class App
  get '/health' do
    halt 200
  end

  get '/test' do
    respond_to do |r|
      r.html { 'test' }
      r.json { {success: true} }
    end
  end
end
  