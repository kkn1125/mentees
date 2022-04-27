/**
 * 
 */

const editor = SUNEDITOR.create((document.getElementById('content') || 'content'),{
    // All of the plugins are loaded in the "window.SUNEDITOR" object in dist/suneditor.min.js file
    // Insert options
    // Language global object (default: en)
    buttonList: [
        ['undo', 'redo'],
        ['font', 'fontSize', 'formatBlock'],
        ['paragraphStyle', 'blockquote'],
        ['bold', 'underline', 'italic', 'strike', 'subscript', 'superscript'],
        ['fontColor', 'hiliteColor', 'textStyle'],
        ['removeFormat'],
        '/', // Line break
        ['outdent', 'indent'],
        ['align', 'horizontalRule', 'list', 'lineHeight'],
        ['table', 'link', 'image', 'video', 'audio' /** ,'math' */], // You must add the 'katex' library at options to use the 'math' plugin.
        /** ['imageGallery'] */ // You must add the "imageGalleryUrl".
        ['fullScreen', 'showBlocks', 'codeView'],
        ['preview', 'print'],
        ['save', 'template']
    ],
    lang: SUNEDITOR_LANG['ko'],
    placeholder: '내용을 완성한 후 저장을 꼭 하고 등록해주세요.',
    height: 450,
    width: '100%'
});
editor.onImageUpload = function (targetElement, index, state, info, remainingFilesCount, core) {
    console.log(`targetElement:${targetElement}, index:${index}, state('create', 'update', 'delete'):${state}`)
    console.log(`info:${info}, remainingFilesCount:${remainingFilesCount}`)
}