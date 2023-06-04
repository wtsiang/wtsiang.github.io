# 第7章：SSD测试
**主流SSD测试软件**

**FIO**：基本功能：

*   指的是同时有多少个读或写任务在并行执行，一般来说，CPU里面的一个核心同一时间只能运行一个线程；
*   同步模式：如果发一个读写命令，然后线程一直休眠，等待结果回来才唤醒处理结果；
*   异步模式 ：就是用几微秒发送命令，发完线程不会傻傻地在那里等，而是继续发后面的命令；如果前面的命令执行完了，SSD通知会通过中断或者轮询等方式告诉CPU，由CPU来调用该命令的回调函数来处理结果；
*   Offset 就可以从某个偏移地址开始测试,比如从offset=4G的偏移地址开始；
*   DirectIO：跳过缓存，直接读写SSD；
*   BIO（Block-IO），这是个数据结构，包含了数据块的逻辑地址LBA，数据大小和内存地址等。

\*\*AS SSD Benchmark：\*\*一款来自德国的SSD专用测试软件，可以测试连续读写、4K对齐、4KB随机读写和响应时间的表现，并给出一个综合评分；它有两种模式可选，即MB/s与IOPS。

**ATTO Disk Benchmark**：一款简单易用的磁盘传输速率检测软件，可以用来检测硬盘、U盘、存储卡及其他可移动磁盘的读取及写入速率。该软件使用了不同大小的数据测试包，数据包按512B、1K、2K直到8K进行读写测试，测试完成后数据用柱状图的形式表达出来，体现文件大小比例不同对磁盘速度的影响。

\*\*CrystalDiskMark：\*\*是一个测试硬盘或者存储设备的小巧工具，测试存储设备大小和测试次数都可以选择。测试项目里分为，持续传输率测试（块单位1024KB），随机512KB传输率测试，随机4KB测试，随机4KB QD32（队列深度32）测试。

\*\*PCMark Vantage：\*\*可以衡量各种类型PC的综合性能；测试内容分为三部分：处理器测试、图形测试、硬盘测试。

\*\*IOMeter：\*\*是一个单机或者集群的I/O子系统测量和描述工具。与前面介绍的测试软件相比，IOMeter在测试软件中是属于比较自由的，用户可以按照测试需求去配置测试磁盘数据范围、队列深度、数据模式（可压缩或者不可压缩，有些版本支持，有些老版本不支持）、测试模式（随机或者顺序访问）、读写测试比例、随机和顺序访问比例，以及测试时间等。

***

**验证与确认**

SSD从设计、固件到成品出货，少不了各种测试。中文博大精深，将这些都叫测试，到英文里则会对应N个词：Simulation、Emulation、Verification、Validation、Test、QA。

**芯片设计的过程：**

1.  需求：老大们商量这颗主控要实现什么功能。
2.  架构：Architecture出设计图。
3.  设计：ASIC把各种内部、外部IP攒起来。
4.  TapeOut（流片）。
5.  芯片回来。

在设计阶段，使用Emulator（以后介绍）或者FPGA进行测试的过程，叫Verification，中文翻译为“验证”——目的是为了帮助ASIC把事情做对。

在芯片回来以后，使用开发板进行测试的过程，叫Validation，中文翻译为“确认”——目的是确保ASIC把事情给做对了。

在Verifation阶段，一旦发现问题，ASIC工程师可以马上fix，然后通过升级Emulator的database或者更新FPGA的bit file把新的RTL交给测试再验证一遍，一直到做对为止。

相同的问题，如果是Validation阶段才发现，则只能通过重新TapeOut（含mental fix）或者让固件“打掩护”了。

***

**测试仪器**

在SSD主控芯片设计阶段，除了RTL Simulation以外，通常还会进行Verification的工作，而Verification中就会使用到Emulator或者FPGA。

先说一下Simulation和Emulation的区别：

*   Simulator是做仿真，基于软件，重点是实现芯片的功能并输出结果；
*   Emulator是做模拟，用硬件实现，通过模拟实现芯片的内部设计，从而实现功能并输出结果。

**Emulator**：比较知名的Emulator提供商Cadence旗下的Emulator产品Palladium系列.

**协议分析仪**：SATA/SAS Analyzer和PCIe Analyzer，实现监听通信协议。

SATA/SAS Analyzer的供应商，平时接触比较多的有两家：SerialTek和LeCroy。

PCIe Analyzer的供应商主要有三家：LeCroy、SerialTek和Agilent。

**Jammer**：如果说Analyzer是一个“窃听器”，让你知道主机和设备之间发生了什么，那么Jammer就是一个“邮递员”，主机和设备之间所有的通信都必须经过它的手，然后Jammer可以把信拆开，将里面的内容修改或者替换，再转发出去。

Jammer还有别的用处，当你想知道某种场景（Scenario）发生以后主机或者设备的反应时，可以通过Jammer来知道答案。

***

**回归测试**

*   确保新的代码没有影响原有功能；
*   从现有功能的测试用例中选取部分或者全部出来进行测试。

**DevSlp测试**

试要求主要是关注DevSlp状态的进出是否正常，要实现这个必须具备两点：能让设备进入DevSlp，进去以后能够侦测到DevSlp的状态。

***

**PCIe InterOp**

CPISIG是个大家庭，没事会弄个Compliance Workshop，各公司可以把自己的产品拿去测试。

**测试点包括：**

*   Electrical Testing：电气化测试，重点测试物理层的发送端和接收端。
*   Configuration Testing：PCIe设备配置空间测试。
*   Link Protocol Testing：设备链路层协议相关测试。
*   Transaction Protocol Testing：事务层协议测试。
*   Platform BIOS Testing：平台BIOS测试。

PCISIG光荣榜即Integrators List，网址：[https://pcisig.com/developers/integrators-list](https://pcisig.com/developers/integrators-list)  。

PCISIG贴心地为初入江湖的你提供了方便查看PCIe Register的工具——PCITree：[http://www.pcitree.de/](http://www.pcitree.de/)。

***

**WA测试（写放大测试）**

WA=闪存写入的数据量/主机写入的数据量

闪存写入数据量=平均Wear Leveling count×SSD容量

***

**耐久度测试**

JEDEC有两份SSD Endurance测试的协议，分别是：

*   JESD 218A：测试方法
*   JESD 219：workload

虽然叫耐久度测试，但是218其实是包括了耐久度和数据保持（Data Retention）两部分测试的，官方给的方法有两种：

*   Direct method——直来直去法,简单来说，就是使劲写，可劲读
*   Extrapolation method——拐弯抹角法

Direct method的注意点：

*   要求有高低温；
*   必须用指定的workload；
*   耐久度测试以后马上进行数据保持测试。

Direct method的测试要求：

1.  如果该系列SSD首次进行测试，选取的SSD要来自至少三个不连续的生产批次，如果不是首次，选一个批次的就行。
2.  要求二：制定标准时直接给了两个公式。

*   UCL（functional\_failures）≤ FFR×SS（for Functional Failure）
*   UCL（data\_errors）≤min（TBW，TBR）×8×10 12 ×UBER×SS（forData Failure）

控制温度变化有两种策略：

*   Ramped-Temperature approach：所有SSD放在一起，在高低温间来回切换。
*   Split Flow approach：所有SSD分两半，一半进行低温测试，一半进行高温测试。

SSD耐久度测试Direct Method Ramped Approach流程：

1）Sample取样，确定用多少块SSD测试；

2）耐久度测试；

3）部件级常温数据保持测试（可选）；

4）写入数据，为了后面的数据保持测试；

5）产品级常温数据保持测试（可选）；

6）高温数据保持；

7）数据比较；

8）判断是否通过（检查FFR和Data\_error是否满足前面那两个公式）。

***

**认证Certification**

1.SATA-IO Plugfest和IW（Interoperability Workshop）

IW和Plugfest有所不同：

*   IW的对象是量产产品，由SATA-IO主导，有固定的测试流程和项目，并且测试结果需要提交SATA-IO，通过测试的设备可以加入Integrators List。
*   Plugfest的对象是开发阶段的产品，厂商之间互相玩耍，测什么，怎么测，大家自己说了算，测试结果不用提交给SATA-IO。

2.PCIe SIG Compliance Program

3.UNH IOL NVMe Test

***

**SSD Performance测试**

*   FOB：Fresh Out of Box，指的是刚开封、全新的盘，此时SSD的性能类似于悟饭同学的愤怒形态，战斗力爆表但不持久，这并不是这块盘在未来正常使用过程中的真实能力。
*   Transition：经过一段时间的读写，战斗力逐步降低，趋向于稳定状态，这个过程称为转换状态。
*   Steady State：战斗力数值稳定在一个区间，Performance相关的数据，例如Throughput（吞吐量）、IOPS、Latency（延迟）都必须在Steady State下获取，据此判断其到底是超级赛亚人，还是战五渣。

Steady State（稳定态）的判断原则是：这段时间内性能波动不超过±10%。

1）Purge（擦除）：每次进行Performance测试前都必须进行Purge动作，目的是消除测试前的其他操作（读写及其他测试）带来的影响（比如，一段小BS的随机读写之后立即进行大BS的顺序读写，这时候大BS的数据会比较差），从而保证每次测试时盘都是从一个已知的、相同的状态下开始。

2）Precondition：通过对盘进行IO使其逐步进入Steady State的过程，分两步进行。

*   Workload Independent Preconditioning（WIPC）：第一步，读写时不使用测试的Workload。
*   Workload Dependent Preconditioning（WDPC）：第二步，读写时使用测试的Workload。

3）Active Range：测试过程中对盘上LBA发送IO命令的范围

4）Data pattern：Performance测试必须使用随机数据（向闪存中写入的数据）。

**基本测试流程：**

1）Purge the device：擦除SSD。

2）Run Workload Independent Precondition：比如用128K的BS顺序把盘写两遍。

3）Run Test（包括Workload Dependent Precondition）：设置好相关参数（OIO/Thread、Thread count、Data Pattern等）后开始进行Workload Dependent Precondition，最多跑25个round。

4）假设在25个round以内达到了Steady Status，例如第x次。那么：

*   Round 1：x称为Steady Status收敛区间；
*   Round（x-4）：4称为测量区间（Measure Window）。

5）如果25个round还没有达到Steady Status，可以选择：

*   继续步骤3直到达到Steady Status并记录x；
*   直接取x=25。