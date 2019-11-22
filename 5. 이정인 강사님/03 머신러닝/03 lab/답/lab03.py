import tensorflow as tf

"""
문제 1)
  텐서플로 상수 "Hi" 를
  10번 출력하는 텐서플로 프로그램을 구현
"""

hello = tf.constant("Hi")
with tf.Session() as sess :
    for i in range(10) :
        print (sess.run( hello ) )


"""  
문제 2)
  jumsu라는 텐서플로 placeholder를 정의 (자료형 : int32 )
  jumsu * 3을 출력하는 텐서플로 프로그램을 구현.

  단, 첫번째 run에는 jumsu의 값을 100 전달.
  두번째 run  run에는 jumsu의 값을 90 전달
"""
jumsu = tf.placeholder(tf.int32)
result = jumsu * 3
with tf.Session() as sess :
    print (sess.run( result, feed_dict={ jumsu :100 } ) )
    print (sess.run(result, feed_dict={jumsu: 90}))

""" 
문제 3)
   jumsu라는 텐서플로 placeholder를 정의
   (단, 자료형 : int32, 값 5개를 갖는  1차원 배열 )

   각각의 jumsu에 10을 더하여 출력하는 텐서플로 프로그램을 구현.

   단, 첫번째 run에는 jumsu의 값을 [100,90,80,70,60] 전달.
   두번째 run  run에는 jumsu의 값을 [99,91,81,71,61] 전달
"""
jumsu = tf.placeholder(tf.int32,[5])

result = jumsu + 10
with tf.Session() as sess :
    print (sess.run( result, feed_dict={ jumsu : [100,90,80,70,60] } ) )
    print (sess.run(result, feed_dict={ jumsu: [99,91,81,71,61] }))


