module BCD_ALU(input [1:0] OP, input [15:0] A, input [15:0] B, output [15:0] C);
    reg [15:0] C, bin_A, bin_B, bin_C;

    always@(A or B or OP) begin
        if (A > 16'h9999) begin
            C = 16'hCCCC;
        end
        else if (B > 16'h9999) begin
            C = 16'hCCCC;
        end
        else begin
            if (OP == 0) begin
                bin_A = (A[15:12] * 10'd1000) + (A[11:8]*7'd100) + (A[7:4]*4'd10) + A[3:0];
                bin_B = (B[15:12] * 10'd1000) + (B[11:8]*7'd100) + (B[7:4]*4'd10) + B[3:0];
                C = bin_A + bin_B;
            end
            if (OP == 1) begin
                bin_A = (A[15:12] * 10'd1000) + (A[11:8]*7'd100) + (A[7:4]*4'd10) + A[3:0];
                bin_B = (B[15:12] * 10'd1000) + (B[11:8]*7'd100) + (B[7:4]*4'd10) + B[3:0];
                C = bin_A - bin_B;
            end
            if (OP == 2) begin
                C[15:12] = 4'b1001 - A[15:12];
                C[11:8] = 4'b1001 - A[11:8];
                C[7:4] = 4'b1001 - A[7:4];
                C[3:0] = 4'b1001 - A[3:0];
                C = (C[15:12] * 10'd1000) + (C[11:8]*7'd100) + (C[7:4]*4'd10) + C[3:0];
            end
            if (OP == 3) begin
                bin_A = (A[15:12] * 10'd1000) + (A[11:8]*7'd100) + (A[7:4]*4'd10) + A[3:0];
                bin_B = (B[15:12] * 10'd1000) + (B[11:8]*7'd100) + (B[7:4]*4'd10) + B[3:0];
                if (bin_A > bin_B) begin
                    C = 16'h0001;
                end
                else if (bin_A == bin_B) begin
                    C = 16'h0000;
                end
                else begin
                    C = 16'hFFFF;
                end
            end
        end
    end
    
endmodule