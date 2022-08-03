module moduleName ();
    

string s;
initial   begin
    s = "IEEE ";
    $display (s.getc(0));       // 显示：73（*I"）
    $display (s.tolower ());   //显示：ieee
    s.putc(s.len()-1,"-");     //将空格变为'-，
    s= {s,"P1800"};             //"IEEE- P1800"
    $display (s.substr (2, 5)); // 显示：EB-P
    //！创建临时字符串,注意格式
    my_1og($psprintf("%s %5d",s, 42));
end
task my_1og (string message);
//把信息打印到日志里
    $display("@%0t: %s", $time, message);
endtask


endmodule
