burninate
=========

Small shim to reduce headaches when writing disk images.

This is written *for my own use*, so it may not fit your use.

Limitations
-----------

By design, this will not write to a normal file, but only to block devices.

By design, it uses `dd` under `pv`, as I haven't found a way to make `pv` use
the equivalent of `oflag=direct,sync`.


I want to try it, quickly!
--------------------------

Using your current `<nixpkgs>` semantics, this will start a shell with
`burninate` available from the latest commit of the `development` branch:

```
nix-shell -p 'import (builtins.fetchTarball "https://github.com/samueldr/burninate/archive/refs/heads/development.tar.gz") { inherit pkgs; }'
```

* * *

```
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT DOCUMENTATION OF ANY KIND, EXPRESS OR IMPLIED
```
