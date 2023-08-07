Return-Path: <netdev+bounces-25095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D8772EE3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD971C20C91
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376C1641E;
	Mon,  7 Aug 2023 19:35:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A4168B2
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:35:26 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA21724
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:35:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so31450975e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436923; x=1692041723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEn7Vyzxp0oT+8eRlG36dyHTspz7ckMQVTd2N8j7ySI=;
        b=2xJv9sDHJKP5PmcQdVHo1SUlesf5gaJlLd8lQYvoteDchIWKBRSVJAMI1oZpAr27Ec
         wRwU11Jx/l6GHM3u6UvvAZX8cqvyhiUppJd3l7U1NPJkP3Xss8KlH8homneaSFWCPVXy
         kcptShpBP3L9qosCIjH8M2OLqVFnX/AnWy+uyDeTfQZ1ndG0pxKg4ADQVZb3fbJaIvkp
         XJ7imsBYFC22SFv+0yZSXrhW3dmfop09nGBchQ1pot7JY7JjhKlebDzqlF0g97fYWrYj
         La3D1AuBVu6LdDL0jLMmhi1WJ8CS5l22HW9VEI0LkH2cY7ZoLrzmsS+g2iosDBX6dHc5
         YJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436923; x=1692041723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEn7Vyzxp0oT+8eRlG36dyHTspz7ckMQVTd2N8j7ySI=;
        b=YcF+wusifn79x4enafAhLKzOBofzPBiueHgaR0u1vrWN1uYBLikU+llwjbd/UqTlag
         SX4/oWYWTif1f/OcRJGbVl6t+8Yw63gm33AsNe5cUJCuqmHnZ3Se/emt2VWsVBDx0DAN
         TwoLsUr5XG5PVg/XbwnS0Hc2Ql3Fnl+an+VsH1k4GHzQNU/HsU25TD2SM3uTHRomlkCE
         J0HsQaHvkrrv6Gs/yLZsFn3z1kXkWjoszw6HE4+XVn1q2lSmlJlCM0KGpQJ/fs6EOWsM
         u4huMbpj47a4Gns6w09LSPCICNId9cXCo0tViGuiCEk5sUxmvH5sAmnk6/I5OP+yb/2b
         2w7w==
X-Gm-Message-State: AOJu0YwuNGkx0bbFMCMlp2SVDi6UbyjwJnPmTIW4xKXU96WJujOgoVGM
	fYcZ+M1B5oTmU2z7ZPUhCIzTmw==
X-Google-Smtp-Source: AGHT+IH8Xr6+EP/rdBj2XSnQSzFIwvg9Ltd6zyko+R/lBTfw2Io8uLU5JqkOEBdcsM5ijdPR5Z9F5g==
X-Received: by 2002:a7b:c7ca:0:b0:3fe:4548:188d with SMTP id z10-20020a7bc7ca000000b003fe4548188dmr7888606wmk.7.1691436922836;
        Mon, 07 Aug 2023 12:35:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:22 -0700 (PDT)
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
Subject: [PATCH 4/9] arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet1
Date: Mon,  7 Aug 2023 21:35:02 +0200
Message-Id: <20230807193507.6488-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807193507.6488-1-brgl@bgdev.pl>
References: <20230807193507.6488-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the MDC and MDIO pin functions for ethernet1 on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 09ae6e153282..38327aff18b0 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -480,6 +480,22 @@ ethernet0_mdio: ethernet0-mdio-pins {
 		};
 	};
 
+	ethernet1_default: ethernet1-default-state {
+		ethernet1_mdc: ethernet1-mdc-pins {
+			pins = "gpio20";
+			function = "emac1_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet1_mdio: ethernet1-mdio-pins {
+			pins = "gpio21";
+			function = "emac1_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
 	qup_uart10_default: qup-uart10-state {
 		pins = "gpio46", "gpio47";
 		function = "qup1_se3";
-- 
2.39.2


