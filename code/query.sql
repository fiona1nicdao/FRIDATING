/* Fiona’s query */
/* AttendanceForFutureEvents: For each event count the number of accounts
who RSVP with a response of 'yes' and the state the account is located at
and date of the events is in the future. */
SELECT E.evtID, E.evtName, E.evtDateStart, A.actState, count(R.response)
FROM Event E, eRSVP R, Account A
WHERE R.response = 'yes' and E.evtID = R.evtID and A.actID = R.actID
GROUP BY E.evtID, A.actState
ORDER BY evtDateStart asc;

/* Hannah's query */
/* bestieForLifeActiveChatCount: For each user with the 'Bestie for Life'
subscription tier, print the total number of chats that have an active
status. */
select A.userID, U.username, count(DISTINCT P.chatID) as activeChatCount
from account A, chat C, participatesIn P, subscription S, users U
where A.actID = P.actID and
C.chatID = P.chatID and
A.userID = U.usrID and
S.subTier = 'Bestie for Life'
group by A.userID, U.username
order by activeChatCount desc;

/* Josh's query */
/* msgStatsForEmailDomains: Shows sending statistics for messages based on
the email domain that is associated with each user’s accounts, including
the total number of messages sent, the oldest message date, and newest
message date. Useful for spam moderation. */
SELECT
split_part(users.email, '@', 2) AS emailDomain,
count(*) AS countDomainMsgs,
min(msg.mesDate) AS oldestDomainMsg,
max(msg.mesDate) AS newestDomainMsg
FROM users, account, message msg
WHERE
account.userID=users.usrID and
msg.senderID=account.actID
GROUP BY(emailDomain)
ORDER BY(countDomainMsgs) desc;

/* Drew's query */
/* paidSubscriptionLocationCount: For each user with a paid subscription,
get the count per each sub tier by location and also by payment method. */
select A.actCity, S.subtier, count(S.subID) as subscription_count,
P.pmtType
from paymentMethod P, account A, subscription S
where S.userID = A.userID and
S.subID = P.subID
group by S.subTier, A.actCity, P.pmtType
order by A.actCity asc, subscription_count desc;