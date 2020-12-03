#!/bin/bash
temp=$(mktemp -d /tmp/nullxception.scourify-XXX)
src=$(realpath "$(dirname "$0")/..")

# recursively optimize all the svgs
find $src -name "*.svg" | while read srcf; do
    tsrcf=$temp/${srcf##*/}
    scour -i $srcf -o $tsrcf \
        --disable-group-collapsing \
        --strip-xml-prolog \
        --enable-comment-stripping
    mv $tsrcf $srcf
done

# cleaning up
rm -rf $temp
