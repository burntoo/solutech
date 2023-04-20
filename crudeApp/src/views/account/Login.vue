<script setup>
import { Form, Field } from 'vee-validate';
import * as Yup from 'yup';

import axios from 'axios';

import { useAuthStore, useAlertStore } from '@/stores';

const schema = Yup.object().shape({
    username: Yup.string().required('Username is required'),
    password: Yup.string().required('Password is required')
});

async function onSubmit(values) {
    const alertStore = useAlertStore();
    try {
        const response = await axios.post('http://localhost:8000/api/login', {
            email_address: values.username,
            password: values.password
        });

        if (response.status === 200) {
            alertStore.success(response.data.message);
            localStorage.setItem('crude', JSON.stringify(response.data));
            router.push('/');
        } else {
            alertStore.error(response.data.message);
        }
    } catch (error) {
        if (error.response.status === 400) {
            alertStore.error(error.response.data.message);
        } else {
            console.error(error.response.data.message);
        }
    }
}
</script>

<template>
    <div class="card m-3">
        <h4 class="card-header">Login</h4>
        <div class="card-body">
            <Form @submit="onSubmit" :validation-schema="schema" v-slot="{ errors, isSubmitting }">
                <div class="form-group">
                    <label>Username</label>
                    <Field name="username" type="text" class="form-control" :class="{ 'is-invalid': errors.username }" />
                    <div class="invalid-feedback">{{ errors.username }}</div>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <Field name="password" type="password" class="form-control" :class="{ 'is-invalid': errors.password }" />
                    <div class="invalid-feedback">{{ errors.password }}</div>
                </div>
                <div class="form-group">
                    <button class="btn btn-primary" :disabled="isSubmitting">
                        <span v-show="isSubmitting" class="spinner-border spinner-border-sm mr-1"></span>
                        Login
                    </button>
                    <router-link to="register" class="btn btn-link">Register</router-link>
                </div>
            </Form>
        </div>
    </div>
</template>
