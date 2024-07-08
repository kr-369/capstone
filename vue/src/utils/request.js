import axios from 'axios'
import router from "@/router";

// Create a new axios subject
const request = axios.create({
    baseURL: process.env.VUE_APP_BASEURL,   //  ip:port
    timeout: 30000                          // 30s request time-out
})

// request prevent

request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8';
    let user = JSON.parse(localStorage.getItem("xm-user") || '{}')
    config.headers['token'] = user.token

    return config
}, error => {
    console.error('request error: ' + error)
    return Promise.reject(error)
});

// response prevent
request.interceptors.response.use(
    response => {
        let res = response.data;

        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        if (res.code === '401') {
            router.push('/login')
        }
        return res;
    },
    error => {
        console.error('response error: ' + error) // for debug
        return Promise.reject(error)
    }
)


export default request