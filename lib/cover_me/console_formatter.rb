class CoverMe::ConsoleFormatter < CoverMe::Formatter

  COLOR_CODE = {
    reset:      '0',

    foreground: '3',
    background: '4',

    black:      '0',
    red:        '1',
    green:      '2',
    yellow:     '3',
    blue:       '4',
    magenta:    '5',
    cyan:       '6',
    white:      '7',

    bold:       '1',
    italic:     '3',
    underline:  '4'
  }

  COLOR = {
    'reset' => "\e[" + COLOR_CODE[:reset] + 'm',
    'hit'   => "\e[" + COLOR_CODE[:foreground] + COLOR_CODE[:white]  +
                 ';' + COLOR_CODE[:bold] +
                 ';' + COLOR_CODE[:background] + COLOR_CODE[:green]  + 'm',
    'near'  => "\e[" + COLOR_CODE[:foreground] + COLOR_CODE[:yellow] +
                 ';' + COLOR_CODE[:bold] +
                 ';' + COLOR_CODE[:background] + COLOR_CODE[:black]  + 'm',
    'miss'  => "\e[" + COLOR_CODE[:foreground] + COLOR_CODE[:white]  +
                 ';' + COLOR_CODE[:bold] +
                 ';' + COLOR_CODE[:background] + COLOR_CODE[:red]    + 'm'
  }

  def format_report(report)
  end

  def format_index(index)
    template_file = File.join(File.dirname(__FILE__), 'templates', 'console.erb')
    config = CoverMe.config.console_formatter
    color = config.use_color ? COLOR : {}

    template('console.erb', '-').run(binding)
    return if index.percent_tested == 100

    index.reports.sort.each do |report|
      template('console.file.erb', '-').run(binding)
      next unless config.verbose

      $stdout.puts '    Untested line(s):' unless report.executed_percent == 100.0
      num_width = (report.source.length).to_s.length
      last_rendered = nil
      report.coverage.each_with_index do |count, line|
        next unless report.coverage[line - 1] == 0 ||
                    count == 0                     ||
                    report.coverage[line + 1] == 0

        status = count == 0 ? 'miss' : 'hit'
        template('console.line.erb', '-').run(binding)
        $stdout.puts '' unless count == 0 || report.coverage[line + 1] == 0
      end
      $stdout.puts '' if config.verbose && index.percent_tested == 100
    end
  end
end
