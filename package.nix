{ pkgs,
  minecraft-versions ? []
}:

pkgs.writeScriptBin "minecraft-dmenu"
      ''
        #!${pkgs.nushell}/bin/nu

        let minecraftVersionsNames = [ ${builtins.toString (map (x: "${x.name}") minecraft-versions)} ]
        let versionName = ($minecraftVersionsNames | to text | bemenu | str trim)
        if ($versionName == "") { print "no input" ; exit }
        let minecraftVersions = [ ${(builtins.toString minecraft-versions)} ]
        mut version = ""
        mut x = 1
        while $x <= ($minecraftVersionsNames | length) { 
          if $versionName == ($minecraftVersionsNames | get $x) { 
            $version = ($minecraftVersions | get $x)
            break
          } else {
            $x = $x + 1
          }
        }
        ^($version | append /bin/minecraft | str join "")
      ''
