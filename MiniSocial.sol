// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MiniSocial {
    struct Post {
        string message;
        address author;
    }

    Post[] public posts;
    mapping(address => uint) public userPostCount; // Track number of posts per user

    uint constant MAX_MESSAGE_LENGTH = 280;  // Restrict message length to 280 characters

    event PostPublished(uint indexed postId, address indexed author, string message); // Event for post creation

    // Function to publish a new post
    function publishPost(string memory _message) public {
        // Ensure the message is not empty
        require(bytes(_message).length > 0, "Message cannot be empty");
        // Ensure the message length is within the allowed limit
        require(bytes(_message).length <= MAX_MESSAGE_LENGTH, "Message exceeds maximum length");

        // Create a new post and push it to the posts array
        Post memory newPost = Post({
            message: _message,
            author: msg.sender
        });
        posts.push(newPost);

        // Increment the post count for the user
        userPostCount[msg.sender]++;

        // Emit an event for post creation
        emit PostPublished(posts.length - 1, msg.sender, _message);
    }

    // Function to get a specific post by index
    function getPost(uint index) public view returns (string memory, address) {
        require(index < posts.length, "Index out of range");
        Post memory post = posts[index];
        return (post.message, post.author);
    }

    // Function to get the total number of posts
    function getTotalPosts() public view returns (uint) {
        return posts.length;
    }

    // Function to get the post count for a specific user
    function getUserPostCount(address user) public view returns (uint) {
        return userPostCount[user];
    }
}
