<?php

namespace App\Http\Controllers;
use App\Models\User;

use Illuminate\Validation\ValidationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class AuthController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }

    public function login(Request $req){
        $this->validate($req, [
            'email_address' => 'required|email',
            'password' => 'required'
        ]);

        $params = array(
            $req->input('email')
        );

        $params = $req->only(['email_address', 'password']);

        if (! $token = Auth::attempt($params)) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'user' => auth()->user(),
            'expires_in' => auth()->factory()->getTTL() * 60 * 24,
            'message' => "Success"
        ]);
    }

    public function register(Request $req)
    {

        $this->validate($req, [
            'email_address' => 'required|email',
            'password' => 'required'
        ]);

        $passHash = password_hash($req->input('password'), PASSWORD_DEFAULT);

        $params = array(
            $req->input('email_address'),
            $passHash
        );

        try {
            $array = json_decode(json_encode(DB::select('CALL userRegistration(?, ?)', $params)), true);

            if ($array[0]['code'] == 400) {
                throw new \ErrorException($array[0]['message']);
            }

            return response()->json(['state' => 'success', 'data' => $array]);
        } catch (\ErrorException$e) {
            return response()->json(['state' => 'error', 'message' => $e->getMessage()], 400);
        }

    }

    public function addTask(Request $req){
        $this->validate($req, [
            'name' => 'required',
            'description' => 'required',
            'dateDue' => 'required',
            'statusId' => 'required'
        ]);

        $params = array(
            $req->input('name'),
            $req->input('description'),
            $req->input('dateDue'),
            $req->input('statusId')
        );

        try {
            $array = json_decode(json_encode(DB::select('CALL addTask(?, ?, ?, ?)', $params)), true);

            // if(isset($array[0]['code'] == 400){
            //     throw new \ErrorException($array[0]['message']);
            // }
            
            return response()->json(['status' => 'success', 'data' => $array]);
        } catch (\ErrorException $e) {
            return response()->json(['status' => 'error', 'error' => $e->getMessage()],400);
        }
    }

    public function assignUserTask(Request $req){
        $this->validate($req, [
            'userId' => 'required',
            'taskId' => 'required',
            'dateDue' => 'required',
            'startTime' => 'required',
            'endTime' => 'required',
            'remarks' => 'required',
            'statusId' => 'required'
        ]);

        $params = array(
            $req->input('userId'),
            $req->input('taskId'),
            $req->input('dateDue'),
            $req->input('startTime'),
            $req->input('endTime'),
            $req->input('remarks'),
            $req->input('statusId')
        );

        try {
            $array = json_decode(json_encode(DB::select('CALL assignUserTask(?, ?, ?, ?, ?, ?, ?)', $params)), true);

            // if($array[0]['code'] == 400){
            //     throw new \ErrorException($array[0]['message']);
            // }
            
            return response()->json(['status' => 'success', 'data' => $array]);
        } catch (\ErrorException $e) {
            return response()->json(['status' => 'error', 'error' => $e->getMessage()],400);
        }
    }

    public function updateUserTask(Request $req){
        $this->validate($req, [
            'statusId' => 'required|email',
            'userId' => 'required',
            'taskId' => 'required'
        ]);

        $params = array(
            $req->input('statusId'),
            $req->input('userId'),
            $req->input('taskId')
        );

        try {
            $array = json_decode(json_encode(DB::select('CALL updateTask(?, ?, ?)', $params)), true);

            // if($array[0]['code'] == 400){
            //     throw new \ErrorException($array[0]['message']);
            // }
            
            return response()->json(['status' => 'success', 'data' => $array]);
        } catch (\ErrorException $e) {
            return response()->json(['status' => 'error', 'error' => $e->getMessage()],400);
        }
    }

    public function getAllUsers(Request $req){
    
        try {
            $array = json_decode(json_encode(DB::select('CALL getAllUsers()')), true);

            // if($array[0]['code'] == 400){
            //     throw new \ErrorException($array[0]['message']);
            // }
            
            return response()->json(['status' => 'success', 'data' => $array]);
        } catch (\ErrorException $e) {
            return response()->json(['status' => 'error', 'error' => $e->getMessage()],400);
        }
    }

}