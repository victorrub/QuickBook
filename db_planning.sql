-- Users Struct
CREATE TABLE IF NOT EXISTS `users` (
	`id`                      BINARY(16) 		NOT NULL,
	`name`                    VARCHAR(255) 	NOT NULL,
	`email`                   VARCHAR(255)	NOT NULL,
	`pass_hash`               BINARY(128) 	NOT NULL,
	`is_reset_pass_required` 	BOOLEAN       NOT NULL DEFAULT 0,
	`created_at`              DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at`              DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`active`                  BOOLEAN       NOT NULL DEFAULT 1,
	PRIMARY KEY `PK_users_id`     (`id`),
	UNIQUE  KEY `UQ_users_email`  (`email`)
);


-- Login Access Type Struct

CREATE TABLE IF NOT EXISTS `login_access_status` (
	`id`      INT         NOT NULL AUTO_INCREMENT,
	`status`  VARCHAR(32) NOT NULL,
	`active` 	BOOLEAN     NOT NULL DEFAULT 1,
	PRIMARY KEY (`id`)
);

INSERT INTO `login_access_status` 
(
	`id`,
	`status`
)
VALUES
	(1,  'Success'),
	(2,  'Success by SSO'),
	(3,  'Success by MFA'),
	(4,  'Redirect Reset Password'),
	(5,  'Redirect SSO Login'),
	(6,  'Canceled')
	(7,  'Failed Incorrect Password'),
	(8,  'Failed Security Reasons'),
	(9,  'Failed Auth Expired'),
	(10, 'Failed Bad Request'),
	(11, 'Failed Server Error'),
	(12, 'Failed Unknown Reason');


-- Login Access Struct

CREATE TABLE IF NOT EXISTS `login_logs` (
	`id`            INT           NOT NULL AUTO_INCREMENT,
	`user_id`       INT           NOT NULL,
	`type`          ENUM('login', 'renew_auth', 'logout') 
									NOT NULL,
	`status_id`     INT           NOT NULL,
	`platform`      VARCHAR(128),
	`browser`       VARCHAR(128),
	`ip_address`    VARCHAR(128),
	`accessed_at`   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`id`),

	CONSTRAINT `FK_login_logs_users_id`
		FOREIGN KEY (`user_id`)
    		REFERENCES `users` (`id`)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION,

	CONSTRAINT `FK_login_logs_login_access_status_id`
		FOREIGN KEY (`status_id`)
			REFERENCES `login_access_status` (`id`)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
);


-- Account Category Struct

CREATE TABLE IF NOT EXISTS `account_category` (
  `id`      INT         NOT NULL AUTO_INCREMENT,
  `name`    VARCHAR(32) NOT NULL,
  `active`  BOOLEAN     NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
);

INSERT INTO `account_category` 
(
  `id`,
  `name`
)
  (1, 'Debit'),
  (2, 'Credit'),
  (3, 'Loan Agency'),
  (4, 'Investment Brokerage'),
  (5, 'Debt Creditor'),
  (6, 'Generic'),
  (7, 'Others');


-- Account Type Struct

CREATE TABLE IF NOT EXISTS `account_type` (
	`id` 								                INT 			    NOT NULL AUTO_INCREMENT,
	`name` 								              VARCHAR(64) 	NOT NULL,
	`is_banking_institution`			      BOOLEAN			  NOT NULL DEFAULT 0,
	`is_transaction_import_available` 	BOOLEAN 		  NOT NULL DEFAULT 0,
	`icon_path` 						            VARCHAR(255) 	NOT NULL,
	`is_icon_allows_custom_colors` 		  BOOLEAN 		  NOT NULL DEFAULT 0,
	`created_at`                        DATETIME 		  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` 						            DATETIME 		  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`active` 							              BOOLEAN 		  NOT NULL DEFAULT 1,
	PRIMARY KEY (`id`)
);

INSERT INTO `account_type`
(
  `id`,
	`name`,
	`is_banking_institution`,
	`is_transaction_import_available`,
	`icon_path`,
	`is_icon_allows_custom_colors`
)
VALUES
	(1, 'Carteira',           0, 0, '', 1),
	(2, 'Banco',              0, 0, '', 1),
	(3, 'Cofrinho',           0, 0, '', 1),
	(4, 'Cartão de Credito',  0, 0, '', 1);


-- Account Type Categories Struct

CREATE TABLE IF NOT EXISTS `account_type_categories` (
  `id`                  INT       NOT NULL AUTO_INCREMENT,
  `account_type_id`     INT       NOT NULL,
  `account_category_id` INT       NOT NULL,
  `created_at`          DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active`              BOOLEAN   NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),

  CONSTRAINT `FK_account_type_categories_account_type_id`
    FOREIGN KEY (`account_type_id`)
      REFERENCES `account_type` (`id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,

  CONSTRAINT `FK_account_type_categories_account_category_id`
    FOREIGN KEY (`account_category_id`)
      REFERENCES `account_category` (`id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO `account_type_categories` 
(
  `account_type_id`,
  `account_category_id`
)
VALUES
  (1, 6),
  (2, 6),
  (3, 6),
  (4, 6);


-- Transaction Category Struct

CREATE TABLE IF NOT EXISTS `transaction_category` (
	`id`                  INT 			    NOT NULL AUTO_INCREMENT,
	`name` 								VARCHAR(64) 	NOT NULL,
  `type`                ENUM('expenses', 'earnings') 
                                      NOT NULL DEFAULT 'expenses',
	`default_icon_code`   VARCHAR(32) 	NOT NULL,
	`default_icon_color`  VARCHAR(8)		NOT NULL,
  `created_at`          DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`          DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`active` 							BOOLEAN 		  NOT NULL DEFAULT 1,
	PRIMARY KEY (`id`)
);

INSERT INTO `transaction_category` 
(
  `name`,
  `type`,
  `default_icon_code`,
  `default_icon_color`
)
VALUES
  ('Salário',                 'earnings', '', ''),
  ('Empréstimos',             'earnings', '', ''),
  ('Investimentos',           'earnings', '', ''),
  ('Outras receitas',         'earnings', '', ''),
  ('Alimentação',             'expenses', '', ''),
  ('Assinaturas e serviços',  'expenses', '', ''),
  ('Bares e restaurantes',    'expenses', '', ''),
  ('Casa',                    'expenses', '', ''),
  ('Compras',                 'expenses', '', ''),
  ('Cuidados pessoais',       'expenses', '', ''),
  ('Dívidas e empréstimos',   'expenses', '', ''),
  ('Educação',                'expenses', '', ''),
  ('Família e filhos',        'expenses', '', ''),
  ('Gastos essenciais',       'expenses', '', ''),
  ('Impostos e Taxas',        'expenses', '', ''),
  ('Investimentos',           'expenses', '', ''),
  ('Lazer e hobbies',         'expenses', '', ''),
  ('Mercado',                 'expenses', '', ''),
  ('Pets',                    'expenses', '', ''),
  ('Presentes e doações',     'expenses', '', ''),
  ('Roupas',                  'expenses', '', ''),
  ('Saúde',                   'expenses', '', ''),
  ('Seguros',                 'expenses', '', ''),
  ('Trabalho',                'expenses', '', ''),
  ('Transporte',              'expenses', '', ''),
  ('Viagem',                  'expenses', '', ''),
  ('Outros',                  'expenses', '', '');


CREATE TABLE IF NOT EXISTS `transaction_custom_category` (
  `id`          INT         NOT NULL AUTO_INCREMENT,
  `user_id`     INT         NOT NULL,
  `name`        VARCHAR(64) NOT NULL,
  `type`        ENUM('expenses', 'earnings') 
                            NOT NULL DEFAULT 'expenses',
  `icon_code`   VARCHAR(32) NOT NULL,
  `icon_color`  VARCHAR(8)  NOT NULL,
  `created_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active`      BOOLEAN     NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),

  CONSTRAINT `FK_transaction_custom_category_users_id`
    FOREIGN KEY (`user_id`)
      REFERENCES `users` (`id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);


CREATE TABLE IF NOT EXISTS `transaction_custom_subcategory` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `custom_category_id` INT NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `created_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active`      BOOLEAN     NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
);


-- Debit Accounts Struct

CREATE TABLE IF NOT EXISTS `debit_accounts` (
	`id` 					INT 			NOT NULL AUTO_INCREMENT,
	`user_id` 				INT 			NOT NULL,
	`name` 					VARCHAR(32) 	NOT NULL,
	`type_id` 				INT 			NOT NULL,
	`icon_color` 			VARCHAR(8),
	`current_balance` 		DECIMAL(16, 2) 	NOT NULL DEFAULT 0,
	`hide_account_balance` 	BOOLEAN 		NOT NULL DEFAULT 0,
	`created_at` 			DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` 			DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`active` 				BOOLEAN 		NOT NULL DEFAULT 1,
	PRIMARY KEY (`id`),

	CONSTRAINT `FK_debit_accounts_users_id`
		FOREIGN KEY (`user_id`)
    		REFERENCES `users` (`id`)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION,

	CONSTRAINT `FK_debit_accounts_account_type_id`
		FOREIGN KEY (`type_id`)
    		REFERENCES `account_type` (`id`)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
);

