require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe '#index' do
    it 'render the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
  describe '#show' do
    it 'render the show template' do
      post = create(:post)
      get :show, params: {id: post.id}
      expect(response).to render_template(:show)
    end
    it 'check if the post being rendered is the same as the one i created' do
      post = create(:post)
      get :show, params: {id: post.id}
      expect(assigns(:post)).to eq(post)
    end
  end
  describe '#destroy' do
    it 'render the show page where destroy button in presented' do
      post = create(:post)
      get :show, params: {id: post.id}
      expect(response).to render_template(:show)
    end
    it 'check if post was deleted from database' do
      post = create(:post)
      count_before = Post.count
      delete :destroy, params: {id: post.id}
      count_after = Post.count
      expect(count_before).to eq(count_after + 1)
    end
  end
  describe '#new' do
    it 'render the new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'initiate a new post object' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end
  describe '#create' do
    context 'with valid params' do
      def valid_params
        post :create, params: {post: attributes_for(:post)}
      end
      it 'saves a post to the database' do
        count_before = Post.count
        valid_params
        count_after = Post.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'redirect to the post show page' do
        valid_params
        expect(response).to redirect_to(post_path(Post.last))
      end
      def invalid_params
        post :create, params: { post: attributes_for(:post, title: nil)}
      end
      it 'doesn\'t save a record to the database' do
        count_before = Post.count
        invalid_params
        count_after = Post.count
        expect(count_after).to eq(count_before)
      end
      it 'renders the new template' do
        invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
  describe '#edit' do
    it 'render the edit template' do
      post = create(:post)
      get :edit, params:{id: post.id}
      expect(response).to render_template(:edit)
    end
    it 'expect the id to be editted to be equal the one created' do
      post = create(:post)
      get :edit, params: {id: post.id}
      expect(assigns(:post)).to eq(post)
    end
  end
  describe '#update' do
    context 'with valid params' do

      it 'update the record to the database' do
        post = create(:post)
        patch :update, params: {id: post.id, post: {title: "testing the new title", body: "testing with body now"}}

        expect(post.reload.title).to eq("testing the new title")
      end
      it 'redirect to the show page' do
        post = create(:post)
        patch :update, params: {id: post.id, post: {title: "testing the new title"}}
        expect(response).to redirect_to(post_path)
      end
    end
    context 'with invalid_params' do
      it 'does not update the record to the database' do
        post = create(:post)
        count_before = Post.count
        patch :update, params: {id: post.id, post: {title: nil }}
        count_after = Post.count
        expect(count_before).to eq(count_after)
      end
      it 'renders the edit template' do
        post = create(:post)
        patch :update, params: {id: post.id, post: {title: nil }}
        expect(response).to render_template(:edit)
      end
    end
  end
end
