# pre dft upf
* top -innolink的连线有些port mismatch

![](vx_images/333563811258988.png =808x)

![](vx_images/106533911267021.png =853x)

![](vx_images/216813911259690.png =835x)

![](vx_images/347413911256245.png =853x)

![](vx_images/474813911251999.png =805x)
# post dft upf clp_check

floating input缺少设置；
![](vx_images/204624711256240.png =1000x)
类似上面，floating input 缺少配置；
![](vx_images/117423319269874.png =1000x)
下面解决方式：
![](vx_images/516363614246862.png)

Top上的cell没有设置releate power，导致clp自己推断了一个，与实际名称冲突；set_domain_supply_net，
![](vx_images/277144116251994.png =1000x)
下面解决方式：
![](vx_images/284153613258984.png =1000x)

![](vx_images/209800220267478.png =1000x)
<mark>下面解决方式：</mark>
![](vx_images/190211217258990.png =1003x)




缺少 off > on 的iso；跟pst有关；
![](vx_images/129971420264980.png =1000x)





# 0527~0531
##  需要补充一下trng (osc_clk osc_data)x8,  osc_cell_block x3
 ![](vx_images/321380714240569.png =1003x)


## analog 和 digital连接问题
* [x]Efuse Pin  VDD18 VQPS多supply set驱动SS_VDD，SS_VDD_CHIP；这个不管，后面没有efuse了；
* digital port直接练到了 analog port上；就是这么连得，可以找rock确认；
* [x]IO port AY500(1.65)连到了vts analog port(1.62)上；lib的问题，不用管；
![](vx_images/399631914258995.png =1118x)


## 为什么要过pin_mux，两个on之间插了一个off的buffer；
![](vx_images/289672320246221.png =1000x)

## floating input需要设置related local power
有两种，1种只有nvme nfi，另一种包含eda dielink osc等；
![](vx_images/516363614246862.png)


## pll有一些aon tie值经过了iso，又接到了aon的port上
需要看tie的值是否是设计写的，能否直接连接aon tie不插iso；
![](vx_images/496645816267024.png)
![](vx_images/248575814267028.png =1028x)

## floating得 可能需要加noiso
![](vx_images/112152610240570.png =1084x)