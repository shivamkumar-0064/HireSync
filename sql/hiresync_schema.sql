#This table stores the companies that post jobs.
USE hiresync;

CREATE TABLE employers (
    employer_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    contact_email VARCHAR(150),
    contact_phone VARCHAR(20)
);

#This stores candidate information
CREATE TABLE candidates (
    candidate_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    resume_info TEXT,
    skills TEXT
);

#Now we store job postings.
CREATE TABLE jobs (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    employer_id INT NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    requirements TEXT,
    job_location VARCHAR(100),
    posted_date DATE,

    FOREIGN KEY (employer_id)
        REFERENCES employers(employer_id)
);

#This is where a candidate applies for a particular job.
CREATE TABLE applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT NOT NULL,
    job_id INT NOT NULL,
    applied_date DATE NOT NULL,

    FOREIGN KEY (candidate_id)
        REFERENCES candidates(candidate_id),

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
);


#This is the most important table for the analytics part. used to store the stahe of the process
CREATE TABLE application_stage_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    stage VARCHAR(50) NOT NULL,
    stage_date DATE NOT NULL,

    FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
);

# used to see the tables name 
SHOW TABLES;


# it is used to describe about all the table 
DESCRIBE employers;
DESCRIBE candidates;
DESCRIBE jobs;
DESCRIBE applications;
DESCRIBE application_stage_history;

#here we store some dummy data to check our tables are working properly or not 
INSERT INTO employers
(company_name, contact_name, contact_email, contact_phone)
VALUES
('TechNova Solutions', 'Rahul Sharma', 'rahul@technova.com', '9876543210'),
('DataSphere Pvt Ltd', 'Priya Singh', 'priya@datasphere.com', '9876543211'),
('CloudMatrix Technologies', 'Amit Verma', 'amit@cloudmatrix.com', '9876543212');

INSERT INTO candidates
(candidate_name, email, phone, resume_info, skills)
VALUES
('Arjun Kumar', 'arjun@gmail.com', '9000000001',
 'BCA graduate with data analysis experience',
 'Python, SQL, Excel, Power BI'),

('Neha Sharma', 'neha@gmail.com', '9000000002',
 'MCA student with analytics background',
 'Python, SQL, Tableau'),

('Rohit Verma', 'rohit@gmail.com', '9000000003',
 'Computer science graduate',
 'Java, SQL, Python'),

('Priya Gupta', 'priya@gmail.com', '9000000004',
 'Data analytics fresher',
 'Excel, SQL, Power BI'),

('Karan Singh', 'karan@gmail.com', '9000000005',
 'Software and analytics graduate',
 'Python, SQL, Tableau');
 
 INSERT INTO jobs
(employer_id, job_title, requirements, job_location, posted_date)
VALUES
(1, 'Data Analyst',
 'SQL, Python, Excel, Power BI',
 'Noida', '2026-01-01'),

(1, 'Python Developer',
 'Python, Django, SQL',
 'Delhi', '2026-01-05'),

(2, 'Business Analyst',
 'SQL, Excel, Tableau',
 'Gurugram', '2026-01-10'),

(2, 'Data Analyst',
 'Python, SQL, Power BI',
 'Bangalore', '2026-01-15'),

(3, 'Data Scientist',
 'Python, Machine Learning, SQL',
 'Hyderabad', '2026-01-20');
 
 INSERT INTO applications
(candidate_id, job_id, applied_date)
VALUES
(1, 1, '2026-01-03'),
(2, 1, '2026-01-04'),
(3, 2, '2026-01-06'),
(4, 3, '2026-01-12'),
(5, 4, '2026-01-18'),
(1, 5, '2026-01-22');

INSERT INTO application_stage_history
(application_id, stage, stage_date)
VALUES
(1, 'Applied', '2026-01-03'),
(1, 'Screened', '2026-01-05'),
(1, 'Interviewed', '2026-01-09'),
(1, 'Offered', '2026-01-12'),
(1, 'Hired', '2026-01-15');

INSERT INTO application_stage_history
(application_id, stage, stage_date)
VALUES
(2, 'Applied', '2026-01-04'),
(2, 'Screened', '2026-01-07'),
(2, 'Dropped', '2026-01-09');


INSERT INTO application_stage_history
(application_id, stage, stage_date)
VALUES
(3, 'Applied', '2026-01-06'),
(3, 'Screened', '2026-01-08'),
(3, 'Interviewed', '2026-01-13'),
(3, 'Dropped', '2026-01-16');


INSERT INTO application_stage_history
(application_id, stage, stage_date)
VALUES
(4, 'Applied', '2026-01-12'),
(4, 'Screened', '2026-01-14'),
(4, 'Interviewed', '2026-01-18'),
(4, 'Offered', '2026-01-21'),
(4, 'Hired', '2026-01-25');


INSERT INTO application_stage_history
(application_id, stage, stage_date)
VALUES
(5, 'Applied', '2026-01-18'),
(5, 'Screened', '2026-01-20'),
(5, 'Interviewed', '2026-01-24');

INSERT INTO application_stage_history
(application_id, stage, stage_date)
VALUES
(6, 'Applied', '2026-01-22'),
(6, 'Dropped', '2026-01-23');

#these are used to retreive the application_stage_history table order wise
SELECT *
FROM application_stage_history
ORDER BY application_id, stage_date;


#these are used to retreive all the table
SELECT * FROM employers;
SELECT * FROM candidates;
SELECT * FROM jobs;
SELECT * FROM applications;
SELECT * FROM application_stage_history;


#let's connect candidates with their applications.
SELECT
    c.candidate_id,
    c.candidate_name,
    a.application_id,
    a.applied_date
FROM candidates c
JOIN applications a
    ON c.candidate_id = a.candidate_id;
    
    
  #let's connect the application to the job.  
SELECT
    c.candidate_name,
    a.application_id,
    a.applied_date,
    j.job_title
FROM candidates c
JOIN applications a
    ON c.candidate_id = a.candidate_id
JOIN jobs j
    ON a.job_id = j.job_id;
    
  #we can connect the entire chain.  
    SELECT
    c.candidate_id,
    c.candidate_name,
    a.application_id,
    a.applied_date,
    j.job_title,
    e.company_name
FROM candidates c
JOIN applications a
    ON c.candidate_id = a.candidate_id
JOIN jobs j
    ON a.job_id = j.job_id
JOIN employers e
    ON j.employer_id = e.employer_id;
    
    
    #let's connect the stage history.
SELECT
    c.candidate_name,
    a.application_id,
    j.job_title,
    e.company_name,
    h.stage,
    h.stage_date
FROM candidates c
JOIN applications a
    ON c.candidate_id = a.candidate_id
JOIN jobs j
    ON a.job_id = j.job_id
JOIN employers e
    ON j.employer_id = e.employer_id
JOIN application_stage_history h
    ON a.application_id = h.application_id
ORDER BY
    a.application_id,
    h.stage_date;
    
    
    #find the current/latest stage of every application.
SELECT
    a.application_id,
    c.candidate_name,
    MAX(h.stage_date) AS latest_stage_date
FROM applications a
JOIN candidates c
    ON a.candidate_id = c.candidate_id
JOIN application_stage_history h
    ON a.application_id = h.application_id
GROUP BY
    a.application_id,
    c.candidate_name;
    
    
    
    #Check row counts
SELECT 'Employers' AS table_name, COUNT(*) AS total_rows
FROM employers

UNION ALL

SELECT 'Candidates', COUNT(*)
FROM candidates

UNION ALL

SELECT 'Jobs', COUNT(*)
FROM jobs

UNION ALL

SELECT 'Applications', COUNT(*)
FROM applications

UNION ALL

SELECT 'Stage History', COUNT(*)
FROM application_stage_history;


#Check for applications without candidates Every application should belong to an existing candidate
SELECT a.*
FROM applications a
LEFT JOIN candidates c
    ON a.candidate_id = c.candidate_id
WHERE c.candidate_id IS NULL;



#Check for applications without jobs
SELECT a.*
FROM applications a
LEFT JOIN jobs j
    ON a.job_id = j.job_id
WHERE j.job_id IS NULL;

SELECT j.*
FROM jobs j
LEFT JOIN employers e
    ON j.employer_id = e.employer_id
WHERE e.employer_id IS NULL;



#Check for jobs without employers
SELECT
    a.application_id,
    a.candidate_id,
    a.job_id
FROM applications a
LEFT JOIN application_stage_history h
    ON a.application_id = h.application_id
WHERE h.application_id IS NULL;


#Check duplicate candidate emails
SELECT
    email,
    COUNT(*) AS duplicate_count
FROM candidates
GROUP BY email
HAVING COUNT(*) > 1;


#Our current table doesn't enforce this at the database level.We can improve it by adding:
ALTER TABLE candidates
ADD CONSTRAINT unique_candidate_email UNIQUE (email);



#Check applications without stage history
SELECT
    application_id,
    stage,
    stage_date
FROM application_stage_history
ORDER BY application_id, stage_date;




#Check our complete database
SELECT
    c.candidate_name,
    c.email,
    j.job_title,
    e.company_name,
    a.applied_date,
    h.stage,
    h.stage_date
FROM candidates c
JOIN applications a
    ON c.candidate_id = a.candidate_id
JOIN jobs j
    ON a.job_id = j.job_id
JOIN employers e
    ON j.employer_id = e.employer_id
JOIN application_stage_history h
    ON a.application_id = h.application_id
ORDER BY
    a.application_id,
    h.stage_date;
    
    