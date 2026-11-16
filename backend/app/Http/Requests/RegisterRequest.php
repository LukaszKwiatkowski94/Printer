<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RegisterRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:8|confirmed',
        ];
    }

    /**
     * Get custom messages for validator errors.
     */
    public function messages(): array
    {
        return [
            'name.required' => 'Nazwa jest wymagana',
            'email.required' => 'Email jest wymagany',
            'email.email' => 'Email musi być prawidłowy',
            'email.unique' => 'Ten email już istnieje w systemie',
            'password.required' => 'Hasło jest wymagane',
            'password.min' => 'Hasło musi mieć co najmniej 8 znaków',
            'password.confirmed' => 'Potwierdzenie hasła nie zgadza się',
        ];
    }
}
