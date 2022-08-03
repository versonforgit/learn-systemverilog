module repeat_bit (
    
);
    int       sh_int[5] = '{5{32'd1}};
    int       lo_int[20];
    initial begin
        lo_int = '{20{32'd1}};
    end
endmodule