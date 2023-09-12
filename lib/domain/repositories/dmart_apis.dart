import 'package:dio/dio.dart';
import 'package:dmart_android_flutter/configs/dio.dart';
import 'package:dmart_android_flutter/domain/models/base/action_reponse.dart';
import 'package:dmart_android_flutter/domain/models/base/action_request.dart';
import 'package:dmart_android_flutter/domain/models/base/api_response.dart';
import 'package:dmart_android_flutter/domain/models/base/get_payload_request.dart';
import 'package:dmart_android_flutter/domain/models/base/profile_response.dart';
import 'package:dmart_android_flutter/domain/models/base/progress_ticket_request.dart';
import 'package:dmart_android_flutter/domain/models/base/query_request.dart';
import 'package:dmart_android_flutter/domain/models/base/query_response.dart';
import 'package:dmart_android_flutter/domain/models/base/response_entry.dart';
import 'package:dmart_android_flutter/domain/models/base/retrieve_entry_request.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/utils/enums/base/query_type.dart';
import 'package:dmart_android_flutter/utils/enums/base/sort_type.dart';

class DmartAPIS {
  static Map<String, dynamic> _headers = {"content-type": "application/json"};

  static Future<LoginResponseModel> login(
      String shortname, String password) async {
    try {
      final response = await dio.post(
        '/user/login',
        data: {
          'shortname': shortname,
          'password': password,
        },
        options: Options(headers: _headers),
      );

      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response?.data);
      if (e.response?.data != null) {
        dynamic error = e.response?.data;
        return LoginResponseModel.fromJson(error);
      }
      return LoginResponseModel.fromJson({
        "status": "failed",
        "type": "UNKNOW",
        "code": 666,
        "message": "Unkonw error"
      });
    }
  }

  Future<ApiResponse> logout() async {
    try {
      final response = await dio.post(
        '/user/logout',
        options: Options(headers: _headers),
      );

      return ApiResponse.fromJson(response.data);
    } catch (e) {
      // Handle the error here
      throw e;
    }
  }

  Future<ProfileResponse?> getProfile() async {
    try {
      final response = await dio.get(
        '/user/profile',
        options: Options(headers: _headers),
      );

      final profileResponse = ProfileResponse.fromJson(response.data);
      if (profileResponse.status == Status.success &&
          profileResponse.records.isNotEmpty) {
        final permissions = profileResponse.records[0].attributes.permissions;
        // Store permissions in your preferred way (e.g., SharedPreferences)
        // localStorage.setItem("permissions", jsonEncode(permissions));
      }

      return profileResponse;
    } catch (e) {
      // Handle the error here
      // await signout();
      return null;
    }
  }

  Future<ApiQueryResponse> query(QueryRequest query) async {
    try {
      query.sortType = query.sortType ?? SortyType.ascending;
      query.sortBy = query.sortBy ?? 'created_at';
      query.subpath = query.subpath.replaceAll(RegExp(r'/+'), '/');
      final response = await dio.post(
        '/managed/query',
        data: query.toJson(),
        options: Options(headers: _headers),
      );

      return ApiQueryResponse.fromJson(response.data);
    } catch (e) {
      // Handle the error here
      throw e;
    }
  }

  Future<ActionResponse> request(ActionRequest action) async {
    try {
      final response = await dio.post(
        '/managed/request',
        data: action.toJson(),
        options: Options(headers: _headers),
      );

      return ActionResponse.fromJson(response.data);
    } catch (e) {
      // Handle the error here
      throw e;
    }
  }

  Future<ResponseEntry> retrieveEntry(RetrieveEntryRequest request) async {
    String? subpath = request.subpath;
    try {
      if (subpath == null || subpath == "/") subpath = "__root__";
      final response = await dio.get(
        '/managed/entry/${request.resourceType.toString()}/${request.spaceName}/${request.subpath}/${request.shortname}?retrieve_json_payload=${request.retrieveJsonPayload}&retrieve_attachments=${request.retrieveAttachments}&validate_schema=${request.validateSchema}'
            .replaceAll(RegExp(r'/+'), '/'),
        options: Options(headers: _headers),
      );

      return ResponseEntry.fromJson(response.data);
    } catch (e) {
      // Handle the error here
      throw e;
    }
  }

  Future<ApiResponse> getSpaces() async {
    return await query(QueryRequest(
      type: QueryType.spaces,
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
    } catch (e) {
      // Handle the error here
      throw e;
    }
  }

  Future<ApiQueryResponse> progressTicket(ProgressTicketRequest request) async {
    try {
      final response = await dio.put(
        '/managed/progress-ticket/${request.spaceName}/${request.subpath}/${request.shortname}/${request.action}',
        data: {
          'resolution': request.resolution,
          'comment': request.comment,
        },
        options: Options(headers: _headers),
      );

      return ApiQueryResponse.fromJson(response.data);
    } catch (e) {
      // Handle the error here
      throw e;
    }
  }
}
