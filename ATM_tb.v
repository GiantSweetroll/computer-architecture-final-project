`include "ATM_dut.v"

module ATM_tb();

reg clock;
reg reset;
reg card;
reg PIN;
reg choice;
reg [1:0] amount;

wire W_50000;
wire W_100000;
wire W_200000;
wire D_50000;
wire D_100000;
wire D_200000;

initial begin
    clock <= 0;
    PIN <= 0;
    card <= 0;
    #20
    card <= 1'b1;
    #20
    PIN = 1;
    #20
    choice = 1;
    #20
    amount = 2'b01;
end

always 
    #10 clock = ~clock;
    
ATM_dut dut(
    reset,
    card,
    PIN,
    clock,
    amount,
    choice,
    W_50000,
    W_100000,
    W_200000,
    D_50000,
    D_100000,
    D_200000
);

endmodule