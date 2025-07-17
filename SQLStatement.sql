
CREATE TABLE user_account (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(45) NOT NULL
);

CREATE TABLE host (
    id INT AUTO_INCREMENT PRIMARY KEY,
    profile_photo VARCHAR(255) NOT NULL,
    join_date DATE NOT NULL,
    rating DECIMAL(3,2),
    user_account_id INT NOT NULL,
    FOREIGN KEY (user_account_id) REFERENCES user_account(id) ON DELETE CASCADE
);

CREATE TABLE guest (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(3,2),
    user_account_id INT NOT NULL,
    FOREIGN KEY (user_account_id) REFERENCES user_account(id) ON DELETE CASCADE
);

CREATE TABLE cancellation_policy (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    details TEXT NOT NULL,
    refund_percentage DECIMAL(5,2) CHECK (refund_percentage BETWEEN 0 AND 100)
);

CREATE TABLE neighborhood (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    country VARCHAR(45) NOT NULL,
    city VARCHAR(45) NOT NULL,
    district VARCHAR(45) NOT NULL
);

CREATE TABLE property (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(45) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    neighborhood_id INT NOT NULL,
    cancellation_policy_id INT NOT NULL,
    host_id INT NOT NULL,
    rental_type ENUM('Entire House', 'Shared') DEFAULT 'Entire House',
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhood(id) ON DELETE CASCADE,
    FOREIGN KEY (cancellation_policy_id) REFERENCES cancellation_policy(id) ON DELETE CASCADE,
    FOREIGN KEY (host_id) REFERENCES host(id) ON DELETE CASCADE
);

CREATE TABLE booking (
    id INT AUTO_INCREMENT PRIMARY KEY,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    guest_id INT NOT NULL,
    host_id INT NOT NULL,
    property_id INT NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(id) ON DELETE CASCADE,
    FOREIGN KEY (host_id) REFERENCES host(id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES property(id) ON DELETE CASCADE
);

CREATE TABLE guest_review (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    parent_review_id INT,
    guest_id INT NOT NULL,
    booking_id INT NOT NULL,
    FOREIGN KEY (parent_review_id) REFERENCES guest_review(id) ON DELETE SET NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES booking(id) ON DELETE CASCADE
);

CREATE TABLE payment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer') NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    booking_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(id) ON DELETE CASCADE
);

CREATE TABLE discount (
    id INT AUTO_INCREMENT PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    discount_rate DECIMAL(5,2) CHECK (discount_rate BETWEEN 0 AND 100),
    property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(id) ON DELETE CASCADE
);

CREATE TABLE house_rule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    description TEXT
);

CREATE TABLE property_house_rule (
    property_id INT NOT NULL,
    house_rule_id INT NOT NULL,
    PRIMARY KEY (property_id, house_rule_id),
    FOREIGN KEY (property_id) REFERENCES property(id) ON DELETE CASCADE,
    FOREIGN KEY (house_rule_id) REFERENCES house_rule(id) ON DELETE CASCADE
);

CREATE TABLE availability (
    id INT AUTO_INCREMENT PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('Available', 'Booked', 'Pending') NOT NULL,
    property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(id) ON DELETE CASCADE
);

CREATE TABLE room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(45) NOT NULL,
    room_type ENUM('Single', 'Double', 'Suite') NOT NULL,
    room_price DECIMAL(10,2) NOT NULL,
    property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(id) ON DELETE CASCADE
);

CREATE TABLE amenity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE property_amenity (
    property_id INT NOT NULL,
    amenity_id INT NOT NULL,
    PRIMARY KEY (property_id, amenity_id),
    FOREIGN KEY (property_id) REFERENCES property(id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenity(id) ON DELETE CASCADE
);

CREATE TABLE room_amenity (
    room_id INT NOT NULL,
    amenity_id INT NOT NULL,
    PRIMARY KEY (room_id, amenity_id),
    FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenity(id) ON DELETE CASCADE
);

CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    property_id INT NOT NULL,
    user_account_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(id) ON DELETE CASCADE,
    FOREIGN KEY (user_account_id) REFERENCES user_account(id) ON DELETE CASCADE
);

CREATE TABLE conversation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    booking_id INT NOT NULL,
    receiver_id INT NOT NULL,
    FOREIGN KEY (sender_id) REFERENCES user_account(id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES booking(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES user_account(id) ON DELETE CASCADE
);

CREATE TABLE message (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message_text TEXT NOT NULL,
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    conversation_id INT NOT NULL,
    sender_id INT NOT NULL,
    FOREIGN KEY (conversation_id) REFERENCES conversation(id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES user_account(id) ON DELETE CASCADE
);

INSERT INTO user_account (username, email, password, phone_number) VALUES
('user1', 'user1@example.com', 'pass1', '500-0001'),
('user2', 'user2@example.com', 'pass2', '500-0002'),
('user3', 'user3@example.com', 'pass3', '500-0003'),
('user4', 'user4@example.com', 'pass4', '500-0004'),
('user5', 'user5@example.com', 'pass5', '500-0005'),
('user6', 'user6@example.com', 'pass6', '500-0006'),
('user7', 'user7@example.com', 'pass7', '500-0007'),
('user8', 'user8@example.com', 'pass8', '500-0008'),
('user9', 'user9@example.com', 'pass9', '500-0009'),
('user10', 'user10@example.com', 'pass10', '500-0010'),
('user11', 'user11@example.com', 'pass11', '500-0011'),
('user12', 'user12@example.com', 'pass12', '500-0012'),
('user13', 'user13@example.com', 'pass13', '500-0013'),
('user14', 'user14@example.com', 'pass14', '500-0014'),
('user15', 'user15@example.com', 'pass15', '500-0015'),
('user16', 'user16@example.com', 'pass16', '500-0016'),
('user17', 'user17@example.com', 'pass17', '500-0017'),
('user18', 'user18@example.com', 'pass18', '500-0018'),
('user19', 'user19@example.com', 'pass19', '500-0019'),
('user20', 'user20@example.com', 'pass20', '500-0020'),
('user21', 'user21@example.com', 'pass21', '500-0021'),
('user22', 'user22@example.com', 'pass22', '500-0022'),
('user23', 'user23@example.com', 'pass23', '500-0023'),
('user24', 'user24@example.com', 'pass24', '500-0024'),
('user25', 'user25@example.com', 'pass25', '500-0025'),
('user26', 'user26@example.com', 'pass26', '500-0026'),
('user27', 'user27@example.com', 'pass27', '500-0027'),
('user28', 'user28@example.com', 'pass28', '500-0028'),
('user29', 'user29@example.com', 'pass29', '500-0029'),
('user30', 'user30@example.com', 'pass30', '500-0030'),
('user31', 'user31@example.com', 'pass31', '500-0031'),
('user32', 'user32@example.com', 'pass32', '500-0032'),
('user33', 'user33@example.com', 'pass33', '500-0033'),
('user34', 'user34@example.com', 'pass34', '500-0034'),
('user35', 'user35@example.com', 'pass35', '500-0035');

INSERT INTO guest (rating, user_account_id) VALUES
(4.2, 1),
(3.8, 2),
(4.5, 3),
(4.0, 4),
(4.1, 5),
(3.9, 6),
(4.3, 7),
(4.6, 8),
(4.0, 9),
(4.4, 10),
(3.7, 11),
(4.8, 12),
(4.9, 13),
(3.6, 14),
(4.0, 15),
(4.2, 31),
(4.5, 32),
(3.9, 33),
(4.4, 34),
(4.1, 35);

INSERT INTO host (profile_photo, join_date, rating, user_account_id) VALUES
('host16.jpg', '2024-01-01', 4.6, 16),
('host17.jpg', '2024-01-02', 4.2, 17),
('host18.jpg', '2024-01-03', 4.0, 18),
('host19.jpg', '2024-01-04', 4.3, 19),
('host20.jpg', '2024-01-05', 4.1, 20),
('host21.jpg', '2024-01-06', 4.7, 21),
('host22.jpg', '2024-01-07', 4.5, 22),
('host23.jpg', '2024-01-08', 3.9, 23),
('host24.jpg', '2024-01-09', 4.4, 24),
('host25.jpg', '2024-01-10', 4.3, 25),
('host26.jpg', '2024-01-11', 4.1, 26),
('host27.jpg', '2024-01-12', 4.6, 27),
('host28.jpg', '2024-01-13', 4.2, 28),
('host29.jpg', '2024-01-14', 3.8, 29),
('host30.jpg', '2024-01-15', 4.0, 30),
('host31.jpg', '2024-01-16', 4.5, 31),
('host32.jpg', '2024-01-17', 4.3, 32),
('host33.jpg', '2024-01-18', 4.0, 33),
('host34.jpg', '2024-01-19', 4.1, 34),
('host35.jpg', '2024-01-20', 4.4, 35);

INSERT INTO cancellation_policy (name, details, refund_percentage) VALUES
('Flexible', 'Full refund up to 1 day before', 100),
('Moderate', 'Full refund up to 5 days before', 80),
('Strict', '50% refund up to 7 days before', 50),
('Super Strict', '25% refund up to 14 days before', 25),
('No Refund', 'No refund on cancellation', 0),
('Holiday Special', 'Refund not available for holidays', 0),
('Last Minute', '75% refund within 24h', 75),
('Free Cancellation', 'Any time full refund', 100),
('Standard', 'Normal cancellation policy', 60),
('Non-refundable', 'Cheaper but no refund', 0),
('Premium', 'Includes travel insurance', 90),
('Early Bird', 'Refundable up to 1 month', 85),
('Late Night', 'Non-refundable after 10 PM', 10),
('VIP', 'Full refund & perks', 100),
('Weekend', '50% refund on weekends', 50),
('Weather-Based', 'Full refund if weather bad', 100),
('Medical Emergency', '80% with proof', 80),
('Business Flex', 'Corporate package refund', 70),
('Eco Stay', '70% refund, green travel', 70),
('Student Special', '60% refund, student only', 60);

INSERT INTO neighborhood (name, country, city, district) VALUES
('Kadikoy', 'Turkey', 'Istanbul', 'Moda'),
('Besiktas', 'Turkey', 'Istanbul', 'Levazim'),
('Cankaya', 'Turkey', 'Ankara', 'Kavaklidere'),
('Greenwich', 'United Kingdom', 'London', 'South East'),
('Soho', 'United States', 'New York', 'Manhattan'),
('Montmartre', 'France', 'Paris', '18th Arrondissement'),
('Prenzlauer Berg', 'Germany', 'Berlin', 'Pankow'),
('Shibuya', 'Japan', 'Tokyo', 'Shibuya-ku'),
('Gangnam', 'South Korea', 'Seoul', 'Gangnam-gu'),
('Trastevere', 'Italy', 'Rome', 'Lazio'),
('Gracia', 'Spain', 'Barcelona', 'Catalonia'),
('Vesterbro', 'Denmark', 'Copenhagen', 'Vesterbro'),
('Le Plateau', 'Canada', 'Montreal', 'Quebec'),
('De Waterkant', 'South Africa', 'Cape Town', 'Western Cape'),
('El Born', 'Spain', 'Barcelona', 'Catalonia'),
('Zamalek', 'Egypt', 'Cairo', 'Zamalek District'),
('Jumeirah', 'United Arab Emirates', 'Dubai', 'Jumeirah'),
('Miraflores', 'Peru', 'Lima', 'Miraflores'),
('Chacarita', 'Argentina', 'Buenos Aires', 'Capital Federal'),
('Beyoglu', 'Turkey', 'Istanbul', 'Cihangir');

INSERT INTO property (title, price, neighborhood_id, cancellation_policy_id, host_id) VALUES
('Cozy Apartment 1', 293.08, 8, 10, 1),
('Cozy Apartment 2', 110.27, 3, 6, 2),
('Cozy Apartment 3', 151.85, 1, 17, 3),
('Cozy Apartment 4', 220.75, 4, 4, 4),
('Cozy Apartment 5', 112.38, 19, 17, 5),
('Cozy Apartment 6', 230.67, 17, 12, 6),
('Cozy Apartment 7', 189.30, 5, 8, 7),
('Cozy Apartment 8', 275.99, 16, 9, 8),
('Cozy Apartment 9', 199.45, 20, 15, 9),
('Cozy Apartment 10', 137.10, 9, 6, 10);

INSERT INTO property (title, price, neighborhood_id, cancellation_policy_id, host_id, rental_type) VALUES
('Cozy Apartment 11', 264.22, 6, 3, 11, 'Shared'),
('Cozy Apartment 12', 204.55, 2, 1, 12, 'Shared'),
('Cozy Apartment 13', 258.40, 10, 18, 13, 'Shared'),
('Cozy Apartment 14', 119.99, 14, 2, 14, 'Shared'),
('Cozy Apartment 15', 148.76, 12, 5, 15, 'Shared'),
('Cozy Apartment 16', 289.99, 7, 11, 16, 'Shared'),
('Cozy Apartment 17', 175.25, 13, 7, 17, 'Shared'),
('Cozy Apartment 18', 206.87, 18, 13, 18, 'Shared'),
('Cozy Apartment 19', 194.33, 11, 16, 19, 'Shared'),
('Cozy Apartment 20', 170.00, 15, 20, 20, 'Shared');

INSERT INTO booking (check_in_date, check_out_date, guest_id, host_id, property_id) VALUES
('2025-04-04', '2025-04-07', 1, 7, 4),
('2025-04-05', '2025-04-09', 2, 4, 6),
('2025-04-06', '2025-04-10', 3, 17, 9),
('2025-04-07', '2025-04-11', 4, 1, 20),
('2025-04-08', '2025-04-10', 5, 2, 8),
('2025-04-09', '2025-04-11', 6, 13, 3),
('2025-04-10', '2025-04-12', 7, 20, 2),
('2025-04-11', '2025-04-14', 8, 8, 12),
('2025-04-12', '2025-04-16', 9, 12, 14),
('2025-04-13', '2025-04-15', 10, 11, 18),
('2025-04-14', '2025-04-18', 11, 18, 17),
('2025-04-15', '2025-04-19', 12, 10, 11),
('2025-04-16', '2025-04-19', 13, 5, 1),
('2025-04-17', '2025-04-19', 14, 6, 19),
('2025-04-18', '2025-04-21', 15, 14, 15),
('2025-04-19', '2025-04-23', 16, 15, 7),
('2025-04-20', '2025-04-24', 17, 9, 5),
('2025-04-21', '2025-04-23', 18, 3, 10),
('2025-04-22', '2025-04-24', 19, 16, 13),
('2025-04-23', '2025-04-26', 20, 19, 16);

INSERT INTO guest_review (rating, comment, review_date, parent_review_id, guest_id, booking_id) VALUES
(5, 'Excellent service and location!', '2025-03-25 14:05:37', NULL, 1, 1),
(4, 'Great stay, would recommend!', '2025-03-26 14:05:37', NULL, 2, 2),
(4, 'Great stay, would recommend!', '2025-03-27 14:05:37', NULL, 3, 3),
(3, 'It was okay, nothing special.', '2025-03-28 14:05:37', NULL, 4, 4),
(5, 'Excellent service and location!', '2025-03-29 14:05:37', NULL, 5, 5),
(3, 'It was okay, nothing special.', '2025-03-30 14:05:37', 2, 6, 6),
(2, 'Not as expected. Needs improvement.', '2025-03-31 14:05:37', 5, 7, 7),
(1, 'Very disappointing experience.', '2025-04-01 14:05:37', 4, 8, 8),
(4, 'Great stay, would recommend!', '2025-04-02 14:05:37', 7, 9, 9),
(3, 'It was okay, nothing special.', '2025-04-03 14:05:37', 6, 10, 10),
(1, 'Very disappointing experience.', '2025-04-04 14:05:37', 9, 11, 11),
(2, 'Not as expected. Needs improvement.', '2025-04-05 14:05:37', 8, 12, 12),
(5, 'Excellent service and location!', '2025-04-06 14:05:37', 10, 13, 13),
(5, 'Excellent service and location!', '2025-04-07 14:05:37', 12, 14, 14),
(2, 'Not as expected. Needs improvement.', '2025-04-08 14:05:37', 11, 15, 15),
(3, 'It was okay, nothing special.', '2025-04-09 14:05:37', 13, 16, 16),
(2, 'Not as expected. Needs improvement.', '2025-04-10 14:05:37', 14, 17, 17),
(4, 'Great stay, would recommend!', '2025-04-11 14:05:37', 15, 18, 18),
(4, 'Great stay, would recommend!', '2025-04-12 14:05:37', 18, 19, 19),
(3, 'It was okay, nothing special.', '2025-04-13 14:05:37', 17, 20, 20);

INSERT INTO payment (amount, payment_method, payment_date, booking_id) VALUES
(662.25, 'Bank Transfer', '2025-04-07 00:00:00', 1),
(922.68, 'Debit Card', '2025-04-09 00:00:00', 2),
(797.80, 'Debit Card', '2025-04-10 00:00:00', 3),
(680.00, 'Bank Transfer', '2025-04-11 00:00:00', 4),
(551.98, 'Debit Card', '2025-04-10 00:00:00', 5),
(303.70, 'Bank Transfer', '2025-04-11 00:00:00', 6),
(220.54, 'Credit Card', '2025-04-12 00:00:00', 7),
(613.65, 'PayPal', '2025-04-14 00:00:00', 8),
(479.96, 'Bank Transfer', '2025-04-16 00:00:00', 9),
(413.74, 'Debit Card', '2025-04-15 00:00:00', 10),
(701.00, 'Credit Card', '2025-04-18 00:00:00', 11),
(1056.88, 'Debit Card', '2025-04-19 00:00:00', 12),
(879.24, 'Debit Card', '2025-04-19 00:00:00', 13),
(388.66, 'PayPal', '2025-04-19 00:00:00', 14),
(446.28, 'PayPal', '2025-04-21 00:00:00', 15),
(757.20, 'Credit Card', '2025-04-23 00:00:00', 16),
(449.52, 'Bank Transfer', '2025-04-24 00:00:00', 17),
(274.20, 'Credit Card', '2025-04-23 00:00:00', 18),
(516.80, 'PayPal', '2025-04-24 00:00:00', 19),
(869.97, 'Credit Card', '2025-04-26 00:00:00', 20);

INSERT INTO discount (start_date, end_date, discount_rate, property_id) VALUES
('2025-10-29', '2025-11-08', 26.34, 1),
('2025-10-30', '2025-11-07', 24.58, 2),
('2025-11-17', '2025-11-24', 12.70, 3),
('2025-11-04', '2025-11-11', 19.16, 4),
('2025-11-10', '2025-11-20', 17.87, 5),
('2025-10-28', '2025-11-05', 18.84, 6),
('2025-11-11', '2025-11-16', 5.24, 7),
('2025-11-14', '2025-11-23', 24.87, 8),
('2025-11-12', '2025-11-20', 24.60, 9),
('2025-11-10', '2025-11-16', 18.85, 10),
('2025-11-05', '2025-11-14', 7.47, 11),
('2025-11-14', '2025-11-24', 11.37, 12),
('2025-10-30', '2025-11-09', 20.89, 13),
('2025-10-25', '2025-11-02', 13.07, 14),
('2025-11-06', '2025-11-12', 29.23, 15),
('2025-11-08', '2025-11-14', 28.84, 16),
('2025-11-05', '2025-11-11', 11.45, 17),
('2025-10-30', '2025-11-08', 5.38, 18),
('2025-11-03', '2025-11-13', 18.22, 19),
('2025-11-09', '2025-11-17', 9.30, 20);

INSERT INTO house_rule (name, description) VALUES
('No Smoking', 'Smoking is not allowed inside the property.'),
('No Pets', 'Pets are not allowed on the premises.'),
('No Parties', 'Parties or events are strictly prohibited.'),
('Quiet Hours', 'Please observe quiet hours between 10 PM and 8 AM.'),
('Check-in After 2PM', 'Guests may check in anytime after 2PM.'),
('Check-out Before 11AM', 'Guests must check out by 11AM.'),
('No Shoes Indoors', 'Please remove shoes when entering the house.'),
('Do Not Disturb Neighbors', 'Respect the neighbors and keep noise to a minimum.'),
('No Extra Guests', 'Only registered guests are allowed to stay overnight.'),
('Garbage Separation', 'Separate garbage and recyclables properly.'),
('Close Windows When Leaving', 'Always close windows before leaving the house.'),
('No Loud Music', 'Loud music is not permitted at any time.'),
('Use Coasters', 'Please use coasters under drinks to protect furniture.'),
('Respect Shared Areas', 'Keep shared areas clean and tidy.'),
('Turn Off Lights', 'Turn off lights and electronics when not in use.'),
('No Cooking After 10PM', 'Cooking is not allowed after 10PM.'),
('No Open Flames', 'Candles or any open flames are not allowed.'),
('Lock Doors When Leaving', 'Ensure all doors are locked when leaving.'),
('Report Damages', 'Please report any damages immediately.'),
('Laundry Rules Apply', 'Laundry use is restricted to certain hours.');

INSERT INTO property_house_rule (property_id, house_rule_id) VALUES
(1, 1),
(1, 4),
(2, 14),
(2, 18),
(3, 5),
(3, 11),
(4, 10),
(5, 3),
(5, 8),
(6, 6),
(6, 15),
(7, 5),
(7, 7),
(8, 1),
(8, 6),
(8, 12),
(9, 2),
(9, 13),
(10, 3),
(10, 10),
(11, 5),
(11, 14),
(12, 2),
(12, 9),
(13, 11),
(13, 19),
(14, 5),
(14, 10),
(15, 3),
(15, 11),
(16, 2),
(16, 8),
(17, 6),
(17, 9),
(18, 4),
(18, 13),
(19, 8),
(19, 20),
(20, 12),
(20, 18),
(20, 19);

INSERT INTO availability (start_date, end_date, status, property_id) VALUES
('2025-07-06', '2025-07-13', 'Pending', 1),
('2025-08-14', '2025-08-20', 'Pending', 2),
('2025-07-14', '2025-07-17', 'Pending', 3),
('2025-08-06', '2025-08-13', 'Booked', 4),
('2025-08-03', '2025-08-08', 'Pending', 5),
('2025-07-17', '2025-07-21', 'Available', 6),
('2025-08-04', '2025-08-07', 'Booked', 7),
('2025-07-08', '2025-07-15', 'Available', 8),
('2025-08-12', '2025-08-18', 'Available', 9),
('2025-07-07', '2025-07-10', 'Pending', 10),
('2025-08-14', '2025-08-20', 'Pending', 11),
('2025-08-10', '2025-08-13', 'Pending', 12),
('2025-07-05', '2025-07-09', 'Available', 13),
('2025-07-09', '2025-07-13', 'Available', 14),
('2025-08-11', '2025-08-15', 'Booked', 15),
('2025-07-18', '2025-07-22', 'Booked', 16),
('2025-07-14', '2025-07-18', 'Available', 17),
('2025-07-02', '2025-07-07', 'Booked', 18),
('2025-08-08', '2025-08-11', 'Booked', 19),
('2025-08-17', '2025-08-20', 'Pending', 20);

INSERT INTO room (room_name, room_type, room_price, property_id) VALUES
('Room 1', 'Suite', 264.22, 11),
('Room 2', 'Single', 264.22, 11),
('Room 3', 'Double', 204.55, 12),
('Room 4', 'Suite', 204.55, 12),
('Room 5', 'Single', 258.40, 13),
('Room 6', 'Double', 258.40, 13),
('Room 7', 'Suite', 119.99, 14),
('Room 8', 'Single', 119.99, 14),
('Room 9', 'Double', 148.76, 15),
('Room 10', 'Suite', 148.76, 15),
('Room 11', 'Suite', 289.99, 16),
('Room 12', 'Single', 289.99, 16),
('Room 13', 'Double', 175.25, 17),
('Room 14', 'Suite', 175.25, 17),
('Room 15', 'Single', 206.87, 18),
('Room 16', 'Double', 206.87, 18),
('Room 17', 'Suite', 194.33, 19),
('Room 18', 'Double', 194.33, 19),
('Room 19', 'Suite', 170.00, 20),
('Room 20', 'Single', 170.00, 20);

INSERT INTO amenity (name) VALUES
('Wi-Fi'),
('Air Conditioning'),
('Heating'),
('Hot Water'),
('Washer'),
('Dryer'),
('Free Parking'),
('Kitchen'),
('Refrigerator'),
('Microwave'),
('TV'),
('Hair Dryer'),
('Iron'),
('Balcony'),
('Fire Extinguisher'),
('Smoke Alarm'),
('First Aid Kit'),
('Workspace'),
('Coffee Maker'),
('Towels');

INSERT INTO room_amenity (room_id, amenity_id) VALUES
(1, 8),
(1, 11),
(2, 7),
(2, 6),
(2, 8),
(3, 6),
(4, 13),
(4, 10),
(5, 17),
(5, 10),
(5, 2),
(6, 1),
(6, 9),
(7, 17),
(7, 5),
(8, 8),
(8, 14),
(8, 16),
(9, 17),
(10, 7),
(10, 3),
(11, 3),
(12, 20),
(13, 4),
(13, 2),
(14, 18),
(15, 9),
(15, 1),
(15, 10),
(16, 14),
(17, 5),
(17, 6),
(18, 3),
(19, 15),
(20, 20),
(20, 6);

INSERT INTO property_amenity (property_id, amenity_id) VALUES
(1, 10),
(1, 11),
(2, 1),
(2, 8),
(3, 14),
(4, 17),
(4, 19),
(5, 7),
(5, 9),
(6, 3),
(6, 13),
(7, 17),
(8, 1),
(8, 20),
(9, 18),
(9, 19),
(10, 4),
(10, 14),
(11, 8),
(11, 11),
(11, 6),
(11, 7),
(12, 6),
(12, 13),
(12, 10),
(13, 17),
(13, 10),
(13, 2),
(13, 1),
(13, 9),
(14, 17),
(14, 5),
(14, 8),
(14, 14), 
(14, 16),
(15, 17),
(15, 7),
(15, 3),
(16, 3),
(16, 20),
(17, 4),
(17, 2),
(17, 18),
(18, 9),
(18, 1),
(18, 10),
(18, 14),
(19, 5),
(19, 6),
(19, 3),
(20, 15),
(20, 20),
(20, 6);

INSERT INTO wishlist (property_id, user_account_id) VALUES
(15, 10),
(10, 8),
(11, 2),
(17, 31),
(9, 11),
(16, 6),
(5, 27),
(20, 12),
(3, 24),
(4, 1),
(13, 30),
(2, 16),
(6, 21),
(7, 14),
(8, 33),
(1, 17),
(18, 3),
(12, 22),
(19, 25),
(14, 4);

INSERT INTO conversation (sender_id, booking_id, receiver_id) VALUES
(1, 1, 7),
(2, 2, 4),
(3, 3, 17),
(4, 4, 1),
(5, 5, 2),
(6, 6, 13),
(7, 7, 20),
(8, 8, 8),
(9, 9, 12),
(10, 10, 11),
(11, 11, 18),
(12, 12, 10),
(13, 13, 5),
(14, 14, 6),
(15, 15, 14),
(16, 16, 15),
(17, 17, 9),
(18, 18, 3),
(19, 19, 16),
(20, 20, 19);

INSERT INTO message (message_text, conversation_id, sender_id) VALUES
('Hi! Looking forward to my stay.', 2, 2),
('Can I check in a bit earlier?', 13, 13),
('Thanks for confirming the booking.', 20, 20),
('Will towels be provided?', 8, 8),
('What time should I check out?', 2, 2),
('Do you have parking available?', 18, 18),
('How do I get the keys?', 17, 17),
('Is the apartment near public transport?', 4, 4),
('The place looks great!', 1, 1),
('See you soon!', 14, 14),
('Can I bring a pet?', 17, 17),
("I'll be arriving late, is that okay?", 12, 12),
('Thank you for hosting!', 10, 10),
('Can we extend our stay?', 1, 1),
('Do you offer airport pickup?', 16, 16),
('Loved the photos online.', 11, 11),
('Hope everything goes well!', 6, 6),
('Do I need to bring toiletries?', 3, 3),
('Is there a balcony view?', 15, 15),
('Is early check-in available?', 5, 5),
('Hi! Looking forward to my stay.', 19, 19),
('Can I check in a bit earlier?', 9, 9),
('Thanks for confirming the booking.', 7, 7),
('Will towels be provided?', 12, 12),
('What time should I check out?', 11, 11),
('Do you have parking available?', 6, 6),
('How do I get the keys?', 8, 8),
('Is the apartment near public transport?', 16, 16),
('The place looks great!', 7, 7),
('See you soon!', 14, 14);

select username, email from user_account where id=10;

SELECT h.id AS host_id, ua.username AS username, h.rating AS rate FROM host h 
JOIN user_account ua ON h.user_account_id=ua.id ORDER BY h.rating DESC LIMIT 5;

SELECT id, rating FROM guest WHERE rating > 4.40;

SELECT id, name, refund_percentage, details FROM cancellation_policy
WHERE refund_percentage >= 80 ORDER BY refund_percentage DESC;

SELECT city, COUNT(*) AS neighborhood_count FROM neighborhood
GROUP BY city ORDER BY neighborhood_count DESC;

SELECT rental_type, COUNT(*) AS total_properties FROM property GROUP BY rental_type;

SELECT b.id AS booking_id, guest_user.username AS guest_name,host_user.username AS host_name, p.title AS property_title,     
DATEDIFF(b.check_out_date, b.check_in_date) AS duration_in_nights FROM booking b JOIN guest g ON b.guest_id = g.id 
JOIN user_account guest_user ON g.user_account_id = guest_user.id JOIN host h ON b.host_id = h.id 
JOIN user_account host_user ON h.user_account_id = host_user.id JOIN property p ON b.property_id = p.id 
HAVING duration_in_nights > 3 ORDER BY duration_in_nights DESC;

SELECT gr.id AS review_id, ua.username AS guest_name, gr.rating, gr.comment, gr.review_date FROM guest_review gr 
JOIN guest g ON gr.guest_id = g.id JOIN user_account ua ON g.user_account_id = ua.id WHERE gr.rating < 3 
ORDER BY gr.rating DESC, gr.review_date DESC;

SELECT ua.username AS guest_name, b.id AS booking_id, p.amount, p.payment_date
FROM payment p JOIN booking b ON p.booking_id = b.id JOIN guest g ON b.guest_id = g.id
JOIN user_account ua ON g.user_account_id = ua.id
WHERE p.payment_method = 'PayPal'
ORDER BY p.payment_date DESC;
 
SELECT p.title AS property_title, d.discount_rate, d.start_date, d.end_date
FROM discount d JOIN property p ON d.property_id = p.id
ORDER BY d.discount_rate DESC LIMIT 3;

SELECT p.id AS property_id, p.title AS property_title
FROM property_house_rule phr
JOIN property p ON phr.property_id = p.id
JOIN house_rule hr ON phr.house_rule_id = hr.id
WHERE hr.name = 'No Smoking';

SELECT hr.name AS house_rule_name, hr.description
FROM property_house_rule phr
JOIN house_rule hr ON phr.house_rule_id = hr.id
WHERE phr.property_id = 1;

SELECT p.title AS property_title, a.start_date, a.end_date, a.status
FROM availability a
JOIN property p ON a.property_id = p.id
WHERE a.property_id = 5
ORDER BY a.start_date;

SELECT p.title AS property_title, r.room_name, r.room_price
FROM room r
JOIN property p ON r.property_id = p.id
WHERE r.room_type = 'Double'
ORDER BY r.room_price DESC;

SELECT id, name FROM amenity ORDER BY name ASC;

SELECT p.id AS property_id, p.title AS property_title
FROM property_amenity pa
JOIN property p ON pa.property_id = p.id
WHERE pa.amenity_id = 6;

SELECT r.id AS room_id, r.room_name, r.room_type, r.room_price,
p.title AS property_title FROM  room_amenity ra
JOIN room r ON ra.room_id = r.id
JOIN property p ON r.property_id = p.id
WHERE ra.amenity_id = 10;

SELECT ua.username, ua.email, w.added_at
FROM  wishlist w
JOIN user_account ua ON w.user_account_id = ua.id
WHERE w.property_id = 12;

SELECT c.id AS conversation_id, s.username AS sender_name, r.username AS receiver_name,
c.booking_id FROM conversation c JOIN user_account s ON c.sender_id = s.id
JOIN user_account r ON c.receiver_id = r.id
ORDER BY c.booking_id;

SELECT m.id AS message_id, ua.username AS sender_name, m.message_text,
m.sent_at FROM message m
JOIN user_account ua ON m.sender_id = ua.id
WHERE m.conversation_id = 5
ORDER BY m.sent_at;

SELECT DISTINCT ua.username AS guest_name, p.title AS property_title
FROM booking b
JOIN guest g ON b.guest_id = g.id
JOIN user_account ua ON g.user_account_id = ua.id
JOIN property p ON b.property_id = p.id
JOIN property_house_rule phr ON p.id = phr.property_id
JOIN house_rule hr ON phr.house_rule_id = hr.id
WHERE hr.name = 'No Smoking';

SELECT DISTINCT p.title AS property_title FROM property p
JOIN room r ON r.property_id = p.id
JOIN room_amenity ra ON ra.room_id = r.id
JOIN amenity a ON ra.amenity_id = a.id
WHERE r.room_type = 'Suite' AND a.name = 'Free Parking';

 
 
 
 
 