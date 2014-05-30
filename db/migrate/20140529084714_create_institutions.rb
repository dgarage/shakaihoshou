class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
    	t.text :"都、国、市町村"
		t.text :"管理番号"
		t.text :"シーン種別(1)"
		t.text :"シーン種別(2)"
		t.text :"保障種別(2)"
		t.text :"一般名称（今後増えてきたものにする）"
		t.text :"独自（都、国、市町村）の呼称"
		t.text :"保障額・保障内容"
		t.text :"対象の方"
		t.text :"年齢(以上)"
		t.text :"年齢(以下)"
		t.text :"年齢(偶数・奇数)"
		t.text :"女"
		t.text :"男"
		t.text :"Unnamed:14"
		t.text :"ひとり親"
		t.text :"妊婦(産前産後)"
		t.text :"Unnamed:17"
		t.text :"子供(1)乳児"
		t.text :"子供(2)就学前、保育園、幼稚園"
		t.text :"子供(3)小学生"
		t.text :"子供(4)中学生"
		t.text :"子供(5)高校生"
		t.text :"高齢者(1)前期高齢者対象"
		t.text :"高齢者(2)後期高齢者対象"
		t.text :"要介護者"
		t.text :"障がい者"
		t.text :"住宅・店舗"
		t.text :"URL(1)"
		t.text :"URL(2)"
		t.text :"URL(3)"
		t.text :"項目追加（1）"
		t.text :"項目追加（2）"
    end
  end
end
