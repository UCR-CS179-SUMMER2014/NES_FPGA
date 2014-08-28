-- Altera_UP_SD_Card_Avalon_Interface_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Altera_UP_SD_Card_Avalon_Interface_0 is
	port (
		i_avalon_chip_select : in    std_logic                     := '0';             -- avalon_sdcard_slave.chipselect
		i_avalon_address     : in    std_logic_vector(7 downto 0)  := (others => '0'); --                    .address
		i_avalon_read        : in    std_logic                     := '0';             --                    .read
		i_avalon_write       : in    std_logic                     := '0';             --                    .write
		i_avalon_byteenable  : in    std_logic_vector(3 downto 0)  := (others => '0'); --                    .byteenable
		i_avalon_writedata   : in    std_logic_vector(31 downto 0) := (others => '0'); --                    .writedata
		o_avalon_readdata    : out   std_logic_vector(31 downto 0);                    --                    .readdata
		o_avalon_waitrequest : out   std_logic;                                        --                    .waitrequest
		i_clock              : in    std_logic                     := '0';             --          clock_sink.clk
		i_reset_n            : in    std_logic                     := '0';             --    clock_sink_reset.reset_n
		b_SD_cmd             : inout std_logic                     := '0';             --         conduit_end.export
		b_SD_dat             : inout std_logic                     := '0';             --                    .export
		b_SD_dat3            : inout std_logic                     := '0';             --                    .export
		o_SD_clock           : out   std_logic                                         --                    .export
	);
end entity Altera_UP_SD_Card_Avalon_Interface_0;

architecture rtl of Altera_UP_SD_Card_Avalon_Interface_0 is
	component Altera_UP_SD_Card_Avalon_Interface is
		port (
			i_avalon_chip_select : in    std_logic                     := 'X';             -- chipselect
			i_avalon_address     : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- address
			i_avalon_read        : in    std_logic                     := 'X';             -- read
			i_avalon_write       : in    std_logic                     := 'X';             -- write
			i_avalon_byteenable  : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			i_avalon_writedata   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			o_avalon_readdata    : out   std_logic_vector(31 downto 0);                    -- readdata
			o_avalon_waitrequest : out   std_logic;                                        -- waitrequest
			i_clock              : in    std_logic                     := 'X';             -- clk
			i_reset_n            : in    std_logic                     := 'X';             -- reset_n
			b_SD_cmd             : inout std_logic                     := 'X';             -- export
			b_SD_dat             : inout std_logic                     := 'X';             -- export
			b_SD_dat3            : inout std_logic                     := 'X';             -- export
			o_SD_clock           : out   std_logic                                         -- export
		);
	end component Altera_UP_SD_Card_Avalon_Interface;

begin

	altera_up_sd_card_avalon_interface_0 : component Altera_UP_SD_Card_Avalon_Interface
		port map (
			i_avalon_chip_select => i_avalon_chip_select, -- avalon_sdcard_slave.chipselect
			i_avalon_address     => i_avalon_address,     --                    .address
			i_avalon_read        => i_avalon_read,        --                    .read
			i_avalon_write       => i_avalon_write,       --                    .write
			i_avalon_byteenable  => i_avalon_byteenable,  --                    .byteenable
			i_avalon_writedata   => i_avalon_writedata,   --                    .writedata
			o_avalon_readdata    => o_avalon_readdata,    --                    .readdata
			o_avalon_waitrequest => o_avalon_waitrequest, --                    .waitrequest
			i_clock              => i_clock,              --          clock_sink.clk
			i_reset_n            => i_reset_n,            --    clock_sink_reset.reset_n
			b_SD_cmd             => b_SD_cmd,             --         conduit_end.export
			b_SD_dat             => b_SD_dat,             --                    .export
			b_SD_dat3            => b_SD_dat3,            --                    .export
			o_SD_clock           => o_SD_clock            --                    .export
		);

end architecture rtl; -- of Altera_UP_SD_Card_Avalon_Interface_0
