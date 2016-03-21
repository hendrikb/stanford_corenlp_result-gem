# Stanford CoreNLP Result (Parser)
## Description
Stanford CoreNLP is a well established Natural Language Processing kit that annotates free-text with various annotators and returns a parseable output format, that has some major semantic information in it. You can use this gem to parse the resulting text files and have all those semantic information in a handy data structure for further ruby love.

## Usage

### First: Annotate text using Stanford CoreNLP

Make sure Stanford's CoreNLP package is up to date (tested with 3.6.0 in March
2016) and all the Java things are properly set up.

Get yourself some not too large text files (unless you've got A LOT OF TIME).
Drop it into my.txt

Start the CoreNLP annotator more or less like this:

```
# Directory of your unzipped stanford-corenlp package
$> corenlp=/home/hendrik/Downloads/stanford-corenlp-full-2015-12-09

# Load the jars into class path
$> cp=$corenlp/stanford-corenlp-3.6.0.jar:$corenlp/stanford-corenlp-models-3.6.0.jar:$corenlp/*

annotators=tokenize,ssplit,pos,lemma,ner,parse,dcoref,relation

# Run that thing (here: with 2G of RAM, increase if you can)
$> java -Xmx2g \
    -cp  $cp edu.stanford.nlp.pipeline.StanfordCoreNLP \
    -annotators $annotators \
    -outputFormat text \
    -file my.txt
```

This procedure may take a lot of time (up to hours, if you have hundreds of
sentences). However, if everything went fine, you should have my.txt.out
which is the super-annotated version of your original text. Use this file to
feed it into this gem and generate a data structure from it.


### Then: Let StanfordCoreNLPResult parse the results
```
$> ./pry.sh
pry(main)>  parser = StanfordCoreNLPResult::Base.new(File.read('my.txt.out'))

# Then, go explore parser...

pry(main)> parser.sentences.each do |sentence|
  puts sentence
end

pry(main)> parser.relations.each do |relation|
  puts relation
end

pry(main)> parser.ngrams.each do |compound|
  puts compound
end

pry(main)> ...

```

Of course, see the docs on how to deeper explore Tokens, Relationships, NGrams,
etc.

Use the data structure to have a lot of ruby fun.
