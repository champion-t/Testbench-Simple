module adder (aif dif);
    always_comb begin
        if (!dif.rstn) begin
            dif.sum <= 0;
            dif.carry <= 0;
        end
        else begin
            {dif.carry, dif.sum} <= dif.a + dif.b;
        end
    end
endmodule