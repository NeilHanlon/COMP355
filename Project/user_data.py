__author__ = 'Neil'

import json
import uuid
import random
import string
import hashlib
import urllib2
import MySQLdb as mdb

con = mdb.connect(host="localhost", user="root", passwd="", db="forumproject")
cursor = con.cursor()

POSTS_URL = "https://www.mockaroo.com/9f32a280/download?count=1000&key=9f153c80"
THREADS_URL = "https://www.mockaroo.com/b20014e0/download?count=1000&key=9f153c80"
CONVERSATION_URL = "https://mockaroo.com/e0e76f70/download?count=1000&key=9f153c80"
MESSAGES_URL = "https://mockaroo.com/0cfff960/download?count=250&key=9f153c80"
GALLERY_URL = "http://mockaroo.com/86a19590/download?count=1000&key=9f153c80"

PERMISSIONS = [
    "Forum_View",
    "Topic_Create", "Topic_Edit_Own", "Topic_Edit_Other", "Topic_Delete", "Topic_Move",
    "Post_Create", "Post_Edit_Own", "Post_Edit_Other", "Post_Delete", "Post_Move",
    "Gallery_Upload", "Gallery_Edit", "Gallery_Delete", "Gallery_Hide",
    "User_Edit", "User_Suspend", "User_Delete", "User_Ban", "User_Create",
    "Conversation_Create"
]

res = urllib2.urlopen("http://api.randomuser.me/?format=json&results=500&key=X46A-OFA4-3TFW-5332")
json_res = json.load(res)

cursor.execute("Select name from role where name = 'Guest'")
res = cursor.fetchone()

if res is None:
    cursor.execute("Insert into role (name) values ('Guest'),('Registered'),('Moderator'),('Administrator')")
    cursor.execute(
        "Insert into permission (name) values "
        "(%s),(%s),(%s),(%s),(%s),"
        "(%s),(%s),(%s),(%s),(%s),"
        "(%s),(%s),(%s),(%s),(%s),"
        "(%s),(%s),(%s),(%s),(%s),(%s)",
        PERMISSIONS)
    con.commit()
    cursor.execute("insert into role_has_permissions (role_id, permission_id) values "
                   "(1,1),"
                   "(2,1),(2,2),(2,3),(2,7),(2,8),(2,12),(2,13),(2,14),(2,15),(2,21),"
                   "(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),"
                   "(3,12),(3,13),(3,14),(3,15),(3,17),(3,21),"
                   "(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(4,10),(4,11),"
                   "(4,12),(4,13),(4,14),(4,15),(4,16),(4,17),(4,18),(4,19),(4,20)")

cursor.execute("select name from forum WHERE name = 'Important'")
res = cursor.fetchone()

if res is None:
    cursor.execute(
        "Insert into forum (parent_id, name) values (NULL,'Important'), (NULL,'General'),(1,'Announcements'),(2,'Off-Topic'),(1,'News'),(2,'Graphics'),(2,'Programming');")

con.commit()

for result in json_res['results']:
    user = result['user']

    # pprint(user)

    username = user['username']
    first = user['name']['first'].title()
    last = user['name']['last'].title()
    email = user['email']
    role_id = 1
    salt = ''.join(random.choice(string.letters + string.digits) for i in xrange(32))
    pass_salt = str(user['password'] + salt)
    password = hashlib.sha256(pass_salt).hexdigest()

    cursor.execute(
        "insert into user (email, username, first_name, last_name, password, salt, role_id) VALUES (%s,%s,%s,%s,%s,%s,%s)",
        (email, username, first, last, password, salt, role_id))

con.commit()
res = json.load(urllib2.urlopen(THREADS_URL))

for result in res:
    forum_id = result['forum_id']
    thread_title = result['thread_title']

    cursor.execute("insert into thread (forum_id,title) values (%s,%s)", (forum_id, thread_title))

res = json.load(urllib2.urlopen(POSTS_URL))

con.commit()

cursor.execute("select max(t.id), max(u.id) from thread t, user u")
sqlres = cursor.fetchone()
max_thread = int(sqlres[0])
max_user = int(sqlres[1])

for result in res:
    post_content = result['post_content']
    user_id = random.randint(1, max_user)
    thread_id = random.randint(1, max_thread)

    cursor.execute("insert into post (thread_id, user_id, content) values (%s,%s,%s)",
                   (thread_id, user_id, post_content))

con.commit()

res = json.load(urllib2.urlopen(CONVERSATION_URL))

for conversation in res:
    user_to = random.randint(1, max_user)
    user_from = random.randint(1, max_user)
    while user_to == user_from:
        print "collision:", user_to, user_from
        user_from = random.randint(1, max_user)
    title = conversation['title']

    cursor.execute("insert into conversation (title, user_id_to, user_id_from) values (%s, %s, %s)",
                   (title, user_to, user_from))

con.commit()

max_conversation = cursor.execute("select max(id) from conversation")
dbres = cursor.fetchone()

max_conversation = int(dbres[0])

res = json.load(urllib2.urlopen(MESSAGES_URL))

for message in res:
    conversation_id = random.randint(1, max_conversation)
    print conversation_id
    content = message['message']

    cursor.execute("insert into message (content, conversation_id) VALUES (%s,%s)", (content, conversation_id))

con.commit()

res = json.load(urllib2.urlopen(GALLERY_URL))

for g in res:
    title = g['title']
    desc = g['description']
    user_id = random.randint(1, max_user)
    path = str(uuid.uuid4())
    hidden = random.choice(["Y", "N"])

    cursor.execute("Insert into gallery (path, title, description, hidden, user_id) values (%s,%s,%s,%s,%s) ",
                   [path, title, desc, hidden, user_id])

con.commit()
