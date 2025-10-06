//
// Copyright (C) YuqiaoZhang(HanetakaChou)
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published
// by the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

#if defined(__GNUC__)
#include <stdlib.h>
#elif defined(_MSC_VER)
#define NOMINMAX 1
#define WIN32_LEAN_AND_MEAN 1
#include <sdkddkver.h>
#include <Windows.h>
#else
#error Unknown Compiler
#endif

extern bool internal_tflite_get_env_force_gpu()
{
    bool force_gpu;
    {
#if defined(__GNUC__)

#if defined(__linux__)
        char *env_val = secure_getenv("TFLITE_FORCE_GPU");
        force_gpu = ((NULL != env_val) && ('1' == env_val[0]) && ('\0' == env_val[1]));
#elif defined(__MACH__)
        char *env_val = getenv("TFLITE_FORCE_GPU");
        force_gpu = ((NULL != env_val) && ('1' == env_val[0]) && ('\0' == env_val[1]));
#else
#error Unknown Platform
#endif

#elif defined(_MSC_VER)
        WCHAR environment_variable_buffer[2];
        DWORD size = GetEnvironmentVariableW(L"TFLITE_FORCE_GPU", environment_variable_buffer, 2U);
        force_gpu = ((1U == size || 2U == size) && L'1' == environment_variable_buffer[0]);
#else
#error Unknown Compiler
#endif
    }
    return force_gpu;
}
