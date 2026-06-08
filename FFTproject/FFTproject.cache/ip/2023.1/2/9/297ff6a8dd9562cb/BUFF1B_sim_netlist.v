// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Sun Jun  7 18:54:50 2026
// Host        : dell-Inspiron-5415 running 64-bit Ubuntu 24.04.2 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ BUFF1B_sim_netlist.v
// Design      : BUFF1B
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a15tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "BUFF1B,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [3:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [35:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [3:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [35:0]doutb;

  wire [3:0]addra;
  wire [3:0]addrb;
  wire clka;
  wire [35:0]dina;
  wire [35:0]doutb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [35:0]NLW_U0_douta_UNCONNECTED;
  wire [3:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [35:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "4" *) 
  (* C_ADDRB_WIDTH = "4" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.84935 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "BUFF1B.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "16" *) 
  (* C_READ_DEPTH_B = "16" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "36" *) 
  (* C_READ_WIDTH_B = "36" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "16" *) 
  (* C_WRITE_DEPTH_B = "16" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "36" *) 
  (* C_WRITE_WIDTH_B = "36" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_6 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[35:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[3:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[3:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[35:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
aMT3usC6uizzcwnzOCX4OsS16Ob+YxFcsGovFpFklbnaIaD1S0lVdxenTwHPp6ByIEi+ehwr6Rgg
z/3AlTheI5NFTM8ihiMA18/wmUxI7EbaftJACA1LykUKCuj5myy0T+DACuv3sGYIZS38TZTZnnBC
FGAlvTZmRWs+JzneH3o=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lR9ZerhYSAb39nzEkeYvhnwEs5t9y/+yTDf8KuoUtR1BGeHZq8pA/YxtjzQLtaOW1R1IQUb0FtSI
e3CYAb7WHYbIjcpw3vKHvW1SqcGn9CMGa556CYKmD2oF12Kow8xRaFvMSBUVxX7HsHxNWnRd+PU1
+C0YayU2KFIY/7Yl6cZ5luAzhw/6SW3PFYUIyyqWy5MCIXweHOwQR2IpQEdlDur5nluN7i7BeB+i
fxwwHh8TU/g7T4mhZFkiTuBKdLAtQOjxWxzqTMxgcuAjlTylY16FgMFOASdvvSbqBZJjbxMdVloU
rYjS8O/8rWktv8GXcaIdBJ2BRj01q7jsChsbwA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Qvl63GHz9mq2xOB7elt/vAQ7URLGdD1Lkcz7f3Wtw31dwjjjbP62Ny/Jr6OmBIheWlgejx38qxAT
TrHiiEyjKmGcnPn1Tn2n+cH4RAxCbOFnCI9n6+YsYMTe9JkplGhGGr39SkFgJz0I2IKpPsuqTjCj
rhf49TAryNMQeRpREJA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MA+9Ro+dh339m0iZrkKbqTKN8gQ5xkxN/SPCfhkOn+5jjgCTS5IOKLHil+HsZDjX333ebxnornwG
MOBxyEdFfLM8SA+bs2r41J/j0af2VVMmCM3hOh8JmZxB4X9Jg/glegNCbvwzqxMbOQNEy+zt7j5t
TFVD82RtPFmYVVYZZyll/WvAA+0aVpyjzLCIM1GznFky0RWLv65Wp4MJJnNRRrtG3muMznVO/u2s
tACsJ9jzv9M0IlMYjYH9BixhG6cZX02I4LEXXaPkhdOINlMMhsbArXtc9NphzmS4bY1/1yF1D6YD
EKLyS2Sr3HDl0O/lefN+jvfG8iKuVl55PNNrVQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
wpMTg7STjFkUDhOqdNPa0FHXTnHQgKmhvqDv+rRVBvMiQ8O7u8oj7ibITq3o+jugJsMJ60B410gQ
JFTcqCJKYmYJvqi8rPLLOYDmFG6ZLP/Ixr3n62IyIaCeDltBahi3yV009QN0X+iuzuFCL+Y7g9ff
IvAgyBly+Z3Itv2H9EJMZPMl17Sa7IkgjmWqzVXIKNMKn0iDVYsQw6ZgzQDYQ8N8IvTIEggU3/lh
6Nf0hV0ev3qOv/2P+4w0U766Ux3yLuzPJSI7bKm3/ip9NjhOytxOiKKqVXhKG8dzbbuS5u3EE/eq
q6YxkL7gpvNltVqqBnJB6vHSyWrD6+MqsCtR9A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q7Q4SSp70lxFryaopuic9VVP/Ire0pSsPEIMYdURBAczC7ShkuYeV02U7L3BlAiyBE4vBKcwYSQd
cWiaj8sVP7q4kxoRHKxLV1R5PIO6l4DsLWE2E+1MLyUPME0w5KTular/oX8EPCJ5n/8VCtW7x4Vf
dpeyki1/IAPJkAyi3zVZKHzgKhEwnZaZZtZYuMWoPZMt4V38sAcE42Raf+7yfFWG5HO74JY6iEnW
gJeRk58K+avB/XLF2/j2RQZfjTYizrprT2tUMBK6e7DRWZZtk8AOcsMhUikev44IFGNbNXjP8BXC
0J3y3P7pCFT6l+saU83nRwi/H25fSA34diJtNw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
a/8ooC+s+6nfvfa1+oBhsvYWLJjFgp83DI1kNyOi5Am+ugPbGRmgGZudfyo6yw6Yd5gGbLm5aToQ
5G4cGF5HaXD5TU6A0ZZFMTIbzFLE76JMjjIxX8JcaJIZpSmrXqlru8l5gDINUEAmwUY3mRQnjcGJ
0Z+kMRH8iAEF+gEviPiFZSBbJeOPqivIS217kimQJX3BeNbNPQTP+GUidcRywpGMh5avxtA0kDRO
F9SoCSyTm9hr2v9hsK1IUAYQLb7n2/R+z5YNKNzt1oN4qgJH1wZfdI8if2K8+ohyOdnxrrgJOWdj
cOqr7cGqEOYfBMTIQeHVZzb7NGWVN+9B8XSUaQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
FLPvOUNRWNW2GU+FEGmt2XWthOT5bY/31DRbol2cUmEGNF6b2XzpCosNKGx/o2n6sQvGP39KRFCs
nJu0ihe2dUGee9nEZZUcpwPjnEfXVI3yJaRVYy8iL+rm59lXq0jX4sjAPieDvv8shgAnoXLTZGlq
K+2c1JhaHt+nFi27TDrYar/+P8nP1MhocOS7BjzCvSs0foEXj92/qD+71Sm/LqGr8cjlH2qTJJ8B
ynxoH6iT+bksVA2VbtPT9o6h1kJ/zwP4wcsL9l+qSlJhd4GI11JPux26DlNyIi41WmufQcfiT0PB
r6O9+0E9lV9ODwKdjaxfZRK29rjKeq2yr0jWhMV38XKKqHAJli7MIypGRXcCo+u89H87KgYt+ebw
s3foIqCe0JKR57WzI8VD6XdNtOL8eBxK539oemx4vkE0cGYECZKYru6A2hPeZOYDD5eyWSUlQl1R
EciK49WM8HnssyRVcmE6di6bISMbVi0TZG/v98bz+9UZa8DtqMVYH0tz

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fphquQOeFuqByo36Gh2C1zEC1J6u9swSMbMzsKldIvLm+SZ6/hr/N8KJ/G2vBABzX6UtbVuP1ZXx
AxdftP4Aqis1B3Bs6989aQG9eo0SOHA7r6aFLtFb3qoD5Pvqw4aVNU4z4EtTpFpn/jCWD21lKROf
q5X32HRfFq1jwqod+9vIbUNRRzz5y9VHvXfacZlxDazSPmcCF4hxB1KqWqT44KmYVkDedgkgnYgb
ZGidHnTb3W7C8tSqC9ac4kNJCL429QndtddweESJNlpX+65pt9Irok9pkOodwoj0QScswOIFjhBZ
/GrzZLQcFWiD3gXRU4DazzxQnGdRH4qEIRWziw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
1lUYYHPCt1BUJOvcBbgMU2GSQiqfxItz4ntieMaenjrtsE9SLwaU6xB0tBl8Atw5yP/RRNww1kX/
9uZbTz5He3r9mPVt+mGxB4N3f9BbCrQRb4USVPgKO/+vWUfMQERGklScy0+fz75WuxH74CjRUoDI
8iyssb2cUNnfDe13jIoI8gM1w4w/Pkxkmb6Mef53QMxacHAWEZeytcH3fuL/adO263D8P90U3XJv
vBXJmbjkRVi9qzjBzfMxuOy2KbZaZgR3BLzaffIfFnMwg/Rb8sGls5pQsZv5jL2wk3+Bj3OXBYdd
pDyjGoalJBzObKzd/t15kNHwY4FXYFcZLQPncw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YRmSEzaa2WFVvMH1BwWc1TIUpVbzSEIP0VbI6n0sEgct/X4PiTfMQmK1jBVCaISIzwBxscKQwZOt
mb/nmINGg6I7ih39LSbBMtx6cdCUiyaLkPeRbqfyPpKhvnUIFmdKVvTd1dYzxeOeuDnhSVaBaAcN
3lngSg7lIbmhLIGjC29yQrBTiLArbVZi6IRGronMK51e3UrYa6GspsznhiuRcXjEb4bHKrJ2CM5Z
BUwA+E9949sQgyOagFZbLVle2ESbwBaoxcAPn2gxfRHlT0leqyLgUGDZLsfArzGzw9BTGzyEG2TR
XOrKFNYRfMXMrnGsBM7acIelY4LdAMgsKgDH/A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19520)
`pragma protect data_block
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
+KZkeY0YQrSjvbCiANYrUmi4mANsy2JrLsM=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
