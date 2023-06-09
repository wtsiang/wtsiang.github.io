# Tcl
# 正则表达式匹配命令regexp
TCL支持三类正则表达式，分别称为基本正则表达式(BRE)、扩展正则表达式(ERE)和高级正则表达式( ARE). BRE和ERE主要是在过去的版本中使用。ERE由POSIX定义，而ARE受到了Perl的一点启发。从Tcl8.1开始，所有的TCL命令都默认支持ARE语法。

TCL使用命令regexp进行字符串和正则表达式的匹配。其格式为：
```tcl
regexp ?switches? exp string ?matchVar??subMatchVar subMatchVar ...?
```

返回1则表示字符串和正则表达式匹配，返回0则表示不匹配。它最简单的形式要获取两个参数: 正则表达式模式 和 输入字符串。例如：
```tcl
regexp {^\[0-9\]+$} 510
→1
regexp {^\[0-9\]+$} -510
→0
```
这里的模式被括在大括号中，使得字符$、\[0-9\]被传给命令regexp，而不会触发变量替换和命令替换。建议总是把正则表达式括在大括号中。

如果regexp在输入字符串后还调用更多的参数，每一个参数都被作为一个变量名对待。
第一个变量会存入与**整个**正则表达式匹配的子字符串；
第二个变量会存入与捕获到的**第一个子表达式**相匹配的子字符串；
第三个变量会存入与捕获到的**下一个子表达式**相匹配的子字符串； 以此类推。
如果变量名的数量比捕获到的子表达式数量更多，多余的变量会被设置为空字符串。例如，执行如下命令后变量a的值为10km，b的值为10，c的值为km。
```tcl
regexp {(\[0-9\]+) \*(\[a-z\]+)} "Walk 10km" a b c
```

这种取得部分配对的子字符串的能力使regexp可以用于解析工作。还可以在正则表达式前为regexp指定更多的选项。可以使用：
- start选项， 在后面跟一个字符串中的字符索引， 指定regexp从该位置开始查找匹配；
- all选项，告诉regexp在字符串中查找尽量多次的匹配， 并返回总的匹配次数；
- nocase选项，指定了模式中的字母在字符串中查找匹配时不区分大小写；
- indices选项，指明额外的变量不应该用于存放匹配的子字符串的值， 而是存放给出子字符串范围的首字符和尾字符的索引列表；
例如，执行下面这个命令后，变量a的值为59，b的值为56，c的值为89。
```tcl
regexp -indices {(\[0-9\]+) \*(\[a-z\]+)} "Walk10 km" a b c
```

- inline选项让regexp把匹配变量返回为一个数据列表。
例如，下面这条命令返回了含有三个元素的列表，第一个元素是与整个表达式匹配的字符，后面两个元素是与捕获到的子表达式匹配的字符。
``` tcl
regexp -inline {(\[0-9\]+) \*(\[a-z\]+)} "Walk 10 km"
→{10 km} 10 km
```
- line选项激活区分换行的匹配。指定这个选项后\[^括号表达式和.绝不会与新行匹配，^原子除了它的普通功能外，与新行后的空字符串匹配，$原子除了它的普通功能外，与新行前的空字符串匹配。
例如，下面这条命令返回了所有以ERROR字符串开头(这个字符串前面可能有空白)的行数。
```tcl
regexp -all -line -- {^\[\[:blank:\]\] \*ERROR:}$text
```
regexp命令也支持用--选项明确地标志选项结束。在实际工作中建议总是使用--选项；否则如果您的模式以-字符开头，它可能被错误地解析为另一个选项。










