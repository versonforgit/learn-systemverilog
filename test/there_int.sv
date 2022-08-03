module three_int ();
    initial begin
        
    
        int threeD[10][10][10];
        foreach(threeD[i,j,k])
            threeD[i][j][k] = i*100 + j*10 + k;
        foreach(threeD[i])begin
            $write("%d:",i);
            $display;
            foreach(threeD[,j])begin
                $write("%d:",j);
               
                    foreach(threeD[,,k])
                        $write("%3d",threeD[i][j][k]);
                $display;
            end 
        end
    end

    
endmodule