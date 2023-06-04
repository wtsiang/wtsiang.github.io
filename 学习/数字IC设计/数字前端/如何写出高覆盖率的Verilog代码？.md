# 如何写出高覆盖率的Verilog代码？
【转载】硅农[https://mp.weixin.qq.com/s/\_AOA6rpcS2\_l6\_Gd-yyAVg](https://mp.weixin.qq.com/s/_AOA6rpcS2_l6_Gd-yyAVg)

芯片前端工程中，测试验证的核心理念：以提高覆盖率为核心。

设计工程师需要关心的主要有行覆盖率（Block），条件覆盖率（Expression），翻转覆盖率（Toggle），状态机覆盖率。本文从ASIC设计的角度上来讨论，如何写出高覆盖率的Verilog代码。

**assign慎用**

按位运算逻辑，& ｜ ^  ^~和三目运算符，慎用。

使用这样的描述方式本身功能并没有什么问题，而且写起来很爽，但是在很多情况下覆盖率是真的不好收。

```Verilog
assign mult_a[3:0] = ({4{mult0_vld}} & mult_a0)
                   | ({4{mult1_vld}} & mult_a1)
                   | ({4{mult2_vld}} & mult_a2);

```

用或门和与门实现的一个选择器的功能，前提是vld不能同时有效，相对于下面第二种写法可能会节省一点门。

但是问题我们在收集Expression时需要分析每一个条件是否跑到0/1，上面一共有六个信号，所以0、1随机组合的情况就有2的6次方种，mult\_a0作为数据端，如果没有出现过全0的情况，通过定向case可以覆盖到，但如果是参数作为选择器的输入端，那么参数本身就是有永远不为0的情况，定向case也无法通过。

所以这个时候就只能把它waive（放弃）/exclude（排除）掉，并解释原因。如果只有几条这样的写法还好，如果有成百上千条，那么就需要重复上面的操作上千次。单纯的体力活，没有任何技术含量。但是直接换一种写法。

```Verilog
always @(*)begin
  if(mult0_vld)
    mult_a[3:0] = mult_a0;
  else if(mult1_vld)
    mult_a[3:0] = mult_a1;
  else // if(mult2_vld)
    mult_a[3:0] = mult_a2;
end
```

这样写覆盖率只会检查行覆盖率，基本上哪一行没跑到一目了然，也并不需要多余的体力劳动。代码可读性也很高。第二种可能会消耗更多的逻辑，但是对于整体的系统而言，也是不值一提的。换句话说，扣这一毛两毛的，要抓大头。

**if-else括号中的条件不要太多**

```Verilog
always @(*)begin
  if(data_vld && mode_sel && enable_flag && (data_num[3:0] > 4'd7) && (ram_addr[4:0] > 4'd15) && ...)
end
  else ...
```

当然最开始的时候肯定不是这样的设计，造成如此冗长的逻辑，大概率是后期调试打的补丁，可以把一些条件拿出来专门做一个信号，会让条件覆盖率分析容易很多，不然这么长的选择，真不是给人看的。

**cur\_state不可能同时出现在两个状态上**

在控制上用状态机中，假如有这样的逻辑。

```Verilog
assign enable = ((cur_state != STATE_A) && (next_state == STATE_A))
             || ((cur_state != STATE_B) && (next_state == STATE_B))
```

这样的写法目的是在状态跳转时产生一个脉冲信号，不过在条件覆盖率中会检查这两个选择条件，cur\_state != STATE\_A为0与cur\_state != STATE\_B为0同时满足的情况。

仔细想一下，cur\_state != STATE\_A为0就代表cur\_state现在就是STATE\_A状态，cur\_state != STATE\_B为0就是代表cur\_state现在就是STATE\_B状态，那么，cur\_state怎么可能同时为两个状态呢。

这样的情况要么就拆开写要么就别写。

**case语句的default分支考虑周全**

```Verilog
always @(*)begin
     case(in[1:0])
         2'd0 : data[1:0] = 2'd0;
         2'd1 : data[1:0] = 2'd1;
         2'd2 : data[1:0] = 2'd2;
         default : data[1:0] = 2'd3;
     endcase
 end
```

case语句不写default分支会产生锁存器，如果case中的所有情况都达到，就可以不用写default分支，但在ASIC设计中可能工具会报lint，所以这样的写法是最完美的。

这样的写法对于in这个变量如果有规定取值范围，哪一个值没取到也一目了然。

**教科书式的反面教材**

```Verilog
always @(*)begin
  if（start）
  cnt <= 'd0;
  else if(((para == 3) && (cnt != 3)) 
  || ((para == 4) && (cnt != 7))
  || ((para == 5) && (cnt != 15))
  || ((para == 6) && (cnt != 31)))
  cnt <= cnt + 1'd1;
...
end
```

这样的写法我愿称之为教科书式的反面教材。首先，计数器的常规套路是给一个使能进行计数，记到一个值然后给清零，上面这样的写法是直接给一个使能信号清零，然后用未记到想要的最大值来做使能。

第二点是，这样的写法和上面cur\_state同时出现在两个状态上，是一样的。else if里面的条件进行条件覆盖率检查，会出现cnt != 3 cnt != 7 cnt != 15 cnt != 31 两两之间或者及以上同时为0的随机组合，那么cnt一个时刻只能是一个值，必不可能满足同时等于多个值的情况。

**参数的取值范围**

一个参数的取值范围是0，1，2三个值，你做了一个这样的vld

```Verilog
assign data_vld = (param == 0) || (param == 1) || (param == 2);
```

条件覆盖率检查会出现，上面三个条件都为0的情况，但是这个参数配置只有这三个值，不可能去其他值，也是一个典型的情况。换一种写法。

**最后**

很多的代码写法，工具有smart exclude也会自动waive一些分支，不过工具也没那么smart，还是需要自己在编码的时候注意，尽量避免很多体力活。