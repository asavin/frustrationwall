user = User.find_by_email('karismafilms@gmail.com')
for i in 0..100
    user.frustrations.create(:content => 'something sad')
end
user.level = 100
user.save
