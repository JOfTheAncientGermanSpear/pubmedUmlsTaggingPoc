##Tagging Pubmed Titles/Articles with Metamap, A Proof of Concept

The Objective: Perform a proof of concept to tag Pubmed titles and abstracts with Metamap's UMLS concept thesaurus

* Input
	* [120 Pubmed ids](data/input/pmids.csv)
* Step 1
	* __Goal:__ Download titles, and abstracts when available, from Pubmed
	* __Language:__ Julia, can perform multi-processing and http requests with little boilerplate
	* `$ julia -p 6 -L downloadPmids.jl driver.jl`
	* Code can be found in [src/step1_download/](src/step1_download/)
	* Special thanks to [Fred Trotter's "Hacking on the Pubmed API"](http://www.fredtrotter.com/2014/11/14/hacking-on-the-pubmed-api/)
	* Output location: [data/step1](data/step1)
* Step 2
	* __Goal:__ Use Metamap to tag titles and abstracts with medical concepts
	* __Language:__ [Scala on Jupyter](https://github.com/alexarchambault/jupyter-scala), JVM language that interops with Metamap's Java API
	* Scala notebook can be found in [src/step2\_tag\_concepts](src/step2_tag_concepts)
	* Requires a local instance of [Metamap server](https://metamap.nlm.nih.gov/MetaMap.shtml) (default and Word Sense Disambiguation) and [Metamap Java API](https://metamap.nlm.nih.gov/JavaApi.shtml)
	* Output location: [data/step2](data/step2)