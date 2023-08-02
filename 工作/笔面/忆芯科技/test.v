module test (
  input clk,
  input [3:0] addr,
  input ren,
  input rst_n,
  input [7:0] wdata,
  input wen,
  output reg [7:0] data_out
);

reg [7:0] mem_name [7:0];
reg [3:0]	i;

/* initial begin
	for(i=0;i<=7;i=i+1)
		mem_name[i] = i;
		
	$display("mem_name[0]=%0d",mem_name[0]);
	$display("mem_name[1]=%0d",mem_name[1]);
	$display("mem_name[2]=%0d",mem_name[2]);
	$display("mem_name[3]=%0d",mem_name[3]);
	$display("mem_name[4]=%0d",mem_name[4]);
	$display("mem_name[5]=%0d",mem_name[5]);
	$display("mem_name[6]=%0d",mem_name[6]);
	$display("mem_name[7]=%0d",mem_name[7]);
end
 */

always @ (posedge clk or negedge rst_n)begin
  if (rst_n) begin
	for(i=0;i<=7;i=i+1) begin
		mem_name[i] <= 0;
	end
  end
  else if (wen)
    mem_name[addr] <= wdata;
  else
    ;
end

always @ (*)
  if (ren)
	data_out = mem_name[addr];
  else
   data_out = data_out;

endmodule
