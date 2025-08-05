from typing import List
from typing import Optional
from sqlalchemy import ForeignKey
from sqlalchemy import String, Integer, Numeric, DateTime, Enum, Float, func
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped
column
_
from sqlalchemy.orm import relationship
from sqlalchemy import create
engine
_
from sqlalchemy.orm import Session
from sqlalchemy import select
from sqlalchemy.dialects.postgresql import UUID
import uuid
import datetime
import enum
import pdb
# IMPORTANT! IMPORTANT! IMPORTANT!
# Change this to TRUE if you want to attempt to write data to the db!
actuallyWriteDataToTheDatabase = False
# IMPORTANT! IMPORTANT! IMPORTANT!
# Database connection
engine = create 
engine("postgresql+psycopg2://jhonig:pfLqVAkQEppPWdo7EaGzUvMJNdHPjX2t@localhost:8080/FRIDATING-dev2")
session = Session(engine)
class Base(DeclarativeBase):
    pass
# Class created by Drew; Defining User class/table
class Users(Base):
    __tablename__= "users"
    usrid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True),
    default=uuid.uuid4, primary_key=True)
    username: Mapped[str] = mapped_column(String(32))
    email: Mapped[str] = mapped_column(String(96))
    passwordhash: Mapped[str] = mapped_column(String(256))
    passwordsalt: Mapped[str] = mapped_column(String(256))
    mfatoken: Mapped[str] = mapped_column(String(64))
    subscription: Mapped[List["Subscription"]] = relationship("Subscription",back_populates="user")

def __repr__(self) -> str:
    return f"User(id={self.userID!r}, username={self.username!r},email={self.email!r})"
# Class created by Josh; define Subscription table
class Subscription(Base):
    __tablename__= "subscription"
subid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), default=uuid.uuid4, primary_key=True)
subtier: Mapped[str] = mapped_column(String(64))
subprice: Mapped[Numeric] = mapped_column(Numeric, nullable=True)
outstandingbalance: Mapped[Numeric] = mapped_column(Numeric, nullable=True)
nextduedate: Mapped[datetime] = mapped_column(DateTime(timezone=False),
nullable=True) # https://stackoverflow.com/a/75364468/11467212
annualbilling: Mapped[Optional[bool]] # Since bool is a native python type,sqlalchemy will figure this out # https://stackoverflow.com/a/76499049/11467212
userid: Mapped[uuid.UUID] = mapped_column(ForeignKey("users.usrid"))

paymentmethods: Mapped[List["paymentmethod"]] = relationship(back_populates="subscription", cascade="all, delete-orphan")
user: Mapped["Users"] = relationship(back_populates="subscription")

def __repr__(self) -> str:
    return f"""Subscription(
        id={self.subid!r}, subtier={self.subtier!r},
        subprice={self.subprince!r}, nextduedate={self.nextduedate!r},
        annualbilling={self.annualbilling!r}, userid={self.userid!r}
    )"""
# Class created by Josh; defines enum for use in paymnetmethod
class payment_type(enum.Enum):
    credit = 'credit'
    debit = 'debit'
    thirdParty = 'thirdParty'
# Class created by Josh; define paymentmethod table
class paymentmethod(Base):
    __tablename__= "paymentmethod"
    pmtid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True),
                                             default=uuid.uuid4, primarykey=True)
    subid: Mapped[uuid.UUID] = mapped_column(ForeignKey("subscription.subid"))
    pmttype = mapped_column(Enum(payment_type))
    num: Mapped[Numeric] = mapped_column(Numeric, nullable=True)
    cvv: Mapped[Numeric] = mapped_column(Numeric, nullable=True)
    expiration: Mapped[str] = mapped_column(String(16), nullable=True)
    pmtstreetaddr: Mapped[str] = mapped_column(String(128), nullable=True)
    pmtcity: Mapped[str] = mapped_column(String(64), nullable=True)
    pmtstate: Mapped[str] = mapped_column(String(64), nullable=True)
    pmtzipcode: Mapped[str] = mapped_column(String(64), nullable=True)
    androidpay: Mapped[str] = mapped_column(String(128), nullable=True)
    applepay: Mapped[str] = mapped_column(String(128), nullable=True)
    paypal: Mapped[str] = mapped_column(String(128), nullable=True)
    subscription: Mapped["Subscription"] =relationship(back_populates="paymentmethods")

    def __repr__(self) -> str:
        return f"""paymentMethod(
            pmtid={self.pmtid!r}, subid={self.subid!r},
            pmtType={self.pmttype!r}, num={self.num!r}, cvv={self.cvv!r}, expiration={self.expiration!r}, pmtstreetaddr={self.pmtstreetaddr!r}, pmtcity={self.pmtcity!r}, pmtstate={self.pmtstate!r}, pmtzipcode={self.pmtzipcode!r}, androidpay={self.androidpay!r}, applepay={self.applepay!r},paypal={self.paypal!r})"""
# Classes created by Hannah
class Account(Base):
    __tablename__= "account"
    actid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), default=uuid.uuid4, primary_key=True)
    bio: Mapped[str] = mapped_column(String(300))
    firstname: Mapped[str] = mapped_column(String(32), nullable=False)
    lastname: Mapped[str] = mapped_column(String(32))
    actstreetaddress: Mapped[str] = mapped_column(String(128), nullable=False)
    actcity: Mapped[str] = mapped_column(String(64), nullable=False)
    actstate: Mapped[str] = mapped_column(String(64), nullable=False)
    #actlocgps_x: Mapped[float] = mapped_column(Float, nullable=False) #
    # Longitude or x-coordinate
    #actlocgps_y: Mapped[float] = mapped_column(Float, nullable=False) #
    #Latitude or y-coordinate
    userid: Mapped[str] = mapped_column(Integer, ForeignKey("users.usrid"),nullable=False)
    participates_in: Mapped["ParticipatesIn"] = relationship("ParticipatesIn",back_populates="account")
    
    def __repr__(self) -> str:
        return f"Account(id={self.actID!r}, firstName={self.firstname!r},lastName={self.lastname!r})"
# Class created by Hannah
class ParticipatesIn(Base):
    __tablename__ = "participatesin"
    actid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True),ForeignKey("account.actid", ondelete="CASCADE", onupdate="CASCADE"),primary_key=True)   
    chatid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True),ForeignKey("chat.chatid", ondelete="CASCADE", onupdate="CASCADE"),primary_key=True)
    startdate: Mapped[datetime] = mapped_column(DateTime(timezone=False),nullable=True)
    # Relationships
    account: Mapped["Account"] = relationship("Account",back_populates="participates_in")
    chat: Mapped["Chat"] = relationship("Chat", back_populates="participants")
    
    def __repr__ (self) -> str: return f"ParticipatesIn(actID={self.actid!r},chatID={self.chatid!r})"
    
# Classes created by Fiona & Hannah
class Chat(Base):
    __tablename__= "chat"
    chatid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True),default=uuid.uuid4, primary_key=True)
    chtisactive: Mapped[bool]
    chtlastmestimestamp: Mapped[datetime] = mapped_column(DateTime(timezone=False))
    # Relationships
    participants: Mapped["ParticipatesIn"] = relationship("ParticipatesIn",back_populates="chat")
    # reference to messages
    messages : Mapped[List["Message"]] = relationship(
        back_populates="chat", cascade="all, delete-orphan"
    )
    def __repr__(self) -> str: #represent the object as a string
        return f"Chat (id = {self.id!r}, chatIsActive{self.chtisactive!r},chtLastMesTimestamp{self.chtlastmestimestamp!r})"

# Class created by Fiona
class Message(Base):
    __tablename__= "message"
    mesid: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    mestext: Mapped[str] = mapped_column(String(200))
    mesdate : Mapped[datetime] = mapped_column(DateTime(timezone=True))
    chatid : Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True),ForeignKey("chat.chatid"))
    senderid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True),ForeignKey("account.actid"))
    chat : Mapped["Chat"] = relationship(back_populates="messages")
    def __repr__(self) -> str :
        return f"Message(id={self.id!r}), mesText={self.mestext!r},mesDate={self.mesdate!r}"
 
# Insert data - Josh
with Sessions(engine) as session:
    # Insert subscriptions
    subscription1 = Subscription(
        subid = uuid.UUID("ba2a5760-0ead-4988-b9cc-b2cc77cfcd34"),
        subtier = "Premium",
        subprice = 9.99,
        outstandingbalance = 0.00,
        nextduedate = datetime.datatime.now() + datatime.timedelta(days=6),
        annualbilling = False,
        userid = uuid.UUID("3db2bb9a-2418-4258-bbc4-c7ea32b39570")
    )
    subscription2 = Subscription(
        subid = uuid.UUID("ef7b5717-96f2-42b4-8bb2-23ae9172ff65"),
        subtier = "Bestie for Life",
        subprice = 49.99,
        outstandingbalance = 0.00,
        nextduedate = datetime.datetime.now() + datetime.timedelta(days=3) + datetime.timedelta(hours=5),
        annualbilling = False,
        userid = uuid.UUID("a87b4c9b-f164-4e4b-99a4-2d64f2212ca7")
    )
    if actuallyWriteDataToTheDatabase:
        session.add_all([subscription1, subscription2])
        session.commit()
    
    # Insert payment methods 
    pmtmethod1 = paymentmethod(
        subid = uuid.UUID("ba2a5760-0ead-4988-b9cc-b2cc77cfcd34"),
        pmttype = payment_type.thirdParty,
        paypal = "somePaypalPaymentAPIKeyGoesHere"
    )
    pmtmethod2 = paymentmethod(
        subid = uuid.UUID("ef7b5717-96f2-42b4-8bb2-23ae9172ff65"),
        pmttype = payment_type.credit,
        num = 4381946282957154,
        cvv = 123,
        expiration = "05/25",
        pmtstreetaddr = "1 N Oak St",
        pmtcity = "Anytown",
        pmtstate = "IL",
        pmtzipcode = "60601"
    )
    pmtmethod3 = paymentmethod(
        subid = uuid.UUID("ef7b5717-96f2-42b4-8bb2-23ae9172ff65"),
        pmttype = payment_type.credit,
        num = 6195016491745164,
        cvv = 321,
        expiration = "01/26",
        pmtstreetaddr = "405 S Railroad Ave",
        pmtcity = "Cornfieldia",
        pmtstate = "IN",
        pmtzipcode = "43052"
    )
    pmtmethod4 = paymentmethod(
        subid = uuid.UUID("ef7b5717-96f2-42b4-8bb2-23ae9172ff65"),
        pmttype = payment_type.credit,
        num = 1750161067181961,
        cvv = 159,
        expiration = "12/24",
        pmtstreetaddr = "8000 University Rd",
        pmtcity = "Lafayette",
        pmtstate = "IN",
        pmtzipcode = "47904"
    )
    if actuallyWriteDataToTheDatabase:
        session.add_all([pmtmethod1, pmtmethod2, pmtmethod3, pmtmethod4])
        session.commit()

# continue here : page 42
# Insert data - Drew 
with Session(engine) as session:
    user_1 = Users(
        usrid= uuid.UUID("4fc51a78-8d6c-4c64-9c68-a005558a0444"),
        username = "TrueB00L",
        email = "B00leanFreak45@aol.com",
        passwordhash = "kYf8npoLQB@",
        passwordsalt="o@a#&%JE@E1",
        mfatoken="MX%V6-Q3pQg",
        subscription=[Subscription(subtier="Free")]
    )