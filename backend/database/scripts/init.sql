-- Insert test data
INSERT INTO users (name, email, password, created_at, updated_at) VALUES
('Test User', 'test@example.com', '$2y$12$H4cXxz7aT0PXz9v5kL8P5uXhKvPy.xQH.8pLnH.5P5H5H8P.5H8P.', NOW(), NOW()),
('Admin User', 'admin@example.com', '$2y$12$H4cXxz7aT0PXz9v5kL8P5uXhKvPy.xQH.8pLnH.5P5H5H8P.5H8P.', NOW(), NOW());

INSERT INTO documents (user_id, filename, file_path, status, created_at, updated_at) VALUES
(1, 'sample.pdf', 'documents/user_1/sample.pdf', 'uploaded', NOW(), NOW()),
(1, 'report.pdf', 'documents/user_1/report.pdf', 'completed', NOW(), NOW()),
(2, 'invoice.pdf', 'documents/user_2/invoice.pdf', 'uploaded', NOW(), NOW());

INSERT INTO document_logs (document_id, status, sent_at, created_at) VALUES
(2, 'sent', NOW(), NOW()),
(3, 'pending', NULL, NOW());
