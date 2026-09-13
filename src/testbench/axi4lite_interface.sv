interface axi4lite_if(input bit ACLK, input bit ARESETn);
logic [31:0] WDATA;
logic [31:0] AWADDR, ARADDR;
logic [2:0] AWPROT;
logic AWVALID, AWREADY;
logic [3:0] WSTRB;
logic WVALID, WREADY, BVALID, BREADY, ARVALID, ARREADY, RVALID, RREADY;
logic [1:0] BRESP;
logic [2:0]ARPROT;
logic [31:0]RDATA;
logic [1:0] RRESP;

property reset;
@(posedge ACLK) !(ARESETn) |-> RDATA==32'b0 && !RVALID && !BVALID;
endproperty
assert property(reset)
else
$error("Reset error");

property bvalid;
@(posedge ACLK) BVALID && !BREADY |=> BVALID;
endproperty
assert property(bvalid)
else
$error("BVALID error");

property bresp;
@(posedge ACLK) BVALID |=> !($isunknown(BRESP));
endproperty
assert property(bresp)
else
$error("BRESP error");

property rvalid;
@(posedge ACLK) RVALID && !RREADY |=> RVALID;
endproperty
assert property(rvalid)
else
$error("RVALID error");

property awaddr ;
@(posedge ACLK) AWVALID |=> !($isunknown(AWADDR));
endproperty
assert property(awaddr)
else
$error("AWADDR error");

property wdata;
@(posedge ACLK) WVALID |=> !($isunknown(WDATA)) && !($isunknown(WSTRB));
endproperty
assert property(wdata)
else
$error("WDATA error");

property rdata;
@(posedge ACLK) RVALID |=> !($isunknown(RDATA));
endproperty
assert property(rdata)
else
$error("RDATA error");

property rresp;
@(posedge ACLK) RVALID |=> !($isunknown(RRESP));
endproperty
assert property(rresp)
else
$error("RRESP error");

clocking drv_cb @(posedge ACLK);
default input #1 ;
output AWADDR, WDATA, ARADDR, AWVALID, WVALID, ARVALID, WSTRB, BREADY, RREADY, AWPROT, ARPROT;
input ARESETn;
input BVALID,RVALID,AWREADY,WREADY,BRESP,ARREADY;
endclocking

clocking inp_mon_cb @(posedge ACLK);
default input #1;
input AWADDR, WDATA, ARADDR, AWVALID, WVALID, ARVALID, WSTRB, BREADY, RREADY, AWPROT, ARPROT, AWREADY, WREADY, ARREADY, BVALID, RVALID, BRESP, RRESP,RDATA;
input ARESETn;
endclocking

clocking out_mon_cb @(posedge ACLK);
default input #1;
input AWADDR, WDATA, ARADDR, AWVALID, WVALID, ARVALID, WSTRB, BREADY, RREADY, AWPROT, ARPROT, AWREADY, WREADY, ARREADY, BVALID, RVALID, BRESP, RRESP,RDATA;
input ARESETn;
endclocking

modport drv_mp(clocking drv_cb);
modport inp_mon_mp(clocking inp_mon_cb);
modport out_mon_mp(clocking out_mon_cb);
endinterface
