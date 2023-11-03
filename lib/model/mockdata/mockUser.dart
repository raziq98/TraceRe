import '../user.dart';

class MockUser {
  static List<User> users = [
    User(
      id: 1,
      name: 'John Doe',
      userCode: 'JD001',
      address: '123 Main Street',
      postalCode: '12345',
      country: 'USA',
      photo: 'profile.jpg',
      phone: '+1234567890',
      email: 'john@example.com',
      password: 'secretpassword',
      roleId: 2,
      branchCode: 'BR001',
      departmentId: 3,
      isAvailable: true,
      isOffDay: false,
    ),
    User(
      id: 2,
      name: 'Jane Smith',
      userCode: 'JS001',
      address: '456 Elm Avenue',
      postalCode: '54321',
      country: 'Canada',
      photo: 'profile2.jpg',
      phone: '+9876543210',
      email: 'jane@example.com',
      password: 'password123',
      roleId: 1,
      branchCode: 'BR002',
      departmentId: 4,
      isAvailable: false,
      isOffDay: true,
    ),
    User(
      id: 3,
      name: 'Michael Johnson',
      userCode: 'MJ003',
      address: '789 Oak Street',
      postalCode: '67890',
      country: 'UK',
      photo: 'profile3.jpg',
      phone: '+441234567890',
      email: 'michael@example.com',
      password: 'secure456',
      roleId: 3,
      branchCode: 'BR003',
      departmentId: 2,
      isAvailable: true,
      isOffDay: false,
    ),
    User(
      id: 4,
      name: 'Emily Brown',
      userCode: 'EB004',
      address: '234 Maple Lane',
      postalCode: '98765',
      country: 'Australia',
      photo: 'profile4.jpg',
      phone: '+61234567890',
      email: 'emily@example.com',
      password: 'pass987',
      roleId: 1,
      branchCode: 'BR004',
      departmentId: 1,
      isAvailable: true,
      isOffDay: true,
    ),
    User(
      id: 5,
      name: 'David Wilson',
      userCode: 'DW005',
      address: '567 Pine Road',
      postalCode: '56789',
      country: 'New Zealand',
      photo: 'profile5.jpg',
      phone: '+640987654321',
      email: 'david@example.com',
      password: 'davidpass',
      roleId: 2,
      branchCode: 'BR005',
      departmentId: 3,
      isAvailable: false,
      isOffDay: false,
    ),
    User(
      id: 1,
      name: 'John Doe',
      userCode: 'JD001',
      address: '123 Main Street',
      postalCode: '12345',
      country: 'USA',
      photo: 'profile.jpg',
      phone: '+1234567890',
      email: 'john@example.com',
      password: 'secretpassword',
      roleId: 2,
      branchCode: 'BR001',
      departmentId: 3,
      isAvailable: true,
      isOffDay: false,
    ),
    User(
      id: 2,
      name: 'Jane Smith',
      userCode: 'JS001',
      address: '456 Elm Avenue',
      postalCode: '54321',
      country: 'Canada',
      photo: 'profile2.jpg',
      phone: '+9876543210',
      email: 'jane@example.com',
      password: 'password123',
      roleId: 1,
      branchCode: 'BR002',
      departmentId: 4,
      isAvailable: false,
      isOffDay: true,
    ),
    User(
      id: 3,
      name: 'Michael Johnson',
      userCode: 'MJ003',
      address: '789 Oak Street',
      postalCode: '67890',
      country: 'UK',
      photo: 'profile3.jpg',
      phone: '+441234567890',
      email: 'michael@example.com',
      password: 'secure456',
      roleId: 3,
      branchCode: 'BR003',
      departmentId: 2,
      isAvailable: true,
      isOffDay: false,
    ),
    User(
      id: 4,
      name: 'Emily Brown',
      userCode: 'EB004',
      address: '234 Maple Lane',
      postalCode: '98765',
      country: 'Australia',
      photo: 'profile4.jpg',
      phone: '+61234567890',
      email: 'emily@example.com',
      password: 'pass987',
      roleId: 1,
      branchCode: 'BR004',
      departmentId: 1,
      isAvailable: true,
      isOffDay: true,
    ),
    User(
      id: 5,
      name: 'David Wilson',
      userCode: 'DW005',
      address: '567 Pine Road',
      postalCode: '56789',
      country: 'New Zealand',
      photo: 'profile5.jpg',
      phone: '+640987654321',
      email: 'david@example.com',
      password: 'davidpass',
      roleId: 2,
      branchCode: 'BR005',
      departmentId: 3,
      isAvailable: false,
      isOffDay: false,
    ),
    User(
      id: 1,
      name: 'John Doe',
      userCode: 'JD001',
      address: '123 Main Street',
      postalCode: '12345',
      country: 'USA',
      photo: 'profile.jpg',
      phone: '+1234567890',
      email: 'john@example.com',
      password: 'secretpassword',
      roleId: 2,
      branchCode: 'BR001',
      departmentId: 3,
      isAvailable: true,
      isOffDay: false,
    ),
    User(
      id: 2,
      name: 'Jane Smith',
      userCode: 'JS001',
      address: '456 Elm Avenue',
      postalCode: '54321',
      country: 'Canada',
      photo: 'profile2.jpg',
      phone: '+9876543210',
      email: 'jane@example.com',
      password: 'password123',
      roleId: 1,
      branchCode: 'BR002',
      departmentId: 4,
      isAvailable: false,
      isOffDay: true,
    ),
    User(
      id: 3,
      name: 'Michael Johnson',
      userCode: 'MJ003',
      address: '789 Oak Street',
      postalCode: '67890',
      country: 'UK',
      photo: 'profile3.jpg',
      phone: '+441234567890',
      email: 'michael@example.com',
      password: 'secure456',
      roleId: 3,
      branchCode: 'BR003',
      departmentId: 2,
      isAvailable: true,
      isOffDay: false,
    ),
    User(
      id: 4,
      name: 'Emily Brown',
      userCode: 'EB004',
      address: '234 Maple Lane',
      postalCode: '98765',
      country: 'Australia',
      photo: 'profile4.jpg',
      phone: '+61234567890',
      email: 'emily@example.com',
      password: 'pass987',
      roleId: 1,
      branchCode: 'BR004',
      departmentId: 1,
      isAvailable: true,
      isOffDay: true,
    ),
    User(
      id: 5,
      name: 'David Wilson',
      userCode: 'DW005',
      address: '567 Pine Road',
      postalCode: '56789',
      country: 'New Zealand',
      photo: 'profile5.jpg',
      phone: '+640987654321',
      email: 'david@example.com',
      password: 'davidpass',
      roleId: 2,
      branchCode: 'BR005',
      departmentId: 3,
      isAvailable: false,
      isOffDay: false,
    ),
    User(
      id: 1,
      name: 'John Doe',
      userCode: 'JD001',
      address: '123 Main Street',
      postalCode: '12345',
      country: 'USA',
      photo: 'profile.jpg',
      phone: '+1234567890',
      email: 'john@example.com',
      password: 'secretpassword',
      roleId: 2,
      branchCode: 'BR001',
      departmentId: 3,
      isAvailable: true,
      isOffDay: false,
    ),
    User(
      id: 2,
      name: 'Jane Smith',
      userCode: 'JS001',
      address: '456 Elm Avenue',
      postalCode: '54321',
      country: 'Canada',
      photo: 'profile2.jpg',
      phone: '+9876543210',
      email: 'jane@example.com',
      password: 'password123',
      roleId: 1,
      branchCode: 'BR002',
      departmentId: 4,
      isAvailable: false,
      isOffDay: true,
    ),
    User(
      id: 3,
      name: 'Michael Johnson',
      userCode: 'MJ003',
      address: '789 Oak Street',
      postalCode: '67890',
      country: 'UK',
      photo: 'profile3.jpg',
      phone: '+441234567890',
      email: 'michael@example.com',
      password: 'secure456',
      roleId: 3,
      branchCode: 'BR003',
      departmentId: 2,
      isAvailable: true,
      isOffDay: false,
    ),
    User(
      id: 4,
      name: 'Emily Brown',
      userCode: 'EB004',
      address: '234 Maple Lane',
      postalCode: '98765',
      country: 'Australia',
      photo: 'profile4.jpg',
      phone: '+61234567890',
      email: 'emily@example.com',
      password: 'pass987',
      roleId: 1,
      branchCode: 'BR004',
      departmentId: 1,
      isAvailable: true,
      isOffDay: true,
    ),
    User(
      id: 5,
      name: 'David Wilson',
      userCode: 'DW005',
      address: '567 Pine Road',
      postalCode: '56789',
      country: 'New Zealand',
      photo: 'profile5.jpg',
      phone: '+640987654321',
      email: 'david@example.com',
      password: 'davidpass',
      roleId: 2,
      branchCode: 'BR005',
      departmentId: 3,
      isAvailable: false,
      isOffDay: false,
    ),
  ];
}
