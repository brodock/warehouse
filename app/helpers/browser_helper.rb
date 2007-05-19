module BrowserHelper
  def link_to_node(text, node, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    link_to text, url_for_node(node, args.first), options
  end

  def url_for_node(node, rev = nil)
    paths = node.respond_to?(:paths) ? node.paths : node.to_s.split('/')
    rev = rev ? rev.to_s : params[:rev]
    rev = "r#{rev}" unless rev.nil? || rev =~ /^r/
    rev ? rev_browser_path(:paths => paths, :rev => rev) : browser_path(:paths => paths)
  end
  
  def link_to_crumbs(path, rev = nil)
    pieces    = path.split '/'
    name      = pieces.pop
    home_link = %(<li#{' class="crumb-divide-last"' if pieces.size == 0 && !name.nil?}>#{link_to 'Home', (rev ? rev_browser_path : browser_path)}</li>)
    return home_link unless name
    prefix = ''
    pieces.collect! do |piece|
      link = %(<li#{' class="crumb-divide-last"' if pieces.last == piece}>#{link_to_node(piece, "#{prefix}#{piece}", rev)}</li>)
      prefix << piece << '/'
      link
    end.unshift(home_link).join << %(<li id="current">#{name}</li>)
  end
  
  def css_class_for(node)
    node.dir? ? 'folder' : CSS_CLASSES[File.extname(node.name)] || 'file'
  end
end
