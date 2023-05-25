aurorae=(cherry-midnight
    cherry-midnight-solid
    cherry-midnight-square
    cherry-midnight-square-solid
    cherry-solid
    cherry-square
    cherry-square-solid)

src=$(pwd)

link_buttons() {
    for f in alldesktops close keepabove keepbelow maximize minimize restore; do
        ln -sr "$src/aurorae/cherry/${f}.svg" "$src/aurorae/$1/"
    done
}

for i in "${aurorae[@]}"; do
    link_buttons "$i"
done

lnfpath="$src/plasma/look-and-feel/com.github.nullxception"
mkdir -p "${lnfpath}.cherrymidnight/contents/layouts"
ln -sr "${lnfpath}.cherry/contents/layouts"/* "${lnfpath}.cherrymidnight/contents/layouts/"

ln -sr "$src/color-schemes/Cherry.colors" "$src/plasma/desktoptheme/cherry/colors"
ln -sr "$src/color-schemes/CherryMidnight.colors" "$src/plasma/desktoptheme/cherry-midnight/colors"
