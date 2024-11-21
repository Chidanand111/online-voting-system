

--
-- Database: `votesystem`
--
CREATE DATABASE IF NOT EXISTS `votesystem` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `votesystem`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `photo` varchar(150) NOT NULL,
  `created_on` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `admin`:
--

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `firstname`, `lastname`, `photo`, `created_on`) VALUES
(1, 'chidanand', 'chidanand', 'Chidanand', 'G L', 'admin1.jpg', '2024-11-1'),
(2, 'darshan', 'darshan', 'Darshan', 'M', 'admin2.jpg', '2024-11-01');

-- --------------------------------------------------------

--
-- Table structure for table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
CREATE TABLE `candidates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position_id` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `photo` BLOB NOT NULL,
  `platform` text NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`position_id`) REFERENCES `positions`(`position_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;



--
-- RELATIONSHIPS FOR TABLE `candidates`:
--

--
-- Dumping data for table `candidates`
--

--INSERT INTO `candidates` (`id`, `position_id`, `firstname`, `lastname`, `photo`, `platform`) VALUES


-- --------------------------------------------------------

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
CREATE TABLE `positions` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  `max_vote` int(11) NOT NULL,
  `priority` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `positions`:
--

--
-- Dumping data for table `positions`
--

INSERT INTO `positions` (`id`, `description`, `max_vote`, `priority`) VALUES
(8, 'President', 2, 1),
(10, 'Secretary', 1, 2),
(11, 'Treasurer', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `voters`
--

DROP TABLE IF EXISTS `voters`;
CREATE TABLE `voters` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `voter_id` VARCHAR(5) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `firstname` VARCHAR(30) NOT NULL,
  `lastname` VARCHAR(30) NOT NULL,
  `photo` BLOB NOT NULL,  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `voters`:
--

--
-- Dumping data for table `voters`
--

INSERT INTO `voters` (`id`, `voters_id`, `password`, `firstname`, `lastname`, `photo`) VALUES
(2, '4I2FS', 'Arun', 'Arun', 'K ', 'voter2.jpg'),
(3, '62WME', 'Chethan', 'Chethan', 'J', 'voter3.jpg'),
(4, 'Z5UV7', 'Darshan', 'Darshan', 'D', 'voter4.jpg'),
(5, 'M6BNE', 'Dheeraj', 'Dheeraj', 'C L', 'voter5.jpg'),
(6, 'SJA3C', 'Omsai', 'Omsai', 'B', 'voter6.jpg'),
(7, 'DCNGV', 'liam', 'Adithya', 'B', 'voter7.jpg');


-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
CREATE TABLE `votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `voters_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  FOREIGN KEY (`voters_id`) REFERENCES `voters` (`id`),
  FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`),
  FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `votes`:
--

--
-- Dumping data for table `votes`
--

INSERT INTO `votes` (`id`, `voters_id`, `candidate_id`, `position_id`) VALUES
;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `candidates`
--
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voters`
--
ALTER TABLE `voters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `candidates`
--
ALTER TABLE `candidates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `positions`
--
ALTER TABLE `positions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `voters`
--
ALTER TABLE `voters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;
COMMIT;




CREATE TABLE error_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    error_message VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




DELIMITER $$

CREATE FUNCTION generate_voter_id() 
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE voter_id VARCHAR(10);
    DECLARE letter_part VARCHAR(2);
    DECLARE number_part VARCHAR(3);
    
    -- Generate the letter part (2 uppercase letters)
    SET letter_part = CONCAT(CHAR(65 + FLOOR(RAND() * 26)), CHAR(65 + FLOOR(RAND() * 26)));
    
    -- Generate the number part (3 digits)
    SET number_part = LPAD(FLOOR(RAND() * 1000), 3, '0');
    
    -- Combine the two parts
    SET voter_id = CONCAT(letter_part, number_part);
    
    -- Return the generated voter ID
    RETURN voter_id;
END$$

DELIMITER ;


DELIMITER //

CREATE TRIGGER before_voter_delete
BEFORE DELETE ON voters
FOR EACH ROW
BEGIN
    DELETE FROM votes WHERE voters_id = OLD.id;
END //

DELIMITER ;




DELIMITER //

CREATE TRIGGER delete_votes_after_candidate
AFTER DELETE ON candidates
FOR EACH ROW
BEGIN
    DELETE FROM votes WHERE candidate_id = OLD.id;
END; //

DELIMITER ;




 --Nested Query to Find Voters Who Have Voted


SELECT firstname, lastname 
FROM voters 
WHERE id IN (SELECT voters_id FROM votes);
--Join Query to Get Candidates and Their Positions


SELECT c.firstname, c.lastname, p.description 
FROM candidates c
JOIN positions p ON c.position_id = p.id;
--Aggregate Query to Count Votes per Position


SELECT p.description, COUNT(v.id) AS total_votes 
FROM positions p
LEFT JOIN votes v ON p.id = v.position_id
GROUP BY p.id;

--Query to Get Candidate Details with Vote Counts
SELECT c.firstname, c.lastname, COUNT(v.id) AS vote_count 
FROM candidates c
LEFT JOIN votes v ON c.id = v.candidate_id
GROUP BY c.id;

--Query to Find Positions with No Votes
SELECT p.description 
FROM positions p 
LEFT JOIN votes v ON p.id = v.position_id 
WHERE v.id IS NULL;

