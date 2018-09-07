
# coding: utf-8

# In[142]:


# 머신러닝 텐서플로 라이브러리
import tensorflow as tf
# 수학 연산 라이브러리
import numpy as np
# 데이터프레임 라이브러리
import pandas as pd
# 그래프 라이브러리
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')


# In[148]:


# 행렬로
data = np.loadtxt("./data/ratings4.dat", delimiter="::", dtype=np.int64)
data[:,:]


# In[149]:


path = "./data/webtoon2.txt"
webtoon_data = pd.read_csv(path,header=None)
webtoon_data.head()


# In[150]:


ratings_df = pd.read_csv('./data/ratings4.dat', sep='::', header=None)
ratings_df.head()


# In[151]:


webtoon_data.columns = ['WebtoonID', 'Title', 'Feelings']
ratings_df.columns = ['UserID', 'WebtoonID', 'Rating']


# In[152]:


webtoon_data.head()


# In[153]:


#indexing error 방지
webtoon_data['List Index'] = webtoon_data.index
webtoon_data.head()


# In[154]:


# 두 데이터 합치기
merged_df = webtoon_data.merge(ratings_df, on='WebtoonID')
merged_df = merged_df.drop('Title', axis=1).drop('Feelings', axis=1)
merged_df.head()


# In[155]:


#userID로 Group
userGroup = merged_df.groupby('UserID')
userGroup.first().head()


# In[156]:


#트레이닝에 사용한 사용자 양 설정
amountOfUsedUsers = 1000


# In[157]:


#트레이닝 리스트
trX = []
#For each user in the group
for userID, curUser in userGroup:
    #모든 웹툰 평점 저장
    temp = [0]*len(webtoon_data)
    for num, webtoon in curUser.iterrows():
        temp[webtoon['List Index']] = webtoon['Rating']/5.0
    trX.append(temp)
    print(temp)
    if amountOfUsedUsers == 0:
        break
    amountOfUsedUsers -= 1


# In[221]:


hiddenUnits = 50
visibleUnits = len(webtoon_data)
vb = tf.placeholder("float", [visibleUnits]) 
hb = tf.placeholder("float", [hiddenUnits]) 
W = tf.placeholder("float", [visibleUnits, hiddenUnits])


# In[222]:


# 렐루함수 사용
v0 = tf.placeholder("float", [None, visibleUnits])
_h0= tf.nn.sigmoid(tf.matmul(v0, W) + hb)
h0 = tf.nn.relu(tf.sign(_h0 - tf.random_uniform(tf.shape(_h0))))
_v1 = tf.nn.sigmoid(tf.matmul(h0, tf.transpose(W)) + vb) 
v1 = tf.nn.relu(tf.sign(_v1 - tf.random_uniform(tf.shape(_v1))))
h1 = tf.nn.sigmoid(tf.matmul(v1, W) + hb)


# In[223]:


alpha = 1.0
w_pos_grad = tf.matmul(tf.transpose(v0), h0)
w_neg_grad = tf.matmul(tf.transpose(v1), h1)
CD = (w_pos_grad - w_neg_grad) / tf.to_float(tf.shape(v0)[0])
update_w = W + alpha * CD
update_vb = vb + alpha * tf.reduce_mean(v0 - v1, 0)
update_hb = hb + alpha * tf.reduce_mean(h0 - h1, 0)


# In[224]:


err = v0 - v1
err_sum = tf.reduce_mean(err * err)


# In[225]:


#초기화
cur_w = np.zeros([visibleUnits, hiddenUnits], np.float32)
cur_vb = np.zeros([visibleUnits], np.float32)

cur_hb = np.zeros([hiddenUnits], np.float32)

prv_w = np.zeros([visibleUnits, hiddenUnits], np.float32)

prv_vb = np.zeros([visibleUnits], np.float32)

prv_hb = np.zeros([hiddenUnits], np.float32)
sess = tf.Session()
sess.run(tf.global_variables_initializer())


# In[226]:


epochs = 10
batchsize = 5
errors = []
for i in range(epochs):
    for start, end in zip( range(0, len(trX), batchsize), range(batchsize, len(trX), batchsize)):
        batch = trX[start:end]
        cur_w = sess.run(update_w, feed_dict={v0: batch, W: prv_w, vb: prv_vb, hb: prv_hb})
        cur_vb = sess.run(update_vb, feed_dict={v0: batch, W: prv_w, vb: prv_vb, hb: prv_hb})
        cur_hb = sess.run(update_hb, feed_dict={v0: batch, W: prv_w, vb: prv_vb, hb: prv_hb})
        prv_w = cur_w
        prv_vb = cur_vb
        prv_hb = cur_hb
    errors.append(sess.run(err_sum, feed_dict={v0: trX, W: cur_w, vb: cur_vb, hb: cur_hb}))
    print (errors[-1])
plt.plot(errors)
plt.ylabel('Error')
plt.xlabel('Epoch')
plt.show()


# In[275]:


#<Test>
inputUser = [trX[17]]


# In[276]:


hh0 = tf.nn.sigmoid(tf.matmul(v0, W) + hb)
vv1 = tf.nn.sigmoid(tf.matmul(hh0, tf.transpose(W)) + vb)
feed = sess.run(hh0, feed_dict={ v0: inputUser, W: prv_w, hb: prv_hb})
rec = sess.run(vv1, feed_dict={ hh0: feed, W: prv_w, vb: prv_vb})


# In[277]:


scored_webtoon_df_20 = webtoon_data
scored_webtoon_df_20["Recommendation Score"] = rec[0]
scored_webtoon_df_20.sort_values(["Recommendation Score"], ascending=False).head(20)


# In[278]:


merged_df.iloc[17]


# In[282]:


webtoon_df_20 = merged_df[merged_df['UserID']==23]
webtoon_df_20.head()


# In[283]:


merged_df_20 = scored_webtoon_df_20.merge(webtoon_df_20, on='WebtoonID', how='outer')
merged_df_20 = merged_df_20.drop('List Index_y', axis=1).drop('UserID', axis=1)


# In[284]:


merged_df_20.sort_values(["Recommendation Score"], ascending=False).head(20)

