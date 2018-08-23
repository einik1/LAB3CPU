onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {New Group} /mips_tb/ALU_result_out
add wave -noupdate -expand -group {New Group} /mips_tb/Branch_out
add wave -noupdate -expand -group {New Group} -radix hexadecimal /mips_tb/Instruction_out
add wave -noupdate -expand -group {New Group} -radix hexadecimal /mips_tb/U_0/ID/register_array
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/ID/RegWriteW
add wave -noupdate -expand -group {New Group} -radix decimal /mips_tb/U_0/ID/write_data
add wave -noupdate -expand -group {New Group} -radix decimal /mips_tb/U_0/read_data
add wave -noupdate -expand -group {New Group} -radix decimal /mips_tb/U_0/MEM/read_data
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/MEM/address
add wave -noupdate -expand -group {New Group} -radix decimal /mips_tb/U_0/MEM/write_data
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/MEM/Memwrite
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/DFF3out
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/DFF4out
add wave -noupdate -expand -group {New Group} -radix decimal /mips_tb/read_data_1_out
add wave -noupdate -expand -group {New Group} -radix decimal /mips_tb/read_data_2_out
add wave -noupdate -expand -group {New Group} -radix decimal /mips_tb/U_0/ResultW
add wave -noupdate -expand -group {New Group} /mips_tb/Memwrite_out
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/PCSrcD
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/clock
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/Read_data_1E
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/Read_data_2E
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/Sign_extendE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/RtE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/RdE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/ALUSrcE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/RegDstE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/ForwardAE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/ForwardBE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/ResultW
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/WriteDataE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/WriteRegE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/ALUControlE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/Ainput
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/Binput
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/ALU_ResultE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/EXE/ALUOutM
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/StallF
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/StallD
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/ForwardAD
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/ForwardBD
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/FlushE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/ForwardAE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/ForwardBE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/clock
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/BranchD
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/MemToRegE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/MemToRegM
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/RegWriteE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/RegWriteM
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/RegWriteW
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/RsD
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/RtD
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/RsE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/RtE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/WriteRegE
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/WriteRegM
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/WriteRegW
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/Lws
add wave -noupdate -expand -group {New Group} /mips_tb/U_0/HU/Brs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99695060 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 222
configure wave -valuecolwidth 462
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {99489358 ps} {100026876 ps}
