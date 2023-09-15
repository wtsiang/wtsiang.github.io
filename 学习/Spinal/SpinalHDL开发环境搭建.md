# Windows 系统开发环境搭建

## 开发所需软件

首先Spinal并不能说是一种language，它只是scala 的一个library，所以我们实际上是在用scala进行开发，scala需要用到JVM，所以需要安装**JDK**。然后还需要安装**scala**和**sbt**，我都是用的.msi独立安装的，sbt是用来构建scala工程的。
此外，在win平台开发一个好用的IDE是必要的，IDEA就是这么一个软件，它提供了scala的开发环境，当然仅仅有IDEA是不够的，还需要安装scala插件（在IDEA中装），考虑用VSCode代替。
上面的软件已经足以建立一个scala工程，至于**verilator**和**gtkwave**是为了仿真用的，注意verilator只能对verilog进行仿真。
安装verilator要使用msys2进行安装，同时还有一些其他的package需要安装，gtkwave只是一个波形查看工具，安装也非常简单。

## 软件安装
所有软件安装过程中，把 path 选项都勾选上；

### JDK安装
Scala需要<mark>Java SDK 1.8</mark>(多数人推荐)，从[Oracle官网](https://www.oracle.com/java/technologies/javase/jdk18-archive-downloads.html)下载即可。安装完成环境配置可参考[菜鸟教程-java环境配置](https://www.runoob.com/java/java-environment-setup.html)。

### Scala安装
Scala建议采用<mark>2.11.12</mark>版本（尝试过其他版本，但使用SpinalHDL中遇到各种问题，以学习SpinalHDL为主，不折腾环境），从[Scala官网](https://www.scala-lang.org/download/2.11.12.html)下载。安装完成环境配置可参考[菜鸟教程-Scala环境配置](https://www.runoob.com/scala/scala-install.html)。
  
### Sbt安装
sbt从[sbt官网](https://www.scala-sbt.org/)进行下载。配置使用sbt国内镜像。 在个人用户目录下新建`.sbt`文件夹，在文件夹内创建`repositories`文件，用来配置sbt国内镜像库，默认支持`https`协议，如果是`http`协议需要在仓库链接后加`allowInsecureProtocol`命令即可。
参考：[sbt配置国内源](https://blog.csdn.net/a772304419/article/details/111053781)
``` shell
#添加国内镜像
[repositories]
local
huaweicloud-maven: https://repo.huaweicloud.com/repository/maven/
maven-central: https://repo1.maven.org/maven2/
sbt-plugin-repo: https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases, [organization]/[module]/(scala_[scalaVersion]/)(sbt_[sbtVersion]/)[revision]/[type]s/[artifact](-[classifier]).[ext]
```
### Verilator 和 GTKWave
仿真需要使用 GTKWave+Verilator,安装 MSYS64 软件之后，使用msys2国内镜像。然后打开 msys2 msys 终端输入如下指令： 
   
``` shell
pacman -Syuu
# 更新后关闭软件 重新打开
pacman -Syuu
pacman -S --needed base-devel mingw-w64-x86_64-toolchain git flex mingw-w64-x86_64-cmake
pacman -U http://国内镜像网站/msys2/mingw/x86_64/mingw-w64-x86_64-verilator-4.224-1-any.pkg.tar.zst
所有更新完毕后更新文件均保存在 C:\SpinalHDL\msys64 路径中。
```
   
   ### 系统变量与环境变量检查

系统变量中设置如下：

| 变量名      | 值                                                                                                                                                                                                                                               |
| :--------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| JAVA_HOME  | C:\software\Java\jdk1.8.0_191\                                                                                                                                                                                                                  |
| CLASSPATH  | .;%JAVA_HOME%\lib;                                                                                                                                                                                                                              |
| SBT_HOME   | C:\SpinalHDL\sbt                                                                                                                                                                                                                                |
| SCALA_HOME | C:\SpinalHDL\scala                                                                                                                                                                                                                              |
| MSYS_HOME  | C:\SpinalHDL\msys64                                                                                                                                                                                                                             |
| Path       | C:\Program Files\Common Files\Oracle\Java\javapath;<br>%SBT_HOME%\sbt\bin;<br>%SCALA_HOME%\bin;<br>%MSYS_HOME%\usr\bin;<br>%MSYS_HOME%\mingw64\bin;<br>%JAVA_HOME%\bin;<br>%JAVA_HOME%\jre\bin;<br>%SBT_HOME%\bin;<br>C:\SpinalHDL\gtkwave\bin; |

---

### Intel IDEA安装
IDEA采用Community版即可，从官网下载，step by step。安装完成后需安装Scala插件。莫名其妙的又把环境调通了，用docker容器编译莫名的慢，每次几十秒，还是直接本地编译快，几秒就好，参考如下：
[SpinalHDL——环境搭建](https://mp.weixin.qq.com/s?__biz=Mzg5NjQyMzQwMQ==&mid=2247483663&idx=1&sn=6d25ce6e4b97e3b5418eb08ddf1b7145&chksm=c0000589f7778c9fc3f1ee7324cdfe3b048753ba635f96416aece49a778a3ecb9d3a9998f84e&scene=21#wechat_redirect)


### 仿真环境的坑

运行 SpinalTemplateSbt 的 MyTopLevelSim 用 Iverilog 仿真时，Iverilog 可以正常编译，但编译结束后会报<mark>Error</mark>
![](vx_images/317504815230956.png)
<mark>from SharedMemIface.cpp:1:SharedStruct.hpp:2:9: fatal error: No such file or directory #include<boost/interprocess/managed_shared_memory.hpp> </mark>

折腾一圈认为是电脑缺少 Boost 库的原因，折腾一圈各种尝试，最终发现按照如下方式将 boost 库添加到 MinGw 中则不再报错。

[mingw编译器下boost库的安装](https://www.cnblogs.com/Fight-go/p/15812452.html)

![](vx_images/592125815249382.png)




# 省事流程
自己装软件折腾几遍都有问题，浪费时间，浪费激情；折腾环境太麻烦（<mark>突然又通了，参见**Intel IDEA安装**</mark>），还是直接使用前辈大佬打包的docker镜像吧。
## Docker是什么？
Docker是什么？也还是要学习一下。
[Windows Docker安装教程](https://www.runoob.com/docker/windows-docker-install.html?renqun_youhua=154522)
## 跟着大佬安装配置镜像
简单学习Docker之后再跟着大佬安装配置镜像。
[避免环境折腾，可选Docker](https://mp.weixin.qq.com/s?__biz=Mzg5NjQyMzQwMQ==&mid=2247491294&idx=1&sn=f7bcd2eca182e24518179a22f0d9de48&chksm=c0001a58f777934e9d470aa316f9c15cc42366aeab6a6ec222a392ae48ecf56854e33eeb16fc&scene=21#wechat_redirect)

下面是一些运行相关的配置信息，主要是Bind mounts需要根据实际情况填写：（host 和 container 端的路径均为绝对路径）
D:\WanTsiang\yixin\testcode\scala\SpinalTemplateSbt-master
/myproj/SpinalTemplateSbt

D:\WanTsiang\yixin\testcode\scala\SpinalTemplateSbt-master\coursie
/root/.cache/coursier

![](vx_images/106021217230860.png =800x)

![](vx_images/173061317249286.png =800x)

## Docker 镜像加速

Docker Engine 配置：

``` json
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "features": {
    "buildkit": true
  },
  "registry-mirrors": [
    "https://registry.docker-cn.com",
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn",
    "https://cr.console.aliyun.com",
    "https://mirror.ccs.tencentyun.com"
  ]
}
```