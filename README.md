# itamae_gosint

## Description

Automated installation of [GOSINT](https://github.com/ciscocsirt/GOSINT) by using itamae.

## How to use

```bash
$ itamae ssh cookbooks/gosint/default.rb
```

After running this itamae script, please execute following commands manually,

```bash
$ sudo systemctl restart nginx
$ /home/gosint/projects/src/GOSINT/gosint
```

Then GOSINT works on `http://localhost`.

## Notes

- This itamae script supports only Ubuntu 16.04 LTS.
