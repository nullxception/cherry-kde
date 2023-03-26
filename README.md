<p align="center"><img src="https://raw.githubusercontent.com/nullxception/cherry-kde-theme/main/cherry.png"/></p>
<h2><p align="center">Cherry KDE Plasma</p></h2>
<p align="center">Clean, Flat, Δ Theme for KDE Plasma Desktop</p>
<p align="center"><img src="https://raw.githubusercontent.com/nullxception/cherry-kde-theme/main/preview-full.png"/></p>
<p align="center"><img src="https://raw.githubusercontent.com/nullxception/cherry-kde-theme/main/preview-variants.png"/></p>
</center>

## Background

Cherry is a theme inspired by Δ (delta) battlesuit from Honkai Impact 3.

This theme consist of several components including :

- aurorae themes (regular, solid, square, square-solid)
- konsole and kitty colorscheme
- kvantum theme (regular, solid)
- plasma colorscheme
- plasma desktop theme
- splash screen

## Installation

- Archlinux - [AUR](https://aur.archlinux.org/packages/cherry-kde-theme) by [RMTT](https://github.com/RMTT)

- Manual

  ```bash
  $ git clone https://github.com/nullxception/cherry-kde-theme.git
  $ cd cherry-kde-theme
  $ ./install.sh
  ```

This theme uses [**Kvantum engine**](https://github.com/tsujan/Kvantum) for it's Application style.

So in order to completely apply this theme, you have to open **Kvantum Manager** (command : `kvantummanager`), and then select **cherry** on **Change/Delete Theme** section.

### Tips

If you're using standard variant (non-solid), set your terminal emulator's background opacity to 0.85 to match titlebar's opacity.

### Layouts

If you use in-built layout (`Global Theme > Use desktop layout from theme`), it's recommended to have several additional applet before for better setup :

- [Better Inline Clock](https://store.kde.org/p/1245902/)
- [Window Appmenu Applet](https://store.kde.org/p/1274975/)
- [Window Title Applet](https://store.kde.org/p/1274218/)

After installing all of them, you can just re-apply the Global Theme to reload layout.

Also, it's recommended that using Latte Dock for your task manager to get better setup!

### Color theme for Kitty Terminal

You can copy the [cherry.conf](kitty/cherry.conf) into kitty theme dir, and then apply it as usual.

```bash
$ cp kitty/cherry.conf ~/.config/kitty/themes/
$ kitty +kitten themes Cherry
```

## Related

There is also a cherry theme for other stuff, check it out 🚀

* Firefox: https://addons.mozilla.org/en-US/firefox/addon/cherry3
* VSCode: https://github.com/nullxception/cherry-vscode

## License

This theme is based on Layan-KDE theme by [Vinceliuice](https://github.com/vinceliuice).
And licensed under [GNU GPL v3](LICENSE).
