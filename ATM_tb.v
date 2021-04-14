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
    clock = 0;
    reset = 1;
    card = 0;
    PIN = 0;
    choice = 0;
    amount = 0;
end

always 
    #10 clock = ~clock;
    
ATM_dut dut(
    clock,
    reset,
    card,
    PIN,
    choice,
    amount,
    W_50000,
    W_100000,
    W_200000,
    D_50000,
    D_100000,
    D_200000
);

endmodule