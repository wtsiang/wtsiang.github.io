# 学习路线

* 阅读SpinalHDL文档
* 实现小项目
* 提高scala水平
* 学习Vexriscv等复杂项目
* SpinalHLD源码

# 常用技巧
* 多使用Bundle将常用的信号打包；
* 使用集合操作，如mapforeachreduce等；
* 使用Stream和Flow，实现握手信号多；
* 使用lib中的模块，提高开发效率；


# 在线教程

  *  [Scala快速入门](https://zhuanlan.zhihu.com/p/467131489)
  *  [SpinalHDL快速入门](https://zhuanlan.zhihu.com/p/467466947)
  

# 基础语法
参考 Verilog 代码格式。
## 创建模块(module)
1. 创建一个没有输入输出的模块：
继承 component 类，这是 Spinal 自带的，用于初始化 module。

``` scala
  class Top extends Component {
    val myBool_1 = Bool       // Create a Bool
    myBool_1 := Flase         // := is the assignment operator
    val myBool_2 = Flase
    val myBool_3 = Bool(5 < 12)  // Use a Scala Boolean to create a Bool
    val myBool_4 = Bool("Spinal" == "Scala")   // Use a Scala Boolean to create a Bool
  }

  showRTL(new Top)
```
2. 创建一个含有输入输出的模块：

``` scala
class Top extends Component {
  val a,b,c   = in Bits(8 bits)      // 输入
  val result  = out (UInt(8 bits))   // 输出，必须驱动
  
  // 内部变量
  val Bits1 = B"8'xFF"
  val Bits2 = B(25, 8 bits)
  val Bits3 = a(6 downto 2)
  
  val myUInt,myUInt1,myUInt2,myUInt3,myUInt4,myUInt5 = UInt(8 bits)
  myUInt   := U(2, 8 bits)
  myUInt1  := U(2)
  myUInt2  := U"0000_0101"
  myUInt3  := U"h1A"
  myUInt4  := U"8'h1A"
  myUInt5  := 2    
  
  result   := 10
}
  
showRTL(new Top)
```

3. 创建一个含有一堆输入输出的模块：


``` scala
// 用 new Bundle
class Top extends Component {
  val io = new Bundle {
    val a,b = in UInt(8 bits)
  }  
  val result = new Bundle {
    val a,b = out UInt(8 bits)
  }
  
  // 输出必须赋值
  result.a := 1
  result.b := io.b
  
  // Bundle 类创建：需要给出子类的名字，例如a、b
  val aaa = new Bundle { val a,b = UInt(8 bits) }
  
}

// 用 Vec
class TopLevel extends Component {
  val io = in Vec(SInt(8 bits),2)
  val result = out Vec(SInt(8 bits),2)
  
  // 必须给out的进行赋值什么的，否则会报错
  result(0) := 1
  result(1) := io(0)

  // Vec 类创建：只需要给出创建的类型和个数，这里是2
  val aaa = Vec(SInt(8 bits),2)

}
showRtl(new Top)
```




