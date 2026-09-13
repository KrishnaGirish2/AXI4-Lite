
//`include "axi4lite_interface.sv"
//`include "axi4lite_pkg.sv"
//`include "axi4lite.v"
module top();
import uvm_pkg::*;
import axi4lite_pkg::*;
bit ACLK,ARESETn;
axi4lite_if DUV_IF(ACLK,ARESETn);
axi4_lite_slave #(.DATA_WIDTH(32),.ADDR_WIDTH(32),.MEM_DEPTH(16),.DEFAULT_PROT(3'b000)) dut(.ACLK(ACLK),.ARESETn(ARESETn),
.AWADDR(DUV_IF.AWADDR),.AWPROT(DUV_IF.AWPROT),.AWVALID(DUV_IF.AWVALID),.AWREADY(DUV_IF.AWREADY),.WDATA(DUV_IF.WDATA),.WSTRB(DUV_IF.WSTRB)
,.WVALID(DUV_IF.WVALID),.WREADY(DUV_IF.WREADY),.BRESP(DUV_IF.BRESP),.BVALID(DUV_IF.BVALID),.BREADY(DUV_IF.BREADY),.ARADDR(DUV_IF.ARADDR),
.ARPROT(DUV_IF.ARPROT),.ARVALID(DUV_IF.ARVALID),.ARREADY(DUV_IF.ARREADY),.RDATA(DUV_IF.RDATA),.RRESP(DUV_IF.RRESP),.RVALID(DUV_IF.RVALID),
.RREADY(DUV_IF.RREADY));
initial begin
uvm_config_db #(virtual axi4lite_if)::set(null,"*","axi4lite_if",DUV_IF);
$dumpfile("waves.fsdb");
$dumpvars;
run_test("test1");
end
initial begin
ACLK=1'b0;
forever
#5 ACLK=~ACLK;
end
initial begin
ARESETn=1'b0;
#12 ARESETn=1'b1;
#100 ARESETn=1'b0;
#110 ARESETn=1'b1;
end
endmodule
