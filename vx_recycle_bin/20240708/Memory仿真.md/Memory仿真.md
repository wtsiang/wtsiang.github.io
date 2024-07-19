# Memory仿真

## 仿真报warning的Memory：
![](vx_images/572073413231142.png)

![](vx_images/496702814257601.png)


DI要求留120ps余量
![](vx_images/367621115257887.png)



讲深度在15-30um之间的时候说到一个log ？

check_mem、find_file用不到了；


![](vx_images/439085115255389.png)


将每个block用到mem list出来，
![](vx_images/455195215236630.png)


# 问题
ecc 和  necc 对比
repair 和 non_repair 对比

\cp 的问题？
模板中的`define是不是没必要？只需要字符串匹配就行？
C_ECC_WIDTH的： 后面为什么不需要乘C_WIDTH_SPLIT_NUM？

![](vx_images/572965017249478.png)


width2才有拆分，width1没有拆分

这个小于是什么意思，感觉和上面的一样。
![](vx_images/239020420237345.png)