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
通过 logic 和 bit 声明的矢量均为无符号 (unsigned） 变量，例如：
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
logic_vec = 128
bit_vec =128
signed_vec = -128
```
如果按照有符号和无符号的类型划分，那么可以将常见的变量类型划分为：
* 有符号类型：byte、 shortint、 int、 longint、 integer。
* 无符号类型：bit、 logic、 reg、 net-type（如 wire、 tri)。
避免两种不一致的变量进行操作，运算结果会出乎意料：
```systemverilog
bit [8:01 result_vec;
initial begin
result_vec = signed_vec;
$display("@1 result vec = 'h%x"， result_vec);
result_ve c= unsigned'(signed_vec);
$display("@2 result_vec = 'h%x"， result_vec);
end

