# dotfiles

various dotfiles and configs.

this repo is managed by [chezmoi](https://www.chezmoi.io/). the root of the repository is at `$HOME`.

## setup on a new machine

to decrypt secret files you need the passphrase for `key.txt.age`. it's stored in bitwarden as **Chezmoi encryption key** (password field).

1. install `chezmoi` and `age`
2. get the passphrase, e.g. `rbw get "Chezmoi encryption key"`
3. run `chezmoi init --apply mvaaltola/dotfiles` and enter the passphrase when asked

you're only asked once. after that chezmoi decrypts files without prompting.

## encryption

some files (`encrypted_*.age` in the source) are encrypted with [age](https://age-encryption.org/). there are two layers:

- **files** are encrypted to an age key pair. the public key is the `recipient` in `.chezmoi.toml.tmpl`, so encrypting needs no secret. decrypting reads the private key from `~/.config/chezmoi/key.txt`.
- **the private key** is committed as `key.txt.age`, encrypted with the passphrase above. `.chezmoiignore` keeps it from being copied into `$HOME`.

on first apply, `run_onchange_before_decrypt-private-key.sh.tmpl` runs before any files are written. if `~/.config/chezmoi/key.txt` doesn't exist, it decrypts `key.txt.age` there (prompting for the passphrase) and sets it to `600`. from then on the key sits on disk and nothing prompts.

to encrypt a new file: `chezmoi add --encrypt <file>`. editing an encrypted file with `chezmoi edit` or `chezmoi re-add` keeps it encrypted.

if the passphrase is lost but a machine still has `~/.config/chezmoi/key.txt`, re-encrypt the key with a new passphrase and update bitwarden:

```sh
chezmoi age encrypt --passphrase --output ~/.local/share/chezmoi/key.txt.age ~/.config/chezmoi/key.txt
```

if both are lost, the encrypted files can't be recovered.
