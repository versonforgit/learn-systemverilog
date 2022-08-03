module dynamic_bit (
);
    int dyn[],d2[];
    initial begin
        dyn = new[5];
        foreach (dyn[j]) dyn[j]=j;
        d2 = dyn;
        d2[0]=5;
        $display(dyn[0],d2[0]);
        dyn = new [20](dyn);
        $display(dyn[19]);
        dyn = new[100];
        $display(dyn[19]);
        dyn.delete();

    end
endmodule