CREATE TABLE `users` (
 `id` int(12) NOT NULL AUTO_INCREMENT,
 `email_address` varchar(100) NOT NULL,
 `password` varchar(100) NOT NULL,
 `created_at` datetime NOT NULL,
 `updated_at` datetime,
 `deleted_at` datetime,
 PRIMARY KEY (`id`),
 UNIQUE KEY (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tasks` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `name` varchar(100) NOT NULL,
 `description` varchar(255) NOT NULL,
 `due_date` datetime NOT NULL,
 `status_id` datetime,
 `created_at` datetime NOT NULL,
 `updated_at` datetime,
 `deleted_at` datetime,
 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `status` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `name` varchar(100) NOT NULL,
 `created_at` datetime NOT NULL,
 `updated_at` datetime,
 `deleted_at` datetime,
 PRIMARY KEY (`id`),
 UNIQUE KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_tasks` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `user_id` int(12) NOT NULL,
 `task_id` int(11) NOT NULL,
 `due_date` datetime NOT NULL,
 `start_time` datetime NOT NULL,
 `end_time` datetime NOT NULL,
 `remarks` varchar(100),
 `status_id` int(11) NOT NULL,
 `created_at` datetime NOT NULL,
 `updated_at` datetime,
 `deleted_at` datetime,
 PRIMARY KEY (`id`),
 FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
 FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`),
 FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;