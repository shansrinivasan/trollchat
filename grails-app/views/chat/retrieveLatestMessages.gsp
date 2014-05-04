<g:each in="${messages}" var="message">
    <div>
        <span class="nickname">${message.date}</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nickname">${message.user.tcHandle}</span> - <span class="msg">${message.message}</span>
    </div>
</g:each>