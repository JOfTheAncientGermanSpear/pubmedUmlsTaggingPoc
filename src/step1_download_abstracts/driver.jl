#example below will download summaries & abstracts in pmids
#$ julia -p 6 -L downloadPmids.jl driver.jl

ids = readcsv("../../data/input/pmids.csv", ASCIIString)[:]

pmap(ids) do id
  try
    pmid = getPmid(id)
    savePmid!(pmid)
  catch
    warn("$id did not download and save")
  end
end
