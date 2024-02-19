# Emacs Verilog-mode安装
在emacs的配置文件.emacs中增加如下语句：
![](vx_images/330632611246553.png =873x)

# insert file header
Ctrl+C + Ctrl+t+h
![](vx_images/407042711266719.png)
![](vx_images/37072811259388.png =705x)

# AUTO*
AUTOARG：自动生成信号列表
AUTOREG：自动声明reg变量
AUTOWIRE：自动声明wire变量
Ctrl + c + Ctrl + a auto展开
Ctrl + c + Ctrl + k auto关闭
![](vx_images/57652911255943.png =871x)

## AUTOINPUT/OUPUT
AUTOINPUT:  在底层模块的input（需要使用AUTOINST）在上层模块没有drive的时候就是自动生成input信号
AUTOOUTPUT: 在底层模块的output在上层没有loading的时候会自动在顶层模块output出去
![](vx_images/423892911251697.png =800x)

## AUTO always
Ctrl + c + Ctrl + t + q
![](vx_images/38283111267181.png =500x)

Ctrl + c + Ctrl + t + a
![](vx_images/492043411264683.png)

## AUTOINST
AUTOINST：自动例化，生成sub module的信号例化
![](vx_images/18334411245924.png =800x)

UTOINST例化的模块的位置需要在verilog-library-directories中指明Verilog-auto-inst-param-value : t 表示在信号例化的时候如果submodule的input/output的信号位宽如果是由parameter定义的话，AUTOINST会自动将parameter转化成对应的数值
![](vx_images/213304411268364.png)

verilog-mode 如果有很多个目录，很多文件都要引用，经常写错的话。可以用一个file汇聚起来，在 .v 文件中调用这个file文件就可以全部引用进去,就不需要每个 .v 文件都写一大堆的目录了。
![](vx_images/390234711263500.png =511x)
![](vx_images/534904711257046.png =864x)

## AUTOTEMPLATE
AUTOTEMPLATE: 帮助在例化模块的时候修改信号的连接, 通配符替换。
![](vx_images/508104811250180.png =848x)

@代表regexp
![](vx_images/193854911240710.png =831x)

@后面代表运算
![](vx_images/388664911243214.png =856x)
![](vx_images/531324911252161.png =844x)


# Emacs Lint check
Ctrl + c + Ctrl + s emacs自动调用Lint进行Lint check
![](vx_images/264125011245046.png =822x)

# 常用快捷键
## 刷新文件
C-x C-v


# Reference
* [Verilog-mode-Help](https://www.veripool.org/wiki/verilog-mode/Verilog-mode-Help)
