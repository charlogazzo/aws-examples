require 'opensearch-aws-sigv4'
require 'aws-sigv4'
require 'pry'

signer = Aws::Sigv4::Signer.new(service: 'es',
                                region: 'eu-central-1', # signing service region
                                access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])

client = OpenSearch::Aws::Sigv4Client.new({
    host: 'https://vpc-maindomain-yhy5xmluanljxujxxuo6kf3why.aos.eu-central-1.on.aws',
    log: true
}, signer)

# create an index and document
index = 'prime'
results = client.indices.create(index: index)
binding.pry

# create document in index
results = client.index(index: index, id: '1', body: { name: 'Amazon Echo', 
                                            msrp: '5999', 
                                            year: 2011 })

binding.pry

# search for the document
results = client.search(body: { query: { match: { name: 'Echo' } } })
binding.pry

# delete the document
results = client.delete(index: index, id: '1')
binding.pry

# delete the index
results = client.indices.delete(index: index)
binding.pry

