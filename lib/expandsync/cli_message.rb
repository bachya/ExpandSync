module ExpandSync
  #  ======================================================
  #  CliManager Module
  #  Singleton to manage common CLI interfacing
  #  ======================================================
  module CLIMessage
    #  ====================================================
    #  Methods
    #  ====================================================
    #  ----------------------------------------------------
    #  error method
    #
    #  Outputs a formatted-red error message.
    #  @param m The message to output
    #  @return Void
    #  ----------------------------------------------------
    def self.error(m, log = true)
      Methadone::CLILogging.error(m) if log
      puts "---> ERROR: #{ m }".red
    end

    #  ----------------------------------------------------
    #  info method
    #
    #  Outputs a formatted-blue informational message.
    #  @param m The message to output
    #  @return Void
    #  ----------------------------------------------------
    def self.info(m, log = true)
      Methadone::CLILogging.info(m) if log
      puts "---> INFO: #{ m }".blue
    end

    #  ----------------------------------------------------
    #  info_block method
    #
    #  Wraps a block in an opening and closing info message.
    #  @param m1 The opening message to output
    #  @param m2 The closing message to output
    #  @param multiline Whether the message should be multiline
    #  @return Void
    #  ----------------------------------------------------
    def self.info_block(m1, m2 = 'Done.', multiline = false, log = true)
      if block_given?
        if multiline
          info(m1, log)
        else
          print "---> INFO: #{ m1 }".blue
        end

        yield

        if multiline
          info(m2, log)
        else
          puts m2.blue
        end
      else
        error = 'Did not specify a valid block'
        Methadone::CLILogging.error(error) if log
        fail ArgumentError, error
      end
    end

    #  ----------------------------------------------------
    #  prompt method
    #
    #  Outputs a prompt, collects the user's response, and
    #  returns it.
    #  @param prompt The prompt to output
    #  @param default The default option
    #  @return String
    #  ----------------------------------------------------
    def self.prompt(prompt, default = nil, log = true)
      print "#{ prompt } #{ default.nil? ? '' : "[default: #{ default }]:" } ".blue
      choice = $stdin.gets.chomp
      if choice.empty?
        r = default
      else
        r = choice
      end

      Methadone::CLILogging.info("Answer to '#{ prompt }': #{r}") if log
      r
    end

    #  ----------------------------------------------------
    #  section method
    #
    #  Outputs a formatted-orange section message.
    #  @param m The message to output
    #  @return Void
    #  ----------------------------------------------------
    def self.section(m, log = true)
      Methadone::CLILogging.info(m) if log
      puts "#### #{ m }".purple
    end

    #  ----------------------------------------------------
    #  section_block method
    #
    #  Wraps a block in an opening and closing section
    #  message.
    #  @param m1 The opening message to output
    #  @param m2 The closing message to output
    #  @param multiline A multiline message or not
    #  @return Void
    #  ----------------------------------------------------
    def self.section_block(m, multiline = true, log = true)
      if block_given?
        if multiline
          section(m, log)
        else
          print "#### #{ m }".purple
        end

        yield
      else
        error = 'Did not specify a valid block'
        Methadone::CLILogging.error(error) if log
        fail ArgumentError, error
      end
    end

    #  ----------------------------------------------------
    #  success method
    #
    #  Outputs a formatted-green success message.
    #  @param m The message to output
    #  @return Void
    #  ----------------------------------------------------
    def self.success(m, log = true)
      Methadone::CLILogging.info(m) if log
      puts "---> SUCCESS: #{ m }".green
    end

    #  ----------------------------------------------------
    #  warning method
    #
    #  Outputs a formatted-yellow warning message.
    #  @param m The message to output
    #  @return Void
    #  ----------------------------------------------------
    def self.warning(m, log = true)
      Methadone::CLILogging.warn(m) if log
      puts "---> WARNING: #{ m }".yellow
    end
  end
end

#  ======================================================
#  String Class
#  ======================================================
class String
  #  ----------------------------------------------------
  #  colorize method
  #
  #  Outputs a string in a formatted color.
  #  @param color_code The code to use
  #  @return Void
  #  ----------------------------------------------------
  def colorize(color_code)
    "\e[#{ color_code }m#{ self }\e[0m"
  end

  #  ----------------------------------------------------
  #  blue method
  #
  #  Convenience method to output a blue string
  #  @return Void
  #  ----------------------------------------------------
  def blue
    colorize(34)
  end

  #  ----------------------------------------------------
  #  green method
  #
  #  Convenience method to output a green string
  #  @return Void
  #  ----------------------------------------------------
  def green
    colorize(32)
  end

  #  ----------------------------------------------------
  #  purple method
  #
  #  Convenience method to output a purple string
  #  @return Void
  #  ----------------------------------------------------
  def purple
    colorize(35)
  end

  #  ----------------------------------------------------
  #  red method
  #
  #  Convenience method to output a red string
  #  @return Void
  #  ----------------------------------------------------
  def red
    colorize(31)
  end

  #  ----------------------------------------------------
  #  yellow method
  #
  #  Convenience method to output a yellow string
  #  @return Void
  #  ----------------------------------------------------
  def yellow
    colorize(33)
  end
end
