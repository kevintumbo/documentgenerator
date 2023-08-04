package co.navyget.DocumentGenerator.service.implementation;

import co.navyget.DocumentGenerator.dto.UserDTO;
import co.navyget.DocumentGenerator.domain.User;
import co.navyget.DocumentGenerator.dtomapper.UserDTOMapper;
import co.navyget.DocumentGenerator.repository.UserRepository;
import co.navyget.DocumentGenerator.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository<User> userRepository;
    /**
     * @param user
     * @return
     */
    @Override
    public UserDTO createUser(User user) {
        return UserDTOMapper.fromUser(userRepository.create(user));
    }
}
