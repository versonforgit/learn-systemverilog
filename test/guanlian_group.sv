module guanlian (
);
    int switch[string],min_address,max_address;
    initial begin
        int i,r,file;
        string s;
        file = $fopen("switch.txt","r");
        while (!$feof(file)) begin
            r = $fscanf(file,"%d %s",i,s);
            switch[s] = i;    
        end
        foreach(switch[s])
            $display("switch[%s] = %d",s,switch[s]);
    end
endmodule