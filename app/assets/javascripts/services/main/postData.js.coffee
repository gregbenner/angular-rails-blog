angular.module('Blog').factory('postData', ['$http', ($http) ->

  postData =
    data:
      posts: [{title: 'Loading', contents: ''}]
    isLoaded: false

  postData.loadPosts = ->
    unless postData.isLoaded
      $http.get('./posts.json').success( (data) ->
        postData.data.posts = data
        postData.isLoaded = true
        console.log('Successfully loaded posts.')
      ).error( ->
        console.error('Failed to load posts.')
      )

  postData.createPost = (newPost) ->
    # client side data validation
    if newPost.newPostTitle == '' or newPost.newPostContents == ''
      alert('Title or content cannot be blank, foo!')
      false

    #create data object to post
    data =
      new_post:
        title: newPost.newPostTitle
        contents: newPost.newPostContents

    $http.post('./posts.json', data).success((data) ->
      # add new post to array of posts
      postData.data.posts.push(data)
      console.log 'successfully created post'
    ).error( ->
      console.log 'Failed to create new post'
    )

    return true

  postData

])