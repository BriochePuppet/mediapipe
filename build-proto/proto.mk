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
PROTO_SOURCE_DIR := $(LOCAL_PATH)/..
PROTO_CPP_OUT_DIR := $(LOCAL_PATH)/../proto-cpp-out
PROTO_SYSTEM_INCLUDE_DIR := $(LOCAL_PATH)/../../protobuf/src
ifeq ($(OS),Windows_NT)
	ifeq (true, $(APP_DEBUG))
		PROTO_COMPILER_PATH := $(realpath $(APP_PROJECT_PATH)/../build-windows/bin/$(TARGET_ARCH_ABI)/Debug/protoc.exe)
	else
		PROTO_COMPILER_PATH := $(realpath $(APP_PROJECT_PATH)/../build-windows/bin/$(TARGET_ARCH_ABI)/Release/protoc.exe)
	endif
else
	ifeq (true, $(APP_DEBUG))
		PROTO_COMPILER_PATH := $(realpath $(APP_PROJECT_PATH)/../build-linux/bin/$(TARGET_ARCH_ABI)/Debug/protoc)
	else
		PROTO_COMPILER_PATH := $(realpath $(APP_PROJECT_PATH)/../build-linux/bin/$(TARGET_ARCH_ABI)/Release/protoc)
	endif
endif

all : \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/util/color.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/util/color.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.pb.cc \
	$(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.pb.h \
	$(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.pb.cc

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/core/flow_limiter_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/core/flow_limiter_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/core/gate_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/core/gate_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/core/get_vector_item_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/core/get_vector_item_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/core/split_vector_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/core/split_vector_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/image/image_clone_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/image/image_clone_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/image/warp_affine_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/image/warp_affine_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/internal/callback_packet_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/internal/callback_packet_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/inference_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/inference_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/association_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/association_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/landmark_projection_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/landmark_projection_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/rect_transformation_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/rect_transformation_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/thresholding_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/thresholding_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/visibility_copy_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/visibility_copy_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/deps/proto_descriptor.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/deps/proto_descriptor.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/annotation/locus.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/annotation/locus.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/annotation/rasterization.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/annotation/rasterization.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/object_detection/anchor.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/object_detection/anchor.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/body_rig.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/body_rig.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/classification.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/classification.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/detection.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/detection.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/image_format.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/image_format.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/landmark.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/landmark.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/location_data.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/location_data.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/matrix_data.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/matrix_data.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/rect.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/rect.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/formats/time_series_header.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/formats/time_series_header.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/tool/calculator_graph_template.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/tool/calculator_graph_template.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/tool/field_data.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/tool/field_data.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/calculator_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/calculator_options.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/graph_runtime_info.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/graph_runtime_info.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/mediapipe_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/mediapipe_options.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/packet_factory.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/packet_factory.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/packet_generator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/packet_generator.proto"	

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/status_handler.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/status_handler.proto"	

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/stream_handler.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/stream_handler.proto"	

$(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.d : $(PROTO_SOURCE_DIR)/mediapipe/framework/thread_pool_executor.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/framework)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/framework/thread_pool_executor.proto"	

$(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.d : $(PROTO_SOURCE_DIR)/mediapipe/gpu/gpu_origin.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/gpu)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/gpu/gpu_origin.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/acceleration.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/acceleration.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/base_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/base_options.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/external_file.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/external_file.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.proto"	

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.proto"	

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.proto"	

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.proto"	

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.d : $(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/util/color.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/util/color.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/util/color.d : $(PROTO_SOURCE_DIR)/mediapipe/util/color.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/util/color.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/util/color.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.d : $(PROTO_SOURCE_DIR)/mediapipe/util/label_map.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/util/label_map.proto"

$(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.pb.h $(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.pb.cc $(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.d : $(PROTO_SOURCE_DIR)/mediapipe/util/render_data.proto
	$(HIDE) $(call host-mkdir,$(PROTO_CPP_OUT_DIR)/mediapipe/util)
	$(HIDE) "$(PROTO_COMPILER_PATH)" "-I$(PROTO_SOURCE_DIR)" "-I$(PROTO_SYSTEM_INCLUDE_DIR)" "--dependency_out=$(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.d" "--cpp_out=$(PROTO_CPP_OUT_DIR)" "$(PROTO_SOURCE_DIR)/mediapipe/util/render_data.proto"

-include \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/util/color.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.d \
	$(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.d

clean:
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/clip_vector_size_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/concatenate_vector_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/constant_side_packet_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/flow_limiter_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/gate_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/get_vector_item_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/core/split_vector_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/image_clone_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/image/warp_affine_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/internal/callback_packet_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/image_to_tensor_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/inference_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_classification_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_detections_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_floats_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/tflite/ssd_anchors_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/association_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/collection_has_min_size_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/detections_to_rects_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmark_projection_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_refinement_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_smoothing_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/landmarks_to_detection_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/non_max_suppression_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/rect_transformation_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/thresholding_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_copy_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/calculators/util/visibility_smoothing_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/deps/proto_descriptor.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/locus.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/annotation/rasterization.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/object_detection/anchor.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/body_rig.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/classification.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/detection.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/image_format.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/landmark.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/location_data.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/matrix_data.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/rect.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/formats/time_series_header.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler/default_input_stream_handler.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/calculator_graph_template.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/field_data.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/tool/packet_generator_wrapper_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/calculator_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/graph_runtime_info.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/mediapipe_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_factory.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/packet_generator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/status_handler.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/stream_handler.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/framework/thread_pool_executor.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/gpu/gpu_origin.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/containers/proto/classifications.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/acceleration.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/base_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/external_file.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/inference_subgraph.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/core/proto/model_resources_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/environment.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/util/color.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/util/color.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/util/color.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/util/label_map.d)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.pb.h)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.pb.cc)
	$(HIDE) $(call host-rm,$(PROTO_CPP_OUT_DIR)/mediapipe/util/render_data.d)

.PHONY : \
	all \
	clean
