Return-Path: <netdev+bounces-25096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF9C772EE4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38399281563
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4545B168BF;
	Mon,  7 Aug 2023 19:35:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28D168B2
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:35:27 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD51717
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:35:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-3fe5c0e57d2so11200205e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436924; x=1692041724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mxzaq+NrM+rI9BGdN8+qRzAj37dK8WvIhI/Ftci2F5g=;
        b=mrigQd5CL1Q/aazYd4Cn504gRfXGrDvfjmQBuRCQFNkgA339hiTI8zwK7rlb/s+Bo8
         yN2+4j//ZlsvRAQiri65N+XkK25hlCNOm+4kB2lzlJzEs5oPgBpcfG49F8Ku5lfP+gi7
         vwLfkkTZkZs3fjJT6nO5yRHeOfqFO1ZKRDxGUAqbR6BNqsldhRqXS9cBpxaAtYM3/+YB
         3Kjokg0XYtz3n4h61lMQ4kp+F0NLgg03sNchk4/s1GFSvxJ2DyAiXPxcc+BwvhJifRZB
         2fluab9kGUYWJmItqLqLC41zDLaXe+lgkmsufzV+8DuKbytAeZdyVZ+FhRyH7Y+ksxA2
         887Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436924; x=1692041724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mxzaq+NrM+rI9BGdN8+qRzAj37dK8WvIhI/Ftci2F5g=;
        b=g+zXHMb5RYvQDpj6BJ5M5j9SX1ldvYVVrlRnv2HuMeBX8HkD7mGifActbfGF+MlKlM
         LLH0V70D5abfade231lmoeGpUoroiTr7soN7529I7VunwH69wUmhGDwhywK5EcOKQN0M
         i9FnRQJrkiyjvmMYGD+wYjDIqE0DEIUoxOlE4TmZhHS6mHCFoygRVlkLCiXIk3krXFvU
         Xrtmd0qmTvDGPvf0hLjzf7gFdh0d74lfkcYFPNTwgnWNjzyW22ufE3RMsL7KXyHIR37L
         M8yNruUAvE7s5DEJKqEWDmdwArQ/al7mPOeiqMDythRO83DBIeMN/7phyBxCzlAset07
         BwBw==
X-Gm-Message-State: AOJu0YzbtmYp0q2pNqJtOnohhlOGEPVmRGyElMf1ayUXpTnBELsk3+Gj
	CG3cyIX7uhrUwn6J/p54xrT7Bg==
X-Google-Smtp-Source: AGHT+IEJ7Gxowf9uX6uF/FNUe4WB138H+f3bt/0qu6PF41fqzFO4aA9R+U+qLIWMmRc+ckjWJwr0lg==
X-Received: by 2002:a05:600c:2283:b0:3fc:a8:dc3c with SMTP id 3-20020a05600c228300b003fc00a8dc3cmr6692479wmf.37.1691436923905;
        Mon, 07 Aug 2023 12:35:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:23 -0700 (PDT)
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
Subject: [PATCH 5/9] arm64: dts: qcom: sa8775p-ride: move the reset-gpios property of the PHY
Date: Mon,  7 Aug 2023 21:35:03 +0200
Message-Id: <20230807193507.6488-6-brgl@bgdev.pl>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Device-tree bindings for MDIO define per-PHY reset-gpios as well as a
global reset-gpios property at the MDIO node level which controlls all
devices on the bus. The latter is most likely a workaround for the
chicken-and-egg problem where we cannot read the ID of the PHY before
bringing it out of reset but we cannot bring it out of reset until we've
read its ID.

I have proposed a solution for this problem in 2020 but it never got
upstream. Now we have a workaround in place which allows us to hard-code
the PHY id in the compatible property, thus skipping the ID scanning).

Let's make the device-tree for sa8775p-ride slightly more correct by
moving the reset-gpios property to the PHY node with its ID put into the
PHY node's compatible.

Link: https://lore.kernel.org/all/20200622093744.13685-1-brgl@bgdev.pl/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 38327aff18b0..1c471278d441 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -279,13 +279,12 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
-		reset-delay-us = <11000>;
-		reset-post-delay-us = <70000>;
-
 		sgmii_phy: phy@8 {
+			compatible = "ethernet-phy-id0141.0dd4";
 			reg = <0x8>;
 			device_type = "ethernet-phy";
+			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
+			reset-deassert-us = <70000>;
 		};
 	};
 
-- 
2.39.2


