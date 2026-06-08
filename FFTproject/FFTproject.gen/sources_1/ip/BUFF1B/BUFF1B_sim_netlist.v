// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Sun Jun  7 18:54:51 2026
// Host        : dell-Inspiron-5415 running 64-bit Ubuntu 24.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/dell/Desktop/projects/20cred/FFTaccelerator/FFTproject/FFTproject.gen/sources_1/ip/BUFF1B/BUFF1B_sim_netlist.v
// Design      : BUFF1B
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a15tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "BUFF1B,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module BUFF1B
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
  BUFF1B_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19424)
`pragma protect data_block
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
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
