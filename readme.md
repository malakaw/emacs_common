
## emacs常用配置 ##

>适用 emacs24.3.X以上版本


### 使用方式  ###

参考下面的操作步骤
<pre><code>  
cd ~
wget https://github.com/malakaw/emacs_common/archive/master.zip
sudo mv .emacs.d .emacs.d_bbak
sudo unzip master.zip
sudo mv emacs_common-master/ .emacs.d
</code></pre>



### 包含mode ###
+ helm
+ multiple-cursors
+ ido
+ desktop




### mode说明 ###

#### ido #### 
这个是我找了好久的mode,原先是使用别人的配置，就是有这个功能，但就是不知道他叫啥。
在emacs中打开和新建文件使用的是一个命令M-x find-file(即C-x C-f)，如果文件不存在就创建一个新文件。默认的提示输入文件名的方式类似shell中的补全。事实上，这个补全方式不是太好，起码是不直观的。Emacs提供一个很好的补全方式──ido-mode。






  
