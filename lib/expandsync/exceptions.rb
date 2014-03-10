module Exceptions
  class InvalidFileError < StandardError; end
  class InvalidCSVError < InvalidFileError; end
  class InvalidXMLError < InvalidFileError; end
end