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

# https://developer.android.com/ndk/guides/android_mk

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := mediapipe

LOCAL_SRC_FILES := \
 	$(LOCAL_PATH)/../../stb/stb_image.c \
 	$(LOCAL_PATH)/../../stb/stb_image_write.c \
 	$(LOCAL_PATH)/../../zlib/adler32.c \
 	$(LOCAL_PATH)/../../zlib/contrib/minizip/ioapi.c \
 	$(LOCAL_PATH)/../../zlib/contrib/minizip/unzip.c \
 	$(LOCAL_PATH)/../../zlib/crc32.c \
 	$(LOCAL_PATH)/../../zlib/inffast.c \
 	$(LOCAL_PATH)/../../zlib/inflate.c \
 	$(LOCAL_PATH)/../../zlib/inftrees.c \
 	$(LOCAL_PATH)/../../zlib/zutil.c \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/begin_loop_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/clip_vector_size_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/concatenate_vector_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/constant_side_packet_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/end_loop_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/gate_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/get_vector_item_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/pass_through_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/previous_loopback_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/side_packet_to_stream_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/split_proto_list_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/core/split_vector_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/image/image_clone_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/image/image_properties_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/image_to_tensor_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/image_to_tensor_converter_opencv.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/image_to_tensor_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/inference_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/inference_calculator_cpu.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/inference_calculator_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/inference_calculator_xnnpack.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/inference_feedback_manager.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/inference_interpreter_delegate_runner.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/inference_io_mapper.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/internal_tflite.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/landmarks_to_tensor_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/tensors_to_classification_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/tensors_to_detections_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/tensors_to_floats_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/tensors_to_landmarks_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tensor/tensor_span.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/tflite/ssd_anchors_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/alignment_points_to_rects_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/association_norm_rect_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/collection_has_min_size_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/detections_to_rects_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/detection_label_id_to_text_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/detection_letterbox_removal_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/detection_projection_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/detection_transformation_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/landmarks_smoothing_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/landmarks_smoothing_calculator_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/landmarks_to_detection_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/landmark_letterbox_removal_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/landmark_projection_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/non_max_suppression_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/rect_transformation_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/thresholding_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/visibility_copy_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/visibility_smoothing_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/calculators/util/world_landmark_projection_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/api2/node.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/api2/packet.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/api2/stream/smoothing.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/calculator_base.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/calculator_context.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/calculator_context_manager.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/calculator_contract.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/calculator_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/calculator_node.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/calculator_state.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/collection_item_id.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/counter_factory.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/delegating_executor.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/clock.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/file_helpers.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/file_path.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/mlock_helpers.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/monotonic_clock.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/platform_strings.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/registration.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/registration_token.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/ret_check.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/status.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/status_builder.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/threadpool_std_thread_impl.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/deps/topologicalsorter.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/executor.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/formats/image.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/formats/image_frame.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/formats/image_opencv.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/formats/location.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/formats/matrix.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/formats/tensor.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/formats/tensor_ahwb.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/formats/unique_fd.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/graph_output_stream.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/graph_service_manager.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/input_side_packet_handler.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/input_stream_handler.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/input_stream_manager.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/input_stream_shard.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/legacy_calculator_support.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/output_side_packet_impl.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/output_stream_handler.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/output_stream_manager.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/output_stream_shard.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/packet.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/packet_generator_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/packet_type.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/resources.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/scheduler.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/scheduler_queue.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/stream_handler/default_input_stream_handler.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/stream_handler/immediate_input_stream_handler.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/stream_handler/in_order_output_stream_handler.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/subgraph.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/thread_pool_executor.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/timestamp.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/fill_packet_set.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/graph_runtime_info_logger.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/graph_runtime_info_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/name_util.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/options_field_util.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/options_map.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/options_registry.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/options_syntax_util.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/options_util.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/proto_util_lite.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/sink.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/status_util.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/subgraph_expansion.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/tag_map.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/tag_map_helper.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/template_expander.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/tool/validate_name.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/validated_graph_config.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/vlog_overrides.cc \
 	$(LOCAL_PATH)/../mediapipe/framework/vlog_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/gpu/gpu_buffer.cc \
 	$(LOCAL_PATH)/../mediapipe/gpu/gpu_buffer_format.cc \
 	$(LOCAL_PATH)/../mediapipe/gpu/gpu_buffer_storage.cc \
 	$(LOCAL_PATH)/../mediapipe/gpu/gpu_buffer_storage_image_frame.cc \
 	$(LOCAL_PATH)/../mediapipe/modules/hand_landmark/calculators/hand_landmarks_to_rect_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/common.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/components/containers/category.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/components/containers/classification_result.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/components/containers/landmark.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/components/processors/image_preprocessing_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/base_options.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/external_file_handler.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/mediapipe_builtin_op_resolver.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/model_asset_bundle_resources.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/model_resources.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/model_resources_cache.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/model_resources_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/model_task_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/task_runner.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/core/utils.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/metadata/metadata_extractor.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/metadata/metadata_version_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/metadata/utils/zip_readonly_mem_file.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/metadata/utils/zip_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_detector/face_detector_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_geometry/face_geometry_from_landmarks_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_geometry/libs/geometry_pipeline.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_geometry/libs/mesh_3d_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_geometry/libs/procrustes_solver.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_geometry/libs/validation_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_landmarker/face_blendshapes_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_landmarker/face_landmarker.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_landmarker/face_landmarker_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_landmarker/face_landmarker_result.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_landmarker/face_landmarks_detector_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/face_landmarker/tensors_to_face_landmarks_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/hand_detector/hand_detector_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/hand_landmarker/calculators/hand_association_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/hand_landmarker/calculators/hand_landmarks_deduplication_calculator.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/hand_landmarker/hand_landmarker.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/hand_landmarker/hand_landmarker_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/hand_landmarker/hand_landmarker_result.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/hand_landmarker/hand_landmarks_detector_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/pose_detector/pose_detector_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/pose_landmarker/pose_landmarker.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/pose_landmarker/pose_landmarker_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/pose_landmarker/pose_landmarker_result.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/pose_landmarker/pose_landmarks_detector_graph.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/utils/image_tensor_specs.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/utils/image_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/cc/vision/utils/landmarks_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/components/containers/category_converter.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/components/containers/landmark_converter.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/components/containers/matrix_converter.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/core/base_options_converter.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/vision/face_landmarker/face_landmarker.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/vision/face_landmarker/face_landmarker_result_converter.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/vision/hand_landmarker/hand_landmarker.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/vision/hand_landmarker/hand_landmarker_result_converter.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/vision/pose_landmarker/pose_landmarker.cc \
 	$(LOCAL_PATH)/../mediapipe/tasks/c/vision/pose_landmarker/pose_landmarker_result_converter.cc \
 	$(LOCAL_PATH)/../mediapipe/util/cpu_util.cc \
 	$(LOCAL_PATH)/../mediapipe/util/filtering/low_pass_filter.cc \
 	$(LOCAL_PATH)/../mediapipe/util/filtering/one_euro_filter.cc \
 	$(LOCAL_PATH)/../mediapipe/util/filtering/relative_velocity_filter.cc \
 	$(LOCAL_PATH)/../mediapipe/util/graph_builder_utils.cc \
 	$(LOCAL_PATH)/../mediapipe/util/header_util.cc \
 	$(LOCAL_PATH)/../mediapipe/util/label_map_util.cc \
 	$(LOCAL_PATH)/../mediapipe/util/rectangle_util.cc \
 	$(LOCAL_PATH)/../mediapipe/util/resource_util.cc \
 	$(LOCAL_PATH)/../mediapipe/util/resource_util_default.cc \
 	$(LOCAL_PATH)/../mediapipe/util/str_util.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/error_reporter.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/operations/landmarks_to_transform_matrix.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/operations/max_pool_argmax.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/operations/max_unpooling.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/operations/transform_landmarks.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/operations/transform_tensor_bilinear.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/operations/transpose_conv_bias.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/tflite_model_loader.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/tflite_signature_reader.cc \
 	$(LOCAL_PATH)/../mediapipe/util/tflite/utils.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/core/clip_vector_size_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/core/concatenate_vector_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/core/constant_side_packet_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/core/flow_limiter_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/core/gate_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/core/get_vector_item_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/core/split_vector_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/image/image_clone_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/image/warp_affine_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/internal/callback_packet_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/tensor/image_to_tensor_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/tensor/inference_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/tensor/landmarks_to_tensor_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/tensor/tensors_to_classification_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/tensor/tensors_to_detections_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/tensor/tensors_to_floats_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/tensor/tensors_to_landmarks_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/tensor/tensors_to_segmentation_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/tflite/ssd_anchors_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/association_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/collection_has_min_size_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/detections_to_rects_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/detection_label_id_to_text_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/landmarks_refinement_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/landmarks_smoothing_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/landmarks_to_detection_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/landmark_projection_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/non_max_suppression_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/rect_transformation_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/refine_landmarks_from_heatmap_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/thresholding_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/visibility_copy_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/calculators/util/visibility_smoothing_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/calculator_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/deps/proto_descriptor.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/annotation/locus.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/annotation/rasterization.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/body_rig.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/classification.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/detection.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/image_format.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/landmark.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/location_data.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/matrix_data.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/object_detection/anchor.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/rect.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/formats/time_series_header.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/graph_runtime_info.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/mediapipe_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/packet_factory.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/packet_generator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/status_handler.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/stream_handler.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/stream_handler/default_input_stream_handler.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/thread_pool_executor.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/tool/calculator_graph_template.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/tool/field_data.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/framework/tool/packet_generator_wrapper_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/gpu/gpu_origin.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/components/containers/proto/classifications.pb.cc \
	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/components/processors/proto/classifier_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/components/processors/proto/image_preprocessing_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/core/proto/acceleration.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/core/proto/base_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/core/proto/external_file.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/core/proto/inference_subgraph.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/core/proto/model_resources_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_detector/proto/face_detector_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_geometry/calculators/env_generator_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_geometry/calculators/geometry_pipeline_calculator.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_geometry/proto/environment.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_geometry/proto/face_geometry_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_geometry/proto/geometry_pipeline_metadata.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_geometry/proto/mesh_3d.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_landmarker/proto/face_blendshapes_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarker_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_landmarker/proto/face_landmarks_detector_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/face_landmarker/proto/tensors_to_face_landmarks_graph_options.pb.cc \
	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/hand_detector/proto/hand_detector_graph_options.pb.cc \
	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/hand_landmarker/calculators/hand_association_calculator.pb.cc \
	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/hand_landmarker/proto/hand_landmarker_graph_options.pb.cc \
	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/hand_landmarker/proto/hand_landmarks_detector_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/pose_detector/proto/pose_detector_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarker_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/tasks/cc/vision/pose_landmarker/proto/pose_landmarks_detector_graph_options.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/util/color.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/util/label_map.pb.cc \
 	$(LOCAL_PATH)/../proto-cpp-out/mediapipe/util/render_data.pb.cc

LOCAL_CFLAGS :=

ifeq (armeabi-v7a,$(TARGET_ARCH_ABI))
LOCAL_ARM_MODE := arm
LOCAL_ARM_NEON := true
else ifeq (arm64-v8a,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS +=
else ifeq (x86,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS += -mf16c
LOCAL_CFLAGS += -mfma
LOCAL_CFLAGS += -mavx2
else ifeq (x86_64,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS += -mf16c
LOCAL_CFLAGS += -mfma
LOCAL_CFLAGS += -mavx2
else
LOCAL_CFLAGS +=
endif

LOCAL_CFLAGS += -Wall
LOCAL_CFLAGS += -Werror=return-type

LOCAL_CFLAGS += -DMP_EXPORT=
LOCAL_CFLAGS += -DMEDIAPIPE_DISABLE_GPU=1
LOCAL_CFLAGS += -DMEDIAPIPE_FORCE_CPU_INFERENCE=1
LOCAL_CFLAGS += -DCL_DELEGATE_NO_GL
LOCAL_CFLAGS += -DTFLITE_KERNEL_USE_XNNPACK
LOCAL_CFLAGS += -DTFLITE_MMAP_DISABLED
LOCAL_CFLAGS += -DTF_LITE_DISABLE_X86_NEON
LOCAL_CFLAGS += -DTFL_STATIC_LIBRARY_BUILD
LOCAL_CFLAGS += -DEIGEN_NEON_GEBP_NR=4
LOCAL_CFLAGS += -DEIGEN_MPL2_ONLY
LOCAL_CFLAGS += -DXNN_ENABLE_ARM_FP16_VECTOR=0
LOCAL_CFLAGS += -DXNN_ENABLE_ARM_FP16_SCALAR=0
LOCAL_CFLAGS += -DXNN_ENABLE_ARM_BF16=0
LOCAL_CFLAGS += -DXNN_ENABLE_ARM_DOTPROD=0
LOCAL_CFLAGS += -DXNN_ENABLE_ARM_I8MM=0
LOCAL_CFLAGS += -DXNN_ENABLE_RISCV_VECTOR=1
LOCAL_CFLAGS += -DXNN_ENABLE_AVXVNNI=1
LOCAL_CFLAGS += -DXNN_ENABLE_AVXVNNIINT8=1
LOCAL_CFLAGS += -DXNN_ENABLE_AVX256SKX=1
LOCAL_CFLAGS += -DXNN_ENABLE_AVX256VNNI=1
LOCAL_CFLAGS += -DXNN_ENABLE_AVX256VNNIGFNI=1
LOCAL_CFLAGS += -DXNN_ENABLE_AVX512VNNIGFNI=1
LOCAL_CFLAGS += -DXNN_ENABLE_AVX512AMX=1
LOCAL_CFLAGS += -DXNN_ENABLE_AVX512FP16=1
LOCAL_CFLAGS += -DXNN_ENABLE_VSX=1
LOCAL_CFLAGS += -DXNN_ENABLE_ASSEMBLY=1
LOCAL_CFLAGS += -DXNN_ENABLE_MEMOPT=1
LOCAL_CFLAGS += -DXNN_ENABLE_SPARSE=1
LOCAL_CFLAGS += -DXNN_ENABLE_GEMM_M_SPECIALIZATION=1
LOCAL_CFLAGS += -DXNN_ENABLE_DWCONV_MULTIPASS=0
LOCAL_CFLAGS += -DXNN_ENABLE_HVX=1
LOCAL_CFLAGS += -DXNN_ENABLE_KLEIDIAI=0
LOCAL_CFLAGS += -DXNN_ENABLE_CPUINFO=1
LOCAL_CFLAGS += -DXNN_LOG_LEVEL=4
LOCAL_CFLAGS += -DFXDIV_USE_INLINE_ASSEMBLY=0
LOCAL_CFLAGS += -DPTHREADPOOL_NO_DEPRECATED_API=1
LOCAL_CFLAGS += -DCPUINFO_SUPPORTED_PLATFORM=1
LOCAL_CFLAGS += -DCPUINFO_LOG_TO_STDIO=1
LOCAL_CFLAGS += -DCPUINFO_LOG_LEVEL=2
LOCAL_CFLAGS += -DGOOGLE_PROTOBUF_CMAKE_BUILD=1
LOCAL_CFLAGS += -DFLATBUFFERS_LOCALE_INDEPENDENT=1
LOCAL_CFLAGS += -DGLOG_USE_GLOG_EXPORT=1
LOCAL_CFLAGS += -DGLOG_USE_WINDOWS_PORT=1
LOCAL_CFLAGS += -DGLOG_NO_ABBREVIATED_SEVERITIES=1
LOCAL_CFLAGS += -DGLOG_NO_SYMBOLIZE_DETECTION=1
LOCAL_CFLAGS += -DZ_SOLO=1

LOCAL_C_INCLUDES :=
LOCAL_C_INCLUDES += $(LOCAL_PATH)/..
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../proto-cpp-out
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../flat-cpp-out
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../abseil-cpp
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../protobuf/src
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../flatbuffers/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../tensorflow
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../eigen
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../glog/src
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../stb
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../gemmlowp
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../FP16/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../zlib
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../OpenCV/modules/core/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../OpenCV/modules/imgproc/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../OpenCV/modules/videoio/include

LOCAL_CPPFLAGS := 
LOCAL_CPPFLAGS += -std=c++20

LOCAL_CPP_FEATURES := 
LOCAL_CPP_FEATURES += rtti

LOCAL_LDFLAGS :=
LOCAL_LDFLAGS += -Wl,--enable-new-dtags
LOCAL_LDFLAGS += -Wl,-rpath,\$$ORIGIN
LOCAL_LDFLAGS += -Wl,--version-script,$(LOCAL_PATH)/mediapipe.map

LOCAL_LDFLAGS += -ldl

LOCAL_STATIC_LIBRARIES :=
LOCAL_STATIC_LIBRARIES += tensorflow-lite
LOCAL_STATIC_LIBRARIES += protobuf
LOCAL_STATIC_LIBRARIES += flatbuffers
LOCAL_STATIC_LIBRARIES += abseil-cpp
LOCAL_STATIC_LIBRARIES += XNNPACK-BASELINE
LOCAL_STATIC_LIBRARIES += XNNPACK-DISPATCH
LOCAL_STATIC_LIBRARIES += glog
LOCAL_STATIC_LIBRARIES += OpenCV

include $(BUILD_SHARED_LIBRARY)
