String formatOccupation(String occupation) {
  switch (occupation) {
    case 'Sales and Services (Trading)':
      return 'Sales';
    case 'Agriculture (Farming, Poultry etc.)':
      return 'Agriculture';
    case 'Clerical (Administrative, secretarial etc.)':
      return 'Clerical';
    case 'Professional/technical/managerial (Lawyer, Manager, Engineer etc.)':
      return 'Professional';
    case 'Skilled Manual Labour (Tailoring, Hairdressing etc)':
      return 'Skilled Manual';
    case 'Unskilled Manual Labour (Cleaner,  etc)':
      return 'Unskilled Manual';
    case 'Unemployed':
      return 'Unemployed';
    case 'What is your occupation':
      return 'Unknown';

    default:
      throw Exception('Unknown String passed to function formatOccupation');
  }
}
