package com.booksmart.auth.repository;

import com.booksmart.auth.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role ,Long> {
}
