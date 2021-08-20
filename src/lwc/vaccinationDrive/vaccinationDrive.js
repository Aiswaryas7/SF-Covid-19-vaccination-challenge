/**
 * Created by Aiswarya.S on 8/19/2021.
 */
import { LightningElement ,api, wire, track} from 'lwc';
import getPeopleList from '@salesforce/apex/TS_covidVaccinationContactDrive.getPeopleList';
export default class CovidVaccinationContactDriveLwc extends LightningElement {
    @track columns = [{
                label: 'Name',
                fieldName: 'Name',
                type: 'text'
            },
            {
                label: 'Age',
                fieldName: 'Age__c',
                type: 'integer'
            },
            {
                label: 'Drive location',
                fieldName: 'Drive_Location__c',
                type: 'text'
            }
        ];

    @track error;
    @track conList ;
    @wire(getPeopleList)
    wiredPeople({
        error,
        data
    }) {
        if (data) {
        this.conList = data;
        console.log('test2',this.conList);
        } else if (error) {
        this.error = error;
    }
    }
}


/*

import { LightningElement ,api, wire, track} from 'lwc';
import getContactList from '@salesforce/apex/vaccinationDriveUsersList.getContactList';
export default class VaccinationDrive extends LightningElement {
    @track columns = [{
            label: 'Name',
            fieldName: 'Name',
            type: 'text'
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'phone'
        },
        {
            label: 'Email',
            fieldName: 'Email',
            type: 'Email'
        },
        {
            label: 'Age',
            fieldName: 'Age',
            type: 'Integer'
        }
    ];

    @track error;
    @track conList ;
    @wire(getContactList)
    wiredAccounts({
        error,
        data
    }) {
        if (data) {
            this.conList = JSON.parse(data).ContactWrap;
            console.log('test2',this.conList);
        } else if (error) {
            this.error = error;
        }
    }

}
*/