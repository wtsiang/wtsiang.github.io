# SOC芯片启动流程
1. 上电复位释放后C908自动从ROM中读取bootrom；
2. CPU根据bootrom将Nor-Flash中的BootLoader加载到sram_min中，CPU根据BootLoader程序完成DDR初始化；
3. BootLoader将FW加载到DRAM中；
4. CPU根据FW从Nor-Flash中读取硬件相关配置信息进行初始化；

![](vx_images/246884114258889.png)