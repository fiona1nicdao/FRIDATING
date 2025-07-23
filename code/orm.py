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

## to be continued 
