import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance_ui/controllers/home_controller.dart';
import 'package:flutter_finance_ui/models/debit_card.dart';
import 'package:flutter_finance_ui/models/transaction_model.dart';
import 'package:flutter_finance_ui/packages/lite_rolling_switch.dart';
import 'package:flutter_finance_ui/services/storage_helper.dart';
import 'package:flutter_finance_ui/utils/app_colors.dart';
import 'package:flutter_finance_ui/utils/app_const.dart';
import 'package:flutter_finance_ui/utils/app_img.dart';
import 'package:flutter_finance_ui/utils/app_strings.dart';
import 'package:flutter_finance_ui/utils/app_widgets.dart';
import 'package:get/get.dart';

class HomeScreenUI extends StatelessWidget {
  const HomeScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (HomeController controller) {
          return Scaffold(
            appBar: AppWidgets.commonAppBar(title: AppStrings.wallet, context: context, actions: [
              LiteRollingSwitch(
                width: 100,
                onDoubleTap: () {},
                onSwipe: () {},
                value: StorageHelper().isDarkMode,
                textOn: 'Dark Mode',
                textOff: 'Light Mode',
                // colorOn: AppColors.lightPrimary.withOpacity(0.2),
                iconOn: Icons.nightlight_round_rounded, iconOnColor: AppColors.blackColor,
                colorOn: AppColors.lightPrimary.withOpacity(0.2), iconOffColor: AppColors.blackColor,
                colorOff: AppColors.blackColor.withOpacity(0.2),
                iconOff: Icons.sunny,
                textSize: 9,
                onChanged: (bool state) {
                  StorageHelper().updateTheme(state);
                  Get.changeThemeMode(StorageHelper().isDarkMode ? ThemeMode.dark : ThemeMode.light);
                  controller.update();
                  print('Current State of SWITCH IS: $state');
                },
                onTap: () {},
              ),
            ]),
            backgroundColor: Theme.of(context).primaryColor,
            body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              cardSlider(controller),
              height20,
              balanceContainer(context),
              height20,
              commonTabbar(context),
              height20,
              transactionList(controller),
            ]),
          );
        });
  }

  Widget transactionList(HomeController controller) {
    return Expanded(
        child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.transactions.length,
      itemBuilder: (context, index) {
        TransactionModel transactionModel = controller.transactions[index];
        if (controller.selectedTab == SelectedTab.send) {
          if (transactionModel.transactionType == TransactionType.send) {
            return transactionTile(transactionModel, context);
          } else {
            return const SizedBox();
          }
        } else if (controller.selectedTab == SelectedTab.receive) {
          if (transactionModel.transactionType == TransactionType.receive) {
            return transactionTile(transactionModel, context);
          } else {
            return const SizedBox();
          }
        } else {
          return transactionTile(transactionModel, context);
        }
      },
    ));
  }

  Widget commonTabbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        commonTab(context: context, tabType: SelectedTab.all, text: AppStrings.all),
        commonTab(context: context, tabType: SelectedTab.send, text: AppStrings.send),
        commonTab(context: context, tabType: SelectedTab.receive, text: AppStrings.receive),
      ],
    );
  }

  Widget commonTab({required SelectedTab tabType, required String text, required BuildContext context}) {
    HomeController controller = Get.find<HomeController>();
    bool isSelected = controller.selectedTab == tabType;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        controller.changeTab(tabType);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        scale: isSelected ? 1.03 : 1,
        child: Container(
            // duration: const Duration(milliseconds: 300),
            width: Get.width * 0.27,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected ? AppColors.selectedTabColor : AppColors.unSelectedTabColor,
                border: Border.all(color: AppColors.selectedTabColor)),
            child: Center(
                child: Text(
              text,
              style:
                  Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: isSelected ? FontWeight.bold : null),
            ))),
      ),
    );
  }

  Widget cardSlider(HomeController controller) {
    return CarouselSlider(
      options: CarouselOptions(height: 160, autoPlay: true),
      items: controller.cards.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return cardWidget(context, i);
          },
        );
      }).toList(),
    );
  }

  Widget cardWidget(BuildContext context, CreditCard creditCard) {
    return Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: creditCard.themeColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [BoxShadow(color: creditCard.themeColor, blurRadius: 5, spreadRadius: 0.1)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.creditCard,
                  style: TextStyle(fontSize: 15, color: AppColors.lightText),
                ),
                height10,
                Text(
                  creditCard.cardNumber,
                  style: const TextStyle(fontSize: 15, color: AppColors.blackColor),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      creditCard.cardHolderName,
                      style: const TextStyle(fontSize: 12, color: AppColors.blackColor),
                    ),
                    const Text(
                      "  .  ",
                      style: TextStyle(fontSize: 12, color: AppColors.blackColor),
                    ),
                    Text(
                      creditCard.expireDate,
                      style: const TextStyle(fontSize: 12, color: AppColors.lightText),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const ImageIcon(AssetImage(AppImage.icWifi), size: 13, color: AppColors.lightText),
                const Spacer(),
                Image.asset(getCardTypePath(creditCard.cardType),
                    height: 17, alignment: Alignment.center, fit: BoxFit.contain),
              ],
            ),
          ],
        ));
  }

  String getCardTypePath(CardType cardType) {
    switch (cardType) {
      case CardType.masterCard:
        return AppImage.icMasterCard;
      case CardType.visa:
        return AppImage.icVisa;
      case CardType.rupay:
        return AppImage.icRupay;
    }
  }

  Widget balanceContainer(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(AppStrings.totalBalance, style: Theme.of(context).textTheme.displaySmall),
        height5,
        RichText(
            text: TextSpan(children: [
          TextSpan(text: "9854.32", style: Theme.of(context).textTheme.bodyLarge),
          TextSpan(text: "  ", style: Theme.of(context).textTheme.bodyLarge),
          TextSpan(text: "USD", style: Theme.of(context).textTheme.displayMedium)
        ]))
      ]),
    );
  }

  Widget transactionTile(TransactionModel transaction, BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.lightText)),
                child: (transaction.transactionType == TransactionType.send)
                    ? const Icon(Icons.arrow_upward_rounded)
                    : const Icon(Icons.arrow_downward_rounded)),
            width10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (transaction.transactionType == TransactionType.send) ? AppStrings.outgoing : AppStrings.incoming,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                height5,
                Text(
                  transaction.details,
                  style: Theme.of(context).textTheme.displayLarge,
                )
              ],
            ),
            const Spacer(),
            Text(
              priceMask(transaction),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
          ],
        ));
  }

  String priceMask(TransactionModel transaction) {
    bool isPositive = transaction.transactionType == TransactionType.receive;
    String toReturn = "";
    if (isPositive) {
      toReturn = "+";
    } else {
      toReturn = "-";
    }
    return "$toReturn\$${transaction.amount}";
  }
}
