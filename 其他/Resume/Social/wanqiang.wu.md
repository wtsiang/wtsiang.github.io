# 吴万强

> 电话：`15038294486`       邮箱：`wanqiangwu@qq.com`      出生年月：`1995.07`        现居城市：`成都`
>
> 

<img src=".\1.jpg" alt="avatar">

## 专业技能

- 熟练使用Verilog HDL进行RTL开发
- 熟悉SystemVerilog、C编程
- 熟练使用VCS、Verdi、Spyglass等EDA工具
- 熟练使用DC、Formal等工具进行PPA分析和一致性检查
- 熟练使用CLP Check、PTPx、PowerPro等工具进行UPF检查和功耗分析
- 熟练使用Python\Shell编写脚本

## 工作经验

### 成都忆芯科技有限公司，数字电路设计高级工程师							     					 2021年7月至今

- 根据需求设计模块整体框架，完成模块级LLD设计文档
- 根据LLD实现高质量的RTL，并进行Lint、CDC、DC时序分析等代码质量检查
- 负责两个子系统Harden Block的集成，及SDC、UPF撰写
- 完成Harden Block SDC Check、UPF CLP Check、Netlist Formal 一致性检查
- 完成芯片所有模块的Power统计
- 完成Memory自动生成系统开发、测试

## 项目经历

## 12nm PCIe Gen4 SSD主控芯片     									    2021年7月至2022年5月

- ### AXI_Lite2APB_bridge设计

**模块功能**：该模块实现AXI_Lite协议转换为APB协议。

**负责内容**：从学习AXI_Lite及APB协议开始，了解每个协议的接口时序，构思两种接口协议对接数据传输桥接方案，绘制AXI_Lite2APB Bridge 模块框图，之后根据设计框图撰写模块文档，并实现RTL设计。

- ### Security算法模块学习、维护与Freeze收尾工作

**模块功能**：国密SM2\SM3\SM4，商密RSA\SHA256\AES256硬件加速模块。

**负责内容**：进入项目组时以上模块功能稳定，没有新的开发需求，主要负责学习模块SPEC及RTL，补充完善SPEC，以及最后各个模块覆盖率检查。

## 8nm PCIE Gen5 SSD主控芯片MPW 				    			         2022年5月至2023年11月

- ### Security算法模块性能提升及国密二级修改，提升芯片安全性

**模块功能**：前代芯片按照国密一级安全要求进行设计，而此代芯片需要进行安全性升级，以满足国密二级安全要求，国密二级相对于国密一级主要是在抵御侧信道攻击方面要求的提升；另外芯片要支持PCIe Gen5实时数据加解密的性能，因此对于模块性能也需要进行翻倍提升。

**负责内容**：**SM2国密二级修改**：梳理SM2防御侧信道攻击的方法，采用了隐藏标量乘功耗轨迹图以及随机化功耗信息的方式，最终实现了满足国密二级的安全性提升。**SM4国密二级修改及性能提升**：梳理SM4防御侧信道攻击的方法，采取了算法级掩码方案，实现了满足国密二级的安全性提升，该防护方案形成了一项专利。在性能提升方面，针对算法分组大小及加解密模式限制，采用了双加解密核心架构、拼流水、Buffer缓存的方式将加解密性能从7GB\s提升至14GB\s，该性能提升方案形成了两项专利。**HASH模块独立及性能提升**：重新设计该模块，模块对接自研消息总线收发CMD及CPL，对接AXI总线，作为Master进行数据读取；针对性能做了提升，增加少量Buffer，提前缓存分组数据，

---

减少数据输入延时，使其性能从400MB\s提升至1GB\s。用少量分支结构实现了多种HASH算法的支持，将原来只支持2种摘要算法，提高到支持8种摘要算法。

- ### 两个Harden Block集成与交付

将两个Harden Block的RTL进行集成，使用Spyglass对Block进行Lint检查、CDC检查，撰写SDC及UPF，对Block进行DC综合，评估Block的面积大小及时序情况；使用PowerPro对模块进行CG率检查，并根据报告修改设计，保证负责模块的CG在90%以上；在整个项目的各个阶段完成UPF 的 CLP Check以及FM Check。

- ### 芯片各模块Power统计

收集各个Harden Block在IDLE、读、写等场景下的波形，对波形进行处理，截取成每个场景下的特定波形，不包含其他场景的波形，并将处理好的波形转换成SAIF类型的波形文件；配合后端提供的各个Harden Block的PT Session，使用PTPx工具对各个Harden Block的各个工作场景进行平均功耗分析，并将各个场景的数据汇总成Excel表格。

## 8nm PCIE Gen5 SSD主控芯片Full Mask     									 2023年11月至今 

- ### 两个Harden Block集成与交付

- ### Memory生成及生成、测试Flow升级修改

**模块功能**：设计采用了通用的Memory模块，为使用者提供了统一的接口，在内部实现SP、TP、TPS等各种Memory的连接；由于Memory修改频繁，有很多工作可以进行系统化的脚步生成，我们开发了Memory自动生成系统；在Memory生成之后对所有的Memory进行本地测试，测试通过后Release给到需求方使用。

**负责内容**：**Memory生成**：基于现有Memory TCL生成脚本进行修改以避免除了深度、宽度以外更细致的需求导致的无法进行区分的问题，主要在命名规则上进行更新。**Memory自动生成系统**：参与设计、开发了Memory自动生成系统，该系统会根据用户输入Memory需求，自动生成PPA最优的Memory；我主要负责Memory自动拆分方案设计、实现，以及Memory自动生成系统集成、测试及验证。**Memory本地测试方案增强**：之前的Memory测试方案较为简单，仅将地址作为数据依次写入对应地址中；我将测试方案进一步完善，实现了Memory每个bit位全随机覆盖、Bit Enable全随机覆盖、ECC随机注错，使得交付的Memory有了更高的质量。

## 专利

SM4-XTS性能提升

AES-XTS性能提升

SM4侧信道防护

## 教育背景

### 西南民族大学 - 研究生 - 电子与通信工程   (2018.09 - 2021.07)

### 郑州工业应用技术学院 - 本科 - 通信工程   (2014.09 - 2018.07)

## 在校期间科研成果

[1] 吴万强, 彭良福, 甘桂, 王逸凡. 基于SOPC的实验室负荷智能监测装置[J]. 实验室研究与探索, 2020,39(6):78-82,107．

[2] Wanqiang Wu, Liangfu Peng, Gui Gan. Oven Controlled Crystal Oscillator Control Based on BP Neural Network Tuning PID[J]. Frontiers in Signal Processing, 2020, 4(1):22-29.

[3] 甘桂, 彭良福, 吴万强. 基于GPS驯服晶振的高精度频差测量[J]. 电子世界, 2019(14): 82-83.

## 自我评价

学习能力强，对新事物保有好奇心，能快速适应新环境；良好的沟通和团队合作能力；能与他人合作，共同完成目标；遇到困难总是相信有办法解决。
