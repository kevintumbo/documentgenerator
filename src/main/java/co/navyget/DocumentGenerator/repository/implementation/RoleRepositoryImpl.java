package co.navyget.DocumentGenerator.repository.implementation;

import co.navyget.DocumentGenerator.domain.Role;
import co.navyget.DocumentGenerator.exception.ApiException;
import co.navyget.DocumentGenerator.repository.RoleRepository;
import co.navyget.DocumentGenerator.rowmapper.RoleRowMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.Map;

import static co.navyget.DocumentGenerator.enumeration.RoleType.ROLE_USER;
import static co.navyget.DocumentGenerator.query.RoleQuery.*;

@Repository
@RequiredArgsConstructor
@Slf4j
public class RoleRepositoryImpl implements RoleRepository<Role> {
    private final NamedParameterJdbcTemplate jdbc;

    /**
     * @param data
     * @return
     */
    @Override
    public Role create(Role data) {
        return null;
    }

    /**
     * @param page
     * @param pageSize
     * @return
     */
    @Override
    public Collection<Role> list(int page, int pageSize) {
        return null;
    }

    /**
     * @param id
     * @return
     */
    @Override
    public Role get(Long id) {
        return null;
    }

    /**
     * @param data
     * @return
     */
    @Override
    public Role update(Role data) {
        return null;
    }

    /**
     * @param id
     * @return
     */
    @Override
    public Boolean delete(Long id) {
        return null;
    }

    /**
     * @param userId
     * @param roleName
     */
    @Override
    public void addRoleToUser(Long userId, String roleName) {
        log.info("Adding role {} tp userid: {}", roleName, userId);
        try {
            Role role = jdbc.queryForObject(SELECT_ROLE_BY_NAME_QUERY, Map.of("roleName", roleName), new RoleRowMapper());
            jdbc.update(INSERT_ROLE_TO_USER_QUERY, Map.of("userId", userId, "roleId", role.getId()));
        } catch (EmptyResultDataAccessException exception) {
            throw new ApiException("No role found by name: " + ROLE_USER.name());
        } catch (Exception exception) {
            throw new ApiException("An error occurred. Please try again.");
        }
    }

    /**
     * @param userId
     * @return
     */
    @Override
    public Role getRoleByUserId(Long userId) {
        return null;
    }

    /**
     * @param email
     * @return
     */
    @Override
    public Role getRoleByUserEmail(String email) {
        return null;
    }

    /**
     * @param userId
     * @param roleName
     */
    @Override
    public void updateUserRole(Long userId, String roleName) {

    }
}
