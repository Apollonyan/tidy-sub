# tidy-sub

srt 自动清理工具

## 安装

0. 确保你已经安装 [Xcode](https://apps.apple.com/app/id497799835)
1. 打开 Terminal
2. 输入以下内容，并按回车键：

```sh
cd ~;git clone https://github.com/Apollonyan/tidy-sub.git
```

或者直接点击右上角绿色的 `Clone and download` 按钮，然后点 `Download ZIP`，下载完成后解压到你希望的地方。

## 使用

1. 打开 Terminal
2. 切换到项目根目录

```sh
cd ~/tidy-sub
```

如果你是直接下载解压的话需要 cd 到你解压出来的文件夹内。

3. 输入如下命令（注意不要回车）

```sh
swift run tidy 
```

确保 `tidy` 后面只有一个空格。（如有需要）按下删除键去除多余的换行/空格

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

如果是第一次运行会进行自动安装，请耐心等待。

如果出现网络错误可以再执行一次同样的命令，多次出错可以尝试挂网络代理。

6. 根据警告和建议对字幕进行额外的修改
7. 如果有错误的处理，可以从备份字幕文件中恢复

## 错误解决方案（来自 @YucongDing）

Catalina下遇到如下错误

```
error: terminated(72): xcrun --sdk macosx --find xctest output:
    xcrun: error: unable to find utility "xctest", not a developer tool or in PATH
```

修正方法为

`sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`