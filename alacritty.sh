echo "installing rust and cargo"
curl https://sh.rustup.rs -sSf | sh
echo "installing alacitty"
cargo install alacritty
source $HOME/.cargo/env
