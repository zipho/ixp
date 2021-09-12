# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  birthday        :datetime
#  email           :string
#  first_name      :string
#  gender          :bigint
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord

end
