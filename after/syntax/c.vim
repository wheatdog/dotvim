syn keyword	cCmtInfo	contained NOTE NOTE
syn keyword	cDebug		contained BUG DEBUG
syn cluster	cCommentGroup	contains=cTodo,cBadContinuation,cDebug,cCmtInfo
hi def link cDebug		Todo
hi def link cCmtInfo		PreCondit
