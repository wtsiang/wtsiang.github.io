# 第5章：PCIe总线
**PCIe总线结构为树形结构**

**PCIe总线分为三层**

*   事物层
*   数据链路层
*   物理层

***

**事物层**

**产生四种\*\*\*\*TLP（Transaction Layer Packet）**

*   Memory
*   IO
*   Configuration
*   Message

**TLP结构**

|  TLP   | Data Payload  | ECRC |
| ------ | ------------- | ---- |
| Header | -             |      |

**PCIe配置和地址空间**

每个PCIe设备都有这样的一段空间，主机可以读取它获得该设备的一些信息，也可以通过它来对设备进行配置。

**TLP路由**

*   地址路由：存储在Configuration空间
*   ID路由：ID = Bus Number + Device Number + Function Number
*   隐式路由：只有Message TLP才支持

***

**数据链路层**

采用握手协议（Ack\\Nak）和重传（Retry）机制保证数据传输的准确性。

**发送端**：服务于上层，接收TLP并给TLP加上Sequence Number（序列号）和LCRC，然后转交物理层；

**接收端**：接收来自物理层的TLP，校验CRC和序列号，若有问题，则通知发送端重传，否则，通知发送端正确接收。

数据链路层特有数据包：**DLLP（Data Link  Layer Packet）**

源于发送端数据链路层，终于接收端的数据链路层；DLLP的传输仅限于相邻的两个端口。

**DLLP有四种类型：**

*   用以确保TLP传输完整行的DLLP：ACK/NAK
*   用以流控的DLLP
*   用以电源管理的DLLP
*   厂家自定义DLLP

\*\*DLLP包格式：\*\*DLLP大小为6Byte，物理层会为其加上头尾变为8Byte



|     **0**     |             **1**              |     **2**      | **3** | **4** | **5** |
| ------------- | ------------------------------ | -------------- | ----- | ----- | ----- |
| **DLLP Type** | **Fields Vary With DLLP Type** | **16 bit CRC** |       |       |       |

***

**物理层**

由电气模块和逻辑模块组成，串行总线传输数据，使用差分信号，即用两根信号线上的电平差表示0和1。

***

**PCIe Reset**

|  **Conventional Reset**   | **Fundamental Reset** | **Cold Reset 、Warm Reset** |
| ------------------------- | --------------------- | --------------------------- |
| **Non-Fundamental Reset** | **Hot Reset**         |                             |
| **Function Level Reset**  |                       |                             |

\*\*Fundamental Reset：\*\*由硬件控制，会重启整个设备。

\*\*Function Level Reset：\*\*会将对应Function内部状态、寄存器重置。

***

**MPS（Maximum Payload Size）**

PCIe协议允许最大Payload为4KB，整个链路中MPS遵守短板效应。