require 'rails_helper'

RSpec.describe Post, type: :model do

    describe 'validations' do
      it 'requires title' do
        p = Post.new({body: "hahahahaha"})
        p.valid?
        expect(p.errors).to have_key(:title)
      end
      it 'require title to be at least 7 characters' do
        p = Post.new({title: "hello", body: "hahahahaha"})
        p.valid?
        expect(p.errors).to have_key(:title)
      end
      it 'require body' do
        p = Post.new({title: "Hello World"})
        p.valid?
        expect(p.errors).to have_key(:body)
      end
      it 'requires body snippet' do
        p = Post.new({title: "Hello World", body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."})
        result = p.body_snippet

        expect(result.length).to be <= 103

      end
    end
end
