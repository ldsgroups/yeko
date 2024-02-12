-- SEED DATA

-- |>>>>>>> SEED ROLES <<<<<<<|
INSERT INTO "public"."roles" ("id","name","created_at","updated_at") VALUES 
(1,'Parent',NULL,NULL),
(2,'Teacher',NULL,NULL),
(3,'School',NULL,NULL),
(4,'Admin',NULL,NULL);

-- |>>>>>>> SEED STATES <<<<<<<|
INSERT INTO "public"."states" ("id","name","created_at","updated_at") VALUES 
(1,'Active',NULL,NULL),
(2,'Checking',NULL,NULL),
(3,'Suspended',NULL,NULL),
(4,'Deleted',NULL,NULL);

-- |>>>>>>> SEED CYCLES <<<<<<<|
INSERT INTO "public"."cycles" ("id","name","description","created_at","updated_at") VALUES 
('primary','Primary','Primary cycle',NULL,NULL),
('secondary','Secondary','Secondary cycle',NULL,NULL);

-- |>>>>>>> SEED SCHOOLS <<<<<<<|
INSERT INTO "public"."schools" ("id","state_id","cycle_id","is_technical_education","name","code","address","phone","email","created_at","updated_at") VALUES 
('cce1b0c4-87c4-4258-98d7-e5c23f555297',2,'secondary','FALSE','Collège ISPAM Adjoifou','010190',NULL,'0707070707','ispam@gmail.com','2024-01-05 05:17:13.322+00','2024-01-05 05:17:13.322+00'),
('ed85f4e4-5133-4270-b52d-795c6e65c0f0',1,'secondary','FALSE','College Celeste Adjoufou','877363','Adjoufou','0505050505','ecole_celeste@gmail.com','2024-01-05 05:17:13.318+00','2024-01-05 05:17:13.318+00');

-- |>>>>>>> SEED USERS <<<<<<<|
INSERT INTO "public"."users" ("id","role_id","state_id","school_id","email","created_at","updated_at") VALUES 
('a9def0e9-f0b1-4099-8bd6-34bfd6db10e8',1,1,NULL,'leevykouassi@mail.com','2024-01-05 05:17:13.295+00','2024-01-05 05:17:13.295+00'),
('7e0488e8-93d5-4a45-9fe5-62421b185f5f',1,1,'ed85f4e4-5133-4270-b52d-795c6e65c0f0','kassidarius@gmail.com','2024-01-05 05:17:13.233+00','2024-01-05 05:17:13.234+00');

-- |>>>>>>> SEED GRADES <<<<<<<|
INSERT INTO "public"."grades" ("id","cycle_id","name","description","created_at","updated_at") VALUES 
(1,'primary','CP1','First grade of primary cycle',NULL,NULL),
(2,'primary','CP2','Second grade of primary cycle',NULL,NULL),
(3,'primary','CE1','Third grade of primary cycle',NULL,NULL),
(4,'primary','CE2','Fourth grade of primary cycle',NULL,NULL),
(5,'primary','CM1','Fifth grade of primary cycle',NULL,NULL),
(6,'primary','CM2','Sixth grade of primary cycle',NULL,NULL),
(7,'secondary','6e','First grade of secondary cycle',NULL,NULL),
(8,'secondary','5e','Second grade of secondary cycle',NULL,NULL),
(9,'secondary','4e','Third grade of secondary cycle',NULL,NULL),
(10,'secondary','3e','Fourth grade of secondary cycle',NULL,NULL),
(11,'secondary','2nde','Fifth grade of secondary cycle',NULL,NULL),
(12,'secondary','1ere','Sixth grade of secondary cycle',NULL,NULL),
(13,'secondary','Tle','Seventh grade of secondary cycle',NULL,NULL);

-- |>>>>>>> SEED PARENTS <<<<<<<|
INSERT INTO "public"."parents" ("id","full_name","phone","email","created_at","updated_at") VALUES 
('906f1750-2821-4086-8c75-0418ed764838','Le parent de Darius et Marc','0506050403','darius.and.marc.parent@gmail.com','2024-01-05 05:17:13.34+00','2024-01-05 05:17:13.34+00'),
('f6124178-83c7-4f1d-86dc-66dcafd1cece','Le parent de Leevy','0405040504','leevyparent@gmail.com','2024-01-05 05:17:13.343+00','2024-01-05 05:17:13.343+00');

-- |>>>>>>> SEED TEACHERS <<<<<<<|
INSERT INTO "public"."teachers" ("id","full_name","phone","email","created_at","updated_at") VALUES 
('1fcf00bb-cd22-4065-bfbd-0a2502bcd6a7','Prof de Maths','0103020103','profdemaths@gmail.com','2024-01-05 05:17:13.37+00','2024-01-05 05:17:13.37+00'),
('11b52518-fcbd-40a6-84cd-f51e3129eaaf','Prof de Philo','0103820103','profdephilo@gmail.com','2024-01-05 05:17:13.38+00','2024-01-05 05:17:13.38+00');

-- |>>>>>>> SEED CLASSES <<<<<<<|
INSERT INTO "public"."classes" ("id","school_id","grade_id","name","created_at","updated_at") VALUES 
('6a8841dc-86bf-4c25-8610-5986ce605a5c','ed85f4e4-5133-4270-b52d-795c6e65c0f0',7,'6ème 3','2024-01-05 05:17:13.406+00','2024-01-05 05:17:13.407+00'),
('b668814e-c1a5-4bd2-add6-88d21516a3c0','ed85f4e4-5133-4270-b52d-795c6e65c0f0',10,'3ème 7','2024-01-05 05:17:13.411+00','2024-01-05 05:17:13.411+00'),
('2967bbaa-80ac-48fb-a359-bc1773ee940e','cce1b0c4-87c4-4258-98d7-e5c23f555297',7,'6e 1','2024-01-05 05:17:13.413+00','2024-01-05 05:17:13.413+00'),
('b98cbcab-0e56-40db-8dc6-a01941981d3a','cce1b0c4-87c4-4258-98d7-e5c23f555297',8,'5e 2','2024-01-05 05:17:13.415+00','2024-01-05 05:17:13.415+00'),
('67bff25b-6d87-41f2-a39f-73789c313269','cce1b0c4-87c4-4258-98d7-e5c23f555297',9,'4e 6','2024-01-05 05:17:13.417+00','2024-01-05 05:17:13.417+00'),
('0f43a56d-a1ae-4abb-b87c-ca63c5bd6fb0','cce1b0c4-87c4-4258-98d7-e5c23f555297',13,'Tld 1','2024-01-05 05:17:13.419+00','2024-01-05 05:17:13.419+00');

-- |>>>>>>> SEED STUDENTS <<<<<<<|
INSERT INTO "public"."students" ("id","parent_id","school_id","class_id","id_number","first_name","last_name","created_at","updated_at") VALUES 
('c94c7803-20ad-4279-a76f-d0302e9aba93','906f1750-2821-4086-8c75-0418ed764838','ed85f4e4-5133-4270-b52d-795c6e65c0f0','b98cbcab-0e56-40db-8dc6-a01941981d3a','07083273S','Leevy','Kouassi','2024-01-05 05:17:13.449+00','2024-01-05 05:17:13.449+00'),
('db4b19df-056a-472b-ae6a-dd6155764b65','f6124178-83c7-4f1d-86dc-66dcafd1cece','ed85f4e4-5133-4270-b52d-795c6e65c0f0','b668814e-c1a5-4bd2-add6-88d21516a3c0','07082680U','Darius','Kassi','2024-01-05 05:17:13.451+00','2024-01-05 05:17:13.451+00'),
('915370f7-7857-4d12-a8dc-89fcc8114ad2','f6124178-83c7-4f1d-86dc-66dcafd1cece','cce1b0c4-87c4-4258-98d7-e5c23f555297','b98cbcab-0e56-40db-8dc6-a01941981d3a','17064624D','Marc','Kassi','2024-01-05 05:17:13.454+00','2024-01-05 05:17:13.454+00'),
('016bd2a7-12da-445f-8b55-4564fea37749','f6124178-83c7-4f1d-86dc-66dcafd1cece','ed85f4e4-5133-4270-b52d-795c6e65c0f0','b668814e-c1a5-4bd2-add6-88d21516a3c0','07147600S','Charlemagne','Kamenan','2024-01-05 05:17:13.456+00','2024-01-05 05:17:13.456+00'),
('9d15c49d-57f4-4157-a68c-ea011368ed04','f6124178-83c7-4f1d-86dc-66dcafd1cece','ed85f4e4-5133-4270-b52d-795c6e65c0f0','b668814e-c1a5-4bd2-add6-88d21516a3c0','09658199T','Fatoumata','Cissé','2024-01-05 05:17:13.458+00','2024-01-05 05:17:13.458+00'),
('eb20ef5f-0f8a-4437-bd23-3dd80d0e25dd','f6124178-83c7-4f1d-86dc-66dcafd1cece','ed85f4e4-5133-4270-b52d-795c6e65c0f0','b668814e-c1a5-4bd2-add6-88d21516a3c0','07652986Y','Olivia','Gueu','2024-01-05 05:17:13.46+00','2024-01-05 05:17:13.46+00'),
('91d596d6-01e9-4551-b904-1c19769f0dbf','f6124178-83c7-4f1d-86dc-66dcafd1cece','ed85f4e4-5133-4270-b52d-795c6e65c0f0','b668814e-c1a5-4bd2-add6-88d21516a3c0','07256719P','Claver','Aboh','2024-01-05 05:17:13.462+00','2024-01-05 05:17:13.462+00'),
('ec243d07-eef2-4f14-8036-ec907bbafe8a','f6124178-83c7-4f1d-86dc-66dcafd1cece','ed85f4e4-5133-4270-b52d-795c6e65c0f0','b668814e-c1a5-4bd2-add6-88d21516a3c0','10101010H','Même','Moi','2024-01-10 03:05:31.509+00','2024-01-10 03:05:31.509+00');
