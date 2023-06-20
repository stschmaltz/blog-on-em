module PostsHelper
  def published(post)
    if post.published_at.present?
      post.published_at.strftime('%-b %-d, %Y')
    else
      'Not published yet'
    end
  end

  def tag_filter_dropdown(filter)
    @tags = Tag.all
    form_with url: '#', id: 'tag_filter_form', method: :get, class: 'bg-red' do |form|
      capture do
        concat form.select :filter, options_for_select([['All Posts', '']] + @tags.map do |t|
                                                                               [t.name, t.name]
                                                                             end, filter), {}, { id: 'filter', class: 'form-input-selector' }
      end
    end
  end

  def tag_filter_javascript
    javascript_tag <<~JS
      document.getElementById('filter').addEventListener('change', function(event) {
        var tag = event.target.value;
        if(tag) {
          window.location = '/posts/filter/' + tag;
        } else {
          window.location = '/posts';
        }
      });
    JS
  end
end
