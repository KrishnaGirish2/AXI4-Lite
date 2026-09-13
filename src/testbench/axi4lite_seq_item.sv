class trans extends uvm_sequence_item;
rand bit [31:0]AWADDR, WDATA, ARADDR;
rand bit [2:0]AWPROT, ARPROT;
rand bit [3:0]WSTRB;
rand bit write_read;
rand bit [1:0]write_order;
bit alt;
bit AWVALID, WVALID, BREADY, ARVALID, RREADY;
logic AWREADY, WREADY, BVALID, RVALID;
logic [1:0]BRESP, RRESP;
logic [31:0]RDATA;
logic ARESETn;
constraint c1{ AWPROT==3'b000; ARPROT==3'b000;}

//constraint c2{ write_order inside {1'd1,1'd2,1'd3};}
`uvm_object_utils_begin(trans)
`uvm_field_int(AWADDR,UVM_ALL_ON)
`uvm_field_int(WDATA,UVM_ALL_ON)
`uvm_field_int(ARADDR,UVM_ALL_ON)
`uvm_field_int(AWPROT,UVM_ALL_ON)
`uvm_field_int(ARPROT,UVM_ALL_ON)
`uvm_field_int(WSTRB,UVM_ALL_ON)
`uvm_field_int(write_read,UVM_ALL_ON)
`uvm_field_int(write_order,UVM_ALL_ON)
`uvm_field_int(ARESETn,UVM_ALL_ON)
`uvm_field_int(RDATA,UVM_ALL_ON)
`uvm_field_int(RRESP,UVM_ALL_ON)
`uvm_object_utils_end
function new(string name="trans");
super.new(name);
endfunction
endclass


