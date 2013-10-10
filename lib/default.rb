# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require "nanoc/toolbox"

def get_post_start(post)
  content = post.compiled_content
  if content =~ /\s<!-- more -->\s/
    content = content.partition('<!-- more -->').first
  end
  return content
end