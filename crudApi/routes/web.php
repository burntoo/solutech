<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});


$router->group(['prefix' => 'api'], function () use ($router) {

    //user login
    $router->post('login', ['uses' => 'AuthController@login']);
    //user Registration
    $router->post('register', ['uses' => 'AuthController@register']);
    //add task
    $router->post('addTask', ['uses' => 'AuthController@addTask']);
    //assign task
    $router->post('assignTask', ['uses' => 'AuthController@assignUserTask']);
    //update task status
    $router->post('updateTaskStatus', ['uses' => 'AuthController@updateUserTask']);
    //get all users
    $router->get('getAllUsers', ['uses' => 'AuthController@getAllUsers']);

});