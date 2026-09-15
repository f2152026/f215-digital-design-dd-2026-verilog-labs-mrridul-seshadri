module alu_tb;

reg [3:0]a;
reg [3:0]b;
reg op;

wire [3:0]result;

alu DUT(
    .a(a),
    .b(b),
    .op(op),
    .result(result)
);

string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

initial begin
    a = 4'd5; b = 4'd3; op = 1'b0; #10; //supposed to print 8
    op = 1'b1; #10; // since a and b are the same therefore it shall print 2
    a = 4'd9; b = 4'd4; op = 1'b1; #10; // changing a,b and op so 9-4 =5
    a = 4'd3; b = 4'd7; op = 1'b1; #10;// again changing a and b for a negative outpt 3-7 = -4 

 end

initial begin
    $monitor($time, " a=%0d b=%0d op=%b | result=%0d (binary: %b)", 
             a, b, op, result, result);
  end
endmodule