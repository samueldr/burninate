burninate
=========

Small shim to reduce headaches when writing disk images.

This is written *for my own use*, so it may not fit your use.

Limitations
-----------

By design, this will not write to a normal file, but only to block devices.

By design, it uses `dd` under `pv`, as I haven't found a way to make `pv` use
the equivalent of `oflag=direct,sync`.

* * *

```
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT DOCUMENTATION OF ANY KIND, EXPRESS OR IMPLIED
```
