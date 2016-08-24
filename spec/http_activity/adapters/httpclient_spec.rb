require 'spec_helper'

describe HTTPClient do
  let(:client) { HTTPClient.new(default_header: { 'Content-Type' => 'application/json' })}

  describe '#GET' do
    subject { client.get('http://localhost:3000/users') }

    it 'gets' do
      subject
    end
  end

  describe '#POST' do
    subject do
      client.post('http://localhost:3000/users', { user: { name: "new user", email: "test@tg.com" }}.to_json)
    end

    it 'posts' do
      subject
    end
  end

  describe '#PUT' do
    subject do
      client.put('http://localhost:3000/users/6', { user: { name: "Edit", email: "test@tg.com" }}.to_json)
    end

    it 'puts' do
      subject
    end
  end

  describe '#DELETE' do
    subject do
      client.delete('http://localhost:3000/users/6')
    end

    it 'deletes' do
      subject
    end
  end
end
