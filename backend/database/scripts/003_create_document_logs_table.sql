-- Create document_logs table
CREATE TABLE IF NOT EXISTS document_logs (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  document_id BIGINT UNSIGNED NOT NULL,
  status VARCHAR(50) NOT NULL COMMENT 'sent, failed, pending',
  sent_at TIMESTAMP NULL,
  error_message TEXT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
  INDEX idx_document_id (document_id),
  INDEX idx_status (status),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
