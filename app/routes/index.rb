class App
  get '/health' do
    halt 200
  end

  get '/test' do
    'test'
  end

  get '/test.json' do
    json json: {success: true}
  end
end
