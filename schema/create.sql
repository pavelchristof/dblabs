create table Files (
  id int primary key,
  path varchar(1024) unique not null
);

create table Declarations (
  id int primary key,
  file int references Files(id)
);

create table Types (
  id int primary key references Declarations(id),
  name varchar(1024) unique not null
);

create table Values (
  id int primary key references Declarations(id),
  name varchar(1024) unique not null
);

-- Types.

create table Primitives (
  id int primary key references Types(id)
);

create table Classes (
  id int primary key references Types(id),
  isStruct bool not null
);

create table Enumerations (
  id int primary key references Types(id)
);

-- Values.

create table Enumerators (
  id int primary key references Values(id),
  enum int unique not null references Enumerations(id)
);

create table Functions (
  id int primary key references Values(id),
  class int references Classes(id),
  returnType int not null references Types(id)
);

create table Arguments (
  func int references Functions(id),
  index int,
  type int not null references Types(id),
  primary key (func, index)
);

create table Variables (
  id int primary key references Values(id),
  type int not null references Types(id)
);

-- Relations.

create table Inherits (
  parent int references Classes(id),
  child int references Classes(id),
  primary key (parent, child)
);

create table Calls (
  caller int references Functions(id),
  callee int references Functions(id),
  primary key (caller, callee)
);

create table Reads (
  func int references Functions(id),
  var int references Variables(id),
  primary key (func, var)
);

create table Writes (
  func int references Functions(id),
  var int references Variables(id),
  primary key (func, var)
);
