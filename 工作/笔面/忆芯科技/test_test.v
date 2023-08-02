`timescale 1 ns/1 ns
//明德扬规范
module  test_test();

	//时钟和复位
	reg 		clk		;
	reg 		rst_n	;

	//例化模块的输入信号	
	reg 		ren		;	
	reg 		wen		;	
	reg [3:0] 	addr	;	
	reg [7:0] 	wdata	;
	
	//例化模块的输出信号
	wire [7:0] 	data_out;

	//时钟周期，单位ns，可在此修改时钟周期，产生50MHz时钟
	parameter	CYCLE = 20;
	
	//复位时间，此时表示复位3个时钟周期
	parameter	RST_TIME = 3;
	
	//待测试的模块例化
	test u_test(
		.clk		(	clk		)	,
		.rst_n		(	rst_n	)	,
		.ren		(	)	,
		.wen		(	)	,
		.addr		(	)	,
		.wdata		(	)	,
		.data_out	(	)	
	);
	
	//生成本地时钟
	initial begin
		clk = 0;
		forever
		#(CYCLE/2)
		clk=!clk;
	end

	//产生复位信号
	initial begin
		rst_n = 1;
		#2;
		rst_n = 0;
		#(CYCLE*RST_TIME);
		rst_n = 1;
	end
	
	
	// 控制仿真时间
	initial	begin
		#600;	// 自定义仿真时间
		$stop;
	end
	
endmodule