`timescale 1ns / 1ps

module hacktronics (
    input  wire        clk,
    input  wire        rst,
    input  wire [7:0]  pixel_in,
    input  wire        humidity_high,
    input  wire        spectral_high,
    input  wire        temp_high,
    output reg         pest_detected
);

wire [7:0] edge_out;

// Sobel Edge Detector
sobel_simple sobel_inst (
    .clk(clk),
    .rst(rst),
    .pixel_in(pixel_in),
    .pixel_valid(1'b1),
    .edge_out(edge_out)
);

// Pest Classification Logic (Latch once detected)
always @(posedge clk) begin
    if (rst)
        pest_detected <= 1'b0;
    else if (edge_out > 8'd50 && humidity_high && spectral_high && temp_high)
        pest_detected <= 1'b1;
end

endmodule