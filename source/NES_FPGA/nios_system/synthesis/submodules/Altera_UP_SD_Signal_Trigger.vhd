---------------------------------------------------------------------------------------
-- This module generates a trigger pulse every time it sees a transition
-- from 0 to 1 on signal i_signal.
--
-- NOTES/REVISIONS:
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Altera_UP_SD_Signal_Trigger is

	port
	(
		i_clock 		: in std_logic;
		i_reset_n	: in std_logic;
		i_signal		: in std_logic;
		o_trigger	: out std_logic
	);

end entity;

architecture rtl of Altera_UP_SD_Signal_Trigger is

	-- Local wires
	-- REGISTERED
	signal local_reg : std_logic;
begin

	process (i_clock, i_reset_n)
	begin
		if (i_reset_n = '0') then
			local_reg <= '0';
		else
			if (rising_edge(i_clock)) then
				local_reg <= i_signal;
			end if;
		end if;
	end process;

	o_trigger <= 	'1' when ((local_reg = '0') and (i_signal = '1'))
					else '0';
end rtl;