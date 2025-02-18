//
//  User.swift


//[
//  {
//    "login": "kenreisan",
//    "id": 11494976,
//    "node_id": "MDQ6VXNlcjExNDk0OTc2",
//    "avatar_url": "https://avatars.githubusercontent.com/u/11494976?v=4",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/kenreisan",
//    "html_url": "https://github.com/kenreisan",
//    "followers_url": "https://api.github.com/users/kenreisan/followers",
//    "following_url": "https://api.github.com/users/kenreisan/following{/other_user}",
//    "gists_url": "https://api.github.com/users/kenreisan/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/kenreisan/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/kenreisan/subscriptions",
//    "organizations_url": "https://api.github.com/users/kenreisan/orgs",
//    "repos_url": "https://api.github.com/users/kenreisan/repos",
//    "events_url": "https://api.github.com/users/kenreisan/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/kenreisan/received_events",
//    "type": "User",
//    "user_view_type": "public",
//    "site_admin": false
//  },
//  
//

import Foundation

struct User: Decodable {
    let login: String
    let avatar_url: String
}
