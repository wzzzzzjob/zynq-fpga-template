module top (
  input  wire        sys_clk,
  input  wire        sys_rst_n,
  output wire [1:0]  led
);

  logic rst;
  reset_sync u_rst (
    .clk   (sys_clk),
    .arst_n(sys_rst_n),
    .srst  (rst)
  );

  logic [31:0] cnt;
  always_ff @(posedge sys_clk) begin
    if (rst) cnt <= 32'd0;
    else     cnt <= cnt + 1;
  end

  assign led = cnt[25:24];

endmodule
