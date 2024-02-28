#!/usr/bin/env raku

my $prompt = 'Tell a single joke suitable for high school students!';

use WWW::OpenAI;
use WWW::MistralAI;

if not (%*ENV<MISTRAL_API_KEY>:exists or %*ENV<OPENAI_API_KEY>:exists) {
	my $api-key-file = $*HOME.IO.add(".env");
	fail "Please store API keys in $api-key-file" if not $api-key-file.IO.f;
	for $api-key-file.slurp.lines {
		my ($name, $key) = $_.split("=");
		%*ENV{$name} = $key;
	}
}

my $response;
if %*ENV<MISTRAL_API_KEY>:exists {
	$response = mistralai-playground($prompt, type => 'text', format=> "hash", max-tokens => 250);
}elsif %*ENV<OPENAI_API_KEY>:exists {
	$response = openai-playground($prompt, type => 'text', format=> "hash", max-tokens => 250);
}

say $response.first<message><content>;