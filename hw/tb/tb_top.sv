module tb_top;
  logic sys_clk = 1'b0;
  logic sys_rst_n = 1'b0;
  wire [3:0] led;

  // 100MHz clock
  always #5 sys_clk = ~sys_clk;

  initial begin
    sys_rst_n = 1'b0;
    repeat (10) @(posedge sys_clk);
    sys_rst_n = 1'b1;

    // run a bit
    repeat (2000) @(posedge sys_clk);

    $display("LED=%b", led);
    $finish;
  end

  top dut (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .led(led)
  );
endmodule
