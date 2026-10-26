# UART

The FPGA receives hexadecimal data sent from a PC through PuTTY. The UART receiver captures the incoming serial data and reconstructs the original byte. The received data is then displayed on the FPGA's seven-segment displays, while the UART transmitter sends the same byte back to the PC.

The design uses a 50 MHz system clock and a default baud rate of 19,200 bps, with configurable parameters for clock frequency, baud rate, oversampling, data width, and stop-bit timing.

## Design Parameters

| Parameter | Default Value | Description |
|---|---|---|
| `CLK_FREQ` | 50 MHz | System clock frequency |
| `BAUD_RATE` | 19,200 bps | UART communication speed |
| `OVERSAMPLE` | 16 | Oversampling factor |
| `DBIT` | 8 | Number of data bits |
| `SB_TICK` | 16 | Stop-bit timing in oversampling ticks |

## Project Files

| File | Description |
|---|---|
| [UART_TOP.sv](https://github.com/im-Fatima/UART/blob/main/UART_TOP.sv) | Integrates the UART receiver, transmitter, baud rate generator, and display logic. |
| [UART_RX.sv](https://github.com/im-Fatima/UART/blob/main/UART_RX.sv) | Receives serial data and converts it into an 8-bit parallel byte using an FSM. |
| [UART_TX.sv](https://github.com/im-Fatima/UART/blob/main/UART_TX.sv) | Converts parallel data into serial UART frames for transmission. |
| [baud_rate_generator.sv](https://github.com/im-Fatima/UART/blob/main/baud_rate_generator.sv) | Generates the oversampling tick for UART timing. |
| [hex_decoder.sv](https://github.com/im-Fatima/UART/blob/main/hex_decoder.sv) | Decodes 4-bit hexadecimal values into active-low seven-segment display patterns. |

## FPGA Verification

The design is intended for FPGA-based UART echo testing using PuTTY. Incoming bytes are displayed on the FPGA's seven-segment displays and transmitted back to the PC through the UART transmitter.
