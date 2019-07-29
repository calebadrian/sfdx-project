({
    onSearch: function(component, event, helper){
        helper.onSearch(component);
    },
    onFormSubmit: function(component, event, helper){
        this.search(component, event, helper)
    },
    doSearch: function(component, event, helper){
        helper.onSearch(component);
    }   
})