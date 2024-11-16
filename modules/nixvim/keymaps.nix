{ config, pkgs, ... }:
{
		programs.nixvim = {
		globals.mapleader = " ";
		keymaps = [
				{
						mode = "n";
						key = "<leader>e";
						action = ":Vex<CR>";			
						options.silent = true;
				}
				{
						key = "<Space>";
						action = "<Nop>";
				}
				#Move visual block with <S-[h|j|k|l]>
				{
						mode = "v";
						key = "<S-j>";
						action = ":m '>+1<CR>gv=gv";
						options.silent = true;
				}
				{
						mode = "v";
						key = "<S-k>";
						action = ":m '>-2<CR>gv=gv";
						options.silent = true;
				}
				{
						mode = "v";
						key = "<S-h>";
						action = "<gv";
						options.silent = true;
				}
				{
						mode = "v";
						key = "<S-l>";
						action = ">gv";
						options.silent = true;
				}
				
		];
	};
}
