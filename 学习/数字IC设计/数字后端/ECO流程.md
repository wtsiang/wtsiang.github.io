# 流片前ECO
后端一般分为4个阶段：85%、95%、100%、signoff，其中，signoff，是指各方面验证都满足要求后，可以把做好的设计送给foundry去tapeout。一般来说，后端布局布线完成后（或进行到一定程度，每个公司不一样），RTL代码会进入freeze阶段，在这个阶段，后端工程师会进行DFT、时钟树插入、修正时序。

代码freeze后，RTL代码不能再进行修改，否则重新生成的网表会让之前的工作全部被推倒重来。如果在这个时候项目遇到临时的需求变更，就需要直接对已生成网表文件直接修改，只对一些门/cell做增删，几乎不影响现有的后端工作，这个步骤叫做工程变更指令（Engineering Change Order, ECO），此种情况是流片前的ECO，又称为 Pre-mask ECO，该阶段一般放在100%到signoff之间。

# 流片后ECO
芯片流片之后，需要进行严格的功能测试来保证芯片运行的正确性。如果芯片通过测试查出致命问题，就需要对设计进行少量修复来弥补缺陷，这就是流片后的 ECO, 又称为Post-mask ECO。

由于流片制版费用昂贵，不可能重新进行一次全新的流片，所以在布局布线的过程中会事先插入少量的冗余单元 (Spare cell)， 流片后ECO不需要进行重新布局，即在不改变晶体管制版信息的前提下利用这些Spare cell, 通过改变少量金属层的方法来实现网表逻辑功能的少量改动，达到满足功能要求的目的。

流片前ECO和流片后ECO的区别就是流片前ECO阶段在物理上能够改变所有版图层，而考虑到成本问题，流片后ECO只改变少量金属层。
需要注意的是： ECO修改组合逻辑比较容易，但如果动到寄存器的话，需要格外小心，因为它有可能影响到Clock Tree, 进而造成大量的时序违例。

# ECO基本步骤
1. 分析需求变更；
2. 备份原有的RTL代码，根据变更后的需求修改出新的设计方案和RTL代码，并对验证的方案和testbench代码做相应修改；
3. 分析原有的网表，看看哪部分cell需要修改，以及怎样修改；
4. 编写tcl脚本，修改原有网表；
5. 编写tcl脚本进行形式验证，验证修改后的网表和新的RTL代码是否一致，设置参考侧为新的RTL代码，实现侧为修改后的网表。


# 参考文献
[芯片设计ECO](https://blog.csdn.net/qq_38246278/article/details/126369246)