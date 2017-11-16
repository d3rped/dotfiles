{ config, pkgs, ... }:

let 

  emacs = pkgs.emacsWithPackages (epkgs: with epkgs; [
    pkgs.aspell pkgs.aspellDicts.en pkgs.aspellDicts.de
    use-package diminish bind-key
    rainbow-delimiters smartparens
    evil-surround evil-indent-textobject evil-cleverparens avy undo-tree
    cdlatex #  for math expressions
    helm
    /* Git */ magit git-timemachine
    /* LaTeX */ auctex helm-bibtex cdlatex
    markdown-mode
    flycheck
    pkgs.ledger
    yaml-mode
    company
    /* Haskell */ haskell-mode flycheck-haskell
    /* Org */ org org-ref pdf-tools
    rust-mode cargo flycheck-rust
    /* mail */ notmuch messages-are-flowing
    /* Nix */ pkgs.nix nix-buffer nix-mode
    spaceline # modeline beautification
    winum eyebrowse # window management
    auto-compile
    /* Maxima */ pkgs.maxima
    visual-fill-column
    melpaStablePackages.idris-mode helm-idris
  ]);

in

  { environment.systemPackages = [ emacs ]; }
