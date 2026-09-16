class driver extends uvm_driver#(trans);
	`uvm_component_utils(driver)
	virtual axi4lite_if.drv_mp vif;
	axi4lite_config m_cfg;
	trans data2duv;
	function new(string name="driver", uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(axi4lite_config)::get(this,"","axi4lite_config",m_cfg))
			`uvm_fatal(get_type_name(),"Driver Failed");
	endfunction
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction
	task run_phase(uvm_phase phase);
		vif.drv_cb.AWVALID<=0;
		vif.drv_cb.WVALID<=0;
		vif.drv_cb.ARVALID<=0;
		vif.drv_cb.RREADY<=0;
		vif.drv_cb.BREADY<=0;

		forever begin
			`uvm_info("Driver_check","Before get next item",UVM_NONE)
			seq_item_port.get_next_item(req);
			`uvm_info("Driver_check","After get next item",UVM_NONE)
			if(req.write_read)begin
				case(req.write_order)
				2'd0: begin
					`uvm_info("Driver_check","before write address handshake",UVM_NONE)
					drive_write_address(req);
					`uvm_info("Driver_check","after write address handshake",UVM_NONE)
					drive_write_data(req);
					`uvm_info("Driver_check","after write data handshake",UVM_NONE)
				end

				2'd1: begin
					drive_write_data(req);
					drive_write_address(req);
				end
				2'd2: begin
					if(req.alt==0) begin
						drive_write_data(req);
						@(vif.drv_cb);
						drive_write_address(req);
						req.alt=1;
				end
					else begin
						drive_write_address(req);
						@(vif.drv_cb);
						drive_write_data(req);
						req.alt=0;
					end

				end
				2'd3: begin
 					fork
						drive_write_address(req,1);
						drive_write_data(req,1);
					join
				end
				endcase
				`uvm_info("Driver_check","before waiting for response",UVM_NONE)
				//vif.drv_cb.BREADY<=1;
				wait(vif.drv_cb.BVALID);
				`uvm_info("Driver_check","BVALID detected",UVM_NONE)

				@(vif.drv_cb);
				`uvm_info("Driver_check","after one cycle asserting BREADY",UVM_NONE)

				vif.drv_cb.BREADY<=1;
				@(vif.drv_cb);
				`uvm_info("Driver_check","BREADY handshake done",UVM_NONE)

				vif.drv_cb.BREADY<=0;
				`uvm_info("Driver_check","got response ",UVM_NONE)
			end

			else begin
				`uvm_info("Driver check","Read transaction received ",UVM_NONE);
 				drive_read(req);
				//vif.drv_cb.RREADY<=1;
				forever begin
					@(vif.drv_cb);

					if(vif.drv_cb.RVALID) break;
				end
				vif.drv_cb.RREADY<=1;
				@(vif.drv_cb);
				vif.drv_cb.RREADY<=0;
			end
			`uvm_info("INPUT_DRIVER",$sformatf("Input Driver\n%s",req.sprint()),UVM_NONE);
			seq_item_port.item_done();
		end
	endtask
	task drive_write_address(trans data2duv, bit hold=0);
	begin
		@(vif.drv_cb);
		vif.drv_cb.AWADDR<=data2duv.AWADDR;
		vif.drv_cb.AWPROT<=data2duv.AWPROT;
		$display("%0t Driver: AWVALID<=1",$time);
		vif.drv_cb.AWVALID<=1;
		@(vif.drv_cb)
		while(!vif.drv_cb.AWREADY) @vif.drv_cb;
		if(hold) @(vif.drv_cb);
		$display("[%0t] Driver:AWREADY seen, AWVALID<=0",$time);
		vif.drv_cb.AWVALID<=0;
	end
	endtask

	task drive_write_data(trans data2duv, bit hold=0);
	begin
		@(vif.drv_cb);
		vif.drv_cb.WDATA<=data2duv.WDATA;
		vif.drv_cb.WSTRB<=data2duv.WSTRB;
		vif.drv_cb.WVALID<=1;
		@(vif.drv_cb)
		while(!vif.drv_cb.WREADY) @(vif.drv_cb);
		if(hold) @(vif.drv_cb);
		vif.drv_cb.WVALID<=0;
	end
	endtask

	task drive_read(trans data2duv);
	begin
		@(vif.drv_cb);
		vif.drv_cb.ARADDR<=data2duv.ARADDR;
		vif.drv_cb.ARPROT<=data2duv.ARPROT;
		vif.drv_cb.ARVALID<=1;
		begin
			@(vif.drv_cb);
			while(!vif.drv_cb.ARREADY) @(vif.drv_cb);
		end
		vif.drv_cb.ARVALID<=0;
	end
	endtask
endclass
