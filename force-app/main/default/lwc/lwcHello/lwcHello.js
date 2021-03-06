/* eslint-disable no-alert */
import { LightningElement, track } from 'lwc';

export default class LwcHello extends LightningElement {
    @track greeting = 'world';
    count() {
        alert(this.greeting.length + " letters");
    }
    handleChange(event){
        this.greeting = event.target.value;
    }
}