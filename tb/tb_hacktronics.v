`timescale 1ns/1ps

module tb_hacktronics();

reg clk;
reg rst;
reg [7:0] pixel_in;
reg humidity_high;
reg temp_high;
reg spectral_high;
wire pest_detected;

// 64x64 image = 4096 pixels
reg [7:0] image_mem [0:4095];
integer i;

// Instantiate DUT
hacktronics dut (
    .clk(clk),
    .rst(rst),
    .pixel_in(pixel_in),
    .humidity_high(humidity_high),
    .spectral_high(spectral_high),
    .temp_high(temp_high),
    .pest_detected(pest_detected)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    pixel_in = 0;

    // Assume pest-friendly environmental condition
    humidity_high = 1;
    spectral_high = 1;
    temp_high = 0;

    // Load real image pixels
    $readmemb("image.mem", image_mem);

    #20 rst = 0;
    
    temp_high=1;

    // Feed image pixels sequentially
    for (i = 0; i < 4096; i = i + 1) begin
        pixel_in = image_mem[i];
        #10;   // one pixel per clock cycle
    end

    #100;
    $stop;
end

endmodule