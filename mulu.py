# -*- coding: utf-8 -*-
import os

# 指定要搜索的目录
root_directory = "D:/WanTsiang/wtsiang_note"
prefix_to_remove = root_directory+"/"
# root_directory = "D:/WanTsiang/wtsiang_note/其他"

# 指定要生成目录的根目录
path_mulu_md   = "D:/WanTsiang/wtsiang_note/_sidebar.md"

# 用python根据文件路径生成markdown 目录
def generate_markdown_toc(root_dir, prefix_to_remove, toc_list=None, level=0):
    if toc_list is None:
        toc_list = []
    
    indent = '  ' * level  # 缩进
    # 去掉不需要列出的目录和文件
    exclude_dir  = [".git","vx_attachments","vx_images","vx_recycle_bin","vx_notebook","生活"]
    exclude_file = ["vx.json",".nojekyll","index.html","log.png","mulu.py","README.md","_coverpage.md","_navbar.md","_sidebar.md"] 

    for filename in os.listdir(root_dir):
        if filename in exclude_dir  or filename in exclude_file :
            continue
        # print(f"filename:{filename}")
        path = os.path.join(root_dir, filename)
        # print(f"path:{path}")
        if os.path.isdir(path):
            # 如果是目录，则递归调用，并增加缩进级别
            toc_list.append(f"{indent}- {filename}\n")
            generate_markdown_toc(path, prefix_to_remove, toc_list, level + 1)
        else:
            # 如果是文件，则添加到列表中
            
            # print(prefix_to_remove)
            path = path.replace(prefix_to_remove,'')
            # print(f"path:{path}")
            toc_list.append(f"{indent}- [{filename}]({path})\n")
    
    return toc_list


# 生成Markdown目录列表
markdown_toc = generate_markdown_toc(root_directory,prefix_to_remove)

# 打印Markdown目录
# print("".join(markdown_toc))
with open(path_mulu_md,'w',encoding='utf-8') as fo:
    fo.write("".join(markdown_toc))