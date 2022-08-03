module meiju ();
    
initial begin
    

typedef enum {RED, BLUE,GREEN} color_e;
color_e color;
color = color.first;
do
    begin
    $display ("Color = %d/%s",color, color.name);
    color= color.next;
    end
while (color!=color.first);//环形绕回时即完成

end

endmodule