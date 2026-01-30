module reset_sync (
  input  logic clk,
  input  logic arst_n,   // async active-low reset in
  output logic srst      // sync active-high reset out
);
  logic [1:0] sync;

  always_ff @(posedge clk or negedge arst_n) begin
    if (!arst_n) begin
      sync <= 2'b11;
      srst <= 1'b1;
    end else begin
      sync <= {sync[0], 1'b0};
      srst <= sync[1];
    end
  end
endmodule
