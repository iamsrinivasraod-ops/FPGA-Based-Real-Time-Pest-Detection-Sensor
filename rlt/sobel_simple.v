`timescale 1ns / 1ps

module sobel_simple(
    input  wire        clk,
    input  wire        rst,
    input  wire [7:0]  pixel_in,
    input  wire        pixel_valid,
    output reg  [7:0]  edge_out
);

    reg [7:0] prev_pixel;
    reg signed [9:0] diff;
    reg [9:0] abs_diff;

    always @(posedge clk) begin
        if (rst) begin
            prev_pixel <= 8'd0;
            edge_out   <= 8'd0;
        end
        else if (pixel_valid) begin
            diff = pixel_in - prev_pixel;

            if (diff < 0)
                abs_diff = -diff;
            else
                abs_diff = diff;

            if (abs_diff > 10'd50)
                edge_out <= 8'hFF;
            else
                edge_out <= abs_diff[7:0];

            prev_pixel <= pixel_in;
        end
    end

endmodule