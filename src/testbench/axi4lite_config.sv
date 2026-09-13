class axi4lite_config extends uvm_object;
`uvm_object_utils(axi4lite_config)
virtual axi4lite_if vif;
uvm_active_passive_enum input_agent_is_active=UVM_ACTIVE;
uvm_active_passive_enum output_agent_is_active=UVM_PASSIVE;
function new(string name="axi4lite_config");
super.new(name);
endfunction
endclass
