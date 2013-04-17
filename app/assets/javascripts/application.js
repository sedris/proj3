// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// must send csrf toden with each ajax request
$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
  }
});
$(function(){
    $('.stickyNote.list')
        // send updated position to server
        .draggable({
            stop: function(e, ui) {
                console.log("dragged", $(this));
                $.ajax({
                    url: '/lists/' + $(this).attr('data-listId'),
                    type: 'PUT',
                    data: { _method:'PUT', x: $(this).position().left, y: $(this).position().top,
                        width: $(this).width(), height: $(this).height()},
                    dataType: 'json',
                    success: function(data) {
                        //alert('put sent');
                  }
                });
            }
        })
        // send updated size to server
        .resizable({
            stop: function(e, ui) {
                $.ajax({
                    url: '/lists/' + $(this).attr('data-listId'),
                    type: 'PUT',
                    data: { _method:'PUT', x: $(this).position().left, y: $(this).position().top,
                        width: $(this).width(), height: $(this).height()},
                    dataType: 'json',
                    success: function(data) {
                        //alert('put sent');
                  }
                });
            }
        });

        // add task on enter and clicking 'add'
        $(function(){
            $('.description').unbind('keypress').keypress( function(event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                    add_task($(event.target).parent().parent());
                }
            });
            $('.add_task').unbind('click').click( function(event) {
                add_task($(event.target).parent().parent()); 
            });  
        });

});
// modified from: http://www.buildfortheweb.com/2010/11/25/create-a-to-do-list-with-jquery/
add_task = function(list) {
    //var list = $(event.target).parent().parent();
    var list_id = list.attr('data-listId');
    var taskList = list.children('.task_list');
    var taskDescriptionObject = list.children('.enter_task').children('.description');

    //console.log('list id', list_id);

    var taskDescription = taskDescriptionObject.html();
    if (taskDescription == "") {
        return false;
    }

    // save task in model
    $.ajax({
        url: '/create_task/' + list_id,
        type: 'POST',
        data: { _method:'POST', body:taskDescription, complete:false },
        dataType: 'json',
        success: function(data) {
            //alert('put sent');
            //console.log('task created - data', data);
            
            taskList.append('<div class="task" data-taskId=' + data.id + '>'
            + '<span>'
            + '<input type="checkbox" class="check_task" name="check_task"/>'
            + '</span>'
            + '<span class="task_description">'
            + taskDescription
            + '</span>'
            + '<span class="delete_task" style="float:right;cursor:pointer;"><a>X</a></span>'
            + '</div>');
            
            // put space in description as filler
            taskDescriptionObject.html("");

            $('.check_task').unbind('click');
            $('.check_task').click( function() {
                //console.log('check task this', $(this));
                var task = $(this).parent().parent();
                var description = task.children('.task_description').html();
                task.toggleClass('checked');
                // mark task as complete
                if (task.hasClass('.checked')) {
                    //console.log('mark');
                    task.children('.task_description').css('text-decoration', 'line-through');
                    $.ajax({
                        url: '/tasks/' + task.attr('data-taskId'),
                        type: 'PUT',
                        data: { _method:'PUT', body: description, complete: true},
                        dataType: 'json',
                        success: function(data) {
                            //alert('put sent');
                      }
                    });
                } else {
                    // mark task as not complete
                    //console.log('unmark');
                    task.children('.task_description').css('text-decoration', 'none');
                    $.ajax({
                        url: '/tasks/' + task.attr('data-taskId'),
                        type: 'PUT',
                        data: { _method:'PUT', body: description, complete: false},
                        dataType: 'json',
                        success: function(data) {
                            //alert('put sent');
                      }
                    });
                }
            });
      }
    });

    $('.check_task').unbind('click');
    $('.check_task').click( function() {
        //console.log('check task this', $(this));
        var task = $(this).parent().parent();
        var description = task.children('.task_description').html();
        task.toggleClass('checked');
        // mark task as complete
        if (task.hasClass('.checked')) {
            //console.log('mark');
            task.children('.task_description').css('text-decoration', 'line-through');
            $.ajax({
                url: '/tasks/' + task.attr('data-taskId'),
                type: 'PUT',
                data: { _method:'PUT', body: description, complete: true},
                dataType: 'json',
                success: function(data) {
                    //alert('put sent');
              }
            });
        } else {
            // mark task as not complete
            //console.log('unmark');
            task.children('.task_description').css('text-decoration', 'none');
            $.ajax({
                url: '/tasks/' + task.attr('data-taskId'),
                type: 'PUT',
                data: { _method:'PUT', body: description, complete: false},
                dataType: 'json',
                success: function(data) {
                    //alert('put sent');
              }
            });
        }
    });

    $('.delete_task').unbind('click').click( function(event) {
        //console.log('deleting', $(event));

        var task_id = $(event.target).parent().parent().attr('data-taskId');
        $.ajax({
            url: '/tasks/' + task_id,
            type: 'DELETE',
            data: { _method:'DELETE'},
            dataType: 'json',
            success: function(data) {
                $(".task[data-taskId='" + data.id + "']").remove();
          }
        });
    });
    return false;
}