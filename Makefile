DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .travis.yml .zsh
DOTFILES_TARGET   := $(wildcard .??*)
CLEAN_TARGET      := $(wildcard .??*) .vim .zfunctions
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
UNAME 	          := $(shell uname)
CURRENTDIR        := $(shell pwd)

install: vim-init zsh-init
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	vim +PlugInstall +qall
	zsh
vim-init:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
zsh-init: peco-init pure-init
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
	ln -snfv $(CURRENTDIR)/.zsh/snippets $(HOME)/.zsh/snippets
peco-init:
ifeq ($(UNAME),Darwin)
	curl -L -O https://github.com/peco/peco/releases/download/v0.5.1/peco_darwin_amd64.zip
	unzip peco_darwin_amd64.zip && mv peco_darwin_amd64/peco /usr/local/bin && rm -rf peco_darwin_amd64 peco_darwin_amd64.zip
endif
ifeq ($(UNAME),Linux)
	curl -L -O https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_amd64.tar.gz
	tar -zxvf peco_linux_amd64.tar.gz && mv peco_linux_amd64/peco /usr/local/bin && rm -rf peco_linux_amd64 peco_linux_amd64.tar.gz
endif
pure-init:
	mkdir ~/.zfunctions
	curl -L https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh > ~/.zfunctions/prompt_pure_setup
	curl -L https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh > ~/.zfunctions/async
clean:
	@$(foreach val, $(CLEAN_TARGET), rm -rf $(HOME)/$(val);)
update:
	vim +PlugInstall +qall
	zsh
