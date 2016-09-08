using JSON
using Lazy
using LightXML
using Requests

const base_url = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils"
const summary_url = "$(base_url)/esummary.fcgi"
const abstract_url = "$(base_url)/efetch.fcgi"


#JSON.parse can not be specified alone in macro
downloadSummary(id) = @> summary_url begin
  get(query=Dict("db"=>"pubmed", "retmode"=>"json", "rettype"=>"abstract", "id"=>id))
  readall
  data -> JSON.parse(data)
  getindex("result")
  getindex("$id")
end


downloadAbstract(id) = @> abstract_url begin
  get(query=Dict("db" => "pubmed", "rettype" => "abstract", "id"=> id))
  readall
  parse_string
end


function getPmid(id)
  pmid = Dict()
  pmid[:summary] = downloadSummary(id)

  if "Has Abstract" in pmid[:summary]["attributes"]
    pmid[:abstract_xml] = downloadAbstract(id)
  end

  pmid
end


function savePmid!(pmid::Dict, dest_dir="../../data/step1/")
  id = pmid[:summary]["uid"]

  summary_f = joinpath(dest_dir, "$(id)_summary.json")
  open(summary_f, "w") do f
    @>> pmid[:summary] json write(f)
  end

  if :abstract_xml in keys(pmid)
    abstract_f = joinpath(dest_dir, "$(id)_abstract.xml")
    save_file(pmid[:abstract_xml], abstract_f)
  else
    warn("$id does not have abstract")
  end
end
