import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    fullname = "Balakrishna";
    age = 30;
    location = {
        city: "Houston",
        country: "United States"
    };
}