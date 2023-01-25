String formatLocation(String location) {
  if (location.endsWith('South West')) {
    return location.replaceFirst('South West', 'S/W');
  } else if (location.endsWith('South East')) {
    return location.replaceFirst('South East', 'S/E');
  } else if (location.endsWith('North West')) {
    return location.replaceFirst('North West', 'N/W');
  } else if (location.endsWith('North East')) {
    return location.replaceFirst('North East', 'N/E');
  } else {
    return location;
  }
}
