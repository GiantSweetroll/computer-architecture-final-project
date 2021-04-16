module ATM_dut(
    reset,
    card,
    PIN,
    clock,
    amount,
    choice, 
    // Withdraw
    W_50000,
    W_100000,
    W_200000,
    // Deposit
    D_50000,
    D_100000,
    D_200000
);

input clock;
input reset;
input card;
input PIN;
input choice;
input [1:0] amount;

// wire amount[1:0];
output W_50000;
output W_100000;
output W_200000;

output D_50000;
output D_100000;
output D_200000;

reg restart;

reg W_50000;
reg W_100000;
reg W_200000;

reg D_50000;
reg D_100000;
reg D_200000;

reg [2:0] state, next_state;

parameter [1:0] FIFTY = 2'b01;
parameter [1:0] HUNDRED = 2'b10;
parameter [1:0] TWO_HUNDRED = 2'b11;

parameter [2:0] START = 3'b000;
parameter [2:0] CARD_INSERTED = 3'b001;
parameter [2:0] MENU = 3'b010;
parameter [2:0] DEPOSIT = 3'b011;
parameter [2:0] WITHDRAW = 3'b100;

initial begin
    state <= START;
    next_state <= START;
end

// always @(*) 
always @(state or PIN or card or choice or amount) 
begin
    $display("Input handling");
    $display(card);
    case(state)
        START:
            // $display("Does it even go here 2?");
            if(card == 1'b1) begin
                
                next_state <= CARD_INSERTED;
            end
        CARD_INSERTED:
            if(PIN == 1'b1) begin
                next_state <= MENU;
            end
            else if(PIN == 1'b0) begin
                next_state <= CARD_INSERTED;
            end
        MENU:
            // If user chooses deposit
            if(choice == 1'b0) begin
                next_state <= DEPOSIT;
            end
            else if(choice == 1'b1) begin
                next_state <= WITHDRAW;
            end
        DEPOSIT:
            if(amount == FIFTY) begin
                D_50000  <= 1'b1;
                restart <= 1'b1;
            end
            else if(amount == HUNDRED) begin
                D_100000 <= 1'b1;
                restart <= 1'b1;
            end
            else if(amount == TWO_HUNDRED) begin
                D_200000 <= 1'b1;
                restart <= 1'b1;
            end
        WITHDRAW:
            if(amount == FIFTY) begin
                W_50000  <= 1'b1;
                restart <= 1'b1;
            end
            else if(amount == HUNDRED) begin
                W_100000 <= 1'b1;
                restart <= 1'b1;
            end
            else if(amount == TWO_HUNDRED) begin
                W_200000 <= 1'b1;
                restart <= 1'b1;
            end
    endcase
end

always @(posedge clock)
begin
    $display("Posedge clock");
    if(reset == 0) begin
        state <= START;

        D_50000 <= 1'b0;
        D_100000 <= 1'b0;
        D_200000 <= 1'b0;
        
        W_50000 <= 1'b0;
        W_100000 <= 1'b0;
        W_200000 <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end
endmodule