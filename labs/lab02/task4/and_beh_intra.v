module and_beh_intra (
  input      a,
  input      b,
  output reg y
);

  always @(a or b) begin
    y = #5 (a & b);
  end

endmodule