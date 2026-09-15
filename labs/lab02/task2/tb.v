// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  reg [1:0] sel;
  reg [7:0] dout;

  lut DUT (
    .sel(sel),
    .dout(dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    sel = 2'b00; #10;
    sel = 2'b01; #10;
    sel = 2'b10; #10;
    sel = 2'b11; #10;


  end

  initial
    $monitor($time, " sel=%b | dout=%b ", sel,dout); // change as required
    

endmodule
