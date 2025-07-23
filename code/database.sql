/* Josh's CREATE and INSERT statements */
CREATE TABLE users(
usrID uuid DEFAULT gen_random_uuid() NOT NULL UNIQUE,
username varchar(32) NOT NULL UNIQUE,
email varchar(96) NOT NULL UNIQUE,
passwordHash varchar(256) NOT NULL,
passwordSalt varchar(256) NOT NULL UNIQUE,
MFAtoken varchar(64) NOT NULL UNIQUE,
PRIMARY KEY(usrID)
);
INSERT INTO users(usrID, username, email, passwordHash, passwordSalt, MFAtoken) VALUES
('94ab690c-3864-407b-8354-4e606ee0cc70', 'jsmith', 'jsmith2618@gmail.com',
md5('password1'), md5(random()::text), md5(random()::text)),
('90d7a0ae-b451-400f-bc12-784817309921', 'tony1', 'tony2@yahoo.com',
md5('secret-password'), md5(random()::text), md5(random()::text)),
('cf7487c3-9196-4f46-99bd-b337baa2d655', 'ann.music', 'amusic@luc.edu', md5('mu$ic'),
md5(random()::text), md5(random()::text)),
('a799046b-9ef7-4166-9120-7f99ebac91b9', 'kay-smith', 'ks1281@gmail.com',
md5('v3rysecurepassword'), md5(random()::text), md5(random()::text)),
('40520f25-1382-4bc1-acb7-cb33af4be407', 'AzureDiamond', 'adiamond2@gmail.com',
md5('hunter2'), md5(random()::text), md5(random()::text));
CREATE TABLE account(
actID uuid DEFAULT gen_random_uuid() NOT NULL UNIQUE,
bio varchar(300),
firstName varchar(32) NOT NULL,
lastName varchar(32),
actStreetAddress varchar(128) NOT NULL,
actCity varchar(64) NOT NULL,
actState varchar(64) NOT NULL,
actLocGPS point NOT NULL,
userID uuid NOT NULL UNIQUE,
FOREIGN KEY(userID) REFERENCES users(usrID) ON DELETE cascade ON UPDATE
cascade,
PRIMARY KEY(actID)
);
INSERT INTO account VALUES
( '4a7536a1-3782-451b-a889-ecc18e6b7fb3',
'My name is John.',
'John', 'Smith', '6400 N Sheridan Rd, Apt 512', 'Chicago', 'IL',
point(41.9983675,-87.6623145), '94ab690c-3864-407b-8354-4e606ee0cc70'
),
( '3a32afed-2d4d-41c9-bef4-434ef8945dfa',
'as featured in Tony Hawk''s Pro Skater AND Tony Hawk''s Pro strcpy',
'Tony', NULL, '10353 E County Rd', 'Galveston', 'IN',
point(40.6129651, -86.1789315), '90d7a0ae-b451-400f-bc12-784817309921'
),
(
'257d8621-2e49-442b-96c2-605a651a996d',
'hi, i''m Ann!',
'Ann', 'M', '644 N Magnolia Av', 'Chicago', 'IL',
point(41.9510346,-87.6630623), 'cf7487c3-9196-4f46-99bd-b337baa2d655'
),
(
'2493c668-be9f-4485-beb7-48dbf596f983',
NULL,
'kay', NULL, '3688 N Atlantic Ave', 'Cocoa Beach', 'FL',
point(28.352895,-80.6093542), 'a799046b-9ef7-4166-9120-7f99ebac91b9'
),
(
'56131135-346e-46f2-84e3-1565178e1164',
'fun fact: did you know if you type your password it will show as stars?',
'AzureDiamond', NULL, '1400 Defense Boulevard', 'Arlington', 'VA',
point(38.8697197,-77.0545081), '40520f25-1382-4bc1-acb7-cb33af4be407'
);
CREATE TABLE accountInterests(
actID uuid NOT NULL,
FOREIGN KEY(actID) REFERENCES account(actID)
ON DELETE CASCADE ON UPDATE CASCADE,
interest varchar(32) NOT NULL UNIQUE,
PRIMARY KEY(actID, interest)
);
INSERT INTO accountInterests(actID, interest) VALUES
('4a7536a1-3782-451b-a889-ecc18e6b7fb3', 'Hiking'),
('4a7536a1-3782-451b-a889-ecc18e6b7fb3', 'Painting'),
('4a7536a1-3782-451b-a889-ecc18e6b7fb3', 'Running'),
('3a32afed-2d4d-41c9-bef4-434ef8945dfa', 'skating'),
('3a32afed-2d4d-41c9-bef4-434ef8945dfa', 'playing Tony Hawk''s Pro Skater'),
('257d8621-2e49-442b-96c2-605a651a996d', 'music'),
('257d8621-2e49-442b-96c2-605a651a996d', 'singing'),
('56131135-346e-46f2-84e3-1565178e1164', 'IRC'),
('56131135-346e-46f2-84e3-1565178e1164', 'Gaming');
CREATE TABLE accountPhotos(
actID uuid NOT NULL,
FOREIGN KEY(actID) REFERENCES account(actID)
ON DELETE CASCADE ON UPDATE CASCADE,
photo varchar(2048) NOT NULL UNIQUE,
PRIMARY KEY(actID, photo)
);
INSERT INTO accountPhotos(actID, photo) VALUES
('4a7536a1-3782-451b-a889-ecc18e6b7fb3',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
a2195bf2-2211-4d8a-bbd7-09a655740ce6.jpg'),
('4a7536a1-3782-451b-a889-ecc18e6b7fb3',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
751e035d-3526-44c5-8427-a12fc34e6a45.jpg'),
('4a7536a1-3782-451b-a889-ecc18e6b7fb3',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
e4e19be7-112d-420f-8d75-93947f133a9f.jpg'),
('4a7536a1-3782-451b-a889-ecc18e6b7fb3',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
81ce9010-b69a-4002-bda9-d6459f6de980.jpg'),
('4a7536a1-3782-451b-a889-ecc18e6b7fb3',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
f9e80b5e-cdc4-42d6-a541-392c6076340f.jpg'),
('3a32afed-2d4d-41c9-bef4-434ef8945dfa',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
eb42d1d6-b4cd-4283-82eb-4e05feef46f3.jpg'),
('3a32afed-2d4d-41c9-bef4-434ef8945dfa',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
53bd7274-b8eb-442c-9c9b-ba83c418a03a.jpg'),
('257d8621-2e49-442b-96c2-605a651a996d',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
ec0bb0a1-b1bb-4381-8bf8-121b90d318a1.jpg'),
('257d8621-2e49-442b-96c2-605a651a996d',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
fd03f3ca-eb70-4632-a3b3-92428fc21623.jpg'),
('56131135-346e-46f2-84e3-1565178e1164',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
dc896d53-5e8e-4ea5-9d8e-3b31a8df88b5.jpg'),
('56131135-346e-46f2-84e3-1565178e1164',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
a9e61e2b-9573-4034-a84b-b14e1468d0aa.jpg'),
('56131135-346e-46f2-84e3-1565178e1164',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
63427ccd-2bd7-4d93-92e3-e14b0a4e9a46.jpg');
CREATE TABLE chat(
chatID uuid DEFAULT gen_random_uuid() NOT NULL UNIQUE,
chtIsActive boolean NOT NULL,
chtLastMesTimestamp timestamp WITHOUT time zone, /* UTC */
PRIMARY KEY(chatID)
);
INSERT INTO chat VALUES
('0b3d9d58-85d0-4679-a5a1-86f7b5fd019f', true, current_timestamp),
('9389cf0b-7fee-4368-b276-c5c1b28f3ffc', true, (current_timestamp - interval '3'
day)),
('bad455be-b7a5-49ce-9299-93a514a2b507', false, (current_timestamp - interval '5'
month - interval '15' day)),
('aaefa26b-b842-4d31-950b-9f7a9b8e0ea7', true, NULL)
/* New chat with no messages */;
CREATE TABLE participatesIn(
actID uuid NOT NULL,
FOREIGN KEY(actID) REFERENCES account(actID)
ON DELETE CASCADE ON UPDATE CASCADE,
chatID uuid NOT NULL,
FOREIGN KEY(chatID) REFERENCES chat(chatID)
ON DELETE CASCADE ON UPDATE CASCADE,
startDate timestamp WITHOUT time zone,
PRIMARY KEY(actID, chatID)
);
INSERT INTO participatesIn(actID, chatID, startDate) VALUES
(
'4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'0b3d9d58-85d0-4679-a5a1-86f7b5fd019f',
(current_timestamp - interval '1' day)
),
(
'3a32afed-2d4d-41c9-bef4-434ef8945dfa', /* Tony */
'0b3d9d58-85d0-4679-a5a1-86f7b5fd019f',
(current_timestamp - interval '1' day)
),
(
'257d8621-2e49-442b-96c2-605a651a996d', /* Ann */
'9389cf0b-7fee-4368-b276-c5c1b28f3ffc',
(current_timestamp - interval '6' day)
),
(
'56131135-346e-46f2-84e3-1565178e1164', /* AzureDiamond */
'9389cf0b-7fee-4368-b276-c5c1b28f3ffc',
(current_timestamp - interval '6' day)
),
(
'4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'bad455be-b7a5-49ce-9299-93a514a2b507',
(current_timestamp - interval '5' month - interval '30' day)
),
(
'56131135-346e-46f2-84e3-1565178e1164', /* AzureDiamond */
'bad455be-b7a5-49ce-9299-93a514a2b507',
(current_timestamp - interval '5' month - interval '30' day)
),
(
'2493c668-be9f-4485-beb7-48dbf596f983', /* kay */
'aaefa26b-b842-4d31-950b-9f7a9b8e0ea7',
(current_timestamp - interval '5' minute)
),
(
'257d8621-2e49-442b-96c2-605a651a996d', /* Ann */
'aaefa26b-b842-4d31-950b-9f7a9b8e0ea7',
(current_timestamp - interval '5' minute)
);
CREATE TABLE message(
mesID serial NOT NULL,
mesText varchar(2048) NOT NULL,
mesDate timestamp WITHOUT time zone NOT NULL,
chatID uuid NOT NULL,
FOREIGN KEY(chatID) REFERENCES chat(chatID)
ON DELETE CASCADE ON UPDATE CASCADE,
senderID uuid NOT NULL,
FOREIGN KEY(senderID) REFERENCES account(actID)
ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(mesID)
);
INSERT INTO message(mesText, mesDate, chatID, senderID) VALUES
(
'Hi Tony. How are you?',
current_timestamp - interval '1' day - interval '15' minute,
'0b3d9d58-85d0-4679-a5a1-86f7b5fd019f',
'4a7536a1-3782-451b-a889-ecc18e6b7fb3' /* John */
),
(
'I''m good John, how are you?..',
current_timestamp - interval '1' day,
'0b3d9d58-85d0-4679-a5a1-86f7b5fd019f',
'3a32afed-2d4d-41c9-bef4-434ef8945dfa' /* Tony */
),
(
'hi Ann! what''s up?',
current_timestamp - interval '8' day,
'9389cf0b-7fee-4368-b276-c5c1b28f3ffc',
'56131135-346e-46f2-84e3-1565178e1164' /* AzureDiamond */
),
(
'not much. tell me about the fact in your bio! i don''t really get it',
current_timestamp - interval '7' day - interval '12' hour,
'9389cf0b-7fee-4368-b276-c5c1b28f3ffc',
'257d8621-2e49-442b-96c2-605a651a996d' /* Ann */
),
(
'oh if you type your password it automatically turns to stars! like this: hunter2',
current_timestamp - interval '6' day,
'9389cf0b-7fee-4368-b276-c5c1b28f3ffc',
'56131135-346e-46f2-84e3-1565178e1164' /* AzureDiamond */
),
(
'Hey there, neat username. What does it stand for?',
current_timestamp - interval '5' month - interval '15' day,
'bad455be-b7a5-49ce-9299-93a514a2b507',
'4a7536a1-3782-451b-a889-ecc18e6b7fb3' /* John */
);
CREATE TABLE event(
evtID uuid DEFAULT gen_random_uuid() NOT NULL UNIQUE,
evtType varchar(32),
evtDateStart timestamp WITHOUT time zone NOT NULL,
evtDateEnd timestamp WITHOUT time zone NOT NULL,
evtName varchar(64) NOT NULL,
evtDetails varchar(2048) NOT NULL,
evtLocGPS point NOT NULL,
evtLocRange int NOT NULL, /* in feet */
evtManager uuid NOT NULL,
FOREIGN KEY(evtManager) REFERENCES account(actID)
ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(evtID)
);
(
INSERT INTO event VALUES
'17170cd3-1bfa-4809-9816-28503c9986fe',
'Game',
current_timestamp + interval '5' day,
current_timestamp + interval '5' day + interval '4' hour,
'Board Games @ Cuneen''s',
'Our THIRD board game night for anybody in the Edgewater area!
We''ll have Azul, Scrabble, Jenga, and Catan. Tonight we''ll be at
Cuneen''s on Devon.',
point(41.9983065,-87.6666288), 50,
'4a7536a1-3782-451b-a889-ecc18e6b7fb3'
),
(
'85067bd4-11fb-4fcb-b1e7-b3883088f90c',
'Group Activity',
current_timestamp + interval '7' day,
current_timestamp + interval '8' day,
'Alligator Wrestling',
'this week''s gator wrestling. everybody wear dark dark clothes,
we do NOT want the cops called on us again.
DON''T BE THERE UNTIL AFTER SUNDOWN',
point(28.288404259380975,-80.61084415798224), 65,
'2493c668-be9f-4485-beb7-48dbf596f983'
);
CREATE TYPE rsvp_status AS ENUM ('yes', 'maybe', 'no');
CREATE TABLE eRSVP(
actID uuid NOT NULL,
FOREIGN KEY(actID) REFERENCES account(actID)
ON DELETE CASCADE ON UPDATE CASCADE,
evtID uuid NOT NULL,
FOREIGN KEY(evtID) REFERENCES event(evtID)
ON DELETE CASCADE ON UPDATE CASCADE,
response rsvp_status NOT NULL,
rsvDate timestamp WITHOUT time zone NOT NULL,
PRIMARY KEY(actID, evtID)
);
(
INSERT INTO eRSVP VALUES
'257d8621-2e49-442b-96c2-605a651a996d', /* Ann */
'17170cd3-1bfa-4809-9816-28503c9986fe', /* Board Games @ Cuneen's */
'yes',
current_timestamp - interval '1' day
),
(
'3a32afed-2d4d-41c9-bef4-434ef8945dfa', /* Tony */
'17170cd3-1bfa-4809-9816-28503c9986fe', /* Board Games @ Cuneen's */
'maybe',
current_timestamp - interval '20' hour
),
(
'56131135-346e-46f2-84e3-1565178e1164', /* AzureDiamond */
'85067bd4-11fb-4fcb-b1e7-b3883088f90c', /* Alligator Wrestling */
'maybe',
current_timestamp - interval '2' hour
),
(
'4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'85067bd4-11fb-4fcb-b1e7-b3883088f90c', /* Alligator Wrestling */
'no',
current_timestamp - interval '5' minute
);
CREATE TABLE subscription(
subID uuid DEFAULT gen_random_uuid() NOT NULL UNIQUE,
subTier varchar(64) NOT NULL,
subPrice numeric,
outstandingBalance numeric,
nextDueDate timestamp WITHOUT time zone,
annualBilling boolean,
userID uuid NOT NULL,
FOREIGN KEY(userID) REFERENCES users(usrID),
PRIMARY KEY(subID)
);
(
INSERT INTO subscription VALUES
'4f36fd46-c84c-4d7c-868b-85532e580dab',
'Bestie for Life', 49.99, 0.00,
'2024-12-10 16:39:00', true,
'94ab690c-3864-407b-8354-4e606ee0cc70'
);
INSERT INTO subscription(subTier, userID) VALUES
('Free', '90d7a0ae-b451-400f-bc12-784817309921'),
('Free', 'cf7487c3-9196-4f46-99bd-b337baa2d655'),
('Free', 'a799046b-9ef7-4166-9120-7f99ebac91b9'),
('Free', '40520f25-1382-4bc1-acb7-cb33af4be407');
CREATE TYPE payment_type AS ENUM ('credit', 'debit', 'thirdParty');
CREATE TABLE paymentMethod(
pmtID uuid DEFAULT gen_random_uuid() NOT NULL UNIQUE,
subID uuid NOT NULL,
FOREIGN KEY(subID) REFERENCES subscription(subID)
ON UPDATE CASCADE ON DELETE CASCADE,
pmtType payment_type NOT NULL,
num numeric,
cvv numeric,
expiration varchar(16),
pmtStreetAddr varchar(128),
pmtCity varchar(64),
pmtState varchar(64),
pmtZipcode varchar(64),
androidPay varchar(128),
applePay varchar(128),
payPal varchar(128),
PRIMARY KEY(pmtID)
);
INSERT INTO paymentMethod(pmtID, subID, pmtType, applePay) VALUES
(
'49ee6acd-08a8-481c-9462-9e10969a97f2', '4f36fd46-c84c-4d7c-868b-85532e580dab',
'thirdParty', '5G8HzqBxpa73VTqSjfipb0u0NKRgwbTe'
);
CREATE TYPE match_status AS ENUM ('unseen', 'accept', 'reject');
CREATE TABLE matches(
actID1 uuid NOT NULL,
FOREIGN KEY(actID1) REFERENCES account(actID)
ON DELETE CASCADE ON UPDATE CASCADE,
actID2 uuid NOT NULL,
FOREIGN KEY(actID2) REFERENCES account(actID)
ON DELETE CASCADE ON UPDATE CASCADE,
mchDate timestamp WITHOUT time zone NOT NULL,
compatabilityScore numeric NOT NULL,
act1status match_status NOT NULL DEFAULT 'unseen',
act2status match_status NOT NULL DEFAULT 'unseen',
PRIMARY KEY(actID1, actID2)
);
(
INSERT INTO matches VALUES
'4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'3a32afed-2d4d-41c9-bef4-434ef8945dfa', /* Tony */
current_timestamp - interval '3' day,
9.553262, 'accept', 'accept'
),
(
'56131135-346e-46f2-84e3-1565178e1164', /* AzureDiamond */
'257d8621-2e49-442b-96c2-605a651a996d', /* Ann */
current_timestamp - interval '10' day,
4.613523, 'accept', 'accept'
),
(
'4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'56131135-346e-46f2-84e3-1565178e1164', /* AzureDiamond */
current_timestamp - interval '6' month,
2.61918804, 'accept', 'accept'
),
(
'4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'2493c668-be9f-4485-beb7-48dbf596f983', /* Kay */
current_timestamp - interval '1' month,
3.161310, 'reject', 'accept'
),
(
'4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'257d8621-2e49-442b-96c2-605a651a996d', /* Ann */
current_timestamp - interval '3' day,
8.1356971, 'accept', 'unseen'
),
(
),
(
'3a32afed-2d4d-41c9-bef4-434ef8945dfa', /* Tony */
'56131135-346e-46f2-84e3-1565178e1164', /* AzureDiamond */
current_timestamp - interval '1' minute,
3.1851014, 'unseen', 'unseen'
'3a32afed-2d4d-41c9-bef4-434ef8945dfa', /* Tony */
'2493c668-be9f-4485-beb7-48dbf596f983', /* Kay */
current_timestamp - interval '1' minute,
2.1358178, 'unseen', 'unseen'
);
/* Josh's spammer/scammer profile INSERT statements */
INSERT INTO users(usrID, username, email, passwordHash, passwordSalt, MFAToken) VALUES
('a87b4c9b-f164-4e4b-99a4-2d64f2212ca7', 'FreeRobux', 'robux1578@sketchkysite.ru',
md5('jEh812hWH&(Q@qjio'), md5(random()::text), md5(random()::text));
INSERT INTO account VALUES
(
'b079763a-21fd-409e-89a8-ccd1d570848f',
'Want to learn how to earn FRE_E <R0BUX>? Go to
http://freemon3y.robux1513125316.pw',
'Free-Robux_website', NULL,
'123454 Red Square', 'Tverskoy District', 'Moscow',
point(55.7536141,37.6227219),
'a87b4c9b-f164-4e4b-99a4-2d64f2212ca7'
);
INSERT INTO accountPhotos VALUES
('b079763a-21fd-409e-89a8-ccd1d570848f',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/af20a503-e4de-425b-a1af-ed2a3d
989f4a');
INSERT INTO matches VALUES
(
'b079763a-21fd-409e-89a8-ccd1d570848f',
'4a7536a1-3782-451b-a889-ecc18e6b7fb3',
current_timestamp - interval '15' day,
1.062179, 'accept', 'accept'
),
(
'b079763a-21fd-409e-89a8-ccd1d570848f',
'3a32afed-2d4d-41c9-bef4-434ef8945dfa',
current_timestamp - interval '15' day,
1.13589, 'accept', 'unseen'
),
(
'b079763a-21fd-409e-89a8-ccd1d570848f',
'257d8621-2e49-442b-96c2-605a651a996d',
current_timestamp - interval '15' day,
1.36161, 'accept', 'unseen'
),
(
'b079763a-21fd-409e-89a8-ccd1d570848f',
'2493c668-be9f-4485-beb7-48dbf596f983',
current_timestamp - interval '15' day,
1.91748, 'accept', 'accept'
),
(
);
'b079763a-21fd-409e-89a8-ccd1d570848f',
'56131135-346e-46f2-84e3-1565178e1164',
current_timestamp - interval '15' day,
1.222179, 'accept', 'unseen'
INSERT INTO chat VALUES
('c3eca16c-0076-4806-b531-c84dc0727894', true,
current_timestamp - interval '3' day),
('5aeeadef-5122-4f6c-969e-ba5b391da800', true,
current_timestamp - interval '3' day),
('eee3a5e8-e2f5-4400-b4b6-e9c0cab3c0d5', true,
current_timestamp - interval '3' day),
('6482e27a-1a10-493c-86e7-8c95c6649ef3', true,
current_timestamp - interval '3' day);
INSERT INTO participatesIn VALUES
(
'b079763a-21fd-409e-89a8-ccd1d570848f', /* spammer */
'c3eca16c-0076-4806-b531-c84dc0727894',
current_timestamp - interval '3' day
),
(
'2493c668-be9f-4485-beb7-48dbf596f983',
'c3eca16c-0076-4806-b531-c84dc0727894',
current_timestamp - interval '3' day
),
(
'b079763a-21fd-409e-89a8-ccd1d570848f', /* spammer */
'5aeeadef-5122-4f6c-969e-ba5b391da800',
current_timestamp - interval '3' day
),
(
'257d8621-2e49-442b-96c2-605a651a996d',
'5aeeadef-5122-4f6c-969e-ba5b391da800',
current_timestamp - interval '3' day
),
(
),
(
'b079763a-21fd-409e-89a8-ccd1d570848f', /* spammer */
'eee3a5e8-e2f5-4400-b4b6-e9c0cab3c0d5',
current_timestamp - interval '3' day
'4a7536a1-3782-451b-a889-ecc18e6b7fb3',
'eee3a5e8-e2f5-4400-b4b6-e9c0cab3c0d5',
current_timestamp - interval '3' day
),
(
),
(
);
(
'b079763a-21fd-409e-89a8-ccd1d570848f', /* spammer */
'6482e27a-1a10-493c-86e7-8c95c6649ef3',
current_timestamp - interval '3' day
'56131135-346e-46f2-84e3-1565178e1164',
'6482e27a-1a10-493c-86e7-8c95c6649ef3',
current_timestamp - interval '3' day
INSERT INTO message(mesText, mesDate, chatID, senderID) VALUES
'FREE R0BUCKS AT THIS LINK ---> http://freemoney.robuxscam2351.pw',
current_timestamp - interval '3' day,
'c3eca16c-0076-4806-b531-c84dc0727894',
'b079763a-21fd-409e-89a8-ccd1d570848f'
),
(
'NEED ROBUX NOW? FREE HERE --> http://robux.legit2353212website.ru',
current_timestamp - interval '3' day,
'5aeeadef-5122-4f6c-969e-ba5b391da800',
'b079763a-21fd-409e-89a8-ccd1d570848f'
),
(
'------> http://robux-generator-now-free.roblocks.ua <------',
current_timestamp - interval '3' day,
'eee3a5e8-e2f5-4400-b4b6-e9c0cab3c0d5',
'b079763a-21fd-409e-89a8-ccd1d570848f'
),
(
'!!! Tap HERE >>> http://robloock-generator-free-noscam.org <<< HERE NOW for FREE
robux !!!',
current_timestamp - interval '3' day,
'6482e27a-1a10-493c-86e7-8c95c6649ef3',
'b079763a-21fd-409e-89a8-ccd1d570848f'
);
/* Hannah's insertions */
INSERT INTO users(usrID, username, email, passwordHash, passwordSalt, MFAtoken) VALUES
('3e5fb29d-ce1b-4f3b-9ced-c35858d389cf', 'katy_pr3ston', 'katyp9570@gmail.com',
md5('katy'), md5(random()::text), md5(random()::text)),
('b7832602-640f-45c9-856a-51496cb97b97', 'madmax', 'mmd0g@yahoo.com',
md5('madmaxd0g'), md5(random()::text), md5(random()::text)),
('bebaaef9-e9a0-40a2-9a65-ab905b164ad7', 'chicagolex', 'lex33420@hotmail.com',
md5('lex1'), md5(random()::text), md5(random()::text)),
('a70baa2f-84c6-4839-9b07-543510a752c0', 'berrybenson', 'b_benson12@gmail.com',
md5('bens0n12'), md5(random()::text), md5(random()::text)),
('7f702396-b720-43d7-a2d9-f96a1b4d3569', 'd0gl0ver213', 'amanda_spears30@gmail.com',
md5('amandasm1th'), md5(random()::text), md5(random()::text));
INSERT INTO account VALUES
('072cb76c-8ca0-43f2-a515-8418d1931193', 'It''s Katy P! <3', 'Katy', 'Perry', '1939
Loomis St', 'Rockford', 'IL', point(42.26220,-89.12451),
'3e5fb29d-ce1b-4f3b-9ced-c35858d389cf'),
('c00605f5-dc5e-41df-83e3-36e4f6427284', 'Looking to play basketball with friends',
'Max', 'Madewell', '301 S 4th Ave', 'Brighton', 'CO', point(39.98200, -104.81848),
'b7832602-640f-45c9-856a-51496cb97b97'),
('f1b21a51-c213-4e83-bc50-b821f317bea4', 'single & ready to.. Make friends!', 'Berry',
'Benson', '512 S 3rd St', 'Champaign', 'IL', point(40.11231, -88.23516),
'bebaaef9-e9a0-40a2-9a65-ab905b164ad7'),
('d7165614-5e9c-4d7c-9003-102dd83545ce', 'If you love reading, walks by the lake, and
movies let''s hang!', 'Amanda', 'Smith', '2634 W Argyle St', 'Chicago', 'IL',
point(41.97254, -87.69531), '7f702396-b720-43d7-a2d9-f96a1b4d3569');
INSERT INTO accountPhotos(actID, photo) VALUES
('072cb76c-8ca0-43f2-a515-8418d1931193',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
file1.jpg'),
('d7165614-5e9c-4d7c-9003-102dd83545ce',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
file2.jpg');
INSERT INTO accountInterests(actID, interest) VALUES
('f1b21a51-c213-4e83-bc50-b821f317bea4', 'Fishing'),
('f1b21a51-c213-4e83-bc50-b821f317bea4', 'Photography'),
('d7165614-5e9c-4d7c-9003-102dd83545ce', 'Reading');
INSERT INTO subscription(subID, subTier, userID, outstandingBalance, nextDueDate)
VALUES
('1cb5b930-62ed-47f0-8a42-52c8f9ed0a2b', 'Bestie for Life',
'3e5fb29d-ce1b-4f3b-9ced-c35858d389cf', 0.00, '2024-12-15 16:39:00'),
('56669135-539c-4993-911a-736f9b237916', 'Bestie for Life',
'bebaaef9-e9a0-40a2-9a65-ab905b164ad7', 0.00, '2024-12-30 16:39:00'),
('e8368d90-94ff-47c4-9f9b-428b1b456d85', 'Premium',
'7f702396-b720-43d7-a2d9-f96a1b4d3569', 0.00, '2024-12-17 16:39:00'),
('d44d4ac4-97eb-4b6a-b888-23571bc3ab41', 'Free',
'b7832602-640f-45c9-856a-51496cb97b97', NULL, NULL);
INSERT INTO paymentMethod(pmtID, subID, pmtType, num, cvv, expiration, pmtStreetAddr,
pmtCity, pmtState, pmtZipcode) VALUES
('5fde54a6-af9a-496e-955b-a7aaf9cce663', '1cb5b930-62ed-47f0-8a42-52c8f9ed0a2b',
'debit', '4532970356782245', '123', '12/25', '123 Elm Street', 'Springfield', 'IL',
'62701'),
('710a95b5-dac9-41f3-ad38-bbf5dde1c38f', '56669135-539c-4993-911a-736f9b237916',
'debit', '6011592898763443', '456', '06/26', '456 Maple Ave', 'Anytown', 'CA',
'90210'),
('a8e3fed5-9411-4b2c-81ec-034b024a77cc', 'e8368d90-94ff-47c4-9f9b-428b1b456d85',
'debit', '371449635398431', '789', '09/27', '512 S 3rd St', 'Champaign', 'IL',
'61820');
INSERT INTO chat VALUES
('0e8c29f9-4176-48dd-b231-19419005451a', true, current_timestamp),
('a26cdfb4-112b-4654-9ef5-80b5bfbbeff2', true, (current_timestamp - interval '1'
day)),
('84ec9373-79f9-4477-b8fe-7f37f9afd83a', false, (current_timestamp - interval '7'
month)),
('2ac5ea0f-bc55-4d0a-8112-63926079cb40', true, (current_timestamp - interval '1'
day)),
('5b93b3a3-f1fe-459a-9451-de9677852d10', true, (current_timestamp - interval '1'
day));
INSERT INTO participatesIn(actID, chatID, startDate) VALUES
('072cb76c-8ca0-43f2-a515-8418d1931193', /* Katy */
'0e8c29f9-4176-48dd-b231-19419005451a', (current_timestamp - interval '10' day)),
('f1b21a51-c213-4e83-bc50-b821f317bea4', /* Berry */
'0e8c29f9-4176-48dd-b231-19419005451a', (current_timestamp - interval '10' day)),
('072cb76c-8ca0-43f2-a515-8418d1931193', /* Katy */
'a26cdfb4-112b-4654-9ef5-80b5bfbbeff2', (current_timestamp - interval '3' day)),
('c00605f5-dc5e-41df-83e3-36e4f6427284', /* Max */
'a26cdfb4-112b-4654-9ef5-80b5bfbbeff2', (current_timestamp - interval '3' day)),
('f1b21a51-c213-4e83-bc50-b821f317bea4', /* Berry */
'84ec9373-79f9-4477-b8fe-7f37f9afd83a', (current_timestamp - interval '5' month -
interval '30' day)),
('c00605f5-dc5e-41df-83e3-36e4f6427284', /* Max */
'84ec9373-79f9-4477-b8fe-7f37f9afd83a', (current_timestamp - interval '5' month -
interval '30' day)),
('072cb76c-8ca0-43f2-a515-8418d1931193', /* Katy */
'2ac5ea0f-bc55-4d0a-8112-63926079cb40', (current_timestamp - interval '3' minute)),
('d7165614-5e9c-4d7c-9003-102dd83545ce', /* Amanda */
'2ac5ea0f-bc55-4d0a-8112-63926079cb40', (current_timestamp - interval '3' minute)),
('c00605f5-dc5e-41df-83e3-36e4f6427284', /* Max */
'5b93b3a3-f1fe-459a-9451-de9677852d10', (current_timestamp - interval '7' month -
interval '30' day)),
('d7165614-5e9c-4d7c-9003-102dd83545ce', /* Amanda */
'5b93b3a3-f1fe-459a-9451-de9677852d10', (current_timestamp - interval '7' month -
interval '30' day));
INSERT INTO matches VALUES
('072cb76c-8ca0-43f2-a515-8418d1931193', /* Katy */
'f1b21a51-c213-4e83-bc50-b821f317bea4', /* Berry */
current_timestamp - interval '10' day,
8.433218, 'accept', 'accept'),
('072cb76c-8ca0-43f2-a515-8418d1931193', /* Katy */
'c00605f5-dc5e-41df-83e3-36e4f6427284', /* Max */
current_timestamp - interval '3' day,
4.389701, 'accept', 'accept'),
('c00605f5-dc5e-41df-83e3-36e4f6427284', /* Max */
'f1b21a51-c213-4e83-bc50-b821f317bea4', /* Berry */
current_timestamp - interval '5' month - interval '30' day,
7.845243, 'accept', 'accept'),
('072cb76c-8ca0-43f2-a515-8418d1931193', /* Katy */
'd7165614-5e9c-4d7c-9003-102dd83545ce', /* Amanda */
current_timestamp - interval '3' minute,
9.826543, 'accept', 'accept'),
('c00605f5-dc5e-41df-83e3-36e4f6427284', /* Max */
'd7165614-5e9c-4d7c-9003-102dd83545ce', /* Amanda */
current_timestamp - interval '7' month - interval '30' day,
3.213907, 'accept', 'accept'),
('4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'd7165614-5e9c-4d7c-9003-102dd83545ce', /* Amanda */
current_timestamp - interval '8' day,
2.608476, 'accept', 'reject'),
('4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'c00605f5-dc5e-41df-83e3-36e4f6427284', /* Max */
current_timestamp - interval '2' month,
3.901824, 'reject', 'unseen');
INSERT INTO event VALUES
('5b13ed06-e18e-4cd3-a29a-5315d1a78147',
'Group Activity',
current_timestamp + interval '14' day,
current_timestamp + interval '14' day + interval '2' hour,
'Twilight Book Club!',
'Come enjoy wine and baked goods as we discuss the Twilight trilogy',
point(41.93776,-87.66006), 100,
'4a7536a1-3782-451b-a889-ecc18e6b7fb3'),
('e91b9519-ab8a-4d00-8f4a-b6086e9c9b7e',
'Game',
current_timestamp + interval '7' day,
current_timestamp + interval '7' day + interval '6' hour,
'Chess Tournament',
'Players of all levels are welcome! $100 grand prize for the 1st place winner.',
point(28.288404259380975,-80.61084415798224), 40,
'f1b21a51-c213-4e83-bc50-b821f317bea4');
INSERT INTO eRSVP VALUES
('c00605f5-dc5e-41df-83e3-36e4f6427284', /* Max */
'e91b9519-ab8a-4d00-8f4a-b6086e9c9b7e', /* Chess Tournament */
'maybe',
current_timestamp - interval '1' day),
('d7165614-5e9c-4d7c-9003-102dd83545ce', /* Amanda */
'e91b9519-ab8a-4d00-8f4a-b6086e9c9b7e', /* Chess Tournament */
'yes',
current_timestamp - interval '20' hour),
('56131135-346e-46f2-84e3-1565178e1164', /* AzureDiamond */
'5b13ed06-e18e-4cd3-a29a-5315d1a78147', /* Book Club */
'yes',
current_timestamp - interval '7' hour),
('4a7536a1-3782-451b-a889-ecc18e6b7fb3', /* John */
'5b13ed06-e18e-4cd3-a29a-5315d1a78147', /* Book Club */
'no',
current_timestamp - interval '5' minute);
INSERT INTO message(mesText, mesDate, chatID, senderID) VALUES
('Hi Berry, are you going to the chess tournament?',
current_timestamp - interval '15' minute,
'0e8c29f9-4176-48dd-b231-19419005451a',
'072cb76c-8ca0-43f2-a515-8418d1931193' /* Katy */),
('I''m thinking about it. I''ll let you know later.',
current_timestamp - interval '5' minute,
'0e8c29f9-4176-48dd-b231-19419005451a',
'f1b21a51-c213-4e83-bc50-b821f317bea4' /* Berry */);
/* Drew's additions to tables */
INSERT INTO users(usrID, username, email, passwordHash, passwordSalt, MFAtoken)
VALUES
('6ecd2aaa-4d44-4b9e-990d-409773324c5b', 'toddy846', 'todd.hanks@gmail.com',
md5('ThePassword123'), md5(random()::text), md5(random()::text)),
('3aced7f0-c2e7-435a-916d-a0a8904389bb', 'LianaT24','liana.timmons24@gmail.com',
md5('randopass'), md5(random()::text), md5(random()::text)),
('829ebcd5-d57f-434d-931b-aec167cf5c03', 'JayMorrow87', 'jason.morrow87@hotmail.com',
md5('helloworld'), md5(random()::text), md5(random()::text)) ,
('61c389ba-63fb-48b9-861b-fcbd8f77d710', 'Rivas12', 'marisol.rivas12@yahoo.com',
md5('awesomeepic'), md5(random()::text), md5(random()::text)),
('21bb1aa8-6dbf-4e14-ace7-01c4e8df2296', 'TyGuy5', 'tyler.caldwell45@aol.com',
md5('veryCoolsw@g'), md5(random()::text), md5(random()::text));
INSERT INTO account VALUES
( '40d2f395-88b0-48d7-b291-a71e28f6b16f',
'Yo its Todd!!!',
'Todd', 'Hanks', '4320 Vesta Drive', 'Chicago', 'IL',
point(41.929520,-87.548576), '6ecd2aaa-4d44-4b9e-990d-409773324c5b'
),
( '3542a953-f5b5-4e4c-9de2-06f67985caf4',
'Excited to get to meet some new people!',
'Liana', 'Timmons', '2824 Sand Fork Road', 'Galveston', 'IN',
point(40.588402, -86.200150), '3aced7f0-c2e7-435a-916d-a0a8904389bb'
),
(
'a72c26d1-d294-4a69-812c-7db5d319299e',
'hi, i''m Jay!',
'Jay', 'M', '4136 Oakmound Drive', 'Chicago', 'IL',
point(41.896301,-87.642776), '829ebcd5-d57f-434d-931b-aec167cf5c03'
),
(
'65523ca9-4f42-41fc-a8e1-84863ce8fa43',
NULL,
'Marisol', NULL, '342 Rosemont Avenue', 'Cocoa Beach', 'FL',
point(28.282207,-80.633247), '61c389ba-63fb-48b9-861b-fcbd8f77d710'
),
(
'33d4d3ac-576c-4d11-85b1-bbb9ebaa38e6',
'fun fact about me is that I''ve broken every bone in my body',
'Tyler', 'Caldwell', '3454 Perine Street', 'Arlington', 'VA',
point(38.838612,-77.044670), '21bb1aa8-6dbf-4e14-ace7-01c4e8df2296'
);
INSERT INTO accountInterests(actID, interest) VALUES
('40d2f395-88b0-48d7-b291-a71e28f6b16f', 'Mortal Kombat'),
('3542a953-f5b5-4e4c-9de2-06f67985caf4', 'Snooker'),
('a72c26d1-d294-4a69-812c-7db5d319299e', 'Surfboarding'),
('65523ca9-4f42-41fc-a8e1-84863ce8fa43', 'Roller Skating'),
('33d4d3ac-576c-4d11-85b1-bbb9ebaa38e6', 'Tennis');
INSERT INTO accountPhotos(actID, photo) VALUES
('40d2f395-88b0-48d7-b291-a71e28f6b16f',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
827fec18-e3a5-472f-b8d8-f2c42336e91f.jpg'),
('3542a953-f5b5-4e4c-9de2-06f67985caf4',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
28bba5ab-6982-442b-a627-fe23d7c9109c.jpg'),
('a72c26d1-d294-4a69-812c-7db5d319299e',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
394aba0d-0b28-4ffb-a198-8a6cb9e2023f.jpg'),
('65523ca9-4f42-41fc-a8e1-84863ce8fa43',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
4951712d-7521-4e4e-b11a-236c08b6d738.jpg'),
('33d4d3ac-576c-4d11-85b1-bbb9ebaa38e6',
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
1a4bfedc-9b81-450b-a28c-0e2a88e02f4b.jpg');
INSERT INTO chat VALUES
('7753c633-e6e4-4ce0-ac72-5e10a0973c58', true, (current_timestamp - interval '1'
day)),
('3f9cbcd0-be29-421b-bddd-22f9ff9adac3', true, (current_timestamp - interval '7'
day)),
('b4f26983-f368-451e-9f73-9860d858e32d', false, (current_timestamp - interval '6'
month - interval '20' day)),
('3f00a86e-9be1-4904-abb8-036566cc5931', true, NULL);
/* New chat with no messages */
INSERT INTO participatesIn(actID, chatID, startDate) VALUES
(
'40d2f395-88b0-48d7-b291-a71e28f6b16f', -- Todd
'7753c633-e6e4-4ce0-ac72-5e10a0973c58', -- w/ Jay
(current_timestamp - interval '1' day)
),
(
'3542a953-f5b5-4e4c-9de2-06f67985caf4', -- Liana to Marisol
'3f9cbcd0-be29-421b-bddd-22f9ff9adac3',
(current_timestamp - interval '7' day)
),
(
'a72c26d1-d294-4a69-812c-7db5d319299e', -- Jay
'7753c633-e6e4-4ce0-ac72-5e10a0973c58', -- w/ Todd
(current_timestamp - interval '1' day)
INSERT INTO message(mesText, mesDate, chatID, senderID) VALUES
),
(
),
(
);
(
'65523ca9-4f42-41fc-a8e1-84863ce8fa43', -- Marisol to Liana
'3f9cbcd0-be29-421b-bddd-22f9ff9adac3',
(current_timestamp - interval '7' day)
'33d4d3ac-576c-4d11-85b1-bbb9ebaa38e6', -- Tyler
'3f00a86e-9be1-4904-abb8-036566cc5931',
(NULL)
'Hey Jay! Whats up?',
current_timestamp - interval '1' day - interval '15' minute,
'7753c633-e6e4-4ce0-ac72-5e10a0973c58',
'40d2f395-88b0-48d7-b291-a71e28f6b16f' /* Todd to Jay */
),
(
'Yo Todd! I''m good how are you bro?..',
current_timestamp - interval '1' day,
'7753c633-e6e4-4ce0-ac72-5e10a0973c58',
'a72c26d1-d294-4a69-812c-7db5d319299e' /* Jay to Todd*/
),
(
),
(
'Just living it up in Chicago! What are your hobbies?',
current_timestamp - interval '1' day,
'7753c633-e6e4-4ce0-ac72-5e10a0973c58',
'40d2f395-88b0-48d7-b291-a71e28f6b16f' /* Todd to Jay*/
'So I see your from Florida! Hows the weather?',
current_timestamp - interval '7' day - interval '12' hour,
'3f9cbcd0-be29-421b-bddd-22f9ff9adac3',
'3542a953-f5b5-4e4c-9de2-06f67985caf4' /* Liana to Marisol */
),
(
'Super humid so far this season!',
current_timestamp - interval '6' day,
'3f9cbcd0-be29-421b-bddd-22f9ff9adac3',
'65523ca9-4f42-41fc-a8e1-84863ce8fa43' /* Marisol to Liana*/
);
(
INSERT INTO event VALUES
'41024d3c-bca4-4020-b700-42bcd481f018',
'Game',
current_timestamp + interval '5' day,
current_timestamp + interval '5' day + interval '4' hour,
'Mortal Kombat Tournament',
'Join us for an epic Mortal Kombat tournament happening right here at Emporium
Arcade Bar!
Prepare to unleash your best combos, fatalities, and fighting skills against the
fiercest competitors in town.',
point(41.906658,-87.671860), 50,
'40d2f395-88b0-48d7-b291-a71e28f6b16f' /* Todd */
);
(
INSERT INTO eRSVP VALUES
'a72c26d1-d294-4a69-812c-7db5d319299e', /* Jay */
'41024d3c-bca4-4020-b700-42bcd481f018', /* MK tourney */
'yes',
current_timestamp - interval '1' day
),
(
'65523ca9-4f42-41fc-a8e1-84863ce8fa43', /* Marisol */
'85067bd4-11fb-4fcb-b1e7-b3883088f90c', /* Alligator wrestlikng */
'maybe',
current_timestamp - interval '20' hour
),
(
'40d2f395-88b0-48d7-b291-a71e28f6b16f', /* Todd */
'17170cd3-1bfa-4809-9816-28503c9986fe', /* Cuneen's game night */
'yes',
current_timestamp - interval '2' hour
);
(
INSERT INTO subscription VALUES
'4d39e47b-b878-49f9-b958-493aebbb4a18',
'Bestie for Life', 49.99, 0.00,
'2024-11-10 16:39:00', true,
'6ecd2aaa-4d44-4b9e-990d-409773324c5b' /* Todd */
),
(
'b307e71b-bbe4-4055-b488-d01ab711a5bd',
'Premium', 9.99, 0.00,
'2025-2-20 16:39:00', true,
'829ebcd5-d57f-434d-931b-aec167cf5c03' /* Jay */
);
INSERT INTO subscription(subID, subTier, userID) VALUES
('8b9e57d7-2415-4ce6-809e-cdea98b877ac', 'Free',
'61c389ba-63fb-48b9-861b-fcbd8f77d710'), /* Marisol */
('df3d6cc7-fde9-4b10-857f-c7e7d6f87fe3', 'Free',
'3aced7f0-c2e7-435a-916d-a0a8904389bb'), /* Liana */
('711833fc-d69e-42a0-a494-fca38ec97fad', 'Free',
'21bb1aa8-6dbf-4e14-ace7-01c4e8df2296'); /* Tyler */
INSERT INTO paymentMethod(pmtID, subID, pmtType, num, cvv, expiration, pmtStreetAddr,
pmtCity, pmtState, pmtZipcode) VALUES
('5da4e5a7-462d-4ec8-b241-a543ee978cd6', '4d39e47b-b878-49f9-b958-493aebbb4a18',
'debit', 4798315489743516, 456, '11/04', '4320 Vesta Drive', 'Chicago', 'IL',
'60656'), /*Todd */
('1a4b7f9f-9b7d-4699-96cd-8c9e2d6e2d75', 'b307e71b-bbe4-4055-b488-d01ab711a5bd',
'debit', 9874654386546348, 795, '10/10', '4136 Oakmound Drive', 'Chicago', 'IL',
'60651'); /* Jay */
INSERT INTO matches VALUES
(
    '40d2f395-88b0-48d7-b291-a71e28f6b16f', /* Todd */
    'a72c26d1-d294-4a69-812c-7db5d319299e', /* Jay */
    current_timestamp - interval '2' day,
    9.5853262, 'accept', 'accept'
),
(
'40d2f395-88b0-48d7-b291-a71e28f6b16f', /* Todd */
'33d4d3ac-576c-4d11-85b1-bbb9ebaa38e6', /* Tyler */
current_timestamp - interval '10' day,
6.617823, 'accept', 'unseen'
),
(
'a72c26d1-d294-4a69-812c-7db5d319299e', /* Jay */
'3542a953-f5b5-4e4c-9de2-06f67985caf4', /* Liana */
current_timestamp - interval '6' month,
7.61125604, 'accept', 'accept'
),
(
'40d2f395-88b0-48d7-b291-a71e28f6b16f', /* Todd */
'257d8621-2e49-442b-96c2-605a651a996d', /* Ann */
current_timestamp - interval '1' month,
3.161310, 'reject', 'reject'
),
(
'65523ca9-4f42-41fc-a8e1-84863ce8fa43', /* Marisol */
'3542a953-f5b5-4e4c-9de2-06f67985caf4', /* Liana */
current_timestamp - interval '3' day,
3.1986971, 'unseen', 'unseen'
),
(
'33d4d3ac-576c-4d11-85b1-bbb9ebaa38e6', /* Tyler */
'65523ca9-4f42-41fc-a8e1-84863ce8fa43', /* Marsiol */
current_timestamp - interval '1' minute,
3.124879, 'unseen', 'reject'
);
/* Fiona's additions to tables */
INSERT INTO users(usrID, username, email, passwordHash, passwordSalt, MFAtoken) VALUES
('1c9ab10a-c70f-4209-a64d-c8019a23aac6', 'wmaximoff', 'wmaximoff3@gmail.com',
md5('magic5'), md5(random()::text),md5(random()::text)),
('8f465290-e54b-452b-b981-cbf92a6cf2d1', 'vision', 'vision@yahoo.com',
md5('ihateultron2'), md5(random()::text), md5(random()::text)),
('3db2bb9a-2418-4258-bbc4-c7ea32b39570', 'emmafrost', 'emma1frost@aol.com',
md5('snowflake12'), md5(random()::text), md5(random()::text)),
('3ecd3feb-6076-4ec3-b3ce-87daa077a4b3', 'eriklensherr', 'magneto@gmail.com',
md5('notthevillain3'), md5(random()::text), md5(random()::text)),
('328ee807-7686-4e08-83cc-0b3d9c111e9b', 'steverogers', 'capamerica@aol.com',
md5('1stAvenger'), md5(random()::text), md5(random()::text));
INSERT INTO account VALUES
(
'8f11b297-0e06-4d8e-ac29-11b3818c6375',
' Hi I am Wanda Maximoff and I love magic the gathering',
'Wanda', 'Maximoff', '1032 W. Sheridan Rd', 'Chicago', 'IL',
point(41.998604, -87.657699), '1c9ab10a-c70f-4209-a64d-c8019a23aac6'
),
(
'0090798d-60f8-483c-9516-b4ebe4bd55d3',
' Hi I am Vision and interested in advanced technology '
,
'Vision', NULL, '6430 N. Kenmore Ave', 'Chicago', 'IL',
point(41.999172, -87.657213), '8f465290-e54b-452b-b981-cbf92a6cf2d1'
),
(
'fe6a275d-03d5-465f-8748-69ad732e3f7b',
' Hi I am Emma Frost and winter is my favorite season '
,
'Emma', 'Frost', '202 Sycamore St', 'Galveston', 'IN',
point(40.577760, -86.187590), '3db2bb9a-2418-4258-bbc4-c7ea32b39570'
),
(
'e431e4b0-9a77-4ac6-b4ab-0931fedc8a75',
' Hi I am Erik Lensherr and I like discussing the marvels of mutation',
'Erik', 'Lensherr', '429 S California St', 'Galveston', 'IN',
point(40.573639, -86.186236), '3ecd3feb-6076-4ec3-b3ce-87daa077a4b3'
),
(
'611eb7a5-1bab-4eea-8107-949d17e7f02e',
' Hi I am Steve Rogers and looking make strong friendships',
'Steve', 'Rogers', '2080 N Atlantic Ave', 'Cocoa Beach', 'FL',
point(28.343305, -80.607015), '328ee807-7686-4e08-83cc-0b3d9c111e9b'
);
INSERT INTO accountInterests(actID, interest) VALUES
('8f11b297-0e06-4d8e-ac29-11b3818c6375','Games'), /*wanda*/
('0090798d-60f8-483c-9516-b4ebe4bd55d3','Card Games'), /*vision*/
('fe6a275d-03d5-465f-8748-69ad732e3f7b','Going Hiking'), /*emma*/
('fe6a275d-03d5-465f-8748-69ad732e3f7b','listen to music'), /*emma*/
('e431e4b0-9a77-4ac6-b4ab-0931fedc8a75','listening to music'), /*erik*/
('611eb7a5-1bab-4eea-8107-949d17e7f02e','Running Marathons'); /*steve */
INSERT INTO accountPhotos(actID, photo) VALUES
( '8f11b297-0e06-4d8e-ac29-11b3818c6375', /*wanda*/
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
583322f1-717b-4729-8d7a-e145e2c013c1.jpg'
),
( '0090798d-60f8-483c-9516-b4ebe4bd55d3', /*vision*/
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
97e5aee6-bb15-472c-a291-78a8c6215334.jpg'
),
( 'fe6a275d-03d5-465f-8748-69ad732e3f7b', /*emma*/
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
56fe7bd4-363f-4b11-bcaf-d31d86a0a74c.jpg'
),
( 'e431e4b0-9a77-4ac6-b4ab-0931fedc8a75', /*erik*/
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
9369fa02-ea4b-4bc7-a149-d05aee621395.jpg'
( '611eb7a5-1bab-4eea-8107-949d17e7f02e', /*steve*/
'https://s3.amazonaws.com/cdn.fridating.org/account-img/
28e084d2-04c2-47a6-9d6e-dd7ed191d0bf.jpg'
),
);
INSERT INTO chat VALUES
('14fd47ff-2fa2-4d08-8283-600e077af006', true, current_timestamp),
('6c578b7d-73fa-40d8-a171-dc25dddb331d', true, current_timestamp - interval '4' day),
('3528e995-bda2-4eeb-b012-6274f3d3f6b3', true, current_timestamp - interval '2' day);
INSERT INTO participatesIn(actID, chatID, startDate) VALUES
(
'8f11b297-0e06-4d8e-ac29-11b3818c6375',/*wanda*/
'14fd47ff-2fa2-4d08-8283-600e077af006',
(current_timestamp - interval '1' day)
),
(
'0090798d-60f8-483c-9516-b4ebe4bd55d3',/*vision*/
'14fd47ff-2fa2-4d08-8283-600e077af006',
(current_timestamp - interval '1' day)
),
(
'e431e4b0-9a77-4ac6-b4ab-0931fedc8a75',/*erik*/
'6c578b7d-73fa-40d8-a171-dc25dddb331d',
(current_timestamp - interval '4' day)
),
(
'fe6a275d-03d5-465f-8748-69ad732e3f7b',/*emma */
'6c578b7d-73fa-40d8-a171-dc25dddb331d',
(current_timestamp - interval '4' day)
),
(
'611eb7a5-1bab-4eea-8107-949d17e7f02e', /*steve*/
'3528e995-bda2-4eeb-b012-6274f3d3f6b3',
(current_timestamp - interval '2' day)
),
(
'65523ca9-4f42-41fc-a8e1-84863ce8fa43', /*marisol*/
'3528e995-bda2-4eeb-b012-6274f3d3f6b3',
(current_timestamp - interval '2' day)
);
INSERT INTO message(mesText, mesDate, chatID, senderID) VALUES
(
'Hi Vision! Do you play Magic the Gathering ?',
current_timestamp - interval '1' day - interval '5' minute,
'14fd47ff-2fa2-4d08-8283-600e077af006',
'8f11b297-0e06-4d8e-ac29-11b3818c6375' /*Wanda */
),
(
'What is up Wanda! Ya! I just got the new duskmourn deck.',
current_timestamp - interval '1' day - interval '10' minute,
'14fd47ff-2fa2-4d08-8283-600e077af006',
'0090798d-60f8-483c-9516-b4ebe4bd55d3' /*Vision*/
),
(
'Hi Emma, what is your favorite music genre ? '
,
current_timestamp - interval '4' day - interval '15' minute,
'6c578b7d-73fa-40d8-a171-dc25dddb331d',
'e431e4b0-9a77-4ac6-b4ab-0931fedc8a75' /*erik*/
),
(
'Hi Erik, I love alternative pop music? '
,
current_timestamp - interval '4' day - interval '30' minute,
'6c578b7d-73fa-40d8-a171-dc25dddb331d',
'fe6a275d-03d5-465f-8748-69ad732e3f7b' /*emma*/
),
(
'Hi Marisol, do you like running ?',
current_timestamp - interval '2' day - interval '5' minute,
'3528e995-bda2-4eeb-b012-6274f3d3f6b3',
'611eb7a5-1bab-4eea-8107-949d17e7f02e' /*steve*/
),
(
'Yes! I just finished the Chicago Marathon and hoping to run in New York
next year.',
current_timestamp - interval '2' day - interval '15' minute,
'3528e995-bda2-4eeb-b012-6274f3d3f6b3',
'65523ca9-4f42-41fc-a8e1-84863ce8fa43' /*marisol*/
);
(
INSERT INTO eRSVP VALUES
'8f11b297-0e06-4d8e-ac29-11b3818c6375', /*Wanda */
'17170cd3-1bfa-4809-9816-28503c9986fe', /* Board Games @ Cuneen's */
'yes',
current_timestamp - interval '1' day
),
(
'0090798d-60f8-483c-9516-b4ebe4bd55d3', /*Vision*/
'17170cd3-1bfa-4809-9816-28503c9986fe', /* Board Games @ Cuneen's */
'yes',
current_timestamp - interval '1' day
),
(
'611eb7a5-1bab-4eea-8107-949d17e7f02e', /*steve*/
'85067bd4-11fb-4fcb-b1e7-b3883088f90c', /* alligator wrestling */
'yes',
current_timestamp - interval '4' day
);
(
INSERT INTO subscription VALUES
'aa8225c4-48f4-4012-bc78-579c0897d710',
'Bestie for Life', 49.99, 0.00,
'2024-11-10 16:00:00', true,
'328ee807-7686-4e08-83cc-0b3d9c111e9b' /*steve*/
);
INSERT INTO subscription(subTier, userID) VALUES
('Free', '1c9ab10a-c70f-4209-a64d-c8019a23aac6'),
('Free', '8f465290-e54b-452b-b981-cbf92a6cf2d1'),
('Free', '3db2bb9a-2418-4258-bbc4-c7ea32b39570');
INSERT INTO paymentMethod(pmtID, subID, pmtType, PayPal) VALUES
(
'4468551d-ffe8-4eca-adcd-1f7392ca82ec', 'aa8225c4-48f4-4012-bc78-579c0897d710',
'thirdParty', '6L5HzqBxpa73VTqSjfipb8u0NKRgwbTe'
);
INSERT INTO matches VALUES
(
'8f11b297-0e06-4d8e-ac29-11b3818c6375',/*wanda*/
'0090798d-60f8-483c-9516-b4ebe4bd55d3',/*vision*/
current_timestamp - interval '1' day,
9.300956, 'accept', 'accept'
),
(
'8f11b297-0e06-4d8e-ac29-11b3818c6375',/*wanda*/
'611eb7a5-1bab-4eea-8107-949d17e7f02e', /*steve*/
current_timestamp - interval '2' day,
4.776183, 'accept', 'reject'
),
(
'e431e4b0-9a77-4ac6-b4ab-0931fedc8a75',/*erik*/
'fe6a275d-03d5-465f-8748-69ad732e3f7b',/*emma */
current_timestamp - interval '4' day,
9.708713, 'accept', 'accept'
),
(
'e431e4b0-9a77-4ac6-b4ab-0931fedc8a75',/*erik*/
'611eb7a5-1bab-4eea-8107-949d17e7f02e', /*steve*/
current_timestamp - interval '4' day,
3.645354, 'unseen', 'unseen'
),
(
'611eb7a5-1bab-4eea-8107-949d17e7f02e', /*steve*/
'65523ca9-4f42-41fc-a8e1-84863ce8fa43', /*marisol*/
current_timestamp - interval '2' day,
8.502177, 'accept', 'accept'
);