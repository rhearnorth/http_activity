require 'spec_helper'

describe Excon do
  let(:connection) { Excon.new('http://localhost:3000') }

  describe '#GET' do
    subject { connection.get(path: '/users')}

    it 'gets' do
      subject
    end
  end

  describe '#POST' do
    subject do
      connection.post(
        path: "/users",
        body: { user: { name: "new user", email: "test@tg.com" }}.to_json,
        headers: { 'Content-Type' => 'application/json' })
    end

    it 'posts' do
      subject
    end
  end

  describe '#PUT' do
    subject do
      connection.put(
        path: "/users/3",
        body: { user: { name: "edited" }}.to_json,
        headers: { 'Content-Type' => 'application/json' })
    end

    it 'puts' do
      subject
    end
  end

  describe '#DELETE' do
    subject do
      connection.delete(
        path: "/users/3",
        headers: { 'Content-Type' => 'application/json' })
    end

    it 'deletes' do
      subject
    end
  end
end
