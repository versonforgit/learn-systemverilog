package test_pkg is
    type reg2arb_t is record
        slv0_prio   :    std_logic_vector(1  downto  0);
    end record;
    type reg2fmt_t is record
        slv0_len   :    std_logic_vector(2  downto  0);
    end record;
end  test_pkg;
entity ctrl_regs4 is
    port(
    clk_i       :   in  std_logic;
    rstn_i      :   in  std_logic;
    cmd_i       :   in  std_logic_vector(1  downto  0);
    reg2fmt_o   :   out reg2fmt_t;
    reg2arb_o   :   out reg2arb_t;
    slv_i       :   out std_logic
    );
end ctrl_regs4;
