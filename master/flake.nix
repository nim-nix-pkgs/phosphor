{
  description = ''eaiser use of OpenGL and GLSL shaders'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-Phosphor-master.flake = false;
  inputs.src-Phosphor-master.owner = "barcharcraz";
  inputs.src-Phosphor-master.ref   = "refs/heads/master";
  inputs.src-Phosphor-master.repo  = "Phosphor";
  inputs.src-Phosphor-master.type  = "github";
  
  inputs."opengl".owner = "nim-nix-pkgs";
  inputs."opengl".ref   = "master";
  inputs."opengl".repo  = "opengl";
  inputs."opengl".type  = "github";
  inputs."opengl".inputs.nixpkgs.follows = "nixpkgs";
  inputs."opengl".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-Phosphor-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-Phosphor-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}