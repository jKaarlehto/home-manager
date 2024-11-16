{config, pkgs, ...} :

{

		programs.nixvim.plugins = {



				lsp = {
					
						enable = true;
						servers = {
										pylsp.enable = true;
										nil_ls.enable = true;
										java_language_server.enable = true;
										cssls.enable = true;
										html.enable = true;
										htmx.enable = true;
										jsonls.enable = true;

								};
				};

				cmp = {

						enable = true;
						autoEnableSources = true;
						settings = {
						    sources = [
								{name = "nvim_lsp";}
								{name = "path";}
								{name = "buffer";}
							    ];
						    mapping = {
						    	  "<C-d>" = "cmp.mapping.scroll_docs(-4)";
							  "<C-f>" = "cmp.mapping.scroll_docs(4)";
							  "<C-Space>" = "cmp.mapping.complete()";
							  "<C-e>" = "cmp.mapping.close()";
							  "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
							  "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
							  "<CR>" = "cmp.mapping.confirm({ select = true })";
							    };

							};
						};
				};

}
