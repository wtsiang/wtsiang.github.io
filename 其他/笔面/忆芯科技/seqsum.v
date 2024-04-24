module seqsum (
	input			clk,
	input			rst_n,
	input 	[31:0] 	a,
	input 	[31:0] 	b,
	output	[31:0] 	y
);
	
/* 	reg [32:0] i;
	// 组合逻辑实现:代码综合不出来，综合时不确定循环次数，可能陷入死循环，综合器终止综合。
	always@(*) begin
		y = 0;
		for(i=a;i<=b;i=i+2) begin
			y = y + i;
			// $display("y=%3d,i=%3d",y,i);
		end
	end */
	
	// 时序逻辑实现
	wire	add_cnt;
	wire	end_cnt;
	reg	[31:0] cnt;
	reg	[31:0] y1;
	
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) begin
			cnt <= 0;
		end
		else if(add_cnt) begin
			cnt <= cnt + 2;
		end
		else if(end_cnt) begin
			cnt <= cnt;
		end
	end
	
	assign add_cnt = a < b && cnt <= b - a;	// 由于原函数i从a开始故可将b减去a，则与从a开始计数相同
	assign end_cnt = cnt > b - a;	
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) begin
			y1 <= 0;
		end
		else if(add_cnt) begin
			y1 <= y1 + a + cnt;	// 与原函数中y=y+i相同，i = a + cnt。
		end
	end	
	
	assign y = end_cnt?y1:0;
	
	
endmodule

/* 
//C语言测试代码
#include <stdio.h>

// 将下面函数改写为Verilog
int seqsum(int a, int b) {
    int y=0;
    for(int i=a; i<=b; i+=2){
        y=y+i;
        printf("y=%2d,i=%2d\n",y,i);
    }
return y;
}

int main() {
	int a = 1;
	int b = 10;
	int y;
	y = seqsum(a,b);
	
	printf("y=%d",y);
	
	return 0;
} */