# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# ====================================================================
#
# Host system auto-detection.
#
# ====================================================================
ifeq ($(OS),Windows_NT)
	# On all modern variants of Windows (including Cygwin and Wine)
	# the OS environment variable is defined to 'Windows_NT'
	#
	# The value of PROCESSOR_ARCHITECTURE will be x86 or AMD64
	#
	HOST_OS := windows

	# Trying to detect that we're running from Cygwin is tricky
	# because we can't use $(OSTYPE): It's a Bash shell variable
	# that is not exported to sub-processes, and isn't defined by
	# other shells (for those with really weird setups).
	#
	# Instead, we assume that a program named /bin/uname.exe
	# that can be invoked and returns a valid value corresponds
	# to a Cygwin installation.
	#
	UNAME := $(shell /bin/uname.exe -s 2>NUL)
	ifneq (,$(filter CYGWIN% MINGW32% MINGW64%,$(UNAME)))
		HOST_OS := unix
		_ := $(shell rm -f NUL) # Cleaning up
	endif
else
	HOST_OS := unix
endif

# -----------------------------------------------------------------------------
# Function : host-mkdir
# Arguments: 1: directory path
# Usage    : $(call host-mkdir,<path>
# Rationale: This function expands to the host-specific shell command used
#            to create a path if it doesn't exist.
# -----------------------------------------------------------------------------
ifeq ($(HOST_OS),windows)
host-mkdir = md $(subst /,\,"$1") >NUL 2>NUL || rem
else
host-mkdir = mkdir -p $1
endif

# -----------------------------------------------------------------------------
# Function : host-rm
# Arguments: 1: list of files
# Usage    : $(call host-rm,<files>)
# Rationale: This function expands to the host-specific shell command used
#            to remove some files.
# -----------------------------------------------------------------------------
ifeq ($(HOST_OS),windows)
host-rm = \
	$(eval __host_rm_files := $(foreach __host_rm_file,$1,$(subst /,\,$(wildcard $(__host_rm_file)))))\
	$(if $(__host_rm_files),del /f/q $(__host_rm_files) >NUL 2>NUL || rem)
else
host-rm = rm -f $1
endif

#
# Copyright (C) YuqiaoZhang(HanetakaChou)
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

HIDE := @

LOCAL_PATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
FLAT_SOURCE_DIR := $(LOCAL_PATH)/..
FLAT_CPP_OUT_DIR := $(LOCAL_PATH)/../flat-cpp-out
ifeq ($(OS),Windows_NT)
	ifeq (true, $(APP_DEBUG))
		FLAT_COMPILER_PATH := $(realpath $(APP_PROJECT_PATH)/../build-windows/bin/$(TARGET_ARCH_ABI)/Debug/flatc.exe)
	else
		FLAT_COMPILER_PATH := $(realpath $(APP_PROJECT_PATH)/../build-windows/bin/$(TARGET_ARCH_ABI)/Release/flatc.exe)
	endif
else
	ifeq (true, $(APP_DEBUG))
		FLAT_COMPILER_PATH := $(realpath $(APP_PROJECT_PATH)/../build-linux/bin/$(TARGET_ARCH_ABI)/Debug/flatc)
	else
		FLAT_COMPILER_PATH := $(realpath $(APP_PROJECT_PATH)/../build-linux/bin/$(TARGET_ARCH_ABI)/Release/flatc)
	endif
endif

all : \
	$(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata/metadata_schema_generated.h

$(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata/metadata_schema_generated.h $(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata/metadata_schema_generated.d : $(FLAT_SOURCE_DIR)/mediapipe/tasks/metadata/metadata_schema.fbs
	$(HIDE) $(call host-mkdir,$(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata)
	$(HIDE) "$(FLAT_COMPILER_PATH)" --cpp --no-union-value-namespacing --gen-object-api -I "$(FLAT_SOURCE_DIR)" -o "$(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata" -M "$(FLAT_SOURCE_DIR)/mediapipe/tasks/metadata/metadata_schema.fbs" > $(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata/metadata_schema_generated.d
	$(HIDE) "$(FLAT_COMPILER_PATH)" --cpp --no-union-value-namespacing --gen-object-api -I "$(FLAT_SOURCE_DIR)" -o "$(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata" "$(FLAT_SOURCE_DIR)/mediapipe/tasks/metadata/metadata_schema.fbs"
	
-include \
	$(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata/metadata_schema_generated.d

clean:
	$(HIDE) $(call host-rm,$(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata/metadata_schema_generated.h)
	$(HIDE) $(call host-rm,$(FLAT_CPP_OUT_DIR)/mediapipe/tasks/metadata/metadata_schema_generated.d)

.PHONY : \
	all \
	clean
