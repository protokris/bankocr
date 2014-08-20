class OutputWriter

  def write(account_data)
    puts print_number(account_data) + ' ' + print_status(account_data)
  end

  def print_number(account_data)
    account_data[:number] || ''
  end

  def print_status(account_data) 
    status = ''
    if account_data[:illegible]
      status = 'ILL'
    elsif !account_data[:valid]
      status = 'ERR'
    end
    status
  end

  private :print_status, :print_number

end