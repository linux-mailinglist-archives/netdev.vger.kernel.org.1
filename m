Return-Path: <netdev+bounces-25536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9842B774786
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87551C20EB0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABAC171CC;
	Tue,  8 Aug 2023 19:13:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0098171A4
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:13:58 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3792341B7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 12:02:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so50664895e9.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691521320; x=1692126120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYZbQHrxpkTe36I8BIa5OFnDC71e2O9qRRyJDc3ulLc=;
        b=JEQmQTNVlr2LI7Of/NkrrpUbKCv82EZ8k0SyfbKP1swdLvkCNa+f+2bp0bGJ+uK1LA
         euyMaa5H2ZbM0g+yDuIpsR4HCTUGbFFxBUmUcGpcpQhLQa0o/OzCIc1OPoJVR9rJOcJX
         lH4CFM03JSIGa4raMA5g34DZ5HMisipJfOkNUW35P8PVXDWWIe7mdKxsxDYVVmikXW62
         m5wHQD0L3EgHh5HrIASbm9Hbt0lN8tW1W0wlS7VzYT/559NWr/s96PEidyTtarcHrttc
         FRbCXmc7O4mis1BD/Hno///0jDSX6MzC7e9qlPMZ+L7YsS3PoR375pK5DW0IdCNkokPM
         A1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691521320; x=1692126120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYZbQHrxpkTe36I8BIa5OFnDC71e2O9qRRyJDc3ulLc=;
        b=BRMeWseFSIlcl08MgTYraorwp+3kmDIINMS4TTMKrWQV2KtAzPSB0WB3BnMEdhJvtG
         FWCEcaCls6u4zLx76JRgmu6/tKGRe5n2dIXkfBjiSNP5zryVmbRIVRRZFTpcG2dviGKg
         6UScHWhkNS6DR+H69t076rrUbmf/SBJKkYQ+xXDEoe0Srep/89qbuo8No2/d+nguQ3t1
         uZJrBdN1JKb4Fy66hLDGWqMSLtBprdAIlKkqqfPvlFju39PPQFLxYqQ/q8czffEkf5LQ
         3lgGSrqqzRVUALZ4SDzjTJGBl4fRWckyoS1vqB00umo9BZDwlAQG8rBIVvcIIPRB65Qu
         zaNg==
X-Gm-Message-State: AOJu0YzlLEVw55NiKIuWIOPVQXgI4NZ6SZAvTbpcgUoSwLSybQYOfuGh
	sof4m6m+4+Wpom+gNwC0dnef6w==
X-Google-Smtp-Source: AGHT+IGJxd8G9X40eIjxwFlRGwQz785i3Io9vskmf46BbSTOXlgI1WmbSJ9NiS4l4e+xS+tgvkRDZg==
X-Received: by 2002:a05:600c:22c6:b0:3fc:e7d:ca57 with SMTP id 6-20020a05600c22c600b003fc0e7dca57mr505644wmg.2.1691521320164;
        Tue, 08 Aug 2023 12:02:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6a08:bcc0:ae83:e1dc])
        by smtp.gmail.com with ESMTPSA id z14-20020adfe54e000000b00317e9f8f194sm7301055wrm.34.2023.08.08.12.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:01:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 7/8] arm64: dts: qcom: sa8775p-ride: add an alias for ethernet0
Date: Tue,  8 Aug 2023 21:01:43 +0200
Message-Id: <20230808190144.19999-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808190144.19999-1-brgl@bgdev.pl>
References: <20230808190144.19999-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we add a second ethernet node, the MDIO bus names will conflict
unless we provide aliases. Add one for the existing ethernet node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 486cb48ecb9d..330553742204 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -23,6 +23,7 @@ aliases {
 		i2c18 = &i2c18;
 		spi16 = &spi16;
 		ufshc1 = &ufs_mem_hc;
+		ethernet0 = &ethernet0;
 	};
 
 	chosen {
-- 
2.39.2


