//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2014 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arbitrator (
                                                                             // inputs:
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata,
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest,
                                                                              clk,
                                                                              cpu_0_data_master_address_to_slave,
                                                                              cpu_0_data_master_byteenable,
                                                                              cpu_0_data_master_read,
                                                                              cpu_0_data_master_waitrequest,
                                                                              cpu_0_data_master_write,
                                                                              cpu_0_data_master_writedata,
                                                                              reset_n,

                                                                             // outputs:
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_address,
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_byteenable,
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_chipselect,
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_read,
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa,
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reset_n,
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa,
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_write,
                                                                              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_writedata,
                                                                              cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave,
                                                                              cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave,
                                                                              cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave,
                                                                              cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave,
                                                                              d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer
                                                                           )
;

  output  [  7: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_address;
  output  [  3: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_byteenable;
  output           Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_chipselect;
  output           Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_read;
  output  [ 31: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa;
  output           Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reset_n;
  output           Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa;
  output           Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_write;
  output  [ 31: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_writedata;
  output           cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  output           cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  output           cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  output           cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  output           d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer;
  input   [ 31: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata;
  input            Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  7: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_address;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_allgrants;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_allow_new_arb_cycle;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_any_bursting_master_saved_grant;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_any_continuerequest;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_counter_enable;
  reg     [  2: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter;
  wire    [  2: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter_next_value;
  wire    [  2: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_set_values;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_beginbursttransfer_internal;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_begins_xfer;
  wire    [  3: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_byteenable;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_chipselect;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_firsttransfer;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_grant_vector;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_read_cycle;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_write_cycle;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_master_qreq_vector;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_non_bursting_master_requests;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_read;
  wire    [ 31: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa;
  reg              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reg_firsttransfer;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reset_n;
  reg              Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable2;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_unreg_firsttransfer;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waits_for_read;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waits_for_write;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_write;
  wire    [ 31: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  wire             cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  wire             cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  wire             cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  wire             cpu_0_data_master_saved_grant_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  reg              d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_from_cpu_0_data_master;
  wire             wait_for_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer;
    end


  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave));
  //assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata;

  assign cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave = ({cpu_0_data_master_address_to_slave[27 : 10] , 10'b0} == 28'h400) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter set values, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_set_values = 1;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_non_bursting_master_requests mux, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_non_bursting_master_requests = cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_any_bursting_master_saved_grant = 0;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter_next_value = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_firsttransfer ? (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_set_values - 1) : |Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter ? (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter - 1) : 0;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_allgrants all slave grants, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_allgrants = |Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_grant_vector;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer assignment, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer = ~(Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waits_for_read | Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer & (~Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave & Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_allgrants) | (end_xfer_arb_share_counter_term_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave & ~Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_non_bursting_master_requests);

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter <= 0;
      else if (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_counter_enable)
          Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter <= Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter_next_value;
    end


  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable <= 0;
      else if ((|Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_master_qreq_vector & end_xfer_arb_share_counter_term_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave) | (end_xfer_arb_share_counter_term_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave & ~Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_non_bursting_master_requests))
          Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable <= |Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master Altera_UP_SD_Card_Avalon_Interface_0/avalon_sdcard_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable2 = |Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arb_share_counter_next_value;

  //cpu_0/data_master Altera_UP_SD_Card_Avalon_Interface_0/avalon_sdcard_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave = cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest)) | ((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_writedata mux, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave = cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;

  //cpu_0/data_master saved-grant Altera_UP_SD_Card_Avalon_Interface_0/avalon_sdcard_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave = cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;

  //allow new arb cycle for Altera_UP_SD_Card_Avalon_Interface_0/avalon_sdcard_slave, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_master_qreq_vector = 1;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reset_n assignment, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reset_n = reset_n;

  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_chipselect = cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_firsttransfer first transaction, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_firsttransfer = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_begins_xfer ? Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_unreg_firsttransfer : Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reg_firsttransfer;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_unreg_firsttransfer = ~(Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_slavearbiterlockenable & Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_any_continuerequest);

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reg_firsttransfer <= 1'b1;
      else if (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_begins_xfer)
          Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reg_firsttransfer <= Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_unreg_firsttransfer;
    end


  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_beginbursttransfer_internal = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_begins_xfer;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_read assignment, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_read = cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave & cpu_0_data_master_read;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_write assignment, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_write = cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave & cpu_0_data_master_write;

  assign shifted_address_to_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_address mux, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_address = shifted_address_to_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_from_cpu_0_data_master >> 2;

  //d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer <= 1;
      else 
        d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer <= Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer;
    end


  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waits_for_read in a cycle, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waits_for_read = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_read_cycle & Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_read_cycle assignment, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_read_cycle = cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_read_cycle;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waits_for_write in a cycle, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waits_for_write = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_write_cycle & Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa;

  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_write_cycle assignment, which is an e_assign
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_write_cycle = cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_in_a_write_cycle;

  assign wait_for_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_counter = 0;
  //Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_byteenable byte enable port mux, which is an e_mux
  assign Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_byteenable = (cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //Altera_UP_SD_Card_Avalon_Interface_0/avalon_sdcard_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clocks_avalon_clocks_slave_arbitrator (
                                               // inputs:
                                                clk,
                                                clocks_avalon_clocks_slave_readdata,
                                                cpu_0_data_master_address_to_slave,
                                                cpu_0_data_master_dbs_address,
                                                cpu_0_data_master_read,
                                                cpu_0_data_master_write,
                                                reset_n,

                                               // outputs:
                                                clocks_avalon_clocks_slave_address,
                                                clocks_avalon_clocks_slave_readdata_from_sa,
                                                cpu_0_data_master_granted_clocks_avalon_clocks_slave,
                                                cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave,
                                                cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave,
                                                cpu_0_data_master_requests_clocks_avalon_clocks_slave,
                                                d1_clocks_avalon_clocks_slave_end_xfer,
                                                registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave
                                             )
;

  output           clocks_avalon_clocks_slave_address;
  output  [  7: 0] clocks_avalon_clocks_slave_readdata_from_sa;
  output           cpu_0_data_master_granted_clocks_avalon_clocks_slave;
  output           cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave;
  output           cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave;
  output           cpu_0_data_master_requests_clocks_avalon_clocks_slave;
  output           d1_clocks_avalon_clocks_slave_end_xfer;
  output           registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave;
  input            clk;
  input   [  7: 0] clocks_avalon_clocks_slave_readdata;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;

  wire             clocks_avalon_clocks_slave_address;
  wire             clocks_avalon_clocks_slave_allgrants;
  wire             clocks_avalon_clocks_slave_allow_new_arb_cycle;
  wire             clocks_avalon_clocks_slave_any_bursting_master_saved_grant;
  wire             clocks_avalon_clocks_slave_any_continuerequest;
  wire             clocks_avalon_clocks_slave_arb_counter_enable;
  reg     [  2: 0] clocks_avalon_clocks_slave_arb_share_counter;
  wire    [  2: 0] clocks_avalon_clocks_slave_arb_share_counter_next_value;
  wire    [  2: 0] clocks_avalon_clocks_slave_arb_share_set_values;
  wire             clocks_avalon_clocks_slave_beginbursttransfer_internal;
  wire             clocks_avalon_clocks_slave_begins_xfer;
  wire             clocks_avalon_clocks_slave_end_xfer;
  wire             clocks_avalon_clocks_slave_firsttransfer;
  wire             clocks_avalon_clocks_slave_grant_vector;
  wire             clocks_avalon_clocks_slave_in_a_read_cycle;
  wire             clocks_avalon_clocks_slave_in_a_write_cycle;
  wire             clocks_avalon_clocks_slave_master_qreq_vector;
  wire             clocks_avalon_clocks_slave_non_bursting_master_requests;
  wire    [  7: 0] clocks_avalon_clocks_slave_readdata_from_sa;
  reg              clocks_avalon_clocks_slave_reg_firsttransfer;
  reg              clocks_avalon_clocks_slave_slavearbiterlockenable;
  wire             clocks_avalon_clocks_slave_slavearbiterlockenable2;
  wire             clocks_avalon_clocks_slave_unreg_firsttransfer;
  wire             clocks_avalon_clocks_slave_waits_for_read;
  wire             clocks_avalon_clocks_slave_waits_for_write;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_clocks_avalon_clocks_slave;
  wire             cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave;
  wire             cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave;
  reg              cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register;
  wire             cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register_in;
  wire             cpu_0_data_master_requests_clocks_avalon_clocks_slave;
  wire             cpu_0_data_master_saved_grant_clocks_avalon_clocks_slave;
  reg              d1_clocks_avalon_clocks_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_clocks_avalon_clocks_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             p1_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register;
  wire             registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave;
  wire             wait_for_clocks_avalon_clocks_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~clocks_avalon_clocks_slave_end_xfer;
    end


  assign clocks_avalon_clocks_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave));
  //assign clocks_avalon_clocks_slave_readdata_from_sa = clocks_avalon_clocks_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clocks_avalon_clocks_slave_readdata_from_sa = clocks_avalon_clocks_slave_readdata;

  assign cpu_0_data_master_requests_clocks_avalon_clocks_slave = (({cpu_0_data_master_address_to_slave[27 : 1] , 1'b0} == 28'h28) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //registered rdv signal_name registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave assignment, which is an e_assign
  assign registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave = cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register_in;

  //clocks_avalon_clocks_slave_arb_share_counter set values, which is an e_mux
  assign clocks_avalon_clocks_slave_arb_share_set_values = (cpu_0_data_master_granted_clocks_avalon_clocks_slave)? 4 :
    1;

  //clocks_avalon_clocks_slave_non_bursting_master_requests mux, which is an e_mux
  assign clocks_avalon_clocks_slave_non_bursting_master_requests = cpu_0_data_master_requests_clocks_avalon_clocks_slave;

  //clocks_avalon_clocks_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign clocks_avalon_clocks_slave_any_bursting_master_saved_grant = 0;

  //clocks_avalon_clocks_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign clocks_avalon_clocks_slave_arb_share_counter_next_value = clocks_avalon_clocks_slave_firsttransfer ? (clocks_avalon_clocks_slave_arb_share_set_values - 1) : |clocks_avalon_clocks_slave_arb_share_counter ? (clocks_avalon_clocks_slave_arb_share_counter - 1) : 0;

  //clocks_avalon_clocks_slave_allgrants all slave grants, which is an e_mux
  assign clocks_avalon_clocks_slave_allgrants = |clocks_avalon_clocks_slave_grant_vector;

  //clocks_avalon_clocks_slave_end_xfer assignment, which is an e_assign
  assign clocks_avalon_clocks_slave_end_xfer = ~(clocks_avalon_clocks_slave_waits_for_read | clocks_avalon_clocks_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_clocks_avalon_clocks_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_clocks_avalon_clocks_slave = clocks_avalon_clocks_slave_end_xfer & (~clocks_avalon_clocks_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //clocks_avalon_clocks_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign clocks_avalon_clocks_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_clocks_avalon_clocks_slave & clocks_avalon_clocks_slave_allgrants) | (end_xfer_arb_share_counter_term_clocks_avalon_clocks_slave & ~clocks_avalon_clocks_slave_non_bursting_master_requests);

  //clocks_avalon_clocks_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clocks_avalon_clocks_slave_arb_share_counter <= 0;
      else if (clocks_avalon_clocks_slave_arb_counter_enable)
          clocks_avalon_clocks_slave_arb_share_counter <= clocks_avalon_clocks_slave_arb_share_counter_next_value;
    end


  //clocks_avalon_clocks_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clocks_avalon_clocks_slave_slavearbiterlockenable <= 0;
      else if ((|clocks_avalon_clocks_slave_master_qreq_vector & end_xfer_arb_share_counter_term_clocks_avalon_clocks_slave) | (end_xfer_arb_share_counter_term_clocks_avalon_clocks_slave & ~clocks_avalon_clocks_slave_non_bursting_master_requests))
          clocks_avalon_clocks_slave_slavearbiterlockenable <= |clocks_avalon_clocks_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master clocks/avalon_clocks_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = clocks_avalon_clocks_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //clocks_avalon_clocks_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign clocks_avalon_clocks_slave_slavearbiterlockenable2 = |clocks_avalon_clocks_slave_arb_share_counter_next_value;

  //cpu_0/data_master clocks/avalon_clocks_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = clocks_avalon_clocks_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //clocks_avalon_clocks_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign clocks_avalon_clocks_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave = cpu_0_data_master_requests_clocks_avalon_clocks_slave & ~((cpu_0_data_master_read & ((|cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register))));
  //cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register_in = cpu_0_data_master_granted_clocks_avalon_clocks_slave & cpu_0_data_master_read & ~clocks_avalon_clocks_slave_waits_for_read & ~(|cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register);

  //shift register p1 cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register = {cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register, cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register_in};

  //cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register <= 0;
      else 
        cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register <= p1_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register;
    end


  //local readdatavalid cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave, which is an e_mux
  assign cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave = cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave_shift_register;

  //master is always granted when requested
  assign cpu_0_data_master_granted_clocks_avalon_clocks_slave = cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave;

  //cpu_0/data_master saved-grant clocks/avalon_clocks_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_clocks_avalon_clocks_slave = cpu_0_data_master_requests_clocks_avalon_clocks_slave;

  //allow new arb cycle for clocks/avalon_clocks_slave, which is an e_assign
  assign clocks_avalon_clocks_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign clocks_avalon_clocks_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign clocks_avalon_clocks_slave_master_qreq_vector = 1;

  //clocks_avalon_clocks_slave_firsttransfer first transaction, which is an e_assign
  assign clocks_avalon_clocks_slave_firsttransfer = clocks_avalon_clocks_slave_begins_xfer ? clocks_avalon_clocks_slave_unreg_firsttransfer : clocks_avalon_clocks_slave_reg_firsttransfer;

  //clocks_avalon_clocks_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign clocks_avalon_clocks_slave_unreg_firsttransfer = ~(clocks_avalon_clocks_slave_slavearbiterlockenable & clocks_avalon_clocks_slave_any_continuerequest);

  //clocks_avalon_clocks_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clocks_avalon_clocks_slave_reg_firsttransfer <= 1'b1;
      else if (clocks_avalon_clocks_slave_begins_xfer)
          clocks_avalon_clocks_slave_reg_firsttransfer <= clocks_avalon_clocks_slave_unreg_firsttransfer;
    end


  //clocks_avalon_clocks_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign clocks_avalon_clocks_slave_beginbursttransfer_internal = clocks_avalon_clocks_slave_begins_xfer;

  //clocks_avalon_clocks_slave_address mux, which is an e_mux
  assign clocks_avalon_clocks_slave_address = {cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1 : 0]};

  //d1_clocks_avalon_clocks_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_clocks_avalon_clocks_slave_end_xfer <= 1;
      else 
        d1_clocks_avalon_clocks_slave_end_xfer <= clocks_avalon_clocks_slave_end_xfer;
    end


  //clocks_avalon_clocks_slave_waits_for_read in a cycle, which is an e_mux
  assign clocks_avalon_clocks_slave_waits_for_read = clocks_avalon_clocks_slave_in_a_read_cycle & 0;

  //clocks_avalon_clocks_slave_in_a_read_cycle assignment, which is an e_assign
  assign clocks_avalon_clocks_slave_in_a_read_cycle = cpu_0_data_master_granted_clocks_avalon_clocks_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = clocks_avalon_clocks_slave_in_a_read_cycle;

  //clocks_avalon_clocks_slave_waits_for_write in a cycle, which is an e_mux
  assign clocks_avalon_clocks_slave_waits_for_write = clocks_avalon_clocks_slave_in_a_write_cycle & 0;

  //clocks_avalon_clocks_slave_in_a_write_cycle assignment, which is an e_assign
  assign clocks_avalon_clocks_slave_in_a_write_cycle = cpu_0_data_master_granted_clocks_avalon_clocks_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = clocks_avalon_clocks_slave_in_a_write_cycle;

  assign wait_for_clocks_avalon_clocks_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clocks/avalon_clocks_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_jtag_debug_module_arbitrator (
                                            // inputs:
                                             clk,
                                             cpu_0_data_master_address_to_slave,
                                             cpu_0_data_master_byteenable,
                                             cpu_0_data_master_debugaccess,
                                             cpu_0_data_master_read,
                                             cpu_0_data_master_waitrequest,
                                             cpu_0_data_master_write,
                                             cpu_0_data_master_writedata,
                                             cpu_0_instruction_master_address_to_slave,
                                             cpu_0_instruction_master_read,
                                             cpu_0_jtag_debug_module_readdata,
                                             cpu_0_jtag_debug_module_resetrequest,
                                             reset_n,

                                            // outputs:
                                             cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_jtag_debug_module_address,
                                             cpu_0_jtag_debug_module_begintransfer,
                                             cpu_0_jtag_debug_module_byteenable,
                                             cpu_0_jtag_debug_module_chipselect,
                                             cpu_0_jtag_debug_module_debugaccess,
                                             cpu_0_jtag_debug_module_readdata_from_sa,
                                             cpu_0_jtag_debug_module_reset_n,
                                             cpu_0_jtag_debug_module_resetrequest_from_sa,
                                             cpu_0_jtag_debug_module_write,
                                             cpu_0_jtag_debug_module_writedata,
                                             d1_cpu_0_jtag_debug_module_end_xfer
                                          )
;

  output           cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  output  [  8: 0] cpu_0_jtag_debug_module_address;
  output           cpu_0_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_0_jtag_debug_module_byteenable;
  output           cpu_0_jtag_debug_module_chipselect;
  output           cpu_0_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  output           cpu_0_jtag_debug_module_reset_n;
  output           cpu_0_jtag_debug_module_resetrequest_from_sa;
  output           cpu_0_jtag_debug_module_write;
  output  [ 31: 0] cpu_0_jtag_debug_module_writedata;
  output           d1_cpu_0_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_debugaccess;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 27: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_read;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata;
  input            cpu_0_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_allgrants;
  wire             cpu_0_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_0_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_0_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_addend;
  wire             cpu_0_jtag_debug_module_arb_counter_enable;
  reg     [  2: 0] cpu_0_jtag_debug_module_arb_share_counter;
  wire    [  2: 0] cpu_0_jtag_debug_module_arb_share_counter_next_value;
  wire    [  2: 0] cpu_0_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_winner;
  wire             cpu_0_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_0_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_0_jtag_debug_module_begins_xfer;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_0_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_0_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire             cpu_0_jtag_debug_module_end_xfer;
  wire             cpu_0_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_0_jtag_debug_module_grant_vector;
  wire             cpu_0_jtag_debug_module_in_a_read_cycle;
  wire             cpu_0_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_0_jtag_debug_module_master_qreq_vector;
  wire             cpu_0_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  reg              cpu_0_jtag_debug_module_reg_firsttransfer;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_0_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_0_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_0_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_0_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_0_jtag_debug_module_waits_for_read;
  wire             cpu_0_jtag_debug_module_waits_for_write;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  reg              d1_cpu_0_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
  wire    [ 27: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master;
  wire    [ 27: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master;
  wire             wait_for_cpu_0_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_0_jtag_debug_module_end_xfer;
    end


  assign cpu_0_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module));
  //assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata;

  assign cpu_0_data_master_requests_cpu_0_jtag_debug_module = ({cpu_0_data_master_address_to_slave[27 : 11] , 11'b0} == 28'h800) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //cpu_0_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_0_jtag_debug_module_arb_share_set_values = 1;

  //cpu_0_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_0_jtag_debug_module_non_bursting_master_requests = cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module |
    cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_0_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_0_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_share_counter_next_value = cpu_0_jtag_debug_module_firsttransfer ? (cpu_0_jtag_debug_module_arb_share_set_values - 1) : |cpu_0_jtag_debug_module_arb_share_counter ? (cpu_0_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_0_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_0_jtag_debug_module_allgrants = (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector);

  //cpu_0_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_end_xfer = ~(cpu_0_jtag_debug_module_waits_for_read | cpu_0_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_end_xfer & (~cpu_0_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_0_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & cpu_0_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests);

  //cpu_0_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_0_jtag_debug_module_arb_counter_enable)
          cpu_0_jtag_debug_module_arb_share_counter <= cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_0_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests))
          cpu_0_jtag_debug_module_slavearbiterlockenable <= |cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //cpu_0_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_0_jtag_debug_module_slavearbiterlockenable2 = |cpu_0_jtag_debug_module_arb_share_counter_next_value;

  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_0_jtag_debug_module_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_data_master_requests_cpu_0_jtag_debug_module & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //cpu_0_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_0_jtag_debug_module_writedata = cpu_0_data_master_writedata;

  assign cpu_0_instruction_master_requests_cpu_0_jtag_debug_module = (({cpu_0_instruction_master_address_to_slave[27 : 11] , 11'b0} == 28'h800) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  assign cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_instruction_master_requests_cpu_0_jtag_debug_module & ~(cpu_0_data_master_arbiterlock);
  //allow new arb cycle for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/instruction_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[0];

  //cpu_0/instruction_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[0] && cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/data_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[1] = cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/data_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[1];

  //cpu_0/data_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[1] && cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_double_vector = {cpu_0_jtag_debug_module_master_qreq_vector, cpu_0_jtag_debug_module_master_qreq_vector} & ({~cpu_0_jtag_debug_module_master_qreq_vector, ~cpu_0_jtag_debug_module_master_qreq_vector} + cpu_0_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_0_jtag_debug_module_arb_winner = (cpu_0_jtag_debug_module_allow_new_arb_cycle & | cpu_0_jtag_debug_module_grant_vector) ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_0_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_0_jtag_debug_module_allow_new_arb_cycle)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= |cpu_0_jtag_debug_module_grant_vector ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_0_jtag_debug_module_grant_vector = {(cpu_0_jtag_debug_module_chosen_master_double_vector[1] | cpu_0_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_0_jtag_debug_module_chosen_master_double_vector[0] | cpu_0_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu_0/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_rot_left = (cpu_0_jtag_debug_module_arb_winner << 1) ? (cpu_0_jtag_debug_module_arb_winner << 1) : 1;

  //cpu_0/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_0_jtag_debug_module_grant_vector)
          cpu_0_jtag_debug_module_arb_addend <= cpu_0_jtag_debug_module_end_xfer? cpu_0_jtag_debug_module_chosen_master_rot_left : cpu_0_jtag_debug_module_grant_vector;
    end


  assign cpu_0_jtag_debug_module_begintransfer = cpu_0_jtag_debug_module_begins_xfer;
  //cpu_0_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_reset_n = reset_n;

  //assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest;

  assign cpu_0_jtag_debug_module_chipselect = cpu_0_data_master_granted_cpu_0_jtag_debug_module | cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  //cpu_0_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_firsttransfer = cpu_0_jtag_debug_module_begins_xfer ? cpu_0_jtag_debug_module_unreg_firsttransfer : cpu_0_jtag_debug_module_reg_firsttransfer;

  //cpu_0_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_unreg_firsttransfer = ~(cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_jtag_debug_module_any_continuerequest);

  //cpu_0_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_0_jtag_debug_module_begins_xfer)
          cpu_0_jtag_debug_module_reg_firsttransfer <= cpu_0_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_0_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_0_jtag_debug_module_beginbursttransfer_internal = cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_0_jtag_debug_module_arbitration_holdoff_internal = cpu_0_jtag_debug_module_begins_xfer & cpu_0_jtag_debug_module_firsttransfer;

  //cpu_0_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_0_jtag_debug_module_write = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //cpu_0_jtag_debug_module_address mux, which is an e_mux
  assign cpu_0_jtag_debug_module_address = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master >> 2) :
    (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_cpu_0_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_0_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_0_jtag_debug_module_end_xfer <= cpu_0_jtag_debug_module_end_xfer;
    end


  //cpu_0_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_read = cpu_0_jtag_debug_module_in_a_read_cycle & cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_read_cycle = (cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_0_jtag_debug_module_in_a_read_cycle;

  //cpu_0_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_write = cpu_0_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_0_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_write_cycle = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_0_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_0_jtag_debug_module_counter = 0;
  //cpu_0_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_0_jtag_debug_module_byteenable = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_0_jtag_debug_module_debugaccess = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_cpu_0_jtag_debug_module + cpu_0_instruction_master_granted_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module + cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_data_master_arbitrator (
                                      // inputs:
                                       Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa,
                                       Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa,
                                       clk,
                                       clocks_avalon_clocks_slave_readdata_from_sa,
                                       cpu_0_data_master_address,
                                       cpu_0_data_master_byteenable_nios_system_clock_1_in,
                                       cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave,
                                       cpu_0_data_master_granted_clocks_avalon_clocks_slave,
                                       cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_granted_input1_s1,
                                       cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_granted_nios_system_clock_0_in,
                                       cpu_0_data_master_granted_nios_system_clock_1_in,
                                       cpu_0_data_master_granted_onchip_memory2_0_s1,
                                       cpu_0_data_master_granted_output1_s1,
                                       cpu_0_data_master_granted_sdram_0_s1,
                                       cpu_0_data_master_granted_sysid_control_slave,
                                       cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave,
                                       cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave,
                                       cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_qualified_request_input1_s1,
                                       cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_qualified_request_nios_system_clock_0_in,
                                       cpu_0_data_master_qualified_request_nios_system_clock_1_in,
                                       cpu_0_data_master_qualified_request_onchip_memory2_0_s1,
                                       cpu_0_data_master_qualified_request_output1_s1,
                                       cpu_0_data_master_qualified_request_sdram_0_s1,
                                       cpu_0_data_master_qualified_request_sysid_control_slave,
                                       cpu_0_data_master_read,
                                       cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave,
                                       cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave,
                                       cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_read_data_valid_input1_s1,
                                       cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_read_data_valid_nios_system_clock_0_in,
                                       cpu_0_data_master_read_data_valid_nios_system_clock_1_in,
                                       cpu_0_data_master_read_data_valid_onchip_memory2_0_s1,
                                       cpu_0_data_master_read_data_valid_output1_s1,
                                       cpu_0_data_master_read_data_valid_sdram_0_s1,
                                       cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
                                       cpu_0_data_master_read_data_valid_sysid_control_slave,
                                       cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave,
                                       cpu_0_data_master_requests_clocks_avalon_clocks_slave,
                                       cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_requests_input1_s1,
                                       cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_requests_nios_system_clock_0_in,
                                       cpu_0_data_master_requests_nios_system_clock_1_in,
                                       cpu_0_data_master_requests_onchip_memory2_0_s1,
                                       cpu_0_data_master_requests_output1_s1,
                                       cpu_0_data_master_requests_sdram_0_s1,
                                       cpu_0_data_master_requests_sysid_control_slave,
                                       cpu_0_data_master_write,
                                       cpu_0_data_master_writedata,
                                       cpu_0_jtag_debug_module_readdata_from_sa,
                                       d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer,
                                       d1_clocks_avalon_clocks_slave_end_xfer,
                                       d1_cpu_0_jtag_debug_module_end_xfer,
                                       d1_input1_s1_end_xfer,
                                       d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                       d1_nios_system_clock_0_in_end_xfer,
                                       d1_nios_system_clock_1_in_end_xfer,
                                       d1_onchip_memory2_0_s1_end_xfer,
                                       d1_output1_s1_end_xfer,
                                       d1_sdram_0_s1_end_xfer,
                                       d1_sysid_control_slave_end_xfer,
                                       input1_s1_readdata_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                       nios_system_clock_0_in_readdata_from_sa,
                                       nios_system_clock_0_in_waitrequest_from_sa,
                                       nios_system_clock_1_in_readdata_from_sa,
                                       nios_system_clock_1_in_waitrequest_from_sa,
                                       onchip_memory2_0_s1_readdata_from_sa,
                                       output1_s1_readdata_from_sa,
                                       registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave,
                                       registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1,
                                       reset_n,
                                       sdram_0_s1_readdata_from_sa,
                                       sdram_0_s1_waitrequest_from_sa,
                                       sysid_control_slave_readdata_from_sa,

                                      // outputs:
                                       cpu_0_data_master_address_to_slave,
                                       cpu_0_data_master_dbs_address,
                                       cpu_0_data_master_dbs_write_8,
                                       cpu_0_data_master_irq,
                                       cpu_0_data_master_no_byte_enables_and_last_term,
                                       cpu_0_data_master_readdata,
                                       cpu_0_data_master_waitrequest
                                    )
;

  output  [ 27: 0] cpu_0_data_master_address_to_slave;
  output  [  1: 0] cpu_0_data_master_dbs_address;
  output  [  7: 0] cpu_0_data_master_dbs_write_8;
  output  [ 31: 0] cpu_0_data_master_irq;
  output           cpu_0_data_master_no_byte_enables_and_last_term;
  output  [ 31: 0] cpu_0_data_master_readdata;
  output           cpu_0_data_master_waitrequest;
  input   [ 31: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa;
  input            Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa;
  input            clk;
  input   [  7: 0] clocks_avalon_clocks_slave_readdata_from_sa;
  input   [ 27: 0] cpu_0_data_master_address;
  input            cpu_0_data_master_byteenable_nios_system_clock_1_in;
  input            cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  input            cpu_0_data_master_granted_clocks_avalon_clocks_slave;
  input            cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_granted_input1_s1;
  input            cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_granted_nios_system_clock_0_in;
  input            cpu_0_data_master_granted_nios_system_clock_1_in;
  input            cpu_0_data_master_granted_onchip_memory2_0_s1;
  input            cpu_0_data_master_granted_output1_s1;
  input            cpu_0_data_master_granted_sdram_0_s1;
  input            cpu_0_data_master_granted_sysid_control_slave;
  input            cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  input            cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave;
  input            cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_qualified_request_input1_s1;
  input            cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_qualified_request_nios_system_clock_0_in;
  input            cpu_0_data_master_qualified_request_nios_system_clock_1_in;
  input            cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  input            cpu_0_data_master_qualified_request_output1_s1;
  input            cpu_0_data_master_qualified_request_sdram_0_s1;
  input            cpu_0_data_master_qualified_request_sysid_control_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  input            cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave;
  input            cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_read_data_valid_input1_s1;
  input            cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_read_data_valid_nios_system_clock_0_in;
  input            cpu_0_data_master_read_data_valid_nios_system_clock_1_in;
  input            cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  input            cpu_0_data_master_read_data_valid_output1_s1;
  input            cpu_0_data_master_read_data_valid_sdram_0_s1;
  input            cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  input            cpu_0_data_master_read_data_valid_sysid_control_slave;
  input            cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  input            cpu_0_data_master_requests_clocks_avalon_clocks_slave;
  input            cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_requests_input1_s1;
  input            cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_requests_nios_system_clock_0_in;
  input            cpu_0_data_master_requests_nios_system_clock_1_in;
  input            cpu_0_data_master_requests_onchip_memory2_0_s1;
  input            cpu_0_data_master_requests_output1_s1;
  input            cpu_0_data_master_requests_sdram_0_s1;
  input            cpu_0_data_master_requests_sysid_control_slave;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer;
  input            d1_clocks_avalon_clocks_slave_end_xfer;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_input1_s1_end_xfer;
  input            d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  input            d1_nios_system_clock_0_in_end_xfer;
  input            d1_nios_system_clock_1_in_end_xfer;
  input            d1_onchip_memory2_0_s1_end_xfer;
  input            d1_output1_s1_end_xfer;
  input            d1_sdram_0_s1_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input   [ 31: 0] input1_s1_readdata_from_sa;
  input            jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  input   [ 31: 0] nios_system_clock_0_in_readdata_from_sa;
  input            nios_system_clock_0_in_waitrequest_from_sa;
  input   [  7: 0] nios_system_clock_1_in_readdata_from_sa;
  input            nios_system_clock_1_in_waitrequest_from_sa;
  input   [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  input   [ 31: 0] output1_s1_readdata_from_sa;
  input            registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave;
  input            registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  input            reset_n;
  input   [ 31: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;

  wire    [ 27: 0] cpu_0_data_master_address_to_slave;
  reg     [  1: 0] cpu_0_data_master_dbs_address;
  wire    [  1: 0] cpu_0_data_master_dbs_increment;
  wire    [  7: 0] cpu_0_data_master_dbs_write_8;
  wire    [ 31: 0] cpu_0_data_master_irq;
  reg              cpu_0_data_master_no_byte_enables_and_last_term;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_run;
  reg              cpu_0_data_master_waitrequest;
  reg     [  7: 0] dbs_8_reg_segment_0;
  reg     [  7: 0] dbs_8_reg_segment_1;
  reg     [  7: 0] dbs_8_reg_segment_2;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  wire             last_dbs_term_and_run;
  wire    [  1: 0] next_dbs_address;
  wire    [  7: 0] p1_dbs_8_reg_segment_0;
  wire    [  7: 0] p1_dbs_8_reg_segment_1;
  wire    [  7: 0] p1_dbs_8_reg_segment_2;
  wire    [ 31: 0] p1_registered_cpu_0_data_master_readdata;
  wire             pre_dbs_count_enable;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  reg     [ 31: 0] registered_cpu_0_data_master_readdata;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave | ~cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave) & ((~cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & ((cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave | (registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave & cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) | ~cpu_0_data_master_requests_clocks_avalon_clocks_slave)) & ((~cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave | ~cpu_0_data_master_read | (registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave & (cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave | ~cpu_0_data_master_write | (1 & (cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) & (cpu_0_data_master_granted_cpu_0_jtag_debug_module | ~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & ((~cpu_0_data_master_qualified_request_input1_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_input1_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write))));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_data_master_run = r_0 & r_1 & r_2;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_0_data_master_qualified_request_nios_system_clock_0_in | ~cpu_0_data_master_requests_nios_system_clock_0_in) & ((~cpu_0_data_master_qualified_request_nios_system_clock_0_in | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~nios_system_clock_0_in_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_nios_system_clock_0_in | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~nios_system_clock_0_in_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & ((cpu_0_data_master_qualified_request_nios_system_clock_1_in | ((cpu_0_data_master_write & !cpu_0_data_master_byteenable_nios_system_clock_1_in & cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0])) | ~cpu_0_data_master_requests_nios_system_clock_1_in)) & ((~cpu_0_data_master_qualified_request_nios_system_clock_1_in | ~cpu_0_data_master_read | (1 & ~nios_system_clock_1_in_waitrequest_from_sa & (cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_nios_system_clock_1_in | ~cpu_0_data_master_write | (1 & ~nios_system_clock_1_in_waitrequest_from_sa & (cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 | ~cpu_0_data_master_requests_onchip_memory2_0_s1) & (cpu_0_data_master_granted_onchip_memory2_0_s1 | ~cpu_0_data_master_qualified_request_onchip_memory2_0_s1) & ((~cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | ~cpu_0_data_master_read | (registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & (cpu_0_data_master_qualified_request_output1_s1 | ~cpu_0_data_master_requests_output1_s1) & ((~cpu_0_data_master_qualified_request_output1_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_output1_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_sdram_0_s1 | cpu_0_data_master_read_data_valid_sdram_0_s1 | ~cpu_0_data_master_requests_sdram_0_s1) & (cpu_0_data_master_granted_sdram_0_s1 | ~cpu_0_data_master_qualified_request_sdram_0_s1);

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = ((~cpu_0_data_master_qualified_request_sdram_0_s1 | ~cpu_0_data_master_read | (cpu_0_data_master_read_data_valid_sdram_0_s1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_sdram_0_s1 | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~sdram_0_s1_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_data_master_address_to_slave = cpu_0_data_master_address[27 : 0];

  //unpredictable registered wait state incoming data, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          registered_cpu_0_data_master_readdata <= 0;
      else 
        registered_cpu_0_data_master_readdata <= p1_registered_cpu_0_data_master_readdata;
    end


  //registered readdata mux, which is an e_mux
  assign p1_registered_cpu_0_data_master_readdata = ({32 {~cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave}} | Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave}} | jtag_uart_0_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_nios_system_clock_0_in}} | nios_system_clock_0_in_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_nios_system_clock_1_in}} | {nios_system_clock_1_in_readdata_from_sa[7 : 0],
    dbs_8_reg_segment_2,
    dbs_8_reg_segment_1,
    dbs_8_reg_segment_0}) &
    ({32 {~cpu_0_data_master_requests_sdram_0_s1}} | sdram_0_s1_readdata_from_sa);

  //cpu_0/data_master readdata mux, which is an e_mux
  assign cpu_0_data_master_readdata = ({32 {~cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_clocks_avalon_clocks_slave}} | {clocks_avalon_clocks_slave_readdata_from_sa[7 : 0],
    dbs_8_reg_segment_2,
    dbs_8_reg_segment_1,
    dbs_8_reg_segment_0}) &
    ({32 {~cpu_0_data_master_requests_cpu_0_jtag_debug_module}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_input1_s1}} | input1_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_nios_system_clock_0_in}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_nios_system_clock_1_in}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_onchip_memory2_0_s1}} | onchip_memory2_0_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_output1_s1}} | output1_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_sdram_0_s1}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_sysid_control_slave}} | sysid_control_slave_readdata_from_sa);

  //actual waitrequest port, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_waitrequest <= ~0;
      else 
        cpu_0_data_master_waitrequest <= ~((~(cpu_0_data_master_read | cpu_0_data_master_write))? 0: (cpu_0_data_master_run & cpu_0_data_master_waitrequest));
    end


  //input to dbs-8 stored 0, which is an e_mux
  assign p1_dbs_8_reg_segment_0 = (cpu_0_data_master_requests_clocks_avalon_clocks_slave)? clocks_avalon_clocks_slave_readdata_from_sa :
    nios_system_clock_1_in_readdata_from_sa;

  //dbs register for dbs-8 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_8_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1 : 0]) == 0))
          dbs_8_reg_segment_0 <= p1_dbs_8_reg_segment_0;
    end


  //input to dbs-8 stored 1, which is an e_mux
  assign p1_dbs_8_reg_segment_1 = (cpu_0_data_master_requests_clocks_avalon_clocks_slave)? clocks_avalon_clocks_slave_readdata_from_sa :
    nios_system_clock_1_in_readdata_from_sa;

  //dbs register for dbs-8 segment 1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_8_reg_segment_1 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1 : 0]) == 1))
          dbs_8_reg_segment_1 <= p1_dbs_8_reg_segment_1;
    end


  //input to dbs-8 stored 2, which is an e_mux
  assign p1_dbs_8_reg_segment_2 = (cpu_0_data_master_requests_clocks_avalon_clocks_slave)? clocks_avalon_clocks_slave_readdata_from_sa :
    nios_system_clock_1_in_readdata_from_sa;

  //dbs register for dbs-8 segment 2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_8_reg_segment_2 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1 : 0]) == 2))
          dbs_8_reg_segment_2 <= p1_dbs_8_reg_segment_2;
    end


  //dbs count increment, which is an e_mux
  assign cpu_0_data_master_dbs_increment = (cpu_0_data_master_requests_clocks_avalon_clocks_slave)? 1 :
    (cpu_0_data_master_requests_nios_system_clock_1_in)? 1 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_data_master_dbs_address + cpu_0_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable &
    (~(cpu_0_data_master_requests_clocks_avalon_clocks_slave & ~cpu_0_data_master_waitrequest & cpu_0_data_master_write)) &
    (~(cpu_0_data_master_requests_nios_system_clock_1_in & ~cpu_0_data_master_waitrequest));

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_data_master_dbs_address <= next_dbs_address;
    end


  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave |
    (cpu_0_data_master_granted_clocks_avalon_clocks_slave & cpu_0_data_master_write & 1 & 1) |
    (((~cpu_0_data_master_no_byte_enables_and_last_term) & cpu_0_data_master_requests_nios_system_clock_1_in & cpu_0_data_master_write & !cpu_0_data_master_byteenable_nios_system_clock_1_in)) |
    (cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_read & 1 & 1 & ~nios_system_clock_1_in_waitrequest_from_sa) |
    (cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_write & 1 & 1 & ~nios_system_clock_1_in_waitrequest_from_sa);

  //irq assign, which is an e_assign
  assign cpu_0_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    jtag_uart_0_avalon_jtag_slave_irq_from_sa};

  //no_byte_enables_and_last_term, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_no_byte_enables_and_last_term <= 0;
      else 
        cpu_0_data_master_no_byte_enables_and_last_term <= last_dbs_term_and_run;
    end


  //compute the last dbs term, which is an e_mux
  assign last_dbs_term_and_run = (cpu_0_data_master_dbs_address == 2'b11) & cpu_0_data_master_write & !cpu_0_data_master_byteenable_nios_system_clock_1_in;

  //mux write dbs 2, which is an e_mux
  assign cpu_0_data_master_dbs_write_8 = ((cpu_0_data_master_dbs_address[1 : 0] == 0))? cpu_0_data_master_writedata[7 : 0] :
    ((cpu_0_data_master_dbs_address[1 : 0] == 1))? cpu_0_data_master_writedata[15 : 8] :
    ((cpu_0_data_master_dbs_address[1 : 0] == 2))? cpu_0_data_master_writedata[23 : 16] :
    cpu_0_data_master_writedata[31 : 24];


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_instruction_master_arbitrator (
                                             // inputs:
                                              clk,
                                              cpu_0_instruction_master_address,
                                              cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_granted_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_granted_sdram_0_s1,
                                              cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_qualified_request_sdram_0_s1,
                                              cpu_0_instruction_master_read,
                                              cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_read_data_valid_sdram_0_s1,
                                              cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                              cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_requests_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_requests_sdram_0_s1,
                                              cpu_0_jtag_debug_module_readdata_from_sa,
                                              d1_cpu_0_jtag_debug_module_end_xfer,
                                              d1_onchip_memory2_0_s1_end_xfer,
                                              d1_sdram_0_s1_end_xfer,
                                              onchip_memory2_0_s1_readdata_from_sa,
                                              reset_n,
                                              sdram_0_s1_readdata_from_sa,
                                              sdram_0_s1_waitrequest_from_sa,

                                             // outputs:
                                              cpu_0_instruction_master_address_to_slave,
                                              cpu_0_instruction_master_readdata,
                                              cpu_0_instruction_master_waitrequest
                                           )
;

  output  [ 27: 0] cpu_0_instruction_master_address_to_slave;
  output  [ 31: 0] cpu_0_instruction_master_readdata;
  output           cpu_0_instruction_master_waitrequest;
  input            clk;
  input   [ 27: 0] cpu_0_instruction_master_address;
  input            cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_granted_sdram_0_s1;
  input            cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_qualified_request_sdram_0_s1;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  input            cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_requests_sdram_0_s1;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_onchip_memory2_0_s1_end_xfer;
  input            d1_sdram_0_s1_end_xfer;
  input   [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  input            reset_n;
  input   [ 31: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 27: 0] cpu_0_instruction_master_address_last_time;
  wire    [ 27: 0] cpu_0_instruction_master_address_to_slave;
  reg              cpu_0_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_run;
  wire             cpu_0_instruction_master_waitrequest;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) & (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_instruction_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_instruction_master_run = r_0 & r_1 & r_2;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 | cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1 | ~cpu_0_instruction_master_requests_onchip_memory2_0_s1) & (cpu_0_instruction_master_granted_onchip_memory2_0_s1 | ~cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1) & ((~cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 | ~cpu_0_instruction_master_read | (cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1 & cpu_0_instruction_master_read))) & 1 & (cpu_0_instruction_master_qualified_request_sdram_0_s1 | cpu_0_instruction_master_read_data_valid_sdram_0_s1 | ~cpu_0_instruction_master_requests_sdram_0_s1);

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = (cpu_0_instruction_master_granted_sdram_0_s1 | ~cpu_0_instruction_master_qualified_request_sdram_0_s1) & ((~cpu_0_instruction_master_qualified_request_sdram_0_s1 | ~cpu_0_instruction_master_read | (cpu_0_instruction_master_read_data_valid_sdram_0_s1 & cpu_0_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_instruction_master_address_to_slave = cpu_0_instruction_master_address[27 : 0];

  //cpu_0/instruction_master readdata mux, which is an e_mux
  assign cpu_0_instruction_master_readdata = ({32 {~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_0_instruction_master_requests_onchip_memory2_0_s1}} | onchip_memory2_0_s1_readdata_from_sa) &
    ({32 {~cpu_0_instruction_master_requests_sdram_0_s1}} | sdram_0_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_assign
  assign cpu_0_instruction_master_waitrequest = ~cpu_0_instruction_master_run;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_address_last_time <= 0;
      else 
        cpu_0_instruction_master_address_last_time <= cpu_0_instruction_master_address;
    end


  //cpu_0/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_instruction_master_waitrequest & (cpu_0_instruction_master_read);
    end


  //cpu_0_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_address != cpu_0_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_last_time <= 0;
      else 
        cpu_0_instruction_master_read_last_time <= cpu_0_instruction_master_read;
    end


  //cpu_0_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_read != cpu_0_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module input1_s1_arbitrator (
                              // inputs:
                               clk,
                               cpu_0_data_master_address_to_slave,
                               cpu_0_data_master_read,
                               cpu_0_data_master_write,
                               input1_s1_readdata,
                               reset_n,

                              // outputs:
                               cpu_0_data_master_granted_input1_s1,
                               cpu_0_data_master_qualified_request_input1_s1,
                               cpu_0_data_master_read_data_valid_input1_s1,
                               cpu_0_data_master_requests_input1_s1,
                               d1_input1_s1_end_xfer,
                               input1_s1_address,
                               input1_s1_readdata_from_sa,
                               input1_s1_reset_n
                            )
;

  output           cpu_0_data_master_granted_input1_s1;
  output           cpu_0_data_master_qualified_request_input1_s1;
  output           cpu_0_data_master_read_data_valid_input1_s1;
  output           cpu_0_data_master_requests_input1_s1;
  output           d1_input1_s1_end_xfer;
  output  [  1: 0] input1_s1_address;
  output  [ 31: 0] input1_s1_readdata_from_sa;
  output           input1_s1_reset_n;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] input1_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_input1_s1;
  wire             cpu_0_data_master_qualified_request_input1_s1;
  wire             cpu_0_data_master_read_data_valid_input1_s1;
  wire             cpu_0_data_master_requests_input1_s1;
  wire             cpu_0_data_master_saved_grant_input1_s1;
  reg              d1_input1_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_input1_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] input1_s1_address;
  wire             input1_s1_allgrants;
  wire             input1_s1_allow_new_arb_cycle;
  wire             input1_s1_any_bursting_master_saved_grant;
  wire             input1_s1_any_continuerequest;
  wire             input1_s1_arb_counter_enable;
  reg     [  2: 0] input1_s1_arb_share_counter;
  wire    [  2: 0] input1_s1_arb_share_counter_next_value;
  wire    [  2: 0] input1_s1_arb_share_set_values;
  wire             input1_s1_beginbursttransfer_internal;
  wire             input1_s1_begins_xfer;
  wire             input1_s1_end_xfer;
  wire             input1_s1_firsttransfer;
  wire             input1_s1_grant_vector;
  wire             input1_s1_in_a_read_cycle;
  wire             input1_s1_in_a_write_cycle;
  wire             input1_s1_master_qreq_vector;
  wire             input1_s1_non_bursting_master_requests;
  wire    [ 31: 0] input1_s1_readdata_from_sa;
  reg              input1_s1_reg_firsttransfer;
  wire             input1_s1_reset_n;
  reg              input1_s1_slavearbiterlockenable;
  wire             input1_s1_slavearbiterlockenable2;
  wire             input1_s1_unreg_firsttransfer;
  wire             input1_s1_waits_for_read;
  wire             input1_s1_waits_for_write;
  wire    [ 27: 0] shifted_address_to_input1_s1_from_cpu_0_data_master;
  wire             wait_for_input1_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~input1_s1_end_xfer;
    end


  assign input1_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_input1_s1));
  //assign input1_s1_readdata_from_sa = input1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign input1_s1_readdata_from_sa = input1_s1_readdata;

  assign cpu_0_data_master_requests_input1_s1 = (({cpu_0_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h10) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //input1_s1_arb_share_counter set values, which is an e_mux
  assign input1_s1_arb_share_set_values = 1;

  //input1_s1_non_bursting_master_requests mux, which is an e_mux
  assign input1_s1_non_bursting_master_requests = cpu_0_data_master_requests_input1_s1;

  //input1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign input1_s1_any_bursting_master_saved_grant = 0;

  //input1_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign input1_s1_arb_share_counter_next_value = input1_s1_firsttransfer ? (input1_s1_arb_share_set_values - 1) : |input1_s1_arb_share_counter ? (input1_s1_arb_share_counter - 1) : 0;

  //input1_s1_allgrants all slave grants, which is an e_mux
  assign input1_s1_allgrants = |input1_s1_grant_vector;

  //input1_s1_end_xfer assignment, which is an e_assign
  assign input1_s1_end_xfer = ~(input1_s1_waits_for_read | input1_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_input1_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_input1_s1 = input1_s1_end_xfer & (~input1_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //input1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign input1_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_input1_s1 & input1_s1_allgrants) | (end_xfer_arb_share_counter_term_input1_s1 & ~input1_s1_non_bursting_master_requests);

  //input1_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          input1_s1_arb_share_counter <= 0;
      else if (input1_s1_arb_counter_enable)
          input1_s1_arb_share_counter <= input1_s1_arb_share_counter_next_value;
    end


  //input1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          input1_s1_slavearbiterlockenable <= 0;
      else if ((|input1_s1_master_qreq_vector & end_xfer_arb_share_counter_term_input1_s1) | (end_xfer_arb_share_counter_term_input1_s1 & ~input1_s1_non_bursting_master_requests))
          input1_s1_slavearbiterlockenable <= |input1_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master input1/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = input1_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //input1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign input1_s1_slavearbiterlockenable2 = |input1_s1_arb_share_counter_next_value;

  //cpu_0/data_master input1/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = input1_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //input1_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign input1_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_input1_s1 = cpu_0_data_master_requests_input1_s1;
  //master is always granted when requested
  assign cpu_0_data_master_granted_input1_s1 = cpu_0_data_master_qualified_request_input1_s1;

  //cpu_0/data_master saved-grant input1/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_input1_s1 = cpu_0_data_master_requests_input1_s1;

  //allow new arb cycle for input1/s1, which is an e_assign
  assign input1_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign input1_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign input1_s1_master_qreq_vector = 1;

  //input1_s1_reset_n assignment, which is an e_assign
  assign input1_s1_reset_n = reset_n;

  //input1_s1_firsttransfer first transaction, which is an e_assign
  assign input1_s1_firsttransfer = input1_s1_begins_xfer ? input1_s1_unreg_firsttransfer : input1_s1_reg_firsttransfer;

  //input1_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign input1_s1_unreg_firsttransfer = ~(input1_s1_slavearbiterlockenable & input1_s1_any_continuerequest);

  //input1_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          input1_s1_reg_firsttransfer <= 1'b1;
      else if (input1_s1_begins_xfer)
          input1_s1_reg_firsttransfer <= input1_s1_unreg_firsttransfer;
    end


  //input1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign input1_s1_beginbursttransfer_internal = input1_s1_begins_xfer;

  assign shifted_address_to_input1_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //input1_s1_address mux, which is an e_mux
  assign input1_s1_address = shifted_address_to_input1_s1_from_cpu_0_data_master >> 2;

  //d1_input1_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_input1_s1_end_xfer <= 1;
      else 
        d1_input1_s1_end_xfer <= input1_s1_end_xfer;
    end


  //input1_s1_waits_for_read in a cycle, which is an e_mux
  assign input1_s1_waits_for_read = input1_s1_in_a_read_cycle & input1_s1_begins_xfer;

  //input1_s1_in_a_read_cycle assignment, which is an e_assign
  assign input1_s1_in_a_read_cycle = cpu_0_data_master_granted_input1_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = input1_s1_in_a_read_cycle;

  //input1_s1_waits_for_write in a cycle, which is an e_mux
  assign input1_s1_waits_for_write = input1_s1_in_a_write_cycle & 0;

  //input1_s1_in_a_write_cycle assignment, which is an e_assign
  assign input1_s1_in_a_write_cycle = cpu_0_data_master_granted_input1_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = input1_s1_in_a_write_cycle;

  assign wait_for_input1_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //input1/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_0_avalon_jtag_slave_arbitrator (
                                                  // inputs:
                                                   clk,
                                                   cpu_0_data_master_address_to_slave,
                                                   cpu_0_data_master_read,
                                                   cpu_0_data_master_waitrequest,
                                                   cpu_0_data_master_write,
                                                   cpu_0_data_master_writedata,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable,
                                                   jtag_uart_0_avalon_jtag_slave_irq,
                                                   jtag_uart_0_avalon_jtag_slave_readdata,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest,
                                                   reset_n,

                                                  // outputs:
                                                   cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                                   d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                                   jtag_uart_0_avalon_jtag_slave_address,
                                                   jtag_uart_0_avalon_jtag_slave_chipselect,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_read_n,
                                                   jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_reset_n,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_write_n,
                                                   jtag_uart_0_avalon_jtag_slave_writedata
                                                )
;

  output           cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  output           d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  output           jtag_uart_0_avalon_jtag_slave_address;
  output           jtag_uart_0_avalon_jtag_slave_chipselect;
  output           jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_reset_n;
  output           jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            jtag_uart_0_avalon_jtag_slave_dataavailable;
  input            jtag_uart_0_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  input            jtag_uart_0_avalon_jtag_slave_readyfordata;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave;
  reg              d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_allgrants;
  wire             jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_0_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_0_avalon_jtag_slave_arb_counter_enable;
  reg     [  2: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter;
  wire    [  2: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  2: 0] jtag_uart_0_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_0_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  reg              jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [ 27: 0] shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master;
  wire             wait_for_jtag_uart_0_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_0_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave));
  //assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata;

  assign cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave = ({cpu_0_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h20) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_0_avalon_jtag_slave_firsttransfer ? (jtag_uart_0_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_0_avalon_jtag_slave_arb_share_counter ? (jtag_uart_0_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_0_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_allgrants = |jtag_uart_0_avalon_jtag_slave_grant_vector;

  //jtag_uart_0_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_end_xfer = ~(jtag_uart_0_avalon_jtag_slave_waits_for_read | jtag_uart_0_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave = jtag_uart_0_avalon_jtag_slave_end_xfer & (~jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & jtag_uart_0_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_0_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_0_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest)) | ((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //jtag_uart_0_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;

  //cpu_0/data_master saved-grant jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_0_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_0_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_0_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_0_avalon_jtag_slave_chipselect = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  //jtag_uart_0_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_firsttransfer = jtag_uart_0_avalon_jtag_slave_begins_xfer ? jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_0_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_0_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_0_avalon_jtag_slave_begins_xfer)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_0_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_0_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_read_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read);

  //~jtag_uart_0_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_write_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write);

  assign shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //jtag_uart_0_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_address = shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master >> 2;

  //d1_jtag_uart_0_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= 1;
      else 
        d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_0_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_read = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_read_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_0_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_write = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_write_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_0_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart_0/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_0_in_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_0_data_master_address_to_slave,
                                            cpu_0_data_master_byteenable,
                                            cpu_0_data_master_read,
                                            cpu_0_data_master_waitrequest,
                                            cpu_0_data_master_write,
                                            cpu_0_data_master_writedata,
                                            nios_system_clock_0_in_endofpacket,
                                            nios_system_clock_0_in_readdata,
                                            nios_system_clock_0_in_waitrequest,
                                            reset_n,

                                           // outputs:
                                            cpu_0_data_master_granted_nios_system_clock_0_in,
                                            cpu_0_data_master_qualified_request_nios_system_clock_0_in,
                                            cpu_0_data_master_read_data_valid_nios_system_clock_0_in,
                                            cpu_0_data_master_requests_nios_system_clock_0_in,
                                            d1_nios_system_clock_0_in_end_xfer,
                                            nios_system_clock_0_in_address,
                                            nios_system_clock_0_in_byteenable,
                                            nios_system_clock_0_in_endofpacket_from_sa,
                                            nios_system_clock_0_in_nativeaddress,
                                            nios_system_clock_0_in_read,
                                            nios_system_clock_0_in_readdata_from_sa,
                                            nios_system_clock_0_in_reset_n,
                                            nios_system_clock_0_in_waitrequest_from_sa,
                                            nios_system_clock_0_in_write,
                                            nios_system_clock_0_in_writedata
                                         )
;

  output           cpu_0_data_master_granted_nios_system_clock_0_in;
  output           cpu_0_data_master_qualified_request_nios_system_clock_0_in;
  output           cpu_0_data_master_read_data_valid_nios_system_clock_0_in;
  output           cpu_0_data_master_requests_nios_system_clock_0_in;
  output           d1_nios_system_clock_0_in_end_xfer;
  output  [  2: 0] nios_system_clock_0_in_address;
  output  [  3: 0] nios_system_clock_0_in_byteenable;
  output           nios_system_clock_0_in_endofpacket_from_sa;
  output           nios_system_clock_0_in_nativeaddress;
  output           nios_system_clock_0_in_read;
  output  [ 31: 0] nios_system_clock_0_in_readdata_from_sa;
  output           nios_system_clock_0_in_reset_n;
  output           nios_system_clock_0_in_waitrequest_from_sa;
  output           nios_system_clock_0_in_write;
  output  [ 31: 0] nios_system_clock_0_in_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            nios_system_clock_0_in_endofpacket;
  input   [ 31: 0] nios_system_clock_0_in_readdata;
  input            nios_system_clock_0_in_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_nios_system_clock_0_in;
  wire             cpu_0_data_master_qualified_request_nios_system_clock_0_in;
  wire             cpu_0_data_master_read_data_valid_nios_system_clock_0_in;
  wire             cpu_0_data_master_requests_nios_system_clock_0_in;
  wire             cpu_0_data_master_saved_grant_nios_system_clock_0_in;
  reg              d1_nios_system_clock_0_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_nios_system_clock_0_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  2: 0] nios_system_clock_0_in_address;
  wire             nios_system_clock_0_in_allgrants;
  wire             nios_system_clock_0_in_allow_new_arb_cycle;
  wire             nios_system_clock_0_in_any_bursting_master_saved_grant;
  wire             nios_system_clock_0_in_any_continuerequest;
  wire             nios_system_clock_0_in_arb_counter_enable;
  reg     [  2: 0] nios_system_clock_0_in_arb_share_counter;
  wire    [  2: 0] nios_system_clock_0_in_arb_share_counter_next_value;
  wire    [  2: 0] nios_system_clock_0_in_arb_share_set_values;
  wire             nios_system_clock_0_in_beginbursttransfer_internal;
  wire             nios_system_clock_0_in_begins_xfer;
  wire    [  3: 0] nios_system_clock_0_in_byteenable;
  wire             nios_system_clock_0_in_end_xfer;
  wire             nios_system_clock_0_in_endofpacket_from_sa;
  wire             nios_system_clock_0_in_firsttransfer;
  wire             nios_system_clock_0_in_grant_vector;
  wire             nios_system_clock_0_in_in_a_read_cycle;
  wire             nios_system_clock_0_in_in_a_write_cycle;
  wire             nios_system_clock_0_in_master_qreq_vector;
  wire             nios_system_clock_0_in_nativeaddress;
  wire             nios_system_clock_0_in_non_bursting_master_requests;
  wire             nios_system_clock_0_in_read;
  wire    [ 31: 0] nios_system_clock_0_in_readdata_from_sa;
  reg              nios_system_clock_0_in_reg_firsttransfer;
  wire             nios_system_clock_0_in_reset_n;
  reg              nios_system_clock_0_in_slavearbiterlockenable;
  wire             nios_system_clock_0_in_slavearbiterlockenable2;
  wire             nios_system_clock_0_in_unreg_firsttransfer;
  wire             nios_system_clock_0_in_waitrequest_from_sa;
  wire             nios_system_clock_0_in_waits_for_read;
  wire             nios_system_clock_0_in_waits_for_write;
  wire             nios_system_clock_0_in_write;
  wire    [ 31: 0] nios_system_clock_0_in_writedata;
  wire             wait_for_nios_system_clock_0_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~nios_system_clock_0_in_end_xfer;
    end


  assign nios_system_clock_0_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_nios_system_clock_0_in));
  //assign nios_system_clock_0_in_readdata_from_sa = nios_system_clock_0_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_0_in_readdata_from_sa = nios_system_clock_0_in_readdata;

  assign cpu_0_data_master_requests_nios_system_clock_0_in = ({cpu_0_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h38) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign nios_system_clock_0_in_waitrequest_from_sa = nios_system_clock_0_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_0_in_waitrequest_from_sa = nios_system_clock_0_in_waitrequest;

  //nios_system_clock_0_in_arb_share_counter set values, which is an e_mux
  assign nios_system_clock_0_in_arb_share_set_values = 1;

  //nios_system_clock_0_in_non_bursting_master_requests mux, which is an e_mux
  assign nios_system_clock_0_in_non_bursting_master_requests = cpu_0_data_master_requests_nios_system_clock_0_in;

  //nios_system_clock_0_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign nios_system_clock_0_in_any_bursting_master_saved_grant = 0;

  //nios_system_clock_0_in_arb_share_counter_next_value assignment, which is an e_assign
  assign nios_system_clock_0_in_arb_share_counter_next_value = nios_system_clock_0_in_firsttransfer ? (nios_system_clock_0_in_arb_share_set_values - 1) : |nios_system_clock_0_in_arb_share_counter ? (nios_system_clock_0_in_arb_share_counter - 1) : 0;

  //nios_system_clock_0_in_allgrants all slave grants, which is an e_mux
  assign nios_system_clock_0_in_allgrants = |nios_system_clock_0_in_grant_vector;

  //nios_system_clock_0_in_end_xfer assignment, which is an e_assign
  assign nios_system_clock_0_in_end_xfer = ~(nios_system_clock_0_in_waits_for_read | nios_system_clock_0_in_waits_for_write);

  //end_xfer_arb_share_counter_term_nios_system_clock_0_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_nios_system_clock_0_in = nios_system_clock_0_in_end_xfer & (~nios_system_clock_0_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //nios_system_clock_0_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign nios_system_clock_0_in_arb_counter_enable = (end_xfer_arb_share_counter_term_nios_system_clock_0_in & nios_system_clock_0_in_allgrants) | (end_xfer_arb_share_counter_term_nios_system_clock_0_in & ~nios_system_clock_0_in_non_bursting_master_requests);

  //nios_system_clock_0_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_in_arb_share_counter <= 0;
      else if (nios_system_clock_0_in_arb_counter_enable)
          nios_system_clock_0_in_arb_share_counter <= nios_system_clock_0_in_arb_share_counter_next_value;
    end


  //nios_system_clock_0_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_in_slavearbiterlockenable <= 0;
      else if ((|nios_system_clock_0_in_master_qreq_vector & end_xfer_arb_share_counter_term_nios_system_clock_0_in) | (end_xfer_arb_share_counter_term_nios_system_clock_0_in & ~nios_system_clock_0_in_non_bursting_master_requests))
          nios_system_clock_0_in_slavearbiterlockenable <= |nios_system_clock_0_in_arb_share_counter_next_value;
    end


  //cpu_0/data_master nios_system_clock_0/in arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = nios_system_clock_0_in_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //nios_system_clock_0_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign nios_system_clock_0_in_slavearbiterlockenable2 = |nios_system_clock_0_in_arb_share_counter_next_value;

  //cpu_0/data_master nios_system_clock_0/in arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = nios_system_clock_0_in_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //nios_system_clock_0_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign nios_system_clock_0_in_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_nios_system_clock_0_in = cpu_0_data_master_requests_nios_system_clock_0_in & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest)) | ((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //nios_system_clock_0_in_writedata mux, which is an e_mux
  assign nios_system_clock_0_in_writedata = cpu_0_data_master_writedata;

  //assign nios_system_clock_0_in_endofpacket_from_sa = nios_system_clock_0_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_0_in_endofpacket_from_sa = nios_system_clock_0_in_endofpacket;

  //master is always granted when requested
  assign cpu_0_data_master_granted_nios_system_clock_0_in = cpu_0_data_master_qualified_request_nios_system_clock_0_in;

  //cpu_0/data_master saved-grant nios_system_clock_0/in, which is an e_assign
  assign cpu_0_data_master_saved_grant_nios_system_clock_0_in = cpu_0_data_master_requests_nios_system_clock_0_in;

  //allow new arb cycle for nios_system_clock_0/in, which is an e_assign
  assign nios_system_clock_0_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign nios_system_clock_0_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign nios_system_clock_0_in_master_qreq_vector = 1;

  //nios_system_clock_0_in_reset_n assignment, which is an e_assign
  assign nios_system_clock_0_in_reset_n = reset_n;

  //nios_system_clock_0_in_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_0_in_firsttransfer = nios_system_clock_0_in_begins_xfer ? nios_system_clock_0_in_unreg_firsttransfer : nios_system_clock_0_in_reg_firsttransfer;

  //nios_system_clock_0_in_unreg_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_0_in_unreg_firsttransfer = ~(nios_system_clock_0_in_slavearbiterlockenable & nios_system_clock_0_in_any_continuerequest);

  //nios_system_clock_0_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_in_reg_firsttransfer <= 1'b1;
      else if (nios_system_clock_0_in_begins_xfer)
          nios_system_clock_0_in_reg_firsttransfer <= nios_system_clock_0_in_unreg_firsttransfer;
    end


  //nios_system_clock_0_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign nios_system_clock_0_in_beginbursttransfer_internal = nios_system_clock_0_in_begins_xfer;

  //nios_system_clock_0_in_read assignment, which is an e_mux
  assign nios_system_clock_0_in_read = cpu_0_data_master_granted_nios_system_clock_0_in & cpu_0_data_master_read;

  //nios_system_clock_0_in_write assignment, which is an e_mux
  assign nios_system_clock_0_in_write = cpu_0_data_master_granted_nios_system_clock_0_in & cpu_0_data_master_write;

  //nios_system_clock_0_in_address mux, which is an e_mux
  assign nios_system_clock_0_in_address = cpu_0_data_master_address_to_slave;

  //slaveid nios_system_clock_0_in_nativeaddress nativeaddress mux, which is an e_mux
  assign nios_system_clock_0_in_nativeaddress = cpu_0_data_master_address_to_slave >> 2;

  //d1_nios_system_clock_0_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_nios_system_clock_0_in_end_xfer <= 1;
      else 
        d1_nios_system_clock_0_in_end_xfer <= nios_system_clock_0_in_end_xfer;
    end


  //nios_system_clock_0_in_waits_for_read in a cycle, which is an e_mux
  assign nios_system_clock_0_in_waits_for_read = nios_system_clock_0_in_in_a_read_cycle & nios_system_clock_0_in_waitrequest_from_sa;

  //nios_system_clock_0_in_in_a_read_cycle assignment, which is an e_assign
  assign nios_system_clock_0_in_in_a_read_cycle = cpu_0_data_master_granted_nios_system_clock_0_in & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = nios_system_clock_0_in_in_a_read_cycle;

  //nios_system_clock_0_in_waits_for_write in a cycle, which is an e_mux
  assign nios_system_clock_0_in_waits_for_write = nios_system_clock_0_in_in_a_write_cycle & nios_system_clock_0_in_waitrequest_from_sa;

  //nios_system_clock_0_in_in_a_write_cycle assignment, which is an e_assign
  assign nios_system_clock_0_in_in_a_write_cycle = cpu_0_data_master_granted_nios_system_clock_0_in & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = nios_system_clock_0_in_in_a_write_cycle;

  assign wait_for_nios_system_clock_0_in_counter = 0;
  //nios_system_clock_0_in_byteenable byte enable port mux, which is an e_mux
  assign nios_system_clock_0_in_byteenable = (cpu_0_data_master_granted_nios_system_clock_0_in)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_0/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_0_out_arbitrator (
                                            // inputs:
                                             clk,
                                             d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer,
                                             nios_system_clock_0_out_address,
                                             nios_system_clock_0_out_byteenable,
                                             nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave,
                                             nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave,
                                             nios_system_clock_0_out_read,
                                             nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave,
                                             nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave,
                                             nios_system_clock_0_out_write,
                                             nios_system_clock_0_out_writedata,
                                             reset_n,
                                             video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa,

                                            // outputs:
                                             nios_system_clock_0_out_address_to_slave,
                                             nios_system_clock_0_out_readdata,
                                             nios_system_clock_0_out_reset_n,
                                             nios_system_clock_0_out_waitrequest
                                          )
;

  output  [  2: 0] nios_system_clock_0_out_address_to_slave;
  output  [ 31: 0] nios_system_clock_0_out_readdata;
  output           nios_system_clock_0_out_reset_n;
  output           nios_system_clock_0_out_waitrequest;
  input            clk;
  input            d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer;
  input   [  2: 0] nios_system_clock_0_out_address;
  input   [  3: 0] nios_system_clock_0_out_byteenable;
  input            nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave;
  input            nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave;
  input            nios_system_clock_0_out_read;
  input            nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave;
  input            nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave;
  input            nios_system_clock_0_out_write;
  input   [ 31: 0] nios_system_clock_0_out_writedata;
  input            reset_n;
  input   [ 31: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa;

  reg              active_and_waiting_last_time;
  reg     [  2: 0] nios_system_clock_0_out_address_last_time;
  wire    [  2: 0] nios_system_clock_0_out_address_to_slave;
  reg     [  3: 0] nios_system_clock_0_out_byteenable_last_time;
  reg              nios_system_clock_0_out_read_last_time;
  wire    [ 31: 0] nios_system_clock_0_out_readdata;
  wire             nios_system_clock_0_out_reset_n;
  wire             nios_system_clock_0_out_run;
  wire             nios_system_clock_0_out_waitrequest;
  reg              nios_system_clock_0_out_write_last_time;
  reg     [ 31: 0] nios_system_clock_0_out_writedata_last_time;
  wire             r_2;
  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave | nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave | ~nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave) & ((~nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave | ~nios_system_clock_0_out_read | (nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave & nios_system_clock_0_out_read))) & ((~nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave | ~(nios_system_clock_0_out_read | nios_system_clock_0_out_write) | (1 & (nios_system_clock_0_out_read | nios_system_clock_0_out_write))));

  //cascaded wait assignment, which is an e_assign
  assign nios_system_clock_0_out_run = r_2;

  //optimize select-logic by passing only those address bits which matter.
  assign nios_system_clock_0_out_address_to_slave = nios_system_clock_0_out_address;

  //nios_system_clock_0/out readdata mux, which is an e_mux
  assign nios_system_clock_0_out_readdata = video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign nios_system_clock_0_out_waitrequest = ~nios_system_clock_0_out_run;

  //nios_system_clock_0_out_reset_n assignment, which is an e_assign
  assign nios_system_clock_0_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_0_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_address_last_time <= 0;
      else 
        nios_system_clock_0_out_address_last_time <= nios_system_clock_0_out_address;
    end


  //nios_system_clock_0/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= nios_system_clock_0_out_waitrequest & (nios_system_clock_0_out_read | nios_system_clock_0_out_write);
    end


  //nios_system_clock_0_out_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_address != nios_system_clock_0_out_address_last_time))
        begin
          $write("%0d ns: nios_system_clock_0_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_0_out_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_byteenable_last_time <= 0;
      else 
        nios_system_clock_0_out_byteenable_last_time <= nios_system_clock_0_out_byteenable;
    end


  //nios_system_clock_0_out_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_byteenable != nios_system_clock_0_out_byteenable_last_time))
        begin
          $write("%0d ns: nios_system_clock_0_out_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_0_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_read_last_time <= 0;
      else 
        nios_system_clock_0_out_read_last_time <= nios_system_clock_0_out_read;
    end


  //nios_system_clock_0_out_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_read != nios_system_clock_0_out_read_last_time))
        begin
          $write("%0d ns: nios_system_clock_0_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_0_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_write_last_time <= 0;
      else 
        nios_system_clock_0_out_write_last_time <= nios_system_clock_0_out_write;
    end


  //nios_system_clock_0_out_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_write != nios_system_clock_0_out_write_last_time))
        begin
          $write("%0d ns: nios_system_clock_0_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_0_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_writedata_last_time <= 0;
      else 
        nios_system_clock_0_out_writedata_last_time <= nios_system_clock_0_out_writedata;
    end


  //nios_system_clock_0_out_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_writedata != nios_system_clock_0_out_writedata_last_time) & nios_system_clock_0_out_write)
        begin
          $write("%0d ns: nios_system_clock_0_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_1_in_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_0_data_master_address_to_slave,
                                            cpu_0_data_master_byteenable,
                                            cpu_0_data_master_dbs_address,
                                            cpu_0_data_master_dbs_write_8,
                                            cpu_0_data_master_no_byte_enables_and_last_term,
                                            cpu_0_data_master_read,
                                            cpu_0_data_master_waitrequest,
                                            cpu_0_data_master_write,
                                            nios_system_clock_1_in_endofpacket,
                                            nios_system_clock_1_in_readdata,
                                            nios_system_clock_1_in_waitrequest,
                                            reset_n,

                                           // outputs:
                                            cpu_0_data_master_byteenable_nios_system_clock_1_in,
                                            cpu_0_data_master_granted_nios_system_clock_1_in,
                                            cpu_0_data_master_qualified_request_nios_system_clock_1_in,
                                            cpu_0_data_master_read_data_valid_nios_system_clock_1_in,
                                            cpu_0_data_master_requests_nios_system_clock_1_in,
                                            d1_nios_system_clock_1_in_end_xfer,
                                            nios_system_clock_1_in_address,
                                            nios_system_clock_1_in_endofpacket_from_sa,
                                            nios_system_clock_1_in_nativeaddress,
                                            nios_system_clock_1_in_read,
                                            nios_system_clock_1_in_readdata_from_sa,
                                            nios_system_clock_1_in_reset_n,
                                            nios_system_clock_1_in_waitrequest_from_sa,
                                            nios_system_clock_1_in_write,
                                            nios_system_clock_1_in_writedata
                                         )
;

  output           cpu_0_data_master_byteenable_nios_system_clock_1_in;
  output           cpu_0_data_master_granted_nios_system_clock_1_in;
  output           cpu_0_data_master_qualified_request_nios_system_clock_1_in;
  output           cpu_0_data_master_read_data_valid_nios_system_clock_1_in;
  output           cpu_0_data_master_requests_nios_system_clock_1_in;
  output           d1_nios_system_clock_1_in_end_xfer;
  output  [ 12: 0] nios_system_clock_1_in_address;
  output           nios_system_clock_1_in_endofpacket_from_sa;
  output  [ 12: 0] nios_system_clock_1_in_nativeaddress;
  output           nios_system_clock_1_in_read;
  output  [  7: 0] nios_system_clock_1_in_readdata_from_sa;
  output           nios_system_clock_1_in_reset_n;
  output           nios_system_clock_1_in_waitrequest_from_sa;
  output           nios_system_clock_1_in_write;
  output  [  7: 0] nios_system_clock_1_in_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input   [  7: 0] cpu_0_data_master_dbs_write_8;
  input            cpu_0_data_master_no_byte_enables_and_last_term;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input            nios_system_clock_1_in_endofpacket;
  input   [  7: 0] nios_system_clock_1_in_readdata;
  input            nios_system_clock_1_in_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_byteenable_nios_system_clock_1_in;
  wire             cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_0;
  wire             cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_1;
  wire             cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_2;
  wire             cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_3;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_nios_system_clock_1_in;
  wire             cpu_0_data_master_qualified_request_nios_system_clock_1_in;
  wire             cpu_0_data_master_read_data_valid_nios_system_clock_1_in;
  wire             cpu_0_data_master_requests_nios_system_clock_1_in;
  wire             cpu_0_data_master_saved_grant_nios_system_clock_1_in;
  reg              d1_nios_system_clock_1_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_nios_system_clock_1_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 12: 0] nios_system_clock_1_in_address;
  wire             nios_system_clock_1_in_allgrants;
  wire             nios_system_clock_1_in_allow_new_arb_cycle;
  wire             nios_system_clock_1_in_any_bursting_master_saved_grant;
  wire             nios_system_clock_1_in_any_continuerequest;
  wire             nios_system_clock_1_in_arb_counter_enable;
  reg     [  2: 0] nios_system_clock_1_in_arb_share_counter;
  wire    [  2: 0] nios_system_clock_1_in_arb_share_counter_next_value;
  wire    [  2: 0] nios_system_clock_1_in_arb_share_set_values;
  wire             nios_system_clock_1_in_beginbursttransfer_internal;
  wire             nios_system_clock_1_in_begins_xfer;
  wire             nios_system_clock_1_in_end_xfer;
  wire             nios_system_clock_1_in_endofpacket_from_sa;
  wire             nios_system_clock_1_in_firsttransfer;
  wire             nios_system_clock_1_in_grant_vector;
  wire             nios_system_clock_1_in_in_a_read_cycle;
  wire             nios_system_clock_1_in_in_a_write_cycle;
  wire             nios_system_clock_1_in_master_qreq_vector;
  wire    [ 12: 0] nios_system_clock_1_in_nativeaddress;
  wire             nios_system_clock_1_in_non_bursting_master_requests;
  wire             nios_system_clock_1_in_pretend_byte_enable;
  wire             nios_system_clock_1_in_read;
  wire    [  7: 0] nios_system_clock_1_in_readdata_from_sa;
  reg              nios_system_clock_1_in_reg_firsttransfer;
  wire             nios_system_clock_1_in_reset_n;
  reg              nios_system_clock_1_in_slavearbiterlockenable;
  wire             nios_system_clock_1_in_slavearbiterlockenable2;
  wire             nios_system_clock_1_in_unreg_firsttransfer;
  wire             nios_system_clock_1_in_waitrequest_from_sa;
  wire             nios_system_clock_1_in_waits_for_read;
  wire             nios_system_clock_1_in_waits_for_write;
  wire             nios_system_clock_1_in_write;
  wire    [  7: 0] nios_system_clock_1_in_writedata;
  wire             wait_for_nios_system_clock_1_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~nios_system_clock_1_in_end_xfer;
    end


  assign nios_system_clock_1_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_nios_system_clock_1_in));
  //assign nios_system_clock_1_in_readdata_from_sa = nios_system_clock_1_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_1_in_readdata_from_sa = nios_system_clock_1_in_readdata;

  assign cpu_0_data_master_requests_nios_system_clock_1_in = ({cpu_0_data_master_address_to_slave[27 : 13] , 13'b0} == 28'h2000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign nios_system_clock_1_in_waitrequest_from_sa = nios_system_clock_1_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_1_in_waitrequest_from_sa = nios_system_clock_1_in_waitrequest;

  //nios_system_clock_1_in_arb_share_counter set values, which is an e_mux
  assign nios_system_clock_1_in_arb_share_set_values = (cpu_0_data_master_granted_nios_system_clock_1_in)? 4 :
    1;

  //nios_system_clock_1_in_non_bursting_master_requests mux, which is an e_mux
  assign nios_system_clock_1_in_non_bursting_master_requests = cpu_0_data_master_requests_nios_system_clock_1_in;

  //nios_system_clock_1_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign nios_system_clock_1_in_any_bursting_master_saved_grant = 0;

  //nios_system_clock_1_in_arb_share_counter_next_value assignment, which is an e_assign
  assign nios_system_clock_1_in_arb_share_counter_next_value = nios_system_clock_1_in_firsttransfer ? (nios_system_clock_1_in_arb_share_set_values - 1) : |nios_system_clock_1_in_arb_share_counter ? (nios_system_clock_1_in_arb_share_counter - 1) : 0;

  //nios_system_clock_1_in_allgrants all slave grants, which is an e_mux
  assign nios_system_clock_1_in_allgrants = |nios_system_clock_1_in_grant_vector;

  //nios_system_clock_1_in_end_xfer assignment, which is an e_assign
  assign nios_system_clock_1_in_end_xfer = ~(nios_system_clock_1_in_waits_for_read | nios_system_clock_1_in_waits_for_write);

  //end_xfer_arb_share_counter_term_nios_system_clock_1_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_nios_system_clock_1_in = nios_system_clock_1_in_end_xfer & (~nios_system_clock_1_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //nios_system_clock_1_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign nios_system_clock_1_in_arb_counter_enable = (end_xfer_arb_share_counter_term_nios_system_clock_1_in & nios_system_clock_1_in_allgrants) | (end_xfer_arb_share_counter_term_nios_system_clock_1_in & ~nios_system_clock_1_in_non_bursting_master_requests);

  //nios_system_clock_1_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_in_arb_share_counter <= 0;
      else if (nios_system_clock_1_in_arb_counter_enable)
          nios_system_clock_1_in_arb_share_counter <= nios_system_clock_1_in_arb_share_counter_next_value;
    end


  //nios_system_clock_1_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_in_slavearbiterlockenable <= 0;
      else if ((|nios_system_clock_1_in_master_qreq_vector & end_xfer_arb_share_counter_term_nios_system_clock_1_in) | (end_xfer_arb_share_counter_term_nios_system_clock_1_in & ~nios_system_clock_1_in_non_bursting_master_requests))
          nios_system_clock_1_in_slavearbiterlockenable <= |nios_system_clock_1_in_arb_share_counter_next_value;
    end


  //cpu_0/data_master nios_system_clock_1/in arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = nios_system_clock_1_in_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //nios_system_clock_1_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign nios_system_clock_1_in_slavearbiterlockenable2 = |nios_system_clock_1_in_arb_share_counter_next_value;

  //cpu_0/data_master nios_system_clock_1/in arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = nios_system_clock_1_in_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //nios_system_clock_1_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign nios_system_clock_1_in_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_nios_system_clock_1_in = cpu_0_data_master_requests_nios_system_clock_1_in & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest)) | ((~cpu_0_data_master_waitrequest | cpu_0_data_master_no_byte_enables_and_last_term | !cpu_0_data_master_byteenable_nios_system_clock_1_in) & cpu_0_data_master_write));
  //nios_system_clock_1_in_writedata mux, which is an e_mux
  assign nios_system_clock_1_in_writedata = cpu_0_data_master_dbs_write_8;

  //assign nios_system_clock_1_in_endofpacket_from_sa = nios_system_clock_1_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_1_in_endofpacket_from_sa = nios_system_clock_1_in_endofpacket;

  //master is always granted when requested
  assign cpu_0_data_master_granted_nios_system_clock_1_in = cpu_0_data_master_qualified_request_nios_system_clock_1_in;

  //cpu_0/data_master saved-grant nios_system_clock_1/in, which is an e_assign
  assign cpu_0_data_master_saved_grant_nios_system_clock_1_in = cpu_0_data_master_requests_nios_system_clock_1_in;

  //allow new arb cycle for nios_system_clock_1/in, which is an e_assign
  assign nios_system_clock_1_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign nios_system_clock_1_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign nios_system_clock_1_in_master_qreq_vector = 1;

  //nios_system_clock_1_in_reset_n assignment, which is an e_assign
  assign nios_system_clock_1_in_reset_n = reset_n;

  //nios_system_clock_1_in_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_1_in_firsttransfer = nios_system_clock_1_in_begins_xfer ? nios_system_clock_1_in_unreg_firsttransfer : nios_system_clock_1_in_reg_firsttransfer;

  //nios_system_clock_1_in_unreg_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_1_in_unreg_firsttransfer = ~(nios_system_clock_1_in_slavearbiterlockenable & nios_system_clock_1_in_any_continuerequest);

  //nios_system_clock_1_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_in_reg_firsttransfer <= 1'b1;
      else if (nios_system_clock_1_in_begins_xfer)
          nios_system_clock_1_in_reg_firsttransfer <= nios_system_clock_1_in_unreg_firsttransfer;
    end


  //nios_system_clock_1_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign nios_system_clock_1_in_beginbursttransfer_internal = nios_system_clock_1_in_begins_xfer;

  //nios_system_clock_1_in_read assignment, which is an e_mux
  assign nios_system_clock_1_in_read = cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_read;

  //nios_system_clock_1_in_write assignment, which is an e_mux
  assign nios_system_clock_1_in_write = ((cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_write)) & nios_system_clock_1_in_pretend_byte_enable;

  //nios_system_clock_1_in_address mux, which is an e_mux
  assign nios_system_clock_1_in_address = {cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1 : 0]};

  //slaveid nios_system_clock_1_in_nativeaddress nativeaddress mux, which is an e_mux
  assign nios_system_clock_1_in_nativeaddress = cpu_0_data_master_address_to_slave >> 2;

  //d1_nios_system_clock_1_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_nios_system_clock_1_in_end_xfer <= 1;
      else 
        d1_nios_system_clock_1_in_end_xfer <= nios_system_clock_1_in_end_xfer;
    end


  //nios_system_clock_1_in_waits_for_read in a cycle, which is an e_mux
  assign nios_system_clock_1_in_waits_for_read = nios_system_clock_1_in_in_a_read_cycle & nios_system_clock_1_in_waitrequest_from_sa;

  //nios_system_clock_1_in_in_a_read_cycle assignment, which is an e_assign
  assign nios_system_clock_1_in_in_a_read_cycle = cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = nios_system_clock_1_in_in_a_read_cycle;

  //nios_system_clock_1_in_waits_for_write in a cycle, which is an e_mux
  assign nios_system_clock_1_in_waits_for_write = nios_system_clock_1_in_in_a_write_cycle & nios_system_clock_1_in_waitrequest_from_sa;

  //nios_system_clock_1_in_in_a_write_cycle assignment, which is an e_assign
  assign nios_system_clock_1_in_in_a_write_cycle = cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = nios_system_clock_1_in_in_a_write_cycle;

  assign wait_for_nios_system_clock_1_in_counter = 0;
  //nios_system_clock_1_in_pretend_byte_enable byte enable port mux, which is an e_mux
  assign nios_system_clock_1_in_pretend_byte_enable = (cpu_0_data_master_granted_nios_system_clock_1_in)? cpu_0_data_master_byteenable_nios_system_clock_1_in :
    -1;

  assign {cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_3,
cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_2,
cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_1,
cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_0} = cpu_0_data_master_byteenable;
  assign cpu_0_data_master_byteenable_nios_system_clock_1_in = ((cpu_0_data_master_dbs_address[1 : 0] == 0))? cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_0 :
    ((cpu_0_data_master_dbs_address[1 : 0] == 1))? cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_1 :
    ((cpu_0_data_master_dbs_address[1 : 0] == 2))? cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_2 :
    cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_3;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_1/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_1_out_arbitrator (
                                            // inputs:
                                             clk,
                                             d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer,
                                             nios_system_clock_1_out_address,
                                             nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave,
                                             nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave,
                                             nios_system_clock_1_out_read,
                                             nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave,
                                             nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave,
                                             nios_system_clock_1_out_write,
                                             nios_system_clock_1_out_writedata,
                                             reset_n,
                                             video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa,
                                             video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa,

                                            // outputs:
                                             nios_system_clock_1_out_address_to_slave,
                                             nios_system_clock_1_out_readdata,
                                             nios_system_clock_1_out_reset_n,
                                             nios_system_clock_1_out_waitrequest
                                          )
;

  output  [ 12: 0] nios_system_clock_1_out_address_to_slave;
  output  [  7: 0] nios_system_clock_1_out_readdata;
  output           nios_system_clock_1_out_reset_n;
  output           nios_system_clock_1_out_waitrequest;
  input            clk;
  input            d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer;
  input   [ 12: 0] nios_system_clock_1_out_address;
  input            nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  input            nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  input            nios_system_clock_1_out_read;
  input            nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  input            nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  input            nios_system_clock_1_out_write;
  input   [  7: 0] nios_system_clock_1_out_writedata;
  input            reset_n;
  input   [  7: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa;
  input            video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 12: 0] nios_system_clock_1_out_address_last_time;
  wire    [ 12: 0] nios_system_clock_1_out_address_to_slave;
  reg              nios_system_clock_1_out_read_last_time;
  wire    [  7: 0] nios_system_clock_1_out_readdata;
  wire             nios_system_clock_1_out_reset_n;
  wire             nios_system_clock_1_out_run;
  wire             nios_system_clock_1_out_waitrequest;
  reg              nios_system_clock_1_out_write_last_time;
  reg     [  7: 0] nios_system_clock_1_out_writedata_last_time;
  wire             r_2;
  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave | nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave | ~nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave) & ((~nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave | ~nios_system_clock_1_out_read | (nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave & nios_system_clock_1_out_read))) & ((~nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave | ~(nios_system_clock_1_out_read | nios_system_clock_1_out_write) | (1 & ~video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa & (nios_system_clock_1_out_read | nios_system_clock_1_out_write))));

  //cascaded wait assignment, which is an e_assign
  assign nios_system_clock_1_out_run = r_2;

  //optimize select-logic by passing only those address bits which matter.
  assign nios_system_clock_1_out_address_to_slave = nios_system_clock_1_out_address;

  //nios_system_clock_1/out readdata mux, which is an e_mux
  assign nios_system_clock_1_out_readdata = video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign nios_system_clock_1_out_waitrequest = ~nios_system_clock_1_out_run;

  //nios_system_clock_1_out_reset_n assignment, which is an e_assign
  assign nios_system_clock_1_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_1_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_address_last_time <= 0;
      else 
        nios_system_clock_1_out_address_last_time <= nios_system_clock_1_out_address;
    end


  //nios_system_clock_1/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= nios_system_clock_1_out_waitrequest & (nios_system_clock_1_out_read | nios_system_clock_1_out_write);
    end


  //nios_system_clock_1_out_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_1_out_address != nios_system_clock_1_out_address_last_time))
        begin
          $write("%0d ns: nios_system_clock_1_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_1_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_read_last_time <= 0;
      else 
        nios_system_clock_1_out_read_last_time <= nios_system_clock_1_out_read;
    end


  //nios_system_clock_1_out_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_1_out_read != nios_system_clock_1_out_read_last_time))
        begin
          $write("%0d ns: nios_system_clock_1_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_1_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_write_last_time <= 0;
      else 
        nios_system_clock_1_out_write_last_time <= nios_system_clock_1_out_write;
    end


  //nios_system_clock_1_out_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_1_out_write != nios_system_clock_1_out_write_last_time))
        begin
          $write("%0d ns: nios_system_clock_1_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_1_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_writedata_last_time <= 0;
      else 
        nios_system_clock_1_out_writedata_last_time <= nios_system_clock_1_out_writedata;
    end


  //nios_system_clock_1_out_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_1_out_writedata != nios_system_clock_1_out_writedata_last_time) & nios_system_clock_1_out_write)
        begin
          $write("%0d ns: nios_system_clock_1_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module onchip_memory2_0_s1_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_byteenable,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_waitrequest,
                                         cpu_0_data_master_write,
                                         cpu_0_data_master_writedata,
                                         cpu_0_instruction_master_address_to_slave,
                                         cpu_0_instruction_master_read,
                                         onchip_memory2_0_s1_readdata,
                                         reset_n,

                                        // outputs:
                                         cpu_0_data_master_granted_onchip_memory2_0_s1,
                                         cpu_0_data_master_qualified_request_onchip_memory2_0_s1,
                                         cpu_0_data_master_read_data_valid_onchip_memory2_0_s1,
                                         cpu_0_data_master_requests_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_granted_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_requests_onchip_memory2_0_s1,
                                         d1_onchip_memory2_0_s1_end_xfer,
                                         onchip_memory2_0_s1_address,
                                         onchip_memory2_0_s1_byteenable,
                                         onchip_memory2_0_s1_chipselect,
                                         onchip_memory2_0_s1_clken,
                                         onchip_memory2_0_s1_readdata_from_sa,
                                         onchip_memory2_0_s1_reset,
                                         onchip_memory2_0_s1_write,
                                         onchip_memory2_0_s1_writedata,
                                         registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1
                                      )
;

  output           cpu_0_data_master_granted_onchip_memory2_0_s1;
  output           cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  output           cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  output           cpu_0_data_master_requests_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  output           d1_onchip_memory2_0_s1_end_xfer;
  output  [ 11: 0] onchip_memory2_0_s1_address;
  output  [  3: 0] onchip_memory2_0_s1_byteenable;
  output           onchip_memory2_0_s1_chipselect;
  output           onchip_memory2_0_s1_clken;
  output  [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  output           onchip_memory2_0_s1_reset;
  output           onchip_memory2_0_s1_write;
  output  [ 31: 0] onchip_memory2_0_s1_writedata;
  output           registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 27: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_read;
  input   [ 31: 0] onchip_memory2_0_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  reg              cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in;
  wire             cpu_0_data_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_data_master_saved_grant_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  reg              cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in;
  wire             cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1;
  reg              d1_onchip_memory2_0_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_onchip_memory2_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1;
  wire    [ 11: 0] onchip_memory2_0_s1_address;
  wire             onchip_memory2_0_s1_allgrants;
  wire             onchip_memory2_0_s1_allow_new_arb_cycle;
  wire             onchip_memory2_0_s1_any_bursting_master_saved_grant;
  wire             onchip_memory2_0_s1_any_continuerequest;
  reg     [  1: 0] onchip_memory2_0_s1_arb_addend;
  wire             onchip_memory2_0_s1_arb_counter_enable;
  reg     [  2: 0] onchip_memory2_0_s1_arb_share_counter;
  wire    [  2: 0] onchip_memory2_0_s1_arb_share_counter_next_value;
  wire    [  2: 0] onchip_memory2_0_s1_arb_share_set_values;
  wire    [  1: 0] onchip_memory2_0_s1_arb_winner;
  wire             onchip_memory2_0_s1_arbitration_holdoff_internal;
  wire             onchip_memory2_0_s1_beginbursttransfer_internal;
  wire             onchip_memory2_0_s1_begins_xfer;
  wire    [  3: 0] onchip_memory2_0_s1_byteenable;
  wire             onchip_memory2_0_s1_chipselect;
  wire    [  3: 0] onchip_memory2_0_s1_chosen_master_double_vector;
  wire    [  1: 0] onchip_memory2_0_s1_chosen_master_rot_left;
  wire             onchip_memory2_0_s1_clken;
  wire             onchip_memory2_0_s1_end_xfer;
  wire             onchip_memory2_0_s1_firsttransfer;
  wire    [  1: 0] onchip_memory2_0_s1_grant_vector;
  wire             onchip_memory2_0_s1_in_a_read_cycle;
  wire             onchip_memory2_0_s1_in_a_write_cycle;
  wire    [  1: 0] onchip_memory2_0_s1_master_qreq_vector;
  wire             onchip_memory2_0_s1_non_bursting_master_requests;
  wire    [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  reg              onchip_memory2_0_s1_reg_firsttransfer;
  wire             onchip_memory2_0_s1_reset;
  reg     [  1: 0] onchip_memory2_0_s1_saved_chosen_master_vector;
  reg              onchip_memory2_0_s1_slavearbiterlockenable;
  wire             onchip_memory2_0_s1_slavearbiterlockenable2;
  wire             onchip_memory2_0_s1_unreg_firsttransfer;
  wire             onchip_memory2_0_s1_waits_for_read;
  wire             onchip_memory2_0_s1_waits_for_write;
  wire             onchip_memory2_0_s1_write;
  wire    [ 31: 0] onchip_memory2_0_s1_writedata;
  wire             p1_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             p1_cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  wire    [ 27: 0] shifted_address_to_onchip_memory2_0_s1_from_cpu_0_data_master;
  wire    [ 27: 0] shifted_address_to_onchip_memory2_0_s1_from_cpu_0_instruction_master;
  wire             wait_for_onchip_memory2_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~onchip_memory2_0_s1_end_xfer;
    end


  assign onchip_memory2_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1));
  //assign onchip_memory2_0_s1_readdata_from_sa = onchip_memory2_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign onchip_memory2_0_s1_readdata_from_sa = onchip_memory2_0_s1_readdata;

  assign cpu_0_data_master_requests_onchip_memory2_0_s1 = ({cpu_0_data_master_address_to_slave[27 : 14] , 14'b0} == 28'h10000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //registered rdv signal_name registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 assignment, which is an e_assign
  assign registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 = cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in;

  //onchip_memory2_0_s1_arb_share_counter set values, which is an e_mux
  assign onchip_memory2_0_s1_arb_share_set_values = 1;

  //onchip_memory2_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign onchip_memory2_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_onchip_memory2_0_s1 |
    cpu_0_instruction_master_requests_onchip_memory2_0_s1 |
    cpu_0_data_master_requests_onchip_memory2_0_s1 |
    cpu_0_instruction_master_requests_onchip_memory2_0_s1;

  //onchip_memory2_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign onchip_memory2_0_s1_any_bursting_master_saved_grant = 0;

  //onchip_memory2_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign onchip_memory2_0_s1_arb_share_counter_next_value = onchip_memory2_0_s1_firsttransfer ? (onchip_memory2_0_s1_arb_share_set_values - 1) : |onchip_memory2_0_s1_arb_share_counter ? (onchip_memory2_0_s1_arb_share_counter - 1) : 0;

  //onchip_memory2_0_s1_allgrants all slave grants, which is an e_mux
  assign onchip_memory2_0_s1_allgrants = (|onchip_memory2_0_s1_grant_vector) |
    (|onchip_memory2_0_s1_grant_vector) |
    (|onchip_memory2_0_s1_grant_vector) |
    (|onchip_memory2_0_s1_grant_vector);

  //onchip_memory2_0_s1_end_xfer assignment, which is an e_assign
  assign onchip_memory2_0_s1_end_xfer = ~(onchip_memory2_0_s1_waits_for_read | onchip_memory2_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_onchip_memory2_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_onchip_memory2_0_s1 = onchip_memory2_0_s1_end_xfer & (~onchip_memory2_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //onchip_memory2_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign onchip_memory2_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_onchip_memory2_0_s1 & onchip_memory2_0_s1_allgrants) | (end_xfer_arb_share_counter_term_onchip_memory2_0_s1 & ~onchip_memory2_0_s1_non_bursting_master_requests);

  //onchip_memory2_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_arb_share_counter <= 0;
      else if (onchip_memory2_0_s1_arb_counter_enable)
          onchip_memory2_0_s1_arb_share_counter <= onchip_memory2_0_s1_arb_share_counter_next_value;
    end


  //onchip_memory2_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_slavearbiterlockenable <= 0;
      else if ((|onchip_memory2_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_onchip_memory2_0_s1) | (end_xfer_arb_share_counter_term_onchip_memory2_0_s1 & ~onchip_memory2_0_s1_non_bursting_master_requests))
          onchip_memory2_0_s1_slavearbiterlockenable <= |onchip_memory2_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master onchip_memory2_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = onchip_memory2_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //onchip_memory2_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign onchip_memory2_0_s1_slavearbiterlockenable2 = |onchip_memory2_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master onchip_memory2_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = onchip_memory2_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master onchip_memory2_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = onchip_memory2_0_s1_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master onchip_memory2_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = onchip_memory2_0_s1_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted onchip_memory2_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1 <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1 <= cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1 ? 1 : (onchip_memory2_0_s1_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_onchip_memory2_0_s1) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1 & cpu_0_instruction_master_requests_onchip_memory2_0_s1;

  //onchip_memory2_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign onchip_memory2_0_s1_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_onchip_memory2_0_s1 = cpu_0_data_master_requests_onchip_memory2_0_s1 & ~((cpu_0_data_master_read & ((|cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register))) | ((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in = cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_read & ~onchip_memory2_0_s1_waits_for_read & ~(|cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register);

  //shift register p1 cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register = {cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register, cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in};

  //cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register <= 0;
      else 
        cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register <= p1_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;
    end


  //local readdatavalid cpu_0_data_master_read_data_valid_onchip_memory2_0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 = cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;

  //onchip_memory2_0_s1_writedata mux, which is an e_mux
  assign onchip_memory2_0_s1_writedata = cpu_0_data_master_writedata;

  //mux onchip_memory2_0_s1_clken, which is an e_mux
  assign onchip_memory2_0_s1_clken = 1'b1;

  assign cpu_0_instruction_master_requests_onchip_memory2_0_s1 = (({cpu_0_instruction_master_address_to_slave[27 : 14] , 14'b0} == 28'h10000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted onchip_memory2_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1 <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1 <= cpu_0_data_master_saved_grant_onchip_memory2_0_s1 ? 1 : (onchip_memory2_0_s1_arbitration_holdoff_internal | ~cpu_0_data_master_requests_onchip_memory2_0_s1) ? 0 : last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1 & cpu_0_data_master_requests_onchip_memory2_0_s1;

  assign cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 = cpu_0_instruction_master_requests_onchip_memory2_0_s1 & ~((cpu_0_instruction_master_read & ((|cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register))) | cpu_0_data_master_arbiterlock);
  //cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in = cpu_0_instruction_master_granted_onchip_memory2_0_s1 & cpu_0_instruction_master_read & ~onchip_memory2_0_s1_waits_for_read & ~(|cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register);

  //shift register p1 cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register = {cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register, cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in};

  //cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register <= 0;
      else 
        cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register <= p1_cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;
    end


  //local readdatavalid cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1 = cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;

  //allow new arb cycle for onchip_memory2_0/s1, which is an e_assign
  assign onchip_memory2_0_s1_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for onchip_memory2_0/s1, which is an e_assign
  assign onchip_memory2_0_s1_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;

  //cpu_0/instruction_master grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_instruction_master_granted_onchip_memory2_0_s1 = onchip_memory2_0_s1_grant_vector[0];

  //cpu_0/instruction_master saved-grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1 = onchip_memory2_0_s1_arb_winner[0] && cpu_0_instruction_master_requests_onchip_memory2_0_s1;

  //cpu_0/data_master assignment into master qualified-requests vector for onchip_memory2_0/s1, which is an e_assign
  assign onchip_memory2_0_s1_master_qreq_vector[1] = cpu_0_data_master_qualified_request_onchip_memory2_0_s1;

  //cpu_0/data_master grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_data_master_granted_onchip_memory2_0_s1 = onchip_memory2_0_s1_grant_vector[1];

  //cpu_0/data_master saved-grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_onchip_memory2_0_s1 = onchip_memory2_0_s1_arb_winner[1] && cpu_0_data_master_requests_onchip_memory2_0_s1;

  //onchip_memory2_0/s1 chosen-master double-vector, which is an e_assign
  assign onchip_memory2_0_s1_chosen_master_double_vector = {onchip_memory2_0_s1_master_qreq_vector, onchip_memory2_0_s1_master_qreq_vector} & ({~onchip_memory2_0_s1_master_qreq_vector, ~onchip_memory2_0_s1_master_qreq_vector} + onchip_memory2_0_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign onchip_memory2_0_s1_arb_winner = (onchip_memory2_0_s1_allow_new_arb_cycle & | onchip_memory2_0_s1_grant_vector) ? onchip_memory2_0_s1_grant_vector : onchip_memory2_0_s1_saved_chosen_master_vector;

  //saved onchip_memory2_0_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_saved_chosen_master_vector <= 0;
      else if (onchip_memory2_0_s1_allow_new_arb_cycle)
          onchip_memory2_0_s1_saved_chosen_master_vector <= |onchip_memory2_0_s1_grant_vector ? onchip_memory2_0_s1_grant_vector : onchip_memory2_0_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign onchip_memory2_0_s1_grant_vector = {(onchip_memory2_0_s1_chosen_master_double_vector[1] | onchip_memory2_0_s1_chosen_master_double_vector[3]),
    (onchip_memory2_0_s1_chosen_master_double_vector[0] | onchip_memory2_0_s1_chosen_master_double_vector[2])};

  //onchip_memory2_0/s1 chosen master rotated left, which is an e_assign
  assign onchip_memory2_0_s1_chosen_master_rot_left = (onchip_memory2_0_s1_arb_winner << 1) ? (onchip_memory2_0_s1_arb_winner << 1) : 1;

  //onchip_memory2_0/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_arb_addend <= 1;
      else if (|onchip_memory2_0_s1_grant_vector)
          onchip_memory2_0_s1_arb_addend <= onchip_memory2_0_s1_end_xfer? onchip_memory2_0_s1_chosen_master_rot_left : onchip_memory2_0_s1_grant_vector;
    end


  //~onchip_memory2_0_s1_reset assignment, which is an e_assign
  assign onchip_memory2_0_s1_reset = ~reset_n;

  assign onchip_memory2_0_s1_chipselect = cpu_0_data_master_granted_onchip_memory2_0_s1 | cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  //onchip_memory2_0_s1_firsttransfer first transaction, which is an e_assign
  assign onchip_memory2_0_s1_firsttransfer = onchip_memory2_0_s1_begins_xfer ? onchip_memory2_0_s1_unreg_firsttransfer : onchip_memory2_0_s1_reg_firsttransfer;

  //onchip_memory2_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign onchip_memory2_0_s1_unreg_firsttransfer = ~(onchip_memory2_0_s1_slavearbiterlockenable & onchip_memory2_0_s1_any_continuerequest);

  //onchip_memory2_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_reg_firsttransfer <= 1'b1;
      else if (onchip_memory2_0_s1_begins_xfer)
          onchip_memory2_0_s1_reg_firsttransfer <= onchip_memory2_0_s1_unreg_firsttransfer;
    end


  //onchip_memory2_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign onchip_memory2_0_s1_beginbursttransfer_internal = onchip_memory2_0_s1_begins_xfer;

  //onchip_memory2_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign onchip_memory2_0_s1_arbitration_holdoff_internal = onchip_memory2_0_s1_begins_xfer & onchip_memory2_0_s1_firsttransfer;

  //onchip_memory2_0_s1_write assignment, which is an e_mux
  assign onchip_memory2_0_s1_write = cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_write;

  assign shifted_address_to_onchip_memory2_0_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //onchip_memory2_0_s1_address mux, which is an e_mux
  assign onchip_memory2_0_s1_address = (cpu_0_data_master_granted_onchip_memory2_0_s1)? (shifted_address_to_onchip_memory2_0_s1_from_cpu_0_data_master >> 2) :
    (shifted_address_to_onchip_memory2_0_s1_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_onchip_memory2_0_s1_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_onchip_memory2_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_onchip_memory2_0_s1_end_xfer <= 1;
      else 
        d1_onchip_memory2_0_s1_end_xfer <= onchip_memory2_0_s1_end_xfer;
    end


  //onchip_memory2_0_s1_waits_for_read in a cycle, which is an e_mux
  assign onchip_memory2_0_s1_waits_for_read = onchip_memory2_0_s1_in_a_read_cycle & 0;

  //onchip_memory2_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign onchip_memory2_0_s1_in_a_read_cycle = (cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_onchip_memory2_0_s1 & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = onchip_memory2_0_s1_in_a_read_cycle;

  //onchip_memory2_0_s1_waits_for_write in a cycle, which is an e_mux
  assign onchip_memory2_0_s1_waits_for_write = onchip_memory2_0_s1_in_a_write_cycle & 0;

  //onchip_memory2_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign onchip_memory2_0_s1_in_a_write_cycle = cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = onchip_memory2_0_s1_in_a_write_cycle;

  assign wait_for_onchip_memory2_0_s1_counter = 0;
  //onchip_memory2_0_s1_byteenable byte enable port mux, which is an e_mux
  assign onchip_memory2_0_s1_byteenable = (cpu_0_data_master_granted_onchip_memory2_0_s1)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //onchip_memory2_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_onchip_memory2_0_s1 + cpu_0_instruction_master_granted_onchip_memory2_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_onchip_memory2_0_s1 + cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module output1_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_read,
                                cpu_0_data_master_waitrequest,
                                cpu_0_data_master_write,
                                cpu_0_data_master_writedata,
                                output1_s1_readdata,
                                reset_n,

                               // outputs:
                                cpu_0_data_master_granted_output1_s1,
                                cpu_0_data_master_qualified_request_output1_s1,
                                cpu_0_data_master_read_data_valid_output1_s1,
                                cpu_0_data_master_requests_output1_s1,
                                d1_output1_s1_end_xfer,
                                output1_s1_address,
                                output1_s1_chipselect,
                                output1_s1_readdata_from_sa,
                                output1_s1_reset_n,
                                output1_s1_write_n,
                                output1_s1_writedata
                             )
;

  output           cpu_0_data_master_granted_output1_s1;
  output           cpu_0_data_master_qualified_request_output1_s1;
  output           cpu_0_data_master_read_data_valid_output1_s1;
  output           cpu_0_data_master_requests_output1_s1;
  output           d1_output1_s1_end_xfer;
  output  [  1: 0] output1_s1_address;
  output           output1_s1_chipselect;
  output  [ 31: 0] output1_s1_readdata_from_sa;
  output           output1_s1_reset_n;
  output           output1_s1_write_n;
  output  [ 31: 0] output1_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] output1_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_output1_s1;
  wire             cpu_0_data_master_qualified_request_output1_s1;
  wire             cpu_0_data_master_read_data_valid_output1_s1;
  wire             cpu_0_data_master_requests_output1_s1;
  wire             cpu_0_data_master_saved_grant_output1_s1;
  reg              d1_output1_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_output1_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] output1_s1_address;
  wire             output1_s1_allgrants;
  wire             output1_s1_allow_new_arb_cycle;
  wire             output1_s1_any_bursting_master_saved_grant;
  wire             output1_s1_any_continuerequest;
  wire             output1_s1_arb_counter_enable;
  reg     [  2: 0] output1_s1_arb_share_counter;
  wire    [  2: 0] output1_s1_arb_share_counter_next_value;
  wire    [  2: 0] output1_s1_arb_share_set_values;
  wire             output1_s1_beginbursttransfer_internal;
  wire             output1_s1_begins_xfer;
  wire             output1_s1_chipselect;
  wire             output1_s1_end_xfer;
  wire             output1_s1_firsttransfer;
  wire             output1_s1_grant_vector;
  wire             output1_s1_in_a_read_cycle;
  wire             output1_s1_in_a_write_cycle;
  wire             output1_s1_master_qreq_vector;
  wire             output1_s1_non_bursting_master_requests;
  wire    [ 31: 0] output1_s1_readdata_from_sa;
  reg              output1_s1_reg_firsttransfer;
  wire             output1_s1_reset_n;
  reg              output1_s1_slavearbiterlockenable;
  wire             output1_s1_slavearbiterlockenable2;
  wire             output1_s1_unreg_firsttransfer;
  wire             output1_s1_waits_for_read;
  wire             output1_s1_waits_for_write;
  wire             output1_s1_write_n;
  wire    [ 31: 0] output1_s1_writedata;
  wire    [ 27: 0] shifted_address_to_output1_s1_from_cpu_0_data_master;
  wire             wait_for_output1_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~output1_s1_end_xfer;
    end


  assign output1_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_output1_s1));
  //assign output1_s1_readdata_from_sa = output1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign output1_s1_readdata_from_sa = output1_s1_readdata;

  assign cpu_0_data_master_requests_output1_s1 = ({cpu_0_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h0) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //output1_s1_arb_share_counter set values, which is an e_mux
  assign output1_s1_arb_share_set_values = 1;

  //output1_s1_non_bursting_master_requests mux, which is an e_mux
  assign output1_s1_non_bursting_master_requests = cpu_0_data_master_requests_output1_s1;

  //output1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign output1_s1_any_bursting_master_saved_grant = 0;

  //output1_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign output1_s1_arb_share_counter_next_value = output1_s1_firsttransfer ? (output1_s1_arb_share_set_values - 1) : |output1_s1_arb_share_counter ? (output1_s1_arb_share_counter - 1) : 0;

  //output1_s1_allgrants all slave grants, which is an e_mux
  assign output1_s1_allgrants = |output1_s1_grant_vector;

  //output1_s1_end_xfer assignment, which is an e_assign
  assign output1_s1_end_xfer = ~(output1_s1_waits_for_read | output1_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_output1_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_output1_s1 = output1_s1_end_xfer & (~output1_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //output1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign output1_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_output1_s1 & output1_s1_allgrants) | (end_xfer_arb_share_counter_term_output1_s1 & ~output1_s1_non_bursting_master_requests);

  //output1_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          output1_s1_arb_share_counter <= 0;
      else if (output1_s1_arb_counter_enable)
          output1_s1_arb_share_counter <= output1_s1_arb_share_counter_next_value;
    end


  //output1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          output1_s1_slavearbiterlockenable <= 0;
      else if ((|output1_s1_master_qreq_vector & end_xfer_arb_share_counter_term_output1_s1) | (end_xfer_arb_share_counter_term_output1_s1 & ~output1_s1_non_bursting_master_requests))
          output1_s1_slavearbiterlockenable <= |output1_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master output1/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = output1_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //output1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign output1_s1_slavearbiterlockenable2 = |output1_s1_arb_share_counter_next_value;

  //cpu_0/data_master output1/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = output1_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //output1_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign output1_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_output1_s1 = cpu_0_data_master_requests_output1_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //output1_s1_writedata mux, which is an e_mux
  assign output1_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_output1_s1 = cpu_0_data_master_qualified_request_output1_s1;

  //cpu_0/data_master saved-grant output1/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_output1_s1 = cpu_0_data_master_requests_output1_s1;

  //allow new arb cycle for output1/s1, which is an e_assign
  assign output1_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign output1_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign output1_s1_master_qreq_vector = 1;

  //output1_s1_reset_n assignment, which is an e_assign
  assign output1_s1_reset_n = reset_n;

  assign output1_s1_chipselect = cpu_0_data_master_granted_output1_s1;
  //output1_s1_firsttransfer first transaction, which is an e_assign
  assign output1_s1_firsttransfer = output1_s1_begins_xfer ? output1_s1_unreg_firsttransfer : output1_s1_reg_firsttransfer;

  //output1_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign output1_s1_unreg_firsttransfer = ~(output1_s1_slavearbiterlockenable & output1_s1_any_continuerequest);

  //output1_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          output1_s1_reg_firsttransfer <= 1'b1;
      else if (output1_s1_begins_xfer)
          output1_s1_reg_firsttransfer <= output1_s1_unreg_firsttransfer;
    end


  //output1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign output1_s1_beginbursttransfer_internal = output1_s1_begins_xfer;

  //~output1_s1_write_n assignment, which is an e_mux
  assign output1_s1_write_n = ~(cpu_0_data_master_granted_output1_s1 & cpu_0_data_master_write);

  assign shifted_address_to_output1_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //output1_s1_address mux, which is an e_mux
  assign output1_s1_address = shifted_address_to_output1_s1_from_cpu_0_data_master >> 2;

  //d1_output1_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_output1_s1_end_xfer <= 1;
      else 
        d1_output1_s1_end_xfer <= output1_s1_end_xfer;
    end


  //output1_s1_waits_for_read in a cycle, which is an e_mux
  assign output1_s1_waits_for_read = output1_s1_in_a_read_cycle & output1_s1_begins_xfer;

  //output1_s1_in_a_read_cycle assignment, which is an e_assign
  assign output1_s1_in_a_read_cycle = cpu_0_data_master_granted_output1_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = output1_s1_in_a_read_cycle;

  //output1_s1_waits_for_write in a cycle, which is an e_mux
  assign output1_s1_waits_for_write = output1_s1_in_a_write_cycle & 0;

  //output1_s1_in_a_write_cycle assignment, which is an e_assign
  assign output1_s1_in_a_write_cycle = cpu_0_data_master_granted_output1_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = output1_s1_in_a_write_cycle;

  assign wait_for_output1_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //output1/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module (
                                                             // inputs:
                                                              clear_fifo,
                                                              clk,
                                                              data_in,
                                                              read,
                                                              reset_n,
                                                              sync_reset,
                                                              write,

                                                             // outputs:
                                                              data_out,
                                                              empty,
                                                              fifo_contains_ones_n,
                                                              full
                                                           )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module (
                                                                    // inputs:
                                                                     clear_fifo,
                                                                     clk,
                                                                     data_in,
                                                                     read,
                                                                     reset_n,
                                                                     sync_reset,
                                                                     write,

                                                                    // outputs:
                                                                     data_out,
                                                                     empty,
                                                                     fifo_contains_ones_n,
                                                                     full
                                                                  )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_0_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_byteenable,
                                cpu_0_data_master_read,
                                cpu_0_data_master_waitrequest,
                                cpu_0_data_master_write,
                                cpu_0_data_master_writedata,
                                cpu_0_instruction_master_address_to_slave,
                                cpu_0_instruction_master_read,
                                reset_n,
                                sdram_0_s1_readdata,
                                sdram_0_s1_readdatavalid,
                                sdram_0_s1_waitrequest,

                               // outputs:
                                cpu_0_data_master_granted_sdram_0_s1,
                                cpu_0_data_master_qualified_request_sdram_0_s1,
                                cpu_0_data_master_read_data_valid_sdram_0_s1,
                                cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
                                cpu_0_data_master_requests_sdram_0_s1,
                                cpu_0_instruction_master_granted_sdram_0_s1,
                                cpu_0_instruction_master_qualified_request_sdram_0_s1,
                                cpu_0_instruction_master_read_data_valid_sdram_0_s1,
                                cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                cpu_0_instruction_master_requests_sdram_0_s1,
                                d1_sdram_0_s1_end_xfer,
                                sdram_0_s1_address,
                                sdram_0_s1_byteenable_n,
                                sdram_0_s1_chipselect,
                                sdram_0_s1_read_n,
                                sdram_0_s1_readdata_from_sa,
                                sdram_0_s1_reset_n,
                                sdram_0_s1_waitrequest_from_sa,
                                sdram_0_s1_write_n,
                                sdram_0_s1_writedata
                             )
;

  output           cpu_0_data_master_granted_sdram_0_s1;
  output           cpu_0_data_master_qualified_request_sdram_0_s1;
  output           cpu_0_data_master_read_data_valid_sdram_0_s1;
  output           cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  output           cpu_0_data_master_requests_sdram_0_s1;
  output           cpu_0_instruction_master_granted_sdram_0_s1;
  output           cpu_0_instruction_master_qualified_request_sdram_0_s1;
  output           cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  output           cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  output           cpu_0_instruction_master_requests_sdram_0_s1;
  output           d1_sdram_0_s1_end_xfer;
  output  [ 24: 0] sdram_0_s1_address;
  output  [  3: 0] sdram_0_s1_byteenable_n;
  output           sdram_0_s1_chipselect;
  output           sdram_0_s1_read_n;
  output  [ 31: 0] sdram_0_s1_readdata_from_sa;
  output           sdram_0_s1_reset_n;
  output           sdram_0_s1_waitrequest_from_sa;
  output           sdram_0_s1_write_n;
  output  [ 31: 0] sdram_0_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 27: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_read;
  input            reset_n;
  input   [ 31: 0] sdram_0_s1_readdata;
  input            sdram_0_s1_readdatavalid;
  input            sdram_0_s1_waitrequest;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sdram_0_s1;
  wire             cpu_0_data_master_qualified_request_sdram_0_s1;
  wire             cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  wire             cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_data_master_requests_sdram_0_s1;
  wire             cpu_0_data_master_saved_grant_sdram_0_s1;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_sdram_0_s1;
  wire             cpu_0_instruction_master_qualified_request_sdram_0_s1;
  wire             cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  wire             cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_instruction_master_requests_sdram_0_s1;
  wire             cpu_0_instruction_master_saved_grant_sdram_0_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_0_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1;
  wire    [ 24: 0] sdram_0_s1_address;
  wire             sdram_0_s1_allgrants;
  wire             sdram_0_s1_allow_new_arb_cycle;
  wire             sdram_0_s1_any_bursting_master_saved_grant;
  wire             sdram_0_s1_any_continuerequest;
  reg     [  1: 0] sdram_0_s1_arb_addend;
  wire             sdram_0_s1_arb_counter_enable;
  reg     [  2: 0] sdram_0_s1_arb_share_counter;
  wire    [  2: 0] sdram_0_s1_arb_share_counter_next_value;
  wire    [  2: 0] sdram_0_s1_arb_share_set_values;
  wire    [  1: 0] sdram_0_s1_arb_winner;
  wire             sdram_0_s1_arbitration_holdoff_internal;
  wire             sdram_0_s1_beginbursttransfer_internal;
  wire             sdram_0_s1_begins_xfer;
  wire    [  3: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire    [  3: 0] sdram_0_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_0_s1_chosen_master_rot_left;
  wire             sdram_0_s1_end_xfer;
  wire             sdram_0_s1_firsttransfer;
  wire    [  1: 0] sdram_0_s1_grant_vector;
  wire             sdram_0_s1_in_a_read_cycle;
  wire             sdram_0_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_0_s1_master_qreq_vector;
  wire             sdram_0_s1_move_on_to_next_transaction;
  wire             sdram_0_s1_non_bursting_master_requests;
  wire             sdram_0_s1_read_n;
  wire    [ 31: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid_from_sa;
  reg              sdram_0_s1_reg_firsttransfer;
  wire             sdram_0_s1_reset_n;
  reg     [  1: 0] sdram_0_s1_saved_chosen_master_vector;
  reg              sdram_0_s1_slavearbiterlockenable;
  wire             sdram_0_s1_slavearbiterlockenable2;
  wire             sdram_0_s1_unreg_firsttransfer;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_waits_for_read;
  wire             sdram_0_s1_waits_for_write;
  wire             sdram_0_s1_write_n;
  wire    [ 31: 0] sdram_0_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sdram_0_s1_from_cpu_0_data_master;
  wire    [ 27: 0] shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master;
  wire             wait_for_sdram_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sdram_0_s1_end_xfer;
    end


  assign sdram_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sdram_0_s1 | cpu_0_instruction_master_qualified_request_sdram_0_s1));
  //assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata;

  assign cpu_0_data_master_requests_sdram_0_s1 = ({cpu_0_data_master_address_to_slave[27] , 27'b0} == 28'h8000000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest;

  //assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid;

  //sdram_0_s1_arb_share_counter set values, which is an e_mux
  assign sdram_0_s1_arb_share_set_values = 1;

  //sdram_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_sdram_0_s1 |
    cpu_0_instruction_master_requests_sdram_0_s1 |
    cpu_0_data_master_requests_sdram_0_s1 |
    cpu_0_instruction_master_requests_sdram_0_s1;

  //sdram_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_0_s1_any_bursting_master_saved_grant = 0;

  //sdram_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_0_s1_arb_share_counter_next_value = sdram_0_s1_firsttransfer ? (sdram_0_s1_arb_share_set_values - 1) : |sdram_0_s1_arb_share_counter ? (sdram_0_s1_arb_share_counter - 1) : 0;

  //sdram_0_s1_allgrants all slave grants, which is an e_mux
  assign sdram_0_s1_allgrants = (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector);

  //sdram_0_s1_end_xfer assignment, which is an e_assign
  assign sdram_0_s1_end_xfer = ~(sdram_0_s1_waits_for_read | sdram_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_0_s1 = sdram_0_s1_end_xfer & (~sdram_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_0_s1 & sdram_0_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests);

  //sdram_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_share_counter <= 0;
      else if (sdram_0_s1_arb_counter_enable)
          sdram_0_s1_arb_share_counter <= sdram_0_s1_arb_share_counter_next_value;
    end


  //sdram_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_0_s1) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests))
          sdram_0_s1_slavearbiterlockenable <= |sdram_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master sdram_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sdram_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sdram_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_0_s1_slavearbiterlockenable2 = |sdram_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master sdram_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master sdram_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = sdram_0_s1_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master sdram_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= cpu_0_instruction_master_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_sdram_0_s1) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 & cpu_0_instruction_master_requests_sdram_0_s1;

  //sdram_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_0_s1_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_sdram_0_s1 = cpu_0_data_master_requests_sdram_0_s1 & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest | (|cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register))) | ((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //unique name for sdram_0_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_0_s1_move_on_to_next_transaction = sdram_0_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_0_data_master_granted_sdram_0_s1),
      .data_out             (cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_0_data_master_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register = ~cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid cpu_0_data_master_read_data_valid_sdram_0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1) & ~ cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;

  //sdram_0_s1_writedata mux, which is an e_mux
  assign sdram_0_s1_writedata = cpu_0_data_master_writedata;

  assign cpu_0_instruction_master_requests_sdram_0_s1 = (({cpu_0_instruction_master_address_to_slave[27] , 27'b0} == 28'h8000000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= cpu_0_data_master_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~cpu_0_data_master_requests_sdram_0_s1) ? 0 : last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 & cpu_0_data_master_requests_sdram_0_s1;

  assign cpu_0_instruction_master_qualified_request_sdram_0_s1 = cpu_0_instruction_master_requests_sdram_0_s1 & ~((cpu_0_instruction_master_read & ((|cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register))) | cpu_0_data_master_arbiterlock);
  //rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_0_instruction_master_granted_sdram_0_s1),
      .data_out             (cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register = ~cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid cpu_0_instruction_master_read_data_valid_sdram_0_s1, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1) & ~ cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;

  //allow new arb cycle for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_sdram_0_s1;

  //cpu_0/instruction_master grant sdram_0/s1, which is an e_assign
  assign cpu_0_instruction_master_granted_sdram_0_s1 = sdram_0_s1_grant_vector[0];

  //cpu_0/instruction_master saved-grant sdram_0/s1, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[0] && cpu_0_instruction_master_requests_sdram_0_s1;

  //cpu_0/data_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[1] = cpu_0_data_master_qualified_request_sdram_0_s1;

  //cpu_0/data_master grant sdram_0/s1, which is an e_assign
  assign cpu_0_data_master_granted_sdram_0_s1 = sdram_0_s1_grant_vector[1];

  //cpu_0/data_master saved-grant sdram_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[1] && cpu_0_data_master_requests_sdram_0_s1;

  //sdram_0/s1 chosen-master double-vector, which is an e_assign
  assign sdram_0_s1_chosen_master_double_vector = {sdram_0_s1_master_qreq_vector, sdram_0_s1_master_qreq_vector} & ({~sdram_0_s1_master_qreq_vector, ~sdram_0_s1_master_qreq_vector} + sdram_0_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_0_s1_arb_winner = (sdram_0_s1_allow_new_arb_cycle & | sdram_0_s1_grant_vector) ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;

  //saved sdram_0_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_saved_chosen_master_vector <= 0;
      else if (sdram_0_s1_allow_new_arb_cycle)
          sdram_0_s1_saved_chosen_master_vector <= |sdram_0_s1_grant_vector ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_0_s1_grant_vector = {(sdram_0_s1_chosen_master_double_vector[1] | sdram_0_s1_chosen_master_double_vector[3]),
    (sdram_0_s1_chosen_master_double_vector[0] | sdram_0_s1_chosen_master_double_vector[2])};

  //sdram_0/s1 chosen master rotated left, which is an e_assign
  assign sdram_0_s1_chosen_master_rot_left = (sdram_0_s1_arb_winner << 1) ? (sdram_0_s1_arb_winner << 1) : 1;

  //sdram_0/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_addend <= 1;
      else if (|sdram_0_s1_grant_vector)
          sdram_0_s1_arb_addend <= sdram_0_s1_end_xfer? sdram_0_s1_chosen_master_rot_left : sdram_0_s1_grant_vector;
    end


  //sdram_0_s1_reset_n assignment, which is an e_assign
  assign sdram_0_s1_reset_n = reset_n;

  assign sdram_0_s1_chipselect = cpu_0_data_master_granted_sdram_0_s1 | cpu_0_instruction_master_granted_sdram_0_s1;
  //sdram_0_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_firsttransfer = sdram_0_s1_begins_xfer ? sdram_0_s1_unreg_firsttransfer : sdram_0_s1_reg_firsttransfer;

  //sdram_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_unreg_firsttransfer = ~(sdram_0_s1_slavearbiterlockenable & sdram_0_s1_any_continuerequest);

  //sdram_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_0_s1_begins_xfer)
          sdram_0_s1_reg_firsttransfer <= sdram_0_s1_unreg_firsttransfer;
    end


  //sdram_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_0_s1_beginbursttransfer_internal = sdram_0_s1_begins_xfer;

  //sdram_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_0_s1_arbitration_holdoff_internal = sdram_0_s1_begins_xfer & sdram_0_s1_firsttransfer;

  //~sdram_0_s1_read_n assignment, which is an e_mux
  assign sdram_0_s1_read_n = ~((cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read));

  //~sdram_0_s1_write_n assignment, which is an e_mux
  assign sdram_0_s1_write_n = ~(cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write);

  assign shifted_address_to_sdram_0_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //sdram_0_s1_address mux, which is an e_mux
  assign sdram_0_s1_address = (cpu_0_data_master_granted_sdram_0_s1)? (shifted_address_to_sdram_0_s1_from_cpu_0_data_master >> 2) :
    (shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_sdram_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_0_s1_end_xfer <= 1;
      else 
        d1_sdram_0_s1_end_xfer <= sdram_0_s1_end_xfer;
    end


  //sdram_0_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_read = sdram_0_s1_in_a_read_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_read_cycle = (cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_0_s1_in_a_read_cycle;

  //sdram_0_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_write = sdram_0_s1_in_a_write_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_write_cycle = cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_0_s1_in_a_write_cycle;

  assign wait_for_sdram_0_s1_counter = 0;
  //~sdram_0_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_0_s1_byteenable_n = ~((cpu_0_data_master_granted_sdram_0_s1)? cpu_0_data_master_byteenable :
    -1);


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_sdram_0_s1 + cpu_0_instruction_master_granted_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_sdram_0_s1 + cpu_0_instruction_master_saved_grant_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         cpu_0_data_master_granted_sysid_control_slave,
                                         cpu_0_data_master_qualified_request_sysid_control_slave,
                                         cpu_0_data_master_read_data_valid_sysid_control_slave,
                                         cpu_0_data_master_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa,
                                         sysid_control_slave_reset_n
                                      )
;

  output           cpu_0_data_master_granted_sysid_control_slave;
  output           cpu_0_data_master_qualified_request_sysid_control_slave;
  output           cpu_0_data_master_read_data_valid_sysid_control_slave;
  output           cpu_0_data_master_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  output           sysid_control_slave_reset_n;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_sysid_control_slave_from_cpu_0_data_master;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg     [  2: 0] sysid_control_slave_arb_share_counter;
  wire    [  2: 0] sysid_control_slave_arb_share_counter_next_value;
  wire    [  2: 0] sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  wire             sysid_control_slave_reset_n;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign cpu_0_data_master_requests_sysid_control_slave = (({cpu_0_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h30) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = cpu_0_data_master_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master sysid/control_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sysid_control_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //cpu_0/data_master sysid/control_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave;
  //master is always granted when requested
  assign cpu_0_data_master_granted_sysid_control_slave = cpu_0_data_master_qualified_request_sysid_control_slave;

  //cpu_0/data_master saved-grant sysid/control_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_reset_n assignment, which is an e_assign
  assign sysid_control_slave_reset_n = reset_n;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  assign shifted_address_to_sysid_control_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = shifted_address_to_sysid_control_slave_from_cpu_0_data_master >> 2;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else 
        d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module video_character_buffer_with_dma_0_avalon_char_buffer_slave_arbitrator (
                                                                               // inputs:
                                                                                clk,
                                                                                nios_system_clock_1_out_address_to_slave,
                                                                                nios_system_clock_1_out_read,
                                                                                nios_system_clock_1_out_write,
                                                                                nios_system_clock_1_out_writedata,
                                                                                reset_n,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest,

                                                                               // outputs:
                                                                                d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer,
                                                                                nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave,
                                                                                nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave,
                                                                                nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave,
                                                                                nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_address,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_byteenable,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_chipselect,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_read,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_write,
                                                                                video_character_buffer_with_dma_0_avalon_char_buffer_slave_writedata
                                                                             )
;

  output           d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer;
  output           nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  output           nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  output           nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  output           nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  output  [ 12: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_address;
  output           video_character_buffer_with_dma_0_avalon_char_buffer_slave_byteenable;
  output           video_character_buffer_with_dma_0_avalon_char_buffer_slave_chipselect;
  output           video_character_buffer_with_dma_0_avalon_char_buffer_slave_read;
  output  [  7: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa;
  output           video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa;
  output           video_character_buffer_with_dma_0_avalon_char_buffer_slave_write;
  output  [  7: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_writedata;
  input            clk;
  input   [ 12: 0] nios_system_clock_1_out_address_to_slave;
  input            nios_system_clock_1_out_read;
  input            nios_system_clock_1_out_write;
  input   [  7: 0] nios_system_clock_1_out_writedata;
  input            reset_n;
  input   [  7: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata;
  input            video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest;

  reg              d1_reasons_to_wait;
  reg              d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             nios_system_clock_1_out_arbiterlock;
  wire             nios_system_clock_1_out_arbiterlock2;
  wire             nios_system_clock_1_out_continuerequest;
  wire             nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  wire             nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  wire             nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  reg              nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register;
  wire             nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register_in;
  wire             nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  wire             nios_system_clock_1_out_saved_grant_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  wire             p1_nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register;
  wire    [ 12: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_address;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_allgrants;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_allow_new_arb_cycle;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_any_bursting_master_saved_grant;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_any_continuerequest;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_counter_enable;
  reg              video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter_next_value;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_set_values;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_beginbursttransfer_internal;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_begins_xfer;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_byteenable;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_chipselect;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_firsttransfer;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_grant_vector;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_read_cycle;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_write_cycle;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_master_qreq_vector;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_non_bursting_master_requests;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_read;
  wire    [  7: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa;
  reg              video_character_buffer_with_dma_0_avalon_char_buffer_slave_reg_firsttransfer;
  reg              video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable2;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_unreg_firsttransfer;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_waits_for_read;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_waits_for_write;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_write;
  wire    [  7: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_writedata;
  wire             wait_for_video_character_buffer_with_dma_0_avalon_char_buffer_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer;
    end


  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_begins_xfer = ~d1_reasons_to_wait & ((nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave));
  //assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa = video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa = video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata;

  assign nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave = (1) & (nios_system_clock_1_out_read | nios_system_clock_1_out_write);
  //assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa = video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa = video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter set values, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_set_values = 1;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_non_bursting_master_requests mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_non_bursting_master_requests = nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_any_bursting_master_saved_grant = 0;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter_next_value = video_character_buffer_with_dma_0_avalon_char_buffer_slave_firsttransfer ? (video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_set_values - 1) : |video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter ? (video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter - 1) : 0;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_allgrants all slave grants, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_allgrants = |video_character_buffer_with_dma_0_avalon_char_buffer_slave_grant_vector;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer assignment, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer = ~(video_character_buffer_with_dma_0_avalon_char_buffer_slave_waits_for_read | video_character_buffer_with_dma_0_avalon_char_buffer_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_buffer_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_buffer_slave = video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer & (~video_character_buffer_with_dma_0_avalon_char_buffer_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_buffer_slave & video_character_buffer_with_dma_0_avalon_char_buffer_slave_allgrants) | (end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_buffer_slave & ~video_character_buffer_with_dma_0_avalon_char_buffer_slave_non_bursting_master_requests);

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter <= 0;
      else if (video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_counter_enable)
          video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter <= video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter_next_value;
    end


  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable <= 0;
      else if ((|video_character_buffer_with_dma_0_avalon_char_buffer_slave_master_qreq_vector & end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_buffer_slave) | (end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_buffer_slave & ~video_character_buffer_with_dma_0_avalon_char_buffer_slave_non_bursting_master_requests))
          video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable <= |video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter_next_value;
    end


  //nios_system_clock_1/out video_character_buffer_with_dma_0/avalon_char_buffer_slave arbiterlock, which is an e_assign
  assign nios_system_clock_1_out_arbiterlock = video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable & nios_system_clock_1_out_continuerequest;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable2 = |video_character_buffer_with_dma_0_avalon_char_buffer_slave_arb_share_counter_next_value;

  //nios_system_clock_1/out video_character_buffer_with_dma_0/avalon_char_buffer_slave arbiterlock2, which is an e_assign
  assign nios_system_clock_1_out_arbiterlock2 = video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable2 & nios_system_clock_1_out_continuerequest;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_any_continuerequest = 1;

  //nios_system_clock_1_out_continuerequest continued request, which is an e_assign
  assign nios_system_clock_1_out_continuerequest = 1;

  assign nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave = nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave & ~((nios_system_clock_1_out_read & ((|nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register))));
  //nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  assign nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register_in = nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave & nios_system_clock_1_out_read & ~video_character_buffer_with_dma_0_avalon_char_buffer_slave_waits_for_read & ~(|nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register);

  //shift register p1 nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register = {nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register, nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register_in};

  //nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register <= 0;
      else 
        nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register <= p1_nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register;
    end


  //local readdatavalid nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave, which is an e_mux
  assign nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave = nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave_shift_register;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_writedata mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_writedata = nios_system_clock_1_out_writedata;

  //master is always granted when requested
  assign nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave = nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave;

  //nios_system_clock_1/out saved-grant video_character_buffer_with_dma_0/avalon_char_buffer_slave, which is an e_assign
  assign nios_system_clock_1_out_saved_grant_video_character_buffer_with_dma_0_avalon_char_buffer_slave = nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave;

  //allow new arb cycle for video_character_buffer_with_dma_0/avalon_char_buffer_slave, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_master_qreq_vector = 1;

  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_chipselect = nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_firsttransfer first transaction, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_firsttransfer = video_character_buffer_with_dma_0_avalon_char_buffer_slave_begins_xfer ? video_character_buffer_with_dma_0_avalon_char_buffer_slave_unreg_firsttransfer : video_character_buffer_with_dma_0_avalon_char_buffer_slave_reg_firsttransfer;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_unreg_firsttransfer = ~(video_character_buffer_with_dma_0_avalon_char_buffer_slave_slavearbiterlockenable & video_character_buffer_with_dma_0_avalon_char_buffer_slave_any_continuerequest);

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          video_character_buffer_with_dma_0_avalon_char_buffer_slave_reg_firsttransfer <= 1'b1;
      else if (video_character_buffer_with_dma_0_avalon_char_buffer_slave_begins_xfer)
          video_character_buffer_with_dma_0_avalon_char_buffer_slave_reg_firsttransfer <= video_character_buffer_with_dma_0_avalon_char_buffer_slave_unreg_firsttransfer;
    end


  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_beginbursttransfer_internal = video_character_buffer_with_dma_0_avalon_char_buffer_slave_begins_xfer;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_read assignment, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_read = nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave & nios_system_clock_1_out_read;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_write assignment, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_write = nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave & nios_system_clock_1_out_write;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_address mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_address = nios_system_clock_1_out_address_to_slave;

  //d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer <= 1;
      else 
        d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer <= video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer;
    end


  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_waits_for_read in a cycle, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_waits_for_read = video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_read_cycle & video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_read_cycle assignment, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_read_cycle = nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave & nios_system_clock_1_out_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_read_cycle;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_waits_for_write in a cycle, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_waits_for_write = video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_write_cycle & video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa;

  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_write_cycle assignment, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_write_cycle = nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave & nios_system_clock_1_out_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = video_character_buffer_with_dma_0_avalon_char_buffer_slave_in_a_write_cycle;

  assign wait_for_video_character_buffer_with_dma_0_avalon_char_buffer_slave_counter = 0;
  //video_character_buffer_with_dma_0_avalon_char_buffer_slave_byteenable byte enable port mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_buffer_slave_byteenable = (nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave)? {1 {1'b1}} :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //video_character_buffer_with_dma_0/avalon_char_buffer_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module video_character_buffer_with_dma_0_avalon_char_control_slave_arbitrator (
                                                                                // inputs:
                                                                                 clk,
                                                                                 nios_system_clock_0_out_address_to_slave,
                                                                                 nios_system_clock_0_out_byteenable,
                                                                                 nios_system_clock_0_out_read,
                                                                                 nios_system_clock_0_out_write,
                                                                                 nios_system_clock_0_out_writedata,
                                                                                 reset_n,
                                                                                 video_character_buffer_with_dma_0_avalon_char_control_slave_readdata,

                                                                                // outputs:
                                                                                 d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer,
                                                                                 nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave,
                                                                                 nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave,
                                                                                 nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave,
                                                                                 nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave,
                                                                                 video_character_buffer_with_dma_0_avalon_char_control_slave_address,
                                                                                 video_character_buffer_with_dma_0_avalon_char_control_slave_byteenable,
                                                                                 video_character_buffer_with_dma_0_avalon_char_control_slave_chipselect,
                                                                                 video_character_buffer_with_dma_0_avalon_char_control_slave_read,
                                                                                 video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa,
                                                                                 video_character_buffer_with_dma_0_avalon_char_control_slave_reset,
                                                                                 video_character_buffer_with_dma_0_avalon_char_control_slave_write,
                                                                                 video_character_buffer_with_dma_0_avalon_char_control_slave_writedata
                                                                              )
;

  output           d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer;
  output           nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave;
  output           nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave;
  output           nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave;
  output           nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave;
  output           video_character_buffer_with_dma_0_avalon_char_control_slave_address;
  output  [  3: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_byteenable;
  output           video_character_buffer_with_dma_0_avalon_char_control_slave_chipselect;
  output           video_character_buffer_with_dma_0_avalon_char_control_slave_read;
  output  [ 31: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa;
  output           video_character_buffer_with_dma_0_avalon_char_control_slave_reset;
  output           video_character_buffer_with_dma_0_avalon_char_control_slave_write;
  output  [ 31: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_writedata;
  input            clk;
  input   [  2: 0] nios_system_clock_0_out_address_to_slave;
  input   [  3: 0] nios_system_clock_0_out_byteenable;
  input            nios_system_clock_0_out_read;
  input            nios_system_clock_0_out_write;
  input   [ 31: 0] nios_system_clock_0_out_writedata;
  input            reset_n;
  input   [ 31: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_readdata;

  reg              d1_reasons_to_wait;
  reg              d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             nios_system_clock_0_out_arbiterlock;
  wire             nios_system_clock_0_out_arbiterlock2;
  wire             nios_system_clock_0_out_continuerequest;
  wire             nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave;
  wire             nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave;
  wire             nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave;
  reg              nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register;
  wire             nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register_in;
  wire             nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave;
  wire             nios_system_clock_0_out_saved_grant_video_character_buffer_with_dma_0_avalon_char_control_slave;
  wire             p1_nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register;
  wire    [  2: 0] shifted_address_to_video_character_buffer_with_dma_0_avalon_char_control_slave_from_nios_system_clock_0_out;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_address;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_allgrants;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_allow_new_arb_cycle;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_any_bursting_master_saved_grant;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_any_continuerequest;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_arb_counter_enable;
  reg              video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter_next_value;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_set_values;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_beginbursttransfer_internal;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_begins_xfer;
  wire    [  3: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_byteenable;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_chipselect;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_firsttransfer;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_grant_vector;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_read_cycle;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_write_cycle;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_master_qreq_vector;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_non_bursting_master_requests;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_read;
  wire    [ 31: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa;
  reg              video_character_buffer_with_dma_0_avalon_char_control_slave_reg_firsttransfer;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_reset;
  reg              video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable2;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_unreg_firsttransfer;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_waits_for_read;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_waits_for_write;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_write;
  wire    [ 31: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_writedata;
  wire             wait_for_video_character_buffer_with_dma_0_avalon_char_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer;
    end


  assign video_character_buffer_with_dma_0_avalon_char_control_slave_begins_xfer = ~d1_reasons_to_wait & ((nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave));
  //assign video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa = video_character_buffer_with_dma_0_avalon_char_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa = video_character_buffer_with_dma_0_avalon_char_control_slave_readdata;

  assign nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave = (1) & (nios_system_clock_0_out_read | nios_system_clock_0_out_write);
  //video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter set values, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_set_values = 1;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_non_bursting_master_requests = nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_any_bursting_master_saved_grant = 0;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter_next_value = video_character_buffer_with_dma_0_avalon_char_control_slave_firsttransfer ? (video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_set_values - 1) : |video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter ? (video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter - 1) : 0;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_allgrants all slave grants, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_allgrants = |video_character_buffer_with_dma_0_avalon_char_control_slave_grant_vector;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer assignment, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer = ~(video_character_buffer_with_dma_0_avalon_char_control_slave_waits_for_read | video_character_buffer_with_dma_0_avalon_char_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_control_slave = video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer & (~video_character_buffer_with_dma_0_avalon_char_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_control_slave & video_character_buffer_with_dma_0_avalon_char_control_slave_allgrants) | (end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_control_slave & ~video_character_buffer_with_dma_0_avalon_char_control_slave_non_bursting_master_requests);

  //video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter <= 0;
      else if (video_character_buffer_with_dma_0_avalon_char_control_slave_arb_counter_enable)
          video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter <= video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter_next_value;
    end


  //video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable <= 0;
      else if ((|video_character_buffer_with_dma_0_avalon_char_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_control_slave) | (end_xfer_arb_share_counter_term_video_character_buffer_with_dma_0_avalon_char_control_slave & ~video_character_buffer_with_dma_0_avalon_char_control_slave_non_bursting_master_requests))
          video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable <= |video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter_next_value;
    end


  //nios_system_clock_0/out video_character_buffer_with_dma_0/avalon_char_control_slave arbiterlock, which is an e_assign
  assign nios_system_clock_0_out_arbiterlock = video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable & nios_system_clock_0_out_continuerequest;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable2 = |video_character_buffer_with_dma_0_avalon_char_control_slave_arb_share_counter_next_value;

  //nios_system_clock_0/out video_character_buffer_with_dma_0/avalon_char_control_slave arbiterlock2, which is an e_assign
  assign nios_system_clock_0_out_arbiterlock2 = video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable2 & nios_system_clock_0_out_continuerequest;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_any_continuerequest = 1;

  //nios_system_clock_0_out_continuerequest continued request, which is an e_assign
  assign nios_system_clock_0_out_continuerequest = 1;

  assign nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave = nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave & ~((nios_system_clock_0_out_read & ((|nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register))));
  //nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  assign nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register_in = nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave & nios_system_clock_0_out_read & ~video_character_buffer_with_dma_0_avalon_char_control_slave_waits_for_read & ~(|nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register);

  //shift register p1 nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register = {nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register, nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register_in};

  //nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register <= 0;
      else 
        nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register <= p1_nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register;
    end


  //local readdatavalid nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave, which is an e_mux
  assign nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave = nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave_shift_register;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_writedata mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_writedata = nios_system_clock_0_out_writedata;

  //master is always granted when requested
  assign nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave = nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave;

  //nios_system_clock_0/out saved-grant video_character_buffer_with_dma_0/avalon_char_control_slave, which is an e_assign
  assign nios_system_clock_0_out_saved_grant_video_character_buffer_with_dma_0_avalon_char_control_slave = nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave;

  //allow new arb cycle for video_character_buffer_with_dma_0/avalon_char_control_slave, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_master_qreq_vector = 1;

  //~video_character_buffer_with_dma_0_avalon_char_control_slave_reset assignment, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_reset = ~reset_n;

  assign video_character_buffer_with_dma_0_avalon_char_control_slave_chipselect = nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave;
  //video_character_buffer_with_dma_0_avalon_char_control_slave_firsttransfer first transaction, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_firsttransfer = video_character_buffer_with_dma_0_avalon_char_control_slave_begins_xfer ? video_character_buffer_with_dma_0_avalon_char_control_slave_unreg_firsttransfer : video_character_buffer_with_dma_0_avalon_char_control_slave_reg_firsttransfer;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_unreg_firsttransfer = ~(video_character_buffer_with_dma_0_avalon_char_control_slave_slavearbiterlockenable & video_character_buffer_with_dma_0_avalon_char_control_slave_any_continuerequest);

  //video_character_buffer_with_dma_0_avalon_char_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          video_character_buffer_with_dma_0_avalon_char_control_slave_reg_firsttransfer <= 1'b1;
      else if (video_character_buffer_with_dma_0_avalon_char_control_slave_begins_xfer)
          video_character_buffer_with_dma_0_avalon_char_control_slave_reg_firsttransfer <= video_character_buffer_with_dma_0_avalon_char_control_slave_unreg_firsttransfer;
    end


  //video_character_buffer_with_dma_0_avalon_char_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_beginbursttransfer_internal = video_character_buffer_with_dma_0_avalon_char_control_slave_begins_xfer;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_read assignment, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_read = nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave & nios_system_clock_0_out_read;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_write assignment, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_write = nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave & nios_system_clock_0_out_write;

  assign shifted_address_to_video_character_buffer_with_dma_0_avalon_char_control_slave_from_nios_system_clock_0_out = nios_system_clock_0_out_address_to_slave;
  //video_character_buffer_with_dma_0_avalon_char_control_slave_address mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_address = shifted_address_to_video_character_buffer_with_dma_0_avalon_char_control_slave_from_nios_system_clock_0_out >> 2;

  //d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer <= 1;
      else 
        d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer <= video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer;
    end


  //video_character_buffer_with_dma_0_avalon_char_control_slave_waits_for_read in a cycle, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_waits_for_read = video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_read_cycle & 0;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_read_cycle = nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave & nios_system_clock_0_out_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_read_cycle;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_waits_for_write in a cycle, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_waits_for_write = video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_write_cycle & 0;

  //video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_write_cycle = nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave & nios_system_clock_0_out_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = video_character_buffer_with_dma_0_avalon_char_control_slave_in_a_write_cycle;

  assign wait_for_video_character_buffer_with_dma_0_avalon_char_control_slave_counter = 0;
  //video_character_buffer_with_dma_0_avalon_char_control_slave_byteenable byte enable port mux, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_control_slave_byteenable = (nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave)? nios_system_clock_0_out_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //video_character_buffer_with_dma_0/avalon_char_control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module video_character_buffer_with_dma_0_avalon_char_source_arbitrator (
                                                                         // inputs:
                                                                          clk,
                                                                          reset_n,
                                                                          video_character_buffer_with_dma_0_avalon_char_source_data,
                                                                          video_character_buffer_with_dma_0_avalon_char_source_endofpacket,
                                                                          video_character_buffer_with_dma_0_avalon_char_source_startofpacket,
                                                                          video_character_buffer_with_dma_0_avalon_char_source_valid,
                                                                          video_vga_controller_0_avalon_vga_sink_ready_from_sa,

                                                                         // outputs:
                                                                          video_character_buffer_with_dma_0_avalon_char_source_ready
                                                                       )
;

  output           video_character_buffer_with_dma_0_avalon_char_source_ready;
  input            clk;
  input            reset_n;
  input   [ 29: 0] video_character_buffer_with_dma_0_avalon_char_source_data;
  input            video_character_buffer_with_dma_0_avalon_char_source_endofpacket;
  input            video_character_buffer_with_dma_0_avalon_char_source_startofpacket;
  input            video_character_buffer_with_dma_0_avalon_char_source_valid;
  input            video_vga_controller_0_avalon_vga_sink_ready_from_sa;

  wire             video_character_buffer_with_dma_0_avalon_char_source_ready;
  //mux video_character_buffer_with_dma_0_avalon_char_source_ready, which is an e_mux
  assign video_character_buffer_with_dma_0_avalon_char_source_ready = video_vga_controller_0_avalon_vga_sink_ready_from_sa;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module video_vga_controller_0_avalon_vga_sink_arbitrator (
                                                           // inputs:
                                                            clk,
                                                            reset_n,
                                                            video_character_buffer_with_dma_0_avalon_char_source_data,
                                                            video_character_buffer_with_dma_0_avalon_char_source_endofpacket,
                                                            video_character_buffer_with_dma_0_avalon_char_source_startofpacket,
                                                            video_character_buffer_with_dma_0_avalon_char_source_valid,
                                                            video_vga_controller_0_avalon_vga_sink_ready,

                                                           // outputs:
                                                            video_vga_controller_0_avalon_vga_sink_data,
                                                            video_vga_controller_0_avalon_vga_sink_endofpacket,
                                                            video_vga_controller_0_avalon_vga_sink_ready_from_sa,
                                                            video_vga_controller_0_avalon_vga_sink_reset,
                                                            video_vga_controller_0_avalon_vga_sink_startofpacket,
                                                            video_vga_controller_0_avalon_vga_sink_valid
                                                         )
;

  output  [ 29: 0] video_vga_controller_0_avalon_vga_sink_data;
  output           video_vga_controller_0_avalon_vga_sink_endofpacket;
  output           video_vga_controller_0_avalon_vga_sink_ready_from_sa;
  output           video_vga_controller_0_avalon_vga_sink_reset;
  output           video_vga_controller_0_avalon_vga_sink_startofpacket;
  output           video_vga_controller_0_avalon_vga_sink_valid;
  input            clk;
  input            reset_n;
  input   [ 29: 0] video_character_buffer_with_dma_0_avalon_char_source_data;
  input            video_character_buffer_with_dma_0_avalon_char_source_endofpacket;
  input            video_character_buffer_with_dma_0_avalon_char_source_startofpacket;
  input            video_character_buffer_with_dma_0_avalon_char_source_valid;
  input            video_vga_controller_0_avalon_vga_sink_ready;

  wire    [ 29: 0] video_vga_controller_0_avalon_vga_sink_data;
  wire             video_vga_controller_0_avalon_vga_sink_endofpacket;
  wire             video_vga_controller_0_avalon_vga_sink_ready_from_sa;
  wire             video_vga_controller_0_avalon_vga_sink_reset;
  wire             video_vga_controller_0_avalon_vga_sink_startofpacket;
  wire             video_vga_controller_0_avalon_vga_sink_valid;
  //mux video_vga_controller_0_avalon_vga_sink_data, which is an e_mux
  assign video_vga_controller_0_avalon_vga_sink_data = video_character_buffer_with_dma_0_avalon_char_source_data;

  //mux video_vga_controller_0_avalon_vga_sink_endofpacket, which is an e_mux
  assign video_vga_controller_0_avalon_vga_sink_endofpacket = video_character_buffer_with_dma_0_avalon_char_source_endofpacket;

  //assign video_vga_controller_0_avalon_vga_sink_ready_from_sa = video_vga_controller_0_avalon_vga_sink_ready so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign video_vga_controller_0_avalon_vga_sink_ready_from_sa = video_vga_controller_0_avalon_vga_sink_ready;

  //mux video_vga_controller_0_avalon_vga_sink_startofpacket, which is an e_mux
  assign video_vga_controller_0_avalon_vga_sink_startofpacket = video_character_buffer_with_dma_0_avalon_char_source_startofpacket;

  //mux video_vga_controller_0_avalon_vga_sink_valid, which is an e_mux
  assign video_vga_controller_0_avalon_vga_sink_valid = video_character_buffer_with_dma_0_avalon_char_source_valid;

  //~video_vga_controller_0_avalon_vga_sink_reset assignment, which is an e_assign
  assign video_vga_controller_0_avalon_vga_sink_reset = ~reset_n;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_reset_clk_0_domain_synch_module (
                                                     // inputs:
                                                      clk,
                                                      data_in,
                                                      reset_n,

                                                     // outputs:
                                                      data_out
                                                   )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_reset_vga_clock_domain_synch_module (
                                                         // inputs:
                                                          clk,
                                                          data_in,
                                                          reset_n,

                                                         // outputs:
                                                          data_out
                                                       )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system (
                     // 1) global signals:
                      clk_0,
                      clocks_SDRAM_CLK_out,
                      clocks_sys_clk_out,
                      reset_n,
                      vga_clock,

                     // the_Altera_UP_SD_Card_Avalon_Interface_0
                      b_SD_cmd_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0,
                      b_SD_dat3_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0,
                      b_SD_dat_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0,
                      o_SD_clock_from_the_Altera_UP_SD_Card_Avalon_Interface_0,

                     // the_input1
                      in_port_to_the_input1,

                     // the_output1
                      out_port_from_the_output1,

                     // the_sdram_0
                      zs_addr_from_the_sdram_0,
                      zs_ba_from_the_sdram_0,
                      zs_cas_n_from_the_sdram_0,
                      zs_cke_from_the_sdram_0,
                      zs_cs_n_from_the_sdram_0,
                      zs_dq_to_and_from_the_sdram_0,
                      zs_dqm_from_the_sdram_0,
                      zs_ras_n_from_the_sdram_0,
                      zs_we_n_from_the_sdram_0,

                     // the_video_vga_controller_0
                      VGA_BLANK_from_the_video_vga_controller_0,
                      VGA_B_from_the_video_vga_controller_0,
                      VGA_CLK_from_the_video_vga_controller_0,
                      VGA_G_from_the_video_vga_controller_0,
                      VGA_HS_from_the_video_vga_controller_0,
                      VGA_R_from_the_video_vga_controller_0,
                      VGA_SYNC_from_the_video_vga_controller_0,
                      VGA_VS_from_the_video_vga_controller_0
                   )
;

  output           VGA_BLANK_from_the_video_vga_controller_0;
  output  [  7: 0] VGA_B_from_the_video_vga_controller_0;
  output           VGA_CLK_from_the_video_vga_controller_0;
  output  [  7: 0] VGA_G_from_the_video_vga_controller_0;
  output           VGA_HS_from_the_video_vga_controller_0;
  output  [  7: 0] VGA_R_from_the_video_vga_controller_0;
  output           VGA_SYNC_from_the_video_vga_controller_0;
  output           VGA_VS_from_the_video_vga_controller_0;
  inout            b_SD_cmd_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  inout            b_SD_dat3_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  inout            b_SD_dat_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  output           clocks_SDRAM_CLK_out;
  output           clocks_sys_clk_out;
  output           o_SD_clock_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  output  [  7: 0] out_port_from_the_output1;
  output  [ 12: 0] zs_addr_from_the_sdram_0;
  output  [  1: 0] zs_ba_from_the_sdram_0;
  output           zs_cas_n_from_the_sdram_0;
  output           zs_cke_from_the_sdram_0;
  output           zs_cs_n_from_the_sdram_0;
  inout   [ 31: 0] zs_dq_to_and_from_the_sdram_0;
  output  [  3: 0] zs_dqm_from_the_sdram_0;
  output           zs_ras_n_from_the_sdram_0;
  output           zs_we_n_from_the_sdram_0;
  input            clk_0;
  input   [  7: 0] in_port_to_the_input1;
  input            reset_n;
  input            vga_clock;

  wire    [  7: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_address;
  wire    [  3: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_byteenable;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_chipselect;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_read;
  wire    [ 31: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata;
  wire    [ 31: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reset_n;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa;
  wire             Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_write;
  wire    [ 31: 0] Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_writedata;
  wire             VGA_BLANK_from_the_video_vga_controller_0;
  wire    [  7: 0] VGA_B_from_the_video_vga_controller_0;
  wire             VGA_CLK_from_the_video_vga_controller_0;
  wire    [  7: 0] VGA_G_from_the_video_vga_controller_0;
  wire             VGA_HS_from_the_video_vga_controller_0;
  wire    [  7: 0] VGA_R_from_the_video_vga_controller_0;
  wire             VGA_SYNC_from_the_video_vga_controller_0;
  wire             VGA_VS_from_the_video_vga_controller_0;
  wire             b_SD_cmd_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  wire             b_SD_dat3_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  wire             b_SD_dat_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  wire             clk_0_reset_n;
  wire             clocks_SDRAM_CLK_out;
  wire             clocks_avalon_clocks_slave_address;
  wire    [  7: 0] clocks_avalon_clocks_slave_readdata;
  wire    [  7: 0] clocks_avalon_clocks_slave_readdata_from_sa;
  wire             clocks_sys_clk_out;
  wire    [ 27: 0] cpu_0_data_master_address;
  wire    [ 27: 0] cpu_0_data_master_address_to_slave;
  wire    [  3: 0] cpu_0_data_master_byteenable;
  wire             cpu_0_data_master_byteenable_nios_system_clock_1_in;
  wire    [  1: 0] cpu_0_data_master_dbs_address;
  wire    [  7: 0] cpu_0_data_master_dbs_write_8;
  wire             cpu_0_data_master_debugaccess;
  wire             cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  wire             cpu_0_data_master_granted_clocks_avalon_clocks_slave;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_granted_input1_s1;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_granted_nios_system_clock_0_in;
  wire             cpu_0_data_master_granted_nios_system_clock_1_in;
  wire             cpu_0_data_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_data_master_granted_output1_s1;
  wire             cpu_0_data_master_granted_sdram_0_s1;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire             cpu_0_data_master_no_byte_enables_and_last_term;
  wire             cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  wire             cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_input1_s1;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_nios_system_clock_0_in;
  wire             cpu_0_data_master_qualified_request_nios_system_clock_1_in;
  wire             cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_data_master_qualified_request_output1_s1;
  wire             cpu_0_data_master_qualified_request_sdram_0_s1;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_read;
  wire             cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  wire             cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_input1_s1;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_nios_system_clock_0_in;
  wire             cpu_0_data_master_read_data_valid_nios_system_clock_1_in;
  wire             cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  wire             cpu_0_data_master_read_data_valid_output1_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave;
  wire             cpu_0_data_master_requests_clocks_avalon_clocks_slave;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_input1_s1;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_nios_system_clock_0_in;
  wire             cpu_0_data_master_requests_nios_system_clock_1_in;
  wire             cpu_0_data_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_data_master_requests_output1_s1;
  wire             cpu_0_data_master_requests_sdram_0_s1;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_waitrequest;
  wire             cpu_0_data_master_write;
  wire    [ 31: 0] cpu_0_data_master_writedata;
  wire    [ 27: 0] cpu_0_instruction_master_address;
  wire    [ 27: 0] cpu_0_instruction_master_address_to_slave;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_granted_sdram_0_s1;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_qualified_request_sdram_0_s1;
  wire             cpu_0_instruction_master_read;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_requests_sdram_0_s1;
  wire             cpu_0_instruction_master_waitrequest;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  wire             d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer;
  wire             d1_clocks_avalon_clocks_slave_end_xfer;
  wire             d1_cpu_0_jtag_debug_module_end_xfer;
  wire             d1_input1_s1_end_xfer;
  wire             d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             d1_nios_system_clock_0_in_end_xfer;
  wire             d1_nios_system_clock_1_in_end_xfer;
  wire             d1_onchip_memory2_0_s1_end_xfer;
  wire             d1_output1_s1_end_xfer;
  wire             d1_sdram_0_s1_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer;
  wire             d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer;
  wire    [  1: 0] input1_s1_address;
  wire    [ 31: 0] input1_s1_readdata;
  wire    [ 31: 0] input1_s1_readdata_from_sa;
  wire             input1_s1_reset_n;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_irq;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [  2: 0] nios_system_clock_0_in_address;
  wire    [  3: 0] nios_system_clock_0_in_byteenable;
  wire             nios_system_clock_0_in_endofpacket;
  wire             nios_system_clock_0_in_endofpacket_from_sa;
  wire             nios_system_clock_0_in_nativeaddress;
  wire             nios_system_clock_0_in_read;
  wire    [ 31: 0] nios_system_clock_0_in_readdata;
  wire    [ 31: 0] nios_system_clock_0_in_readdata_from_sa;
  wire             nios_system_clock_0_in_reset_n;
  wire             nios_system_clock_0_in_waitrequest;
  wire             nios_system_clock_0_in_waitrequest_from_sa;
  wire             nios_system_clock_0_in_write;
  wire    [ 31: 0] nios_system_clock_0_in_writedata;
  wire    [  2: 0] nios_system_clock_0_out_address;
  wire    [  2: 0] nios_system_clock_0_out_address_to_slave;
  wire    [  3: 0] nios_system_clock_0_out_byteenable;
  wire             nios_system_clock_0_out_endofpacket;
  wire             nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave;
  wire             nios_system_clock_0_out_nativeaddress;
  wire             nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave;
  wire             nios_system_clock_0_out_read;
  wire             nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave;
  wire    [ 31: 0] nios_system_clock_0_out_readdata;
  wire             nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave;
  wire             nios_system_clock_0_out_reset_n;
  wire             nios_system_clock_0_out_waitrequest;
  wire             nios_system_clock_0_out_write;
  wire    [ 31: 0] nios_system_clock_0_out_writedata;
  wire    [ 12: 0] nios_system_clock_1_in_address;
  wire             nios_system_clock_1_in_endofpacket;
  wire             nios_system_clock_1_in_endofpacket_from_sa;
  wire    [ 12: 0] nios_system_clock_1_in_nativeaddress;
  wire             nios_system_clock_1_in_read;
  wire    [  7: 0] nios_system_clock_1_in_readdata;
  wire    [  7: 0] nios_system_clock_1_in_readdata_from_sa;
  wire             nios_system_clock_1_in_reset_n;
  wire             nios_system_clock_1_in_waitrequest;
  wire             nios_system_clock_1_in_waitrequest_from_sa;
  wire             nios_system_clock_1_in_write;
  wire    [  7: 0] nios_system_clock_1_in_writedata;
  wire    [ 12: 0] nios_system_clock_1_out_address;
  wire    [ 12: 0] nios_system_clock_1_out_address_to_slave;
  wire             nios_system_clock_1_out_endofpacket;
  wire             nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  wire    [ 12: 0] nios_system_clock_1_out_nativeaddress;
  wire             nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  wire             nios_system_clock_1_out_read;
  wire             nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  wire    [  7: 0] nios_system_clock_1_out_readdata;
  wire             nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave;
  wire             nios_system_clock_1_out_reset_n;
  wire             nios_system_clock_1_out_waitrequest;
  wire             nios_system_clock_1_out_write;
  wire    [  7: 0] nios_system_clock_1_out_writedata;
  wire             o_SD_clock_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  wire    [ 11: 0] onchip_memory2_0_s1_address;
  wire    [  3: 0] onchip_memory2_0_s1_byteenable;
  wire             onchip_memory2_0_s1_chipselect;
  wire             onchip_memory2_0_s1_clken;
  wire    [ 31: 0] onchip_memory2_0_s1_readdata;
  wire    [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  wire             onchip_memory2_0_s1_reset;
  wire             onchip_memory2_0_s1_write;
  wire    [ 31: 0] onchip_memory2_0_s1_writedata;
  wire             out_clk_clocks_SDRAM_CLK;
  wire             out_clk_clocks_sys_clk;
  wire    [  7: 0] out_port_from_the_output1;
  wire    [  1: 0] output1_s1_address;
  wire             output1_s1_chipselect;
  wire    [ 31: 0] output1_s1_readdata;
  wire    [ 31: 0] output1_s1_readdata_from_sa;
  wire             output1_s1_reset_n;
  wire             output1_s1_write_n;
  wire    [ 31: 0] output1_s1_writedata;
  wire             registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave;
  wire             registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  wire             reset_n_sources;
  wire    [ 24: 0] sdram_0_s1_address;
  wire    [  3: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire             sdram_0_s1_read_n;
  wire    [ 31: 0] sdram_0_s1_readdata;
  wire    [ 31: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid;
  wire             sdram_0_s1_reset_n;
  wire             sdram_0_s1_waitrequest;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_write_n;
  wire    [ 31: 0] sdram_0_s1_writedata;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_clock;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire             sysid_control_slave_reset_n;
  wire             vga_clock_reset_n;
  wire    [ 12: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_address;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_byteenable;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_chipselect;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_read;
  wire    [  7: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata;
  wire    [  7: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa;
  wire             video_character_buffer_with_dma_0_avalon_char_buffer_slave_write;
  wire    [  7: 0] video_character_buffer_with_dma_0_avalon_char_buffer_slave_writedata;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_address;
  wire    [  3: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_byteenable;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_chipselect;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_read;
  wire    [ 31: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_readdata;
  wire    [ 31: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_reset;
  wire             video_character_buffer_with_dma_0_avalon_char_control_slave_write;
  wire    [ 31: 0] video_character_buffer_with_dma_0_avalon_char_control_slave_writedata;
  wire    [ 29: 0] video_character_buffer_with_dma_0_avalon_char_source_data;
  wire             video_character_buffer_with_dma_0_avalon_char_source_endofpacket;
  wire             video_character_buffer_with_dma_0_avalon_char_source_ready;
  wire             video_character_buffer_with_dma_0_avalon_char_source_startofpacket;
  wire             video_character_buffer_with_dma_0_avalon_char_source_valid;
  wire    [ 29: 0] video_vga_controller_0_avalon_vga_sink_data;
  wire             video_vga_controller_0_avalon_vga_sink_endofpacket;
  wire             video_vga_controller_0_avalon_vga_sink_ready;
  wire             video_vga_controller_0_avalon_vga_sink_ready_from_sa;
  wire             video_vga_controller_0_avalon_vga_sink_reset;
  wire             video_vga_controller_0_avalon_vga_sink_startofpacket;
  wire             video_vga_controller_0_avalon_vga_sink_valid;
  wire    [ 12: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 31: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  3: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;
  Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_arbitrator the_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave
    (
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_address                             (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_address),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_byteenable                          (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_byteenable),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_chipselect                          (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_chipselect),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_read                                (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_read),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata                            (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa                    (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reset_n                             (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reset_n),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest                         (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa                 (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_write                               (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_write),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_writedata                           (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_writedata),
      .clk                                                                                          (clk_0),
      .cpu_0_data_master_address_to_slave                                                           (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                                                 (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave           (cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave),
      .cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave (cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave),
      .cpu_0_data_master_read                                                                       (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave   (cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave),
      .cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave          (cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave),
      .cpu_0_data_master_waitrequest                                                                (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                                                      (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                                                  (cpu_0_data_master_writedata),
      .d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer                         (d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer),
      .reset_n                                                                                      (clk_0_reset_n)
    );

  Altera_UP_SD_Card_Avalon_Interface_0 the_Altera_UP_SD_Card_Avalon_Interface_0
    (
      .b_SD_cmd             (b_SD_cmd_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0),
      .b_SD_dat             (b_SD_dat_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0),
      .b_SD_dat3            (b_SD_dat3_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0),
      .i_avalon_address     (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_address),
      .i_avalon_byteenable  (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_byteenable),
      .i_avalon_chip_select (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_chipselect),
      .i_avalon_read        (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_read),
      .i_avalon_write       (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_write),
      .i_avalon_writedata   (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_writedata),
      .i_clock              (clk_0),
      .i_reset_n            (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_reset_n),
      .o_SD_clock           (o_SD_clock_from_the_Altera_UP_SD_Card_Avalon_Interface_0),
      .o_avalon_readdata    (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata),
      .o_avalon_waitrequest (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest)
    );

  clocks_avalon_clocks_slave_arbitrator the_clocks_avalon_clocks_slave
    (
      .clk                                                                     (clk_0),
      .clocks_avalon_clocks_slave_address                                      (clocks_avalon_clocks_slave_address),
      .clocks_avalon_clocks_slave_readdata                                     (clocks_avalon_clocks_slave_readdata),
      .clocks_avalon_clocks_slave_readdata_from_sa                             (clocks_avalon_clocks_slave_readdata_from_sa),
      .cpu_0_data_master_address_to_slave                                      (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_dbs_address                                           (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_granted_clocks_avalon_clocks_slave                    (cpu_0_data_master_granted_clocks_avalon_clocks_slave),
      .cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave          (cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave),
      .cpu_0_data_master_read                                                  (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave            (cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave),
      .cpu_0_data_master_requests_clocks_avalon_clocks_slave                   (cpu_0_data_master_requests_clocks_avalon_clocks_slave),
      .cpu_0_data_master_write                                                 (cpu_0_data_master_write),
      .d1_clocks_avalon_clocks_slave_end_xfer                                  (d1_clocks_avalon_clocks_slave_end_xfer),
      .registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave (registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave),
      .reset_n                                                                 (clk_0_reset_n)
    );

  //clocks_SDRAM_CLK_out out_clk assignment, which is an e_assign
  assign clocks_SDRAM_CLK_out = out_clk_clocks_SDRAM_CLK;

  //clocks_sys_clk_out out_clk assignment, which is an e_assign
  assign clocks_sys_clk_out = out_clk_clocks_sys_clk;

  clocks the_clocks
    (
      .CLOCK_50  (clk_0),
      .SDRAM_CLK (out_clk_clocks_SDRAM_CLK),
      .address   (clocks_avalon_clocks_slave_address),
      .readdata  (clocks_avalon_clocks_slave_readdata),
      .sys_clk   (out_clk_clocks_sys_clk)
    );

  cpu_0_jtag_debug_module_arbitrator the_cpu_0_jtag_debug_module
    (
      .clk                                                                (clk_0),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_debugaccess                                      (cpu_0_data_master_debugaccess),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                  (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module        (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module          (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                 (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_waitrequest                                      (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                        (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_jtag_debug_module_address                                    (cpu_0_jtag_debug_module_address),
      .cpu_0_jtag_debug_module_begintransfer                              (cpu_0_jtag_debug_module_begintransfer),
      .cpu_0_jtag_debug_module_byteenable                                 (cpu_0_jtag_debug_module_byteenable),
      .cpu_0_jtag_debug_module_chipselect                                 (cpu_0_jtag_debug_module_chipselect),
      .cpu_0_jtag_debug_module_debugaccess                                (cpu_0_jtag_debug_module_debugaccess),
      .cpu_0_jtag_debug_module_readdata                                   (cpu_0_jtag_debug_module_readdata),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .cpu_0_jtag_debug_module_reset_n                                    (cpu_0_jtag_debug_module_reset_n),
      .cpu_0_jtag_debug_module_resetrequest                               (cpu_0_jtag_debug_module_resetrequest),
      .cpu_0_jtag_debug_module_resetrequest_from_sa                       (cpu_0_jtag_debug_module_resetrequest_from_sa),
      .cpu_0_jtag_debug_module_write                                      (cpu_0_jtag_debug_module_write),
      .cpu_0_jtag_debug_module_writedata                                  (cpu_0_jtag_debug_module_writedata),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .reset_n                                                            (clk_0_reset_n)
    );

  cpu_0_data_master_arbitrator the_cpu_0_data_master
    (
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa                    (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_readdata_from_sa),
      .Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa                 (Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_waitrequest_from_sa),
      .clk                                                                                          (clk_0),
      .clocks_avalon_clocks_slave_readdata_from_sa                                                  (clocks_avalon_clocks_slave_readdata_from_sa),
      .cpu_0_data_master_address                                                                    (cpu_0_data_master_address),
      .cpu_0_data_master_address_to_slave                                                           (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable_nios_system_clock_1_in                                          (cpu_0_data_master_byteenable_nios_system_clock_1_in),
      .cpu_0_data_master_dbs_address                                                                (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_8                                                                (cpu_0_data_master_dbs_write_8),
      .cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave           (cpu_0_data_master_granted_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave),
      .cpu_0_data_master_granted_clocks_avalon_clocks_slave                                         (cpu_0_data_master_granted_clocks_avalon_clocks_slave),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                                            (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_granted_input1_s1                                                          (cpu_0_data_master_granted_input1_s1),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave                                      (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_granted_nios_system_clock_0_in                                             (cpu_0_data_master_granted_nios_system_clock_0_in),
      .cpu_0_data_master_granted_nios_system_clock_1_in                                             (cpu_0_data_master_granted_nios_system_clock_1_in),
      .cpu_0_data_master_granted_onchip_memory2_0_s1                                                (cpu_0_data_master_granted_onchip_memory2_0_s1),
      .cpu_0_data_master_granted_output1_s1                                                         (cpu_0_data_master_granted_output1_s1),
      .cpu_0_data_master_granted_sdram_0_s1                                                         (cpu_0_data_master_granted_sdram_0_s1),
      .cpu_0_data_master_granted_sysid_control_slave                                                (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_irq                                                                        (cpu_0_data_master_irq),
      .cpu_0_data_master_no_byte_enables_and_last_term                                              (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave (cpu_0_data_master_qualified_request_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave),
      .cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave                               (cpu_0_data_master_qualified_request_clocks_avalon_clocks_slave),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module                                  (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_input1_s1                                                (cpu_0_data_master_qualified_request_input1_s1),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave                            (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_nios_system_clock_0_in                                   (cpu_0_data_master_qualified_request_nios_system_clock_0_in),
      .cpu_0_data_master_qualified_request_nios_system_clock_1_in                                   (cpu_0_data_master_qualified_request_nios_system_clock_1_in),
      .cpu_0_data_master_qualified_request_onchip_memory2_0_s1                                      (cpu_0_data_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_data_master_qualified_request_output1_s1                                               (cpu_0_data_master_qualified_request_output1_s1),
      .cpu_0_data_master_qualified_request_sdram_0_s1                                               (cpu_0_data_master_qualified_request_sdram_0_s1),
      .cpu_0_data_master_qualified_request_sysid_control_slave                                      (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_read                                                                       (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave   (cpu_0_data_master_read_data_valid_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave),
      .cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave                                 (cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module                                    (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read_data_valid_input1_s1                                                  (cpu_0_data_master_read_data_valid_input1_s1),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave                              (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read_data_valid_nios_system_clock_0_in                                     (cpu_0_data_master_read_data_valid_nios_system_clock_0_in),
      .cpu_0_data_master_read_data_valid_nios_system_clock_1_in                                     (cpu_0_data_master_read_data_valid_nios_system_clock_1_in),
      .cpu_0_data_master_read_data_valid_onchip_memory2_0_s1                                        (cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_data_master_read_data_valid_output1_s1                                                 (cpu_0_data_master_read_data_valid_output1_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1                                                 (cpu_0_data_master_read_data_valid_sdram_0_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register                                  (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_data_master_read_data_valid_sysid_control_slave                                        (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_readdata                                                                   (cpu_0_data_master_readdata),
      .cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave          (cpu_0_data_master_requests_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave),
      .cpu_0_data_master_requests_clocks_avalon_clocks_slave                                        (cpu_0_data_master_requests_clocks_avalon_clocks_slave),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                                           (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_input1_s1                                                         (cpu_0_data_master_requests_input1_s1),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave                                     (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_nios_system_clock_0_in                                            (cpu_0_data_master_requests_nios_system_clock_0_in),
      .cpu_0_data_master_requests_nios_system_clock_1_in                                            (cpu_0_data_master_requests_nios_system_clock_1_in),
      .cpu_0_data_master_requests_onchip_memory2_0_s1                                               (cpu_0_data_master_requests_onchip_memory2_0_s1),
      .cpu_0_data_master_requests_output1_s1                                                        (cpu_0_data_master_requests_output1_s1),
      .cpu_0_data_master_requests_sdram_0_s1                                                        (cpu_0_data_master_requests_sdram_0_s1),
      .cpu_0_data_master_requests_sysid_control_slave                                               (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_waitrequest                                                                (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                                                      (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                                                  (cpu_0_data_master_writedata),
      .cpu_0_jtag_debug_module_readdata_from_sa                                                     (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer                         (d1_Altera_UP_SD_Card_Avalon_Interface_0_avalon_sdcard_slave_end_xfer),
      .d1_clocks_avalon_clocks_slave_end_xfer                                                       (d1_clocks_avalon_clocks_slave_end_xfer),
      .d1_cpu_0_jtag_debug_module_end_xfer                                                          (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_input1_s1_end_xfer                                                                        (d1_input1_s1_end_xfer),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                                                    (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .d1_nios_system_clock_0_in_end_xfer                                                           (d1_nios_system_clock_0_in_end_xfer),
      .d1_nios_system_clock_1_in_end_xfer                                                           (d1_nios_system_clock_1_in_end_xfer),
      .d1_onchip_memory2_0_s1_end_xfer                                                              (d1_onchip_memory2_0_s1_end_xfer),
      .d1_output1_s1_end_xfer                                                                       (d1_output1_s1_end_xfer),
      .d1_sdram_0_s1_end_xfer                                                                       (d1_sdram_0_s1_end_xfer),
      .d1_sysid_control_slave_end_xfer                                                              (d1_sysid_control_slave_end_xfer),
      .input1_s1_readdata_from_sa                                                                   (input1_s1_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                                                    (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                                               (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                                            (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .nios_system_clock_0_in_readdata_from_sa                                                      (nios_system_clock_0_in_readdata_from_sa),
      .nios_system_clock_0_in_waitrequest_from_sa                                                   (nios_system_clock_0_in_waitrequest_from_sa),
      .nios_system_clock_1_in_readdata_from_sa                                                      (nios_system_clock_1_in_readdata_from_sa),
      .nios_system_clock_1_in_waitrequest_from_sa                                                   (nios_system_clock_1_in_waitrequest_from_sa),
      .onchip_memory2_0_s1_readdata_from_sa                                                         (onchip_memory2_0_s1_readdata_from_sa),
      .output1_s1_readdata_from_sa                                                                  (output1_s1_readdata_from_sa),
      .registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave                      (registered_cpu_0_data_master_read_data_valid_clocks_avalon_clocks_slave),
      .registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1                             (registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .reset_n                                                                                      (clk_0_reset_n),
      .sdram_0_s1_readdata_from_sa                                                                  (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                                               (sdram_0_s1_waitrequest_from_sa),
      .sysid_control_slave_readdata_from_sa                                                         (sysid_control_slave_readdata_from_sa)
    );

  cpu_0_instruction_master_arbitrator the_cpu_0_instruction_master
    (
      .clk                                                                (clk_0),
      .cpu_0_instruction_master_address                                   (cpu_0_instruction_master_address),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_granted_onchip_memory2_0_s1               (cpu_0_instruction_master_granted_onchip_memory2_0_s1),
      .cpu_0_instruction_master_granted_sdram_0_s1                        (cpu_0_instruction_master_granted_sdram_0_s1),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1     (cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_instruction_master_qualified_request_sdram_0_s1              (cpu_0_instruction_master_qualified_request_sdram_0_s1),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1       (cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1                (cpu_0_instruction_master_read_data_valid_sdram_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_readdata                                  (cpu_0_instruction_master_readdata),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_onchip_memory2_0_s1              (cpu_0_instruction_master_requests_onchip_memory2_0_s1),
      .cpu_0_instruction_master_requests_sdram_0_s1                       (cpu_0_instruction_master_requests_sdram_0_s1),
      .cpu_0_instruction_master_waitrequest                               (cpu_0_instruction_master_waitrequest),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_onchip_memory2_0_s1_end_xfer                                    (d1_onchip_memory2_0_s1_end_xfer),
      .d1_sdram_0_s1_end_xfer                                             (d1_sdram_0_s1_end_xfer),
      .onchip_memory2_0_s1_readdata_from_sa                               (onchip_memory2_0_s1_readdata_from_sa),
      .reset_n                                                            (clk_0_reset_n),
      .sdram_0_s1_readdata_from_sa                                        (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                     (sdram_0_s1_waitrequest_from_sa)
    );

  cpu_0 the_cpu_0
    (
      .clk                                   (clk_0),
      .d_address                             (cpu_0_data_master_address),
      .d_byteenable                          (cpu_0_data_master_byteenable),
      .d_irq                                 (cpu_0_data_master_irq),
      .d_read                                (cpu_0_data_master_read),
      .d_readdata                            (cpu_0_data_master_readdata),
      .d_waitrequest                         (cpu_0_data_master_waitrequest),
      .d_write                               (cpu_0_data_master_write),
      .d_writedata                           (cpu_0_data_master_writedata),
      .i_address                             (cpu_0_instruction_master_address),
      .i_read                                (cpu_0_instruction_master_read),
      .i_readdata                            (cpu_0_instruction_master_readdata),
      .i_waitrequest                         (cpu_0_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_0_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_0_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_0_jtag_debug_module_byteenable),
      .jtag_debug_module_debugaccess         (cpu_0_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_0_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_0_jtag_debug_module_readdata),
      .jtag_debug_module_resetrequest        (cpu_0_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_0_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_0_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_0_jtag_debug_module_writedata),
      .reset_n                               (cpu_0_jtag_debug_module_reset_n)
    );

  input1_s1_arbitrator the_input1_s1
    (
      .clk                                           (clk_0),
      .cpu_0_data_master_address_to_slave            (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_input1_s1           (cpu_0_data_master_granted_input1_s1),
      .cpu_0_data_master_qualified_request_input1_s1 (cpu_0_data_master_qualified_request_input1_s1),
      .cpu_0_data_master_read                        (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_input1_s1   (cpu_0_data_master_read_data_valid_input1_s1),
      .cpu_0_data_master_requests_input1_s1          (cpu_0_data_master_requests_input1_s1),
      .cpu_0_data_master_write                       (cpu_0_data_master_write),
      .d1_input1_s1_end_xfer                         (d1_input1_s1_end_xfer),
      .input1_s1_address                             (input1_s1_address),
      .input1_s1_readdata                            (input1_s1_readdata),
      .input1_s1_readdata_from_sa                    (input1_s1_readdata_from_sa),
      .input1_s1_reset_n                             (input1_s1_reset_n),
      .reset_n                                       (clk_0_reset_n)
    );

  input1 the_input1
    (
      .address  (input1_s1_address),
      .clk      (clk_0),
      .in_port  (in_port_to_the_input1),
      .readdata (input1_s1_readdata),
      .reset_n  (input1_s1_reset_n)
    );

  jtag_uart_0_avalon_jtag_slave_arbitrator the_jtag_uart_0_avalon_jtag_slave
    (
      .clk                                                               (clk_0),
      .cpu_0_data_master_address_to_slave                                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave           (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read                                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave   (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave          (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_waitrequest                                     (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                       (cpu_0_data_master_writedata),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                         (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .jtag_uart_0_avalon_jtag_slave_address                             (jtag_uart_0_avalon_jtag_slave_address),
      .jtag_uart_0_avalon_jtag_slave_chipselect                          (jtag_uart_0_avalon_jtag_slave_chipselect),
      .jtag_uart_0_avalon_jtag_slave_dataavailable                       (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa               (jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_0_avalon_jtag_slave_irq                                 (jtag_uart_0_avalon_jtag_slave_irq),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                         (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_read_n                              (jtag_uart_0_avalon_jtag_slave_read_n),
      .jtag_uart_0_avalon_jtag_slave_readdata                            (jtag_uart_0_avalon_jtag_slave_readdata),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                    (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readyfordata                        (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa                (jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_reset_n                             (jtag_uart_0_avalon_jtag_slave_reset_n),
      .jtag_uart_0_avalon_jtag_slave_waitrequest                         (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                 (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_0_avalon_jtag_slave_write_n                             (jtag_uart_0_avalon_jtag_slave_write_n),
      .jtag_uart_0_avalon_jtag_slave_writedata                           (jtag_uart_0_avalon_jtag_slave_writedata),
      .reset_n                                                           (clk_0_reset_n)
    );

  jtag_uart_0 the_jtag_uart_0
    (
      .av_address     (jtag_uart_0_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_0_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_0_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_0_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_0_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_0_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_0_avalon_jtag_slave_writedata),
      .clk            (clk_0),
      .dataavailable  (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_0_avalon_jtag_slave_reset_n)
    );

  nios_system_clock_0_in_arbitrator the_nios_system_clock_0_in
    (
      .clk                                                        (clk_0),
      .cpu_0_data_master_address_to_slave                         (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                               (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_nios_system_clock_0_in           (cpu_0_data_master_granted_nios_system_clock_0_in),
      .cpu_0_data_master_qualified_request_nios_system_clock_0_in (cpu_0_data_master_qualified_request_nios_system_clock_0_in),
      .cpu_0_data_master_read                                     (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_nios_system_clock_0_in   (cpu_0_data_master_read_data_valid_nios_system_clock_0_in),
      .cpu_0_data_master_requests_nios_system_clock_0_in          (cpu_0_data_master_requests_nios_system_clock_0_in),
      .cpu_0_data_master_waitrequest                              (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                    (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                (cpu_0_data_master_writedata),
      .d1_nios_system_clock_0_in_end_xfer                         (d1_nios_system_clock_0_in_end_xfer),
      .nios_system_clock_0_in_address                             (nios_system_clock_0_in_address),
      .nios_system_clock_0_in_byteenable                          (nios_system_clock_0_in_byteenable),
      .nios_system_clock_0_in_endofpacket                         (nios_system_clock_0_in_endofpacket),
      .nios_system_clock_0_in_endofpacket_from_sa                 (nios_system_clock_0_in_endofpacket_from_sa),
      .nios_system_clock_0_in_nativeaddress                       (nios_system_clock_0_in_nativeaddress),
      .nios_system_clock_0_in_read                                (nios_system_clock_0_in_read),
      .nios_system_clock_0_in_readdata                            (nios_system_clock_0_in_readdata),
      .nios_system_clock_0_in_readdata_from_sa                    (nios_system_clock_0_in_readdata_from_sa),
      .nios_system_clock_0_in_reset_n                             (nios_system_clock_0_in_reset_n),
      .nios_system_clock_0_in_waitrequest                         (nios_system_clock_0_in_waitrequest),
      .nios_system_clock_0_in_waitrequest_from_sa                 (nios_system_clock_0_in_waitrequest_from_sa),
      .nios_system_clock_0_in_write                               (nios_system_clock_0_in_write),
      .nios_system_clock_0_in_writedata                           (nios_system_clock_0_in_writedata),
      .reset_n                                                    (clk_0_reset_n)
    );

  nios_system_clock_0_out_arbitrator the_nios_system_clock_0_out
    (
      .clk                                                                                                   (vga_clock),
      .d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer                               (d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer),
      .nios_system_clock_0_out_address                                                                       (nios_system_clock_0_out_address),
      .nios_system_clock_0_out_address_to_slave                                                              (nios_system_clock_0_out_address_to_slave),
      .nios_system_clock_0_out_byteenable                                                                    (nios_system_clock_0_out_byteenable),
      .nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave           (nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave),
      .nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave (nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave),
      .nios_system_clock_0_out_read                                                                          (nios_system_clock_0_out_read),
      .nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave   (nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave),
      .nios_system_clock_0_out_readdata                                                                      (nios_system_clock_0_out_readdata),
      .nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave          (nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave),
      .nios_system_clock_0_out_reset_n                                                                       (nios_system_clock_0_out_reset_n),
      .nios_system_clock_0_out_waitrequest                                                                   (nios_system_clock_0_out_waitrequest),
      .nios_system_clock_0_out_write                                                                         (nios_system_clock_0_out_write),
      .nios_system_clock_0_out_writedata                                                                     (nios_system_clock_0_out_writedata),
      .reset_n                                                                                               (vga_clock_reset_n),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa                          (video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa)
    );

  nios_system_clock_0 the_nios_system_clock_0
    (
      .master_address       (nios_system_clock_0_out_address),
      .master_byteenable    (nios_system_clock_0_out_byteenable),
      .master_clk           (vga_clock),
      .master_endofpacket   (nios_system_clock_0_out_endofpacket),
      .master_nativeaddress (nios_system_clock_0_out_nativeaddress),
      .master_read          (nios_system_clock_0_out_read),
      .master_readdata      (nios_system_clock_0_out_readdata),
      .master_reset_n       (nios_system_clock_0_out_reset_n),
      .master_waitrequest   (nios_system_clock_0_out_waitrequest),
      .master_write         (nios_system_clock_0_out_write),
      .master_writedata     (nios_system_clock_0_out_writedata),
      .slave_address        (nios_system_clock_0_in_address),
      .slave_byteenable     (nios_system_clock_0_in_byteenable),
      .slave_clk            (clk_0),
      .slave_endofpacket    (nios_system_clock_0_in_endofpacket),
      .slave_nativeaddress  (nios_system_clock_0_in_nativeaddress),
      .slave_read           (nios_system_clock_0_in_read),
      .slave_readdata       (nios_system_clock_0_in_readdata),
      .slave_reset_n        (nios_system_clock_0_in_reset_n),
      .slave_waitrequest    (nios_system_clock_0_in_waitrequest),
      .slave_write          (nios_system_clock_0_in_write),
      .slave_writedata      (nios_system_clock_0_in_writedata)
    );

  nios_system_clock_1_in_arbitrator the_nios_system_clock_1_in
    (
      .clk                                                        (clk_0),
      .cpu_0_data_master_address_to_slave                         (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                               (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_nios_system_clock_1_in        (cpu_0_data_master_byteenable_nios_system_clock_1_in),
      .cpu_0_data_master_dbs_address                              (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_8                              (cpu_0_data_master_dbs_write_8),
      .cpu_0_data_master_granted_nios_system_clock_1_in           (cpu_0_data_master_granted_nios_system_clock_1_in),
      .cpu_0_data_master_no_byte_enables_and_last_term            (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_nios_system_clock_1_in (cpu_0_data_master_qualified_request_nios_system_clock_1_in),
      .cpu_0_data_master_read                                     (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_nios_system_clock_1_in   (cpu_0_data_master_read_data_valid_nios_system_clock_1_in),
      .cpu_0_data_master_requests_nios_system_clock_1_in          (cpu_0_data_master_requests_nios_system_clock_1_in),
      .cpu_0_data_master_waitrequest                              (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                    (cpu_0_data_master_write),
      .d1_nios_system_clock_1_in_end_xfer                         (d1_nios_system_clock_1_in_end_xfer),
      .nios_system_clock_1_in_address                             (nios_system_clock_1_in_address),
      .nios_system_clock_1_in_endofpacket                         (nios_system_clock_1_in_endofpacket),
      .nios_system_clock_1_in_endofpacket_from_sa                 (nios_system_clock_1_in_endofpacket_from_sa),
      .nios_system_clock_1_in_nativeaddress                       (nios_system_clock_1_in_nativeaddress),
      .nios_system_clock_1_in_read                                (nios_system_clock_1_in_read),
      .nios_system_clock_1_in_readdata                            (nios_system_clock_1_in_readdata),
      .nios_system_clock_1_in_readdata_from_sa                    (nios_system_clock_1_in_readdata_from_sa),
      .nios_system_clock_1_in_reset_n                             (nios_system_clock_1_in_reset_n),
      .nios_system_clock_1_in_waitrequest                         (nios_system_clock_1_in_waitrequest),
      .nios_system_clock_1_in_waitrequest_from_sa                 (nios_system_clock_1_in_waitrequest_from_sa),
      .nios_system_clock_1_in_write                               (nios_system_clock_1_in_write),
      .nios_system_clock_1_in_writedata                           (nios_system_clock_1_in_writedata),
      .reset_n                                                    (clk_0_reset_n)
    );

  nios_system_clock_1_out_arbitrator the_nios_system_clock_1_out
    (
      .clk                                                                                                  (vga_clock),
      .d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer                               (d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer),
      .nios_system_clock_1_out_address                                                                      (nios_system_clock_1_out_address),
      .nios_system_clock_1_out_address_to_slave                                                             (nios_system_clock_1_out_address_to_slave),
      .nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave           (nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave),
      .nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave (nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave),
      .nios_system_clock_1_out_read                                                                         (nios_system_clock_1_out_read),
      .nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave   (nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave),
      .nios_system_clock_1_out_readdata                                                                     (nios_system_clock_1_out_readdata),
      .nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave          (nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave),
      .nios_system_clock_1_out_reset_n                                                                      (nios_system_clock_1_out_reset_n),
      .nios_system_clock_1_out_waitrequest                                                                  (nios_system_clock_1_out_waitrequest),
      .nios_system_clock_1_out_write                                                                        (nios_system_clock_1_out_write),
      .nios_system_clock_1_out_writedata                                                                    (nios_system_clock_1_out_writedata),
      .reset_n                                                                                              (vga_clock_reset_n),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa                          (video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa                       (video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa)
    );

  nios_system_clock_1 the_nios_system_clock_1
    (
      .master_address       (nios_system_clock_1_out_address),
      .master_clk           (vga_clock),
      .master_endofpacket   (nios_system_clock_1_out_endofpacket),
      .master_nativeaddress (nios_system_clock_1_out_nativeaddress),
      .master_read          (nios_system_clock_1_out_read),
      .master_readdata      (nios_system_clock_1_out_readdata),
      .master_reset_n       (nios_system_clock_1_out_reset_n),
      .master_waitrequest   (nios_system_clock_1_out_waitrequest),
      .master_write         (nios_system_clock_1_out_write),
      .master_writedata     (nios_system_clock_1_out_writedata),
      .slave_address        (nios_system_clock_1_in_address),
      .slave_clk            (clk_0),
      .slave_endofpacket    (nios_system_clock_1_in_endofpacket),
      .slave_nativeaddress  (nios_system_clock_1_in_nativeaddress),
      .slave_read           (nios_system_clock_1_in_read),
      .slave_readdata       (nios_system_clock_1_in_readdata),
      .slave_reset_n        (nios_system_clock_1_in_reset_n),
      .slave_waitrequest    (nios_system_clock_1_in_waitrequest),
      .slave_write          (nios_system_clock_1_in_write),
      .slave_writedata      (nios_system_clock_1_in_writedata)
    );

  onchip_memory2_0_s1_arbitrator the_onchip_memory2_0_s1
    (
      .clk                                                              (clk_0),
      .cpu_0_data_master_address_to_slave                               (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                     (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_onchip_memory2_0_s1                    (cpu_0_data_master_granted_onchip_memory2_0_s1),
      .cpu_0_data_master_qualified_request_onchip_memory2_0_s1          (cpu_0_data_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_data_master_read                                           (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_onchip_memory2_0_s1            (cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_data_master_requests_onchip_memory2_0_s1                   (cpu_0_data_master_requests_onchip_memory2_0_s1),
      .cpu_0_data_master_waitrequest                                    (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                          (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                      (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                        (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_onchip_memory2_0_s1             (cpu_0_instruction_master_granted_onchip_memory2_0_s1),
      .cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1   (cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_instruction_master_read                                    (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1     (cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_instruction_master_requests_onchip_memory2_0_s1            (cpu_0_instruction_master_requests_onchip_memory2_0_s1),
      .d1_onchip_memory2_0_s1_end_xfer                                  (d1_onchip_memory2_0_s1_end_xfer),
      .onchip_memory2_0_s1_address                                      (onchip_memory2_0_s1_address),
      .onchip_memory2_0_s1_byteenable                                   (onchip_memory2_0_s1_byteenable),
      .onchip_memory2_0_s1_chipselect                                   (onchip_memory2_0_s1_chipselect),
      .onchip_memory2_0_s1_clken                                        (onchip_memory2_0_s1_clken),
      .onchip_memory2_0_s1_readdata                                     (onchip_memory2_0_s1_readdata),
      .onchip_memory2_0_s1_readdata_from_sa                             (onchip_memory2_0_s1_readdata_from_sa),
      .onchip_memory2_0_s1_reset                                        (onchip_memory2_0_s1_reset),
      .onchip_memory2_0_s1_write                                        (onchip_memory2_0_s1_write),
      .onchip_memory2_0_s1_writedata                                    (onchip_memory2_0_s1_writedata),
      .registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 (registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .reset_n                                                          (clk_0_reset_n)
    );

  onchip_memory2_0 the_onchip_memory2_0
    (
      .address    (onchip_memory2_0_s1_address),
      .byteenable (onchip_memory2_0_s1_byteenable),
      .chipselect (onchip_memory2_0_s1_chipselect),
      .clk        (clk_0),
      .clken      (onchip_memory2_0_s1_clken),
      .readdata   (onchip_memory2_0_s1_readdata),
      .reset      (onchip_memory2_0_s1_reset),
      .write      (onchip_memory2_0_s1_write),
      .writedata  (onchip_memory2_0_s1_writedata)
    );

  output1_s1_arbitrator the_output1_s1
    (
      .clk                                            (clk_0),
      .cpu_0_data_master_address_to_slave             (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_output1_s1           (cpu_0_data_master_granted_output1_s1),
      .cpu_0_data_master_qualified_request_output1_s1 (cpu_0_data_master_qualified_request_output1_s1),
      .cpu_0_data_master_read                         (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_output1_s1   (cpu_0_data_master_read_data_valid_output1_s1),
      .cpu_0_data_master_requests_output1_s1          (cpu_0_data_master_requests_output1_s1),
      .cpu_0_data_master_waitrequest                  (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                        (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                    (cpu_0_data_master_writedata),
      .d1_output1_s1_end_xfer                         (d1_output1_s1_end_xfer),
      .output1_s1_address                             (output1_s1_address),
      .output1_s1_chipselect                          (output1_s1_chipselect),
      .output1_s1_readdata                            (output1_s1_readdata),
      .output1_s1_readdata_from_sa                    (output1_s1_readdata_from_sa),
      .output1_s1_reset_n                             (output1_s1_reset_n),
      .output1_s1_write_n                             (output1_s1_write_n),
      .output1_s1_writedata                           (output1_s1_writedata),
      .reset_n                                        (clk_0_reset_n)
    );

  output1 the_output1
    (
      .address    (output1_s1_address),
      .chipselect (output1_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_output1),
      .readdata   (output1_s1_readdata),
      .reset_n    (output1_s1_reset_n),
      .write_n    (output1_s1_write_n),
      .writedata  (output1_s1_writedata)
    );

  sdram_0_s1_arbitrator the_sdram_0_s1
    (
      .clk                                                                (clk_0),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_sdram_0_s1                               (cpu_0_data_master_granted_sdram_0_s1),
      .cpu_0_data_master_qualified_request_sdram_0_s1                     (cpu_0_data_master_qualified_request_sdram_0_s1),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sdram_0_s1                       (cpu_0_data_master_read_data_valid_sdram_0_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register        (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_data_master_requests_sdram_0_s1                              (cpu_0_data_master_requests_sdram_0_s1),
      .cpu_0_data_master_waitrequest                                      (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                        (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_sdram_0_s1                        (cpu_0_instruction_master_granted_sdram_0_s1),
      .cpu_0_instruction_master_qualified_request_sdram_0_s1              (cpu_0_instruction_master_qualified_request_sdram_0_s1),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1                (cpu_0_instruction_master_read_data_valid_sdram_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_requests_sdram_0_s1                       (cpu_0_instruction_master_requests_sdram_0_s1),
      .d1_sdram_0_s1_end_xfer                                             (d1_sdram_0_s1_end_xfer),
      .reset_n                                                            (clk_0_reset_n),
      .sdram_0_s1_address                                                 (sdram_0_s1_address),
      .sdram_0_s1_byteenable_n                                            (sdram_0_s1_byteenable_n),
      .sdram_0_s1_chipselect                                              (sdram_0_s1_chipselect),
      .sdram_0_s1_read_n                                                  (sdram_0_s1_read_n),
      .sdram_0_s1_readdata                                                (sdram_0_s1_readdata),
      .sdram_0_s1_readdata_from_sa                                        (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_readdatavalid                                           (sdram_0_s1_readdatavalid),
      .sdram_0_s1_reset_n                                                 (sdram_0_s1_reset_n),
      .sdram_0_s1_waitrequest                                             (sdram_0_s1_waitrequest),
      .sdram_0_s1_waitrequest_from_sa                                     (sdram_0_s1_waitrequest_from_sa),
      .sdram_0_s1_write_n                                                 (sdram_0_s1_write_n),
      .sdram_0_s1_writedata                                               (sdram_0_s1_writedata)
    );

  sdram_0 the_sdram_0
    (
      .az_addr        (sdram_0_s1_address),
      .az_be_n        (sdram_0_s1_byteenable_n),
      .az_cs          (sdram_0_s1_chipselect),
      .az_data        (sdram_0_s1_writedata),
      .az_rd_n        (sdram_0_s1_read_n),
      .az_wr_n        (sdram_0_s1_write_n),
      .clk            (clk_0),
      .reset_n        (sdram_0_s1_reset_n),
      .za_data        (sdram_0_s1_readdata),
      .za_valid       (sdram_0_s1_readdatavalid),
      .za_waitrequest (sdram_0_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram_0),
      .zs_ba          (zs_ba_from_the_sdram_0),
      .zs_cas_n       (zs_cas_n_from_the_sdram_0),
      .zs_cke         (zs_cke_from_the_sdram_0),
      .zs_cs_n        (zs_cs_n_from_the_sdram_0),
      .zs_dq          (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm         (zs_dqm_from_the_sdram_0),
      .zs_ras_n       (zs_ras_n_from_the_sdram_0),
      .zs_we_n        (zs_we_n_from_the_sdram_0)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                     (clk_0),
      .cpu_0_data_master_address_to_slave                      (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_sysid_control_slave           (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_qualified_request_sysid_control_slave (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_read                                  (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sysid_control_slave   (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_requests_sysid_control_slave          (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_write                                 (cpu_0_data_master_write),
      .d1_sysid_control_slave_end_xfer                         (d1_sysid_control_slave_end_xfer),
      .reset_n                                                 (clk_0_reset_n),
      .sysid_control_slave_address                             (sysid_control_slave_address),
      .sysid_control_slave_readdata                            (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                    (sysid_control_slave_readdata_from_sa),
      .sysid_control_slave_reset_n                             (sysid_control_slave_reset_n)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .clock    (sysid_control_slave_clock),
      .readdata (sysid_control_slave_readdata),
      .reset_n  (sysid_control_slave_reset_n)
    );

  video_character_buffer_with_dma_0_avalon_char_buffer_slave_arbitrator the_video_character_buffer_with_dma_0_avalon_char_buffer_slave
    (
      .clk                                                                                                  (vga_clock),
      .d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer                               (d1_video_character_buffer_with_dma_0_avalon_char_buffer_slave_end_xfer),
      .nios_system_clock_1_out_address_to_slave                                                             (nios_system_clock_1_out_address_to_slave),
      .nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave           (nios_system_clock_1_out_granted_video_character_buffer_with_dma_0_avalon_char_buffer_slave),
      .nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave (nios_system_clock_1_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_buffer_slave),
      .nios_system_clock_1_out_read                                                                         (nios_system_clock_1_out_read),
      .nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave   (nios_system_clock_1_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_buffer_slave),
      .nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave          (nios_system_clock_1_out_requests_video_character_buffer_with_dma_0_avalon_char_buffer_slave),
      .nios_system_clock_1_out_write                                                                        (nios_system_clock_1_out_write),
      .nios_system_clock_1_out_writedata                                                                    (nios_system_clock_1_out_writedata),
      .reset_n                                                                                              (vga_clock_reset_n),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_address                                   (video_character_buffer_with_dma_0_avalon_char_buffer_slave_address),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_byteenable                                (video_character_buffer_with_dma_0_avalon_char_buffer_slave_byteenable),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_chipselect                                (video_character_buffer_with_dma_0_avalon_char_buffer_slave_chipselect),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_read                                      (video_character_buffer_with_dma_0_avalon_char_buffer_slave_read),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata                                  (video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa                          (video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata_from_sa),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest                               (video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa                       (video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest_from_sa),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_write                                     (video_character_buffer_with_dma_0_avalon_char_buffer_slave_write),
      .video_character_buffer_with_dma_0_avalon_char_buffer_slave_writedata                                 (video_character_buffer_with_dma_0_avalon_char_buffer_slave_writedata)
    );

  video_character_buffer_with_dma_0_avalon_char_control_slave_arbitrator the_video_character_buffer_with_dma_0_avalon_char_control_slave
    (
      .clk                                                                                                   (vga_clock),
      .d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer                               (d1_video_character_buffer_with_dma_0_avalon_char_control_slave_end_xfer),
      .nios_system_clock_0_out_address_to_slave                                                              (nios_system_clock_0_out_address_to_slave),
      .nios_system_clock_0_out_byteenable                                                                    (nios_system_clock_0_out_byteenable),
      .nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave           (nios_system_clock_0_out_granted_video_character_buffer_with_dma_0_avalon_char_control_slave),
      .nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave (nios_system_clock_0_out_qualified_request_video_character_buffer_with_dma_0_avalon_char_control_slave),
      .nios_system_clock_0_out_read                                                                          (nios_system_clock_0_out_read),
      .nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave   (nios_system_clock_0_out_read_data_valid_video_character_buffer_with_dma_0_avalon_char_control_slave),
      .nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave          (nios_system_clock_0_out_requests_video_character_buffer_with_dma_0_avalon_char_control_slave),
      .nios_system_clock_0_out_write                                                                         (nios_system_clock_0_out_write),
      .nios_system_clock_0_out_writedata                                                                     (nios_system_clock_0_out_writedata),
      .reset_n                                                                                               (vga_clock_reset_n),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_address                                   (video_character_buffer_with_dma_0_avalon_char_control_slave_address),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_byteenable                                (video_character_buffer_with_dma_0_avalon_char_control_slave_byteenable),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_chipselect                                (video_character_buffer_with_dma_0_avalon_char_control_slave_chipselect),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_read                                      (video_character_buffer_with_dma_0_avalon_char_control_slave_read),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_readdata                                  (video_character_buffer_with_dma_0_avalon_char_control_slave_readdata),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa                          (video_character_buffer_with_dma_0_avalon_char_control_slave_readdata_from_sa),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_reset                                     (video_character_buffer_with_dma_0_avalon_char_control_slave_reset),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_write                                     (video_character_buffer_with_dma_0_avalon_char_control_slave_write),
      .video_character_buffer_with_dma_0_avalon_char_control_slave_writedata                                 (video_character_buffer_with_dma_0_avalon_char_control_slave_writedata)
    );

  video_character_buffer_with_dma_0_avalon_char_source_arbitrator the_video_character_buffer_with_dma_0_avalon_char_source
    (
      .clk                                                                (vga_clock),
      .reset_n                                                            (vga_clock_reset_n),
      .video_character_buffer_with_dma_0_avalon_char_source_data          (video_character_buffer_with_dma_0_avalon_char_source_data),
      .video_character_buffer_with_dma_0_avalon_char_source_endofpacket   (video_character_buffer_with_dma_0_avalon_char_source_endofpacket),
      .video_character_buffer_with_dma_0_avalon_char_source_ready         (video_character_buffer_with_dma_0_avalon_char_source_ready),
      .video_character_buffer_with_dma_0_avalon_char_source_startofpacket (video_character_buffer_with_dma_0_avalon_char_source_startofpacket),
      .video_character_buffer_with_dma_0_avalon_char_source_valid         (video_character_buffer_with_dma_0_avalon_char_source_valid),
      .video_vga_controller_0_avalon_vga_sink_ready_from_sa               (video_vga_controller_0_avalon_vga_sink_ready_from_sa)
    );

  video_character_buffer_with_dma_0 the_video_character_buffer_with_dma_0
    (
      .buf_address          (video_character_buffer_with_dma_0_avalon_char_buffer_slave_address),
      .buf_byteenable       (video_character_buffer_with_dma_0_avalon_char_buffer_slave_byteenable),
      .buf_chipselect       (video_character_buffer_with_dma_0_avalon_char_buffer_slave_chipselect),
      .buf_read             (video_character_buffer_with_dma_0_avalon_char_buffer_slave_read),
      .buf_readdata         (video_character_buffer_with_dma_0_avalon_char_buffer_slave_readdata),
      .buf_waitrequest      (video_character_buffer_with_dma_0_avalon_char_buffer_slave_waitrequest),
      .buf_write            (video_character_buffer_with_dma_0_avalon_char_buffer_slave_write),
      .buf_writedata        (video_character_buffer_with_dma_0_avalon_char_buffer_slave_writedata),
      .clk                  (vga_clock),
      .ctrl_address         (video_character_buffer_with_dma_0_avalon_char_control_slave_address),
      .ctrl_byteenable      (video_character_buffer_with_dma_0_avalon_char_control_slave_byteenable),
      .ctrl_chipselect      (video_character_buffer_with_dma_0_avalon_char_control_slave_chipselect),
      .ctrl_read            (video_character_buffer_with_dma_0_avalon_char_control_slave_read),
      .ctrl_readdata        (video_character_buffer_with_dma_0_avalon_char_control_slave_readdata),
      .ctrl_write           (video_character_buffer_with_dma_0_avalon_char_control_slave_write),
      .ctrl_writedata       (video_character_buffer_with_dma_0_avalon_char_control_slave_writedata),
      .reset                (video_character_buffer_with_dma_0_avalon_char_control_slave_reset),
      .stream_data          (video_character_buffer_with_dma_0_avalon_char_source_data),
      .stream_endofpacket   (video_character_buffer_with_dma_0_avalon_char_source_endofpacket),
      .stream_ready         (video_character_buffer_with_dma_0_avalon_char_source_ready),
      .stream_startofpacket (video_character_buffer_with_dma_0_avalon_char_source_startofpacket),
      .stream_valid         (video_character_buffer_with_dma_0_avalon_char_source_valid)
    );

  video_vga_controller_0_avalon_vga_sink_arbitrator the_video_vga_controller_0_avalon_vga_sink
    (
      .clk                                                                (vga_clock),
      .reset_n                                                            (vga_clock_reset_n),
      .video_character_buffer_with_dma_0_avalon_char_source_data          (video_character_buffer_with_dma_0_avalon_char_source_data),
      .video_character_buffer_with_dma_0_avalon_char_source_endofpacket   (video_character_buffer_with_dma_0_avalon_char_source_endofpacket),
      .video_character_buffer_with_dma_0_avalon_char_source_startofpacket (video_character_buffer_with_dma_0_avalon_char_source_startofpacket),
      .video_character_buffer_with_dma_0_avalon_char_source_valid         (video_character_buffer_with_dma_0_avalon_char_source_valid),
      .video_vga_controller_0_avalon_vga_sink_data                        (video_vga_controller_0_avalon_vga_sink_data),
      .video_vga_controller_0_avalon_vga_sink_endofpacket                 (video_vga_controller_0_avalon_vga_sink_endofpacket),
      .video_vga_controller_0_avalon_vga_sink_ready                       (video_vga_controller_0_avalon_vga_sink_ready),
      .video_vga_controller_0_avalon_vga_sink_ready_from_sa               (video_vga_controller_0_avalon_vga_sink_ready_from_sa),
      .video_vga_controller_0_avalon_vga_sink_reset                       (video_vga_controller_0_avalon_vga_sink_reset),
      .video_vga_controller_0_avalon_vga_sink_startofpacket               (video_vga_controller_0_avalon_vga_sink_startofpacket),
      .video_vga_controller_0_avalon_vga_sink_valid                       (video_vga_controller_0_avalon_vga_sink_valid)
    );

  video_vga_controller_0 the_video_vga_controller_0
    (
      .VGA_B         (VGA_B_from_the_video_vga_controller_0),
      .VGA_BLANK     (VGA_BLANK_from_the_video_vga_controller_0),
      .VGA_CLK       (VGA_CLK_from_the_video_vga_controller_0),
      .VGA_G         (VGA_G_from_the_video_vga_controller_0),
      .VGA_HS        (VGA_HS_from_the_video_vga_controller_0),
      .VGA_R         (VGA_R_from_the_video_vga_controller_0),
      .VGA_SYNC      (VGA_SYNC_from_the_video_vga_controller_0),
      .VGA_VS        (VGA_VS_from_the_video_vga_controller_0),
      .clk           (vga_clock),
      .data          (video_vga_controller_0_avalon_vga_sink_data),
      .endofpacket   (video_vga_controller_0_avalon_vga_sink_endofpacket),
      .ready         (video_vga_controller_0_avalon_vga_sink_ready),
      .reset         (video_vga_controller_0_avalon_vga_sink_reset),
      .startofpacket (video_vga_controller_0_avalon_vga_sink_startofpacket),
      .valid         (video_vga_controller_0_avalon_vga_sink_valid)
    );

  //reset is asserted asynchronously and deasserted synchronously
  nios_system_reset_clk_0_domain_synch_module nios_system_reset_clk_0_domain_synch
    (
      .clk      (clk_0),
      .data_in  (1'b1),
      .data_out (clk_0_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    0);

  //reset is asserted asynchronously and deasserted synchronously
  nios_system_reset_vga_clock_domain_synch_module nios_system_reset_vga_clock_domain_synch
    (
      .clk      (vga_clock),
      .data_in  (1'b1),
      .data_out (vga_clock_reset_n),
      .reset_n  (reset_n_sources)
    );

  //nios_system_clock_0_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign nios_system_clock_0_out_endofpacket = 0;

  //nios_system_clock_1_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign nios_system_clock_1_out_endofpacket = 0;

  //sysid_control_slave_clock of type clock does not connect to anything so wire it to default (0)
  assign sysid_control_slave_clock = 0;


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/altera/quartus/eda/sim_lib/altera_mf.v"
`include "c:/altera/quartus/eda/sim_lib/220model.v"
`include "c:/altera/quartus/eda/sim_lib/sgate.v"
`include "C:/altera/ip/University_Program/Audio_Video/Video/altera_up_avalon_video_vga_controller/hdl/altera_up_avalon_video_vga_timing.v"
`include "video_vga_controller_0.v"
`include "C:/altera/ip/University_Program/Audio_Video/Video/altera_up_avalon_video_character_buffer_with_dma/hdl/altera_up_video_128_character_rom.v"
`include "C:/altera/ip/University_Program/Audio_Video/Video/altera_up_avalon_video_character_buffer_with_dma/hdl/altera_up_video_fb_color_rom.v"
`include "video_character_buffer_with_dma_0.v"
`include "clocks.v"
// Altera_UP_SD_Card_Avalon_Interface_0.vhd
`include "sdram_0.v"
`include "nios_system_clock_1.v"
`include "sysid.v"
`include "cpu_0_test_bench.v"
`include "cpu_0_oci_test_bench.v"
`include "cpu_0_jtag_debug_module_tck.v"
`include "cpu_0_jtag_debug_module_sysclk.v"
`include "cpu_0_jtag_debug_module_wrapper.v"
`include "cpu_0.v"
`include "output1.v"
`include "input1.v"
`include "jtag_uart_0.v"
`include "onchip_memory2_0.v"
`include "nios_system_clock_0.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             VGA_BLANK_from_the_video_vga_controller_0;
  wire    [  7: 0] VGA_B_from_the_video_vga_controller_0;
  wire             VGA_CLK_from_the_video_vga_controller_0;
  wire    [  7: 0] VGA_G_from_the_video_vga_controller_0;
  wire             VGA_HS_from_the_video_vga_controller_0;
  wire    [  7: 0] VGA_R_from_the_video_vga_controller_0;
  wire             VGA_SYNC_from_the_video_vga_controller_0;
  wire             VGA_VS_from_the_video_vga_controller_0;
  wire             b_SD_cmd_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  wire             b_SD_dat3_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  wire             b_SD_dat_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  wire             clk;
  reg              clk_0;
  wire             clocks_SDRAM_CLK_out;
  wire             clocks_sys_clk_out;
  wire    [  7: 0] in_port_to_the_input1;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             nios_system_clock_0_in_endofpacket_from_sa;
  wire             nios_system_clock_0_out_endofpacket;
  wire             nios_system_clock_0_out_nativeaddress;
  wire             nios_system_clock_1_in_endofpacket_from_sa;
  wire             nios_system_clock_1_out_endofpacket;
  wire    [ 12: 0] nios_system_clock_1_out_nativeaddress;
  wire             o_SD_clock_from_the_Altera_UP_SD_Card_Avalon_Interface_0;
  wire    [  7: 0] out_port_from_the_output1;
  reg              reset_n;
  wire             sysid_control_slave_clock;
  reg              vga_clock;
  wire    [ 12: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 31: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  3: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  nios_system DUT
    (
      .VGA_BLANK_from_the_video_vga_controller_0                      (VGA_BLANK_from_the_video_vga_controller_0),
      .VGA_B_from_the_video_vga_controller_0                          (VGA_B_from_the_video_vga_controller_0),
      .VGA_CLK_from_the_video_vga_controller_0                        (VGA_CLK_from_the_video_vga_controller_0),
      .VGA_G_from_the_video_vga_controller_0                          (VGA_G_from_the_video_vga_controller_0),
      .VGA_HS_from_the_video_vga_controller_0                         (VGA_HS_from_the_video_vga_controller_0),
      .VGA_R_from_the_video_vga_controller_0                          (VGA_R_from_the_video_vga_controller_0),
      .VGA_SYNC_from_the_video_vga_controller_0                       (VGA_SYNC_from_the_video_vga_controller_0),
      .VGA_VS_from_the_video_vga_controller_0                         (VGA_VS_from_the_video_vga_controller_0),
      .b_SD_cmd_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0  (b_SD_cmd_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0),
      .b_SD_dat3_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0 (b_SD_dat3_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0),
      .b_SD_dat_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0  (b_SD_dat_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0),
      .clk_0                                                          (clk_0),
      .clocks_SDRAM_CLK_out                                           (clocks_SDRAM_CLK_out),
      .clocks_sys_clk_out                                             (clocks_sys_clk_out),
      .in_port_to_the_input1                                          (in_port_to_the_input1),
      .o_SD_clock_from_the_Altera_UP_SD_Card_Avalon_Interface_0       (o_SD_clock_from_the_Altera_UP_SD_Card_Avalon_Interface_0),
      .out_port_from_the_output1                                      (out_port_from_the_output1),
      .reset_n                                                        (reset_n),
      .vga_clock                                                      (vga_clock),
      .zs_addr_from_the_sdram_0                                       (zs_addr_from_the_sdram_0),
      .zs_ba_from_the_sdram_0                                         (zs_ba_from_the_sdram_0),
      .zs_cas_n_from_the_sdram_0                                      (zs_cas_n_from_the_sdram_0),
      .zs_cke_from_the_sdram_0                                        (zs_cke_from_the_sdram_0),
      .zs_cs_n_from_the_sdram_0                                       (zs_cs_n_from_the_sdram_0),
      .zs_dq_to_and_from_the_sdram_0                                  (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm_from_the_sdram_0                                        (zs_dqm_from_the_sdram_0),
      .zs_ras_n_from_the_sdram_0                                      (zs_ras_n_from_the_sdram_0),
      .zs_we_n_from_the_sdram_0                                       (zs_we_n_from_the_sdram_0)
    );

  initial
    clk_0 = 1'b0;
  always
    #10 clk_0 <= ~clk_0;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end
  initial
    vga_clock = 1'b0;
  always
    #20 vga_clock <= ~vga_clock;
  

endmodule


//synthesis translate_on