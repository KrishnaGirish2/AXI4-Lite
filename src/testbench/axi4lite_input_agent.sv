class input_agent extends uvm_agent;
`uvm_component_utils(input_agent)
driver dr_h;
input_monitor inp_mon_h;
sequencer seqr_h;
axi4lite_config m_cfg;

function new(string name="input_agent",uvm_component parent);
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(axi4lite_config)::get(this,"","axi4lite_config",m_cfg))
`uvm_fatal(get_type_name(),"Input agent failed");
inp_mon_h=input_monitor::type_id::create("inp_mon_h",this);

if(m_cfg.input_agent_is_active==UVM_ACTIVE) begin
dr_h=driver::type_id::create("dr_h",this);
seqr_h=sequencer::type_id::create("seqr_h",this);
end
endfunction
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(m_cfg.input_agent_is_active==UVM_ACTIVE) begin
dr_h.seq_item_port.connect(seqr_h.seq_item_export);
end
endfunction
endclass
