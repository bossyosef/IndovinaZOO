module GameHelper
  def form_path
    if params[:id] < params[:numeroquiz]
      return "/quiz/"+(params[:id].to_i+1).to_s
	elsif params[:id] == params[:numeroquiz]
	  return "/result"
  end
end
