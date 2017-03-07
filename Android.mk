# Copyright (C) 2013 The Android Open Source Project
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
#

LOCAL_PATH := $(call my-dir)

# build for the host JVM
#-----------------------
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(call all-java-files-under, main/src/main/java)
LOCAL_MODULE := objenesis-host
LOCAL_MODULE_TAGS := optional
include $(BUILD_HOST_JAVA_LIBRARY)

# build for host dalvik
#-----------------------
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(call all-java-files-under, main/src/main/java)
LOCAL_MODULE := objenesis-hostdex
LOCAL_MODULE_TAGS := optional
include $(BUILD_HOST_DALVIK_JAVA_LIBRARY)

#-------------------------------
# build a target jar

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(call all-java-files-under, main/src/main/java)
# ideally this should be called just 'objenesis', but that name is
# already used by a prebuilt host lib.
LOCAL_MODULE := objenesis-target
#  SDK 10 needed for ObjectStreamClass lookupAny
LOCAL_SDK_VERSION := 10
LOCAL_MODULE_TAGS := optional
include $(BUILD_STATIC_JAVA_LIBRARY)

#--------------------------------
# Builds the Objenesis TCK as a device-targeted library

include $(CLEAR_VARS)
LOCAL_MODULE := objenesis-tck-target
LOCAL_MODULE_TAGS := tests

LOCAL_STATIC_JAVA_LIBRARIES := objenesis-target
LOCAL_SRC_FILES := $(call all-java-files-under, tck/src/main/java)
LOCAL_JAVA_RESOURCE_DIRS := tck/src/main/resources
include $(BUILD_STATIC_JAVA_LIBRARY)

include $(call all-makefiles-under, $(LOCAL_PATH))
