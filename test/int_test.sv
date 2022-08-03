module int_test ();
    int int_a[5] = '{1,2,3,4,5};
    int a = 32'd0;
    initial begin
        for (int i =0 ;i<$size(int_a) ;i++ ) begin
            a = a + 32'd1;
             $display("a=%d",a);
        end
    $display("size of int_a is %2d",$size(int_a));
        
    end
   
    
endmodule