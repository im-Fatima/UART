module UART_TOP #(
    parameter int CLK_FREQ   = 50_000_000,
    parameter int BAUD_RATE  = 19_200,
    parameter int OVERSAMPLE = 16,
    parameter int DBIT       = 8,
    parameter int SB_TICK    = 16
)(
    input  logic clk,
    input  logic rst,

    input  logic uart_rx,
    output logic uart_tx,

    output logic [6:0] HEX0,
    output logic [6:0] HEX1
);

    logic s_tick;
    logic rx_done;
    logic tx_done;

    logic [DBIT-1:0] rx_data;
    logic [DBIT-1:0] tx_data;
    logic tx_start;

    logic [7:0] display_data;

    baud_rate_generator #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE),
        .OVERSAMPLE(OVERSAMPLE)
    ) baud_gen (
        .clk(clk),
        .reset(rst),
        .s_tick(s_tick)
    );


    UART_RX #(
        .DBIT(DBIT),
        .SB_TICK(SB_TICK)
    ) receiver (
        .clk(clk),
        .rst(rst),
        .rx(uart_rx),
        .s_tick(s_tick),
        .rx_done(rx_done),
        .dout(rx_data)
    );


    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_start    <= 1'b0;
            tx_data     <= '0;
            display_data <= 8'h00;
        end
        else begin
            tx_start <= 1'b0;

            if (rx_done) begin
                tx_data      <= rx_data;
                tx_start     <= 1'b1;
                display_data <= rx_data;
            end
        end
    end


    UART_TX #(
        .DBIT(DBIT),
        .SB_TICK(SB_TICK)
    ) transmitter (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .s_tick(s_tick),
        .din(tx_data),
        .tx_done(tx_done),
        .tx(uart_tx)
    );


    hex_decoder hex_low (
        .digit(display_data[3:0]),
        .seg(HEX0)
    );

    hex_decoder hex_high (
        .digit(display_data[7:4]),
        .seg(HEX1)
    );

endmodule
