entity ctrl_regs3 is
    port(
    clk_i       :   in  std_logic;
    rstn_i      :   in  std_logic;
    cmd_i       :   in  std_logic_vector(1  downto  0);
    slv0_prio   :   out std_logic_vector(1  downto  0);
    slv0_len    :   out std_logic_vector(2  downto  0);
    slv_o       :   out std_logic
    );
end ctrl_regs3;