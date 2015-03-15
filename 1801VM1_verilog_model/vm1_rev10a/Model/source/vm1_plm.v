//
// Copyright (c) 2014-2015 by 1801BM1@gmail.com
//
// 1801VM1 programmable logic matrixes (PLM)
//______________________________________________________________________________
//
// Main matrix inputs format:
//
//    ir[15:0] - instruction code latched in instrustion register (opcode)
//    mr[14:0] - microinstruction state word also latched
//       mr[6:0] - address/state field, controlled by PLM outputs
//          sp[0]  -> mr[6]
//          sp[5]  -> mr[5]
//          sp[9]  -> mr[4]
//          sp[15] -> mr[3]
//          sp[19] -> mr[2]
//          sp[24] -> mr[1]
//          spl29] -> mr[0] + reset
//
//       mr[7]  - psw[0] - C (carry) flag or condition
//       mr[8]  - psw[1] - V (overflow) flag or condition)
//       mr[9]  - psw[2] - Z (zero) flag or condition
//       mr[10] - psw[3] - N (negative) flag or condition
//       mr[11] - psw[4] - T (trap) flag
//
//    mr[14:12] - multiplexed
//       priority encoder branch:
//          mr[12]   - sp[9] priority encoder
//          mr[13]   - sp[7] priority encoder
//          mr[14]   - sp[5] priority encoder
//       feedback from main matrix
//          mr[12]   - ~plr17
//          mr[13]   -  plr16
//          mr[14]   - ~plr14
//
// Main matrix outputs format (after SOP inversion):
//    plx[0]   ~mj[6];
//    plx[5]    mj[5]
//    plx[9]    mj[4]
//    plx[12]   opcode is not recognized
//    plx[15]   mj[3]
//    plx[19]  ~mj[2]
//    plx[24]  ~mj[1]
//    plx[29]  ~mj[0]
//______________________________________________________________________________
//
// 1801VM1A main matrix original representation (for identity check)
//
module vm1_plm_model
(
   input  [15:0]  ir,
   input  [14:0]  mr,
   output [33:0]  sp
);
wire [249:2] p;
wire [33:0] pl;

function cmp
(
   input [30:0] i,
   input [30:0] c,
   input [30:0] m
);
   cmp = &(~(i ^ c) | m);
endfunction
//
// Products
//
// assign p[2]   = (ir[15:0] === 16'bxxxxxxx111xxxxxx) & (mr[14:0] === 15'bxxxxxxxx01xx111);
// assign p[3]   = (ir[15:0] === 16'bx00xxxxxxx00xxxx) & (mr[14:0] === 15'b100xxxxx01x1010);
// assign p[4]   = (ir[15:0] === 16'bx00xxxxxxx0x0xxx) & (mr[14:0] === 15'b100xxxxx011101x);
// assign p[5]   = (ir[15:0] === 16'bxxxxxxxxxxxxx111) & (mr[14:0] === 15'bxxxxxxxx100x111);
// assign p[6]   = (ir[15:0] === 16'b0xxxx101xxxxxxxx) & (mr[14:0] === 15'bxxxx1x1x000010x);
// assign p[7]   = (ir[15:0] === 16'bxxxxxx1xxxxxxxxx) & (mr[14:0] === 15'bxxxxx1xx1001x0x);
// assign p[8]   = (ir[15:0] === 16'bx00xxxxxxxxx0xxx) & (mr[14:0] === 15'b100xxxxx011x011);
// assign p[9]   = (ir[15:0] === 16'bx000101111xxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[10]  = (ir[15:0] === 16'b0xxxx1x1xxxxxxxx) & (mr[14:0] === 15'bxxxx000x000010x);
// assign p[11]  = (ir[15:0] === 16'bxxxxx00111000xxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[12]  = (ir[15:0] === 16'bx111xxxxxxxxxxxx) & (mr[14:0] === 15'b0xxxxxxx01x011x);
// assign p[13]  = (ir[15:0] === 16'bxxxxx1x01xxxxxxx) & (mr[14:0] === 15'b1xxxxxxx011x11x);
// assign p[14]  = (ir[15:0] === 16'bx00xxxxxxxxxxxxx) & (mr[14:0] === 15'b100xxxxx0110010);
// assign p[15]  = (ir[15:0] === 16'bxxxxx000xxxxxxxx) & (mr[14:0] === 15'bxxxx1xxx0000100);
// assign p[16]  = (ir[15:0] === 16'bxxxxxxxxxx000111) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[17]  = (ir[15:0] === 16'b1xxxx001xxxxxxxx) & (mr[14:0] === 15'bxxxx0xxx00x010x);
// assign p[18]  = (ir[15:0] === 16'bx00xxxxxxxx00xxx) & (mr[14:0] === 15'b100xxxxx0111010);
// assign p[19]  = (ir[15:0] === 16'bxxxxxxxxxxxx0xxx) & (mr[14:0] === 15'bxxx1xxxx1010x0x);
// assign p[20]  = (ir[15:0] === 16'b0000000001000xxx) & (mr[14:0] === 15'b00xxxxxx11111x0);
// assign p[21]  = (ir[15:0] === 16'b1xxxxx011xxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111000);
// assign p[22]  = (ir[15:0] === 16'b0000100xxx000xxx) & (mr[14:0] === 15'b00xxxxxx11111x0);
// assign p[23]  = (ir[15:0] === 16'bxxxxxxxx1xx0xxxx) & (mr[14:0] === 15'bxxxxxxxx1001001);
// assign p[24]  = (ir[15:0] === 16'b10001000xxxxxxxx) & (mr[14:0] === 15'b00xxxxxxx111110);
// assign p[25]  = (ir[15:0] === 16'b1xxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxx0xxx01x1110);
// assign p[26]  = (ir[15:0] === 16'b1xxxxxxxxxxx011x) & (mr[14:0] === 15'bxx1xxxxx01x1010);
// assign p[27]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'b11xxxxxx0110111);
// assign p[28]  = (ir[15:0] === 16'b1000100xxxxxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[29]  = (ir[15:0] === 16'b0xxx0111xxxxxxxx) & (mr[14:0] === 15'bxxxx101x00x010x);
// assign p[30]  = (ir[15:0] === 16'b0xxxx011xxxxxxxx) & (mr[14:0] === 15'bxxxxx0xx00x010x);
// assign p[31]  = (ir[15:0] === 16'bx001xxxxxx00xxxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[32]  = (ir[15:0] === 16'b1xxxx011xxxxxxxx) & (mr[14:0] === 15'bxxxxx0x000x010x);
// assign p[33]  = (ir[15:0] === 16'bx000xxxxxxxx0xxx) & (mr[14:0] === 15'bx01xxxxx0110011);
// assign p[34]  = (ir[15:0] === 16'bxxxxxxxxxx000xxx) & (mr[14:0] === 15'bxxxxxxxx1111011);
// assign p[35]  = (ir[15:0] === 16'bx000xx1010xxxxxx) & (mr[14:0] === 15'b1xxxxxxx011x11x);
// assign p[36]  = (ir[15:0] === 16'b0000000000000101) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[37]  = (ir[15:0] === 16'b0xxxx1x0xxxxxxxx) & (mr[14:0] === 15'bxxxx0x1x00x010x);
// assign p[38]  = (ir[15:0] === 16'bx001xxxxxx0x0xxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[39]  = (ir[15:0] === 16'bx100xxxxxxxxxxxx) & (mr[14:0] === 15'b0xxxxxxx01x011x);
// assign p[40]  = (ir[15:0] === 16'b1xxxx101xxxxxxxx) & (mr[14:0] === 15'bxxxxxx0x00x010x);
// assign p[41]  = (ir[15:0] === 16'b0xxxx101xxxxxxxx) & (mr[14:0] === 15'bxxxx0x0x000010x);
// assign p[42]  = (ir[15:0] === 16'bx010xxxxxxxxxxxx) & (mr[14:0] === 15'b0xxxxxxx01x011x);
// assign p[43]  = (ir[15:0] === 16'bxxxxxxxxxxxxx111) & (mr[14:0] === 15'bxxxxxxxx01xx11x);
// assign p[44]  = (ir[15:0] === 16'b1xxxx100xxxxxxxx) & (mr[14:0] === 15'bxxxxxx1x00x010x);
// assign p[45]  = (ir[15:0] === 16'b1xxxx111xxxxxxxx) & (mr[14:0] === 15'bxxxxxxx000x010x);
// assign p[46]  = (ir[15:0] === 16'bx001xxxxxxx00xxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[47]  = (ir[15:0] === 16'b1xxxxx10xxxxxxxx) & (mr[14:0] === 15'bxxxxxxx100x010x);
// assign p[48]  = (ir[15:0] === 16'b0000x1x111xxxxxx) & (mr[14:0] === 15'b1xxx1xxx011x11x);
// assign p[49]  = (ir[15:0] === 16'b0xxxx1x0xxxxxxxx) & (mr[14:0] === 15'bxxxx1x0x00x010x);
// assign p[50]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxx1) & (mr[14:0] === 15'bxxxxxxxx000101x);
// assign p[51]  = (ir[15:0] === 16'bx0000xxx1xxxxxxx) & (mr[14:0] === 15'b111xxxxx0110111);
// assign p[52]  = (ir[15:0] === 16'b0xxxx110xxxxxxxx) & (mr[14:0] === 15'bxxxxx1xx00x010x);
// assign p[53]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0100110);
// assign p[54]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxx1xxxxx0110x11);
// assign p[55]  = (ir[15:0] === 16'bxxxxx010xxxxxxxx) & (mr[14:0] === 15'bxxxxx1xx00x010x);
// assign p[56]  = (ir[15:0] === 16'b10001101xx000xxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[57]  = (ir[15:0] === 16'b101xxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxxx1x011x);
// assign p[58]  = (ir[15:0] === 16'bx000xxxxxxxxxxxx) & (mr[14:0] === 15'b000xxxxx011x01x);
// assign p[59]  = (ir[15:0] === 16'bx000xx1101xxxxxx) & (mr[14:0] === 15'b1xxxxxxx011011x);
// assign p[60]  = (ir[15:0] === 16'bx000x1x0x1xxxxxx) & (mr[14:0] === 15'b1xxxxxxx011011x);
// assign p[61]  = (ir[15:0] === 16'bx0000xxxxxxxxxxx) & (mr[14:0] === 15'b100xxxxx0110111);
// assign p[62]  = (ir[15:0] === 16'b0110xxxxxxxxxxxx) & (mr[14:0] === 15'b0xxxxxxx01x011x);
// assign p[63]  = (ir[15:0] === 16'bx001xxxxxxxx0xxx) & (mr[14:0] === 15'bxxxxxxxx0110011);
// assign p[64]  = (ir[15:0] === 16'b1x00x1x111xxxxxx) & (mr[14:0] === 15'b1x1xxxxx0110111);
// assign p[65]  = (ir[15:0] === 16'bx000101xxx000xxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[66]  = (ir[15:0] === 16'bxxxxxxxx10xxxxxx) & (mr[14:0] === 15'bxxxxxxxxx101111);
// assign p[67]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'b000xxxxx11111x0);
// assign p[68]  = (ir[15:0] === 16'bx000xxxxxxxxxxxx) & (mr[14:0] === 15'bx01xxxxx011x010);
// assign p[69]  = (ir[15:0] === 16'bxxxx0xxx0xxxxxx1) & (mr[14:0] === 15'b1xxxx1xx10x1001);
// assign p[70]  = (ir[15:0] === 16'b1000x1x1x0xxxxxx) & (mr[14:0] === 15'b1x1xxxxx0110111);
// assign p[71]  = (ir[15:0] === 16'bx001xxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0110010);
// assign p[72]  = (ir[15:0] === 16'bxxxxxxx11xxxxxxx) & (mr[14:0] === 15'bxxxxxxxxx101111);
// assign p[73]  = (ir[15:0] === 16'bxxxxxxxxxxxxx1xx) & (mr[14:0] === 15'bxxxxxxxx0xx0x1x);
// assign p[74]  = (ir[15:0] === 16'bx0001100xx000xxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[75]  = (ir[15:0] === 16'b0111111xxxxxxxxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[76]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'b0xxxxxxx1110101);
// assign p[77]  = (ir[15:0] === 16'bx00xxxxxxxxxxxxx) & (mr[14:0] === 15'b0xxxxxxx0110111);
// assign p[78]  = (ir[15:0] === 16'bxxxxxxxxxxxxxx1x) & (mr[14:0] === 15'bxxxxxxxx0000x1x);
// assign p[79]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1110000);
// assign p[80]  = (ir[15:0] === 16'bxxxx0xxx10xxxxxx) & (mr[14:0] === 15'bxxxxxxxx1001000);
// assign p[81]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxx1) & (mr[14:0] === 15'bxxxxxxxx0x01110);
// assign p[82]  = (ir[15:0] === 16'b000000001x000xxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[83]  = (ir[15:0] === 16'bxxxx000xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111000);
// assign p[84]  = (ir[15:0] === 16'b0xxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx01x1110);
// assign p[85]  = (ir[15:0] === 16'bxxxxxxxxxxxxx1xx) & (mr[14:0] === 15'bxxxxxxxx0x1xx1x);
// assign p[86]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1100110);
// assign p[87]  = (ir[15:0] === 16'bxxxxxxxxxxxxxx1x) & (mr[14:0] === 15'bxxxxxxxx0x01110);
// assign p[88]  = (ir[15:0] === 16'b1xxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1001x00);
// assign p[89]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxx1) & (mr[14:0] === 15'bxxxxxxxx001xx1x);
// assign p[90]  = (ir[15:0] === 16'bxxxxxxxxxxxxx1xx) & (mr[14:0] === 15'bxxxxxxxx000101x);
// assign p[91]  = (ir[15:0] === 16'b0000000000000000) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[92]  = (ir[15:0] === 16'bxxxxxxxx1xxxxxxx) & (mr[14:0] === 15'bxxxxxxxxxx1100x);
// assign p[93]  = (ir[15:0] === 16'bxxxxxxxxxxxxx1xx) & (mr[14:0] === 15'bxxxxxxxx0001110);
// assign p[94]  = (ir[15:0] === 16'bxxxxxxxxxxxx1xxx) & (mr[14:0] === 15'bxxxxxxxx0010101);
// assign p[95]  = (ir[15:0] === 16'bxxxxxxx1xxxxxxxx) & (mr[14:0] === 15'bxxxxxxxxx1001x1);
// assign p[96]  = (ir[15:0] === 16'bxxxxxxxx0xxxxxxx) & (mr[14:0] === 15'bxxxxxxxxx101111);
// assign p[97]  = (ir[15:0] === 16'bx10xxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx011001x);
// assign p[98]  = (ir[15:0] === 16'bxxxxxxxxxxxxxx1x) & (mr[14:0] === 15'bxxxxxxxx000101x);
// assign p[99]  = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1100011);
// assign p[100] = (ir[15:0] === 16'bxxxxxxxxxx1xxxxx) & (mr[14:0] === 15'bxxxxxxxxx101010);
// assign p[101] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1000010);
// assign p[102] = (ir[15:0] === 16'bxxxxxxx1xxxxxxxx) & (mr[14:0] === 15'bxxxxxxxxxx1100x);
// assign p[103] = (ir[15:0] === 16'bx000xx1000xxxxxx) & (mr[14:0] === 15'b1xxxxxxx011011x);
// assign p[104] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bx0xxxxxx1101x11);
// assign p[105] = (ir[15:0] === 16'bxxxxxxxxxx101xxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[106] = (ir[15:0] === 16'bxxxxxxxxx1xxxxxx) & (mr[14:0] === 15'bxxxxxxxxxx1100x);
// assign p[107] = (ir[15:0] === 16'b0000110111000xxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[108] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxx1xxxxx1101000);
// assign p[109] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'b1xxxxxxx1110101);
// assign p[110] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0000x01);
// assign p[111] = (ir[15:0] === 16'bx01xxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx010011x);
// assign p[112] = (ir[15:0] === 16'bxxxxxxx1xxxxxxxx) & (mr[14:0] === 15'bxxxxxxxxx01010x);
// assign p[113] = (ir[15:0] === 16'bxxxxxxxx1xxxxxxx) & (mr[14:0] === 15'bxxxxxxxxx1001x1);
// assign p[114] = (ir[15:0] === 16'bx000x1x1x1xxxxxx) & (mr[14:0] === 15'bxxxxxxxx011011x);
// assign p[115] = (ir[15:0] === 16'bxxxxxxxxxxxxxxx1) & (mr[14:0] === 15'bxxxxxxxx0x00x1x);
// assign p[116] = (ir[15:0] === 16'bxx00xxxxxxxxxxxx) & (mr[14:0] === 15'bx1xxxxxx011001x);
// assign p[117] = (ir[15:0] === 16'b0xxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx01xx01x);
// assign p[118] = (ir[15:0] === 16'b0111100xxx000xxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[119] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx11x1111);
// assign p[120] = (ir[15:0] === 16'bxxxxxxxxxxxxxx1x) & (mr[14:0] === 15'bxxxxxxxx010xx1x);
// assign p[121] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx100111x);
// assign p[122] = (ir[15:0] === 16'bxxxx0xxxxx0xxxx0) & (mr[14:0] === 15'bxxx0xxxx10x1001);
// assign p[123] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1010011);
// assign p[124] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'b10xxxxxxx111110);
// assign p[125] = (ir[15:0] === 16'b1000000xxxxxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[126] = (ir[15:0] === 16'bxxxxxxxxxxxx1xxx) & (mr[14:0] === 15'bxxxxxxxx1010000);
// assign p[127] = (ir[15:0] === 16'bxxxxxxxxxx011xxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[128] = (ir[15:0] === 16'bx000xxxxxxxxxxxx) & (mr[14:0] === 15'bx1xxxxxx0111x10);
// assign p[129] = (ir[15:0] === 16'bxxxx101xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111000);
// assign p[130] = (ir[15:0] === 16'b00000001xxxxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[131] = (ir[15:0] === 16'bxxxxxxxxxx11xxxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[132] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxxx100101);
// assign p[133] = (ir[15:0] === 16'bxxxx0xxx0xxxx0x1) & (mr[14:0] === 15'bxxxxxxxx1001x00);
// assign p[134] = (ir[15:0] === 16'bx000x00xxxxxxxxx) & (mr[14:0] === 15'b1xxxxxxx0110111);
// assign p[135] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1101010);
// assign p[136] = (ir[15:0] === 16'b0001xxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx010011x);
// assign p[137] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'b01xxxxxxx111110);
// assign p[138] = (ir[15:0] === 16'bxxxxxxxxx1xxxxxx) & (mr[14:0] === 15'bxxxxxxxxx101111);
// assign p[139] = (ir[15:0] === 16'b0000000000001xxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[140] = (ir[15:0] === 16'bx000xx1111xxxxxx) & (mr[14:0] === 15'b1xxxxxxx011011x);
// assign p[141] = (ir[15:0] === 16'bxxxx0xxx0xxxxxx1) & (mr[14:0] === 15'b0xxxx1xx10x1001);
// assign p[142] = (ir[15:0] === 16'bxxxxxxxxx1xxxxxx) & (mr[14:0] === 15'bxxxxxxxxx1001x1);
// assign p[143] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1100001);
// assign p[144] = (ir[15:0] === 16'bx000x1x0xxxxxxxx) & (mr[14:0] === 15'b1xxxxxxx011011x);
// assign p[145] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1000110);
// assign p[146] = (ir[15:0] === 16'bx000xx1001xxxxxx) & (mr[14:0] === 15'b1xxxxxxx011011x);
// assign p[147] = (ir[15:0] === 16'b1xxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx01x1110);
// assign p[148] = (ir[15:0] === 16'bxxxxxxxxxxxx1xxx) & (mr[14:0] === 15'bxxxxxxxx0110011);
// assign p[149] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bx1xxxxxx1101011);
// assign p[150] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1100010);
// assign p[151] = (ir[15:0] === 16'bxx1xxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx011001x);
// assign p[152] = (ir[15:0] === 16'bx01x000xxx000xxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[153] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1010010);
// assign p[154] = (ir[15:0] === 16'bxxxxxxxxxxxx0xxx) & (mr[14:0] === 15'bxxxxxxxx00x0101);
// assign p[155] = (ir[15:0] === 16'bxxxx011xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111000);
// assign p[156] = (ir[15:0] === 16'bxxxx11xxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111000);
// assign p[157] = (ir[15:0] === 16'bxxxx10xxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx100100x);
// assign p[158] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx111x100);
// assign p[159] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx011111x);
// assign p[160] = (ir[15:0] === 16'bxxxxxxxxxxxxx0xx) & (mr[14:0] === 15'bxxxxxxxx1010101);
// assign p[161] = (ir[15:0] === 16'bx10xxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[162] = (ir[15:0] === 16'bxxxxxxx0xxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0010100);
// assign p[163] = (ir[15:0] === 16'bxxxxxxxxxxxxxxx1) & (mr[14:0] === 15'bxxxxxxxx01xxx1x);
// assign p[164] = (ir[15:0] === 16'bxxxxxxxxxxx1xxxx) & (mr[14:0] === 15'bxxxxxxxxx101010);
// assign p[165] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1100000);
// assign p[166] = (ir[15:0] === 16'bxx11xxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx01x011x);
// assign p[167] = (ir[15:0] === 16'bx000xx1110xxxxxx) & (mr[14:0] === 15'b1xxxxxxx011011x);
// assign p[168] = (ir[15:0] === 16'bx10xxxxxxxxxxxxx) & (mr[14:0] === 15'b0xxxxxxx01x011x);
// assign p[169] = (ir[15:0] === 16'b100xxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx010011x);
// assign p[170] = (ir[15:0] === 16'b1x0xxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxxx1x011x);
// assign p[171] = (ir[15:0] === 16'bx000xx101xxxxxxx) & (mr[14:0] === 15'b1xxxxxxx011011x);
// assign p[172] = (ir[15:0] === 16'bxx10xxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx01x011x);
// assign p[173] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1000x11);
// assign p[174] = (ir[15:0] === 16'bxx01000xxx000xxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[175] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'b11xxxxxxx111110);
// assign p[176] = (ir[15:0] === 16'bxxxxxxxxxxxxx1xx) & (mr[14:0] === 15'bxxxxxxxx01xxx1x);
// assign p[177] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx11x1100);
// assign p[178] = (ir[15:0] === 16'bxxxxxx1xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx101xx00);
// assign p[179] = (ir[15:0] === 16'bx000xx110xxxxxxx) & (mr[14:0] === 15'b1xxxxxxx011011x);
// assign p[180] = (ir[15:0] === 16'bxx1xxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[181] = (ir[15:0] === 16'bx1x0000xxx000xxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[182] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx110111x);
// assign p[183] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'b0xxxxxxx0110x11);
// assign p[184] = (ir[15:0] === 16'bxxxxxx1xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111x01);
// assign p[185] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxx0xxxxx1101000);
// assign p[186] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx10111x0);
// assign p[187] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bx0xxxxxx011x01x);
// assign p[188] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1011111);
// assign p[189] = (ir[15:0] === 16'bx000010xxxxxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[190] = (ir[15:0] === 16'bxxxxxxxx1xxxxxxx) & (mr[14:0] === 15'bxxxxxxxx10x100x);
// assign p[191] = (ir[15:0] === 16'b0000110100xxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[192] = (ir[15:0] === 16'b0xxx000011000xxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[193] = (ir[15:0] === 16'b0000000000000011) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[194] = (ir[15:0] === 16'b0000000000000100) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[195] = (ir[15:0] === 16'bxxxxxxx1xxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx10x100x);
// assign p[196] = (ir[15:0] === 16'b00000000101xxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[197] = (ir[15:0] === 16'bx0000x1xxxxxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[198] = (ir[15:0] === 16'bxxxxxxxxxxxxxx1x) & (mr[14:0] === 15'bxxxxxxxx0x1xx1x);
// assign p[199] = (ir[15:0] === 16'bxxxx0xxxx00xx0x0) & (mr[14:0] === 15'bxxx1xxxx100100x);
// assign p[200] = (ir[15:0] === 16'b0000000000000x10) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[201] = (ir[15:0] === 16'b0000000000000001) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[202] = (ir[15:0] === 16'bxxxx0xxxx00xx1x1) & (mr[14:0] === 15'bxxxxxxxx1001000);
// assign p[203] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0110001);
// assign p[204] = (ir[15:0] === 16'b0xxxx10xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1001x00);
// assign p[205] = (ir[15:0] === 16'b0000000001xxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[206] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx101x100);
// assign p[207] = (ir[15:0] === 16'bxxxx001xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111000);
// assign p[208] = (ir[15:0] === 16'bxxxx0xxx0xxxxxx0) & (mr[14:0] === 15'bxxx0xxxx1001x00);
// assign p[209] = (ir[15:0] === 16'bxxxx0xxx00xxx1x1) & (mr[14:0] === 15'bxxxxx0xx1001x01);
// assign p[210] = (ir[15:0] === 16'b1000110100xxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[211] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1010001);
// assign p[212] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx101110x);
// assign p[213] = (ir[15:0] === 16'b1xxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx10x1001);
// assign p[214] = (ir[15:0] === 16'bxxxxxxxxxxxxx1xx) & (mr[14:0] === 15'bxxxxxxxx1010101);
// assign p[215] = (ir[15:0] === 16'bxxxx0xxx11xxxxxx) & (mr[14:0] === 15'bxxxxxxxx1001x0x);
// assign p[216] = (ir[15:0] === 16'bxxxx0xxxx00xx1x0) & (mr[14:0] === 15'bxxx1xxxx1001000);
// assign p[217] = (ir[15:0] === 16'b0xxxx1xxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx10x1001);
// assign p[218] = (ir[15:0] === 16'bxxxxxxx00xxxx1x0) & (mr[14:0] === 15'bxxx1xxxx1001001);
// assign p[219] = (ir[15:0] === 16'bxxxx0xxxxx1xxxxx) & (mr[14:0] === 15'bxxxxxxxx10x1001);
// assign p[220] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx100110x);
// assign p[221] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0110010);
// assign p[222] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1111011);
// assign p[223] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxx0xxxxx01xx0xx);
// assign p[224] = (ir[15:0] === 16'bx000100xxxxxxxxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[225] = (ir[15:0] === 16'bxxxxxxxxxxxx0xxx) & (mr[14:0] === 15'bxxxxxxxx1010x0x);
// assign p[226] = (ir[15:0] === 16'bxxxxxx0xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111x01);
// assign p[227] = (ir[15:0] === 16'bxxxxxxxxxx001xxx) & (mr[14:0] === 15'bxxxxxxxx0111010);
// assign p[228] = (ir[15:0] === 16'bxxxxxx1xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1001x0x);
// assign p[229] = (ir[15:0] === 16'bx0001100xxxxxxxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[230] = (ir[15:0] === 16'bxxxx100xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111000);
// assign p[231] = (ir[15:0] === 16'bxxxxxx0xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1011x00);
// assign p[232] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1x01111);
// assign p[233] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1x0x1x1);
// assign p[234] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0110111);
// assign p[235] = (ir[15:0] === 16'b0000000011xxxxxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[236] = (ir[15:0] === 16'bxxxx010xxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0111000);
// assign p[237] = (ir[15:0] === 16'bxxxxxxxxxxxx0xxx) & (mr[14:0] === 15'bxxxxxxxx0110011);
// assign p[238] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx01xx11x);
// assign p[239] = (ir[15:0] === 16'bxxxxxxxxxx100xxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[240] = (ir[15:0] === 16'bxxxxxxxxxx010xxx) & (mr[14:0] === 15'bxxxxxxxx0111x10);
// assign p[241] = (ir[15:0] === 16'bx10xxxxxxxxxxxxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[242] = (ir[15:0] === 16'bx000110111xxxxxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[243] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx0000100);
// assign p[244] = (ir[15:0] === 16'bx000101xxxxxxxxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[245] = (ir[15:0] === 16'b0111100xxxxxxxxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[246] = (ir[15:0] === 16'bxxxxxxxxxxxxxxxx) & (mr[14:0] === 15'bxxxxxxxx1011001);
// assign p[247] = (ir[15:0] === 16'bx1x0xxxxxxxxxxxx) & (mr[14:0] === 15'b001xxxxx11111x0);
// assign p[248] = (ir[15:0] === 16'bx01xxxxxxxxxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
// assign p[249] = (ir[15:0] === 16'bxx01xxxxxxxxxxxx) & (mr[14:0] === 15'b001xxxxxx111110);
//
assign p[2]   = cmp({ir,mr}, 31'bxxxxxxx111xxxxxxxxxxxxxx01xx111, 31'b1111111000111111111111110011000);
assign p[3]   = cmp({ir,mr}, 31'bx00xxxxxxx00xxxx100xxxxx01x1010, 31'b1001111111001111000111110010000);
assign p[4]   = cmp({ir,mr}, 31'bx00xxxxxxx0x0xxx100xxxxx011101x, 31'b1001111111010111000111110000001);
assign p[5]   = cmp({ir,mr}, 31'bxxxxxxxxxxxxx111xxxxxxxx100x111, 31'b1111111111111000111111110001000);
assign p[6]   = cmp({ir,mr}, 31'b0xxxx101xxxxxxxxxxxx1x1x000010x, 31'b0111100011111111111101010000001);
assign p[7]   = cmp({ir,mr}, 31'bxxxxxx1xxxxxxxxxxxxxx1xx1001x0x, 31'b1111110111111111111110110000101);
assign p[8]   = cmp({ir,mr}, 31'bx00xxxxxxxxx0xxx100xxxxx011x011, 31'b1001111111110111000111110001000);
assign p[9]   = cmp({ir,mr}, 31'bx000101111xxxxxx001xxxxxx111110, 31'b1000000000111111000111111000000);
assign p[10]  = cmp({ir,mr}, 31'b0xxxx1x1xxxxxxxxxxxx000x000010x, 31'b0111101011111111111100010000001);
assign p[11]  = cmp({ir,mr}, 31'bxxxxx00111000xxx001xxxxx11111x0, 31'b1111100000000111000111110000010);
assign p[12]  = cmp({ir,mr}, 31'bx111xxxxxxxxxxxx0xxxxxxx01x011x, 31'b1000111111111111011111110010001);
assign p[13]  = cmp({ir,mr}, 31'bxxxxx1x01xxxxxxx1xxxxxxx011x11x, 31'b1111101001111111011111110001001);
assign p[14]  = cmp({ir,mr}, 31'bx00xxxxxxxxxxxxx100xxxxx0110010, 31'b1001111111111111000111110000000);
assign p[15]  = cmp({ir,mr}, 31'bxxxxx000xxxxxxxxxxxx1xxx0000100, 31'b1111100011111111111101110000000);
assign p[16]  = cmp({ir,mr}, 31'bxxxxxxxxxx000111001xxxxxx111110, 31'b1111111111000000000111111000000);
assign p[17]  = cmp({ir,mr}, 31'b1xxxx001xxxxxxxxxxxx0xxx00x010x, 31'b0111100011111111111101110010001);
assign p[18]  = cmp({ir,mr}, 31'bx00xxxxxxxx00xxx100xxxxx0111010, 31'b1001111111100111000111110000000);
assign p[19]  = cmp({ir,mr}, 31'bxxxxxxxxxxxx0xxxxxx1xxxx1010x0x, 31'b1111111111110111111011110000101);
assign p[20]  = cmp({ir,mr}, 31'b0000000001000xxx00xxxxxx11111x0, 31'b0000000000000111001111110000010);
assign p[21]  = cmp({ir,mr}, 31'b1xxxxx011xxxxxxxxxxxxxxx0111000, 31'b0111110001111111111111110000000);
assign p[22]  = cmp({ir,mr}, 31'b0000100xxx000xxx00xxxxxx11111x0, 31'b0000000111000111001111110000010);
assign p[23]  = cmp({ir,mr}, 31'bxxxxxxxx1xx0xxxxxxxxxxxx1001001, 31'b1111111101101111111111110000000);
assign p[24]  = cmp({ir,mr}, 31'b10001000xxxxxxxx00xxxxxxx111110, 31'b0000000011111111001111111000000);
assign p[25]  = cmp({ir,mr}, 31'b1xxxxxxxxxxxxxxxxxxx0xxx01x1110, 31'b0111111111111111111101110010000);
assign p[26]  = cmp({ir,mr}, 31'b1xxxxxxxxxxx011xxx1xxxxx01x1010, 31'b0111111111110001110111110010000);
assign p[27]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxx11xxxxxx0110111, 31'b1111111111111111001111110000000);
assign p[28]  = cmp({ir,mr}, 31'b1000100xxxxxxxxx001xxxxxx111110, 31'b0000000111111111000111111000000);
assign p[29]  = cmp({ir,mr}, 31'b0xxx0111xxxxxxxxxxxx101x00x010x, 31'b0111000011111111111100010010001);
assign p[30]  = cmp({ir,mr}, 31'b0xxxx011xxxxxxxxxxxxx0xx00x010x, 31'b0111100011111111111110110010001);
assign p[31]  = cmp({ir,mr}, 31'bx001xxxxxx00xxxxxxxxxxxx0111x10, 31'b1000111111001111111111110000100);
assign p[32]  = cmp({ir,mr}, 31'b1xxxx011xxxxxxxxxxxxx0x000x010x, 31'b0111100011111111111110100010001);
assign p[33]  = cmp({ir,mr}, 31'bx000xxxxxxxx0xxxx01xxxxx0110011, 31'b1000111111110111100111110000000);
assign p[34]  = cmp({ir,mr}, 31'bxxxxxxxxxx000xxxxxxxxxxx1111011, 31'b1111111111000111111111110000000);
assign p[35]  = cmp({ir,mr}, 31'bx000xx1010xxxxxx1xxxxxxx011x11x, 31'b1000110000111111011111110001001);
assign p[36]  = cmp({ir,mr}, 31'b0000000000000101001xxxxx11111x0, 31'b0000000000000000000111110000010);
assign p[37]  = cmp({ir,mr}, 31'b0xxxx1x0xxxxxxxxxxxx0x1x00x010x, 31'b0111101011111111111101010010001);
assign p[38]  = cmp({ir,mr}, 31'bx001xxxxxx0x0xxxxxxxxxxx0111x10, 31'b1000111111010111111111110000100);
assign p[39]  = cmp({ir,mr}, 31'bx100xxxxxxxxxxxx0xxxxxxx01x011x, 31'b1000111111111111011111110010001);
assign p[40]  = cmp({ir,mr}, 31'b1xxxx101xxxxxxxxxxxxxx0x00x010x, 31'b0111100011111111111111010010001);
assign p[41]  = cmp({ir,mr}, 31'b0xxxx101xxxxxxxxxxxx0x0x000010x, 31'b0111100011111111111101010000001);
assign p[42]  = cmp({ir,mr}, 31'bx010xxxxxxxxxxxx0xxxxxxx01x011x, 31'b1000111111111111011111110010001);
assign p[43]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxx111xxxxxxxx01xx11x, 31'b1111111111111000111111110011001);
assign p[44]  = cmp({ir,mr}, 31'b1xxxx100xxxxxxxxxxxxxx1x00x010x, 31'b0111100011111111111111010010001);
assign p[45]  = cmp({ir,mr}, 31'b1xxxx111xxxxxxxxxxxxxxx000x010x, 31'b0111100011111111111111100010001);
assign p[46]  = cmp({ir,mr}, 31'bx001xxxxxxx00xxxxxxxxxxx0111x10, 31'b1000111111100111111111110000100);
assign p[47]  = cmp({ir,mr}, 31'b1xxxxx10xxxxxxxxxxxxxxx100x010x, 31'b0111110011111111111111100010001);
assign p[48]  = cmp({ir,mr}, 31'b0000x1x111xxxxxx1xxx1xxx011x11x, 31'b0000101000111111011101110001001);
assign p[49]  = cmp({ir,mr}, 31'b0xxxx1x0xxxxxxxxxxxx1x0x00x010x, 31'b0111101011111111111101010010001);
assign p[50]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxx1xxxxxxxx000101x, 31'b1111111111111110111111110000001);
assign p[51]  = cmp({ir,mr}, 31'bx0000xxx1xxxxxxx111xxxxx0110111, 31'b1000011101111111000111110000000);
assign p[52]  = cmp({ir,mr}, 31'b0xxxx110xxxxxxxxxxxxx1xx00x010x, 31'b0111100011111111111110110010001);
assign p[53]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx0100110, 31'b1111111111111111111111110000000);
assign p[54]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxx1xxxxx0110x11, 31'b1111111111111111110111110000100);
assign p[55]  = cmp({ir,mr}, 31'bxxxxx010xxxxxxxxxxxxx1xx00x010x, 31'b1111100011111111111110110010001);
assign p[56]  = cmp({ir,mr}, 31'b10001101xx000xxx001xxxxxx111110, 31'b0000000011000111000111111000000);
assign p[57]  = cmp({ir,mr}, 31'b101xxxxxxxxxxxxxxxxxxxxxx1x011x, 31'b0001111111111111111111111010001);
assign p[58]  = cmp({ir,mr}, 31'bx000xxxxxxxxxxxx000xxxxx011x01x, 31'b1000111111111111000111110001001);
assign p[59]  = cmp({ir,mr}, 31'bx000xx1101xxxxxx1xxxxxxx011011x, 31'b1000110000111111011111110000001);
assign p[60]  = cmp({ir,mr}, 31'bx000x1x0x1xxxxxx1xxxxxxx011011x, 31'b1000101010111111011111110000001);
assign p[61]  = cmp({ir,mr}, 31'bx0000xxxxxxxxxxx100xxxxx0110111, 31'b1000011111111111000111110000000);
assign p[62]  = cmp({ir,mr}, 31'b0110xxxxxxxxxxxx0xxxxxxx01x011x, 31'b0000111111111111011111110010001);
assign p[63]  = cmp({ir,mr}, 31'bx001xxxxxxxx0xxxxxxxxxxx0110011, 31'b1000111111110111111111110000000);
assign p[64]  = cmp({ir,mr}, 31'b1x00x1x111xxxxxx1x1xxxxx0110111, 31'b0100101000111111010111110000000);
assign p[65]  = cmp({ir,mr}, 31'bx000101xxx000xxx001xxxxx11111x0, 31'b1000000111000111000111110000010);
assign p[66]  = cmp({ir,mr}, 31'bxxxxxxxx10xxxxxxxxxxxxxxx101111, 31'b1111111100111111111111111000000);
assign p[67]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxx000xxxxx11111x0, 31'b1111111111111111000111110000010);
assign p[68]  = cmp({ir,mr}, 31'bx000xxxxxxxxxxxxx01xxxxx011x010, 31'b1000111111111111100111110001000);
assign p[69]  = cmp({ir,mr}, 31'bxxxx0xxx0xxxxxx11xxxx1xx10x1001, 31'b1111011101111110011110110010000);
assign p[70]  = cmp({ir,mr}, 31'b1000x1x1x0xxxxxx1x1xxxxx0110111, 31'b0000101010111111010111110000000);
assign p[71]  = cmp({ir,mr}, 31'bx001xxxxxxxxxxxxxxxxxxxx0110010, 31'b1000111111111111111111110000000);
assign p[72]  = cmp({ir,mr}, 31'bxxxxxxx11xxxxxxxxxxxxxxxx101111, 31'b1111111001111111111111111000000);
assign p[73]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxx1xxxxxxxxxx0xx0x1x, 31'b1111111111111011111111110110101);
assign p[74]  = cmp({ir,mr}, 31'bx0001100xx000xxx001xxxxx11111x0, 31'b1000000011000111000111110000010);
assign p[75]  = cmp({ir,mr}, 31'b0111111xxxxxxxxx001xxxxx11111x0, 31'b0000000111111111000111110000010);
assign p[76]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxx0xxxxxxx1110101, 31'b1111111111111111011111110000000);
assign p[77]  = cmp({ir,mr}, 31'bx00xxxxxxxxxxxxx0xxxxxxx0110111, 31'b1001111111111111011111110000000);
assign p[78]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxx1xxxxxxxxx0000x1x, 31'b1111111111111101111111110000101);
assign p[79]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1110000, 31'b1111111111111111111111110000000);
assign p[80]  = cmp({ir,mr}, 31'bxxxx0xxx10xxxxxxxxxxxxxx1001000, 31'b1111011100111111111111110000000);
assign p[81]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxx1xxxxxxxx0x01110, 31'b1111111111111110111111110100000);
assign p[82]  = cmp({ir,mr}, 31'b000000001x000xxx001xxxxxx111110, 31'b0000000001000111000111111000000);
assign p[83]  = cmp({ir,mr}, 31'bxxxx000xxxxxxxxxxxxxxxxx0111000, 31'b1111000111111111111111110000000);
assign p[84]  = cmp({ir,mr}, 31'b0xxxxxxxxxxxxxxxxxxxxxxx01x1110, 31'b0111111111111111111111110010000);
assign p[85]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxx1xxxxxxxxxx0x1xx1x, 31'b1111111111111011111111110101101);
assign p[86]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1100110, 31'b1111111111111111111111110000000);
assign p[87]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxx1xxxxxxxxx0x01110, 31'b1111111111111101111111110100000);
assign p[88]  = cmp({ir,mr}, 31'b1xxxxxxxxxxxxxxxxxxxxxxx1001x00, 31'b0111111111111111111111110000100);
assign p[89]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxx1xxxxxxxx001xx1x, 31'b1111111111111110111111110001101);
assign p[90]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxx1xxxxxxxxxx000101x, 31'b1111111111111011111111110000001);
assign p[91]  = cmp({ir,mr}, 31'b0000000000000000001xxxxxx111110, 31'b0000000000000000000111111000000);
assign p[92]  = cmp({ir,mr}, 31'bxxxxxxxx1xxxxxxxxxxxxxxxxx1100x, 31'b1111111101111111111111111100001);
assign p[93]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxx1xxxxxxxxxx0001110, 31'b1111111111111011111111110000000);
assign p[94]  = cmp({ir,mr}, 31'bxxxxxxxxxxxx1xxxxxxxxxxx0010101, 31'b1111111111110111111111110000000);
assign p[95]  = cmp({ir,mr}, 31'bxxxxxxx1xxxxxxxxxxxxxxxxx1001x1, 31'b1111111011111111111111111000010);
assign p[96]  = cmp({ir,mr}, 31'bxxxxxxxx0xxxxxxxxxxxxxxxx101111, 31'b1111111101111111111111111000000);
assign p[97]  = cmp({ir,mr}, 31'bx10xxxxxxxxxxxxxxxxxxxxx011001x, 31'b1001111111111111111111110000001);
assign p[98]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxx1xxxxxxxxx000101x, 31'b1111111111111101111111110000001);
assign p[99]  = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1100011, 31'b1111111111111111111111110000000);
assign p[100] = cmp({ir,mr}, 31'bxxxxxxxxxx1xxxxxxxxxxxxxx101010, 31'b1111111111011111111111111000000);
assign p[101] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1000010, 31'b1111111111111111111111110000000);
assign p[102] = cmp({ir,mr}, 31'bxxxxxxx1xxxxxxxxxxxxxxxxxx1100x, 31'b1111111011111111111111111100001);
assign p[103] = cmp({ir,mr}, 31'bx000xx1000xxxxxx1xxxxxxx011011x, 31'b1000110000111111011111110000001);
assign p[104] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxx0xxxxxx1101x11, 31'b1111111111111111101111110000100);
assign p[105] = cmp({ir,mr}, 31'bxxxxxxxxxx101xxxxxxxxxxx0111x10, 31'b1111111111000111111111110000100);
assign p[106] = cmp({ir,mr}, 31'bxxxxxxxxx1xxxxxxxxxxxxxxxx1100x, 31'b1111111110111111111111111100001);
assign p[107] = cmp({ir,mr}, 31'b0000110111000xxx001xxxxxx111110, 31'b0000000000000111000111111000000);
assign p[108] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxx1xxxxx1101000, 31'b1111111111111111110111110000000);
assign p[109] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxx1xxxxxxx1110101, 31'b1111111111111111011111110000000);
assign p[110] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx0000x01, 31'b1111111111111111111111110000100);
assign p[111] = cmp({ir,mr}, 31'bx01xxxxxxxxxxxxxxxxxxxxx010011x, 31'b1001111111111111111111110000001);
assign p[112] = cmp({ir,mr}, 31'bxxxxxxx1xxxxxxxxxxxxxxxxx01010x, 31'b1111111011111111111111111000001);
assign p[113] = cmp({ir,mr}, 31'bxxxxxxxx1xxxxxxxxxxxxxxxx1001x1, 31'b1111111101111111111111111000010);
assign p[114] = cmp({ir,mr}, 31'bx000x1x1x1xxxxxxxxxxxxxx011011x, 31'b1000101010111111111111110000001);
assign p[115] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxx1xxxxxxxx0x00x1x, 31'b1111111111111110111111110100101);
assign p[116] = cmp({ir,mr}, 31'bxx00xxxxxxxxxxxxx1xxxxxx011001x, 31'b1100111111111111101111110000001);
assign p[117] = cmp({ir,mr}, 31'b0xxxxxxxxxxxxxxxxxxxxxxx01xx01x, 31'b0111111111111111111111110011001);
assign p[118] = cmp({ir,mr}, 31'b0111100xxx000xxx001xxxxxx111110, 31'b0000000111000111000111111000000);
assign p[119] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx11x1111, 31'b1111111111111111111111110010000);
assign p[120] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxx1xxxxxxxxx010xx1x, 31'b1111111111111101111111110001101);
assign p[121] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx100111x, 31'b1111111111111111111111110000001);
assign p[122] = cmp({ir,mr}, 31'bxxxx0xxxxx0xxxx0xxx0xxxx10x1001, 31'b1111011111011110111011110010000);
assign p[123] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1010011, 31'b1111111111111111111111110000000);
assign p[124] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxx10xxxxxxx111110, 31'b1111111111111111001111111000000);
assign p[125] = cmp({ir,mr}, 31'b1000000xxxxxxxxx001xxxxxx111110, 31'b0000000111111111000111111000000);
assign p[126] = cmp({ir,mr}, 31'bxxxxxxxxxxxx1xxxxxxxxxxx1010000, 31'b1111111111110111111111110000000);
assign p[127] = cmp({ir,mr}, 31'bxxxxxxxxxx011xxxxxxxxxxx0111x10, 31'b1111111111000111111111110000100);
assign p[128] = cmp({ir,mr}, 31'bx000xxxxxxxxxxxxx1xxxxxx0111x10, 31'b1000111111111111101111110000100);
assign p[129] = cmp({ir,mr}, 31'bxxxx101xxxxxxxxxxxxxxxxx0111000, 31'b1111000111111111111111110000000);
assign p[130] = cmp({ir,mr}, 31'b00000001xxxxxxxx001xxxxxx111110, 31'b0000000011111111000111111000000);
assign p[131] = cmp({ir,mr}, 31'bxxxxxxxxxx11xxxxxxxxxxxx0111x10, 31'b1111111111001111111111110000100);
assign p[132] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxxx100101, 31'b1111111111111111111111111000000);
assign p[133] = cmp({ir,mr}, 31'bxxxx0xxx0xxxx0x1xxxxxxxx1001x00, 31'b1111011101111010111111110000100);
assign p[134] = cmp({ir,mr}, 31'bx000x00xxxxxxxxx1xxxxxxx0110111, 31'b1000100111111111011111110000000);
assign p[135] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1101010, 31'b1111111111111111111111110000000);
assign p[136] = cmp({ir,mr}, 31'b0001xxxxxxxxxxxxxxxxxxxx010011x, 31'b0000111111111111111111110000001);
assign p[137] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxx01xxxxxxx111110, 31'b1111111111111111001111111000000);
assign p[138] = cmp({ir,mr}, 31'bxxxxxxxxx1xxxxxxxxxxxxxxx101111, 31'b1111111110111111111111111000000);
assign p[139] = cmp({ir,mr}, 31'b0000000000001xxx001xxxxxx111110, 31'b0000000000000111000111111000000);
assign p[140] = cmp({ir,mr}, 31'bx000xx1111xxxxxx1xxxxxxx011011x, 31'b1000110000111111011111110000001);
assign p[141] = cmp({ir,mr}, 31'bxxxx0xxx0xxxxxx10xxxx1xx10x1001, 31'b1111011101111110011110110010000);
assign p[142] = cmp({ir,mr}, 31'bxxxxxxxxx1xxxxxxxxxxxxxxx1001x1, 31'b1111111110111111111111111000010);
assign p[143] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1100001, 31'b1111111111111111111111110000000);
assign p[144] = cmp({ir,mr}, 31'bx000x1x0xxxxxxxx1xxxxxxx011011x, 31'b1000101011111111011111110000001);
assign p[145] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1000110, 31'b1111111111111111111111110000000);
assign p[146] = cmp({ir,mr}, 31'bx000xx1001xxxxxx1xxxxxxx011011x, 31'b1000110000111111011111110000001);
assign p[147] = cmp({ir,mr}, 31'b1xxxxxxxxxxxxxxxxxxxxxxx01x1110, 31'b0111111111111111111111110010000);
assign p[148] = cmp({ir,mr}, 31'bxxxxxxxxxxxx1xxxxxxxxxxx0110011, 31'b1111111111110111111111110000000);
assign p[149] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxx1xxxxxx1101011, 31'b1111111111111111101111110000000);
assign p[150] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1100010, 31'b1111111111111111111111110000000);
assign p[151] = cmp({ir,mr}, 31'bxx1xxxxxxxxxxxxxxxxxxxxx011001x, 31'b1101111111111111111111110000001);
assign p[152] = cmp({ir,mr}, 31'bx01x000xxx000xxx001xxxxxx111110, 31'b1001000111000111000111111000000);
assign p[153] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1010010, 31'b1111111111111111111111110000000);
assign p[154] = cmp({ir,mr}, 31'bxxxxxxxxxxxx0xxxxxxxxxxx00x0101, 31'b1111111111110111111111110010000);
assign p[155] = cmp({ir,mr}, 31'bxxxx011xxxxxxxxxxxxxxxxx0111000, 31'b1111000111111111111111110000000);
assign p[156] = cmp({ir,mr}, 31'bxxxx11xxxxxxxxxxxxxxxxxx0111000, 31'b1111001111111111111111110000000);
assign p[157] = cmp({ir,mr}, 31'bxxxx10xxxxxxxxxxxxxxxxxx100100x, 31'b1111001111111111111111110000001);
assign p[158] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx111x100, 31'b1111111111111111111111110001000);
assign p[159] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx011111x, 31'b1111111111111111111111110000001);
assign p[160] = cmp({ir,mr}, 31'bxxxxxxxxxxxxx0xxxxxxxxxx1010101, 31'b1111111111111011111111110000000);
assign p[161] = cmp({ir,mr}, 31'bx10xxxxxxxxxxxxxxxxxxxxx0111x10, 31'b1001111111111111111111110000100);
assign p[162] = cmp({ir,mr}, 31'bxxxxxxx0xxxxxxxxxxxxxxxx0010100, 31'b1111111011111111111111110000000);
assign p[163] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxx1xxxxxxxx01xxx1x, 31'b1111111111111110111111110011101);
assign p[164] = cmp({ir,mr}, 31'bxxxxxxxxxxx1xxxxxxxxxxxxx101010, 31'b1111111111101111111111111000000);
assign p[165] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1100000, 31'b1111111111111111111111110000000);
assign p[166] = cmp({ir,mr}, 31'bxx11xxxxxxxxxxxxxxxxxxxx01x011x, 31'b1100111111111111111111110010001);
assign p[167] = cmp({ir,mr}, 31'bx000xx1110xxxxxx1xxxxxxx011011x, 31'b1000110000111111011111110000001);
assign p[168] = cmp({ir,mr}, 31'bx10xxxxxxxxxxxxx0xxxxxxx01x011x, 31'b1001111111111111011111110010001);
assign p[169] = cmp({ir,mr}, 31'b100xxxxxxxxxxxxxxxxxxxxx010011x, 31'b0001111111111111111111110000001);
assign p[170] = cmp({ir,mr}, 31'b1x0xxxxxxxxxxxxxxxxxxxxxx1x011x, 31'b0101111111111111111111111010001);
assign p[171] = cmp({ir,mr}, 31'bx000xx101xxxxxxx1xxxxxxx011011x, 31'b1000110001111111011111110000001);
assign p[172] = cmp({ir,mr}, 31'bxx10xxxxxxxxxxxxxxxxxxxx01x011x, 31'b1100111111111111111111110010001);
assign p[173] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1000x11, 31'b1111111111111111111111110000100);
assign p[174] = cmp({ir,mr}, 31'bxx01000xxx000xxx001xxxxxx111110, 31'b1100000111000111000111111000000);
assign p[175] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxx11xxxxxxx111110, 31'b1111111111111111001111111000000);
assign p[176] = cmp({ir,mr}, 31'bxxxxxxxxxxxxx1xxxxxxxxxx01xxx1x, 31'b1111111111111011111111110011101);
assign p[177] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx11x1100, 31'b1111111111111111111111110010000);
assign p[178] = cmp({ir,mr}, 31'bxxxxxx1xxxxxxxxxxxxxxxxx101xx00, 31'b1111110111111111111111110001100);
assign p[179] = cmp({ir,mr}, 31'bx000xx110xxxxxxx1xxxxxxx011011x, 31'b1000110001111111011111110000001);
assign p[180] = cmp({ir,mr}, 31'bxx1xxxxxxxxxxxxxxxxxxxxx0111x10, 31'b1101111111111111111111110000100);
assign p[181] = cmp({ir,mr}, 31'bx1x0000xxx000xxx001xxxxx11111x0, 31'b1010000111000111000111110000010);
assign p[182] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx110111x, 31'b1111111111111111111111110000001);
assign p[183] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxx0xxxxxxx0110x11, 31'b1111111111111111011111110000100);
assign p[184] = cmp({ir,mr}, 31'bxxxxxx1xxxxxxxxxxxxxxxxx0111x01, 31'b1111110111111111111111110000100);
assign p[185] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxx0xxxxx1101000, 31'b1111111111111111110111110000000);
assign p[186] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx10111x0, 31'b1111111111111111111111110000010);
assign p[187] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxx0xxxxxx011x01x, 31'b1111111111111111101111110001001);
assign p[188] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1011111, 31'b1111111111111111111111110000000);
assign p[189] = cmp({ir,mr}, 31'bx000010xxxxxxxxx001xxxxxx111110, 31'b1000000111111111000111111000000);
assign p[190] = cmp({ir,mr}, 31'bxxxxxxxx1xxxxxxxxxxxxxxx10x100x, 31'b1111111101111111111111110010001);
assign p[191] = cmp({ir,mr}, 31'b0000110100xxxxxx001xxxxxx111110, 31'b0000000000111111000111111000000);
assign p[192] = cmp({ir,mr}, 31'b0xxx000011000xxx001xxxxxx111110, 31'b0111000000000111000111111000000);
assign p[193] = cmp({ir,mr}, 31'b0000000000000011001xxxxxx111110, 31'b0000000000000000000111111000000);
assign p[194] = cmp({ir,mr}, 31'b0000000000000100001xxxxxx111110, 31'b0000000000000000000111111000000);
assign p[195] = cmp({ir,mr}, 31'bxxxxxxx1xxxxxxxxxxxxxxxx10x100x, 31'b1111111011111111111111110010001);
assign p[196] = cmp({ir,mr}, 31'b00000000101xxxxx001xxxxxx111110, 31'b0000000000011111000111111000000);
assign p[197] = cmp({ir,mr}, 31'bx0000x1xxxxxxxxx001xxxxxx111110, 31'b1000010111111111000111111000000);
assign p[198] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxx1xxxxxxxxx0x1xx1x, 31'b1111111111111101111111110101101);
assign p[199] = cmp({ir,mr}, 31'bxxxx0xxxx00xx0x0xxx1xxxx100100x, 31'b1111011110011010111011110000001);
assign p[200] = cmp({ir,mr}, 31'b0000000000000x10001xxxxxx111110, 31'b0000000000000100000111111000000);
assign p[201] = cmp({ir,mr}, 31'b0000000000000001001xxxxxx111110, 31'b0000000000000000000111111000000);
assign p[202] = cmp({ir,mr}, 31'bxxxx0xxxx00xx1x1xxxxxxxx1001000, 31'b1111011110011010111111110000000);
assign p[203] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx0110001, 31'b1111111111111111111111110000000);
assign p[204] = cmp({ir,mr}, 31'b0xxxx10xxxxxxxxxxxxxxxxx1001x00, 31'b0111100111111111111111110000100);
assign p[205] = cmp({ir,mr}, 31'b0000000001xxxxxx001xxxxxx111110, 31'b0000000000111111000111111000000);
assign p[206] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx101x100, 31'b1111111111111111111111110001000);
assign p[207] = cmp({ir,mr}, 31'bxxxx001xxxxxxxxxxxxxxxxx0111000, 31'b1111000111111111111111110000000);
assign p[208] = cmp({ir,mr}, 31'bxxxx0xxx0xxxxxx0xxx0xxxx1001x00, 31'b1111011101111110111011110000100);
assign p[209] = cmp({ir,mr}, 31'bxxxx0xxx00xxx1x1xxxxx0xx1001x01, 31'b1111011100111010111110110000100);
assign p[210] = cmp({ir,mr}, 31'b1000110100xxxxxx001xxxxxx111110, 31'b0000000000111111000111111000000);
assign p[211] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1010001, 31'b1111111111111111111111110000000);
assign p[212] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx101110x, 31'b1111111111111111111111110000001);
assign p[213] = cmp({ir,mr}, 31'b1xxxxxxxxxxxxxxxxxxxxxxx10x1001, 31'b0111111111111111111111110010000);
assign p[214] = cmp({ir,mr}, 31'bxxxxxxxxxxxxx1xxxxxxxxxx1010101, 31'b1111111111111011111111110000000);
assign p[215] = cmp({ir,mr}, 31'bxxxx0xxx11xxxxxxxxxxxxxx1001x0x, 31'b1111011100111111111111110000101);
assign p[216] = cmp({ir,mr}, 31'bxxxx0xxxx00xx1x0xxx1xxxx1001000, 31'b1111011110011010111011110000000);
assign p[217] = cmp({ir,mr}, 31'b0xxxx1xxxxxxxxxxxxxxxxxx10x1001, 31'b0111101111111111111111110010000);
assign p[218] = cmp({ir,mr}, 31'bxxxxxxx00xxxx1x0xxx1xxxx1001001, 31'b1111111001111010111011110000000);
assign p[219] = cmp({ir,mr}, 31'bxxxx0xxxxx1xxxxxxxxxxxxx10x1001, 31'b1111011111011111111111110010000);
assign p[220] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx100110x, 31'b1111111111111111111111110000001);
assign p[221] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx0110010, 31'b1111111111111111111111110000000);
assign p[222] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1111011, 31'b1111111111111111111111110000000);
assign p[223] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxx0xxxxx01xx0xx, 31'b1111111111111111110111110011011);
assign p[224] = cmp({ir,mr}, 31'bx000100xxxxxxxxx001xxxxx11111x0, 31'b1000000111111111000111110000010);
assign p[225] = cmp({ir,mr}, 31'bxxxxxxxxxxxx0xxxxxxxxxxx1010x0x, 31'b1111111111110111111111110000101);
assign p[226] = cmp({ir,mr}, 31'bxxxxxx0xxxxxxxxxxxxxxxxx0111x01, 31'b1111110111111111111111110000100);
assign p[227] = cmp({ir,mr}, 31'bxxxxxxxxxx001xxxxxxxxxxx0111010, 31'b1111111111000111111111110000000);
assign p[228] = cmp({ir,mr}, 31'bxxxxxx1xxxxxxxxxxxxxxxxx1001x0x, 31'b1111110111111111111111110000101);
assign p[229] = cmp({ir,mr}, 31'bx0001100xxxxxxxx001xxxxx11111x0, 31'b1000000011111111000111110000010);
assign p[230] = cmp({ir,mr}, 31'bxxxx100xxxxxxxxxxxxxxxxx0111000, 31'b1111000111111111111111110000000);
assign p[231] = cmp({ir,mr}, 31'bxxxxxx0xxxxxxxxxxxxxxxxx1011x00, 31'b1111110111111111111111110000100);
assign p[232] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1x01111, 31'b1111111111111111111111110100000);
assign p[233] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1x0x1x1, 31'b1111111111111111111111110101010);
assign p[234] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx0110111, 31'b1111111111111111111111110000000);
assign p[235] = cmp({ir,mr}, 31'b0000000011xxxxxx001xxxxx11111x0, 31'b0000000000111111000111110000010);
assign p[236] = cmp({ir,mr}, 31'bxxxx010xxxxxxxxxxxxxxxxx0111000, 31'b1111000111111111111111110000000);
assign p[237] = cmp({ir,mr}, 31'bxxxxxxxxxxxx0xxxxxxxxxxx0110011, 31'b1111111111110111111111110000000);
assign p[238] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx01xx11x, 31'b1111111111111111111111110011001);
assign p[239] = cmp({ir,mr}, 31'bxxxxxxxxxx100xxxxxxxxxxx0111x10, 31'b1111111111000111111111110000100);
assign p[240] = cmp({ir,mr}, 31'bxxxxxxxxxx010xxxxxxxxxxx0111x10, 31'b1111111111000111111111110000100);
assign p[241] = cmp({ir,mr}, 31'bx10xxxxxxxxxxxxx001xxxxx11111x0, 31'b1001111111111111000111110000010);
assign p[242] = cmp({ir,mr}, 31'bx000110111xxxxxx001xxxxx11111x0, 31'b1000000000111111000111110000010);
assign p[243] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx0000100, 31'b1111111111111111111111110000000);
assign p[244] = cmp({ir,mr}, 31'bx000101xxxxxxxxx001xxxxx11111x0, 31'b1000000111111111000111110000010);
assign p[245] = cmp({ir,mr}, 31'b0111100xxxxxxxxx001xxxxx11111x0, 31'b0000000111111111000111110000010);
assign p[246] = cmp({ir,mr}, 31'bxxxxxxxxxxxxxxxxxxxxxxxx1011001, 31'b1111111111111111111111110000000);
assign p[247] = cmp({ir,mr}, 31'bx1x0xxxxxxxxxxxx001xxxxx11111x0, 31'b1010111111111111000111110000010);
assign p[248] = cmp({ir,mr}, 31'bx01xxxxxxxxxxxxx001xxxxxx111110, 31'b1001111111111111000111111000000);
assign p[249] = cmp({ir,mr}, 31'bxx01xxxxxxxxxxxx001xxxxxx111110, 31'b1100111111111111000111111000000);

//
// Summ-Of-Products
//
assign sp = ~pl;
assign pl[0]   = p[246] | p[243] | p[236] | p[234] | p[231] | p[230] | p[228] | p[226] | p[225] | p[220]
               | p[219] | p[217] | p[215] | p[213] | p[212] | p[211] | p[209] | p[208] | p[207] | p[206]
               | p[204] | p[203] | p[202] | p[201] | p[200] | p[199] | p[196] | p[195] | p[194] | p[193]
               | p[191] | p[190] | p[188] | p[186] | p[185] | p[182] | p[179] | p[178] | p[177] | p[175]
               | p[173] | p[172] | p[171] | p[168] | p[167] | p[166] | p[165] | p[162] | p[160] | p[159]
               | p[158] | p[157] | p[154] | p[153] | p[150] | p[149] | p[147] | p[146] | p[144] | p[143]
               | p[141] | p[139] | p[137] | p[136] | p[133] | p[126] | p[124] | p[123] | p[122] | p[119]
               | p[114] | p[112] | p[109] | p[108] | p[107] | p[104] | p[103] | p[101] | p[99]  | p[96]
               | p[94]  | p[91]  | p[86]  | p[84]  | p[79]  | p[76]  | p[75]  | p[74]  | p[69]  | p[67]
               | p[66]  | p[65]  | p[36]  | p[34]  | p[28]  | p[22]  | p[20];

assign pl[1]   = p[249] | p[248] | p[247] | p[246] | p[245] | p[244] | p[243] | p[242] | p[241] | p[240]
               | p[239] | p[237] | p[236] | p[235] | p[234] | p[232] | p[231] | p[230] | p[229] | p[228]
               | p[227] | p[226] | p[225] | p[224] | p[222] | p[221] | p[220] | p[218] | p[217] | p[216]
               | p[215] | p[214] | p[213] | p[212] | p[211] | p[210] | p[209] | p[207] | p[206] | p[205]
               | p[204] | p[203] | p[202] | p[201] | p[200] | p[199] | p[197] | p[196] | p[195] | p[194]
               | p[193] | p[191] | p[189] | p[188] | p[186] | p[185] | p[184] | p[178] | p[177] | p[175]
               | p[173] | p[169] | p[165] | p[164] | p[162] | p[160] | p[159] | p[158] | p[157] | p[156]
               | p[155] | p[153] | p[150] | p[149] | p[148] | p[145] | p[143] | p[141] | p[139] | p[138]
               | p[137] | p[135] | p[133] | p[132] | p[131] | p[130] | p[129] | p[127] | p[126] | p[125]
               | p[124] | p[123] | p[122] | p[121] | p[112] | p[110] | p[109] | p[108] | p[105] | p[104]
               | p[101] | p[100] | p[99]  | p[96]  | p[91]  | p[86]  | p[83]  | p[82]  | p[80]  | p[79]
               | p[76]  | p[75]  | p[69]  | p[66]  | p[43]  | p[36]  | p[2];

assign pl[2]   = p[232] | p[218] | p[216] | p[196] | p[192] | p[181] | p[174] | p[154] | p[152] | p[119]
               | p[118] | p[110] | p[107] | p[94]  | p[74]  | p[67]  | p[65]  | p[56];

assign pl[3]   = p[236] | p[230] | p[226] | p[208] | p[207] | p[206] | p[203] | p[200] | p[184] | p[182]
               | p[180] | p[175] | p[161] | p[158] | p[156] | p[155] | p[154] | p[153] | p[151] | p[148]
               | p[145] | p[137] | p[135] | p[131] | p[129] | p[128] | p[127] | p[126] | p[116] | p[105]
               | p[101] | p[97]  | p[94]  | p[68]  | p[58]  | p[33];

assign pl[4]   = p[225] | p[215] | p[209] | p[202] | p[179] | p[178] | p[172] | p[169] | p[167] | p[146]
               | p[144] | p[140] | p[103] | p[84]  | p[72];

assign pl[5]   = p[246] | p[231] | p[225] | p[218] | p[217] | p[216] | p[214] | p[212] | p[211] | p[209]
               | p[206] | p[204] | p[202] | p[201] | p[200] | p[197] | p[196] | p[191] | p[189] | p[186]
               | p[178] | p[175] | p[173] | p[162] | p[158] | p[157] | p[153] | p[145] | p[141] | p[139]
               | p[134] | p[130] | p[126] | p[125] | p[123] | p[110] | p[107] | p[96]  | p[88]  | p[80]
               | p[75]  | p[74]  | p[70]  | p[66]  | p[65]  | p[36]  | p[34];

assign pl[6]   = p[249] | p[248] | p[247] | p[246] | p[245] | p[244] | p[243] | p[242] | p[241] | p[238]
               | p[235] | p[232] | p[231] | p[229] | p[228] | p[225] | p[224] | p[223] | p[222] | p[220]
               | p[219] | p[218] | p[217] | p[216] | p[215] | p[214] | p[213] | p[212] | p[211] | p[210]
               | p[209] | p[208] | p[206] | p[205] | p[204] | p[202] | p[201] | p[200] | p[199] | p[197]
               | p[196] | p[195] | p[194] | p[193] | p[191] | p[190] | p[189] | p[188] | p[186] | p[185]
               | p[184] | p[182] | p[178] | p[177] | p[175] | p[173] | p[165] | p[164] | p[162] | p[160]
               | p[158] | p[157] | p[156] | p[155] | p[154] | p[153] | p[150] | p[149] | p[148] | p[145]
               | p[143] | p[141] | p[139] | p[137] | p[135] | p[133] | p[132] | p[131] | p[130] | p[129]
               | p[127] | p[126] | p[125] | p[124] | p[123] | p[122] | p[121] | p[119] | p[117] | p[112]
               | p[110] | p[109] | p[108] | p[105] | p[104] | p[101] | p[100] | p[99]  | p[94]  | p[91]
               | p[86]  | p[83]  | p[82]  | p[79]  | p[76]  | p[75]  | p[69]  | p[67]  | p[36];

assign pl[7]   = p[246] | p[243] | p[238] | p[236] | p[232] | p[231] | p[230] | p[228] | p[226] | p[225]
               | p[222] | p[220] | p[219] | p[218] | p[217] | p[216] | p[215] | p[214] | p[213] | p[212]
               | p[211] | p[209] | p[208] | p[207] | p[204] | p[203] | p[202] | p[201] | p[200] | p[196]
               | p[192] | p[191] | p[188] | p[187] | p[186] | p[185] | p[184] | p[182] | p[181] | p[178]
               | p[177] | p[175] | p[174] | p[173] | p[165] | p[164] | p[162] | p[160] | p[158] | p[156]
               | p[155] | p[154] | p[153] | p[152] | p[150] | p[148] | p[145] | p[143] | p[139] | p[135]
               | p[133] | p[132] | p[131] | p[129] | p[127] | p[126] | p[123] | p[118] | p[112] | p[110]
               | p[109] | p[108] | p[107] | p[105] | p[101] | p[100] | p[88]  | p[86]  | p[83]  | p[80]
               | p[74]  | p[65]  | p[56];

assign pl[8]   = p[246] | p[243] | p[238] | p[231] | p[228] | p[225] | p[222] | p[220] | p[219] | p[217]
               | p[215] | p[214] | p[213] | p[212] | p[211] | p[209] | p[204] | p[202] | p[201] | p[195]
               | p[191] | p[190] | p[188] | p[186] | p[185] | p[178] | p[177] | p[173] | p[165] | p[164]
               | p[162] | p[160] | p[157] | p[154] | p[150] | p[149] | p[143] | p[139] | p[132] | p[124]
               | p[123] | p[112] | p[109] | p[108] | p[104] | p[100] | p[99]  | p[86]  | p[83]  | p[71]
               | p[63]  | p[46]  | p[38]  | p[31]  | p[18]  | p[14]  | p[8]   | p[4]   | p[3];

assign pl[9]   = p[246] | p[245] | p[243] | p[240] | p[239] | p[234] | p[232] | p[228] | p[225] | p[220]
               | p[217] | p[215] | p[214] | p[213] | p[209] | p[204] | p[202] | p[201] | p[200] | p[197]
               | p[196] | p[192] | p[191] | p[189] | p[188] | p[185] | p[181] | p[178] | p[177] | p[174]
               | p[173] | p[169] | p[160] | p[159] | p[158] | p[152] | p[150] | p[149] | p[141] | p[138]
               | p[137] | p[130] | p[125] | p[124] | p[112] | p[108] | p[107] | p[104] | p[101] | p[99]
               | p[96]  | p[88]  | p[86]  | p[83]  | p[82]  | p[80]  | p[79]  | p[76]  | p[74]  | p[69]
               | p[66]  | p[65]  | p[56]  | p[43]  | p[36]  | p[34]  | p[2];

assign pl[10]  = p[237] | p[234] | p[226] | p[225] | p[222] | p[221] | p[214] | p[211] | p[203] | p[186]
               | p[184] | p[173] | p[165] | p[162] | p[160] | p[159] | p[158] | p[150] | p[148] | p[123]
               | p[112] | p[36];

assign pl[11]  = p[246] | p[240] | p[237] | p[236] | p[232] | p[227] | p[226] | p[222] | p[221] | p[220]
               | p[219] | p[218] | p[217] | p[216] | p[215] | p[213] | p[212] | p[211] | p[208] | p[207]
               | p[204] | p[203] | p[200] | p[196] | p[192] | p[184] | p[183] | p[182] | p[181] | p[177]
               | p[174] | p[173] | p[172] | p[169] | p[168] | p[166] | p[165] | p[162] | p[159] | p[158]
               | p[156] | p[155] | p[154] | p[152] | p[148] | p[145] | p[144] | p[138] | p[136] | p[135]
               | p[134] | p[132] | p[131] | p[127] | p[123] | p[118] | p[112] | p[110] | p[108] | p[107]
               | p[100] | p[94]  | p[86]  | p[83]  | p[74]  | p[65]  | p[64] | p[56];

assign pl[12]  = p[249] | p[248] | p[247] | p[246] | p[245] | p[244] | p[243] | p[242] | p[241] | p[240]
               | p[239] | p[238] | p[237] | p[236] | p[235] | p[232] | p[231] | p[230] | p[229] | p[228]
               | p[227] | p[226] | p[225] | p[224] | p[222] | p[221] | p[220] | p[219] | p[218] | p[217]
               | p[216] | p[215] | p[214] | p[213] | p[212] | p[211] | p[210] | p[209] | p[208] | p[207]
               | p[206] | p[205] | p[204] | p[203] | p[202] | p[201] | p[200] | p[199] | p[197] | p[196]
               | p[195] | p[194] | p[193] | p[191] | p[190] | p[189] | p[188] | p[186] | p[185] | p[184]
               | p[182] | p[178] | p[177] | p[175] | p[173] | p[165] | p[164] | p[162] | p[160] | p[158]
               | p[157] | p[156] | p[155] | p[154] | p[153] | p[150] | p[149] | p[148] | p[145] | p[143]
               | p[141] | p[139] | p[137] | p[135] | p[133] | p[132] | p[131] | p[130] | p[129] | p[127]
               | p[126] | p[125] | p[124] | p[123] | p[122] | p[121] | p[119] | p[112] | p[110] | p[109]
               | p[108] | p[105] | p[104] | p[101] | p[100] | p[99]  | p[94]  | p[91]  | p[86]  | p[83]
               | p[82]  | p[79]  | p[76]  | p[75]  | p[69]  | p[67]  | p[36];

assign pl[13]  = p[246] | p[243] | p[239] | p[237] | p[231] | p[230] | p[228] | p[226] | p[225] | p[222]
               | p[221] | p[220] | p[219] | p[217] | p[214] | p[213] | p[212] | p[211] | p[209] | p[206]
               | p[204] | p[203] | p[202] | p[201] | p[195] | p[191] | p[188] | p[186] | p[185] | p[184]
               | p[183] | p[179] | p[178] | p[175] | p[173] | p[172] | p[171] | p[169] | p[168] | p[167]
               | p[166] | p[165] | p[164] | p[162] | p[160] | p[159] | p[158] | p[157] | p[154] | p[153]
               | p[150] | p[149] | p[148] | p[147] | p[146] | p[143] | p[140] | p[139] | p[137] | p[136]
               | p[132] | p[129] | p[126] | p[124] | p[123] | p[114] | p[112] | p[109] | p[105] | p[104]
               | p[103] | p[101] | p[99]  | p[96]  | p[94]  | p[84]  | p[80]  | p[72]  | p[70]  | p[66];

assign pl[14]  = p[246] | p[244] | p[243] | p[242] | p[240] | p[239] | p[237] | p[236] | p[235] | p[232]
               | p[230] | p[229] | p[228] | p[227] | p[226] | p[224] | p[222] | p[221] | p[220] | p[218]
               | p[217] | p[216] | p[212] | p[211] | p[210] | p[209] | p[208] | p[207] | p[206] | p[205]
               | p[204] | p[203] | p[202] | p[201] | p[200] | p[199] | p[196] | p[194] | p[193] | p[191]
               | p[188] | p[185] | p[184] | p[182] | p[181] | p[179] | p[178] | p[177] | p[175] | p[174]
               | p[173] | p[172] | p[171] | p[169] | p[167] | p[165] | p[164] | p[162] | p[159] | p[158]
               | p[157] | p[156] | p[155] | p[154] | p[153] | p[152] | p[149] | p[148] | p[145] | p[143]
               | p[141] | p[139] | p[137] | p[136] | p[135] | p[132] | p[131] | p[129] | p[127] | p[126]
               | p[124] | p[123] | p[122] | p[121] | p[118] | p[114] | p[112] | p[110] | p[108] | p[105]
               | p[104] | p[103] | p[101] | p[100] | p[99]  | p[94]  | p[83]  | p[80]  | p[77]  | p[72];

assign pl[15]  = p[245] | p[237] | p[232] | p[227] | p[221] | p[218] | p[217] | p[216] | p[214] | p[211]
               | p[206] | p[200] | p[197] | p[189] | p[185] | p[184] | p[181] | p[174] | p[173] | p[165]
               | p[164] | p[162] | p[158] | p[155] | p[153] | p[152] | p[150] | p[148] | p[145] | p[143]
               | p[139] | p[137] | p[131] | p[130] | p[129] | p[127] | p[126] | p[125] | p[123] | p[121]
               | p[110] | p[109] | p[108] | p[105] | p[101] | p[100] | p[83]  | p[77];

assign pl[16]  = p[248] | p[246] | p[243] | p[240] | p[237] | p[236] | p[232] | p[227] | p[226] | p[225]
               | p[224] | p[222] | p[221] | p[220] | p[219] | p[218] | p[217] | p[216] | p[215] | p[214]
               | p[213] | p[212] | p[211] | p[210] | p[208] | p[207] | p[206] | p[205] | p[204] | p[203]
               | p[202] | p[201] | p[200] | p[199] | p[196] | p[194] | p[193] | p[192] | p[191] | p[188]
               | p[184] | p[182] | p[181] | p[177] | p[175] | p[174] | p[173] | p[169] | p[168] | p[165]
               | p[162] | p[160] | p[159] | p[158] | p[156] | p[155] | p[154] | p[153] | p[150] | p[148]
               | p[147] | p[145] | p[144] | p[143] | p[139] | p[138] | p[137] | p[136] | p[135] | p[134]
               | p[133] | p[132] | p[131] | p[127] | p[123] | p[122] | p[121] | p[118] | p[114] | p[112]
               | p[110] | p[109] | p[108] | p[107] | p[103] | p[101] | p[100] | p[99]  | p[96]  | p[94]
               | p[86]  | p[84]  | p[83]  | p[80]  | p[77]  | p[74]  | p[70]  | p[65]  | p[62]  | p[59]
               | p[56]  | p[35]  | p[9];

assign pl[17]  = p[249] | p[248] | p[245] | p[244] | p[243] | p[242] | p[241] | p[240] | p[237] | p[236]
               | p[235] | p[232] | p[229] | p[226] | p[225] | p[218] | p[216] | p[214] | p[210] | p[208]
               | p[201] | p[200] | p[199] | p[196] | p[194] | p[193] | p[191] | p[184] | p[182] | p[181]
               | p[179] | p[160] | p[156] | p[155] | p[153] | p[148] | p[146] | p[145] | p[135] | p[131]
               | p[127] | p[121] | p[112] | p[110] | p[109] | p[101] | p[96]  | p[91]  | p[84]  | p[82]
               | p[75]  | p[70]  | p[62]  | p[42]  | p[39]  | p[35]  | p[28]  | p[25]  | p[23]  | p[22]
               | p[20] | p[12];

assign pl[18]  = p[215] | p[213] | p[205] | p[199] | p[194] | p[193] | p[170] | p[122] | p[96]  | p[88]
               | p[84]  | p[72]  | p[57]  | p[24]  | p[22];

assign pl[19]  = p[246] | p[245] | p[243] | p[237] | p[233] | p[228] | p[227] | p[221] | p[219] | p[218]
               | p[217] | p[216] | p[215] | p[214] | p[213] | p[212] | p[208] | p[206] | p[200] | p[199]
               | p[197] | p[194] | p[193] | p[192] | p[189] | p[188] | p[186] | p[182] | p[181] | p[179]
               | p[175] | p[174] | p[172] | p[171] | p[169] | p[168] | p[167] | p[166] | p[165] | p[164]
               | p[160] | p[159] | p[154] | p[152] | p[147] | p[146] | p[145] | p[144] | p[143] | p[140]
               | p[138] | p[136] | p[135] | p[133] | p[130] | p[125] | p[124] | p[123] | p[122] | p[121]
               | p[119] | p[114] | p[112] | p[110] | p[107] | p[103] | p[100] | p[99]  | p[94]  | p[91]
               | p[86]  | p[84]  | p[83]  | p[82]  | p[79]  | p[77]  | p[76]  | p[74]  | p[69]  | p[67]
               | p[66]  | p[65]  | p[61]  | p[56]  | p[34]  | p[28]  | p[22]  | p[20];

assign pl[20]  = p[237] | p[227] | p[226] | p[224] | p[221] | p[215] | p[214] | p[210] | p[207] | p[206]
               | p[205] | p[203] | p[202] | p[191] | p[186] | p[184] | p[183] | p[175] | p[164] | p[160]
               | p[158] | p[154] | p[153] | p[150] | p[149] | p[148] | p[143] | p[139] | p[137] | p[126]
               | p[111] | p[101] | p[100] | p[99]  | p[96]  | p[94]  | p[84]  | p[83]  | p[80]  | p[66]
               | p[55]  | p[52]  | p[49]  | p[47]  | p[45]  | p[44]  | p[41]  | p[40]  | p[37]  | p[32]
               | p[30]  | p[29]  | p[17]  | p[16]  | p[15]  | p[11]  | p[10]  | p[7]   | p[6]   | p[5];

assign pl[21]  = p[225] | p[209] | p[202] | p[199] | p[193] | p[178] | p[169] | p[122] | p[91]  | p[72]
               | p[24];

assign pl[22]  = p[225] | p[209] | p[202] | p[199] | p[194] | p[193] | p[178] | p[171] | p[169] | p[168]
               | p[166] | p[147] | p[136] | p[122] | p[114] | p[91]  | p[86]  | p[72];

assign pl[23]  = p[236] | p[232] | p[231] | p[230] | p[226] | p[218] | p[216] | p[214] | p[208] | p[207]
               | p[206] | p[203] | p[200] | p[196] | p[192] | p[191] | p[185] | p[184] | p[183] | p[182]
               | p[181] | p[180] | p[177] | p[175] | p[174] | p[161] | p[160] | p[158] | p[157] | p[156]
               | p[155] | p[153] | p[152] | p[151] | p[150] | p[149] | p[148] | p[145] | p[143] | p[141]
               | p[137] | p[135] | p[131] | p[129] | p[128] | p[127] | p[126] | p[124] | p[118] | p[116]
               | p[110] | p[108] | p[107] | p[105] | p[104] | p[101] | p[99]  | p[97]  | p[96]  | p[91]
               | p[86]  | p[74]  | p[71]  | p[70]  | p[69]  | p[68]  | p[65]  | p[64]  | p[63]  | p[58]
               | p[56]  | p[54]  | p[46]  | p[38]  | p[31]  | p[27];

assign pl[24]  = p[244] | p[243] | p[242] | p[240] | p[239] | p[237] | p[236] | p[235] | p[232] | p[230]
               | p[229] | p[228] | p[227] | p[226] | p[224] | p[222] | p[221] | p[220] | p[219] | p[217]
               | p[215] | p[213] | p[212] | p[211] | p[210] | p[208] | p[207] | p[205] | p[203] | p[200]
               | p[199] | p[194] | p[193] | p[188] | p[183] | p[182] | p[181] | p[179] | p[177] | p[175]
               | p[174] | p[173] | p[172] | p[171] | p[169] | p[168] | p[167] | p[166] | p[164] | p[160]
               | p[159] | p[158] | p[154] | p[153] | p[152] | p[150] | p[148] | p[147] | p[146] | p[144]
               | p[140] | p[138] | p[137] | p[136] | p[135] | p[133] | p[132] | p[131] | p[127] | p[122]
               | p[121] | p[119] | p[118] | p[114] | p[112] | p[105] | p[103] | p[100] | p[94]  | p[91]
               | p[86]  | p[84]  | p[82]  | p[79]  | p[76]  | p[69]  | p[67];

assign pl[25]  = p[243] | p[237] | p[231] | p[228] | p[226] | p[222] | p[221] | p[220] | p[219] | p[214]
               | p[213] | p[212] | p[211] | p[204] | p[203] | p[191] | p[184] | p[183] | p[175] | p[173]
               | p[167] | p[165] | p[162] | p[160] | p[159] | p[158] | p[150] | p[148] | p[146] | p[144]
               | p[143] | p[140] | p[139] | p[123] | p[112] | p[99]  | p[94]  | p[80]  | p[72]  | p[66]
               | p[64]  | p[59]  | p[53]  | p[48];

assign pl[26]  = p[246] | p[243] | p[237] | p[228] | p[226] | p[225] | p[222] | p[221] | p[220] | p[219]
               | p[217] | p[213] | p[212] | p[211] | p[206] | p[204] | p[203] | p[202] | p[191] | p[188]
               | p[186] | p[184] | p[173] | p[167] | p[165] | p[162] | p[159] | p[158] | p[148] | p[147]
               | p[137] | p[123] | p[112] | p[109] | p[95]  | p[94]  | p[84]  | p[80]  | p[72]  | p[64]
               | p[59]  | p[13];

assign pl[27]  = p[246] | p[243] | p[237] | p[232] | p[226] | p[223] | p[222] | p[221] | p[218] | p[216]
               | p[213] | p[211] | p[209] | p[208] | p[203] | p[202] | p[201] | p[200] | p[196] | p[192]
               | p[188] | p[185] | p[184] | p[183] | p[182] | p[181] | p[175] | p[174] | p[173] | p[165]
               | p[162] | p[159] | p[158] | p[157] | p[156] | p[155] | p[153] | p[152] | p[149] | p[148]
               | p[145] | p[143] | p[139] | p[138] | p[135] | p[131] | p[129] | p[127] | p[126] | p[124]
               | p[123] | p[118] | p[117] | p[113] | p[112] | p[110] | p[107] | p[105] | p[104] | p[101]
               | p[99]  | p[96]  | p[88]  | p[80]  | p[79]  | p[76]  | p[74]  | p[70]  | p[65]  | p[64]
               | p[60]  | p[56]  | p[53]  | p[51]  | p[26]  | p[21];

assign pl[28]  = p[246] | p[240] | p[239] | p[237] | p[236] | p[232] | p[231] | p[230] | p[228] | p[226]
               | p[222] | p[221] | p[218] | p[217] | p[216] | p[213] | p[211] | p[209] | p[208] | p[206]
               | p[203] | p[202] | p[201] | p[200] | p[196] | p[192] | p[191] | p[188] | p[185] | p[184]
               | p[183] | p[182] | p[181] | p[178] | p[175] | p[174] | p[173] | p[171] | p[165] | p[164]
               | p[162] | p[159] | p[158] | p[157] | p[156] | p[155] | p[153] | p[152] | p[149] | p[148]
               | p[146] | p[145] | p[143] | p[142] | p[140] | p[137] | p[135] | p[131] | p[129] | p[127]
               | p[126] | p[124] | p[123] | p[118] | p[112] | p[110] | p[107] | p[105] | p[104] | p[101]
               | p[80]  | p[74]  | p[66]  | p[65]  | p[56]  | p[53]  | p[48];

assign pl[29]  = p[246] | p[245] | p[237] | p[236] | p[231] | p[230] | p[227] | p[226] | p[221] | p[218]
               | p[216] | p[214] | p[212] | p[209] | p[207] | p[206] | p[204] | p[203] | p[202] | p[200]
               | p[192] | p[186] | p[185] | p[184] | p[181] | p[177] | p[174] | p[165] | p[164] | p[158]
               | p[156] | p[155] | p[153] | p[152] | p[150] | p[135] | p[131] | p[129] | p[126] | p[110]
               | p[108] | p[100] | p[88]  | p[83]  | p[82]  | p[80]  | p[61]  | p[56]  | p[34]  | p[19];

assign pl[30]  = p[234] | p[225] | p[222] | p[219] | p[215] | p[214] | p[213] | p[209] | p[188] | p[186]
               | p[177] | p[165] | p[162] | p[160] | p[154] | p[153] | p[150] | p[149] | p[132] | p[126]
               | p[123] | p[109] | p[101] | p[88]  | p[86];

assign pl[31]  = p[249] | p[248] | p[247] | p[245] | p[244] | p[243] | p[242] | p[235] | p[234] | p[232]
               | p[229] | p[228] | p[225] | p[220] | p[219] | p[218] | p[217] | p[216] | p[215] | p[214]
               | p[213] | p[212] | p[211] | p[210] | p[209] | p[208] | p[204] | p[201] | p[200] | p[196]
               | p[195] | p[191] | p[188] | p[186] | p[185] | p[182] | p[177] | p[176] | p[173] | p[165]
               | p[162] | p[160] | p[157] | p[156] | p[154] | p[153] | p[150] | p[149] | p[145] | p[135]
               | p[131] | p[126] | p[124] | p[123] | p[112] | p[110] | p[109] | p[108] | p[104] | p[102]
               | p[101] | p[93]  | p[90]  | p[86]  | p[85]  | p[73];

assign pl[32]  = p[249] | p[248] | p[247] | p[245] | p[244] | p[243] | p[242] | p[235] | p[234] | p[232]
               | p[229] | p[228] | p[225] | p[222] | p[220] | p[219] | p[218] | p[217] | p[216] | p[215]
               | p[214] | p[213] | p[212] | p[211] | p[210] | p[208] | p[204] | p[201] | p[200] | p[198]
               | p[196] | p[191] | p[190] | p[188] | p[186] | p[185] | p[182] | p[177] | p[173] | p[165]
               | p[162] | p[160] | p[157] | p[156] | p[150] | p[145] | p[135] | p[132] | p[131] | p[124]
               | p[123] | p[120] | p[110] | p[109] | p[108] | p[104] | p[98]  | p[92]  | p[88]  | p[87]
               | p[86]  | p[78];

assign pl[33]  = p[249] | p[248] | p[247] | p[245] | p[244] | p[243] | p[242] | p[235] | p[234] | p[232]
               | p[229] | p[228] | p[222] | p[220] | p[218] | p[217] | p[216] | p[215] | p[214] | p[212]
               | p[211] | p[210] | p[208] | p[201] | p[196] | p[191] | p[186] | p[185] | p[182] | p[173]
               | p[163] | p[160] | p[156] | p[150] | p[132] | p[131] | p[115] | p[112] | p[110] | p[108]
               | p[106] | p[89]  | p[86]  | p[81]  | p[50];
endmodule

//______________________________________________________________________________
//
// Main matrix rewritten (for clarity and readability)
//
module vm1_plm
(
   input  [15:0]  ir,
   input  [14:0]  mr,
   output [33:0]  sp
);
wire [249:2] p;
wire [33:0] pl;

function cmp
(
   input [30:0] ai,
   input [30:0] mi
);
begin
   casex(ai)
      mi:      cmp = 1'b1;
      default: cmp = 1'b0;
   endcase
end
endfunction

assign p[2]   = cmp({ir, mr}, {16'bxxxxxxx111xxxxxx, 15'bxxxxxxxx01xx111});
assign p[3]   = cmp({ir, mr}, {16'bx00xxxxxxx00xxxx, 15'b100xxxxx01x1010});
assign p[4]   = cmp({ir, mr}, {16'bx00xxxxxxx0x0xxx, 15'b100xxxxx011101x});
assign p[5]   = cmp({ir, mr}, {16'bxxxxxxxxxxxxx111, 15'bxxxxxxxx100x111});
assign p[6]   = cmp({ir, mr}, {16'b0xxxx101xxxxxxxx, 15'bxxxx1x1x000010x});
assign p[7]   = cmp({ir, mr}, {16'bxxxxxx1xxxxxxxxx, 15'bxxxxx1xx1001x0x});
assign p[8]   = cmp({ir, mr}, {16'bx00xxxxxxxxx0xxx, 15'b100xxxxx011x011});
assign p[9]   = cmp({ir, mr}, {16'bx000101111xxxxxx, 15'b001xxxxxx111110});
assign p[10]  = cmp({ir, mr}, {16'b0xxxx1x1xxxxxxxx, 15'bxxxx000x000010x});
assign p[11]  = cmp({ir, mr}, {16'bxxxxx00111000xxx, 15'b001xxxxx11111x0});
assign p[12]  = cmp({ir, mr}, {16'bx111xxxxxxxxxxxx, 15'b0xxxxxxx01x011x});
assign p[13]  = cmp({ir, mr}, {16'bxxxxx1x01xxxxxxx, 15'b1xxxxxxx011x11x});
assign p[14]  = cmp({ir, mr}, {16'bx00xxxxxxxxxxxxx, 15'b100xxxxx0110010});
assign p[15]  = cmp({ir, mr}, {16'bxxxxx000xxxxxxxx, 15'bxxxx1xxx0000100});
assign p[16]  = cmp({ir, mr}, {16'bxxxxxxxxxx000111, 15'b001xxxxxx111110});
assign p[17]  = cmp({ir, mr}, {16'b1xxxx001xxxxxxxx, 15'bxxxx0xxx00x010x});
assign p[18]  = cmp({ir, mr}, {16'bx00xxxxxxxx00xxx, 15'b100xxxxx0111010});
assign p[19]  = cmp({ir, mr}, {16'bxxxxxxxxxxxx0xxx, 15'bxxx1xxxx1010x0x});
assign p[20]  = cmp({ir, mr}, {16'b0000000001000xxx, 15'b00xxxxxx11111x0});
assign p[21]  = cmp({ir, mr}, {16'b1xxxxx011xxxxxxx, 15'bxxxxxxxx0111000});
assign p[22]  = cmp({ir, mr}, {16'b0000100xxx000xxx, 15'b00xxxxxx11111x0});
assign p[23]  = cmp({ir, mr}, {16'bxxxxxxxx1xx0xxxx, 15'bxxxxxxxx1001001});
assign p[24]  = cmp({ir, mr}, {16'b10001000xxxxxxxx, 15'b00xxxxxxx111110});
assign p[25]  = cmp({ir, mr}, {16'b1xxxxxxxxxxxxxxx, 15'bxxxx0xxx01x1110});
assign p[26]  = cmp({ir, mr}, {16'b1xxxxxxxxxxx011x, 15'bxx1xxxxx01x1010});
assign p[27]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'b11xxxxxx0110111});
assign p[28]  = cmp({ir, mr}, {16'b1000100xxxxxxxxx, 15'b001xxxxxx111110});
assign p[29]  = cmp({ir, mr}, {16'b0xxx0111xxxxxxxx, 15'bxxxx101x00x010x});
assign p[30]  = cmp({ir, mr}, {16'b0xxxx011xxxxxxxx, 15'bxxxxx0xx00x010x});
assign p[31]  = cmp({ir, mr}, {16'bx001xxxxxx00xxxx, 15'bxxxxxxxx0111x10});
assign p[32]  = cmp({ir, mr}, {16'b1xxxx011xxxxxxxx, 15'bxxxxx0x000x010x});
assign p[33]  = cmp({ir, mr}, {16'bx000xxxxxxxx0xxx, 15'bx01xxxxx0110011});
assign p[34]  = cmp({ir, mr}, {16'bxxxxxxxxxx000xxx, 15'bxxxxxxxx1111011});
assign p[35]  = cmp({ir, mr}, {16'bx000xx1010xxxxxx, 15'b1xxxxxxx011x11x});
assign p[36]  = cmp({ir, mr}, {16'b0000000000000101, 15'b001xxxxx11111x0});
assign p[37]  = cmp({ir, mr}, {16'b0xxxx1x0xxxxxxxx, 15'bxxxx0x1x00x010x});
assign p[38]  = cmp({ir, mr}, {16'bx001xxxxxx0x0xxx, 15'bxxxxxxxx0111x10});
assign p[39]  = cmp({ir, mr}, {16'bx100xxxxxxxxxxxx, 15'b0xxxxxxx01x011x});
assign p[40]  = cmp({ir, mr}, {16'b1xxxx101xxxxxxxx, 15'bxxxxxx0x00x010x});
assign p[41]  = cmp({ir, mr}, {16'b0xxxx101xxxxxxxx, 15'bxxxx0x0x000010x});
assign p[42]  = cmp({ir, mr}, {16'bx010xxxxxxxxxxxx, 15'b0xxxxxxx01x011x});
assign p[43]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxx111, 15'bxxxxxxxx01xx11x});
assign p[44]  = cmp({ir, mr}, {16'b1xxxx100xxxxxxxx, 15'bxxxxxx1x00x010x});
assign p[45]  = cmp({ir, mr}, {16'b1xxxx111xxxxxxxx, 15'bxxxxxxx000x010x});
assign p[46]  = cmp({ir, mr}, {16'bx001xxxxxxx00xxx, 15'bxxxxxxxx0111x10});
assign p[47]  = cmp({ir, mr}, {16'b1xxxxx10xxxxxxxx, 15'bxxxxxxx100x010x});
assign p[48]  = cmp({ir, mr}, {16'b0000x1x111xxxxxx, 15'b1xxx1xxx011x11x});
assign p[49]  = cmp({ir, mr}, {16'b0xxxx1x0xxxxxxxx, 15'bxxxx1x0x00x010x});
assign p[50]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxx1, 15'bxxxxxxxx000101x});
assign p[51]  = cmp({ir, mr}, {16'bx0000xxx1xxxxxxx, 15'b111xxxxx0110111});
assign p[52]  = cmp({ir, mr}, {16'b0xxxx110xxxxxxxx, 15'bxxxxx1xx00x010x});
assign p[53]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx0100110});
assign p[54]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxx1xxxxx0110x11});
assign p[55]  = cmp({ir, mr}, {16'bxxxxx010xxxxxxxx, 15'bxxxxx1xx00x010x});
assign p[56]  = cmp({ir, mr}, {16'b10001101xx000xxx, 15'b001xxxxxx111110});
assign p[57]  = cmp({ir, mr}, {16'b101xxxxxxxxxxxxx, 15'bxxxxxxxxx1x011x});
assign p[58]  = cmp({ir, mr}, {16'bx000xxxxxxxxxxxx, 15'b000xxxxx011x01x});
assign p[59]  = cmp({ir, mr}, {16'bx000xx1101xxxxxx, 15'b1xxxxxxx011011x});
assign p[60]  = cmp({ir, mr}, {16'bx000x1x0x1xxxxxx, 15'b1xxxxxxx011011x});
assign p[61]  = cmp({ir, mr}, {16'bx0000xxxxxxxxxxx, 15'b100xxxxx0110111});
assign p[62]  = cmp({ir, mr}, {16'b0110xxxxxxxxxxxx, 15'b0xxxxxxx01x011x});
assign p[63]  = cmp({ir, mr}, {16'bx001xxxxxxxx0xxx, 15'bxxxxxxxx0110011});
assign p[64]  = cmp({ir, mr}, {16'b1x00x1x111xxxxxx, 15'b1x1xxxxx0110111});
assign p[65]  = cmp({ir, mr}, {16'bx000101xxx000xxx, 15'b001xxxxx11111x0});
assign p[66]  = cmp({ir, mr}, {16'bxxxxxxxx10xxxxxx, 15'bxxxxxxxxx101111});
assign p[67]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'b000xxxxx11111x0});
assign p[68]  = cmp({ir, mr}, {16'bx000xxxxxxxxxxxx, 15'bx01xxxxx011x010});
assign p[69]  = cmp({ir, mr}, {16'bxxxx0xxx0xxxxxx1, 15'b1xxxx1xx10x1001});
assign p[70]  = cmp({ir, mr}, {16'b1000x1x1x0xxxxxx, 15'b1x1xxxxx0110111});
assign p[71]  = cmp({ir, mr}, {16'bx001xxxxxxxxxxxx, 15'bxxxxxxxx0110010});
assign p[72]  = cmp({ir, mr}, {16'bxxxxxxx11xxxxxxx, 15'bxxxxxxxxx101111});
assign p[73]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxx1xx, 15'bxxxxxxxx0xx0x1x});
assign p[74]  = cmp({ir, mr}, {16'bx0001100xx000xxx, 15'b001xxxxx11111x0});
assign p[75]  = cmp({ir, mr}, {16'b0111111xxxxxxxxx, 15'b001xxxxx11111x0});
assign p[76]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'b0xxxxxxx1110101});
assign p[77]  = cmp({ir, mr}, {16'bx00xxxxxxxxxxxxx, 15'b0xxxxxxx0110111});
assign p[78]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxx1x, 15'bxxxxxxxx0000x1x});
assign p[79]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1110000});
assign p[80]  = cmp({ir, mr}, {16'bxxxx0xxx10xxxxxx, 15'bxxxxxxxx1001000});
assign p[81]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxx1, 15'bxxxxxxxx0x01110});
assign p[82]  = cmp({ir, mr}, {16'b000000001x000xxx, 15'b001xxxxxx111110});
assign p[83]  = cmp({ir, mr}, {16'bxxxx000xxxxxxxxx, 15'bxxxxxxxx0111000});
assign p[84]  = cmp({ir, mr}, {16'b0xxxxxxxxxxxxxxx, 15'bxxxxxxxx01x1110});
assign p[85]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxx1xx, 15'bxxxxxxxx0x1xx1x});
assign p[86]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1100110});
assign p[87]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxx1x, 15'bxxxxxxxx0x01110});
assign p[88]  = cmp({ir, mr}, {16'b1xxxxxxxxxxxxxxx, 15'bxxxxxxxx1001x00});
assign p[89]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxx1, 15'bxxxxxxxx001xx1x});
assign p[90]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxx1xx, 15'bxxxxxxxx000101x});
assign p[91]  = cmp({ir, mr}, {16'b0000000000000000, 15'b001xxxxxx111110});
assign p[92]  = cmp({ir, mr}, {16'bxxxxxxxx1xxxxxxx, 15'bxxxxxxxxxx1100x});
assign p[93]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxx1xx, 15'bxxxxxxxx0001110});
assign p[94]  = cmp({ir, mr}, {16'bxxxxxxxxxxxx1xxx, 15'bxxxxxxxx0010101});
assign p[95]  = cmp({ir, mr}, {16'bxxxxxxx1xxxxxxxx, 15'bxxxxxxxxx1001x1});
assign p[96]  = cmp({ir, mr}, {16'bxxxxxxxx0xxxxxxx, 15'bxxxxxxxxx101111});
assign p[97]  = cmp({ir, mr}, {16'bx10xxxxxxxxxxxxx, 15'bxxxxxxxx011001x});
assign p[98]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxx1x, 15'bxxxxxxxx000101x});
assign p[99]  = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1100011});
assign p[100] = cmp({ir, mr}, {16'bxxxxxxxxxx1xxxxx, 15'bxxxxxxxxx101010});
assign p[101] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1000010});
assign p[102] = cmp({ir, mr}, {16'bxxxxxxx1xxxxxxxx, 15'bxxxxxxxxxx1100x});
assign p[103] = cmp({ir, mr}, {16'bx000xx1000xxxxxx, 15'b1xxxxxxx011011x});
assign p[104] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bx0xxxxxx1101x11});
assign p[105] = cmp({ir, mr}, {16'bxxxxxxxxxx101xxx, 15'bxxxxxxxx0111x10});
assign p[106] = cmp({ir, mr}, {16'bxxxxxxxxx1xxxxxx, 15'bxxxxxxxxxx1100x});
assign p[107] = cmp({ir, mr}, {16'b0000110111000xxx, 15'b001xxxxxx111110});
assign p[108] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxx1xxxxx1101000});
assign p[109] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'b1xxxxxxx1110101});
assign p[110] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx0000x01});
assign p[111] = cmp({ir, mr}, {16'bx01xxxxxxxxxxxxx, 15'bxxxxxxxx010011x});
assign p[112] = cmp({ir, mr}, {16'bxxxxxxx1xxxxxxxx, 15'bxxxxxxxxx01010x});
assign p[113] = cmp({ir, mr}, {16'bxxxxxxxx1xxxxxxx, 15'bxxxxxxxxx1001x1});
assign p[114] = cmp({ir, mr}, {16'bx000x1x1x1xxxxxx, 15'bxxxxxxxx011011x});
assign p[115] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxx1, 15'bxxxxxxxx0x00x1x});
assign p[116] = cmp({ir, mr}, {16'bxx00xxxxxxxxxxxx, 15'bx1xxxxxx011001x});
assign p[117] = cmp({ir, mr}, {16'b0xxxxxxxxxxxxxxx, 15'bxxxxxxxx01xx01x});
assign p[118] = cmp({ir, mr}, {16'b0111100xxx000xxx, 15'b001xxxxxx111110});
assign p[119] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx11x1111});
assign p[120] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxx1x, 15'bxxxxxxxx010xx1x});
assign p[121] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx100111x});
assign p[122] = cmp({ir, mr}, {16'bxxxx0xxxxx0xxxx0, 15'bxxx0xxxx10x1001});
assign p[123] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1010011});
assign p[124] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'b10xxxxxxx111110});
assign p[125] = cmp({ir, mr}, {16'b1000000xxxxxxxxx, 15'b001xxxxxx111110});
assign p[126] = cmp({ir, mr}, {16'bxxxxxxxxxxxx1xxx, 15'bxxxxxxxx1010000});
assign p[127] = cmp({ir, mr}, {16'bxxxxxxxxxx011xxx, 15'bxxxxxxxx0111x10});
assign p[128] = cmp({ir, mr}, {16'bx000xxxxxxxxxxxx, 15'bx1xxxxxx0111x10});
assign p[129] = cmp({ir, mr}, {16'bxxxx101xxxxxxxxx, 15'bxxxxxxxx0111000});
assign p[130] = cmp({ir, mr}, {16'b00000001xxxxxxxx, 15'b001xxxxxx111110});
assign p[131] = cmp({ir, mr}, {16'bxxxxxxxxxx11xxxx, 15'bxxxxxxxx0111x10});
assign p[132] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxxx100101});
assign p[133] = cmp({ir, mr}, {16'bxxxx0xxx0xxxx0x1, 15'bxxxxxxxx1001x00});
assign p[134] = cmp({ir, mr}, {16'bx000x00xxxxxxxxx, 15'b1xxxxxxx0110111});
assign p[135] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1101010});
assign p[136] = cmp({ir, mr}, {16'b0001xxxxxxxxxxxx, 15'bxxxxxxxx010011x});
assign p[137] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'b01xxxxxxx111110});
assign p[138] = cmp({ir, mr}, {16'bxxxxxxxxx1xxxxxx, 15'bxxxxxxxxx101111});
assign p[139] = cmp({ir, mr}, {16'b0000000000001xxx, 15'b001xxxxxx111110});
assign p[140] = cmp({ir, mr}, {16'bx000xx1111xxxxxx, 15'b1xxxxxxx011011x});
assign p[141] = cmp({ir, mr}, {16'bxxxx0xxx0xxxxxx1, 15'b0xxxx1xx10x1001});
assign p[142] = cmp({ir, mr}, {16'bxxxxxxxxx1xxxxxx, 15'bxxxxxxxxx1001x1});
assign p[143] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1100001});
assign p[144] = cmp({ir, mr}, {16'bx000x1x0xxxxxxxx, 15'b1xxxxxxx011011x});
assign p[145] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1000110});
assign p[146] = cmp({ir, mr}, {16'bx000xx1001xxxxxx, 15'b1xxxxxxx011011x});
assign p[147] = cmp({ir, mr}, {16'b1xxxxxxxxxxxxxxx, 15'bxxxxxxxx01x1110});
assign p[148] = cmp({ir, mr}, {16'bxxxxxxxxxxxx1xxx, 15'bxxxxxxxx0110011});
assign p[149] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bx1xxxxxx1101011});
assign p[150] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1100010});
assign p[151] = cmp({ir, mr}, {16'bxx1xxxxxxxxxxxxx, 15'bxxxxxxxx011001x});
assign p[152] = cmp({ir, mr}, {16'bx01x000xxx000xxx, 15'b001xxxxxx111110});
assign p[153] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1010010});
assign p[154] = cmp({ir, mr}, {16'bxxxxxxxxxxxx0xxx, 15'bxxxxxxxx00x0101});
assign p[155] = cmp({ir, mr}, {16'bxxxx011xxxxxxxxx, 15'bxxxxxxxx0111000});
assign p[156] = cmp({ir, mr}, {16'bxxxx11xxxxxxxxxx, 15'bxxxxxxxx0111000});
assign p[157] = cmp({ir, mr}, {16'bxxxx10xxxxxxxxxx, 15'bxxxxxxxx100100x});
assign p[158] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx111x100});
assign p[159] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx011111x});
assign p[160] = cmp({ir, mr}, {16'bxxxxxxxxxxxxx0xx, 15'bxxxxxxxx1010101});
assign p[161] = cmp({ir, mr}, {16'bx10xxxxxxxxxxxxx, 15'bxxxxxxxx0111x10});
assign p[162] = cmp({ir, mr}, {16'bxxxxxxx0xxxxxxxx, 15'bxxxxxxxx0010100});
assign p[163] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxx1, 15'bxxxxxxxx01xxx1x});
assign p[164] = cmp({ir, mr}, {16'bxxxxxxxxxxx1xxxx, 15'bxxxxxxxxx101010});
assign p[165] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1100000});
assign p[166] = cmp({ir, mr}, {16'bxx11xxxxxxxxxxxx, 15'bxxxxxxxx01x011x});
assign p[167] = cmp({ir, mr}, {16'bx000xx1110xxxxxx, 15'b1xxxxxxx011011x});
assign p[168] = cmp({ir, mr}, {16'bx10xxxxxxxxxxxxx, 15'b0xxxxxxx01x011x});
assign p[169] = cmp({ir, mr}, {16'b100xxxxxxxxxxxxx, 15'bxxxxxxxx010011x});
assign p[170] = cmp({ir, mr}, {16'b1x0xxxxxxxxxxxxx, 15'bxxxxxxxxx1x011x});
assign p[171] = cmp({ir, mr}, {16'bx000xx101xxxxxxx, 15'b1xxxxxxx011011x});
assign p[172] = cmp({ir, mr}, {16'bxx10xxxxxxxxxxxx, 15'bxxxxxxxx01x011x});
assign p[173] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1000x11});
assign p[174] = cmp({ir, mr}, {16'bxx01000xxx000xxx, 15'b001xxxxxx111110});
assign p[175] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'b11xxxxxxx111110});
assign p[176] = cmp({ir, mr}, {16'bxxxxxxxxxxxxx1xx, 15'bxxxxxxxx01xxx1x});
assign p[177] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx11x1100});
assign p[178] = cmp({ir, mr}, {16'bxxxxxx1xxxxxxxxx, 15'bxxxxxxxx101xx00});
assign p[179] = cmp({ir, mr}, {16'bx000xx110xxxxxxx, 15'b1xxxxxxx011011x});
assign p[180] = cmp({ir, mr}, {16'bxx1xxxxxxxxxxxxx, 15'bxxxxxxxx0111x10});
assign p[181] = cmp({ir, mr}, {16'bx1x0000xxx000xxx, 15'b001xxxxx11111x0});
assign p[182] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx110111x});
assign p[183] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'b0xxxxxxx0110x11});
assign p[184] = cmp({ir, mr}, {16'bxxxxxx1xxxxxxxxx, 15'bxxxxxxxx0111x01});
assign p[185] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxx0xxxxx1101000});
assign p[186] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx10111x0});
assign p[187] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bx0xxxxxx011x01x});
assign p[188] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1011111});
assign p[189] = cmp({ir, mr}, {16'bx000010xxxxxxxxx, 15'b001xxxxxx111110});
assign p[190] = cmp({ir, mr}, {16'bxxxxxxxx1xxxxxxx, 15'bxxxxxxxx10x100x});
assign p[191] = cmp({ir, mr}, {16'b0000110100xxxxxx, 15'b001xxxxxx111110});
assign p[192] = cmp({ir, mr}, {16'b0xxx000011000xxx, 15'b001xxxxxx111110});
assign p[193] = cmp({ir, mr}, {16'b0000000000000011, 15'b001xxxxxx111110});
assign p[194] = cmp({ir, mr}, {16'b0000000000000100, 15'b001xxxxxx111110});
assign p[195] = cmp({ir, mr}, {16'bxxxxxxx1xxxxxxxx, 15'bxxxxxxxx10x100x});
assign p[196] = cmp({ir, mr}, {16'b00000000101xxxxx, 15'b001xxxxxx111110});
assign p[197] = cmp({ir, mr}, {16'bx0000x1xxxxxxxxx, 15'b001xxxxxx111110});
assign p[198] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxx1x, 15'bxxxxxxxx0x1xx1x});
assign p[199] = cmp({ir, mr}, {16'bxxxx0xxxx00xx0x0, 15'bxxx1xxxx100100x});
assign p[200] = cmp({ir, mr}, {16'b0000000000000x10, 15'b001xxxxxx111110});
assign p[201] = cmp({ir, mr}, {16'b0000000000000001, 15'b001xxxxxx111110});
assign p[202] = cmp({ir, mr}, {16'bxxxx0xxxx00xx1x1, 15'bxxxxxxxx1001000});
assign p[203] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx0110001});
assign p[204] = cmp({ir, mr}, {16'b0xxxx10xxxxxxxxx, 15'bxxxxxxxx1001x00});
assign p[205] = cmp({ir, mr}, {16'b0000000001xxxxxx, 15'b001xxxxxx111110});
assign p[206] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx101x100});
assign p[207] = cmp({ir, mr}, {16'bxxxx001xxxxxxxxx, 15'bxxxxxxxx0111000});
assign p[208] = cmp({ir, mr}, {16'bxxxx0xxx0xxxxxx0, 15'bxxx0xxxx1001x00});
assign p[209] = cmp({ir, mr}, {16'bxxxx0xxx00xxx1x1, 15'bxxxxx0xx1001x01});
assign p[210] = cmp({ir, mr}, {16'b1000110100xxxxxx, 15'b001xxxxxx111110});
assign p[211] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1010001});
assign p[212] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx101110x});
assign p[213] = cmp({ir, mr}, {16'b1xxxxxxxxxxxxxxx, 15'bxxxxxxxx10x1001});
assign p[214] = cmp({ir, mr}, {16'bxxxxxxxxxxxxx1xx, 15'bxxxxxxxx1010101});
assign p[215] = cmp({ir, mr}, {16'bxxxx0xxx11xxxxxx, 15'bxxxxxxxx1001x0x});
assign p[216] = cmp({ir, mr}, {16'bxxxx0xxxx00xx1x0, 15'bxxx1xxxx1001000});
assign p[217] = cmp({ir, mr}, {16'b0xxxx1xxxxxxxxxx, 15'bxxxxxxxx10x1001});
assign p[218] = cmp({ir, mr}, {16'bxxxxxxx00xxxx1x0, 15'bxxx1xxxx1001001});
assign p[219] = cmp({ir, mr}, {16'bxxxx0xxxxx1xxxxx, 15'bxxxxxxxx10x1001});
assign p[220] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx100110x});
assign p[221] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx0110010});
assign p[222] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1111011});
assign p[223] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxx0xxxxx01xx0xx});
assign p[224] = cmp({ir, mr}, {16'bx000100xxxxxxxxx, 15'b001xxxxx11111x0});
assign p[225] = cmp({ir, mr}, {16'bxxxxxxxxxxxx0xxx, 15'bxxxxxxxx1010x0x});
assign p[226] = cmp({ir, mr}, {16'bxxxxxx0xxxxxxxxx, 15'bxxxxxxxx0111x01});
assign p[227] = cmp({ir, mr}, {16'bxxxxxxxxxx001xxx, 15'bxxxxxxxx0111010});
assign p[228] = cmp({ir, mr}, {16'bxxxxxx1xxxxxxxxx, 15'bxxxxxxxx1001x0x});
assign p[229] = cmp({ir, mr}, {16'bx0001100xxxxxxxx, 15'b001xxxxx11111x0});
assign p[230] = cmp({ir, mr}, {16'bxxxx100xxxxxxxxx, 15'bxxxxxxxx0111000});
assign p[231] = cmp({ir, mr}, {16'bxxxxxx0xxxxxxxxx, 15'bxxxxxxxx1011x00});
assign p[232] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1x01111});
assign p[233] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1x0x1x1});
assign p[234] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx0110111});
assign p[235] = cmp({ir, mr}, {16'b0000000011xxxxxx, 15'b001xxxxx11111x0});
assign p[236] = cmp({ir, mr}, {16'bxxxx010xxxxxxxxx, 15'bxxxxxxxx0111000});
assign p[237] = cmp({ir, mr}, {16'bxxxxxxxxxxxx0xxx, 15'bxxxxxxxx0110011});
assign p[238] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx01xx11x});
assign p[239] = cmp({ir, mr}, {16'bxxxxxxxxxx100xxx, 15'bxxxxxxxx0111x10});
assign p[240] = cmp({ir, mr}, {16'bxxxxxxxxxx010xxx, 15'bxxxxxxxx0111x10});
assign p[241] = cmp({ir, mr}, {16'bx10xxxxxxxxxxxxx, 15'b001xxxxx11111x0});
assign p[242] = cmp({ir, mr}, {16'bx000110111xxxxxx, 15'b001xxxxx11111x0});
assign p[243] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx0000100});
assign p[244] = cmp({ir, mr}, {16'bx000101xxxxxxxxx, 15'b001xxxxx11111x0});
assign p[245] = cmp({ir, mr}, {16'b0111100xxxxxxxxx, 15'b001xxxxx11111x0});
assign p[246] = cmp({ir, mr}, {16'bxxxxxxxxxxxxxxxx, 15'bxxxxxxxx1011001});
assign p[247] = cmp({ir, mr}, {16'bx1x0xxxxxxxxxxxx, 15'b001xxxxx11111x0});
assign p[248] = cmp({ir, mr}, {16'bx01xxxxxxxxxxxxx, 15'b001xxxxxx111110});
assign p[249] = cmp({ir, mr}, {16'bxx01xxxxxxxxxxxx, 15'b001xxxxxx111110});

//
// Summ-Of-Products
//
assign sp = ~pl;
assign pl[0]   = p[246] | p[243] | p[236] | p[234] | p[231] | p[230] | p[228] | p[226] | p[225] | p[220]
               | p[219] | p[217] | p[215] | p[213] | p[212] | p[211] | p[209] | p[208] | p[207] | p[206]
               | p[204] | p[203] | p[202] | p[201] | p[200] | p[199] | p[196] | p[195] | p[194] | p[193]
               | p[191] | p[190] | p[188] | p[186] | p[185] | p[182] | p[179] | p[178] | p[177] | p[175]
               | p[173] | p[172] | p[171] | p[168] | p[167] | p[166] | p[165] | p[162] | p[160] | p[159]
               | p[158] | p[157] | p[154] | p[153] | p[150] | p[149] | p[147] | p[146] | p[144] | p[143]
               | p[141] | p[139] | p[137] | p[136] | p[133] | p[126] | p[124] | p[123] | p[122] | p[119]
               | p[114] | p[112] | p[109] | p[108] | p[107] | p[104] | p[103] | p[101] | p[99]  | p[96]
               | p[94]  | p[91]  | p[86]  | p[84]  | p[79]  | p[76]  | p[75]  | p[74]  | p[69]  | p[67]
               | p[66]  | p[65]  | p[36]  | p[34]  | p[28]  | p[22]  | p[20];

assign pl[1]   = p[249] | p[248] | p[247] | p[246] | p[245] | p[244] | p[243] | p[242] | p[241] | p[240]
               | p[239] | p[237] | p[236] | p[235] | p[234] | p[232] | p[231] | p[230] | p[229] | p[228]
               | p[227] | p[226] | p[225] | p[224] | p[222] | p[221] | p[220] | p[218] | p[217] | p[216]
               | p[215] | p[214] | p[213] | p[212] | p[211] | p[210] | p[209] | p[207] | p[206] | p[205]
               | p[204] | p[203] | p[202] | p[201] | p[200] | p[199] | p[197] | p[196] | p[195] | p[194]
               | p[193] | p[191] | p[189] | p[188] | p[186] | p[185] | p[184] | p[178] | p[177] | p[175]
               | p[173] | p[169] | p[165] | p[164] | p[162] | p[160] | p[159] | p[158] | p[157] | p[156]
               | p[155] | p[153] | p[150] | p[149] | p[148] | p[145] | p[143] | p[141] | p[139] | p[138]
               | p[137] | p[135] | p[133] | p[132] | p[131] | p[130] | p[129] | p[127] | p[126] | p[125]
               | p[124] | p[123] | p[122] | p[121] | p[112] | p[110] | p[109] | p[108] | p[105] | p[104]
               | p[101] | p[100] | p[99]  | p[96]  | p[91]  | p[86]  | p[83]  | p[82]  | p[80]  | p[79]
               | p[76]  | p[75]  | p[69]  | p[66]  | p[43]  | p[36]  | p[2];

assign pl[2]   = p[232] | p[218] | p[216] | p[196] | p[192] | p[181] | p[174] | p[154] | p[152] | p[119]
               | p[118] | p[110] | p[107] | p[94]  | p[74]  | p[67]  | p[65]  | p[56];

assign pl[3]   = p[236] | p[230] | p[226] | p[208] | p[207] | p[206] | p[203] | p[200] | p[184] | p[182]
               | p[180] | p[175] | p[161] | p[158] | p[156] | p[155] | p[154] | p[153] | p[151] | p[148]
               | p[145] | p[137] | p[135] | p[131] | p[129] | p[128] | p[127] | p[126] | p[116] | p[105]
               | p[101] | p[97]  | p[94]  | p[68]  | p[58]  | p[33];

assign pl[4]   = p[225] | p[215] | p[209] | p[202] | p[179] | p[178] | p[172] | p[169] | p[167] | p[146]
               | p[144] | p[140] | p[103] | p[84]  | p[72];

assign pl[5]   = p[246] | p[231] | p[225] | p[218] | p[217] | p[216] | p[214] | p[212] | p[211] | p[209]
               | p[206] | p[204] | p[202] | p[201] | p[200] | p[197] | p[196] | p[191] | p[189] | p[186]
               | p[178] | p[175] | p[173] | p[162] | p[158] | p[157] | p[153] | p[145] | p[141] | p[139]
               | p[134] | p[130] | p[126] | p[125] | p[123] | p[110] | p[107] | p[96]  | p[88]  | p[80]
               | p[75]  | p[74]  | p[70]  | p[66]  | p[65]  | p[36]  | p[34];

assign pl[6]   = p[249] | p[248] | p[247] | p[246] | p[245] | p[244] | p[243] | p[242] | p[241] | p[238]
               | p[235] | p[232] | p[231] | p[229] | p[228] | p[225] | p[224] | p[223] | p[222] | p[220]
               | p[219] | p[218] | p[217] | p[216] | p[215] | p[214] | p[213] | p[212] | p[211] | p[210]
               | p[209] | p[208] | p[206] | p[205] | p[204] | p[202] | p[201] | p[200] | p[199] | p[197]
               | p[196] | p[195] | p[194] | p[193] | p[191] | p[190] | p[189] | p[188] | p[186] | p[185]
               | p[184] | p[182] | p[178] | p[177] | p[175] | p[173] | p[165] | p[164] | p[162] | p[160]
               | p[158] | p[157] | p[156] | p[155] | p[154] | p[153] | p[150] | p[149] | p[148] | p[145]
               | p[143] | p[141] | p[139] | p[137] | p[135] | p[133] | p[132] | p[131] | p[130] | p[129]
               | p[127] | p[126] | p[125] | p[124] | p[123] | p[122] | p[121] | p[119] | p[117] | p[112]
               | p[110] | p[109] | p[108] | p[105] | p[104] | p[101] | p[100] | p[99]  | p[94]  | p[91]
               | p[86]  | p[83]  | p[82]  | p[79]  | p[76]  | p[75]  | p[69]  | p[67]  | p[36];

assign pl[7]   = p[246] | p[243] | p[238] | p[236] | p[232] | p[231] | p[230] | p[228] | p[226] | p[225]
               | p[222] | p[220] | p[219] | p[218] | p[217] | p[216] | p[215] | p[214] | p[213] | p[212]
               | p[211] | p[209] | p[208] | p[207] | p[204] | p[203] | p[202] | p[201] | p[200] | p[196]
               | p[192] | p[191] | p[188] | p[187] | p[186] | p[185] | p[184] | p[182] | p[181] | p[178]
               | p[177] | p[175] | p[174] | p[173] | p[165] | p[164] | p[162] | p[160] | p[158] | p[156]
               | p[155] | p[154] | p[153] | p[152] | p[150] | p[148] | p[145] | p[143] | p[139] | p[135]
               | p[133] | p[132] | p[131] | p[129] | p[127] | p[126] | p[123] | p[118] | p[112] | p[110]
               | p[109] | p[108] | p[107] | p[105] | p[101] | p[100] | p[88]  | p[86]  | p[83]  | p[80]
               | p[74]  | p[65]  | p[56];

assign pl[8]   = p[246] | p[243] | p[238] | p[231] | p[228] | p[225] | p[222] | p[220] | p[219] | p[217]
               | p[215] | p[214] | p[213] | p[212] | p[211] | p[209] | p[204] | p[202] | p[201] | p[195]
               | p[191] | p[190] | p[188] | p[186] | p[185] | p[178] | p[177] | p[173] | p[165] | p[164]
               | p[162] | p[160] | p[157] | p[154] | p[150] | p[149] | p[143] | p[139] | p[132] | p[124]
               | p[123] | p[112] | p[109] | p[108] | p[104] | p[100] | p[99]  | p[86]  | p[83]  | p[71]
               | p[63]  | p[46]  | p[38]  | p[31]  | p[18]  | p[14]  | p[8]   | p[4]   | p[3];

assign pl[9]   = p[246] | p[245] | p[243] | p[240] | p[239] | p[234] | p[232] | p[228] | p[225] | p[220]
               | p[217] | p[215] | p[214] | p[213] | p[209] | p[204] | p[202] | p[201] | p[200] | p[197]
               | p[196] | p[192] | p[191] | p[189] | p[188] | p[185] | p[181] | p[178] | p[177] | p[174]
               | p[173] | p[169] | p[160] | p[159] | p[158] | p[152] | p[150] | p[149] | p[141] | p[138]
               | p[137] | p[130] | p[125] | p[124] | p[112] | p[108] | p[107] | p[104] | p[101] | p[99]
               | p[96]  | p[88]  | p[86]  | p[83]  | p[82]  | p[80]  | p[79]  | p[76]  | p[74]  | p[69]
               | p[66]  | p[65]  | p[56]  | p[43]  | p[36]  | p[34]  | p[2];

assign pl[10]  = p[237] | p[234] | p[226] | p[225] | p[222] | p[221] | p[214] | p[211] | p[203] | p[186]
               | p[184] | p[173] | p[165] | p[162] | p[160] | p[159] | p[158] | p[150] | p[148] | p[123]
               | p[112] | p[36];

assign pl[11]  = p[246] | p[240] | p[237] | p[236] | p[232] | p[227] | p[226] | p[222] | p[221] | p[220]
               | p[219] | p[218] | p[217] | p[216] | p[215] | p[213] | p[212] | p[211] | p[208] | p[207]
               | p[204] | p[203] | p[200] | p[196] | p[192] | p[184] | p[183] | p[182] | p[181] | p[177]
               | p[174] | p[173] | p[172] | p[169] | p[168] | p[166] | p[165] | p[162] | p[159] | p[158]
               | p[156] | p[155] | p[154] | p[152] | p[148] | p[145] | p[144] | p[138] | p[136] | p[135]
               | p[134] | p[132] | p[131] | p[127] | p[123] | p[118] | p[112] | p[110] | p[108] | p[107]
               | p[100] | p[94]  | p[86]  | p[83]  | p[74]  | p[65]  | p[64] | p[56];

assign pl[12]  = p[249] | p[248] | p[247] | p[246] | p[245] | p[244] | p[243] | p[242] | p[241] | p[240]
               | p[239] | p[238] | p[237] | p[236] | p[235] | p[232] | p[231] | p[230] | p[229] | p[228]
               | p[227] | p[226] | p[225] | p[224] | p[222] | p[221] | p[220] | p[219] | p[218] | p[217]
               | p[216] | p[215] | p[214] | p[213] | p[212] | p[211] | p[210] | p[209] | p[208] | p[207]
               | p[206] | p[205] | p[204] | p[203] | p[202] | p[201] | p[200] | p[199] | p[197] | p[196]
               | p[195] | p[194] | p[193] | p[191] | p[190] | p[189] | p[188] | p[186] | p[185] | p[184]
               | p[182] | p[178] | p[177] | p[175] | p[173] | p[165] | p[164] | p[162] | p[160] | p[158]
               | p[157] | p[156] | p[155] | p[154] | p[153] | p[150] | p[149] | p[148] | p[145] | p[143]
               | p[141] | p[139] | p[137] | p[135] | p[133] | p[132] | p[131] | p[130] | p[129] | p[127]
               | p[126] | p[125] | p[124] | p[123] | p[122] | p[121] | p[119] | p[112] | p[110] | p[109]
               | p[108] | p[105] | p[104] | p[101] | p[100] | p[99]  | p[94]  | p[91]  | p[86]  | p[83]
               | p[82]  | p[79]  | p[76]  | p[75]  | p[69]  | p[67]  | p[36];

assign pl[13]  = p[246] | p[243] | p[239] | p[237] | p[231] | p[230] | p[228] | p[226] | p[225] | p[222]
               | p[221] | p[220] | p[219] | p[217] | p[214] | p[213] | p[212] | p[211] | p[209] | p[206]
               | p[204] | p[203] | p[202] | p[201] | p[195] | p[191] | p[188] | p[186] | p[185] | p[184]
               | p[183] | p[179] | p[178] | p[175] | p[173] | p[172] | p[171] | p[169] | p[168] | p[167]
               | p[166] | p[165] | p[164] | p[162] | p[160] | p[159] | p[158] | p[157] | p[154] | p[153]
               | p[150] | p[149] | p[148] | p[147] | p[146] | p[143] | p[140] | p[139] | p[137] | p[136]
               | p[132] | p[129] | p[126] | p[124] | p[123] | p[114] | p[112] | p[109] | p[105] | p[104]
               | p[103] | p[101] | p[99]  | p[96]  | p[94]  | p[84]  | p[80]  | p[72]  | p[70]  | p[66];

assign pl[14]  = p[246] | p[244] | p[243] | p[242] | p[240] | p[239] | p[237] | p[236] | p[235] | p[232]
               | p[230] | p[229] | p[228] | p[227] | p[226] | p[224] | p[222] | p[221] | p[220] | p[218]
               | p[217] | p[216] | p[212] | p[211] | p[210] | p[209] | p[208] | p[207] | p[206] | p[205]
               | p[204] | p[203] | p[202] | p[201] | p[200] | p[199] | p[196] | p[194] | p[193] | p[191]
               | p[188] | p[185] | p[184] | p[182] | p[181] | p[179] | p[178] | p[177] | p[175] | p[174]
               | p[173] | p[172] | p[171] | p[169] | p[167] | p[165] | p[164] | p[162] | p[159] | p[158]
               | p[157] | p[156] | p[155] | p[154] | p[153] | p[152] | p[149] | p[148] | p[145] | p[143]
               | p[141] | p[139] | p[137] | p[136] | p[135] | p[132] | p[131] | p[129] | p[127] | p[126]
               | p[124] | p[123] | p[122] | p[121] | p[118] | p[114] | p[112] | p[110] | p[108] | p[105]
               | p[104] | p[103] | p[101] | p[100] | p[99]  | p[94]  | p[83]  | p[80]  | p[77]  | p[72];

assign pl[15]  = p[245] | p[237] | p[232] | p[227] | p[221] | p[218] | p[217] | p[216] | p[214] | p[211]
               | p[206] | p[200] | p[197] | p[189] | p[185] | p[184] | p[181] | p[174] | p[173] | p[165]
               | p[164] | p[162] | p[158] | p[155] | p[153] | p[152] | p[150] | p[148] | p[145] | p[143]
               | p[139] | p[137] | p[131] | p[130] | p[129] | p[127] | p[126] | p[125] | p[123] | p[121]
               | p[110] | p[109] | p[108] | p[105] | p[101] | p[100] | p[83]  | p[77];

assign pl[16]  = p[248] | p[246] | p[243] | p[240] | p[237] | p[236] | p[232] | p[227] | p[226] | p[225]
               | p[224] | p[222] | p[221] | p[220] | p[219] | p[218] | p[217] | p[216] | p[215] | p[214]
               | p[213] | p[212] | p[211] | p[210] | p[208] | p[207] | p[206] | p[205] | p[204] | p[203]
               | p[202] | p[201] | p[200] | p[199] | p[196] | p[194] | p[193] | p[192] | p[191] | p[188]
               | p[184] | p[182] | p[181] | p[177] | p[175] | p[174] | p[173] | p[169] | p[168] | p[165]
               | p[162] | p[160] | p[159] | p[158] | p[156] | p[155] | p[154] | p[153] | p[150] | p[148]
               | p[147] | p[145] | p[144] | p[143] | p[139] | p[138] | p[137] | p[136] | p[135] | p[134]
               | p[133] | p[132] | p[131] | p[127] | p[123] | p[122] | p[121] | p[118] | p[114] | p[112]
               | p[110] | p[109] | p[108] | p[107] | p[103] | p[101] | p[100] | p[99]  | p[96]  | p[94]
               | p[86]  | p[84]  | p[83]  | p[80]  | p[77]  | p[74]  | p[70]  | p[65]  | p[62]  | p[59]
               | p[56]  | p[35]  | p[9];

assign pl[17]  = p[249] | p[248] | p[245] | p[244] | p[243] | p[242] | p[241] | p[240] | p[237] | p[236]
               | p[235] | p[232] | p[229] | p[226] | p[225] | p[218] | p[216] | p[214] | p[210] | p[208]
               | p[201] | p[200] | p[199] | p[196] | p[194] | p[193] | p[191] | p[184] | p[182] | p[181]
               | p[179] | p[160] | p[156] | p[155] | p[153] | p[148] | p[146] | p[145] | p[135] | p[131]
               | p[127] | p[121] | p[112] | p[110] | p[109] | p[101] | p[96]  | p[91]  | p[84]  | p[82]
               | p[75]  | p[70]  | p[62]  | p[42]  | p[39]  | p[35]  | p[28]  | p[25]  | p[23]  | p[22]
               | p[20] | p[12];

assign pl[18]  = p[215] | p[213] | p[205] | p[199] | p[194] | p[193] | p[170] | p[122] | p[96]  | p[88]
               | p[84]  | p[72]  | p[57]  | p[24]  | p[22];

assign pl[19]  = p[246] | p[245] | p[243] | p[237] | p[233] | p[228] | p[227] | p[221] | p[219] | p[218]
               | p[217] | p[216] | p[215] | p[214] | p[213] | p[212] | p[208] | p[206] | p[200] | p[199]
               | p[197] | p[194] | p[193] | p[192] | p[189] | p[188] | p[186] | p[182] | p[181] | p[179]
               | p[175] | p[174] | p[172] | p[171] | p[169] | p[168] | p[167] | p[166] | p[165] | p[164]
               | p[160] | p[159] | p[154] | p[152] | p[147] | p[146] | p[145] | p[144] | p[143] | p[140]
               | p[138] | p[136] | p[135] | p[133] | p[130] | p[125] | p[124] | p[123] | p[122] | p[121]
               | p[119] | p[114] | p[112] | p[110] | p[107] | p[103] | p[100] | p[99]  | p[94]  | p[91]
               | p[86]  | p[84]  | p[83]  | p[82]  | p[79]  | p[77]  | p[76]  | p[74]  | p[69]  | p[67]
               | p[66]  | p[65]  | p[61]  | p[56]  | p[34]  | p[28]  | p[22]  | p[20];

assign pl[20]  = p[237] | p[227] | p[226] | p[224] | p[221] | p[215] | p[214] | p[210] | p[207] | p[206]
               | p[205] | p[203] | p[202] | p[191] | p[186] | p[184] | p[183] | p[175] | p[164] | p[160]
               | p[158] | p[154] | p[153] | p[150] | p[149] | p[148] | p[143] | p[139] | p[137] | p[126]
               | p[111] | p[101] | p[100] | p[99]  | p[96]  | p[94]  | p[84]  | p[83]  | p[80]  | p[66]
               | p[55]  | p[52]  | p[49]  | p[47]  | p[45]  | p[44]  | p[41]  | p[40]  | p[37]  | p[32]
               | p[30]  | p[29]  | p[17]  | p[16]  | p[15]  | p[11]  | p[10]  | p[7]   | p[6]   | p[5];

assign pl[21]  = p[225] | p[209] | p[202] | p[199] | p[193] | p[178] | p[169] | p[122] | p[91]  | p[72]
               | p[24];

assign pl[22]  = p[225] | p[209] | p[202] | p[199] | p[194] | p[193] | p[178] | p[171] | p[169] | p[168]
               | p[166] | p[147] | p[136] | p[122] | p[114] | p[91]  | p[86]  | p[72];

assign pl[23]  = p[236] | p[232] | p[231] | p[230] | p[226] | p[218] | p[216] | p[214] | p[208] | p[207]
               | p[206] | p[203] | p[200] | p[196] | p[192] | p[191] | p[185] | p[184] | p[183] | p[182]
               | p[181] | p[180] | p[177] | p[175] | p[174] | p[161] | p[160] | p[158] | p[157] | p[156]
               | p[155] | p[153] | p[152] | p[151] | p[150] | p[149] | p[148] | p[145] | p[143] | p[141]
               | p[137] | p[135] | p[131] | p[129] | p[128] | p[127] | p[126] | p[124] | p[118] | p[116]
               | p[110] | p[108] | p[107] | p[105] | p[104] | p[101] | p[99]  | p[97]  | p[96]  | p[91]
               | p[86]  | p[74]  | p[71]  | p[70]  | p[69]  | p[68]  | p[65]  | p[64]  | p[63]  | p[58]
               | p[56]  | p[54]  | p[46]  | p[38]  | p[31]  | p[27];

assign pl[24]  = p[244] | p[243] | p[242] | p[240] | p[239] | p[237] | p[236] | p[235] | p[232] | p[230]
               | p[229] | p[228] | p[227] | p[226] | p[224] | p[222] | p[221] | p[220] | p[219] | p[217]
               | p[215] | p[213] | p[212] | p[211] | p[210] | p[208] | p[207] | p[205] | p[203] | p[200]
               | p[199] | p[194] | p[193] | p[188] | p[183] | p[182] | p[181] | p[179] | p[177] | p[175]
               | p[174] | p[173] | p[172] | p[171] | p[169] | p[168] | p[167] | p[166] | p[164] | p[160]
               | p[159] | p[158] | p[154] | p[153] | p[152] | p[150] | p[148] | p[147] | p[146] | p[144]
               | p[140] | p[138] | p[137] | p[136] | p[135] | p[133] | p[132] | p[131] | p[127] | p[122]
               | p[121] | p[119] | p[118] | p[114] | p[112] | p[105] | p[103] | p[100] | p[94]  | p[91]
               | p[86]  | p[84]  | p[82]  | p[79]  | p[76]  | p[69]  | p[67];

assign pl[25]  = p[243] | p[237] | p[231] | p[228] | p[226] | p[222] | p[221] | p[220] | p[219] | p[214]
               | p[213] | p[212] | p[211] | p[204] | p[203] | p[191] | p[184] | p[183] | p[175] | p[173]
               | p[167] | p[165] | p[162] | p[160] | p[159] | p[158] | p[150] | p[148] | p[146] | p[144]
               | p[143] | p[140] | p[139] | p[123] | p[112] | p[99]  | p[94]  | p[80]  | p[72]  | p[66]
               | p[64]  | p[59]  | p[53]  | p[48];

assign pl[26]  = p[246] | p[243] | p[237] | p[228] | p[226] | p[225] | p[222] | p[221] | p[220] | p[219]
               | p[217] | p[213] | p[212] | p[211] | p[206] | p[204] | p[203] | p[202] | p[191] | p[188]
               | p[186] | p[184] | p[173] | p[167] | p[165] | p[162] | p[159] | p[158] | p[148] | p[147]
               | p[137] | p[123] | p[112] | p[109] | p[95]  | p[94]  | p[84]  | p[80]  | p[72]  | p[64]
               | p[59]  | p[13];

assign pl[27]  = p[246] | p[243] | p[237] | p[232] | p[226] | p[223] | p[222] | p[221] | p[218] | p[216]
               | p[213] | p[211] | p[209] | p[208] | p[203] | p[202] | p[201] | p[200] | p[196] | p[192]
               | p[188] | p[185] | p[184] | p[183] | p[182] | p[181] | p[175] | p[174] | p[173] | p[165]
               | p[162] | p[159] | p[158] | p[157] | p[156] | p[155] | p[153] | p[152] | p[149] | p[148]
               | p[145] | p[143] | p[139] | p[138] | p[135] | p[131] | p[129] | p[127] | p[126] | p[124]
               | p[123] | p[118] | p[117] | p[113] | p[112] | p[110] | p[107] | p[105] | p[104] | p[101]
               | p[99]  | p[96]  | p[88]  | p[80]  | p[79]  | p[76]  | p[74]  | p[70]  | p[65]  | p[64]
               | p[60]  | p[56]  | p[53]  | p[51]  | p[26]  | p[21];

assign pl[28]  = p[246] | p[240] | p[239] | p[237] | p[236] | p[232] | p[231] | p[230] | p[228] | p[226]
               | p[222] | p[221] | p[218] | p[217] | p[216] | p[213] | p[211] | p[209] | p[208] | p[206]
               | p[203] | p[202] | p[201] | p[200] | p[196] | p[192] | p[191] | p[188] | p[185] | p[184]
               | p[183] | p[182] | p[181] | p[178] | p[175] | p[174] | p[173] | p[171] | p[165] | p[164]
               | p[162] | p[159] | p[158] | p[157] | p[156] | p[155] | p[153] | p[152] | p[149] | p[148]
               | p[146] | p[145] | p[143] | p[142] | p[140] | p[137] | p[135] | p[131] | p[129] | p[127]
               | p[126] | p[124] | p[123] | p[118] | p[112] | p[110] | p[107] | p[105] | p[104] | p[101]
               | p[80]  | p[74]  | p[66]  | p[65]  | p[56]  | p[53]  | p[48];

assign pl[29]  = p[246] | p[245] | p[237] | p[236] | p[231] | p[230] | p[227] | p[226] | p[221] | p[218]
               | p[216] | p[214] | p[212] | p[209] | p[207] | p[206] | p[204] | p[203] | p[202] | p[200]
               | p[192] | p[186] | p[185] | p[184] | p[181] | p[177] | p[174] | p[165] | p[164] | p[158]
               | p[156] | p[155] | p[153] | p[152] | p[150] | p[135] | p[131] | p[129] | p[126] | p[110]
               | p[108] | p[100] | p[88]  | p[83]  | p[82]  | p[80]  | p[61]  | p[56]  | p[34]  | p[19];

assign pl[30]  = p[234] | p[225] | p[222] | p[219] | p[215] | p[214] | p[213] | p[209] | p[188] | p[186]
               | p[177] | p[165] | p[162] | p[160] | p[154] | p[153] | p[150] | p[149] | p[132] | p[126]
               | p[123] | p[109] | p[101] | p[88]  | p[86];

assign pl[31]  = p[249] | p[248] | p[247] | p[245] | p[244] | p[243] | p[242] | p[235] | p[234] | p[232]
               | p[229] | p[228] | p[225] | p[220] | p[219] | p[218] | p[217] | p[216] | p[215] | p[214]
               | p[213] | p[212] | p[211] | p[210] | p[209] | p[208] | p[204] | p[201] | p[200] | p[196]
               | p[195] | p[191] | p[188] | p[186] | p[185] | p[182] | p[177] | p[176] | p[173] | p[165]
               | p[162] | p[160] | p[157] | p[156] | p[154] | p[153] | p[150] | p[149] | p[145] | p[135]
               | p[131] | p[126] | p[124] | p[123] | p[112] | p[110] | p[109] | p[108] | p[104] | p[102]
               | p[101] | p[93]  | p[90]  | p[86]  | p[85]  | p[73];

assign pl[32]  = p[249] | p[248] | p[247] | p[245] | p[244] | p[243] | p[242] | p[235] | p[234] | p[232]
               | p[229] | p[228] | p[225] | p[222] | p[220] | p[219] | p[218] | p[217] | p[216] | p[215]
               | p[214] | p[213] | p[212] | p[211] | p[210] | p[208] | p[204] | p[201] | p[200] | p[198]
               | p[196] | p[191] | p[190] | p[188] | p[186] | p[185] | p[182] | p[177] | p[173] | p[165]
               | p[162] | p[160] | p[157] | p[156] | p[150] | p[145] | p[135] | p[132] | p[131] | p[124]
               | p[123] | p[120] | p[110] | p[109] | p[108] | p[104] | p[98]  | p[92]  | p[88]  | p[87]
               | p[86]  | p[78];

assign pl[33]  = p[249] | p[248] | p[247] | p[245] | p[244] | p[243] | p[242] | p[235] | p[234] | p[232]
               | p[229] | p[228] | p[222] | p[220] | p[218] | p[217] | p[216] | p[215] | p[214] | p[212]
               | p[211] | p[210] | p[208] | p[201] | p[196] | p[191] | p[186] | p[185] | p[182] | p[173]
               | p[163] | p[160] | p[156] | p[150] | p[132] | p[131] | p[115] | p[112] | p[110] | p[108]
               | p[106] | p[89]  | p[86]  | p[81]  | p[50];
endmodule

//______________________________________________________________________________
//
// Interrupt priority matrix input description:
//
//    rq[0]    - psw[10]
//    rq[1]    - feedback - output  sp[4] (pli4r net)
//    rq[2]    - psw[11]
//    rq[3]    - unknown opcode error
//    rq[4]    - psw[7] interrupt priority/disable
//    rq[5]    - unused (former some error 2 request)
//    rq[6]    - unused (former start request)
//    rq[7]    - unused (former some error 3 request)
//    rq[8]    - vectored interrupt request (low active)
//    rq[9]    - normal qbus timeout trap or odd address
//    rq[10]   - double error trap
//    rq[11]   - nACLO falling edge detector (nACLO failed)
//    rq[12]   - wait mode (bit 2 of mode register 177700)
//    rq[13]   - nACLO raising edge detector (nACLO restored)
//    rq[14]   - radial interrupt request IRQ1
//    rq[15]   - psw[4] T-bit
//    rq[16]   - radial interrupt request IRQ2
//    rq[17]   - vector fetch qbus timeout
//    rq[18]   - radial interrupt request IRQ3
//    rq[19]   - unused (used to be the VE-timer request)
//
// Interrupt priority matrix output description:
//
//    sp[0]    - vector generator selector  bit 0
//    sp[1]    - vector generator selector  bit 1
//    sp[2]    - vector generator selector ~bit 2
//    sp[3]    - vector generator selector  bit 3
//    sp[4]    - feedback to priority matrix - plir
//
//    sp[6]    - controls the request detectors rearm
//    sp[8]    - controls the request detectors rearm
//    sp[10]   - controls the request detectors rearm
//
//    sp[5]    - goes to the main microcode register ~mj[14]
//    sp[7]    - goes to the main microcode register ~mj[13]
//    sp[9]    - goes to the main microcode register ~mj[12]
//
//
// On schematics vsel is {pli[3], ~pli[2], pli[1], pli[0]}
//
// 4'b0000: vmux = 16'o160006;      // double error
// 4'b0001: vmux = 16'o000020;      // IOT instruction
// 4'b0010: vmux = 16'o000010;      // reserved opcode
// 4'b0011: vmux = 16'o000014;      // T-bit trap
// 4'b0100: vmux = 16'o000004;      // invalid opcode
// 4'b0101:                         // or qbus timeout
//    case (pa[1:0])                // initial start
//       2'b00: vmux = 16'o177716;  // register base
//       2'b01: vmux = 16'o177736;  // depends on
//       2'b10: vmux = 16'o177756;  // processor number
//       2'b10: vmux = 16'o177776;  //
//    endcase                       //
// 4'b0110: vmux = 16'o000030;      // EMT instruction
// 4'b0111: vmux = 16'o160012;      // int ack timeout
// 4'b1000: vmux = 16'o000270;      // IRQ3 falling edge
// 4'b1001: vmux = 16'o000024;      // ACLO falling edge
// 4'b1010: vmux = 16'o000100;      // IRQ2 falling edge
// 4'b1011: vmux = 16'o160002;      // IRQ1 low level/HALT
// 4'b1100: vmux = 16'o000034;      // TRAP instruction
// 4'b1101: vmux = vreg;            // vector register
// 4'b1110: vmux = svec;            // start @177704
// 4'b1111: vmux = 16'o000000;      // unused vector
//
//______________________________________________________________________________
//
// 1801VM1A interrupt matrix original representation (for identity check)
//
module vm1_pli_model
(
   input  [19:0]  rq,
   output [10:0]  sp
);
wire [20:0] p;
wire [10:0] pl;

function cmp
(
   input [19:0] i,
   input [19:0] c,                                                            //
   input [19:0] m                                                             //     .iiipianadqv...puppp
);                                                                            //     .rarsrcccbbi...sesls
   cmp = &(~(i ^ c) | m);                                                     //     .qtqwqoplltr...wrwiw
endfunction                                                                   //     .3o241kuoeoq...7r1r0
                                                                              //
assign p[0]    = cmp(rq, 20'b00000001000100000010, 20'b10101010010011110101); // 20'bx0x0x0x10x01xxxx0x1x
assign p[1]    = cmp(rq, 20'b00010001000000000010, 20'b11101010010111100100); // 20'bxxx1x0x10x0xxxx00x10
assign p[2]    = cmp(rq, 20'b00000100000000000010, 20'b11110011010111110000); // 20'bxxxx01xx0x0xxxxx0010
assign p[3]    = cmp(rq, 20'b00001101000000000010, 20'b11110010010111110000); // 20'bxxxx11x10x0xxxxx0010
assign p[4]    = cmp(rq, 20'b00001001000000000010, 20'b10100010010011100100); // 20'bx0x010x10x00xxx00x10
assign p[5]    = cmp(rq, 20'b00000000000000000010, 20'b10100011010011100100); // 20'bx0x000xx0x00xxx00x10
assign p[6]    = cmp(rq, 20'b01001001000000000010, 20'b10100010010111100100); // 20'bx1x010x10x0xxxx00x10
assign p[7]    = cmp(rq, 20'b00010000000000000010, 20'b11100011010111100100); // 20'bxxx100xx0x0xxxx00x10
assign p[8]    = cmp(rq, 20'b00000000000000000000, 20'b11111101111111111101); // 20'bxxxxxx0xxxxxxxxxxx0x
assign p[9]    = cmp(rq, 20'b01000000000000000010, 20'b10100011010111100100); // 20'bx1x000xx0x0xxxx00x10
assign p[10]   = cmp(rq, 20'b00000001000000000010, 20'b11111010010111110100); // 20'bxxxxx0x10x0xxxxx0x10
assign p[11]   = cmp(rq, 20'b00000000100000000010, 20'b11110111010111110100); // 20'bxxxx0xxx1x0xxxxx0x10
assign p[12]   = cmp(rq, 20'b00001000000000000010, 20'b11110110110111110100); // 20'bxxxx1xx0xx0xxxxx0x10
assign p[13]   = cmp(rq, 20'b00001001100000000010, 20'b11110110010111110100); // 20'bxxxx1xx11x0xxxxx0x10
assign p[14]   = cmp(rq, 20'b00000000001000000110, 20'b11011111100111111001); // 20'bxx0xxxxxx01xxxxxx11x
assign p[15]   = cmp(rq, 20'b00000000000000001010, 20'b11111111110111110101); // 20'bxxxxxxxxxx0xxxxx1x1x
assign p[16]   = cmp(rq, 20'b00100000001000000010, 20'b11011111110111111101); // 20'bxx1xxxxxxx1xxxxxxx1x
assign p[17]   = cmp(rq, 20'b00000010000000000000, 20'b11111101111111111101); // 20'bxxxxxx1xxxxxxxxxxx0x
assign p[18]   = cmp(rq, 20'b00000000001000000011, 20'b11011111100111111100); // 20'bxx0xxxxxx01xxxxxxx11
assign p[19]   = cmp(rq, 20'b00000000011000000010, 20'b11011111100111111101); // 20'bxx0xxxxxx11xxxxxxx1x
assign p[20]   = cmp(rq, 20'b00000000001000000010, 20'b11011111100111111000); // 20'bxx0xxxxxx01xxxxxx010

assign sp      = ~pl;
assign pl[0]   = p[20] | p[19] | p[15] | p[9]  | p[7]  | p[6]  | p[1];
assign pl[1]   = p[20] | p[19] | p[17] | p[13] | p[11] | p[9]  | p[6];
assign pl[2]   = p[20] | p[17] | p[16] | p[5]  | p[4];
assign pl[3]   = p[20] | p[19] | p[17] | p[16] | p[15] | p[12];
assign pl[4]   = p[8];
assign pl[5]   = p[20] | p[17] | p[15] | p[13] | p[12] | p[11] | p[9]  | p[7]  | p[6]  | p[5]  | p[4] | p[1];
assign pl[6]   = p[20] | p[19] | p[18] | p[16] | p[15] | p[14] | p[12] | p[10] | p[9]  | p[7]  | p[5];
assign pl[7]   = p[19] | p[18] | p[17] | p[16] | p[14] | p[3]  | p[2];
assign pl[8]   = p[20] | p[19] | p[18] | p[17] | p[16] | p[15] | p[14] | p[13] | p[11] | p[9]  | p[6];
assign pl[9]   = p[14] | p[13] | p[12] | p[11] | p[10] | p[9]  | p[8]  | p[7]  | p[5]  | p[3]  | p[2] | p[0];
assign pl[10]  = p[20] | p[19] | p[18] | p[17] | p[16] | p[15] | p[14] | p[13] | p[12] | p[11] | p[5] | p[4];
endmodule

//______________________________________________________________________________
//
// Interrupt matrix rewritten (for clarity and readability)
//
module vm1_pli
(
   input  [19:0]  rq,
   output [10:0]  sp
);
wire [20:0] p;
wire [10:0] pl;
wire [3:1]  irq;
wire [11:0] psw;
wire  virq;
wire  plir, uerr;
wire  wcpu, dble;
wire  acok, aclo;    // ACLO detector requests
wire  iato, qbto;    // qbus timeouts and odd address

assign psw[10] = rq[0];
assign plir    = rq[1];
assign psw[11] = rq[2];
assign uerr    = rq[3];
assign psw[7]  = rq[4];
assign virq    = rq[8];       // low active level
assign qbto    = rq[9];
assign dble    = rq[10];
assign aclo    = rq[11];
assign wcpu    = rq[12];      // low active level
assign acok    = rq[13];
assign irq[1]  = rq[14];
assign psw[4]  = rq[15];
assign irq[2]  = rq[16];
assign iato    = rq[17];
assign irq[3]  = rq[18];

function cmp
(
   input [19:0] i,
   input [19:0] c,
   input [19:0] m
);
   cmp = &(~(i ^ c) | m);
endfunction

//______________________________________________________________________________
//
// wcpu = 0, simplified matrix to demostrate priority encoding
//
//                          iato   &  qbto;
//                         ~iato   &  qbto &  dble;
//    psw[11]            & ~iato   &  qbto & ~dble ;
//            &  psw[10] & ~iato   &  qbto & ~dble;
//   ~psw[11] & ~psw[10] & ~iato   &  qbto & ~dble;
//
//                                   ~qbto &  uerr;
//              ~psw[10] &  psw[4] & ~qbto & ~uerr;
//              ~psw[10] & ~psw[4] & ~qbto & ~uerr &  aclo;
//   ~psw[11] & ~psw[10] & ~psw[4] & ~qbto & ~uerr & ~aclo           &  irq[1];
//              ~psw[10] & ~psw[4] & ~qbto & ~uerr & ~aclo & ~psw[7] & ~irq[1] &  irq[2];
//              ~psw[10] & ~psw[4] & ~qbto & ~uerr & ~aclo & ~psw[7] & ~irq[1] & ~irq[2] &  irq[3];
//              ~psw[10] & ~psw[4] & ~qbto & ~uerr & ~aclo & ~psw[7] & ~irq[1] & ~irq[2] & ~irq[3] & ~virq;
//
assign p[0]    =  plir                                 & ~qbto & ~aclo & ~uerr &  wcpu           & ~irq[1] & ~irq[2] & ~irq[3] &  virq;
assign p[10]   =  plir            & ~psw[10]           & ~qbto & ~aclo & ~uerr &  wcpu           & ~irq[1];
assign p[3]    =  plir & ~psw[11] & ~psw[10] &  psw[4] & ~qbto & ~aclo & ~uerr &  wcpu           &  irq[1];
assign p[2]    =  plir & ~psw[11] & ~psw[10] & ~psw[4] & ~qbto & ~aclo & ~uerr                   &  irq[1];
assign p[1]    =  plir            & ~psw[10]           & ~qbto & ~aclo & ~uerr &  wcpu & ~psw[7] & ~irq[1] &  irq[2];
assign p[7]    =  plir            & ~psw[10] & ~psw[4] & ~qbto & ~aclo & ~uerr         & ~psw[7] & ~irq[1] &  irq[2];
assign p[6]    =  plir            & ~psw[10] &  psw[4] & ~qbto & ~aclo & ~uerr &  wcpu & ~psw[7] & ~irq[1] & ~irq[2] &  irq[3];
assign p[9]    =  plir            & ~psw[10] & ~psw[4] & ~qbto & ~aclo & ~uerr         & ~psw[7] & ~irq[1] & ~irq[2] &  irq[3];
assign p[4]    =  plir            & ~psw[10] &  psw[4] & ~qbto & ~aclo & ~uerr &  wcpu & ~psw[7] & ~irq[1] & ~irq[2] & ~irq[3] & ~virq;
assign p[5]    =  plir            & ~psw[10] & ~psw[4] & ~qbto & ~aclo & ~uerr         & ~psw[7] & ~irq[1] & ~irq[2] & ~irq[3] & ~virq;
assign p[11]   =  plir            & ~psw[10] & ~psw[4] & ~qbto &  aclo & ~uerr;
assign p[12]   =  plir            & ~psw[10] &  psw[4] & ~qbto         & ~uerr & ~wcpu;
assign p[13]   =  plir            & ~psw[10] &  psw[4] & ~qbto &  aclo & ~uerr &  wcpu;
assign p[20]   =  plir & ~psw[11] & ~psw[10] & ~iato   &  qbto & ~dble;
assign p[14]   =  plir &  psw[11]            & ~iato   &  qbto & ~dble;
assign p[18]   =  plir            &  psw[10] & ~iato   &  qbto & ~dble;
assign p[19]   =  plir                       & ~iato   &  qbto &  dble;
assign p[16]   =  plir                       &  iato   &  qbto;
assign p[15]   =  plir                       &  uerr   & ~qbto;
assign p[8]    = ~plir & ~acok;
assign p[17]   = ~plir &  acok;

assign sp      = ~pl;
assign pl[0]   = p[20] | p[19] | p[15] | p[9]  | p[7]  | p[6]  | p[1];     // 20, 19, 17, 16, 15, 13,
assign pl[1]   = p[20] | p[19] | p[17] | p[13] | p[11] | p[9]  | p[6];     // 12, 11, 9, 7, 6, 5, 4, 1
assign pl[2]   = p[20] | p[17] | p[16] | p[5]  | p[4];
assign pl[3]   = p[20] | p[19] | p[17] | p[16] | p[15] | p[12];
assign pl[4]   = p[8];
assign pl[5]   = p[20] | p[17] | p[15] | p[13] | p[12] | p[11] | p[9]  | p[7]  | p[6]  | p[5]  | p[4] | p[1];
assign pl[7]   = p[19] | p[18] | p[17] | p[16] | p[14] | p[3]  | p[2];
assign pl[9]   = p[14] | p[13] | p[12] | p[11] | p[10] | p[9]  | p[8]  | p[7]  | p[5]  | p[3]  | p[2] | p[0];
assign pl[6]   = p[20] | p[19] | p[18] |         p[16] | p[15] | p[14] | p[12] | p[10] | p[9]  | p[7] | p[5];
assign pl[8]   = p[20] | p[19] | p[18] | p[17] | p[16] | p[15] | p[14] | p[13] | p[11] | p[9]  | p[6];
assign pl[10]  = p[20] | p[19] | p[18] | p[17] | p[16] | p[15] | p[14] | p[13] | p[12] | p[11] | p[5] | p[4];
endmodule

//______________________________________________________________________________
//
// PLM and PLI identity checker. This module is intended for debug purposes only.
// The identity can also be checked by the viewing compilation results
// (most of checker's logic should be eliminated by redundant logic optimization)
//
module vm1_plm_check
(
   input    clk,        // input clock
   input    reset,      // module reset
   output   done,       // check done flag
   output   good        // check result
);
reg [28:0] entry;
reg result;

wire [33:0] orig[0:7];
wire [33:0] test[0:7];
wire [10:0] itest0, itest1;

//
// Run the 8 matrix instances in paralel
//
vm1_plm        mtest0(.ir(entry[15:0]), .mr({3'b000, entry[27:16]}), .sp(test[0]));
vm1_plm        mtest1(.ir(entry[15:0]), .mr({3'b001, entry[27:16]}), .sp(test[1]));
vm1_plm        mtest2(.ir(entry[15:0]), .mr({3'b010, entry[27:16]}), .sp(test[2]));
vm1_plm        mtest3(.ir(entry[15:0]), .mr({3'b011, entry[27:16]}), .sp(test[3]));
vm1_plm        mtest4(.ir(entry[15:0]), .mr({3'b100, entry[27:16]}), .sp(test[4]));
vm1_plm        mtest5(.ir(entry[15:0]), .mr({3'b101, entry[27:16]}), .sp(test[5]));
vm1_plm        mtest6(.ir(entry[15:0]), .mr({3'b110, entry[27:16]}), .sp(test[6]));
vm1_plm        mtest7(.ir(entry[15:0]), .mr({3'b111, entry[27:16]}), .sp(test[7]));

vm1_plm_model  model0(.ir(entry[15:0]), .mr({3'b000, entry[27:16]}), .sp(orig[0]));
vm1_plm_model  model1(.ir(entry[15:0]), .mr({3'b001, entry[27:16]}), .sp(orig[1]));
vm1_plm_model  model2(.ir(entry[15:0]), .mr({3'b010, entry[27:16]}), .sp(orig[2]));
vm1_plm_model  model3(.ir(entry[15:0]), .mr({3'b011, entry[27:16]}), .sp(orig[3]));
vm1_plm_model  model4(.ir(entry[15:0]), .mr({3'b100, entry[27:16]}), .sp(orig[4]));
vm1_plm_model  model5(.ir(entry[15:0]), .mr({3'b101, entry[27:16]}), .sp(orig[5]));
vm1_plm_model  model6(.ir(entry[15:0]), .mr({3'b110, entry[27:16]}), .sp(orig[6]));
vm1_plm_model  model7(.ir(entry[15:0]), .mr({3'b111, entry[27:16]}), .sp(orig[7]));

vm1_pli        iplm0(.rq(entry[19:0]), .sp(itest0));
vm1_pli_model  iplm1(.rq(entry[19:0]), .sp(itest1));

assign done = entry[28];
assign good = ~result;

always @(posedge clk or posedge reset)
begin
   if (reset)
   begin
      result   <= 1'b0;
      entry    <= 29'h0000000;
   end
   else
   begin
      if (~entry[28])
      begin
         entry  <= entry + 29'h00000001;
         if ( (test[0]  != orig[0])
            | (test[1]  != orig[1])
            | (test[2]  != orig[2])
            | (test[3]  != orig[3])
            | (test[4]  != orig[4])
            | (test[5]  != orig[5])
            | (test[6]  != orig[6])
            | (test[7]  != orig[7])
            | (itest0[10:0] != itest1[10:0]))
         begin
            result <= 1'b1;
         end
      end
   end
end
endmodule
