import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/login_bloc.dart';
import 'models/login_model.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(LoginState(
        loginModelObj: LoginModel(),
      ))
        ..add(LoginInitialEvent()),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgRectangle98,
                      height: 200.v,
                      width: 375.h,
                    ),
                    SizedBox(height: 50.v),
                    Text(
                      "lbl_welcome".tr,
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      "msg_login_to_your_account".tr,
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 22.v),
                    _buildColumnemail(context),
                    SizedBox(height: 5.v),
                    _buildColumnpassword(context),
                    SizedBox(height: 59.v),
                    CustomElevatedButton(
                      text: "lbl_login".tr,
                      margin: EdgeInsets.symmetric(horizontal: 40.h),
                      buttonTextStyle: CustomTextStyles.titleLargeWhiteA700,
                      onPressed: () {
                        onTapLogin(context);
                      },
                    ),
                    SizedBox(height: 14.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 53.h,
                        right: 49.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "msg_don_t_have_account".tr,
                            style:
                                CustomTextStyles.titleMediumSecondaryContainer,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 9.h),
                            child: Text(
                              "lbl_create_now".tr,
                              style: CustomTextStyles.titleMediumBluegray100,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 48.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 97.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgGoogleGLogo,
                            height: 30.v,
                            width: 31.h,
                          ),
                          Spacer(
                            flex: 50,
                          ),
                          CustomIconButton(
                            height: 30.v,
                            width: 31.h,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgFacebook1,
                            ),
                          ),
                          Spacer(
                            flex: 49,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgInstagram,
                            height: 30.v,
                            width: 32.h,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5.v)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnemail(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3.h),
            child: Text(
              "lbl_email".tr,
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 6.v),
          BlocSelector<LoginBloc, LoginState, TextEditingController?>(
            selector: (state) => state.emailController,
            builder: (context, emailController) {
              return CustomTextFormField(
                controller: emailController,
                hintText: "lbl_email".tr,
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      (!isValidEmail(value, isRequired: true))) {
                    return "err_msg_please_enter_valid_email".tr;
                  }
                  return null;
                },
              );
            },
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnpassword(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.h),
            child: Text(
              "lbl_password".tr,
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 4.v),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return CustomTextFormField(
                controller: state.passwordController,
                hintText: "lbl_password".tr,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                suffix: InkWell(
                  onTap: () {
                    context.read<LoginBloc>().add(ChangePasswordVisibilityEvent(
                        value: !state.isShowPassword));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.h, 12.v, 14.h, 12.v),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgGroup8,
                      height: 24.v,
                      width: 27.h,
                    ),
                  ),
                ),
                suffixConstraints: BoxConstraints(
                  maxHeight: 48.v,
                ),
                validator: (value) {
                  if (value == null ||
                      (!isValidPassword(value, isRequired: true))) {
                    return "err_msg_please_enter_valid_password".tr;
                  }
                  return null;
                },
                obscureText: state.isShowPassword,
                contentPadding: EdgeInsets.only(
                  left: 23.h,
                  top: 12.v,
                  bottom: 12.v,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  /// Navigates to the mainScreen when the action is triggered.
  onTapLogin(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.mainScreen,
    );
  }
}
