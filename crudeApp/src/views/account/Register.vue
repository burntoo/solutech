<script setup>
import { Form, Field } from 'vee-validate';
import * as Yup from 'yup';
import axios from 'axios';

import { useUsersStore, useAlertStore } from '@/stores';
import { router } from '@/router';

const schema = Yup.object().shape({
    email: Yup.string()
        .required('Email adress is required'),
    password: Yup.string()
        .required('Password is required')
        .min(6, 'Password must be at least 6 characters'),
    confirmPassword: Yup.string()
        .required('Confirm Password is required')
        .min(6, 'Confirm Password must be at least 6 characters')
        .oneOf([Yup.ref('password'), null], 'Passwords do not match')
});

async function onSubmit(values) {
    const alertStore = useAlertStore();
    try {
        const response = await axios.post('http://localhost:8000/api/register', {
            email_address: values.email,
            password: values.password
        });

        if (response.status === 200) {
            alertStore.success(response.data.data[0]['message']);
            router.push('/login');
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
        <h4 class="card-header">Register</h4>
        <div class="card-body">
            <Form @submit="onSubmit" :validation-schema="schema" v-slot="{ errors, isSubmitting }">
                <div class="form-group">
                    <label>Email</label>
                    <Field name="email" type="email" class="form-control" :class="{ 'is-invalid': errors.email }" />
                    <div class="invalid-feedback">{{ errors.firstName }}</div>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <Field name="password" type="password" class="form-control"
                        :class="{ 'is-invalid': errors.password }" />
                    <div class="invalid-feedback">{{ errors.password }}</div>
                </div>
                <div class="form-group">
                    <label>Confirm Password</label>
                    <Field name="confirmPassword" type="password" class="form-control"
                        :class="{ 'is-invalid': errors.confirmPassword }" />
                    <div class="invalid-feedback">{{ errors.confirmPassword }}</div>
                </div>
                <div class="form-group">
                    <button class="btn btn-primary" :disabled="isSubmitting">
                        <span v-show="isSubmitting" class="spinner-border spinner-border-sm mr-1"></span>
                        Register
                    </button>
                    <router-link to="login" class="btn btn-link">Login</router-link>
                </div>
            </Form>
        </div>
    </div>
</template>
