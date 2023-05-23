<p align="center"><img src="https://raw.githubusercontent.com/nullxception/cherry-kde/main/cherry.png"/></p>
<h2><p align="center">Cherry KDE</p></h2>
<p align="center">Clean, Flat, Δ Theme for Plasma Desktop</p>
<p align="center"><img src="https://raw.githubusercontent.com/nullxception/cherry-kde/main/preview-full.png"/></p>
<p align="center"><img src="https://raw.githubusercontent.com/nullxception/cherry-kde/main/preview-variants.png"/></p>
</center>

Cherry is a theme inspired by Δ (delta) battlesuit from Honkai Impact 3.
This theme consist of several components including :

- aurorae themes
- konsole and kitty colorscheme
- kvantum theme
- plasma colorscheme
- plasma desktop theme
- splash screen
- wallpaper

## Installation

> Note: Due to the amount of variants on this theme, I decide to give up on
> publishing this theme to the store.kde.org

- Arch Linux (AUR)

  - [cherry-kde-git](https://aur.archlinux.org/packages/cherry-kde-git)
  - [kvantum-theme-cherry-git](https://aur.archlinux.org/packages/kvantum-theme-cherry-git)

- GitHub

  ```bash
  $ git clone https://github.com/nullxception/cherry-kde.git
  $ cd cherry-kde
  $ ./install.sh
  ```

This theme uses [**Kvantum engine**](https://github.com/tsujan/Kvantum) for it's Application style.

So in order to completely apply this theme, you have to set the theme on kvantum:

**From terminal**

```bash
kvantummanager --set <theme-name> # available: cherry, cherry-solid, cherry-midnight, and cherry-midnight-solid
```

**From Kvantum Manager GUI**

Open **Kvantum Manager**, then select the theme on **Change/Delete Theme** section.

## Recommendation

**Terminal Emulator**

Cherry theme (non-solid variant) has background opacity set to 95%, you can match your term config for nicer setup.

**Color scheme for Kitty Terminal**

You can copy the configs inside of [kitty](kitty) directory into your kitty theme dir, and then apply it as usual.

```bash
$ cp kitty/*.conf ~/.config/kitty/themes/
$ kitty +kitten themes Cherry
```

### Layouts

If you use in-built layout (`Global Theme > Use desktop layout from theme`), it's recommended to have several additional applet before for better setup :

- [Better Inline Clock](https://store.kde.org/p/1245902/)
- [Window Appmenu Applet](https://store.kde.org/p/1274975/)
- [Window Title Applet](https://store.kde.org/p/1274218/)

After installing all of them, you can just re-apply the Global Theme to reload layout.

Also, it's recommended that using Latte Dock for your task manager to get better setup!

## Related

There is also a cherry theme for other stuff, check it out 🚀

- **Firefox**

  - [Cherry theme](https://addons.mozilla.org/en-US/firefox/addon/cherry-kde-theme) by [Daste](https://addons.mozilla.org/en-US/firefox/user/16594667)
  - [Cherry 3.0 theme](https://addons.mozilla.org/en-US/firefox/addon/cherry3) by [Gotoro](https://addons.mozilla.org/en-US/firefox/user/17172197)

- [**Cherry VSCode**](https://github.com/nullxception/cherry-vscode)

## License

This theme is based on Layan-KDE theme by [Vinceliuice](https://github.com/vinceliuice).
And licensed under [GNU GPL v3](LICENSE).
