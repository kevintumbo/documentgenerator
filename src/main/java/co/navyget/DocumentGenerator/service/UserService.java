package co.navyget.DocumentGenerator.service;

import co.navyget.DocumentGenerator.dto.UserDTO;
import co.navyget.DocumentGenerator.domain.User;

public interface UserService {
    UserDTO createUser(User user);
}
