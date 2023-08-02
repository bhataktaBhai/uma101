# \left\{...\right\} to \{...\}
for file in *.tex; do
    gawk '{r = gensub(/\\left\\\{/, "\\\\{", "g"); print r}' $file > $file.copy
    gawk '{r = gensub(/\\right\\\}/, "\\\\}", "g"); print r}' $file.copy > $file
    rm $file.copy
done

# \{...\} to \set{...}
for file in *.tex; do
    gawk '{r = gensub(/\\\{(([^\}]|([^\\]\}))*)\\\}/, "\\\\set{\\1}", "g"); print r}' $file > $file.copy
    cat $file.copy > $file
    rm $file.copy
done

# \left\lvert ... \right\rvert to \lvert ... \rvert
for file in *.tex; do
    gawk '{r = gensub(/\\right\\rvert/, "\\\\rvert", "g"); print r}' $file > $file.copy
    gawk '{r = gensub(/\\left\\lvert/, "\\\\lvert", "g"); print r}' $file.copy > $file
    rm $file.copy
done

# \lvert ... \rvert to \abs*{ ... }
for file in *.tex; do
    python3 -c "import sys; print(sys.stdin.read().replace(r'\lvert', r'\abs*{').replace(r'\rvert', r'}'))" < $file > $file.copy
    cat $file.copy > $file
    rm $file.copy
done

# \left( ... \right) to \paren*{ ... }
for file in *.tex; do
    python3 -c "import sys; print(sys.stdin.read().replace(r'\left(', r'\paren*{').replace(r'\right)', r'}'))" < $file > $file.copy
    cat $file.copy > $file
    rm $file.copy
done

# \mathbb{R} to \R, \mathbb{N} to \N, \mathbb{Z} to \Z, \mathbb{Q} to \Q, \mathbb{C} to \C, \mathbb{P} to \P
for file in *.tex; do
    gawk '{r = gensub(/\\mathbb\{([PNZQRC])\}/, "\\\\\\1", "g"); print r}' $file > $file.copy
    cat $file.copy > $file
    rm $file.copy
done

# change starred paren, abs, set, norm, floor and ceil to non-starred
for file in *.tex; do
    gawk '{r = gensub(/\\(paren|abs|set|norm|floor|ceil)\*/, "\\\\\\1", "g"); print r}' $file > $file.copy
    cat $file.copy > $file
    rm $file.copy
done
