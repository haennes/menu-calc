# menu-calc

A calculator for Rofi/dmenu(2)

[Screencast](https://gfycat.com/SociableDopeyHerald)

## Installation

### GNU make

```sh
sudo make install
```

### Nix Flake

This repository is a Nix flake. You can add this repo as an input to your Nix
flake.

```nix
inputs.menucalc.url = "github:sumnerevans/menu-calc";
```

If you want to follow your own nixpkgs version:

```nix
inputs.menucalc = {
  url = "github:sumnerevans/menu-calc";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

And then use it like:

```nix
outputs = { ..., menucalc }: {
  ...
  menucalc.packages.x86_64-linux.menucalc
  ...
};
```

If you want to use fend as an backend just use the package menucalc-fend

### Arch Linux AUR

[menu-calc](https://aur.archlinux.org/packages/menu-calc/)

## Dependencies

- [bc](https://www.archlinux.org/packages/extra/x86_64/bc/)
- [xclip](https://www.archlinux.org/packages/extra/x86_64/xclip/)
- [Rofi](https://aur.archlinux.org/packages/rofi-git/) or
  dmenu[(2)](https://aur.archlinux.org/packages/dmenu2/)

## Usage

`menu-calc` uses `bc` as the backend and will accept any operations `bc` is able
to do:

    = -h
    = 4+4
    = (4+2)/(4+3)
    = 4^2
    = sqrt(4)
    = c(2)

The answer can be copied to the clipboard and used for further calculations
inside (or outside) Rofi/dmenu.

If launched outside of Rofi/dmenu the expression may need quotation marks.

## Custom Usage

To launch directly into the calculator, use the following command (useful if
bound to "super + equal" in [sxhkd](https://github.com/baskerville/sxhkd),
[i3](https://i3wm.org/) or the like):

    = -- [rofi/dmenu parameters]

For example:

    = -- -location 2 -width 100

### Force usage of `dmenu`

By default, if `rofi` is installed, it will be used. You can force `menu-calc`
to use `dmenu` or any other `dmenu`-like application:

    = --dmenu=dmenu

### Change calculator backend

By default [bc](https://www.gnu.org/software/bc/manual/html_mono/bc.html)
is used, alternatively a custom command (e.g. [fend](https://github.com/printfn/fend))
can be used instead

    = --calculator=fend
