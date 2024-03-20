# Daily Jokes for your Command Line

How to add ```something with AI``` to the classic ```fortune | cowsay | lolcat``` fun?

```bash
openai-playground --max-tokens=1024 --format=json \
  'Tell a Computer Science joke!' \
  | jq '.choices.[0].message.content' \
  | sed -e 's/\\n/\n/g' -e 's/"//g' \
  | cowsay \
  | lolcat

 ______________________________________
/ Why do programmers prefer dark mode? \
|                                      |
\ Because the light attracts bugs!     /
 --------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

## System Setup

### Mac
```bash
brew install rakudo-star jq cowsay lolcat
```

### Linux
Use Nix

```bash
nix-shell -p rakudo zef jq cowsay lolcat
```

or your package manager, something like:

```bash
apt-get install rakudo-star jq cowsay lolcat
```

## LLM Setup

Currently you can choose from the following LLM back-ends:

- [WWW::OpenAI](https://raku.land/zef:antononcube/WWW::OpenAI)
- [WWW::PaLM](https://raku.land/zef:antononcube/WWW::PaLM)
- [WWW::Gemini](https://raku.land/zef:antononcube/WWW::Gemini)
- [WWW::LLaMA](https://raku.land/zef:antononcube/WWW::LLaMA)
- [WWW::MistralAI](https://raku.land/zef:antononcube/WWW::MistralAI)

Llama ([llamafile](https://simonwillison.net/2023/Nov/29/llamafile/)) runs also locally - in case you need some privacy!

You can file a request [here](https://github.com/antononcube/Raku-LLM-Functions) in case you need another LLM back-end.

The command line tools [mistralai-playground](https://raku.land/zef:antononcube/WWW::MistralAI), [openai-playground](https://raku.land/zef:antononcube/WWW::OpenAI) etc. allow easy access to the specific Large Language Models (LLM).

```bash
zef install WWW::OpenAI WWW::MistralAI WWW::PaLM WWW::LLaMA WWW::Gemini
```

For easy access expose your API keys via environment variables. When using Bash do e.g.

```bash
echo 'export MISTRAL_API_KEY=some-key' >> $HOME/.bashrc
echo 'export OPENAI_API_KEY=some-other-key' >> $HOME/.bashrc
etc.
```

Go to https://console.mistral.ai/api-keys/ or https://platform.openai.com/api-keys etc. to setup your keys.

## Bash Setup

For command line use I will abbreviate ```daily joke``` to ```dj```. Creating an alias makes it easy to call the entire chain.

```bash
alias dj-by-mistral="mistralai-playground --max-tokens=1024 --format=json 'Tell a Computer Science joke!' | jq '.choices.[0].message.content' | sed -e 's/\\n/\n/g' | cowsay | lolcat"
```

or like this, if you are using OpenAI

```bash
alias dj-by-openai="openai-playground --max-tokens=1024 --format=json 'Tell a Computer Science joke!' | jq '.choices.[0].message.content' | sed -e 's/\\n/\n/g' | cowsay | lolcat"
```

In case you want to read a joke every time you start a shell, store the alias definition and the command call.

```bash
echo 'dj-by-mistral' >> $HOME/.bashrc
```

or, if you are using e.g. oh-my-zsh put it here:

```bash
echo 'dj-by-openai' >> $HOME/.oh-my-zsh/custom/my-alias.zsh
```

## Running

If you created an alias, just run it, otherwise grep the entire command from your history using and run it again.

```bash
history | grep playground
```

If you like a different prompt, save some appropriate prompts in a text file

```bash
cat prompts.txt

'Tell a single joke not suitable for high school students!'
'Tell a Computer Science joke!'
'Ask me an exam question about sorting algorithms!'
'Explain an algorithm specific to hard problems!'
'Show a nice feature of the programming language Raku.'
'Entertain me!'
```

and select one randomly when calling the LLM. Of course, you can also do some serious learning every day ...

```bash
openai-playground --max-tokens=1024 --format="json" `shuf -n 1 /path/to/prompts.txt` \
| jq '.choices.[0].message.content' \
| sed -e 's/\\n/\n/g' -e 's/"//g' \
| cowsay \
| lolcat

 _________________________________________
/ "One nice feature of the programming    \
| language Raku is its built-in support   |
| for lazy evaluation. This means that    |
| values are only calculated when they    |
| are actually needed, which can improve  |
| performance and memory usage in certain |
| situations. Lazy evaluation can be      |
| implemented using the `lazy` keyword or |
| by using built-in functions like `map`, |
| `grep`, and `first`. This feature       |
| allows for more efficient and           |
| streamlined code, making Raku a         |
| powerful and versatile language for a   |
\ wide range of programming tasks."       /
 -----------------------------------------
        \  ^___^
         \ (ooo)\_______
           (___)\       )\/\
                ||----w |
                ||     ||
``` 

If you are tired of cows, use a random animal from e.g. ```/usr/local/Cellar/cowsay/*/share/cows``` or maybe ```/usr/share/cowsay/cows/```.

```bash
openai-playground --max-tokens=1024 --format="json" \
'Entertain me!' \
| jq '.choices.[0].message.content' \
| sed -e 's/\\n/\n/g' -e 's/"//g' \
| cowsay -f $(ls /usr/local/Cellar/cowsay/*/share/cows | shuf -n1) \
| lolcat
```

Have fun!

```bash
 ____________________________________
/ "Why was the computer cold?        \
|                                    |
\ Because it left its Windows open!" /
 ------------------------------------
   \
    \
               |    .
           .   |L  /|
       _ . |\ _| \--+._/| .
      / ||\| Y J  )   / |/| ./
     J  |)'( |        ` F`.'/
   -<|  F         __     .-<
     | /       .-'. `.  /-. L___
     J \      <    \  | | O\|.-'
   _J \  .-    \/ O | | \  |F
  '-F  -<_.     \   .-'  `-' L__
 __J  _   _.     >-'  )._.   |-'
 `-|.'   /_.           \_|   F
   /.-   .                _.<
  /'    /.'             .'  `\
   /L  /'   |/      _.-'-\
  /'J       ___.---'\|
    |\  .--' V  | `. `
    |/`. `-.     `._)
       / .-.\
 VK    \ (  `\
        `.\
```
