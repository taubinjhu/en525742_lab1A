LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY toplevel IS
  PORT (
    reset_pb : IN STD_LOGIC;
    sysclk : IN STD_LOGIC;
    led : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END toplevel;
ARCHITECTURE Behavioral OF toplevel IS
  SIGNAL ctr : unsigned(3 DOWNTO 0);
  SIGNAL rstn, ena_2Hz : STD_LOGIC;
  COMPONENT clkdivider IS
    GENERIC (divideby : NATURAL := 2);
    PORT (
      clk : IN STD_LOGIC;
      resetn : IN STD_LOGIC;
      pulseout : OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  rstn <= NOT reset_pb;
  make2Hz : clkdivider GENERIC MAP(divideby => 62500000)
  PORT MAP(clk => sysclk, resetn => rstn, pulseout => ena_2hz);
  -- just a silly counter for demo purposes
  PROCESS (sysclk, rstn)
  BEGIN
    IF rstn = '0' THEN
      ctr <= (OTHERS => '0');
    ELSIF rising_edge(sysclk) THEN
      IF ena_2hz = '1' THEN
        ctr <= ctr + 1;
      END IF;
    END IF;
  END PROCESS;
  led <= STD_LOGIC_VECTOR(ctr);
END Behavioral;