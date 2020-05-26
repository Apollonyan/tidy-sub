//
//  main.swift
//  tidy sub
//
//  Created by Liuliet.Lee on 26/5/2020.
//  Copyright © 2020 Apollo nyan~. All rights reserved.
//

import srt
import tidysub
import Foundation
import ArgumentParser

struct Tidy: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "srt 自动清理工具",
        version: "0.0.1"
    )

    @Argument(help: "中文字幕文件路径")
    var cnSub: String

    @Argument(default: nil, help: "输出文件路径，默认覆盖中文字幕")
    var output: String?

    @Argument(default: nil, help: "英文字幕文件路径，默认和中文字幕路径唯一区别是 zh-Hans 替换为 en")
    var enSub: String?

    func run() throws {
        let enSub = self.enSub ?? cnSub.replacingOccurrences(of: "zh-Hans", with: "en")
        let outputPath: String
        if let output = output, output != cnSub && output != enSub {
            outputPath = output
        } else {
            try FileManager.default.copyItem(atPath: cnSub, toPath: cnSub + ".bak")
            outputPath = cnSub
        }
        let enSRT = try SRT(path: enSub)
        let cnSRT = try SRT(path: cnSub)
        try tidy(cnSub: cnSRT, basedOnENSub: enSRT)
            .write(to: outputPath)
    }
}

Tidy.main()
