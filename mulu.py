
# -*- coding: utf-8 -*-

import os

print("你好！")

print("====Start gen sidebar.md====")

path_root      = "./"
path_mdlst     = "./mdlst.log"
path_mdlst_txt = "./mdlst.log.txt"

# 列出所以md文件
md_lst = []
for root,dirs,files in os.walk(path_root):
    for file in files:
        if file.endswith(".md"):
            match_file = os.path.join(root,file)
            # print(match_file)
            md_lst.append(match_file)
            

# print (md_lst)
