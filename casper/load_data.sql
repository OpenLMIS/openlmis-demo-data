--
-- This program is part of the OpenLMIS logistics management information system platform software.
-- Copyright © 2019 VillageReach
--
-- This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.
-- You should have received a copy of the GNU Affero General Public License along with this program.  If not, see http://www.gnu.org/licenses.  For additional information contact info@OpenLMIS.org.
--

INSERT INTO referencedata.programs (id, code, name, description, active, shownonfullsupplytab, periodsskippable, enabledatephysicalstockcountcompleted)
  VALUES
    ('19ef7927-2597-4f75-b594-a0807d71f14a','ilshosp','Redesigned ILS','ILS Hospital','true', 'true','false', 'false');

INSERT INTO referencedata.geographic_levels
(id, code, name, levelNumber) VALUES
('48cfc451-99a8-44c1-b3d0-1d2d41e0cb1d', 'country', 'Country', 1),
('29222ebc-27e1-411d-a914-c3b4f79c3b4a', 'state', 'State', 2),
('4de24837-626e-436e-b347-6e5c919c8c39', 'province', 'Province', 3),
('5552712b-498a-4b85-a465-26b096ea04d1', 'district', 'District', 4);

INSERT INTO referencedata.geographic_zones
(id, code, name, levelId, parentId) values
('8a4f8d4d-5dd0-4108-810d-0f7da9059a8a', 'Root', 'Root', (SELECT id from referencedata.geographic_levels WHERE code = 'country'), NULL);

INSERT INTO referencedata.geographic_zones
(id, code, name, levelId, parentId) values
('8555d166-65a9-431e-82af-f5a0dc30a819', 'Mozambique', 'Mozambique', (SELECT id from referencedata.geographic_levels WHERE code = 'country'), NULL);


INSERT INTO referencedata.geographic_zones
(id, code, name, levelId, parentId) values
('960927bc-a015-498b-bd33-4fef4648ad5b', 'Arusha', 'Arusha',(SELECT id from referencedata.geographic_levels WHERE code = 'state'), (SELECT id from referencedata.geographic_zones WHERE code = 'Root'));


INSERT INTO referencedata.geographic_zones
(id, code, name, levelId, parentId) values
('3405b837-9a7a-46c8-9c4b-48d7784755d5', 'Dodoma', 'Dodoma',(SELECT id from referencedata.geographic_levels WHERE code = 'province'), (SELECT id from referencedata.geographic_zones WHERE code = 'Arusha'));

INSERT INTO referencedata.geographic_zones
(id, code, name, levelId, parentId) values
('cc125c1f-e335-4685-99f3-e85a889e17dd', 'Ngorongoro', 'Ngorongoro', (SELECT id from referencedata.geographic_levels WHERE code = 'district'), (SELECT id from referencedata.geographic_zones WHERE code = 'Dodoma'));



INSERT INTO referencedata.facility_operators
(id, code,      description,      displayOrder) VALUES
('5d2ccad6-9078-4996-a28c-5903a6c05bd8', 'MoH',     'MoH',     1),
('4da7a275-df6b-43b6-8d4f-883749ac7e7d', 'NGO',     'NGO',     2),
('9f1992b6-3855-465b-81fe-0b76cad138f2', 'FBO',     'FBO',     3),
('c5e44385-ae41-485f-9312-376bcec2ad2e', 'Private', 'Private', 4);



INSERT INTO referencedata.facility_types (id, code, name, description, displayOrder, active) VALUES
    ('e4a9973b-b249-4a8b-a3d4-8223b9123383', 'disp','Dispensary','Dispensary',13,'true'),
    ('a0677dcd-3e3f-4ee5-a8fa-a7bf2c77f224', 'heac','Health Centre','Health Centre',14,'true'),
    ('cf9fc00e-4e53-43ad-9faf-c362e30fb15e', 'ddho','District Designated Hospital','District Designated Hospital',10,'true');

--Insert Facilities Section
INSERT INTO referencedata.facilities (id, code, name, description, geographiczoneid,
  typeid, operatedbyid,
  active, golivedate, godowndate, comment, enabled)
            VALUES
    ('47cb7b3f-caf0-4164-bf09-46ed5192d3e2', 'MZ520495','Kibirizi','Dispensary',(select id from referencedata.geographic_zones where code ='Ngorongoro'),
    (select id from referencedata.facility_types where code ='disp'),(select id from referencedata.facility_operators where code='MoH'),
    'true','2013-01-01 00:00:00',NULL,NULL,'true'),
    ('14617116-12d5-4617-aad0-004c8a2cb83e', 'MZ510054','Katoro Bukoba DC','Health Centre',(select id from referencedata.geographic_zones where code ='Ngorongoro'),
    (select id from referencedata.facility_types where code ='heac'),(select id from referencedata.facility_operators where code='MoH'),
    'true','2013-01-01 00:00:00',NULL,NULL,'true');




--Insert Programs Supported

INSERT INTO referencedata.supported_programs (facilityId, programId, startDate, active) VALUES
  ((SELECT
      id
    from referencedata.facilities
    WHERE code = 'MZ520495'),
     (SELECT
      id
    from referencedata.programs
    WHERE code = 'ilshosp'), '11/11/12', TRUE);

  INSERT INTO referencedata.supported_programs (facilityId, programId, startDate, active) VALUES
  ((SELECT
      id
    from referencedata.facilities
    WHERE code = 'MZ510054'),
     (SELECT
      id
    from referencedata.programs
    WHERE code = 'ilshosp'), '11/11/12', TRUE);


insert into referencedata.orderable_display_categories
(id, code, displayname , displayOrder) values
   ('0704c1ec-c12e-4ff2-aaf6-5063828d4937','arv','Antiretrovirals',1),
    ('209fd868-2b0e-499b-b718-45be0399e797','anb','Antibiotics',4),
    ('03a9b3ad-71ac-44a2-9bbf-2d249d35bdea','anh','Antihelminthics',5),
    ('d59760c5-858e-4faa-be62-b0c7c73ceda4','anf','Antifungals',6),
    ('65933653-693c-4bd1-8217-04f4b94bc4fa','anm','Antimalarials',7),
    ('6a11b690-b8e1-4364-88d5-a6362e5f7670','bro','Bronchodilators',8),
    ('b811a180-946e-4518-95a9-c28afd587a56','cns','Central Nervous system drugs',9),
    ('3c88196d-d46e-4672-8fcf-ad9cb1b76d4a','con','Contraceptives',10),
    ('6a6fb7e1-37bf-486b-8e85-2cca6450d6bb','sup','Supplements',11),
    ('01c1bcf7-9343-40bb-8407-f0da05bac7b1','git','GIT drugs',12),
    ('93c9c5a9-e698-43fa-84b6-f320c1c2e363','opp','Ophthalmic preparation',13),
    ('85caf109-9e19-492f-91d8-3345c9d6b80a','ans','Antiseptics/Disinfectants',14),
    ('4c485800-0749-4968-aee3-341e9dc97a4f','anp','Antispasmodics',15),
    ('352bbfa1-1027-4b62-a2a8-28fc5dc042f3','anw','Anti warts',16),
    ('2bcb476b-a31d-4d5d-9027-6130abb9e3cf','oxy','Oxytocics',17),
    ('21c681be-52fa-4175-a5d9-13db4d3da018','pma','PMTCT Option A',18),
    ('0161db1a-82a6-41aa-83d9-5548d1b1282f','pmb','PMTCT Option B+',19),
    ('a3a6450e-79ba-4584-be9e-faf21bd1d6ea','ivf','Intravenous Fluids',20),
    ('f067b924-66c6-4239-b8f0-c54b400cec99','msu','Medical supplies and utensils',21),
    ('dd632936-845e-4f4c-8f49-638fadc81c5f','lab','Laboratory utensils/reagents',22),
    ('c45bf570-c204-4765-83b5-0e08ce913a56','mgt','Management tools',23),
    ('ced6315c-d92d-4883-b059-e314b99379ac','anl','Antileprosy',24),
    ('d320d5ce-9ad9-4264-aae7-69a7ebb6097d','ute','Uterotonics',26),
    ('fb1935fe-37e7-4107-893b-c10972274ed2','oid','Opportunistic Infections Drugs',27),
    ('2cc822ac-88d5-4d92-bb04-51995c348b90','chem','Chemistry',28),
    ('eac9c96c-699a-4e5e-bb50-c1ad02629d04','oth','Other Methods',29),
    ('74a092aa-fc27-4599-b0f8-8c615b09fce5','ser','Serology',30),
    ('ba724aec-c694-4222-8a65-354fd8a0cdba','bac','Bacteriology (Stains and Bacterial ID agents)',31),
    ('d55bc88d-157b-46f5-951a-91d0ffbeb4b0','acc','Accessories and other Supplies',32),
    ('3c988979-1242-48b1-969b-944d976ad06f','hae','Haematology',33),
    ('5480e7ce-7cd6-4422-ab19-9d5f3d11804a','cdf','CD-4 Testing Facs Count',34),
    ('521d249f-dbc4-452f-9ecd-e949c879d379','axy','AXYSM',35),
    ('ccf8234a-7129-4726-a877-fa82e2a1833e','vil','Viral Load',36),
    ('60769202-2592-4ca6-917c-9265a1aa8e62','pcr','PCR Test',37),
    ('dd4b01c4-9144-4ec5-9a60-f4b17d0570dc','bga','Blood and glucose analyser',38),
    ('9143508a-10b4-48ca-a87b-9055316e2f2a','chu','Reagents Strip for Urine - Chemistry',39),
    ('4087e164-3545-4b65-9126-a3e15a9e9adb','his','Histopathology',40),
    ('0d880b88-41ae-4dd0-9623-e365b4b07257','bfi','Bacterial and Fungal Isolation and Identification',41),
    ('5c1989cf-97d5-4c74-9f35-d151689f3745','bsi','Bacterial Stains and Identification Agent',42),
    ('a8e6a05c-3099-4a8c-b4dd-f489acf263ef','pry','Parasitology',43),
    ('7f23310b-6b99-4a7d-99a1-225df6bb69cb','cgi','Consumables and General Items',44),
    ('e5469f37-d3b6-45a6-8bb9-b516307c44e0','hep','Haematology Pentra 8',46),
    ('468a1cb9-01bf-451a-a5cd-c3bfde9e3ec7','fas','Facs Callibur',47),
    ('6cf111b1-b812-4cce-a924-b7cdd415f44a','btf','Blood Transfusion',48),
    ('67ecb679-330b-4bb7-ab78-db8f60631870','ant','Anti - Inflamatory',49),
    ('4760f7fb-3eb3-45c0-bc3c-3c09c3462300','antang','Anti-Angina Medicines',31),
    ('4f7a3882-a858-46dc-a74b-1b628b2b361f','gen','General Purposes, Laboratory and Disinfectants Items',51),
    ('3813a5dd-4690-4af1-86b5-7068baff87dd','hospef','Hospital Equipment And Furniture ',52),
    ('21af9196-367b-48f7-a372-5cfd679367d4','hosplub','Hospital Linen, Uniforms & Beddings Materials ',53),
    ('78215733-4aab-4dd9-8274-0f1afe0ade2a','hhw','Hospital Hollow Wares ',54),
    ('fcd972ff-70cc-424c-b2a3-508167198b34','patmgmnt','Patient Management Devices And Other Tools ',55),
    ('8fbd19bc-433e-46b4-9404-774b55f18b76','psychoa','Psychotherapeutic Agents',56),
    ('4bbbc077-1b2e-4568-ac68-00130a15fe57','reud','Reusable Devices (Hospital Instruments) ',57),
    ('360e7db5-db21-4c00-a9a4-c6c27b80da24','atb','Anti-TB',25),
    ('dc092c11-5549-4514-b8a4-38420e847e59','antac','Anti - Acid Medicines',58),
    ('b4fd2fa7-d262-4bb0-9757-4dc910b8e6e4','antdb','Anti - Diabetic Medicines',59),
    ('d5f4f9fe-5bb4-46e5-b767-7dd3738b5cd4','anhc','Anti - Hypertensive and Cardiac Glycoside',60),
    ('b962e5f4-97ba-47ce-8528-49ce8ce0870f','antp','Antipruritics',61),
    ('d2286ab0-91f6-4e69-936e-ae84d25a136b','cat','Catheters &Tubes',62),
    ('5d3ec5ff-62d2-41d3-969a-aac8c73fd514','DiureticMed','Diuretic Medicines',63),
    ('d100e6ba-ede9-4aa2-8681-1ddfa91b9e7a','MicroSerol','Microbiology and Serology Items',64),
    ('cc81fafc-6680-4586-b64b-f7c599dc18f7','Patmgmntdevice','Patient Management Devices And Other Tools',65),
    ('8066166a-f284-40e6-97c7-2b8934db67ee','psychothagent','Psychotherapeutic Agents',66),
    ('fabb2e40-f61d-4f62-96c8-9a97f6f2b102','steroid','Steroidal Anti-Inflammatory Medicines',67),
    ('91fc0368-3052-4f98-96d6-4a36783e35e1','surgicalInst','Surgical Instruments & Medical Kits/Sets',68),
    ('d7114982-df56-4167-ba7e-9abd21a9574c','syrin','Syringes, Needles, Cannulas &  Administration Sets',69),
    ('dfdcbbc6-5c8c-413d-a72e-a6e7d47ea681','vit','Vitamins & Minerals',70),
    ('fb324808-48b0-4100-8dd1-7e245a4a5cee','wasteCollect','Waste Collection Bags',71),
    ('7053ebe3-ab6f-4b86-ada3-7f0fb9818802','dress','Dressing Material ',72),
    ('72260fdb-c5eb-4894-bb63-0cb138ef1fc9','ana','Anti-allergies and Medicines used Anaphylaxis and Shock',3),
    ('953c07e6-5230-456c-8193-0700ab164e62','cough','Cough Medicine',72),
    ('b5c4dd5b-642a-43ca-a940-00ef67891aee','NSAIDS','Anti-pyretics NSAIDS',73),
    ('ccbe34ba-c9a5-443c-9f28-72065bd6a67b','anschisto','Anti-Schistosomal',74),
    ('f7d22767-f4fa-4094-bc04-d2ec8b43dc7f','screenm','Screen Master',75),
    ('7373b9f0-a682-4703-98fa-2f1fd6a760f0','anlg','Analgesics',0),
    ('e5e7f5b2-785f-47dd-97e5-ce889f94e2d6','antidote','Antidote',76),
    ('8c04054e-2805-41cd-ad04-4bc92467fc8a','hemamicro60','Hematology Micro 60',78),
    ('08c3669d-480a-474a-bba0-5e7f96151113','amoe','Amoebicides',1),
    ('c1b3ce64-0c67-41bf-8481-d72f5c0843ae','lane','Local Anesthesia',2),
    ('782af745-f878-42c9-888e-44e64028d1f4','gane','General Anesthesia',3),
    ('7c5d4bd9-0407-4861-95b5-9da7e0a1ad24','asth','Anti-Asthmatic and Cough Medicine',6),
    ('4fc373c8-29bf-4f31-86e0-d307a4be392a','Anti-Co','Anti-Coagulant & Antagonists',79),
    ('90a8e876-4f1f-4b65-901d-af45ec36cc1a','Anti-Ep','Anti-Epileptics/Anticonvasants',80),
    ('466f60f4-5f62-48a1-9a28-a93da6924bea','Anti-Ha','Anti-Haemorrhoids',81),
    ('2f7ca10a-f7aa-4851-a53e-933c408c5324','Anti-Py','Anti-Pyretics And Nsaids',82),
    ('a63bcad0-aa5a-475a-b4c1-a0ec2fa85030','Gloves','Gloves & Other Protective Gears',83),
    ('5defe9f6-bf47-4707-8c33-17ab09ad1f41','Ironde','Iron Deficiency Anaemias Medicines',84),
    ('957eda00-5b8a-4941-a797-f324980b1dc5','Liq','Liquid, Correcting Electrolytes and Acid/Base Disturbances',85),
    ('4caa657a-9b5e-47ea-ae92-2f44ea190de5','Med-Diar','Medicines used in Diarrhoea',86),
    ('cf9d4b5f-158d-48f6-addd-aaaf8ee8230a','Muscle-Relax','Muscle Relaxants , Cholineserase Inhibitors and Anticholinergic',87),
    ('4b0309e5-b443-4f2a-b05a-846d23d87e0c','Narcoti','Narcotic & Antagonists',88),
    ('4e0946b1-a626-499d-be18-acd4304d1f30','Ophtham','Ophthamological Preparations',89),
    ('480ed068-b510-4769-b0a5-bd1bf7b0ca4b','SeraIm','Sera And Immunoglobulins',90),
    ('f3a5492d-3cf2-458c-9041-6fd9168b49b9','X-RayC','X-Ray Chemicals And Reagents',91),
    ('a0e3724f-1d19-40ec-a147-826d31bdf0a9','X-RayF','X-Ray Films',92),
    ('c5906b14-0074-4b79-86cd-fb207b1de953','ane','Anaesthetics',1),
    ('34f57249-3079-4a3a-a877-8316478fae08','hmind','Hematology Reagents for Mindray Machines BC 3200',99),
    ('876accb8-5efe-4097-8797-fe771b6d5a0b','hsys','Haematology Reagents for Sysmex (KX21, KX 1000i/PoCH)',110),
    ('d3e10233-f01e-4dfa-a3ef-6aa8da4916f9','gds','GIT drugs and Suppliments',122),
    ('76f33c27-55a3-4460-a2c4-a4daf1a4450b','ecfvm','Electrolystes corection  Fluid, Vaccines and Immunoglobins',123),
    ('41f8cba5-4eae-433e-9eb3-620c6fb3fdb9','adv','Antiretriviral Drugs -ARVs',124),
    ('51dcafbd-f6de-4bcc-a7d8-09945ce80d4e','aaam','Anti-Allergies and anaphylaxis mediecine',114),
    ('33b93768-0004-480b-ba63-cdd267cdc377','ast','Asthma',115),
    ('4ad7b754-960a-43a0-83f6-e7e89177e687','anhs','Antihelminthes',116),
    ('0ca21034-dcec-46aa-9602-7b12b2e1a7cb','anfs','Anti-Fungals',117),
    ('42fd00a8-c9af-40df-8dac-554891d08f83','antd','Anti-Diabetics',118),
    ('1e59ccf4-0e1c-4989-a989-676a5879478a','ahcg','Anti - Hypertensive and Cardiac Glycoside.',119),
    ('e62d5b1c-4c98-48bc-b89d-522fdc05788c','amm','Anti-Malarial medicine',120),
    ('0bf945f3-b9a4-4166-b42a-1bfd3570ad18','cnsm','Central Nervous System Medicines',121),
    ('8c7044f7-59d0-461f-9615-800c9834da5d','agmr','Anesthetics General and Muscle relaxants',112),
    ('8b76727e-cb09-4d52-a7c7-eeaab5e80306','anta','Antibiotics and Amoebicides',113),
    ('1c844e05-8ee0-4ff8-9fd6-5f8247e2f955','laa','Local Anaesthetics and analgesics',111),
    ('5450a6b9-58cf-43a5-aa99-1b15ff3b9eec','nar','Narcotics',126),
    ('7ec73257-11d8-4d35-b1a7-c856ad3d92b3','fpsmp','Family Planning and Safe Motherhood product',127),
    ('60198ac9-bd24-4526-9fc7-712d1265fe4d','ansd','Antiseptics/Disinfectants.',128),
    ('12be084f-67bf-4cc6-bd68-62bea8a0bcf1','Ophthamp','Ophthalmic Preparation.',129),
    ('9e752ffa-2dc2-4871-9068-8a178d125c85','msus','Medical supplies and utensils.',130),
    ('de08a4c1-8a35-42c7-8a40-12e8128c1975','nmv','Nutritions (Minerals and Vitamins)',131),
    ('6d0800c9-28dd-4f15-b311-acb232979576','sergy','Serology.',132),
    ('48a2e880-c266-4909-82d6-6b19ecd76166','hbtr','Hematology and Blood transfusion',133),
    ('3c1fc4a6-0d4b-4edd-9017-d95ed2e0cd71','chemy','Chemistry.',134),
    ('127f6a00-4194-40c7-9a8f-69a966a76a53','icd','Immunophenotyping/CD4',135),
    ('56722ec3-8533-4180-b236-51de7358bb5e','cosu','Consumables',136),
    ('cba540f5-c161-43e1-b587-b985771aa273','lmt','LMIS and Management Tools',137),
    ('d35faf64-aa54-4e88-8b85-68c5e84e96c4','tbli','TB&LEPROSY ITEMS',138),
    ('90dd8a41-2b8c-4e8c-b9ad-9ea5625c0213','ctfc','CD-4 Testing Facs Count.',201),
    ('6237320a-f948-4c09-99ad-56584edea531','vrl','Viral Load.',202),
    ('d953ba2e-6d5b-453d-b731-137efc0c898c','htlgy','Haematology.',203),
    ('6ea32c73-181a-4346-8014-460196ac5dcb','htlgym','Haematology Micro 60.',204),
    ('a6a601c9-09a1-463b-9f96-ba30d52f52e8','htlgyrfs','Haematology Reagents for Sysmex (KX21, KX 1000i/PoCH).',205),
    ('6260c728-bac8-4765-80d2-228ebf07bef7','htlgyrfmm','Haematology Reagents for Mindray Machines BC 3200.',206),
    ('933183ff-6379-4b28-a2c3-b505199a12dd','bctrg','Bacteriology (Stains and Bacterial ID agents).',207),
    ('65a1c0ce-1395-40d6-bc69-e1e026491ca5','lur','Laboratory utensils/reagents.',208),
    ('bff1c85f-94f1-4d35-b0ab-3751c86758dd','rsfuc','Reagents Strip for urine - Chemistry.',209),
    ('00ff6a3f-6dfe-486e-95e5-f7d28734e07f','cgs','Consumables and General items.',211),
    ('adbec852-070b-471f-8cdb-18cc8f3cedfe','scc','Specimen Collection/Consumables',45),
    ('484a0323-0f29-4b16-bf66-35c78ffa6777','sccnew','Specimen Collection/Consumables.',210),
    ('ea26f5d0-c35a-4c85-a809-22189e64b906','hmp','Haematology Pentra 80.',212),
    ('cddbb94a-4859-48ad-ae4c-ff256c5c7563','dmn','Dawa za Magonjwa Nyemelezi',125);



insert into referencedata.dispensables
(id,type) values
('bc51ce3e-322a-4d41-a9ec-aef2aee77d55','default'),
('5ccbecf3-3403-4331-8d34-f49030005472','default'),
('5667378b-160a-4dc4-aaf3-6ab21ffae8e3','default'),
('4c781e51-d6c4-45c6-b9be-ca8dbebcd889','default');

insert into referencedata.dispensable_attributes
(dispensableid,key,value) values
('bc51ce3e-322a-4d41-a9ec-aef2aee77d55','dispensingUnit','100 Tablets'),
('5ccbecf3-3403-4331-8d34-f49030005472','dispensingUnit','1000 Tabs'),
('5667378b-160a-4dc4-aaf3-6ab21ffae8e3','dispensingUnit','28 Tablets'),
('4c781e51-d6c4-45c6-b9be-ca8dbebcd889','dispensingUnit','30 Tablets');

--Insert products
insert into referencedata.orderables
(id, code, fullproductName, description, netcontent, packRoundingThreshold, roundToZero,dispensableid,versionid) values
('b477a8e4-056f-4506-ab57-c7ef5f6afd33','10010129AC','Zinc Sulphate','Zinc Sulphate',100,1,'true','bc51ce3e-322a-4d41-a9ec-aef2aee77d55',1),
('b327c607-5a87-415d-8c62-daff58def51a','10010031MD','Griseofulvin',NULL,1000,1,'true','5ccbecf3-3403-4331-8d34-f49030005472',1),
('72c581bd-93dd-43e2-b9e0-4b13002fdf97','10010222SC','LOSARTAN 50MG TABLETS','LOSARTAN 50MG TABLETS',28,1,'true','5667378b-160a-4dc4-aaf3-6ab21ffae8e3',1),
('3bf36a15-b276-4c14-ba58-b63ed02cd5d7','10010190SP','LORATIDINE 10MG TABLETS','LORATIDINE 10MG TABLETS',30,1,'true','4c781e51-d6c4-45c6-b9be-ca8dbebcd889',1),
('dcca56dc-dbeb-4454-a70c-f84afcbb12f6','10010190MD','Loratidine Tablet',NULL,30,1,'true','4c781e51-d6c4-45c6-b9be-ca8dbebcd889',1);



--Insert program_products
insert into referencedata.program_orderables(id, programId, orderableid, fullSupply, priceperpack, active, displayOrder, orderabledisplaycategoryId, orderableversionid) values
('46a33d1d-d9a5-4ed6-9f38-00eae4079c78',(select id from referencedata.programs where code='ilshosp'),(select id from referencedata.orderables where code = '10010129AC'),'true',0.00,'true',455,(select id from referencedata.orderable_display_categories where code='cgi'),1),
('2ed21424-6e08-471a-a66f-1f36639846a6',(select id from referencedata.programs where code='ilshosp'),(select id from referencedata.orderables where code = '10010031MD'),'true',0.00,'true',0,(select id from referencedata.orderable_display_categories where code='cgi'),1),
('e264962a-45ec-4c7f-8f99-83c37dfe22b8',(select id from referencedata.programs where code='ilshosp'),(select id from referencedata.orderables where code = '10010222SC'),'true',6300.00,'true',560,(select id from referencedata.orderable_display_categories where code='cgi'),1),
('23102117-fecf-46b7-b6ad-540b666629b7',(select id from referencedata.programs where code='ilshosp'),(select id from referencedata.orderables where code = '10010190SP'),'true',2600.00,'true',9,(select id from referencedata.orderable_display_categories where code='cgi'),1),
('ac8a72d6-082e-4728-8d16-ae016993948a',(select id from referencedata.programs where code='ilshosp'),(select id from referencedata.orderables where code = '10010190MD'),'true',133300.00,'true',356,(select id from referencedata.orderable_display_categories where code='cgi'),1);





--Insert facility_approved_products
insert into referencedata.facility_type_approved_products(id, facilityTypeId, programid, orderableid, maxperiodsOfStock, versionid) values
('430418a6-5b15-4ffa-a4ab-ad6d8369ed2e',(select id from referencedata.facility_types where code='disp'), (select id from referencedata.programs where code='ilshosp'),
 (select id from referencedata.orderables where  code='10010129AC'), 2, 1),
('c5fb65b8-772c-4a2a-a45b-d76ac0bbec2f',(select id from referencedata.facility_types where code='disp'), (select id from referencedata.programs where code='ilshosp'),
(select id from referencedata.orderables where  code='10010031MD'), 2, 1),
('d0712f5d-46bb-4dfe-a277-68cc8876d74c',(select id from referencedata.facility_types where code='disp'), (select id from referencedata.programs where code='ilshosp'),
(select id from referencedata.orderables where  code='10010222SC'), 2, 1),
('1b0345c7-33ad-4d38-bc56-87b96fbcf7d1',(select id from referencedata.facility_types where code='disp'), (select id from referencedata.programs where code='ilshosp'),
(select id from referencedata.orderables where  code='10010190SP'), 2, 1),
('f0a17ebf-744f-4226-a116-72eb94338883',(select id from referencedata.facility_types where code='heac'), (select id from referencedata.programs where code='ilshosp'),
(select id from referencedata.orderables where  code='10010129AC'), 2, 1),
('7be9d936-3194-477d-870d-0db535d61142',(select id from referencedata.facility_types where code='heac'), (select id from referencedata.programs where code='ilshosp'),
(select id from referencedata.orderables where  code='10010031MD'), 2, 1),
('37ecc6dc-e267-4edd-96fe-5351d1e91db6',(select id from referencedata.facility_types where code='heac'), (select id from referencedata.programs where code='ilshosp'),
(select id from referencedata.orderables where  code='10010222SC'), 2, 1),
('c8843e80-9bd3-4845-991f-00e3c8e36d3a',(select id from referencedata.facility_types where code='heac'), (select id from referencedata.programs where code='ilshosp'),
(select id from referencedata.orderables where  code='10010190SP'), 2, 1);







INSERT into referencedata.roles(id, name, description) VALUES
    ('edfa94dc-3217-4d5c-91fd-6d43c8691434', 'Create & Submit','Can only create R&R'),
    ('3c2f3bda-04e6-45f2-b043-c943d9be1986', 'Approve Only','Can only approve the R&R'),
    ('08f34610-6e0b-4376-83bd-a974a7b02ebd', 'Authorize only','Can only authorize R&R'),
    ('3c1e6ae3-96a1-4fae-a377-2179f8e8fd4f', 'Admin', 'Admin');

INSERT into referencedata.role_rights
(roleId, rightid) VALUES
((SELECT  id from referencedata.roles WHERE name = 'Create & Submit'), (select id from referencedata.rights where name = 'REQUISITION_VIEW')),
((SELECT  id from referencedata.roles WHERE name = 'Create & Submit'), (select id from referencedata.rights where name = 'REQUISITION_CREATE')),
((SELECT  id from referencedata.roles WHERE name = 'Create & Submit'), (select id from referencedata.rights where name = 'REQUISITION_DELETE')),

((SELECT id from referencedata.roles WHERE name = 'Approve Only'), (select id from referencedata.rights where name = 'REQUISITION_VIEW')),
((SELECT id from referencedata.roles WHERE name = 'Approve Only'), (select id from referencedata.rights where name = 'REQUISITION_APPROVE')),
((SELECT id from referencedata.roles WHERE name = 'Approve Only'), (select id from referencedata.rights where name = 'REQUISITION_DELETE')),

((SELECT id from referencedata.roles WHERE name = 'Authorize only'), (select id from referencedata.rights where name = 'REQUISITION_VIEW')),
((SELECT id from referencedata.roles WHERE name = 'Authorize only'), (select id from referencedata.rights where name = 'REQUISITION_AUTHORIZE')),
((SELECT id from referencedata.roles WHERE name = 'Authorize only'), (select id from referencedata.rights where name = 'REQUISITION_DELETE')),

((SELECT id from referencedata.roles WHERE name = 'Admin'), (select id from referencedata.rights where name = 'FACILITIES_MANAGE')),
((SELECT id from referencedata.roles WHERE name = 'Admin'), (select id from referencedata.rights where name = 'USER_ROLES_MANAGE')),
((SELECT id from referencedata.roles WHERE name = 'Admin'), (select id from referencedata.rights where name = 'PROGRAMS_MANAGE')),
((SELECT id from referencedata.roles WHERE name = 'Admin'), (select id from referencedata.rights where name = 'PROCESSING_SCHEDULES_MANAGE')),
((SELECT id from referencedata.roles WHERE name = 'Admin'), (select id from referencedata.rights where name = 'REQUISITION_TEMPLATES_MANAGE')),
((SELECT id from referencedata.roles WHERE name = 'Admin'), (select id from referencedata.rights where name = 'USERS_MANAGE')),
((SELECT id from referencedata.roles WHERE name = 'Admin'), (select id from referencedata.rights where name = 'REPORTS_VIEW')),
((SELECT id from referencedata.roles WHERE name = 'Admin'), (select id from referencedata.rights where name = 'REPORT_TEMPLATES_EDIT')),
((SELECT id from referencedata.roles WHERE name = 'Admin'), (select id from referencedata.rights where name = 'SYSTEM_SETTINGS_MANAGE'))
;


--Insert into referencedata.user table

INSERT into referencedata.users
(id, userName, homefacilityId, firstName, lastName, email, verified, active) VALUES
  ('5806ca9e-24e0-4b40-9638-f551e6048e27', 'StoreInCharge',
   (SELECT
      id
    from referencedata.facilities
    WHERE code = 'MZ520495'), 'Hassan', 'Matoto', 'Fatima_Doe@openlmis.com', TRUE, TRUE),

  ('a3c2508d-f46c-42b7-ab21-7a0fdfa0071e', 'FacilityInCharge',
   (SELECT
      id
    from referencedata.facilities
    WHERE code = 'MZ520495'), 'Rachel', 'Stephen', 'Jane_Doe@openlmis.com', TRUE, TRUE),

  ('c86bfd2c-7a22-4911-a9bc-0921c34681de', 'lmu',
   (SELECT
      id
    from referencedata.facilities
    WHERE code = 'MZ520495'), 'Evance', 'Nkya', 'Frank_Doe@openlmis.com', TRUE, TRUE),
    ('81104549-a8e0-454d-86c8-dada103365e1', 'Admin123', (SELECT
      id
    from referencedata.facilities
    WHERE code = 'MZ520495'), 'John', 'Doe', 'John_Doe@openlmis.com', TRUE, TRUE);




--Insert supervisory nodes


INSERT into referencedata.supervisory_nodes
(id, facilityId, name, code, parentId) VALUES
  ('7b2d5193-f2fa-45a1-83f0-524beaedbbc4', (SELECT id from referencedata.facilities WHERE code = 'MZ520495'), 'Mwanza Zone', 'MWAN-SNZ', NULL);




--Insert role assignments

INSERT into referencedata.role_assignments
(type, id, userId, roleId, programId, supervisoryNodeId) VALUES
  ('supervision', '659c9b9f-c028-45b2-bf33-be77b7dc28e8', (SELECT ID from referencedata.USERS WHERE username = 'StoreInCharge'), (SELECT id from referencedata.roles WHERE name = 'Create & Submit'), (SELECT id from referencedata.programs WHERE code = 'ilshosp'), NULL),
  ('supervision', 'b9e1c145-b633-43cd-ad0a-a4f4cc667777', (SELECT ID from referencedata.USERS WHERE username = 'lmu'), (SELECT id from referencedata.roles WHERE name = 'Approve Only'), (SELECT id from referencedata.programs WHERE code = 'ilshosp'), (select id from referencedata.supervisory_nodes where code='MWAN-SNZ')),
  ('supervision', '2659d31c-7f83-4d85-bc71-1abc9009115e', (SELECT ID from referencedata.USERS WHERE username = 'FacilityInCharge'), (SELECT id from referencedata.roles WHERE name = 'Authorize only'), (SELECT id from referencedata.programs WHERE code = 'ilshosp'), NULL),
  ('direct', 'aad366b2-59cf-4bac-9ca2-fd74f91fd13b', (SELECT id from referencedata.users WHERE userName = 'Admin123'), (SELECT id from referencedata.roles WHERE name = 'Admin'), (SELECT id from referencedata.programs WHERE code = 'ilshosp'), NULL);


INSERT INTO referencedata.processing_schedules (id, code, name, description) VALUES
 ('9faacf97-357c-4ad1-8b0c-c21bc9de6737', 'groupA','BiMonthly Group A','Reporting and Ordering Group A'),
 ('2d21c306-6309-4bdb-ab26-c57b0feb1f51', 'groupB','BiMonthly Group B','Reporting and Ordering Group B');



INSERT INTO referencedata.processing_periods
(id, name, description, startDate, endDate, processingscheduleId) VALUES
    ('70f5bef1-9755-4f15-8933-d1b02cf69e2d','Jan 2019',NULL,'2019-01-01T00:00:00.000+03:00','2019-01-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('297bf315-1dce-4fbc-9d6d-7a572d2b213c','Jan -  Feb 2019',NULL,'2019-01-01T00:00:00.000+03:00','2019-02-28T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('1bdc180f-d1f3-4e71-9150-4ce244d1c97b','March 2019',NULL,'2019-03-01T00:00:00.000+03:00','2019-03-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('ac867e52-e468-48da-afe7-08ef3836a979','March - April 2019',NULL,'2019-03-01T00:00:00.000+03:00','2019-04-30T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('a48d5a86-683f-423b-99a2-2451afcef1c9','May 2019',NULL,'2019-05-01T00:00:00.000+03:00','2019-05-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('dee28f2b-390e-4253-b571-df71b5565f32','May - June 2019',NULL,'2019-05-01T00:00:00.000+03:00','2019-06-30T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('e13960d3-7b5e-403e-8796-0cc1f58d791c','July 2019',NULL,'2019-07-01T00:00:00.000+03:00','2019-07-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('cdd91765-8471-4f14-a708-64a15123ee38','July - August 2019',NULL,'2019-07-01T00:00:00.000+03:00','2019-08-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('fbbb45e5-069b-4938-8d9b-eff7d659eea1','Sep 2019',NULL,'2019-09-01T00:00:00.000+03:00','2019-09-30T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('6d903e0c-16e0-422c-b6d8-ecc00067f3a0','Sep - Oct 2019',NULL,'2019-09-01T00:00:00.000+03:00','2019-10-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('d5d1a17d-f52e-45c8-b8ea-953611b5216b','Nov 2019',NULL,'2019-11-01T00:00:00.000+03:00','2019-11-30T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('e5b04c19-cd68-45a1-a695-c8c6950f9773','Nov - Dec 2019',NULL,'2019-11-01T00:00:00.000+03:00','2019-12-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupA')),
    ('fa3fc1a1-72eb-40e5-95ba-c56bbd7c2036','Dec - Jan 2019',NULL,'2018-12-01T00:00:00.000+03:00','2019-01-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('9cf0e924-fd69-47b2-8adc-7e6a0839e576','Feb 2019',NULL,'2019-02-01T00:00:00.000+03:00','2019-02-28T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('41c668fd-3a48-4472-8c20-bd1570494104','Feb - March 2019',NULL,'2019-02-01T00:00:00.000+03:00','2019-03-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('eff7fe10-1a2a-4092-81cd-07755f530475','April 2019',NULL,'2019-04-01T00:00:00.000+03:00','2019-04-30T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('948810b0-eb80-417a-9e6c-e14cf372ce5e','April - May 2019',NULL,'2019-04-01T00:00:00.000+03:00','2019-05-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('2ca220da-93fa-4036-a54f-314d03d81a68','June 2019',NULL,'2019-06-01T00:00:00.000+03:00','2019-06-30T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('2c3b5a06-1a13-4a72-9222-c3e87fbe3a58','June - July 2019',NULL,'2019-06-01T00:00:00.000+03:00','2019-07-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('a9f795a3-0e3b-45d8-b6c3-90d6c3ea88de','Aug 2019',NULL,'2019-08-01T00:00:00.000+03:00','2019-08-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('e72f8b82-fb3c-4117-af0f-98f2e8070be0','Aug - Sept 2019',NULL,'2019-08-01T00:00:00.000+03:00','2019-09-30T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('21e04a55-7a28-41df-b391-01892bf8414f','Oct 2019',NULL,'2019-10-01T00:00:00.000+03:00','2019-10-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('be13048b-d2cc-4a25-bd45-f44f5480acdc','Oct - Nov 2019',NULL,'2019-10-01T00:00:00.000+03:00','2019-11-30T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB')),
    ('10c9b4d8-3952-4d1d-9300-741b27cadef6','Dec 2019',NULL,'2019-12-01T00:00:00.000+03:00','2019-12-31T23:59:59.000+03:00',(SELECT id from referencedata.processing_schedules WHERE code = 'groupB'));







INSERT into referencedata.requisition_groups (id, code ,name,description,supervisoryNodeId )values
('3f1a2773-0a66-4501-9782-3a1d1cab04b3', 'DARE-RGILS15A','Morogoro MC - ILS - A','Morogoro MC Requisition Group A - ILS',(select id from referencedata.supervisory_nodes where code='MWAN-SNZ'));

INSERT into referencedata.requisition_group_members ( requisitionGroupId ,facilityId )values
((select id from referencedata. requisition_groups where code ='DARE-RGILS15A'),(select id from referencedata. facilities where code ='MZ520495')),
((select id from referencedata. requisition_groups where code ='DARE-RGILS15A'),(select id from referencedata. facilities where code ='MZ510054'));



insert into referencedata.requisition_group_program_schedules (id, requisitionGroupId , programId , processingscheduleId , directDelivery ) values
('61e63623-ac95-469f-b3ed-facae9d0cd08', (select id from referencedata.requisition_groups where code='DARE-RGILS15A'),(select id from referencedata.programs where code='ilshosp'),(select id from referencedata.processing_schedules where code='groupA'),TRUE);





insert into requisition.requisition_templates (id, name, archived, populatestockonhandfromstockcards) values
('a2ade107-dcac-4e34-ae53-1dcfc6f39d5d', 'ILS redesigned template', false, false);

insert into requisition.requisition_template_assignments (id, templateid, programid, facilityTypeId) values
('74b81822-5649-4834-8f2f-004d8e3ce4ee', (select id from requisition.requisition_templates where name='ILS redesigned template'), (select id from referencedata.programs where code='ilshosp'), (select id from referencedata.facility_types where code ='disp'));



insert into requisition.columns_maps
(requisitioncolumnid, key, name, requisitioncolumnoptionid, requisitiontemplateid, isdisplayed, source, displayOrder, label)
values
    ((select id from requisition.available_requisition_columns where name = 'skipped'),'skipped','skipped','488e6882-563d-4b69-b7eb-fd59e7772a41',(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,1,'Skip'),
    ((select id from requisition.available_requisition_columns where name = 'orderable.productCode'),'orderable.productCode','orderable.productCode',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',2,2,'Namba mpya ya MSD'),
    ((select id from requisition.available_requisition_columns where name = 'orderable.fullProductName'),'orderable.fullProductName','orderable.fullProductName',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',2,3,'Maelezo ya bidhaa'),
    ((select id from requisition.available_requisition_columns where name = 'orderable.dispensable.displayUnit'),'orderable.dispensable.displayUnit','orderable.dispensable.displayUnit',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',2,4,'Kipimo cha Ugavi (U)'),
    ((select id from requisition.available_requisition_columns where name = 'beginningBalance'),'beginningBalance','beginningBalance',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,5,'Kiasi cha kuanzia (A)'),
    ((select id from requisition.available_requisition_columns where name = 'totalReceivedQuantity'),'totalReceivedQuantity','totalReceivedQuantity',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,6,'Kiasi kilichopokelewa (B)'),
    ((select id from requisition.available_requisition_columns where name = 'totalLossesAndAdjustments'),'totalLossesAndAdjustments','totalLossesAndAdjustments',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,7,'Upotevu au Marekebisho (C)'),
    ((select id from requisition.available_requisition_columns where name = 'totalStockoutDays'),'totalStockoutDays','totalStockoutDays',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,8,'Siku Ambazo Dawa Haikuwepo Kituoni (X)'),
    ((select id from requisition.available_requisition_columns where name = 'stockOnHand'),'stockOnHand','stockOnHand',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,9,'Salio la mwisho (D)'),
    ((select id from requisition.available_requisition_columns where name = 'totalConsumedQuantity'),'totalConsumedQuantity','totalConsumedQuantity',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,10,'Matumizi halisi (E)'),
    ((select id from requisition.available_requisition_columns where name = 'adjustedConsumption'),'adjustedConsumption','adjustedConsumption',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',1,11,'Makadirio ya matumizi baada ya marekebisho [E* 60]/]60-X] (Z)'),
    ((select id from requisition.available_requisition_columns where name = 'maximumStockQuantity'),'maximumStockQuantity','maximumStockQuantity','ff2b350c-37f2-4801-b21e-27ca12c12b3c',(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',1,12,'Kiasi cha juu kinachohitajika [Z x 2] (Y)'),
    ((select id from requisition.available_requisition_columns where name = 'calculatedOrderQuantity'),'calculatedOrderQuantity','calculatedOrderQuantity',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',1,13,'Kiasi kinachohitajika kilichokokotolewa [Y - D] (F)'),
    ((select id from requisition.available_requisition_columns where name = 'requestedQuantity'),'requestedQuantity','requestedQuantity',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,14,'Kiasi halisi kinachohitajika (G)'),
    ((select id from requisition.available_requisition_columns where name = 'packsToShip'),'packsToShip','packsToShip','dcf41f06-3000-4af6-acf5-5de4fffc966f',(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',1,15,'Kiasi cha kuagizwa [K/U] (H)'),
    ((select id from requisition.available_requisition_columns where name = 'remarks'),'remarks','remarks',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,16,'Maelezo ya kiasi kilichoidhinishwa'),
    ((select id from requisition.available_requisition_columns where name = 'requestedQuantityExplanation'),'requestedQuantityExplanation','requestedQuantityExplanation',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,17,'Maelezo ya kiasi halisi kinachohitajika'),
    ((select id from requisition.available_requisition_columns where name = 'pricePerPack'),'pricePerPack','pricePerPack',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',2,18,'Bei (I)'),
    ((select id from requisition.available_requisition_columns where name = 'totalCost'),'totalCost','totalCost',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',1,19,'Gharama [H x I] (J)'),
    ((select id from requisition.available_requisition_columns where name = 'approvedQuantity'),'approvedQuantity','approvedQuantity',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'true',0,20,'Kiasi kilichoindinishwa (K)'),
    ((select id from requisition.available_requisition_columns where name = 'total'),'total','total',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'false',1,22,'Total'),
    ((select id from requisition.available_requisition_columns where name = 'averageConsumption'),'averageConsumption','averageConsumption',NULL,(select id from requisition.requisition_templates where name='ILS redesigned template'),'false',1,23,'Average Monthly Consumption(AMC)'),
    ((select id from requisition.available_requisition_columns where name = 'numberOfNewPatientsAdded'),'numberOfNewPatientsAdded','numberOfNewPatientsAdded',(select id from requisition.available_requisition_column_options where optionname = 'newPatientCount'),(select id from requisition.requisition_templates where name='ILS redesigned template'),'false',0,24,'Total number of new patients added to service on the program')
;

insert into stockmanagement.stock_card_line_item_reasons(id,name,description,reasoncategory,reasontype,isfreetextallowed) values
('c1fc3cf3-da18-44b0-a220-77c985202e06','Transfer Out','Transfer Out','TRANSFER','DEBIT',true),
('279d55bd-42e3-438c-a63d-9c021b185dae','Facility return','Facility return','ADJUSTMENT','CREDIT',false),
('5b09202e-b8a7-4f77-9e0e-8156f8efc613','Damage','Damage','ADJUSTMENT','DEBIT',false),
('3e7940db-49a5-492f-a4eb-75acb981dd2b','Expired','Expired','ADJUSTMENT','DEBIT',false),
('09e1d05d-f736-4834-9346-c27196a99eae','Stolen','Stolen','ADJUSTMENT','DEBIT',false),
('b7e99f5b-af04-433d-9c30-d4f90c60c47b','Lost','Lost','ADJUSTMENT','DEBIT',true),
('30f6002d-a78d-44db-b2b9-46e76795a188','Passed open-vial time limit','Passed open-vial time limit','ADJUSTMENT','DEBIT',false),
('6f8d0431-6ec5-4280-9019-c6024b168b23','Cold chain failure','Cold chain failure','ADJUSTMENT','DEBIT',false);


insert into auth.auth_users (id,enabled,password,username) values
((select id from referencedata.users where username = 'StoreInCharge'),TRUE,'$2a$10$4IZfidcJzbR5Krvj87ZJdOZvuQoD/kvPAJe549rUNoP3N3uH0Lq2G','StoreInCharge'),
((select id from referencedata.users where username = 'FacilityInCharge'),TRUE,'$2a$10$4IZfidcJzbR5Krvj87ZJdOZvuQoD/kvPAJe549rUNoP3N3uH0Lq2G','FacilityInCharge'),
((select id from referencedata.users where username = 'lmu'),TRUE,'$2a$10$4IZfidcJzbR5Krvj87ZJdOZvuQoD/kvPAJe549rUNoP3N3uH0Lq2G','lmu'),
((select id from referencedata.users where username = 'Admin123'),TRUE,'$2a$10$4IZfidcJzbR5Krvj87ZJdOZvuQoD/kvPAJe549rUNoP3N3uH0Lq2G','Admin123');

insert into notification.user_contact_details (referenceDataUserId,phoneNumber,email,allowNotify,emailVerified) values
((select id from referencedata.users where username = 'StoreInCharge'),NULL,'Fatima_Doe@openlmis.com','false','true'),
((select id from referencedata.users where username = 'FacilityInCharge'),NULL,'Jane_Doe@openlmis.com','false','true'),
((select id from referencedata.users where username = 'lmu'),NULL,'Frank_Doe@openlmis.com','false','true'),
((select id from referencedata.users where username = 'Admin123'),NULL,'John_Doe@openlmis.com','false','true');




insert into  stockmanagement.valid_reason_assignments (id,programId,facilityTypeId,reasonId,hidden) VALUES
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='disp'),'b5c27da7-bdda-4790-925a-9484c5dfb594', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='heac'),'b5c27da7-bdda-4790-925a-9484c5dfb594', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='ddho'),'b5c27da7-bdda-4790-925a-9484c5dfb594', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='disp'),'313f2f5f-0c22-4626-8c49-3554ef763de3', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='heac'),'313f2f5f-0c22-4626-8c49-3554ef763de3', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='ddho'),'313f2f5f-0c22-4626-8c49-3554ef763de3', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='disp'),'84eb13c3-3e54-4687-8a5f-a9f20dcd0dac', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='heac'),'84eb13c3-3e54-4687-8a5f-a9f20dcd0dac', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='ddho'),'84eb13c3-3e54-4687-8a5f-a9f20dcd0dac', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='disp'),'f8bb41e2-ab43-4781-ae7a-7bf3b5116b82', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='heac'),'f8bb41e2-ab43-4781-ae7a-7bf3b5116b82', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='ddho'),'f8bb41e2-ab43-4781-ae7a-7bf3b5116b82', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='disp'),'9b4b653a-f319-4a1b-bb80-8d6b4dd6cc12', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='heac'),'9b4b653a-f319-4a1b-bb80-8d6b4dd6cc12', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='ddho'),'9b4b653a-f319-4a1b-bb80-8d6b4dd6cc12', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='disp'),'0676fdea-9ba8-4e6d-ae26-bb14f0dcfecd', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='heac'),'0676fdea-9ba8-4e6d-ae26-bb14f0dcfecd', true ),
(uuid_generate_v4(), (select id from referencedata.programs  where code='ilshosp'), (select id from referencedata.facility_types where code='ddho'),'0676fdea-9ba8-4e6d-ae26-bb14f0dcfecd', true );


INSERT INTO referencedata.right_assignments(id,rightname,facilityid,programid,userid) VALUES
('e41208a0-803d-4253-8ca3-1c5fddae45f6','REQUISITION_VIEW','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','a3c2508d-f46c-42b7-ab21-7a0fdfa0071e'),
('1ecf3f77-ead8-409a-85c0-35a99ca2c3de','REQUISITION_AUTHORIZE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','a3c2508d-f46c-42b7-ab21-7a0fdfa0071e'),
('e44db7f2-237e-4ae1-8ffd-a78c22ace96c','REQUISITION_CREATE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','5806ca9e-24e0-4b40-9638-f551e6048e27'),
('dd00584d-80f4-49fa-9d91-23499d245226','PROCESSING_SCHEDULES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('b0106b29-ff10-4509-9d3d-95960235ab86','SUPPLY_LINES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('771d81f3-60ac-4f8e-9993-dd0a7538f27e','REQUISITION_TEMPLATES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('e826c4db-842f-4d2d-89cc-55e8d164ab0f','USER_ROLES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('ca1e2d36-eed3-4e6f-bdeb-cd2d75753edd','STOCK_CARD_TEMPLATES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('3184d624-b92b-40be-923d-e381ed8e8989','PROCESSING_SCHEDULES_MANAGE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','81104549-a8e0-454d-86c8-dada103365e1'),
('aaf0fcb8-44bd-4a79-9fb1-a53f882eb737','REPORT_TEMPLATES_EDIT','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','81104549-a8e0-454d-86c8-dada103365e1'),
('5e57fe3e-34f9-452b-a1f8-4b5fd4bbd7d2','REQUISITION_TEMPLATES_MANAGE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','81104549-a8e0-454d-86c8-dada103365e1'),
('c002d54f-acc4-4acb-a22c-44f1f7daef68','STOCK_CARD_LINE_ITEM_REASONS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('5faef6dc-6a51-4012-9c41-b1faafae9605','REQUISITION_VIEW','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','c86bfd2c-7a22-4911-a9bc-0921c34681de'),
('491ce931-b7fa-43a2-ab6f-0b99bd1c99f7','FACILITIES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('cbb0dcd4-7a4f-49bf-8393-5d2b127acd32','STOCK_DESTINATIONS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('47a1387c-ea05-4aca-abec-7daa1aa5f7dd','RIGHTS_VIEW',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('20440d69-a2b0-4d20-96cb-48568b59c040','STOCK_SOURCES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('1a0ac602-d7d5-4216-81cb-ac7611ee6d3a','SUPERVISORY_NODES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('7eefac26-9a24-46ea-8ce4-027d10b087ad','REQUISITION_DELETE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','a3c2508d-f46c-42b7-ab21-7a0fdfa0071e'),
('3dd9b43c-edb9-47cf-aa6b-2a40a55d4b2b','REQUISITION_GROUPS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('71228d3b-21f8-4c2b-9e15-ef2d6073c4ef','SERVICE_ACCOUNTS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('7041a54f-bc31-434d-af78-b66ee53b226b','SYSTEM_SETTINGS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('27f84103-c7ca-4047-9dd2-de9a5c4bcff8','STOCK_ORGANIZATIONS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('c815d60a-00ea-4b36-bf05-1a566de24c34','REQUISITION_DELETE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','5806ca9e-24e0-4b40-9638-f551e6048e27'),
('4c60c21a-2036-4440-8064-d8c5ad8fd977','PROGRAMS_MANAGE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','81104549-a8e0-454d-86c8-dada103365e1'),
('d13ef734-c48c-4832-a107-b85667ec421b','SUPPLY_PARTNERS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('ecdac4d7-3085-43d1-980c-09ee1cb4dc58','STOCK_ADJUSTMENT_REASONS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('5ff0827d-447a-4335-9b21-baa8b2de548a','SYSTEM_SETTINGS_MANAGE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','81104549-a8e0-454d-86c8-dada103365e1'),
('16d0068b-4851-4af1-8da0-3b044ad83c6b','CCE_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('fa2533ae-4dc6-4fba-8bf8-8144334a8dfc','FACILITIES_MANAGE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','81104549-a8e0-454d-86c8-dada103365e1'),
('19e42c08-cbea-46f9-9652-8fa97cdf9ded','USERS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('f454452d-41dc-4a08-a486-bd505b95ae40','USER_ROLES_MANAGE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','81104549-a8e0-454d-86c8-dada103365e1'),
('7f518aac-1cc9-4650-9149-35523f2d355d','REQUISITION_VIEW','14617116-12d5-4617-aad0-004c8a2cb83e','19ef7927-2597-4f75-b594-a0807d71f14a','c86bfd2c-7a22-4911-a9bc-0921c34681de'),
('7a2b6391-6b6b-47f7-bd24-3faa9850269c','FACILITY_APPROVED_ORDERABLES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('5f9ac286-e319-4ded-b579-a4208591e4bb','ORDERABLES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('9dccb71e-7d9a-40e3-884b-9b6737e3d79a','GEOGRAPHIC_ZONES_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('b2e4dc3d-f949-4b98-a5bd-15dce8787187','SYSTEM_NOTIFICATIONS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('f95d083a-8794-4ee3-9625-64d8cd84a6dc','REQUISITION_VIEW','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','5806ca9e-24e0-4b40-9638-f551e6048e27'),
('9e767bd1-0e48-480c-9cf7-c7ae5f156d10','REPORTS_VIEW','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','81104549-a8e0-454d-86c8-dada103365e1'),
('d7c453f5-edb2-4c87-8255-57bbec4d0fe1','PROGRAMS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462'),
('3c4f2d12-8ca2-4568-a702-686dfc541811','USERS_MANAGE','47cb7b3f-caf0-4164-bf09-46ed5192d3e2','19ef7927-2597-4f75-b594-a0807d71f14a','81104549-a8e0-454d-86c8-dada103365e1'),
('855c2c8e-39cb-44ee-a471-03c4002b17e6','SYSTEM_IDEAL_STOCK_AMOUNTS_MANAGE',NULL,NULL,'35316636-6264-6331-2d34-3933322d3462');
