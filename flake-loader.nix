{
  description = "MyNixOS flake loader for juhanakaarlehto";
  inputs = {
    juhanakaarlehto-config.url = "git+https://github.com/jKaarlehto/home-manager";
  };
  outputs = inputs@{ self, juhanakaarlehto-config, ... }:
    let
      filterAttrs = pred: set: builtins.listToAttrs (builtins.concatMap
        (name: let v = set.${name}; in if pred name v then [ ((name: value: { inherit name value; }) name v) ] else [ ])
        (builtins.attrNames set));
      forwardFlakeOutputs = input: filterAttrs (n: v: !(builtins.elem n [ "inputs" "outputs" "narHash" "outPath" "sourceInfo" ])) input;
    in
    forwardFlakeOutputs juhanakaarlehto-config;
}
