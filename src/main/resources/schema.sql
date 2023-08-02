--################################
--###                          ###
--### Author: Kevin Tumbo      ###
--### Version: 1.0.0           ###
--###                          ###
--################################

--/*
-- *---General Rules ---
-- * Use underscore_names instead of CamelCase
-- * Table names should be plural
-- * Spell out id fields (item_id instead of id)
-- * Don't use ambiguous column names'
-- * Name foreign key columns the same as the  columns they refer to
-- */
CREATE SCHEMA IF NOT EXISTS documentgenerator;

 USE documentgenerator;
 -- -----------------------------------------------------
 -- Table `documentgenerator`.`Users`
 -- -----------------------------------------------------
 DROP TABLE IF EXISTS Users;

 CREATE TABLE Users (
   id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   first_name   VARCHAR(50) NOT NULL,
   last_name    VARCHAR(50) NOT NULL,
   email        VARCHAR(100) NOT NULL,
   password     VARCHAR(255) NOT NULL,
   address      VARCHAR(255) NOT NULL,
   phone        VARCHAR(30) NOT NULL,
   title        VARCHAR(50) NOT NULL,
   bio          VARCHAR(255) NOT NULL,
   enabled      BOOLEAN DEFAULT FALSE,
   non_locked   BOOLEAN DEFAULT TRUE,
   using_mfa    BOOLEAN DEFAULT FALSE,
   created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   image_url    VARCHAR(255) DEFAULT 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
   CONSTRAINT UQ_Users_Email UNIQUE (email)
);

 -- -----------------------------------------------------
 -- Table `documentgenerator`.`Roles`
 -- -----------------------------------------------------
 DROP TABLE IF EXISTS Roles;

 CREATE TABLE Roles (
   id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name       VARCHAR(50) NOT NULL,
   permission VARCHAR(255) NOT NULL,
   CONSTRAINT UQ_Roles_Name UNIQUE (name)
  );

 -- -----------------------------------------------------
  -- Table `documentgenerator`.`Roles`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS UserRoles;

  CREATE TABLE UserRoles (
    id          BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id     BIGINT UNSIGNED NOT NULL,
    role_id     BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (role_id) REFERENCES Roles (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT UQ_UserRoles_User_Id UNIQUE (user_id)
  );

-- -----------------------------------------------------
-- Table `documentgenerator`.`EVENTS`
-- -----------------------------------------------------
  DROP TABLE IF EXISTS Events;

  CREATE TABLE Events (
   id          BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   type        VARCHAR(50) NOT NULL CHECK(type IN ('LOGIN_ATTEMPT','LOGIN_ATTEMPT_FAILURE','LOGIN_ATTEMPT_SUCCESS','PROFILE_UPDATE','PROFILE_PICTURE_UPDATE','ROLE_UPDATE', 'ACCOUNT_SETTINGS_UPDATE', 'PASSWORD_UPDATE', 'MFA_UPDATE')),
   description VARCHAR(255) NOT NULL,
   CONSTRAINT  UQ_Events_Type UNIQUE (type)
 );

  -------------------------------------------------------
  -- Table `documentgenerator`.`UserEvents`
  -------------------------------------------------------
   DROP TABLE IF EXISTS UserEvents;

   CREATE TABLE UserEvents (
     id          BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     user_id     BIGINT UNSIGNED NOT NULL,
     event_id    BIGINT UNSIGNED NOT NULL,
     device      VARCHAR(255) DEFAULT NULL,
     ip_address  VARCHAR(255) DEFAULT NULL,
     created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
     FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (event_id) REFERENCES Roles (id) ON DELETE RESTRICT ON UPDATE CASCADE
   );

  -------------------------------------------------------
  -- Table `documentgenerator`.`AccountVerifications`
  -------------------------------------------------------
   DROP TABLE IF EXISTS AccountVerifications;

   CREATE TABLE AccountVerifications (
     id          BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     user_id     BIGINT UNSIGNED NOT NULL,
     url         VARCHAR(255) DEFAULT NULL,
     CONSTRAINT UQ_AccountVerifications_User_Id UNIQUE (user_id),
     CONSTRAINT UQ_AccountVerifications_Url UNIQUE (url)
   );

 ---------------------------------------------------------
 -- Table `documentgenerator`.`ResetPasswordVerifications`
 ---------------------------------------------------------
  DROP TABLE IF EXISTS ResetPasswordVerifications;

  CREATE TABLE ResetPasswordVerifications (
    id                 BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id            BIGINT UNSIGNED NOT NULL,
    url                VARCHAR(255) NOT NULL,
    expiration_date    DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UQ_ResetPasswordVerifications_User_Id UNIQUE (user_id),
    CONSTRAINT UQ_ResetPasswordVerifications_Url UNIQUE (url)
  );

   ---------------------------------------------------------
   -- Table `documentgenerator`.`TwoFactorAuthentication`
   ---------------------------------------------------------
    DROP TABLE IF EXISTS TwoFactorAuthentication;

    CREATE TABLE TwoFactorAuthentication (
      id                 BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      user_id            BIGINT UNSIGNED NOT NULL,
      verification_code  VARCHAR(255) NOT NULL,
      expiration_date    DATETIME NOT NULL,
      FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
      CONSTRAINT UQ_ResetPasswordVerifications_User_Id UNIQUE (user_id),
      CONSTRAINT UQ_ResetPasswordVerifications_Url UNIQUE (verification_code)
    );
