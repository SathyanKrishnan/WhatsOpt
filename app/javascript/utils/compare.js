function deepIsEqual(first, second) {
  // If first and second are the same type and have the same value
  // Useful if strings or other primitive types are compared
  if (first === second) { return true; }

  // Try a quick compare by seeing if the length of properties are the same
  const firstProps = Object.getOwnPropertyNames(first);
  const secondProps = Object.getOwnPropertyNames(second);

  // Check different amount of properties
  if (firstProps.length !== secondProps.length) { return false; }

  // Go through properties of first object
  for (let i = 0; i < firstProps.length; i += 1) {
    const prop = firstProps[i];
    // Check the type of property to perform different comparisons
    switch (typeof (first[prop])) {
      // If it is an object, decend for deep compare
      case 'object':
        if (!deepIsEqual(first[prop], second[prop])) { return false; }
        break;
      case 'number':
        // with JavaScript NaN != NaN so we need a special check
        // eslint-disable-next-line no-restricted-globals
        if (isNaN(first[prop]) && isNaN(second[prop])) { break; }
      // eslint-disable-next-line no-fallthrough
      default:
        if (first[prop] !== second[prop]) { return false; }
    }
  }
  return true;
}

export default deepIsEqual;
