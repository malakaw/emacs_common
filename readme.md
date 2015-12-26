
## emacs常用配置 

>适用 emacs24.3.X以上版本


### 使用方式 

参考下面的操作步骤
<pre><code>  
cd ~
wget https://github.com/malakaw/emacs_common/archive/master.zip
sudo mv .emacs.d .emacs.d_bbak
sudo unzip master.zip
sudo mv emacs_common-master/ .emacs.d
</code></pre>



### 包含mode 
+ helm
+ multiple-cursors
+ ido
+ desktop



### 其他 ###
应为翻页的C-v和M-v和cua-mode有冲突，所以不是默认调用cua,而且cua的编辑选中C-RET无效，所以最好调用
<pre><code>  
M-x cua-set-rectangle-mark
</code></pre>
 







  
