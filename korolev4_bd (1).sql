-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Апр 10 2024 г., 09:34
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `korolev4_bd`
--

-- --------------------------------------------------------

--
-- Структура таблицы `footballer`
--

CREATE TABLE `footballer` (
  `footballer_id` int(11) NOT NULL,
  `first_name` varchar(70) NOT NULL,
  `last_name` varchar(70) NOT NULL,
  `salary` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `goals` int(11) NOT NULL
) ;

--
-- Дамп данных таблицы `footballer`
--

INSERT INTO `footballer` (`footballer_id`, `first_name`, `last_name`, `salary`, `team_id`, `goals`) VALUES
(1, 'Mitya', 'Korolev', 10000, 1, 0),
(2, 'Nikita', 'Markov', 12000, 2, 2),
(3, 'Fedor', 'Naumenko', 20000, 3, 3),
(4, 'Ivan', 'Kramchikin', 23000, 2, 2),
(5, 'Misha', 'Korolev', 1, 1, 0),
(6, 'Yarik', 'Tusikov', 5000, 1, 2);

--
-- Триггеры `footballer`
--
DELIMITER $$
CREATE TRIGGER `first_trigger` BEFORE UPDATE ON `footballer` FOR EACH ROW BEGIN
IF NEW.goals < 0 THEN
	SET NEW.goals = 0;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `game`
--

CREATE TABLE `game` (
  `game_id` int(11) NOT NULL,
  `first_team` int(11) NOT NULL,
  `second_team` int(11) NOT NULL,
  `game_referee` int(11) NOT NULL,
  `game_stadium` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `game`
--

INSERT INTO `game` (`game_id`, `first_team`, `second_team`, `game_referee`, `game_stadium`) VALUES
(1, 1, 2, 3, 3),
(2, 2, 3, 1, 2),
(3, 3, 1, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `referee`
--

CREATE TABLE `referee` (
  `referee_id` int(11) NOT NULL,
  `first_name` varchar(70) NOT NULL,
  `last_name` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `referee`
--

INSERT INTO `referee` (`referee_id`, `first_name`, `last_name`) VALUES
(1, 'Kirill', 'Boykov'),
(2, 'Oleg', 'Pavlushin'),
(3, 'Alex', 'Golovkov');

-- --------------------------------------------------------

--
-- Структура таблицы `stadium`
--

CREATE TABLE `stadium` (
  `stadium_id` int(11) NOT NULL,
  `name` varchar(70) NOT NULL,
  `country` varchar(70) NOT NULL,
  `capacity` int(11) NOT NULL
) ;

--
-- Дамп данных таблицы `stadium`
--

INSERT INTO `stadium` (`stadium_id`, `name`, `country`, `capacity`) VALUES
(1, 'VEB ARENA', 'Russia', 30000),
(2, 'VTB ARENA', 'Russia', 35000),
(3, 'Santiago Bernabeu', 'Spain', 60000),
(4, 'rio', 'brazil', 200000);

--
-- Триггеры `stadium`
--
DELIMITER $$
CREATE TRIGGER `second_trigger` BEFORE UPDATE ON `stadium` FOR EACH ROW BEGIN
IF NEW.capacity > 200000 THEN
	SET NEW.capacity = 200000;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `team`
--

CREATE TABLE `team` (
  `team_id` int(11) NOT NULL,
  `name` varchar(70) NOT NULL,
  `coach` varchar(70) NOT NULL,
  `year_birth` date NOT NULL,
  `stadium` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `team`
--

INSERT INTO `team` (`team_id`, `name`, `coach`, `year_birth`, `stadium`) VALUES
(1, 'CSKA', 'Petrov', '1911-12-07', 2),
(2, 'Dynamo', 'Ivanov', '1922-12-14', 2),
(3, 'Real', 'Iglesias', '1897-12-18', 3);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `footballer`
--
ALTER TABLE `footballer`
  ADD PRIMARY KEY (`footballer_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Индексы таблицы `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`game_id`),
  ADD KEY `first_team` (`first_team`),
  ADD KEY `second_team` (`second_team`),
  ADD KEY `game_ibfk_3` (`game_referee`),
  ADD KEY `game_ibfk_4` (`game_stadium`);

--
-- Индексы таблицы `referee`
--
ALTER TABLE `referee`
  ADD PRIMARY KEY (`referee_id`);

--
-- Индексы таблицы `stadium`
--
ALTER TABLE `stadium`
  ADD PRIMARY KEY (`stadium_id`);

--
-- Индексы таблицы `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `stadium` (`stadium`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `footballer`
--
ALTER TABLE `footballer`
  MODIFY `footballer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `game`
--
ALTER TABLE `game`
  MODIFY `game_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `referee`
--
ALTER TABLE `referee`
  MODIFY `referee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `stadium`
--
ALTER TABLE `stadium`
  MODIFY `stadium_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `team`
--
ALTER TABLE `team`
  MODIFY `team_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `footballer`
--
ALTER TABLE `footballer`
  ADD CONSTRAINT `footballer_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `game_ibfk_1` FOREIGN KEY (`first_team`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `game_ibfk_2` FOREIGN KEY (`second_team`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `game_ibfk_3` FOREIGN KEY (`game_referee`) REFERENCES `referee` (`referee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `game_ibfk_4` FOREIGN KEY (`game_stadium`) REFERENCES `stadium` (`stadium_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `team`
--
ALTER TABLE `team`
  ADD CONSTRAINT `team_ibfk_1` FOREIGN KEY (`stadium`) REFERENCES `stadium` (`stadium_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
