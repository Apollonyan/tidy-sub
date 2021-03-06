//
//  main.swift
//  tidy sub
//
//  Created by Liuliet.Lee on 26/5/2020.
//  Copyright © 2020 Apollo nyan~. MIT License.
//

import srt
import tidysub
import Rainbow
import Foundation
import ArgumentParser

struct Tidy: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "srt 自动清理工具",
        version: "0.0.2"
    )

    @Argument(help: "中文字幕文件路径")
    var cnSub: String

    @Argument(default: nil, help: "输出文件路径，默认覆盖中文字幕")
    var output: String?

    @Argument(default: nil, help: "英文字幕文件路径，默认和中文字幕路径唯一区别是 zh-Hans 替换为 en")
    var enSub: String?

    @Flag(name: .shortAndLong, help: "是否将字幕合并到一起")
    var merge: Bool

    func run() throws {
        let enSub = self.enSub ?? cnSub.replacingOccurrences(of: "zh-Hans", with: "en")
        let outputPath: String
        if let output = output, output != cnSub && output != enSub {
            outputPath = output
        } else {
            let backupPath = cnSub + ".bak"
            if FileManager.default.fileExists(atPath: backupPath) {
                print("删除备份文件：".bold.red + backupPath)
                try FileManager.default.removeItem(atPath: backupPath)
            }
            
            print("保存备份字幕：".bold.yellow + backupPath)
            try FileManager.default.copyItem(atPath: cnSub, toPath: backupPath)
            outputPath = cnSub
        }
        print("加载英文字幕：".bold.blue + enSub)
        let enSRT = try SRT(path: enSub)
        print("加载中文字幕：".bold.blue + cnSub)
        let cnSRT = try SRT(path: cnSub)
        print("清理中文字幕……".bold.blue)
        let processed = tidy(cnSub: cnSRT, basedOnENSub: enSRT) {
            (index, contents) in
            if contents.count > 2 {
                print("警告：".bold.red + """
                    第 \(String(format: "%-4d ", index))\
                    条超过了 2 行字幕限制
                    """)
            }
            let contents = contents.map(format)
            for (row, content) in contents.enumerated() {
                switch content.displayWidth {
                case ..<40:
                    break
                case ..<46:
                    print("提示：".bold.yellow + """
                        第 \(String(format: "%-4d", index)) \
                        条 \(row + 1) 行偏长：\(content)
                        """)
                default:
                    print("警告：".bold.red + """
                        第 \(String(format: "%-4d", index)) \
                        条 \(row + 1) 行过长：\(content)
                        """)
                }
            }
            return contents
        }
        print("导出处理结果：".bold.blue + outputPath)
        if merge {
            try tidysub.merge(processed, with: enSRT).write(to: outputPath)
        } else {
            try processed.write(to: outputPath)
        }
        print("完成！".bold.green)
    }
}

Tidy.main()
