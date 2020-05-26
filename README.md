# tidy-sub

srt 自动清理工具

## 安装

0. 确保你已经安装 [Xcode](https://apps.apple.com/app/id497799835)
1. 打开 Terminal
2. 输入以下内容，并按回车键：

```sh
cd ~;git clone https://github.com/Apollonyan/tidy-sub.git
```

## 使用

1. 打开 Terminal
2. 输入以下内容

```sh
cd ~/tidy-sub;swift run tidy
```

3. 确保 `tidy` 后面只有一个空格。（如有需要）按下删除键
4. 将需要处理的字幕文件拖拽到 Terminal 窗口中
5. 按下回车键。你应该能看到如下的输出

```sh
保存备份字幕：...bak
加载英文字幕：...srt
加载中文字幕：...srt
清理中文字幕……
导出处理结果：...srt
完成！
```

6. 根据警告和建议最字幕进行额外的修改
