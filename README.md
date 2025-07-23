# FRIDATING Database Project 
SQL database project : Fiona Nicdao, Josh Honig, Drew Patterson, Hannah Serio

## Overview 
FRIDATING (Friend Dating Database) is a social platform designed to help individuals build meaningful friendships through shared interests and local events. Whether you're new in town or looking to grow your social circle, FRIDATING provides a safe, welcoming space for people to connect, chat, and meet in person.
This project models the backend SQL database of the FRIDATING platform, including user accounts, chat functionality, subscription plans, and event management.

## Introduction
The Friend Dating Database (FRIDATING) allows individuals to connect with like-minded
people. This platform provides a safe space for fostering new friendships, whether users are
new to a city or looking to expand their social circles. In the FRIDATING Database, users can
create one account, which is distinct from their user profile. While the user is the individual
participating in the platform, the account they create contains their bio and shared interests,
enabling them to connect with others. An account matches with other accounts based on shared
interests, with communication facilitated through the platform's chat feature. Each account can
engage in multiple text chat conversations with those they have matched with. Two unique traits
of the FRIDATING Database are the subscription and events features, allowing special
privileges to certain users and giving accounts a space to host or join events near them.
Accounts can create and host many events that are open and visible for others to join. Others
can indicate their interest via an RSVP mechanism, which tells the event organizer how many
people to anticipate. Each user manages one subscription at a time, with a choice between
base and premium subscriptions. Premium subscriptions offer additional perks, and users can
choose to split their payment across multiple different payment methods. Overall, the
FRIDATING Database provides an engaging and dynamic platform for individuals to build
meaningful connections both online and in person. The inspiration for the design of the
database comes from the group's collective experience using dating apps.

## Description
The Friend Dating Database (FRIDATING) stores relevant information regarding a company's
need to track the actions of its users on a friend 'dating' site. The FRIDATING Database
contains data about the user's matches, account information, subscription tier with possible
payment methods, chats created between two users, messages sent between two users, and
events shared amongst users.

* Each user possesses a unique identification number, multi-factor authentication token,
username, and password. Only sensitive information is stored in the user; profile
information is stored elsewhere for security purposes. Payment information is also tied to
the user, since this information is considered sensitive.

* Each user must manage their account. Each account is only managed by one user. The
account contains profile information such as account identification number, interests, a
biography, account name, address, a user's location, and their photos. The address
contains the user's street address, city, and state, from which GPS coordinates may be
derived for matching users together. An account can match with zero to many other
accounts. The match status is stored depending on the individual status of each user's
match with each other. The match date and derived compatibility score are also stored.

* Each user can manage zero to many events containing the unique event identification
number, event name, event date, event type, and event location. Event location is stored
as the latitude, longitude, and location range. Each event can only be managed by one
user. In addition to managing events, users can also RSVP to zero to many events using
a response type.

* Each user must manage their subscription. Subscription tier type, balance, date their
next payment is due, billing mode, price, and subscription identification number are all
stored. Each subscription must be managed by one user.

* Each subscription can contain zero to many payment methods. A payment method must
belong to one subscription. The method identification number, method type, credit card
information, and third party payment information are stored.

* Accounts can participate in zero to multiple chats with their matches. The start date of
the chat, chat identification number, and chat status are stored. When there has been no
activity in the chat for 30 days, the chat's status will be set to “expired,
” and users will not
be able to send messages in the chat.

* Each chat contains zero to many messages which have a message identification
number, content of the message, and date of the message. Each message must belong
to only one chat. Each account can send zero to many messages. Each message must
be sent by one account.

## Technologies Used 
* SQL (PostgreSQL)
* ER diagram tools (Draw.io)
* SQL testing platform (pgAdmin)

## Learn more ...
Look at the documentations directory for more information and the complete project pdf

## Licence 
MIT License
Feel free to use, modify, and build upon this project.