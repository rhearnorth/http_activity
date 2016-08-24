require 'spec_helper'

describe Net::HTTP do
  describe '#GET' do
    subject do
      Net::HTTP.new("localhost", "3000").get("/users")
    end

    it 'gets' do
      subject
    end
  end

  describe '#POST' do
    subject do
      Net::HTTP.new("localhost", "3000").post("/users", { user: { name: "new user", email: "test@tg.com" }}.to_json, { 'Content-Type' => 'application/json' } )
    end

    it 'posts' do
      subject
    end

  end

  describe '#PUT' do
    subject do
      Net::HTTP.new("localhost", "3000").put("/users/2", { user: { name: "edited" }}.to_json, { 'Content-Type' => 'application/json' } )
    end

    it 'puts' do
      subject
    end
  end

  describe '#DELETE' do
    subject do
      Net::HTTP.new("localhost", "3000").delete("/users/2")
    end

    it 'deletes' do
      subject
    end
  end
end
