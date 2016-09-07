ids = readcsv("../../data/input/pmids.csv", ASCIIString)[:]

pmap(ids) do id
  try
    pmid = getPmid(id)
    savePmid!(pmid)
  catch
    println("$id did not retrieve")
  end
end
