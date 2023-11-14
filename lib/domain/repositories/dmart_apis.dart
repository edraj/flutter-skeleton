import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dmart_android_flutter/configs/dio.dart';
import 'package:dmart_android_flutter/domain/models/base/api_response.dart';
import 'package:dmart_android_flutter/domain/models/base/error.dart';
import 'package:dmart_android_flutter/domain/models/base/get_payload_request.dart';
import 'package:dmart_android_flutter/domain/models/base/profile/profile_response.dart';
import 'package:dmart_android_flutter/domain/models/base/progress_ticket_request.dart';
import 'package:dmart_android_flutter/domain/models/base/query/query_request.dart';
import 'package:dmart_android_flutter/domain/models/base/query/query_response.dart';
import 'package:dmart_android_flutter/domain/models/base/request/action_reponse.dart';
import 'package:dmart_android_flutter/domain/models/base/request/action_request.dart';
import 'package:dmart_android_flutter/domain/models/base/response_entry.dart';
import 'package:dmart_android_flutter/domain/models/base/retrieve_entry_request.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/utils/enums/base/query_type.dart';
import 'package:dmart_android_flutter/utils/enums/base/sort_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';

class DmartAPIS {
  static final Map<String, dynamic> _headers = {
    "content-type": "application/json"
  };

  static ErrorModel _returnExceptionError(e) {
    if (e.response?.data['error'] != null) {
      return ErrorModel.fromJson(e.response?.data);
    }
    return ErrorModel(
      type: 'unknown',
      code: 0,
      info: [],
      message: e.message.toString(),
    );
  }

  static Future<(LoginResponseModel?, ErrorModel?)> login(
      LoginRequestModel loginRequestModel) async {
    try {
      final response = await dio.post(
        '/user/login',
        data: loginRequestModel.toJson(),
        options: Options(headers: _headers),
      );

      return (LoginResponseModel.fromJson(response.data), null);
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  static Future<(ApiResponse?, ErrorModel?)> logout() async {
    try {
      final response = await dio.post(
        '/user/logout',
        options: Options(headers: {
          ..._headers,
          "Authorization": "Bearer ${GetStorage().read("token")}"
        }),
      );

      return (ApiResponse.fromJson(response.data), null);
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  static Future<(ProfileResponse?, ErrorModel?)> getProfile() async {
    try {
      final response = await dio.get(
        '/user/profile',
        options: Options(headers: {
          ..._headers,
          "Authorization": "Bearer ${GetStorage().read("token")}"
        }),
      );

      final profileResponse = ProfileResponse.fromJson(response.data);
      if (profileResponse.status == Status.success &&
          profileResponse.records != null &&
          profileResponse.records!.isNotEmpty) {
        return (profileResponse, null);
      }

      return (
        null,
        ErrorModel(
            type: 'unknown',
            code: 0,
            info: [profileResponse.error?.toJson() ?? {}],
            message: "Unable to retrive the profile.")
      );
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  static Future<(ApiQueryResponse?, ErrorModel?)> managedQuery(
      QueryRequest query) async {
    try {
      query.sortType = query.sortType ?? SortyType.ascending;
      query.sortBy = query.sortBy ?? 'created_at';
      query.subpath = query.subpath.replaceAll(RegExp(r'/+'), '/');
      final response = await dio.post(
        '/managed/query',
        data: query.toJson(),
        options: Options(headers: {
          ..._headers,
          "Authorization": "Bearer ${GetStorage().read("token")}"
        }),
      );

      return (ApiQueryResponse.fromJson(response.data), null);
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  // static Future<(ApiQueryResponse?, ErrorModel?)> publicQuery(
  //     QueryRequest query) async {
  //   try {
  //     final response = await dio.post(
  //       '/public/entry/${query.resourceType?.name}/${query.spaceName}/${query.subpath}/${query.shortname}',
  //       data: query.toJson(),
  //       options: Options(headers: {
  //         ..._headers,
  //         "Authorization": "Bearer ${GetStorage().read("token")}"
  //       }),
  //     );
  //
  //     return (ApiQueryResponse.fromJson(response.data), null);
  //   } on DioException catch (e) {
  //     return (null, _returnExceptionError(e));
  //   }
  // }

  static Future<(ActionResponse?, ErrorModel?)> request(
      ActionRequest action) async {
    try {
      final response = await dio.post(
        '/managed/request',
        data: action.toJson(),
        options: Options(headers: {
          ..._headers,
          "Authorization": "Bearer ${GetStorage().read("token")}"
        }),
      );
      return (ActionResponse.fromJson(response.data), null);
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  static Future<(ResponseEntry?, ErrorModel?)> retrieveEntry(
      RetrieveEntryRequest request) async {
    String? subpath = request.subpath;
    try {
      if (subpath == null || subpath == "/") subpath = "__root__";
      final response = await dio.get(
          '/managed/entry/${request.resourceType.name}/${request.spaceName}/${request.subpath}/${request.shortname}?retrieve_json_payload=${request.retrieveJsonPayload}&retrieve_attachments=${request.retrieveAttachments}&validate_schema=${request.validateSchema}'
              .replaceAll(RegExp(r'/+'), '/'),
          options: Options(headers: {
            ..._headers,
            "Authorization": "Bearer ${GetStorage().read("token")}"
          }));

      return (ResponseEntry.fromJson(response.data), null);
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  Future<(ApiQueryResponse?, ErrorModel?)> getSpaces() async {
    return await managedQuery(QueryRequest(
      queryType: QueryType.spaces,
      spaceName: "management",
      subpath: "/",
      search: "",
      limit: 100,
    ));
  }

  Future<dynamic> getPayload(GetPayloadRequest request) async {
    try {
      final response = await dio.get(
        '/managed/payload/${request.resourceType}/${request.spaceName}/${request.subpath}/${request.shortname}${request.ext}',
        options: Options(headers: _headers),
      );

      return response.data;
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  Future<(ApiQueryResponse?, ErrorModel?)> progressTicket(
      ProgressTicketRequest request) async {
    try {
      final response = await dio.put(
        '/managed/progress-ticket/${request.spaceName}/${request.subpath}/${request.shortname}/${request.action}',
        data: {
          'resolution': request.resolution,
          'comment': request.comment,
        },
        options: Options(headers: _headers),
      );

      return (ApiQueryResponse.fromJson(response.data), null);
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  static Future<(Response?, ErrorModel?)> createAttachment({
    required String shortname,
    required String entitySubpath,
    required File payloadFile,
    required String spaceName,
    bool isActive = true,
    String resourceType = "media",
  }) async {
    Map<String, dynamic> payloadData = {
      'resource_type': resourceType,
      'shortname': shortname,
      'subpath': entitySubpath,
      'attributes': {
        'is_active': isActive,
      },
    };

    // Create a payload.json file with the payload data
    var payloadJson = json.encode(payloadData);

    FormData formData = FormData();

    String extension = 'tmp';
    try {
      extension = payloadFile.path.split('.').last;
    } catch (e) {
      // Handle exception if any
    }

    // Add files to form data
    formData.files.add(MapEntry(
      'payload_file',
      await MultipartFile.fromFile(payloadFile.path,
          filename: 'file.$extension'),
    ));

    formData.files.add(MapEntry(
      'request_record',
      MultipartFile.fromBytes(
        utf8.encode(payloadJson),
        filename: 'payload.json',
        contentType: MediaType('text', 'plain'),
      ),
    ));

    formData.fields
      ..add(MapEntry('space_name', spaceName))
      ..add(MapEntry('entity_subpath', entitySubpath))
      ..add(MapEntry('entity_shortname', shortname));
    try {
      Response response = await dio.post(
        '/managed/resource_with_payload',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            ..._headers,
            "Authorization": "Bearer ${GetStorage().read("token")}"
          },
        ),
      );

      return (response, null);
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  static Future<(ActionResponse?, ErrorModel?)> submit(
      String spaceName,
      String schemaShortname,
      String subpath,
      Map<String, dynamic> record) async {
    try {
      final response = await dio.post(
        '/public/submit/$spaceName/$schemaShortname/$subpath',
        data: record,
        options: Options(headers: {
          ..._headers,
          "Authorization": "Bearer ${GetStorage().read("token")}"
        }),
      );
      return (ActionResponse.fromJson(response.data), null);
    } on DioException catch (e) {
      return (null, _returnExceptionError(e));
    }
  }

  static String getAttachmentUrl(String resourceType, String spaceName,
      String subpath, String parentShortname, String shortname, String ext) {
    return '$BASE_URL/managed/payload/$resourceType/$spaceName/${subpath.replaceAll(RegExp(r'/+$'), '')}/$parentShortname/$shortname.$ext'
        .replaceAll('..', '.');
  }
}
