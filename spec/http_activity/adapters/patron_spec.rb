require 'spec_helper'

describe Patron do
  let(:connection) do
    Patron::Session.new(base_url: 'http://localhost:3000',
                        headers: { 'Content-Type' => 'application/json' })
  end

  describe '#GET' do
    subject { connection.get('/users') }

    it 'gets' do
      subject
    end
  end

  describe '#POST' do
    subject do
      connection.post('/users', { user: { name: "new user", email: "test@tg.com" }}.to_json)
    end

    it 'posts' do
      subject
    end
  end

  describe '#PUT' do
    subject do
      connection.put('/users/4', { user: { name: "Edit", email: "test@tg.com" }}.to_json)
    end

    it 'puts' do
      subject
    end
  end

  describe '#DELETE' do
    subject do
      connection.delete('/users/5')
    end

    it 'deletes' do
      subject
    end
  end
end
