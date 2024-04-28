#!/bin/bash
echo "Hello World !"

path_mdlst="./mdlst.log"
path_mdlst_txt="./mdlst.log.txt"

find .  -path "vx_recycle_bin"  -prune -o -name '*.md' > ${path_mdlst}

# 删除行首的./
sed -i 's/^..//' ${path_mdlst}

# 在每行的头添加字符，比如"HEAD"，命令如下：
# sed "s/^/HEAD&/g" ${path_mdlst}
sed -i "s/^/(&/g" ${path_mdlst}

# 在每行的行尾添加字符，比如“TAIL”，命令如下：
# sed "s/$/&TAIL/g" ${path_mdlst}
sed -i "s/$/&)/g" ${path_mdlst}
 


# 复制每行内容
echo -n ""> ${path_mdlst_txt}
# cat ${path_mdlst} | while read line; do echo $line; echo $line$line >> ${path_mdlst_txt}; done
cat ${path_mdlst} | while read line; do echo $line$line >> ${path_mdlst_txt}; done

# 将行首的(替换为[
sed -i 's/^(/[/' ${path_mdlst_txt}

# 将行中的)(替换为](
sed -i 's/)(/](/' ${path_mdlst_txt}


