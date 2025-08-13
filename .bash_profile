. ~/.bashrc
if [ -f "/Tmp/lessarke/.cargo/env" ]; then
    . "/Tmp/lessarke/.cargo/env"
fi
. "$HOME/.cargo/env"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/Users/hazot/.juliaup/bin:*)
        ;;

    *)
        export PATH=/Users/hazot/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/hazot/.cache/lm-studio/bin"
# End of LM Studio CLI section

