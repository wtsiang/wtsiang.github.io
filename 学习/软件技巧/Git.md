# 1、本地删除/修改了文件，且与远程同步
``` shell
git status # 非必须
git commit -am '提交注释'
git push origin master
```
# 2、新增文件，且与远程同步
``` shell
git add 文件名
git commit -m '提交注释'
git push origin master
```
# 3、从远程拉取文件
``` shell
git pull origin master
```

# 4、一些命令解释
``` shell
git status 			          # 检查工作区状态
git add 文件名			        # 将文件提交到暂存区
git commit -m ' '		      # 将暂存区文件提交到仓库（单引号内为注释）
git diff 文件名			      # 查看文件修改的内容
git log				            # 获得历史修改记录
git log --pretty=oneline	# 使记录只显示主要的内容，一行显示
git reset --hard HEAD^		# 回退到上一个版本
git reflog			          # 获取历史版本号
git reset --hard 版本号		# 回退到该版本号对应的版本
# 是将你本地的仓库和github仓库进行关联
git remote add origin https://github.com/zwg481026/APITest.git 
# 第一次推送master分支时，加上了 –u参数，Git会将本地的master分支内容推送的远程新的master分支，还会把2个master分支关联起来，在以后的推送或者拉取时就可以简化操作。
git push -u origin master

git ls-files			            # 查看暂存区文件
git remote -v			            # 查看远程地址，会显示连接方式
git remote rm origin	        # 移除远程地址或连接方式
git remote add origin git地址	# 添加远程地址或连接方式
#只需要在命令行后面加--depth=1，就会只clone最后一次commit的内容
git clone https://github.com/Wuchenwcf/MyCode.git --depth==1
# git pull或者git push报fatal: refusing to merge unrelated histories 同理：
git pull origin master --allow-unrelated-histories

git log --graph               # 以“图形”方式查看
# git log 信息会变得非常简洁，默认只展示简短的 commit id 和提交注释
git log --oneline              
git log --format="xxx"        # 格式化打印log信息,
git log --pretty=oneline      # 实际等价于 git log --oneline;
git log --pretty=format:"xxx" # 实际可以使用 git log --format 代替;
# --format="xxx" 可选格式如下：
[format格式详细参数](https://blog.csdn.net/weixin_39021823/article/details/115481842)
%H 提交对象 (commit) 的完整哈希字串
%h 提交对象的简短哈希字串
%T 树对象 (tree) 的完整哈希字串
%t 树对象的简短哈希字串
%P 父对象 (parent) 的完整哈希字串
%p 父对象的简短哈希字串
%s 提交说明
%an 作者 (author) 的名字
%ae 作者的电子邮件地址
%ad 作者修订日期 (可以用-date= 选项定制格式)
%ar 作者修订日期，按多久以前的方式显示
%cn 提交者(committer)的名字
%ce 提交者的电子邮件地址
%cd 提交日期
%cr 提交日期，按多久以前的方式显示
```

# 5、ssh测试
`ssh -T  git@e.coding.net`
coding ssh无法访问解决方法，在安装目录*\Git\etc\ssh\ssh_config 添加一下内容：
``` shell
# Added by git-extra
Host *.coding.net
            HostkeyAlgorithms +ssh-rsa
            PubkeyAcceptedAlgorithms +ssh-rsa
```
		
# 6、Git删除所有历史提交记录，保持干净
``` shell
# 1.Checkout
   git checkout --orphan latest_branch
# 2. Add all the files
   git add -A
# 3. Commit the changes
   git commit -am "commit message"
# 4. Delete the branch
   git branch -D master
# 5.Rename the current branch to master
   git branch -m master
# 6.Finally, force update your repository
   git push -f origin master
```