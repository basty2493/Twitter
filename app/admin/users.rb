ActiveAdmin.register User do

    index do
        column :email
        column :username
        column :avatar
        column :admin
        column :created_at
        column :friend_count
        column :tweets_count
        column :likes_give_it
        column :retweet_give_it
        actions
    end
end