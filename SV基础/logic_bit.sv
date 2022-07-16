module tb ;
    logic [7:0]  logic_vec = 8'b1000_0000;
    bit [7:0] bit_vec=8'b1000_0000;
    byte signed_vec = 8'b1000_0000;
initial begin
    $display("1ogie_vec = %d", logic_vec);
    $display("bit_vee=%d", bit_vec);
    $display("signed_vec = %d", signed_vec);
end
endmodule