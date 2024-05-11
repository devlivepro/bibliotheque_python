BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "membres_mediaconsulte" (
	"id"	integer NOT NULL,
	"titre"	varchar(100) NOT NULL,
	"auteur"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "bibliotheque_dvd" (
	"media_ptr_id"	bigint NOT NULL,
	"duree_minutes"	integer NOT NULL,
	PRIMARY KEY("media_ptr_id"),
	FOREIGN KEY("media_ptr_id") REFERENCES "bibliotheque_media"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "bibliotheque_cd" (
	"media_ptr_id"	bigint NOT NULL,
	"duree_minutes"	integer NOT NULL,
	PRIMARY KEY("media_ptr_id"),
	FOREIGN KEY("media_ptr_id") REFERENCES "bibliotheque_media"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "bibliotheque_jeudeplateau" (
	"id"	integer NOT NULL,
	"createur"	varchar(100) NOT NULL,
	"titre"	varchar(100) NOT NULL,
	"disponible"	bool NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "bibliotheque_livre" (
	"media_ptr_id"	bigint NOT NULL,
	"nb_pages"	integer NOT NULL,
	PRIMARY KEY("media_ptr_id"),
	FOREIGN KEY("media_ptr_id") REFERENCES "bibliotheque_media"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "bibliotheque_media" (
	"id"	integer NOT NULL,
	"titre"	varchar(255) NOT NULL,
	"auteur"	varchar(255),
	"disponible"	bool NOT NULL,
	"type"	varchar(20) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "membres_membre" (
	"id"	integer NOT NULL,
	"nom"	varchar(100) NOT NULL,
	"bloque"	bool NOT NULL,
	"nb_emprunts"	integer NOT NULL,
	"media_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("media_id") REFERENCES "bibliotheque_media"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "bibliotheque_membre" (
	"id"	integer NOT NULL,
	"nom"	varchar(100) NOT NULL,
	"nb_emprunts"	integer NOT NULL,
	"bloque"	bool NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "bibliotheque_emprunt" (
	"id"	integer NOT NULL,
	"date_emprunt"	date NOT NULL,
	"media_id"	bigint NOT NULL,
	"membre_id"	bigint NOT NULL,
	"date_retour_prevue"	date NOT NULL,
	"est_rendu"	bool NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("media_id") REFERENCES "bibliotheque_media"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("membre_id") REFERENCES "bibliotheque_membre"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (1,'contenttypes','0001_initial','2024-04-26 19:39:36.808849'),
 (2,'auth','0001_initial','2024-04-26 19:39:36.848530'),
 (3,'admin','0001_initial','2024-04-26 19:39:36.886722'),
 (4,'admin','0002_logentry_remove_auto_add','2024-04-26 19:39:36.978481'),
 (5,'admin','0003_logentry_add_action_flag_choices','2024-04-26 19:39:37.034034'),
 (6,'contenttypes','0002_remove_content_type_name','2024-04-26 19:39:37.059353'),
 (7,'auth','0002_alter_permission_name_max_length','2024-04-26 19:39:37.081154'),
 (8,'auth','0003_alter_user_email_max_length','2024-04-26 19:39:37.099505'),
 (9,'auth','0004_alter_user_username_opts','2024-04-26 19:39:37.114385'),
 (10,'auth','0005_alter_user_last_login_null','2024-04-26 19:39:37.138689'),
 (11,'auth','0006_require_contenttypes_0002','2024-04-26 19:39:37.151089'),
 (12,'auth','0007_alter_validators_add_error_messages','2024-04-26 19:39:37.170957'),
 (13,'auth','0008_alter_user_username_max_length','2024-04-26 19:39:37.193746'),
 (14,'auth','0009_alter_user_last_name_max_length','2024-04-26 19:39:37.220033'),
 (15,'auth','0010_alter_group_name_max_length','2024-04-26 19:39:37.243345'),
 (16,'auth','0011_update_proxy_permissions','2024-04-26 19:39:37.256241'),
 (17,'auth','0012_alter_user_first_name_max_length','2024-04-26 19:39:37.294929'),
 (18,'membres','0001_initial','2024-04-26 19:39:37.306833'),
 (19,'bibliotheque','0001_initial','2024-04-26 19:39:37.336096'),
 (20,'sessions','0001_initial','2024-04-26 19:39:37.364369'),
 (21,'bibliotheque','0002_emprunt_media_membre_delete_jeudeplateau_and_more','2024-04-27 09:26:53.402597'),
 (22,'membres','0002_mediaconsulte_membre_nb_emprunts','2024-04-27 09:26:53.426929'),
 (23,'bibliotheque','0003_jeudeplateau','2024-04-27 09:38:34.216181'),
 (25,'bibliotheque','0004_remove_cd_duree_minutes_alter_cd_media_ptr_and_more','2024-04-27 11:36:01.521516'),
 (26,'bibliotheque','0005_rename_nom_jeudeplateau_titre_cd_duree_minutes_and_more','2024-04-27 12:22:11.046863'),
 (27,'bibliotheque','0006_remove_media_type_media_type_media','2024-04-27 20:44:38.549125'),
 (30,'bibliotheque','0007_remove_media_type_media_media_type','2024-04-28 13:38:07.380564'),
 (31,'bibliotheque','0008_alter_livre_nb_pages_alter_media_auteur_and_more','2024-04-28 13:38:07.416798'),
 (32,'membres','0003_membre_media','2024-04-28 14:01:00.486305'),
 (33,'bibliotheque','0009_emprunt_est_rendu','2024-04-28 15:35:33.805057'),
 (34,'membres','0004_alter_membre_table','2024-04-28 15:58:17.674539'),
 (35,'bibliotheque','0010_membre_media_id','2024-04-28 17:06:06.595971'),
 (36,'bibliotheque','0011_remove_membre_media_id','2024-04-28 17:10:18.604408'),
 (37,'bibliotheque','0012_remove_emprunt_date_retour_remove_emprunt_est_rendu_and_more','2024-04-28 17:30:20.489105'),
 (38,'bibliotheque','0013_emprunt_est_rendu','2024-04-28 17:34:12.975963');
INSERT INTO "django_admin_log" ("id","object_id","object_repr","action_flag","change_message","content_type_id","user_id","action_time") VALUES (1,'1','Les Misérables',1,'[{"added": {}}]',10,1,'2024-04-27 09:30:48.185933'),
 (2,'2','Greatest Hits',1,'[{"added": {}}]',8,1,'2024-04-27 09:41:28.552107'),
 (3,'3','Inception',1,'[{"added": {}}]',9,1,'2024-04-27 09:42:21.797651'),
 (4,'1','Catan',1,'[{"added": {}}]',7,1,'2024-04-27 09:43:04.590996'),
 (5,'1','Damien',1,'[{"added": {}}]',11,1,'2024-04-27 09:43:32.507832'),
 (6,'1','Catan',2,'[]',7,1,'2024-04-27 12:53:45.595911'),
 (7,'1','Rose',1,'[{"added": {}}]',14,1,'2024-04-27 13:15:17.740108'),
 (8,'2','coco',3,'',14,1,'2024-04-27 13:24:33.688124'),
 (9,'1','jean1 - Les Misérables',2,'[{"changed": {"fields": ["Date retour"]}}]',12,1,'2024-04-27 16:10:31.127396'),
 (10,'3','Rose2 - Greatest Hits',3,'',12,1,'2024-04-27 18:54:08.946250'),
 (11,'2','Rose2 - Inception',3,'',12,1,'2024-04-27 18:54:08.960610'),
 (12,'1','jean1 - Les Misérables',3,'',12,1,'2024-04-27 18:54:08.974995'),
 (13,'2','Greatest Hits - CD',2,'[{"changed": {"fields": ["Disponible"]}}]',8,1,'2024-04-27 18:54:25.509632'),
 (14,'3','Inception - DVD',2,'[{"changed": {"fields": ["Disponible"]}}]',9,1,'2024-04-27 18:54:31.021674'),
 (15,'1','Catan',2,'[]',7,1,'2024-04-27 18:54:36.727653'),
 (16,'1','Les Misérables - Livre',2,'[{"changed": {"fields": ["Disponible"]}}]',10,1,'2024-04-27 18:54:40.981344'),
 (17,'1','Catan',3,'',7,1,'2024-04-27 18:57:44.985741'),
 (18,'2','Catan',1,'[{"added": {}}]',7,1,'2024-04-27 18:58:19.125881'),
 (19,'2','Catan',2,'[{"changed": {"fields": ["Disponible"]}}]',7,1,'2024-04-27 19:12:38.243336'),
 (20,'2','Catan',2,'[{"changed": {"fields": ["Disponible"]}}]',7,1,'2024-04-27 19:12:45.794432'),
 (21,'3','test',1,'[{"added": {}}]',7,1,'2024-04-27 19:13:55.728870'),
 (22,'3','test - Jeu de plateau',3,'',7,1,'2024-04-27 20:07:50.239429'),
 (23,'4','Pasteur - CD',2,'[{"changed": {"fields": ["Type"]}}]',8,1,'2024-04-27 20:24:58.291093'),
 (24,'4','Pasteur - CD',3,'',8,1,'2024-04-27 20:45:11.732482'),
 (25,'1','Les Misérables - Livre',2,'[{"changed": {"fields": ["Type"]}}]',10,1,'2024-04-28 08:16:47.926422'),
 (26,'1','Les Misérables - Livre',2,'[{"changed": {"fields": ["Disponible"]}}]',10,1,'2024-04-28 08:41:53.863660'),
 (27,'1','Les Misérables - Livre',2,'[{"changed": {"fields": ["Disponible"]}}]',10,1,'2024-04-28 08:42:00.406388'),
 (28,'4','jean1 - Les Misérables',1,'[{"added": {}}]',12,1,'2024-04-28 09:31:53.489694'),
 (29,'2','Greatest Hits',3,'',8,1,'2024-04-28 14:12:03.072735'),
 (30,'11','MK',1,'[{"added": {}}]',8,1,'2024-04-28 14:12:32.275200'),
 (31,'12',' - DVD',3,'',9,1,'2024-05-06 19:24:56.253244'),
 (32,'13','testtitre',1,'[{"added": {}}]',8,1,'2024-05-07 07:52:07.300376'),
 (33,'13','testtitre - CD',3,'',8,1,'2024-05-07 08:02:17.934176'),
 (34,'1','Les Misérables - Livre',3,'',10,1,'2024-05-07 08:49:55.952076'),
 (35,'14','Les Misérables - Livre',2,'[{"changed": {"fields": ["Titre", "Auteur"]}}]',10,1,'2024-05-07 08:50:18.894722'),
 (36,'15','testtitre - Livre',3,'',10,1,'2024-05-07 09:12:42.941865'),
 (37,'17','testtitre2 - Livre',3,'',10,1,'2024-05-07 10:20:58.413237'),
 (38,'16','testtitre - Livre',3,'',10,1,'2024-05-07 10:20:58.422659'),
 (39,'48','testtitreqq - CD',3,'',8,1,'2024-05-07 12:13:19.376757'),
 (40,'38','qdqd - CD',3,'',8,1,'2024-05-07 12:13:19.398771'),
 (41,'36','testtitreqddqd - CD',3,'',8,1,'2024-05-07 12:13:19.417620'),
 (42,'32','dqq - CD',3,'',8,1,'2024-05-07 12:13:19.437935'),
 (43,'30','qq - CD',3,'',8,1,'2024-05-07 12:13:19.453191'),
 (44,'28','qqq - CD',3,'',8,1,'2024-05-07 12:13:19.462595'),
 (45,'26','qdqqqq - CD',3,'',8,1,'2024-05-07 12:13:19.473733'),
 (46,'22','testtitre - CD',3,'',8,1,'2024-05-07 12:13:19.489578'),
 (47,'46','pmll - DVD',3,'',9,1,'2024-05-07 12:13:26.637383'),
 (48,'44','qdqdqd - DVD',3,'',9,1,'2024-05-07 12:13:26.654308'),
 (49,'42','qdqd - DVD',3,'',9,1,'2024-05-07 12:13:26.671311'),
 (50,'40','dqd - DVD',3,'',9,1,'2024-05-07 12:13:26.685196'),
 (51,'34','dqdqd - DVD',3,'',9,1,'2024-05-07 12:13:26.699738'),
 (52,'24','qfqfq - Livre',3,'',10,1,'2024-05-07 12:13:33.444095'),
 (53,'20','gssgg - Livre',3,'',10,1,'2024-05-07 12:13:33.459549'),
 (54,'18','testtitre - Livre',3,'',10,1,'2024-05-07 12:13:33.495344'),
 (55,'4','dqd - Jeu de plateau',3,'',7,1,'2024-05-07 12:16:42.573584'),
 (56,'52','testtitre2 - DVD',3,'',9,1,'2024-05-07 12:16:47.682216'),
 (57,'50','testtitre - CD',3,'',8,1,'2024-05-07 12:16:52.285937'),
 (58,'57','qdqdd - CD',3,'',8,1,'2024-05-07 12:28:53.299077'),
 (59,'59','dqdqd - DVD',3,'',9,1,'2024-05-07 12:28:57.852587'),
 (60,'5','fqff - Jeu de plateau',3,'',7,1,'2024-05-07 12:29:04.338908'),
 (61,'55','testtitre - Livre',3,'',10,1,'2024-05-07 12:29:10.047904'),
 (62,'62','testtitre - Livre',3,'',10,1,'2024-05-07 12:38:11.215760'),
 (63,'64','testtitre - CD',3,'',8,1,'2024-05-07 12:38:26.658759'),
 (64,'66','yrdgsg - DVD',3,'',9,1,'2024-05-07 12:38:47.490729'),
 (65,'6','testtitre - Jeu de plateau',3,'',7,1,'2024-05-07 12:39:10.287951'),
 (66,'69','Boogie - CD',3,'',8,1,'2024-05-09 07:26:16.830841');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'admin','logentry'),
 (2,'auth','permission'),
 (3,'auth','group'),
 (4,'auth','user'),
 (5,'contenttypes','contenttype'),
 (6,'sessions','session'),
 (7,'bibliotheque','jeudeplateau'),
 (8,'bibliotheque','cd'),
 (9,'bibliotheque','dvd'),
 (10,'bibliotheque','livre'),
 (11,'membres','membre'),
 (12,'bibliotheque','emprunt'),
 (13,'bibliotheque','media'),
 (14,'bibliotheque','membre'),
 (15,'membres','mediaconsulte');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_logentry','Can add log entry'),
 (2,1,'change_logentry','Can change log entry'),
 (3,1,'delete_logentry','Can delete log entry'),
 (4,1,'view_logentry','Can view log entry'),
 (5,2,'add_permission','Can add permission'),
 (6,2,'change_permission','Can change permission'),
 (7,2,'delete_permission','Can delete permission'),
 (8,2,'view_permission','Can view permission'),
 (9,3,'add_group','Can add group'),
 (10,3,'change_group','Can change group'),
 (11,3,'delete_group','Can delete group'),
 (12,3,'view_group','Can view group'),
 (13,4,'add_user','Can add user'),
 (14,4,'change_user','Can change user'),
 (15,4,'delete_user','Can delete user'),
 (16,4,'view_user','Can view user'),
 (17,5,'add_contenttype','Can add content type'),
 (18,5,'change_contenttype','Can change content type'),
 (19,5,'delete_contenttype','Can delete content type'),
 (20,5,'view_contenttype','Can view content type'),
 (21,6,'add_session','Can add session'),
 (22,6,'change_session','Can change session'),
 (23,6,'delete_session','Can delete session'),
 (24,6,'view_session','Can view session'),
 (25,7,'add_jeudeplateau','Can add jeu de plateau'),
 (26,7,'change_jeudeplateau','Can change jeu de plateau'),
 (27,7,'delete_jeudeplateau','Can delete jeu de plateau'),
 (28,7,'view_jeudeplateau','Can view jeu de plateau'),
 (29,8,'add_cd','Can add cd'),
 (30,8,'change_cd','Can change cd'),
 (31,8,'delete_cd','Can delete cd'),
 (32,8,'view_cd','Can view cd'),
 (33,9,'add_dvd','Can add dvd'),
 (34,9,'change_dvd','Can change dvd'),
 (35,9,'delete_dvd','Can delete dvd'),
 (36,9,'view_dvd','Can view dvd'),
 (37,10,'add_livre','Can add livre'),
 (38,10,'change_livre','Can change livre'),
 (39,10,'delete_livre','Can delete livre'),
 (40,10,'view_livre','Can view livre'),
 (41,11,'add_membre','Can add membre'),
 (42,11,'change_membre','Can change membre'),
 (43,11,'delete_membre','Can delete membre'),
 (44,11,'view_membre','Can view membre'),
 (45,12,'add_emprunt','Can add emprunt'),
 (46,12,'change_emprunt','Can change emprunt'),
 (47,12,'delete_emprunt','Can delete emprunt'),
 (48,12,'view_emprunt','Can view emprunt'),
 (49,13,'add_media','Can add media'),
 (50,13,'change_media','Can change media'),
 (51,13,'delete_media','Can delete media'),
 (52,13,'view_media','Can view media'),
 (53,14,'add_membre','Can add membre'),
 (54,14,'change_membre','Can change membre'),
 (55,14,'delete_membre','Can delete membre'),
 (56,14,'view_membre','Can view membre'),
 (57,15,'add_mediaconsulte','Can add media consulte'),
 (58,15,'change_mediaconsulte','Can change media consulte'),
 (59,15,'delete_mediaconsulte','Can delete media consulte'),
 (60,15,'view_mediaconsulte','Can view media consulte');
INSERT INTO "auth_user" ("id","password","last_login","is_superuser","username","last_name","email","is_staff","is_active","date_joined","first_name") VALUES (1,'pbkdf2_sha256$720000$NAW1tEyQWAiPtCPsQ0bSgf$9Udgx1D1uXY/FUOO5DO8zjn9ra8DvGIQQEeV1RjBNnU=','2024-05-09 07:25:54.896184',1,'admin','','david.saadoun@hotmail.com',1,1,'2024-04-27 09:08:16.003922','');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('ywonjy1vpr2n3dvwdo4cyrhow4amt8eu','.eJxVjEEOwiAQRe_C2hAGqAWX7nsGMsOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hZnERIE6_G2F8pLoDvmO9NRlbXZeZ5K7Ig3Y5NU7P6-H-HRTs5VufkyGOGcgots5FZKeQDMPgIRFmp5h9Qhy1sxrQkIJRR6DsyQ4uZvH-AA5fONk:1s1AVR:gQeN_SWcT2b62noZzUvVjzuK53vxoHOmGicntdD3J8I','2024-05-12 19:48:13.324749'),
 ('1df1k799uqmk8qmojoiky8xcztvwm9n3','.eJxVjEEOwiAQRe_C2hAGqAWX7nsGMsOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hZnERIE6_G2F8pLoDvmO9NRlbXZeZ5K7Ig3Y5NU7P6-H-HRTs5VufkyGOGcgots5FZKeQDMPgIRFmp5h9Qhy1sxrQkIJRR6DsyQ4uZvH-AA5fONk:1s3sQy:rFZmaVqvm-_v2eLiOhjmBUk1PEOdLskGrowp23RU-kQ','2024-05-20 07:06:48.003523'),
 ('uy74a8wce62xd0uwc33b3papbyiwxx0a','.eJxVjEEOwiAQRe_C2hAGqAWX7nsGMsOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hZnERIE6_G2F8pLoDvmO9NRlbXZeZ5K7Ig3Y5NU7P6-H-HRTs5VufkyGOGcgots5FZKeQDMPgIRFmp5h9Qhy1sxrQkIJRR6DsyQ4uZvH-AA5fONk:1s3w54:to1MvgotAqiDI7XIBEnrmUFla84ORlmcql_VdBZYtRw','2024-05-20 11:00:26.047209'),
 ('joi4rfur6joi4ixztcjc1clnnymq50x1','.eJxVjEEOwiAQRe_C2hAGqAWX7nsGMsOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hZnERIE6_G2F8pLoDvmO9NRlbXZeZ5K7Ig3Y5NU7P6-H-HRTs5VufkyGOGcgots5FZKeQDMPgIRFmp5h9Qhy1sxrQkIJRR6DsyQ4uZvH-AA5fONk:1s46FY:Ot_ox5P_fd7VgY1JI5eazDUFMX8QMODb8-MZZXe_2WQ','2024-05-20 21:51:56.219004'),
 ('u7zflvpu668exyzvkbltf1g9h3v1fvm7','.eJxVjEEOwiAQRe_C2hAGqAWX7nsGMsOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hZnERIE6_G2F8pLoDvmO9NRlbXZeZ5K7Ig3Y5NU7P6-H-HRTs5VufkyGOGcgots5FZKeQDMPgIRFmp5h9Qhy1sxrQkIJRR6DsyQ4uZvH-AA5fONk:1s4HUZ:9xmE9fjWzE_ZEsztowidqKtsWBqXJl3FpZd4TflL5iY','2024-05-21 09:52:11.814582'),
 ('wuxcsmxmyzksdrpxfh8292coxp816r4t','.eJxVjEEOwiAQRe_C2hAGqAWX7nsGMsOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hZnERIE6_G2F8pLoDvmO9NRlbXZeZ5K7Ig3Y5NU7P6-H-HRTs5VufkyGOGcgots5FZKeQDMPgIRFmp5h9Qhy1sxrQkIJRR6DsyQ4uZvH-AA5fONk:1s4Hz1:NfK5ICpa5n4cMAC5vc8D3o_m_91B2X9qpVo6klTcDmI','2024-05-21 10:23:39.679810'),
 ('f1uxh044evjn61aiqie1vjze3p3k56rt','.eJxVjEEOwiAQRe_C2hAGqAWX7nsGMsOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hZnERIE6_G2F8pLoDvmO9NRlbXZeZ5K7Ig3Y5NU7P6-H-HRTs5VufkyGOGcgots5FZKeQDMPgIRFmp5h9Qhy1sxrQkIJRR6DsyQ4uZvH-AA5fONk:1s4I1P:ZKANgStAm7X1F2jfFRs5XREyEcbBodmEbABpjs3OQa4','2024-05-21 10:26:07.500611'),
 ('ruyuappw20fazgaaoih1llgv7hp67e6y','.eJxVjEEOwiAQRe_C2hAGqAWX7nsGMsOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hZnERIE6_G2F8pLoDvmO9NRlbXZeZ5K7Ig3Y5NU7P6-H-HRTs5VufkyGOGcgots5FZKeQDMPgIRFmp5h9Qhy1sxrQkIJRR6DsyQ4uZvH-AA5fONk:1s4JGF:D9Ns9drhK11zred6UxYAjXAnEKrTGy0E7xGI52guOdg','2024-05-21 11:45:31.789379'),
 ('wt9vfqqh1ldsqq8mqnmh0p4cg0ii8u7i','.eJxVjEEOwiAQRe_C2hAGqAWX7nsGMsOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hZnERIE6_G2F8pLoDvmO9NRlbXZeZ5K7Ig3Y5NU7P6-H-HRTs5VufkyGOGcgots5FZKeQDMPgIRFmp5h9Qhy1sxrQkIJRR6DsyQ4uZvH-AA5fONk:1s4yA6:JTu0xfGjDIIE0I-lzSdSx_O7WUuzWPOmOaG3jzv5YCU','2024-05-23 07:25:54.956471');
INSERT INTO "bibliotheque_dvd" ("media_ptr_id","duree_minutes") VALUES (3,148);
INSERT INTO "bibliotheque_cd" ("media_ptr_id","duree_minutes") VALUES (11,100);
INSERT INTO "bibliotheque_jeudeplateau" ("id","createur","titre","disponible") VALUES (2,'Klaus Teuber','Catan',1);
INSERT INTO "bibliotheque_livre" ("media_ptr_id","nb_pages") VALUES (14,5);
INSERT INTO "bibliotheque_media" ("id","titre","auteur","disponible","type") VALUES (3,'Inception','Christopher Nolan',1,'dvd'),
 (10,'Catan','moi',1,'jeu'),
 (11,'MK','Mickael Jakscon',1,'cd'),
 (14,'Les Misérables','Christopher Nolan',1,'livre'),
 (68,'Boogie','musique',1,'cd');
INSERT INTO "bibliotheque_membre" ("id","nom","nb_emprunts","bloque") VALUES (2,'robert',-2,0);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "membres_membre_media_id_459a6152" ON "membres_membre" (
	"media_id"
);
CREATE INDEX IF NOT EXISTS "bibliotheque_emprunt_media_id_d7299e06" ON "bibliotheque_emprunt" (
	"media_id"
);
CREATE INDEX IF NOT EXISTS "bibliotheque_emprunt_membre_id_29510acc" ON "bibliotheque_emprunt" (
	"membre_id"
);
COMMIT;
