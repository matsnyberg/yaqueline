

def get_file_contents path
  IO.read File.join(File.dirname(__FILE__), path)
end
