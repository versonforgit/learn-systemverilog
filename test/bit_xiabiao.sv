module bit_xiabiao ();
    initial begin
        bit [31:0] src[5] = '{5{5}};
        $displayb(src[0],,
                    src[0][0],,
                    src[0][2:1]);
    end
    
endmodule