<template>
    <form v-on:submit.prevent="upload">
        <label for="cloudname-input">Cloud name </label>
        <input id="cloudname-input" v-model="cloudName" placeholder="Enter cloud_name from dashboard"/>
        <label for="preset-input">Cloud name </label>
        <input id="preset-input" v-model="preset" placeholder="Enter preset from upload settings"/>
        <label for="file-input">Upload </label>
        <input id="file-input" type="file" accept="image/png, image/jpeg" @change="handleFileChange($event)">
    <button type="submit">Upload </button>
    <section v-if="result && result.secure_url">
        <img :src="result.secure_url" :alt="result.public_id" />
    </section>
    <!-- <section>
        <ul v-if="errors.length > 0">
        <li v-for="(error,index) in errors" :key="index">{{error}}</li>
        </ul>
    </section> -->
    </form>
</template>
<script>
import axios from "axios";
// import Vue from 'vue'
// import VueProgressBar from 'vue-progressbar';
// const options = {
//     color: '#bffaf3',
//     failedColor: '#874b4b',
//     thickness: '5px',
//     transition: {
//         speed: '0.2s',
//         opacity: '0.6s',
//         termination: 300
//     },
//     autoRevert: true,
//     location: 'left',
//     inverse: false
// }
// Vue.use(VueProgressBar, options)
export default{

    methods: {
    // function to handle file info obtained from local
    // file system and set the file state
    handleFileChange: function(event) {
        console.log("handlefilechange", event.target.files);
      //returns an array of files even though multiple not used
        this.file = event.target.files[0];
        this.filesSelected = event.target.files.length;
    },
    prepareFormData: function() {
        this.formData = new FormData();
        this.formData.append("upload_preset", this.preset);
        this.formData.append("tags", this.tags); // Optional - add tag for image admin in Cloudinary
        this.formData.append("file", this.fileContents);
        },
    // function to handle form submit
    upload: function() {
      //no need to look at selected files if there is no cloudname or preset
        if (this.preset.length < 1 || this.cloudName.length < 1) {
            this.errors.push("You must enter a cloud name and preset to upload");
            return;
        }
        // clear errors
        else {
            this.errors = [];
        }
        console.log("upload", this.file.name);
        let reader = new FileReader();
        // attach listener to be called when data from file
        reader.addEventListener(
            "load",
            function() {
            this.fileContents = reader.result;
            this.prepareFormData();
            let cloudinaryUploadURL = `https://api.cloudinary.com/v1_1/dcmca9cgi/upload`;
            let requestObj = {
                url: cloudinaryUploadURL,
                method: "POST",
                data: this.formData,
                onUploadProgress: function(progressEvent) {
                console.log("progress", progressEvent);
                this.progress = Math.round(
                    (progressEvent.loaded * 100.0) / progressEvent.total
                );
                console.log(this.progress);
                //bind "this" to access vue state during callback
                }.bind(this)
            };
            //show progress bar at beginning of post
            this.showProgress = true;
            axios(requestObj)
                .then(response => {
                this.results = response.data;
                console.log(this.results);
                console.log("public_id", this.results.public_id);
                })
                .catch(error => {
                this.errors.push(error);
                console.log(this.error);
                })
                .finally(() => {
                setTimeout(
                    function() {
                    this.showProgress = false;
                    }.bind(this),
                    1000
                );
                });
            }.bind(this),
            false
        );
        // call for file read if there is a file
        if (this.file && this.file.name) {
            reader.readAsDataURL(this.file);
        }
        }
    }
};
    
</script>