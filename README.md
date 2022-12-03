# Dotfiles

### Setting up on a new machine
```
cd ~
git init
git remote add origin git@github.com:nzsilverman/dotfiles.git
git fetch
git checkout -f main # Note, this will overwrite any conflicting files
```

### Using this repository
Dotfiles are stored in the home (`~`) directory. 
By default, all files are ignored in this directory.
To track a configuration file, use `git add -f <filename>`.

