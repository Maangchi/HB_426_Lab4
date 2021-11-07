library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity top_level is
    generic (N : integer := 15;
             R : integer := 2);
    port    (clk : in std_logic);
    
end top_level;
architecture simple of top_level is

    --Control signals
    signal Opcode_MemtoReg : std_logic;
    signal Opcode_ALUSrc : std_logic;
    signal Opcode_RegDst : std_logic;
    signal ALUctr : unsigned(R downto 0);
    signal Opcode_ALU_Control_Unit : unsigned(R downto 0);
    signal RegWr: std_logic;
    signal Jump_Sig : std_logic;
    signal Opcode_Branch : std_logic;
    signal Instruction_ToOp : unsigned(3 downto 0);
    signal Opcode_ClearReg : std_logic;
    signal Opcode_LoadImmediatesMux : std_logic;
    signal Opcode_LoadImmediate_Selection : unsigned(1 downto 0);
    
    --Registers Signals for 
    signal Write_Register : unsigned(R downto 0);
    signal busA : unsigned(N downto 0);
    signal busB : unsigned(N downto 0);
    signal busW : unsigned(N downto 0);
    
    --Instruction Memory Signal
    signal Rd   : unsigned(R downto 0);
    signal Rs   : unsigned(R downto 0);
    signal Rt   : unsigned(R downto 0);
    signal func : unsigned(R downto 0);
    signal To_Opcode : unsigned(3 downto 0);
    signal immediate_sig : unsigned(5 downto 0);
    
    --Data Memory Signals for 
    signal Mem_Write_sig : std_logic;
    signal Mem_Read_sig : std_logic;
    signal Read_Data_Mux : unsigned(N downto 0);
    
    --MemtoReg Mux Signals to 
    signal ALU_Result: unsigned(N downto 0);
    signal MemToReg_Result: unsigned(N downto 0);
    --Loads Immediates Mux signals
    signal Loads_Immediates_Mux_Result : unsigned(N downto 0);
    
    --ALU Src Mux Signals
    signal Result_of_ALU_Src : unsigned(N downto 0);
    
    --Sign Extend signals
    signal immediate : unsigned(5 downto 0);
    signal Sign_extend_Result_sig : unsigned (N downto 0);
    
    --Small Adder one Signal from PC to 
    signal From_PC : unsigned(N downto 0);
    signal Plus_One : unsigned(N downto 0);
    signal Small_Adder_One_Result : unsigned(N downto 0);
    
    --Small Adder Two Signal For 
    signal Small_Adder_Two_Result : unsigned(N downto 0);
    
    --Instruction Memory signals
    signal To_Instruction_Mem : unsigned(N downto 0);
    signal Instruction_Jump_Shift : unsigned(11 downto 0);
    
    --AND gate signal 
    signal ALU_Zero :  std_logic;
    signal ALUZero_To_And: std_logic;
    signal Out_to_Mux_Branch : std_logic;
    
    --Branch Mux signals 
    signal To_PC : unsigned(15 downto 0);
    
    --Clear Reg Mux Signals
    signal ClearMux_Result : unsigned(N downto 0);
    signal ClearOn : unsigned(N downto 0);
    --Jump Mux signals 
    signal To_Jump_Mux : unsigned(15 downto 0);
    
    --Shift BubbleS Jump
    signal Shift_Amount_Jump : unsigned(3 downto 0) := "0010";
    signal Shift_Bubble_To_Jump_Mux : unsigned(N downto 0);
    signal Load_Immediates_Results_Result : unsigned(N downto 0);
    signal Load_Immediate_Result : unsigned(N downto 0);
    signal Shift_Amount : unsigned (3 downto 0);
    
    --Combine Jump and Small adder signal
    signal Jump_Address : unsigned(N downto 0);
    
    --Shift Bubble Sign Extend
    signal SHSE_Result : unsigned(N downto 0);
begin
    
    Instruction_Memory : entity work.Instruction_Memory(behavioral)
    port map(Read_Address=>From_PC,
             Rs=>Rs,
             Rt=>Rt,
             Rd=>Rd,
             Func=>Func,
             immediate=>immediate_sig,
             Opcode=>Instruction_ToOp,
             Instruction_Jump_shift=>Instruction_Jump_Shift);
           
    PC : entity work.PC(behavioral)
    generic map(N=>N)
    port map(clk=>clk,
             A=>To_PC,
             C=>From_PC);
    
    Control : entity work.Control(behavioral)
    port map(Opcode => Instruction_ToOp,
           RegDst=> Opcode_RegDst,
           Func => Func,
           Branch=> Opcode_Branch,
           MemRead=>Mem_Read_sig,
           MemtoReg=>Opcode_MemtoReg,
           ALUOp=>ALUCtr,
           MemWrite=>Mem_Write_sig,
           ALUSrc=>Opcode_ALUSrc,
           RegWrite=>RegWr,
           LoadImmediateSelect=>Opcode_LoadImmediate_Selection,
           ClearReg=>Opcode_ClearReg,
           LoadImmediatesMux=>Opcode_LoadImmediatesMux,
           Jump=>Jump_Sig);
           
    ALU : entity work.ALU(behavior)
    generic map(N => N,
                R => R)
    port map(ALUctr => ALUctr,
             BusA => busA,
             BusB => Result_of_ALU_Src,
             Result => busW,
             Zero => ALU_Zero
             );
             
     Registers : entity work.Registers(behavior)
     generic map(N => N,
                R => R)
     port map(clk => clk,
             Rd => Write_Register,
             RegWr => RegWr,
             Rs => Rs,
             Rt => Rt,
             busW => ClearMux_Result,
             BusA => BusA,
             BusB => BusB);
             
      Mem : entity work.Data_Memory(Behavioral)
      generic map(N => N)
      port map(clk => clk,
               ALU_Result=>busW,
               Write_Data=>BusB,
               MemWrite=>Mem_Write_sig,
               MemRead=>Mem_Read_sig,
               Read_Data=> Read_Data_Mux);
           
       MUX_MemToReg : entity work.Mux(Behavioral)
       generic map(N => N)
       port map(Sel=> Opcode_MemtoReg,
                A=>Read_Data_Mux,
                B=>busW,
                C=>MemToReg_Result);
       
       MUX_ClearReg : entity work.Mux(Behavioral)
       generic map(N => N)
       port map(Sel=> Opcode_ClearReg,
                A=>MemToReg_Result,
                B=>ClearOn,
                C=>ClearMux_Result);
               
       MUX_ALUSrc : entity work.Mux(Behavioral)
       generic map(N => N)
       port map(Sel=> Opcode_ALUSrc,
                A=>BusB,
                B=>Loads_Immediates_Mux_Result,
                C=>Result_of_ALU_Src);
                
       MUX_LoadImmediates : entity work.Mux(Behavioral)
       generic map(N => N)
       port map(Sel=> Opcode_LoadImmediatesMux,
                A=>Sign_Extend_Result_sig,
                B=>Load_Immediate_Result,
                C=>Loads_Immediates_Mux_Result);
                
       Mux_RegDst : entity work.Mux(Behavioral)
       generic map(N => 2)
       port map(Sel=>Opcode_RegDst,
                A=>Rt,
                B=>Rd,
                C=>Write_Register);
                
        Mux_Branch : entity work.Mux(Behavioral)
        generic map(N => N)
        port map(Sel=>Out_to_Mux_Branch,
                A=> Small_Adder_One_Result,
                B=> Small_Adder_Two_Result,
                C=>To_Jump_Mux);
                
        Mux_Jump : entity work.Mux(Behavioral)
        generic map(N => N)
        port map(Sel=>Jump_Sig,
                A=> To_Jump_Mux,
                B=> Jump_Address,
                C=>To_PC);        
        
        AND_GATE : entity work.And_gate(Behavioral)
        port map(A => Opcode_Branch,
                 B => ALU_Zero,
                 C => Out_to_Mux_Branch);            
                        
        Sign_Extend : entity work.Sign_Extend(Behavioral)
        generic map(N => N)
        port map(Immediate=>immediate_sig,
                 Sign_Extend_Result=>Sign_Extend_Result_sig);
                 
        Small_Adder_One : entity work.Small_Adder(Behavioral)
        generic map(N => N)
        port map(A=>From_PC,
                 B=>Plus_One, ---this should be just 1, since we only move one line to reach the next instruction address
                 C=>Small_Adder_One_Result);
        
        Small_Adder_Two : entity work.Small_Adder(Behavioral)
        generic map(N => N)
        port map(A=>Small_Adder_One_Result,
                 B=>SHSE_Result,
                 C=>Small_Adder_Two_Result);
                 
        Shift_Bubble_Jump : entity work.Shift_Bubble(Behavioral)
        generic map(N => N,
                    R => 11)
        port map(A=>Instruction_Jump_Shift,
                 B=>Shift_Amount_Jump,
                 C=>Shift_Bubble_To_Jump_Mux);
        
        Shift_Bubble_Sign_Extend : entity work.Shift_Bubble(Behavioral)
        generic map(N => N,
                    R => N)
        port map(A=>Sign_Extend_Result_sig,
                 B=>Shift_Amount_Jump,
                 C=>SHSE_Result);
        
        Load_Immediate_Component : entity work.Load_Immediate_Component(Behavioral)
        generic map(N=>N,
                    R => 1)
        port map(A=>Sign_Extend_Result_sig,
                 B=>Opcode_LoadImmediate_Selection,
                 C=>Load_Immediate_Result
                 );          
        
        Combine_JShift_OneSmall : entity work.Combine_JShift_OneSmall(Behavioral)
        generic map(N => N)
        port map(A=>Shift_Bubble_To_Jump_Mux,
                 B=>Small_Adder_One_Result,
                 C=>Jump_Address);           

end architecture;