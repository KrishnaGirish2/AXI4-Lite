class test extends uvm_test;
`uvm_component_utils(test)
env env_h;
axi4lite_config m_cfg;
function new(string name="test",uvm_component parent);
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
m_cfg=axi4lite_config::type_id::create("m_cfg");
if(!uvm_config_db#(virtual axi4lite_if)::get(this,"","axi4lite_if",m_cfg.vif))
`uvm_fatal(get_type_name(),"Can't get the interface")
m_cfg.input_agent_is_active=UVM_ACTIVE;
m_cfg.output_agent_is_active=UVM_PASSIVE;
uvm_config_db#(axi4lite_config)::set(this,"*","axi4lite_config",m_cfg);
env_h=env::type_id::create("env_h",this);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_top.print_topology();
endfunction
endclass

class test1 extends test;
`uvm_component_utils(test1)
seq_1 s1;
seq_2 s2;
seq_3 s3;
seq_4 s4;
seq_5 s5;
seq_6 s6;
seq_7 s7;
seq_8 s8;
seq_9 s9;
seq_10 s10;
seq_11 s11;
seq_12 s12;
seq_13 s13;
seq_14 s14;
seq_15 s15;
seq_16 s16;
seq_17 s17;
seq_18 s18;
seq_19 s19;
seq_20 s20;
seq_21 s21;
seq_22 s22;
seq_23 s23;
seq_24 s24;
seq_25 s25;
seq_26 s26;
seq_27 s27;
seq_28 s28;
seq_29 s29;
seq_30 s30;
seq_31 s31;
seq_32 s32;
function new(string name="test1",uvm_component parent);
super.new(name,parent);
endfunction
task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1=seq_1::type_id::create("s1");
s2=seq_2::type_id::create("s2");
s3=seq_3::type_id::create("s3");
s4=seq_4::type_id::create("s4");
s5=seq_5::type_id::create("s5");
s6=seq_6::type_id::create("s6");
s7=seq_7::type_id::create("s7");
s8=seq_8::type_id::create("s8");
s9=seq_9::type_id::create("s9");
s10=seq_10::type_id::create("s10");
s11=seq_11::type_id::create("s11");
s12=seq_12::type_id::create("s12");
s13=seq_13::type_id::create("s13");
s14=seq_14::type_id::create("s14");
s15=seq_15::type_id::create("s15");
s16=seq_16::type_id::create("s16");
s17=seq_17::type_id::create("s17");
s18=seq_18::type_id::create("s18");
s19=seq_19::type_id::create("s19");
s20=seq_20::type_id::create("s20");
s21=seq_21::type_id::create("s21");
s22=seq_22::type_id::create("s22");
s23=seq_23::type_id::create("s23");
s24=seq_24::type_id::create("s24");
s25=seq_25::type_id::create("s25");
s26=seq_26::type_id::create("s26");
s27=seq_27::type_id::create("s27");
s28=seq_28::type_id::create("s28");
s29=seq_29::type_id::create("s29");
s30=seq_30::type_id::create("s30");
s31=seq_31::type_id::create("s31");
s32=seq_32::type_id::create("s32");
begin
s1.start(env_h.agt_h.seqr_h);
s2.start(env_h.agt_h.seqr_h);
s3.start(env_h.agt_h.seqr_h);
s4.start(env_h.agt_h.seqr_h);
s5.start(env_h.agt_h.seqr_h);
s6.start(env_h.agt_h.seqr_h);
s7.start(env_h.agt_h.seqr_h);
s8.start(env_h.agt_h.seqr_h);
s9.start(env_h.agt_h.seqr_h);
s10.start(env_h.agt_h.seqr_h);
s11.start(env_h.agt_h.seqr_h);
s12.start(env_h.agt_h.seqr_h);
s13.start(env_h.agt_h.seqr_h);
s14.start(env_h.agt_h.seqr_h);
s15.start(env_h.agt_h.seqr_h);
s16.start(env_h.agt_h.seqr_h);
s17.start(env_h.agt_h.seqr_h);
s18.start(env_h.agt_h.seqr_h);
s19.start(env_h.agt_h.seqr_h);
s20.start(env_h.agt_h.seqr_h);
s21.start(env_h.agt_h.seqr_h);
s22.start(env_h.agt_h.seqr_h);
s23.start(env_h.agt_h.seqr_h);
s24.start(env_h.agt_h.seqr_h);
s25.start(env_h.agt_h.seqr_h);
s26.start(env_h.agt_h.seqr_h);
s27.start(env_h.agt_h.seqr_h);
s28.start(env_h.agt_h.seqr_h);
s29.start(env_h.agt_h.seqr_h);
s30.start(env_h.agt_h.seqr_h);
//repeat(5)@(m_cfg.vif.inp_mon_cb);
s1.start(env_h.agt_h.seqr_h);
s31.start(env_h.agt_h.seqr_h);
s1.start(env_h.agt_h.seqr_h);

s32.start(env_h.agt_h.seqr_h);
end
#100;
phase.drop_objection(this);
endtask
endclass
