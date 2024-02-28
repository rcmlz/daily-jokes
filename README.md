# Daily Jokes for your Command Line

How to add ```something with AI``` to the classic ```fortune | cowsay | lolcat``` fun?

```bash
openai-playground --format=json 'Tell a Computer Science joke' | jq '.choices.[0].message.content' | sed -e 's/\\n/\n/g' | cowsay | lolcat

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

The command line tools [mistralai-playground](https://raku.land/zef:antononcube/WWW::MistralAI) and [openai-playground](https://raku.land/zef:antononcube/WWW::OpenAI) allow easy access to the Large Language Models (LLM).

```bash
zef install WWW::OpenAI WWW::MistralAI
```

Llama ([llamafile](https://simonwillison.net/2023/Nov/29/llamafile/)) can also be used with WWW::OpenAI, in case you want to run the LLM locally.

For easy access expose your API keys via environment variables. When using Bash do e.g.

```bash
echo 'export MISTRAL_API_KEY=some-key' >> $HOME/.bashrc
echo 'export OPENAI_API_KEY=some-other-key' >> $HOME/.bashrc
```

Go to https://console.mistral.ai/api-keys/ or https://platform.openai.com/api-keys to setup your keys.

## Bash Setup

For command line use I will abbreviate ```daily joke``` to ```dj```. Creating an alias makes it easy to call the entire chain.

```bash
alias dj-by-mistral="mistralai-playground --format=json 'Tell a Computer Science joke!' | jq '.choices.[0].message.content' | sed -e 's/\\n/\n/g' | cowsay | lolcat"
```

or like this, if you are using OpenAI

```bash
alias dj-by-openai="openai-playground --format=json 'Tell a Computer Science joke!' | jq '.choices.[0].message.content' | sed -e 's/\\n/\n/g' | cowsay | lolcat"
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
openai-playground --format="json" `shuf -n 1 /path/to/prompts.txt` | jq '.choices.[0].message.content' | sed -e 's/\\n/\n/g' -e 's/"//g' | cowsay | lolcat

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
openai-playground --format="json" 'Entertain me!' | jq '.choices.[0].message.content' | sed -e 's/\\n/\n/g' -e 's/"//g' | cowsay -f $(ls /usr/local/Cellar/cowsay/*/share/cows | shuf -n1) | lolcat
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