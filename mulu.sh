#!/bin/bash
echo "Hello World !"

find . -name '*.md' > mdlst.log

# 删除行首的./
sed -i 's/^..//' mdlst.log

# 在每行的头添加字符，比如"HEAD"，命令如下：
# sed "s/^/HEAD&/g" mdlst.log
sed -i "s/^/(&/g" mdlst.log

# 在每行的行尾添加字符，比如“TAIL”，命令如下：
# sed "s/$/&TAIL/g" mdlst.log
sed -i "s/$/&)/g" mdlst.log
 


# 复制每行内容
echo -n ""> mdlst.log.txt
# cat mdlst.log | while read line; do echo $line; echo $line$line >> mdlst.log.txt; done
cat mdlst.log | while read line; do echo $line$line >> mdlst.log.txt; done

# 将行首的(替换为[
sed -i 's/^(/[/' mdlst.log.txt

# 将行中的)(替换为](
sed -i 's/)(/](/' mdlst.log.txt


