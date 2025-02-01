LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY tb_toplevel IS
END tb_toplevel;
ARCHITECTURE tb OF tb_toplevel IS
  COMPONENT toplevel
    PORT (
      reset_pb : IN STD_LOGIC;
      sysclk : IN STD_LOGIC;
      led : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
  END COMPONENT;
  SIGNAL reset_pb : STD_LOGIC;
  SIGNAL clk_in : STD_LOGIC;
  SIGNAL led : STD_LOGIC_VECTOR (3 DOWNTO 0);
  CONSTANT TbPeriod : TIME := 8 ns;
  SIGNAL TbClock : STD_LOGIC := '0';
BEGIN
  dut : toplevel
  PORT MAP(
    reset_pb => reset_pb,
    sysclk => clk_in,
    led => led);
  TbClock <= NOT TbClock AFTER TbPeriod/2;
  clk_in <= TbClock;
  stimuli : PROCESS
  BEGIN
    reset_pb <= '0';
    WAIT FOR 232 ns;
    reset_pb <= '1';
    WAIT;
  END PROCESS;
END tb;