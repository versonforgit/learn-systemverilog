module test_v_wai(clk_i,
            rstn_i,
            cmd_i,
            slv0_prio,
            slv0_len,
            slv_o);
    input clk_i,rstn_i;
    input [1:0] cmd_i;
    output [1:0] slv0_prio;
    output [2:0] slv0_len;
    output [1:0] slv_o;
endmodule