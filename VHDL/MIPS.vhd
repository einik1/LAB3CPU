				-- Top Level Structural Model for MIPS Processor Core h
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY MIPS IS

	PORT( nreset 					: IN 	STD_LOGIC ;
			clock						: IN 	STD_LOGIC ;
		 --Output important signals to pins for easy display in Simulator
		PC								: OUT  STD_LOGIC_VECTOR( 9 DOWNTO 0 );
		ALU_result_out, read_data_1_out, read_data_2_out, write_data_out,	
     	Instruction_out					: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		Branch_out, Zero_out, Memwrite_out, 
		Regwrite_out					: OUT 	STD_LOGIC 
		);
END 	MIPS;

ARCHITECTURE structure OF MIPS IS

	COMPONENT Ifetch
   	     PORT(	SIGNAL InstructionF 		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	SIGNAL PC_plus_4_outF 	: OUT	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        	SIGNAL PCBranchD 		: IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        	SIGNAL PCSrcD 			: IN 	STD_LOGIC;
        	--SIGNAL BranchD 			: IN 	STD_LOGIC;
        	SIGNAL StallF    : IN STD_LOGIC;
      	SIGNAL PC_outF 			: OUT	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        	SIGNAL clock, reset 	: IN 	STD_LOGIC
			--SIGNAL PCFFF : OUT 	STD_LOGIC_VECTOR( 7 DOWNTO 0 )
			);
	END COMPONENT; 

	COMPONENT Idecode
 	     PORT(	InstructionD 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			WriteRegW 			: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			ResultW				: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			forwarfAD 			: IN 	STD_LOGIC;
			forwarfBD 			: IN 	STD_LOGIC;	
			PC_plus_4D 			: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
			ALU_OUT_M 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			RegWriteW 			: IN 	STD_LOGIC;
			read_data_1D		: OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data_2D		: OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Sign_extendD 		: OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			EqualD 				: OUT	STD_LOGIC;
			PCBranchD 			: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
			RsD 					: OUT	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			RtD 					: OUT	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			RdD 					: OUT	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			clock,reset			: IN 	STD_LOGIC );
			--read_dataD 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			--ALU_resultW			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			--MemtoRegD 			: IN 	STD_LOGIC;
			--RegDstD 				: IN 	STD_LOGIC;						
	END COMPONENT;

	COMPONENT control
	     PORT( 	Opcode 			: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	Funct				: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	EqualD         : IN 	STD_LOGIC;
	RegWriteD 		: OUT 	STD_LOGIC;
	MemtoRegD 		: OUT 	STD_LOGIC;
	MemWriteD 		: OUT 	STD_LOGIC;
	ALUControlID 	: OUT 	STD_LOGIC_VECTOR( 2 DOWNTO 0 );--ALUopD
	ALUSrcD 			: OUT 	STD_LOGIC;
	RegDstD 			: OUT 	STD_LOGIC;
	BranchD 			: OUT 	STD_LOGIC;
	PCSrcD			: OUT 	STD_LOGIC;
	Lui				: OUT 	STD_LOGIC;
	--MemReadD 		: OUT 	STD_LOGIC;	
	clock, reset	: IN 	STD_LOGIC );
	END COMPONENT;

	COMPONENT  Execute
   	    PORT(	Read_data_1E 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Read_data_2E 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Sign_extendE 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			RtE				: IN 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			RdE				: IN 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			ALUControlE		: IN 	STD_LOGIC_VECTOR( 2 DOWNTO 0 );
			ALUSrcE			: IN 	STD_LOGIC;
			RegDstE			: IN 	STD_LOGIC;
			ForwardAE		: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			ForwardBE		: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			ALUOutM 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ResultW		 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ALU_ResultE		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			WriteDataE		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			WriteRegE		: OUT	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			Lui				: IN 	STD_LOGIC;
			clock, reset	: IN 	STD_LOGIC );			
			--Function_opcode : IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
			--ALUOp 			: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			--ALUSrc 			: IN 	STD_LOGIC;
			--Zero 			: OUT	STD_LOGIC;			
			--Add_Result 		: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
			--PC_plus_4 		: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	END COMPONENT;


	COMPONENT dmemory
	     PORT(	read_data 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	address 				: IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        	write_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	   	Memwrite : IN 	STD_LOGIC;
			--MemRead,
         clock,reset			: IN 	STD_LOGIC );
	END COMPONENT;
	
	COMPONENT Hazard_Unit 
  PORT( 
	StallF, StallD, ForwardAD, ForwardBD, FlushE : OUT  	STD_LOGIC; 
	ForwardAE, ForwardBE : OUT  STD_LOGIC_VECTOR( 1 DOWNTO 0 );
	clock, BranchD, MemToRegE,MemToRegM, RegWriteE, RegWriteM, RegWriteW : IN  	STD_LOGIC;  -- MemtoRegM ???
	RsD,RtD,RsE,RtE, WriteRegE, WriteRegM,WriteRegW : IN  STD_LOGIC_VECTOR( 4 DOWNTO 0 ));
	END 	COMPONENT;
	
	COMPONENT DFF_Register is 
			generic (N : integer);
			port (clock, rst, ld : in std_logic; -- clock reset and load
					d : in STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0'); -- data
					q : out STD_LOGIC_VECTOR(N-1 downto 0):= (others => '0')); -- output
	end COMPONENT;

					-- declare signals used to connect VHDL components
	SIGNAL reset 		: STD_LOGIC;				
	--signals for ifetch
	 SIGNAL InstructionF 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
   SIGNAL PC_plus_4_outF 	: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
   SIGNAL PCBranchD 			: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
   SIGNAL PCSrcD 				: STD_LOGIC;
   SIGNAL BranchD 			: STD_LOGIC;
   SIGNAL StallF    			: STD_LOGIC;
   SIGNAL PC_outF 			: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
   SIGNAL StallD    			: STD_LOGIC;
	SIGNAL nStallD    			: STD_LOGIC;
	 SIGNAL DFF1in : STD_LOGIC_VECTOR( 41 DOWNTO 0 );
  	SIGNAL DFF1out : STD_LOGIC_VECTOR(41 DOWNTO 0 );
	
	 --signals for control
	 SIGNAL           RegWriteD 		:  	STD_LOGIC;
	 SIGNAL           MemtoRegD 		:  	STD_LOGIC;
	 SIGNAL           MemWriteD 		:  	STD_LOGIC;
	 SIGNAL           EqualD 		:  	STD_LOGIC;	 
	 SIGNAL           ALUControlID 	:  	STD_LOGIC_VECTOR( 2 DOWNTO 0 );--ALUopD
	 SIGNAL           ALUSrcD 			:  	STD_LOGIC;
	 SIGNAL           RegDstD 			:  	STD_LOGIC;	
	 SIGNAL 				Luis				:  	STD_LOGIC;
  	
  	--signals for dcode
  	--SIGNAL	WriteRegW 			: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	 SIGNAL	ResultW				:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 SIGNAL	forwarfAD 			:  	STD_LOGIC;
	 SIGNAL	forwarfBD 			:  	STD_LOGIC;	
	 --SIGNAL	PC_plus_4D 			:  	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	 SIGNAL	read_data_1D		:  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 SIGNAL	read_data_2D		:  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 SIGNAL	Sign_extendD 		:  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 SIGNAL	RsD 					: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	 SIGNAL	RtD 					: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	 SIGNAL	RdD 					: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	 SIGNAL DFF2in : STD_LOGIC_VECTOR( 119 DOWNTO 0 );
	 SIGNAL DFF2out : STD_LOGIC_VECTOR(119 DOWNTO 0 );	
	 
	
	 
	 --signals for execute	
	 SIGNAL		ForwardAE		:  	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
	 SIGNAL		ForwardBE		:  	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
	 SIGNAL		ALU_ResultE		:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 SIGNAL		WriteDataE		:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 SIGNAL		WriteRegE		:  	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	 SIGNAL DFF3in : STD_LOGIC_VECTOR(71 DOWNTO 0 );
	 SIGNAL DFF3out : STD_LOGIC_VECTOR(71 DOWNTO 0 );
	 
	 --signals for execute	
	 SIGNAL read_data 			:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 SIGNAL DFF4in : STD_LOGIC_VECTOR(70 DOWNTO 0);
	 SIGNAL DFF4out : STD_LOGIC_VECTOR(70 DOWNTO 0 );
					
	 --signals for Hazard_Unit	
	 SIGNAL FlushE	:  	STD_LOGIC;
	--SIGNAL PCFFF :  	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	
BEGIN
					-- copy important signals to output pins for easy 
					-- display in Simulator
    Instruction_out 	<= DFF1out(41 DOWNTO 10 );
  ALU_result_out 	<= DFF3out (71 DOWNTO 40 );
  read_data_1_out 	<= read_data_1D;
   read_data_2_out 	<= read_data_2D;
   write_data_out  	<= ResultW;
   Branch_out 		<= BranchD;
   Zero_out 		<= EqualD;
   RegWrite_out 	<= RegWriteD;
   MemWrite_out 	<= MemWriteD;
	PC <= PC_outF;
					-- connect the 5 MIPS components   
	reset <= nreset ; --not(nreset);
  
  IFE : Ifetch
	PORT MAP (	 InstructionF 	=> InstructionF,
        	 PC_plus_4_outF 		=> PC_plus_4_outF,
        	 PCBranchD 				=> PCBranchD,
        	 PCSrcD 					=> PCSrcD,
        	 --BranchD 				=> BranchD,
        	 StallF    				=> StallF,
    	    PC_outF 				=>PC_outF,
        	 clock 					=> clock,
			 reset 					=> reset
			--PCFFF => PCFFF 
			);
			 
	DFF1in <= InstructionF & PC_plus_4_outF ;
	nStallD <= not(StallD);
	--SIGNAL InstructionF 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
  --SIGNAL PC_plus_4_outF 	: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
  --SIGNAL DFF1in : STD_LOGIC_VECTOR( 41 DOWNTO 0 );
  
  	DF1: DFF_Register  
	generic MAP(42 )
	port MAP(clock => clock,
			rst =>PCSrcD,
			ld =>nStallD,
			d => DFF1in , 
			q => DFF1out); 
			
	--DFF1out <= InstructionD & PC_plus_4_outD ;
  --SIGNAL DFF1out : STD_LOGIC_VECTOR(41 DOWNTO 0 );
  --SIGNAL InstructionD 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
  --SIGNAL PC_plus_4_outD 	: STD_LOGIC_VECTOR( 9 DOWNTO 0 );	

  ID : Idecode
 	PORT MAP (	InstructionD 		=> DFF1out(41 DOWNTO 10 ),
			WriteRegW 			=> DFF4out(4 downto 0),
			ResultW				=> ResultW,
			forwarfAD 			=> forwarfAD,
			forwarfBD 			=> forwarfBD,
			PC_plus_4D 			=> DFF1out(9 DOWNTO 0 ),
			ALU_OUT_M 			=> DFF3out (71 DOWNTO 40 ),
			RegWriteW 			=> DFF4out(6),
			read_data_1D		=> read_data_1D,
			read_data_2D		=> read_data_2D,
			Sign_extendD 		=> Sign_extendD,
			EqualD 				=> EqualD,
			PCBranchD 			=> PCBranchD,
			RsD 					=> RsD,
			RtD 					=> RtD,
			RdD 					=> RdD,
			clock => clock,
			reset			=> reset);
			
	CTL:   control
	PORT MAP ( 	Opcode 		=> DFF1out(41 DOWNTO 36 ),
	            Funct			=> DFF1out(15 DOWNTO 10 ),
					EqualD      => EqualD,
	            RegWriteD 		=> RegWriteD,
	            MemtoRegD 		=> MemtoRegD,
	            MemWriteD 		=> MemWriteD,
	            ALUControlID 	=> ALUControlID,
	            ALUSrcD 			=> ALUSrcD,
	            RegDstD 			=> RegDstD,
	            BranchD 			=> BranchD,
					PCSrcD         => PCSrcD,
					Lui				=> Luis,
	            clock => clock,
	            reset	=> reset);
			
		
		DFF2in <= Luis & read_data_1D & read_data_2D & RsD & RtD & RdD & Sign_extendD & RegWriteD & MemtoRegD & MemWriteD & ALUControlID & ALUSrcD & RegDstD;
		--SIGNAL DFF2in : STD_LOGIC_VECTOR( 119 DOWNTO 0 );
		--SIGNAL           Luis 			:  	STD_LOGIC;
		--SIGNAL	read_data_1D		:  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		--SIGNAL	read_data_2D		:  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		--SIGNAL	RsD 					: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		--SIGNAL	RtD 					: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
		--SIGNAL	RdD 					: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );	
		--SIGNAL	Sign_extendD 		:  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 --SIGNAL           RegWriteD 		: OUT 	STD_LOGIC;
	 --SIGNAL           MemtoRegD 		: OUT 	STD_LOGIC;
	 --SIGNAL           MemWriteD 		: OUT 	STD_LOGIC;
	 --SIGNAL           ALUControlID 	: OUT 	STD_LOGIC_VECTOR( 2 DOWNTO 0 );--ALUopD
	 --SIGNAL           ALUSrcD 			: OUT 	STD_LOGIC;
	 --SIGNAL           RegDstD 			: OUT 	STD_LOGIC;
		
	DF2: DFF_Register  
	generic MAP( 120 )
	port MAP (clock => clock,
			rst =>FlushE,
			ld =>'1',
			d => DFF2in, 
			q => DFF2out);
			
	--DFF2out <= read_data_1E & read_data_2E & RsE & RtE & RdE & Sign_extendE & RegWriteE & MemtoRegE & MemWriteE & ALUControlIE & ALUSrcE & RegDstE;
	--SIGNAL DFF2out : STD_LOGIC_VECTOR(119 DOWNTO 0);
	--SIGNAL           Luis 			:  	STD_LOGIC;
	--SIGNAL	read_data_1E		:  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	--SIGNAL	read_data_2E		:  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	--SIGNAL	RsE 					: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	--SIGNAL	RtE 					: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	--SIGNAL	RdE 					: 	STD_LOGIC_VECTOR( 4 DOWNTO 0 );	
	--SIGNAL	Sign_extendE 		:  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 --SIGNAL           RegWriteE 		: OUT 	STD_LOGIC;
	 --SIGNAL           MemtoRegE 		: OUT 	STD_LOGIC;
	 --SIGNAL           MemWriteE 		: OUT 	STD_LOGIC;
	 --SIGNAL           ALUControlIE 	: OUT 	STD_LOGIC_VECTOR( 2 DOWNTO 0 );--ALUopD
	 --SIGNAL           ALUSrcE 			: OUT 	STD_LOGIC;
	 --SIGNAL           RegDstE 			: OUT 	STD_LOGIC;
  
	EXE:  Execute
   	PORT MAP (	Read_data_1E 	=> DFF2out(118 DOWNTO 87 ),
			Read_data_2E 	=> DFF2out(86 DOWNTO 55 ),
			Sign_extendE 	=> DFF2out(39 DOWNTO 8 ),
			RtE				=> DFF2out(49 DOWNTO 45 ),
			RdE				=> DFF2out(44 DOWNTO 40 ),
			ALUControlE		=> DFF2out(4 DOWNTO 2 ),
			ALUSrcE			=> DFF2out(1),
			RegDstE			=> DFF2out(0),
			ForwardAE		=> ForwardAE,
			ForwardBE		=> ForwardBE,
			ALUOutM 			=> DFF3out (71 DOWNTO 40 ),
			ResultW		 	=> ResultW,
			ALU_ResultE		=> ALU_ResultE,
			WriteDataE		=> WriteDataE,
			WriteRegE		=> WriteRegE,
			Lui				=> DFF2out(119),
			clock => clock,
			reset	=> reset );			
			
			
			 DFF3in <= ALU_ResultE & WriteDataE & WriteRegE &DFF2out(7) & DFF2out(6) & DFF2out(5);
			 --SIGNAL DFF3in : STD_LOGIC_VECTOR( 71 DOWNTO 0 );
			 --SIGNAL		ALU_ResultE		:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 --SIGNAL		WriteDataE		:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 --SIGNAL		WriteRegE		:  	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			  --SIGNAL           RegWriteE 		: OUT 	STD_LOGIC;
			  --SIGNAL           MemtoRegE 		: OUT 	STD_LOGIC;
			  --SIGNAL           MemWriteE 		: OUT 	STD_LOGIC;
	 
			
	DF3: DFF_Register  
	generic MAP ( 72 )
	port MAP (clock => clock,
			rst =>reset,
			ld =>'1',
			d => DFF3in,
			q => DFF3out); 
			
			
			-- DFF3out <= ALU_ResultM & WriteDataM & WriteRegM & RegWriteM & MemtoRegM & MemWriteM;
			--	 SIGNAL DFF3out : STD_LOGIC_VECTOR(71 DOWNTO 0 );
			--SIGNAL		ALU_ResultM		:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 --SIGNAL		WriteDataM		:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 --SIGNAL		WriteRegM		:  	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			  --SIGNAL           RegWriteM 		: OUT 	STD_LOGIC;
			  --SIGNAL           MemtoRegM 		: OUT 	STD_LOGIC;
			  --SIGNAL           MemWriteM 		: OUT 	STD_LOGIC;
			
	MEM:  dmemory
	PORT MAP(	read_data => read_data,
        	address 	=> DFF3out (47 DOWNTO 40 ),
        	write_data => DFF3out (39 DOWNTO 8 ),
	   	Memwrite => DFF3out (0),
         clock => clock,
			reset	=> reset );

	
	 DFF4in <= read_data & DFF3out (71 DOWNTO 40 ) & DFF3out (2) & DFF3out (1) & DFF3out (7 DOWNTO 3 ) ;
    --SIGNAL DFF4in : STD_LOGIC_VECTOR(70 DOWNTO 0 );	
	 --SIGNAL	read_data 			:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 --SIGNAL		ALU_ResultM		:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 --SIGNAL           RegWriteM 		: OUT 	STD_LOGIC;
	 --SIGNAL           MemtoRegM 		: OUT 	STD_LOGIC;
	 --SIGNAL		WriteRegM		:  	STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	 
				
	DF4: DFF_Register  
	generic MAP ( 71 )
	port MAP (clock => clock,
			rst =>reset,
			ld =>'1',
			d => DFF4in , --read_data & ALU_result
			q => DFF4out);--DFF4read_data & DFF4ALU_result
			
	--DFF4out <= read_dataW & ALU_ResultW	& RegWriteW & MemtoRegW & WriteRegW;
	--SIGNAL DFF4out : STD_LOGIC_VECTOR(70 DOWNTO 0 );
	--SIGNAL	read_dataW 			:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 --SIGNAL		ALU_ResultW		:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	 --SIGNAL           RegWriteW 		: OUT 	STD_LOGIC;
	 --SIGNAL           MemtoRegW 		: OUT 	STD_LOGIC;
	 --SIGNAL		WriteRegW		:  	STD_LOGIC_VECTOR( 4 DOWNTO 0 );		
	
	ResultW <= DFF4out(70 downto 39) 
	WHEN (DFF4out(5) = '1')
	ELSE DFF4out(38 downto 7);
	  
	  
	HU: Hazard_Unit 
  port MAP( 
  
	StallF=>StallF,
	StallD=>StallD,
	ForwardAD=>forwarfAD,
	ForwardBD=>forwarfBD,
	FlushE=>FlushE,
	ForwardAE=>ForwardAE,
	ForwardBE=>ForwardBE,
	clock => clock,
	BranchD=>BranchD,
	MemToRegE=>DFF2out(6),
	MemToRegM=>DFF3out (1),
	RegWriteE=>DFF2out(7),
	RegWriteM=>DFF3out (2),
	RegWriteW=>DFF4out(6),
	RsD=>RsD,
	RtD=>RtD,
	RsE=>DFF2out(54 downto 50),
	RtE=>DFF2out(49 DOWNTO 45 ),
	WriteRegE=>WriteRegE,
	WriteRegM=>DFF3out (7 DOWNTO 3 ),
	WriteRegW=>DFF4out(4 downto 0));
	
	
				
END structure;

