// cla64_flat.v
// A flat, unblocked 64-bit carry-lookahead adder: every carry is computed
// directly (two-level, no rippling), exactly like cla4.v, just scaled to
// 64 bits. Add delays throughout (same convention as cla4.v) so it can be
// fairly compared against rca64.v and cla64_blocked.v.

module cla64_flat(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [63:0] p, g;
  wire [64:1] c;
  
  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin : gen_pg
      xor #(2) (p[i], a[i], b[i]);
      and #(2) (g[i], a[i], b[i]);
    end
  endgenerate

genvar j;
  wire [64:0] t_and [1:64]; 
  wire [64:0] t_or  [1:64]; 
  
  generate
    for (i = 1; i <= 64; i = i + 1) begin : gen_c
      
      assign t_and[i][0] = g[i-1];
      assign t_or[i][0]  = t_and[i][0];

      if (i == 1) begin : gen_base
        assign t_and[1][1] = p[0] & cin;
        assign t_or[1][1]  = t_or[1][0] | t_and[1][1];
      end else begin : gen_rest
        for (j = 1; j <= i; j = j + 1) begin : gen_terms
          assign t_and[i][j] = p[i-1] & t_and[i-1][j-1];
          assign t_or[i][j]  = t_or[i][j-1] | t_and[i][j];
        end
      end

      assign #(2) c[i] = t_or[i][i];
      
    end
  endgenerate
  
  assign cout = c[64];
  // ---------------------------------------------------------------------
  // Step 3: sum bits
  // ---------------------------------------------------------------------
  assign #(2) sum = p ^ {c[63:1], cin};

endmodule
