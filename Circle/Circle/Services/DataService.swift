//
//  DataService.swift
//  Circle
//
//  Created by Ivanna Peña on 5/3/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    private var _REF_CHATS = DB_BASE.child("chats")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    var REF_CHATS: DatabaseReference {
        return _REF_CHATS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
    //gets username and profile for user
    func getUsernameAndProfilePictureURL(forUID uid: String, handler: @escaping (_ username: String, _ profileImageURL: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String, user.childSnapshot(forPath: "profileImageURL").value as! String)
                }
            }
        }
    }
    //retrieves messages for newsfeed
    func getAllFeedMessages(handler: @escaping (_ message: [Message]) -> ()) {
        var messageArray = [Message]()
        print("get all feed messages called")
        //REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
        REF_GROUPS.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for group in feedMessageSnapshot{
                let members = group.childSnapshot(forPath: "members").value as! [String]
                if members.contains(String((Auth.auth().currentUser?.email)!)){
            self.REF_GROUPS.child(group.key).child("messages").observeSingleEvent(of: .value) { (feedSnapshot) in
                guard let feedSnapshot = feedSnapshot.children.allObjects as? [DataSnapshot]
                    else { return }
                
                for message in feedSnapshot {
                    let content = message.childSnapshot(forPath: "content").value as! String
                    let senderID = message.childSnapshot(forPath: "senderId").value as! String
                    //print(content)
                    //print(senderID)
                    let message = Message(content: content, senderId: senderID)
                    messageArray.append(message)
                    //print(messageArray)
                    handler(messageArray)
                    print(messageArray)
                }
                    }
            }
            }
            
            handler(messageArray)
        }
    }
    //retrieves messages for group feed
    func getAllMessages(group: Group, handler: @escaping (_ messages: [Message]) -> ()) {
        var messageArray = [Message]()
        
        REF_GROUPS.child(group.key).child("messages").observeSingleEvent(of: .value) { (feedSnapshot) in
            guard let feedSnapshot = feedSnapshot.children.allObjects as? [DataSnapshot]
                else { return }
            
            for message in feedSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderID = message.childSnapshot(forPath: "senderId").value as! String
                
                let message = Message(content: content, senderId: senderID)
                messageArray.append(message)
            }
            
            handler(messageArray)
        }
    }
    //retrieves username for user
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot]
            else { return }
            
            for user in userSnapshot {
                if(user.key == uid) {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    //retrieves user email
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    //retreives user profile picture
    func getCurrentUserProfilePicture(userUID: String, handler: @escaping (_ imageURL: String)-> ()) {
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if user.key == userUID {
                    guard let userProfileImageURL = user.childSnapshot(forPath: "profileImageURL").value as? String else { return }
                    handler(userProfileImageURL)
                }
            }
        }
    }
    //retrieves user id for username
    func getIds(forUsername usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
        print("getIds function")
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email) {
                    idArray.append(user.key)
                }
            }
            print(idArray[0])
            handler(idArray)
        }
    }
    //retrieves email of all group members
    func getEmails(group: Group, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        print("getEmails called")
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            emailArray = group.members
            print(emailArray)
            handler(emailArray)
        }
    }
    //create group object
    func createGroups(withTitle title: String, andDescription description: String, forUserIds ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title" : title, "description": description, "members": ids])
        handler(true)
    }
    //create chat object
    func createChats(forUserIds ids: [String], handler: @escaping (_ chatCreated: Bool) -> ()) {
        REF_CHATS.childByAutoId().updateChildValues(["members": ids])
        handler(true)
    }
    //create chat message object
    func uploadChat(withMessage message: String, forUID uid: String, withChatKey chatKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if chatKey != nil {
           REF_CHATS.child(chatKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
    //retrieve lists of all chats a user is a part of
    func getAllChats(handler: @escaping (_ chatArray: [Chat]) -> ()) {
        var chatArray = [Chat]()
        
        REF_CHATS.observeSingleEvent(of: .value) { (Snapshot) in
            guard let Snapshot = Snapshot.children.allObjects as? [DataSnapshot]
                else { return }
            
            for chat in Snapshot {
                let key = chat.key
                let members = chat.childSnapshot(forPath: "members").value as! [String]
                //most recent message object contents
                
                let chatInstance = Chat(key: key, members: members)
                
                if(members.contains((Auth.auth().currentUser?.email)!)) {
                    chatArray.append(chatInstance)
                }
            }
            
            handler(chatArray)
        }
    }
    //retreives all chat messages in a single chat object
    func getAllChatMessages(chatKey: String, handler: @escaping (_ chatMessageArray: [ChatMessage]) -> ()) {
        var chatMessageArray = [ChatMessage]()
        
        REF_CHATS.child(chatKey).child("messages").observeSingleEvent(of: .value) { (Snapshot) in
            guard let Snapshot = Snapshot.children.allObjects as? [DataSnapshot]
                else { return }
            
            for chatMessage in Snapshot {
                //let key = chatMessage.key
                let senderId = chatMessage.childSnapshot(forPath: "senderId").value as! String
                let content = chatMessage.childSnapshot(forPath: "content").value as! String
                //most recent message object contents
                
                let chatInstance = ChatMessage(content: content, senderId: senderId)
                
                //if(members.contains((Auth.auth().currentUser?.email)!)) {
                    chatMessageArray.append(chatInstance)
                //}
            }
            
            handler(chatMessageArray)
        }
    }
    //retrieves all groups for group page
    func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot]
                else { return }
            
            for group in groupSnapshot {
                let title = group.childSnapshot(forPath: "title").value as! String
                let description = group.childSnapshot(forPath: "description").value as! String
                let key = group.key
                let members = group.childSnapshot(forPath: "members").value as! [String]
                let memberCount = members.count
                
                let groupInstance = Group(title: title, description: description, memberCount: memberCount, key: key, members: members)
                
                //if(members.contains((Auth.auth().currentUser?.email)!)) {
                    groupsArray.append(groupInstance)
                //}
            }
            
            handler(groupsArray)
        }
    }
    //new function for profile groups table view
    func getAllProfileGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot]
                else { return }
            
            for group in groupSnapshot {
                let title = group.childSnapshot(forPath: "title").value as! String
                let description = group.childSnapshot(forPath: "description").value as! String
                let key = group.key
                let members = group.childSnapshot(forPath: "members").value as! [String]
                let memberCount = members.count
                
                let groupInstance = Group(title: title, description: description, memberCount: memberCount, key: key, members: members)
                
                if(members.contains((Auth.auth().currentUser?.email)!)) {
                    groupsArray.append(groupInstance)
                }
            }
            
            handler(groupsArray)
        }
    }
    
    //new function for member profile view controller to retrieve groups with the current selected user's email
    func getAllMembersGroupNames(email: String, handler: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot]
                else { return }
            
            for group in groupSnapshot {
                let title = group.childSnapshot(forPath: "title").value as! String
                let description = group.childSnapshot(forPath: "description").value as! String
                let key = group.key
                let members = group.childSnapshot(forPath: "members").value as! [String]
                let memberCount = members.count
                
                let groupInstance = Group(title: title, description: description, memberCount: memberCount, key: key, members: members)
                
                if(members.contains(email)) {
                    groupsArray.append(groupInstance)
                }
            }
            
            handler(groupsArray)
        }
    }
}
