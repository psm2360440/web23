<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .fc-day-sun a {
        color: #ebb2fb;
    }

    .fc-day-sat a {
        color: #a9d7b5;
    }
</style>

<script>

    $(function(){

        var calendar = new FullCalendar.Calendar($('#calendar')[0], {
            height: '600px', // calendar 높이 설정
            headerToolbar: {
                start: 'dayGridMonth,timeGridWeek,timeGridDay today',
                center: 'title',
                end: 'prevYear,prev,next,nextYear'
            },
            footerToolbar: {
                start: 'prev',
                center: '',
                end: 'next'
            }
                //,
            // customButtons: {
            //     custom1: {
            //         text: 'custom 1',
            //         click: function() {
            //             alert('clicked custom button 1!');
            //         }
            //     },
            //     custom2: {
            //         text: 'custom 2',
            //         click: function() {
            //             alert('clicked custom button 2!');
            //         }
            //     }
            // }
        });

        calendar.render();

    });
</script>
<div class="col-sm-8  text-left ">
    <div class="container">
        <div class="row content">
            <div class="col-sm-8  text-left ">
                    <div id='calendar-container' style="margin-top: 5% ">
                        <div id='calendar'></div>
                    </div>
            </div>
        </div>
    </div>
</div>