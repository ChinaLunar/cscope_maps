""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" 该文件包含Vim对cscope接口的设置模版，添加了一些笔者认为有用的键盘映射。
"
" USAGE: 
" -- vim 6:     将本文件复制到“~/.vim/plugin”目录下（或者是“runtimepath”
"  		中其他目录中的“plugin”目录）
"
" -- vim 5:     将该文件复制到某处，并在“~/.vimrc”文件写入命令
"  		“source cscope.vim”(或者将该文件复制到.vimrc中)
"
" NOTE: 
" 这些映射键由两到三个键组成。如果用户觉得以下按键所需时间过长，请根据以下
" 说明自行修改。
"
" 祝您愉快
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 该if用于测试Vim编译时是否配置了“--enable-cscope”操作。否则，请重新编译
if has("cscope")

    """"""""""""" 标准cscope/vim配置模板

    " “ctrl-]”，“:ta”和“vim -t”都可用于cscope和ctag
    set cscopetag

    " 检查ctags前，检查cscope是否定义该符号：如果用户希望反向检索就设置为1
    set csto=0

    " 添加将当前目录下可读的cscope数据库
    if filereadable("cscope.out")
        cs add cscope.out  
    " 否则将环境变量所指定的数据库添加到cscope
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " 当添加了其他cscope数据库时显示信息
    set cscopeverbose  


    """"""""""""" 笔者的cscope/vim键盘映射
    "
    " 以下映射分别对应cscope检索类型的一种：
    "
    " 	's'   symbol：查找光标所指符号的所有引用
    "   'g'   global：查找光标所指符号的全局定义
    "   'c'   calls：查找光标所指函数名的所有调用
    "   't'   text：查找光标所指文本的所有实例
    "   'e'   egrep：用egrep命令检索光标所指单词
    "   'f'   file：打开光标所指文件名对应的文件
    "   'i'   includes：查找包含光标所指文件名的文件
    "   'd'   called：查找光标所指函数所调用的函数
    "
    " 以下三个映射集合：第一个集合直接跳转到检索结果处，第二个是将当前Vim
    " 窗口横向分割并将检索结果显示在新窗口中；第三个则是将窗口竖向分割（仅Vim
    " 6）。
    "
    " 笔者使用CTRL-\和CTRL-@作为这些映射的起始关键字，用户可能不会使用他们的默
    " 认映射（CTRL-\的默认用法是CTRL-\、CTRL-N typemap的一部分，其功能和esc键
    " 一致：CTRL-@ 好像没有默认用法）。如果用户不喜欢使用CTRL-\或CTRL-@，可以
    " 修改部分或全部映射为其他按键，备用键可以选CTRL-_（这个键也映射到
    " “CTRL-/”，也更容易输入），这个按键默认用于切换希伯来语键盘和英语键盘
    " 模式。
    " 
    " 所有映射都调用<cfile>宏（且该宏使用了“^<cfile>$”命令）：因此通过
    " “#include <time.h>”仅返回“time.h”的引用，而不是“sys/time.h”等
    " （默认情况下cscope将返回所有文件名中含有“time.h”的文件的引用）。


    " 第一种类型检索，先输入“CTRL-\”，然后输入以上的一种cscope检索类型。
    " cscope的检索结果会在当前窗口显示。用户可以使用CTRL-T让光标返回检索前
    " 所在的位置。

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " 使用“CTRL-空格”（被Vim解释为CTRL-@），然后跟上检索类型，可以横向分割
    " Vim窗口，并将检索结果显示在新窗口。
    "
    "注意：较早版本Vim可能没有“:csc”命令，但可使用如下命令粗略模仿该命令
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	

    " 在检索类型前两次按下CTRL-space可以可以纵向分割而不是横向分割窗口
    " （仅Vim 6及更高版本）
    "
    " 注意：如果用户更希望新窗口出现在右边而不是左边，可以再.vimrc文件
    " 中设置“set splitright”

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" 按键映射超时（timeout—1秒钟后键位映射超时）
    " 
    " Vim默认情况下对每个按键映射仅需要使用1秒。用户可能会发现1秒对于以上映射
    " 过短。如果是这样，用户应该通过如下命令关闭映射超时。
    " 译者注：这个timeout的意思是指用户必须在timeout所指定的时间内，将所要使
    " 的快捷键按下，否则，Vim就会将用户在超时之后按下的按键当做是另外的快捷键
    " 来进行处理，也就是说Vim不会无限时的等待用户输入快捷键。
    "
    "set notimeout 
    "
    " 或者，可以保持映射超时设置，取消以下这行命令的注释，并给timeoutlen设
    " 置喜欢的数值（以毫秒为单位）：
    "
    "set timeoutlen=4000
    "
    " 无论哪种方法，由于映射超时设置默认情况下被设置为多字符的“按键代码”会发
    " 生超时（例如<F1>），用户也应该设置ttimeout和ttimeoutlen：否则，Vim会有很
    " 长时间的延时，就如同用户按下了ESC键之后Vim等待用户输入命令一样（如果ESC
    " 像<F1>一样是按键代码一部分，Vim会等待输入）。
    "
    "set ttimeout 
    "
    " 笔者自己发现按键代码超时设置为十分之一秒就可良好运行。如果用户发现终端或
    " 者网络速度慢的问题，可以设置更大的值。如果用户不设置ttimeoutlen，Vim就会
    " 使用timeoutlen的值（默认：1000=1秒，导致反应缓慢）。
    "
    "set ttimeoutlen=100

endif
