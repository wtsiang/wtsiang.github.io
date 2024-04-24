	`timescale 1 ns/1 ns
	//明德扬规范
	module  test_seqsum();
	
		//时钟和复位
		reg 		clk		;
		reg 		rst_n	;
	
		//例化模块的输入信号
		reg	[31:0] a;
		reg	[31:0] b;
	
	
		//例化模块的输出信号
		wire [31:0] y;
		// wire			dout0	;
	
	
		//时钟周期，单位ns，可在此修改时钟周期，产生50MHz时钟
		parameter	CYCLE = 20	;
		parameter	TOTAL =	10	,
					PWM_L = 5  	, // 分子为低电平占比
					PWM_H = 5  	; // 分子为高电平占比
		
		//复位时间，此时表示复位3个时钟周期
		parameter	RST_TIME = 3;
		
		//待测试的模块例化
		seqsum u_seqsum (
		.clk	(clk	),
		.rst_n	(rst_n	),
		.a		(a	),
		.b		(b	),
		.y		(y	)
		);	
			
			
		
		//生成本地时钟
		initial begin
			clk = 0;
			forever begin
				#(CYCLE*PWM_L/TOTAL);
				clk=!clk;
				#(CYCLE*PWM_H/TOTAL);
				clk=!clk;
			end
		end
	
		//产生复位信号
		initial begin
			rst_n = 1;
			#2;
			rst_n = 0;
			#(CYCLE*RST_TIME);
			rst_n = 1;
		end
		
		//输入信号赋值
		initial begin
		
			#1;
			//赋初值
			a = 0;
			b = 0;
			#(2*RST_TIME*CYCLE);
			//开始赋值
			a = 1;
			b = 10;
		end
		
		// 控制仿真时间
		initial	begin
			#1600000;	// 自定义仿真时间
			$stop;
		end
		
	endmodule