`uvm_analysis_imp_decl(_output)
class subscriber extends uvm_subscriber #(trans);
`uvm_component_utils(subscriber)
uvm_analysis_imp #(trans,subscriber) input_imp;
uvm_analysis_imp_output #(trans,subscriber) output_imp;
trans drv;
trans mon;
covergroup input_cg;
addr_cp: coverpoint drv.AWADDR{
bins rd_wr={[32'h0:32'h24],32'h3C};
bins wr_bin={[32'h34:32'h38]};
bins inv={[32'h25:32'h27],[32'h31:32'h33],[32'h57:32'h3B],[32'h3D:32'hFFFFFFFF]} ;
}
addr_rd_cp: coverpoint drv.ARADDR{
bins rd_wr={[32'h0:32'h24],32'h3C};
bins rd_bin={[32'h28:32'h30]};
bins inv={[32'h25:32'h27],[32'h31:32'h33],[32'h57:32'h3B],[32'h3D:32'hFFFFFFFF]} ;
}

strb_cp: coverpoint drv.WSTRB{
bins strb_0={4'b0000};
bins strb_1={4'b0001, 4'b0010, 4'b0100, 4'b1000};
bins strb_all_ones={4'b1111};
bins strb_1s={4'b0011,4'b1100, 4'b1010, 4'b1110,4'b0111};
}
addr_strb: cross addr_cp, strb_cp;

endgroup
covergroup output_cg;
wrsp_cp: coverpoint mon.BRESP{
bins wrsp_0={2'b00};

bins wrsp_2={2'b10};
bins wrsp_3={2'b11};
}
rrsp_cp: coverpoint mon.RRESP{
bins rrsp_0={2'b00};

bins rrsp_2={2'b10};
bins rrsp_3={2'b11};
}
data_cp: coverpoint mon.RDATA{
bins dat={[32'h0:32'hFFFFFFFF]};
}
endgroup

function new(string name="subscriber",uvm_component parent=null);
super.new(name,parent);
input_imp=new("input_imp",this);
output_imp=new("output_imp",this);
input_cg=new();
output_cg=new();
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction
virtual function void write(trans t);
drv=t;
input_cg.sample();
`uvm_info(get_name,"[DRIVER]:Input Received",UVM_HIGH)
endfunction

 virtual function void write_output(trans t);
mon=t;
output_cg.sample();
endfunction
   
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_name,$sformatf("INPUT COVERAGE = %0f\n OUTPUT COVERAGE = %0f",input_cg.get_coverage(),output_cg.get_coverage()),UVM_NONE);
  endfunction
 
endclass
