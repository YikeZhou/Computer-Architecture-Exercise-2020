module timer(
    input reset,
    input clock,
    output reg [4:0] hour,
    output reg [5:0] minute,
    output reg [5:0] second
);
    /* Please insert your code here. */
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // reset
            hour <= 0;
            minute <= 0;
            second <= 0;
        end
        else begin
            second <= second + 1;
            if (second >= 59) begin
                minute <= minute + 1;
                second <= 0;
            end
            if (minute >= 59) begin
                hour <= hour + 1;
                minute <= 0;
            end
            if (hour >= 59) begin
                hour <= 0;
            end
        end
    end

endmodule