###############################################################################
# Linux build
# User : EExuke
# Email : EExuke@qq.com
###############################################################################
一：配置
	1. 下载 mylinuxbuild 文件夹后，放入用户家目录下;

	2. 运行在mylinuxbuild中的 build 自动建立以下软链接：

		.bashrc -> /home/user/mylinuxbuild/.bashrc
		bin -> /home/user/mylinuxbuild/bin/
		.gitconfig -> /home/xuke/mylinuxbuild/.gitconfig
		.gitmessage -> /home/xuke/mylinuxbuild/.gitmessage
		.profile -> /home/xuke/mylinuxbuild/.profile
		.ssh -> /home/xuke/mylinuxbuild/.ssh/
		.vim -> /home/xuke/mylinuxbuild/.vim/
		.vimrc -> /home/xuke/mylinuxbuild/.vimrc
	
	3. 建一个workspace用于工作项目;

	4. 在各自代码项目总目录下运行
		[ Sync -b ] 或者 [ ctags -R * ]  生成 tags 文件，使得函数跳转可用 。

二：相关插件软件
	1. GNU
	2. cscope
	3. ctags
	4. vim-gui-common ： 剪切板共享

三：文件功能说明
	1. .vimrc :
		配置vim编辑环境与快捷键操作；
	2. .vim :
		管理vim中用到的相关插件；
	3. .ssh :
		公钥文件 ;
	4. .bashrc :
		路径相关 ;
	5. build : 
		执行自动生成软链接 ;
	6. mylinuxenv :
		存以上相关隐藏文件 ;
	7. backup ：
		备份文件夹 ;


