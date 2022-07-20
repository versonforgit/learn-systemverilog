
# SV环境构建
### 优点
1. 抽象的数据结构描述 满足 更高层面的验证需求。
2. 面向对象的编程方式 更好的模块性、封装性和复用性。
3. 验证一侧独立于设计，因为验证侧的语言属性完全基于软件化的构建方式。
4. 约束化随机激励 提高 回归验证收益。
5. 功能覆盖率收集可量化功能验证点 验证进度易于反映。
* 主要任务
    - [ ] SV的环境构建
    - [ ] SV的组件实现
    - [ ] SV的系统集成
## 数据类型
相应于 Verilog 将变量类型（如 reg）和线网类型（如 wire) 区分得如此清楚，在SV中新引入了一个数据类型`logic`。
区别联系在于：
* Verilog 作为硬件描述语言，倾向于认为设计人员自身懂得所描述的电路中哪些变量应被实现为寄存器，哪些变量应被实现为线网类型。这不但有利于后端综合工具，更便于阅读和理解。
* SV 作为侧重于验证的语言，并不十分关心 logic 类型对应的逻辑应被综合为寄存器还是综合为线网，因为如果 logic 类型被使用的场景是验证环境，那么它只会作为单纯的变量进行赋值操作，而这些变量只属于软件环境构建。
* 推出 logic 类型的另一个原因是方便验证人员驱动和连接硬件模块而省去考虑使用reg 还是使用 wire 的精力。这既节省了时间，也避免了出错的可能。与logic 类型对应的数据类型是 bit 类型，它们均可用来构建矢量类型（vector)，区别在于：
    * logic 为四值逻辑，即可以表示 0、1、X、Z。
    * bit 为二值逻辑，只可以表示0和1。
**通过 logic 和 bit 声明的矢量均为无符号 (unsigned） 变量，例如：**
```systemverilog
module tb ;
    logic [7:0]  logic_vec = 8'b1000_0000;
    bit [7:0] bit_vec=8'b1000_0000;
    byte signed_vec = 8'b1000_0000;
initial begin
    $display("1ogie_vec = %d", logic_vec);
    $display("bit_vec = %d", bit_vec);
    $display("signed_vec = %d", signed_vec);
end
endmodule
```
仿真结果：
```shell
# logic_vec = 128
# bit_vec =128
# signed_vec = -128
```
如果按照有符号和无符号的类型划分，那么可以将常见的变量类型划分为：
* 有符号类型：byte、 shortint、 int、 longint、 integer。
* 无符号类型：bit、 logic、 reg、 net-type（如 wire、 tri)。
**避免两种不一致的变量进行操作，运算结果会出乎意料：**
```systemverilog
module tb;
    bit [8:01 result_vec;
    initial begin
        result_vec = signed_vec;
        $display("@1 result vec = 'h%x"， result_vec);
        result_ve c= unsigned'(signed_vec);
        $display("@2 result_vec = 'h%x"， result_vec);
    end
endmodule
```
仿真结果：
```shell
# @1 result_vec ='h180
# @2 result_vec ='h080
```
我们这里分析一下：
(1) 开始时，signed vec 被赋值为 8 510000000，表达为有符号十进制数值为-128。
(2）在第一次赋值操作时 result vec = signed vec，右侧的有符号数值-128 被赋值到左侧，并且需要从8位扩展为9位，保证有符号数值不变的情况下，首先需要将 8h80 扩展为9h180（均为-128)，进而再赋值到左侧。
(3）在第二次赋值操作时，我们首先进行了类型转换操作 unsigned(signed vec)，则转换结果应为十进制数值128，所以在赋值操作以后 result vec = unsigned(signed vec), result_ vec同 signed vec 就比特位的数值没有发生变化，但是实际表达的干进制数值则从-128 被赋值为128。
通过上面的例子我们可以发现，编码时一定要注意操作符左右两侧的符号类型是否一致，如果不一致，要将其转换为同一类型再进行运算。
上面例子是静态转换，不会对转换状态给出反馈。
与之对应的是动态转换¥cast(tgt,src)
**隐式转化**
```systemverilog
module tb;
    logic [3:0] x_vec = 'b111x;
    bit [2:0] b_vec ;
    initial begin
        $display("@1 x_vec = 'b%b",x_vec);
        b_vec = x_vec;
        $display("@2 b_vec = 'b%b"，b_vec)；
    end
endmodule
```
仿真结果：
```shell
# @1 x_vec = 'b111x
# @2 b_vec = 'b110
```
## 模块定义与例化
### 模块定义
#### Verilog模块定义
1. 括号外说明
```verilog
module test(clk,rstn,
            cmd,
            slv,)
    input clk,rstn;
    input [1:0] cmd;
    output [1:0] slv;
endmodule
```
2. 括号内说明
```verilog
module test(input clk,
            input rstn,
            input [1:0] cmd,
            output [1:0] slv);
endmodule
```
## 
