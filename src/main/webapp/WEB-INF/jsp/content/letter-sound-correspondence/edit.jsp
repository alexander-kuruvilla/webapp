<content:title>
    <fmt:message key="edit.letter.sound.correspondence" />
</content:title>

<content:section cssId="letterSoundCorrespondenceEditPage">
    <h4><content:gettitle /></h4>
    <div class="card-panel">
        <form:form modelAttribute="letterSoundCorrespondence">
            <tag:formErrors modelAttribute="letterSoundCorrespondence" />
            
            <form:hidden path="revisionNumber" value="${letterSoundCorrespondence.revisionNumber}" />
            <form:hidden path="usageCount" value="${letterSoundCorrespondence.usageCount}" />
            <input type="hidden" name="timeStart" value="${timeStart}" />
            
            <div class="row">
                <div class="col s12">
                    <label><fmt:message key="letters" /></label><br />
                    "<span id="lettersContainer">
                        <c:forEach var="letter" items="${letterSoundCorrespondence.letters}">
                            <input name="letters" type="hidden" value="${letter.id}" />
                            <div class="chip" data-letterid="${letter.id}" data-lettervalue="${letter.text}"
                                 style="font-size: 2rem; padding: 1rem; height: auto;">
                                ${letter.text} 
                                <a href="#" class="letterDeleteLink" data-letterid="${letter.id}">
                                    <i class="close material-icons">clear</i>
                                </a>
                            </div>
                        </c:forEach>
                        <script>
                            $(function() {
                                $('.letterDeleteLink').on("click", function() {
                                    console.log('.letterDeleteLink on click');
                                    
                                    var letterId = $(this).attr("data-letterid");
                                    console.log('letterId: ' + letterId);
                                    
                                    $(this).parent().remove();
                                    
                                    var $hiddenInput = $('input[name="letters"][value="' + letterId + '"]');
                                    $hiddenInput.remove();
                                });
                            });
                        </script>
                    </span>"

                    <select id="letters" class="browser-default" style="font-size: 2rem; margin: 0.5rem 0; height: auto;">
                        <option value="">-- <fmt:message key='select' /> --</option>
                        <c:forEach var="letter" items="${letters}">
                            <option value="${letter.id}"><c:out value="${letter.text}" /></option>
                        </c:forEach>
                    </select>
                    <script>
                        $(function() {
                            $('#letters').on("change", function() {
                                console.log('#letters on change');
                                
                                var letterId = $(this).val();
                                console.log('letterId: ' + letterId);
                                var letterText = $(this).find('option[value="' + letterId + '"]').text();
                                console.log('letterText: ' + letterText);
                                if (letterId != "") {
                                    $('#lettersContainer').append('<input name="letters" type="hidden" value="' + letterId + '" />');
                                    $('#lettersContainer').append('<div class="chip" style="font-size: 2rem; padding: 1rem; height: auto;">' + letterText + '</div>');
                                    $(this).val("");
                                }
                            });
                        });
                    </script>
                    
                    <a href="<spring:url value='/content/letter/create' />" target="_blank"><fmt:message key="add.letter" /> <i class="material-icons">launch</i></a>
                </div>
            </div>
            
            <div class="row">
                <div class="col s12">
                    <label><fmt:message key="sounds" /></label><br />
                    /<span id="allophonesContainer">
                        <c:forEach var="sound" items="${letterSoundCorrespondence.allophones}">
                            <input name="allophones" type="hidden" value="${sound.id}" />
                            <div class="chip" data-allophoneid="${sound.id}" data-allophonevalue="${sound.valueIpa}"
                                 style="font-size: 2rem; padding: 1rem; height: auto;">
                                ${sound.valueIpa} 
                                <a href="#" class="allophoneDeleteLink" data-allophoneid="${sound.id}">
                                    <i class="close material-icons">clear</i>
                                </a>
                            </div>
                        </c:forEach>
                        <script>
                            $(function() {
                                $('.allophoneDeleteLink').on("click", function() {
                                    console.log('.allophoneDeleteLink on click');
                                    
                                    var allophoneId = $(this).attr("data-allophoneid");
                                    console.log('allophoneId: ' + allophoneId);
                                    
                                    $(this).parent().remove();
                                    
                                    var $hiddenInput = $('input[name="allophones"][value="' + allophoneId + '"]');
                                    $hiddenInput.remove();
                                });
                            });
                        </script>
                    </span>/

                    <select id="allophones" class="browser-default" style="font-size: 2rem; margin: 0.5rem 0; height: auto;">
                        <option value="">-- <fmt:message key='select' /> --</option>
                        <c:forEach var="sound" items="${allophones}">
                            <option value="${sound.id}"><c:out value="${sound.valueIpa}" /></option>
                        </c:forEach>
                    </select>
                    <script>
                        $(function() {
                            $('#allophones').on("change", function() {
                                console.log('#allophones on change');
                                
                                var allophoneId = $(this).val();
                                console.log('allophoneId: ' + allophoneId);
                                var allophoneValueIpa = $(this).find('option[value="' + allophoneId + '"]').text();
                                console.log('allophoneValueIpa: ' + allophoneValueIpa);
                                if (allophoneId != "") {
                                    $('#allophonesContainer').append('<input name="allophones" type="hidden" value="' + allophoneId + '" />');
                                    $('#allophonesContainer').append('<div class="chip" style="font-size: 2rem; padding: 1rem; height: auto;">' + allophoneValueIpa + '</div>');
                                    $(this).val("");
                                }
                            });
                        });
                    </script>
                    
                    <a href="<spring:url value='/content/sound/create' />" target="_blank"><fmt:message key="add.sound" /> <i class="material-icons">launch</i></a>
                </div>
            </div>
            
            <div class="row">
                <div class="input-field col s12">
                    <label for="contributionComment"><fmt:message key='comment' /></label>
                    <textarea id="contributionComment" name="contributionComment" class="materialize-textarea" placeholder="A comment describing your contribution." maxlength="1000"><c:if test="${not empty param.contributionComment}"><c:out value="${param.contributionComment}" /></c:if></textarea>
                </div>
            </div>

            <button id="submitButton" class="btn waves-effect waves-light" type="submit">
                <fmt:message key="edit" /> <i class="material-icons right">send</i>
            </button>
        </form:form>
    </div>
    
    <div class="divider" style="margin: 2em 0;"></div>

    <a name="contribution-events"></a>
    <h5><fmt:message key="contributions" /> 👩🏽‍💻</h5>
    <div id="contributionEvents" class="collection">
        <c:forEach var="letterSoundCorrespondenceContributionEvent" items="${letterSoundCorrespondenceContributionEvents}">
            <a name="contribution-event_${letterSoundCorrespondenceContributionEvent.id}"></a>
            <div class="collection-item">
                <span class="badge">
                    <fmt:message key="revision" /> #${letterSoundCorrespondenceContributionEvent.revisionNumber} 
                    (<fmt:formatNumber maxFractionDigits="0" value="${letterSoundCorrespondenceContributionEvent.timeSpentMs / 1000 / 60}" /> min). 
                    <fmt:formatDate value="${letterSoundCorrespondenceContributionEvent.time.time}" pattern="yyyy-MM-dd HH:mm" />
                </span>
                <a href="<spring:url value='/content/contributor/${letterSoundCorrespondenceContributionEvent.contributor.id}' />">
                    <div class="chip">
                        <c:choose>
                            <c:when test="${not empty letterSoundCorrespondenceContributionEvent.contributor.imageUrl}">
                                <img src="${letterSoundCorrespondenceContributionEvent.contributor.imageUrl}" />
                            </c:when>
                            <c:when test="${not empty letterSoundCorrespondenceContributionEvent.contributor.providerIdWeb3}">
                                <img src="http://62.75.236.14:3000/identicon/<c:out value="${letterSoundCorrespondenceContributionEvent.contributor.providerIdWeb3}" />" />
                            </c:when>
                            <c:otherwise>
                                <img src="<spring:url value='/static/img/placeholder.png' />" />
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${not empty letterSoundCorrespondenceContributionEvent.contributor.firstName}">
                                <c:out value="${letterSoundCorrespondenceContributionEvent.contributor.firstName}" />&nbsp;<c:out value="${letterSoundCorrespondenceContributionEvent.contributor.lastName}" />
                            </c:when>
                            <c:when test="${not empty letterSoundCorrespondenceContributionEvent.contributor.providerIdWeb3}">
                                ${fn:substring(letterSoundCorrespondenceContributionEvent.contributor.providerIdWeb3, 0, 6)}...${fn:substring(letterSoundCorrespondenceContributionEvent.contributor.providerIdWeb3, 38, 42)}
                            </c:when>
                        </c:choose>
                    </div>
                </a>
                <c:if test="${not empty letterSoundCorrespondenceContributionEvent.comment}">
                    <blockquote><c:out value="${letterSoundCorrespondenceContributionEvent.comment}" /></blockquote>
                </c:if>
            </div>
        </c:forEach>
    </div>
</content:section>

<content:aside>
    <h5 class="center"><fmt:message key="resources" /></h5>
    <div class="card-panel deep-purple lighten-5">
        <c:if test="${applicationScope.configProperties['content.language'] == 'HIN'}">
            Hindi resources:
            <ol style="list-style-type: inherit;">
                <li>
                    <a href="https://en.wikipedia.org/wiki/Help:IPA/Hindi_and_Urdu" target="_blank">IPA for Hindi and Urdu</a>
                </li>
                <li>
                    <a href="https://en.wikipedia.org/wiki/Hindustani_phonology" target="_blank">Hindustani phonology</a>
                </li>
                <li>
                    <a href="https://omniglot.com/writing/hindi.htm#alphabet" target="_blank">Devanāgarī alphabet for Hindi</a>
                </li>
            </ol>
        </c:if>
        
        General resources:
        <ol style="list-style-type: inherit;">
            <li>
                <a href="https://github.com/elimu-ai/wiki/blob/master/LOCALIZATION.md" target="_blank">elimu.ai Wiki</a>
            </li>
            <li>
                <a href="https://docs.google.com/document/d/e/2PACX-1vSZ7fc_Rcz24PGYaaRiy3_UUj_XZGl_jWs931RiGkcI2ft4DrN9PMb28jbndzisWccg3h5W_ynyxVU5/pub#h.835fthbx76vy" target="_blank">Creating Localizable Learning Apps</a>
            </li>
            <li>
                <a href="https://en.wikipedia.org/wiki/International_Phonetic_Alphabet">International Phonetic Alphabet (IPA)</a>
            </li>
        </ol>
    </div>
    
    <div class="divider" style="margin: 1.5em 0;"></div>
    
    <h5 class="center"><fmt:message key="usages" /></h5>
    
    <table class="bordered highlight">
        <thead>
            <th><fmt:message key="word" /></th>
            <th><fmt:message key="frequency" /></th>
        </thead>
        <tbody>
            <c:forEach var="word" items="${words}">
                <%-- Check if the current letter-sound correspondence is used by the word. --%>
                <c:set var="isUsedByWord" value="false" />
                <c:forEach var="lsc" items="${word.letterSoundCorrespondences}">
                    <c:if test="${lsc.id == letterSoundCorrespondence.id}">
                        <c:set var="isUsedByWord" value="true" />
                    </c:if>
                </c:forEach>
                <c:if test="${isUsedByWord}">
                    <tr>
                        <td>
                            <a href="<spring:url value='/content/word/edit/${word.id}' />">
                                "<c:out value="${word.text}" />"
                            </a><br />
                            <span class="grey-text">
                                /<c:forEach var="lsc" items="${word.letterSoundCorrespondences}">&nbsp;<a href="<spring:url value='/content/letter-sound-correspondence/edit/${lsc.id}' />"><c:if test="${lsc.id == letterSoundCorrespondence.id}"><span class='diff-addition'></c:if><c:forEach var="sound" items="${lsc.allophones}">${sound.valueIpa}</c:forEach><c:if test="${lsc.id == letterSoundCorrespondence.id}"></span></c:if></a>&nbsp;</c:forEach>/
                            </span>
                        </td>
                        <td>${word.usageCount}</td>
                    </tr>
                </c:if>
            </c:forEach>
        </tbody>
    </table>
</content:aside>
