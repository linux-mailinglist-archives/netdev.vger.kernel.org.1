Return-Path: <netdev+bounces-26192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D22477724C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3231C20898
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F7A1E500;
	Thu, 10 Aug 2023 08:09:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7AA1DDD4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:09:20 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41074212F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so3306175e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654958; x=1692259758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZfHcD5iKH92nMGOtJsjwO8F6ScspW6SHo1XJSm0hk0=;
        b=GnussyPTIou8eprNZioYl3UmyJGVZQP8PfyJOLOPBK1CNKetnRc0vmVqo5N0gamois
         mDlyOKYcXpldli1Uf0D+1d6QD1Bjkvn+t29P7/IKGJ5ETzI9dkVfatfMJOps9XPx0jFn
         ufMMCcxwL6cyG5Y5/4YEBlV3p+OMOxSUoYvboqVTi8r8pYTZT7mQ3aY8B0bzTAbZNYLF
         Sr6yp7zjNz83J09XXwaAp7Yvu60uZHInHTD8H7p8+rcwtLwhX0n+xvsqnq3tRxvfGGGV
         cIATdwKoJP0CyLQTkmM3WrCBWEpFGFYMz7yGqYCxAdF9d5deCSgf7oZCn7n9x03K8Fu5
         WGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654958; x=1692259758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZfHcD5iKH92nMGOtJsjwO8F6ScspW6SHo1XJSm0hk0=;
        b=dUQRXKzo40BkXWlDVx3hXGKtfADcpimsjB1SeeEdQpcpmXXfDOu4eF8yf9f3POT9Ws
         kfGx/96smCiJqzEfoj0UQFefimo6/Sv4M+pKw/lVgr5jzDbWBwAciHbZmt02f8nzERjE
         4CQuIrPHUbZ/n6KRtnPhegAZs4QhV4lpebvsDD9cKjCdH0i5TabNyzbFNR831ARjB33m
         nMZFgudM8u0N1hID3kl/dx/qcrPC81xJPv5Ub6LM1rElirxYEl3hBdk3fN0Pcsep5BfC
         WFfssRm9uzhxhzYEQ3okJP2lOdSW5t26rmfBOGOJOyB08c/ih3Gz9kQusG37JW7wQB27
         wujw==
X-Gm-Message-State: AOJu0Yyn0GIQVYneFtND+pQ0Y1c8fXSsCim8WLtaLQ6VyoYVN0VZ/4fL
	6D++kNsy8ZEOl1hwlaW3hxTYvA==
X-Google-Smtp-Source: AGHT+IGIa8oSvb3iGBVIroJMvJcCqmcdtRG4qeQaivBsqa9/Ce15p1oaQ2VrL0P69NEdqF95toUoaQ==
X-Received: by 2002:a05:600c:285:b0:3fb:af9a:bf30 with SMTP id 5-20020a05600c028500b003fbaf9abf30mr968467wmk.2.1691654957797;
        Thu, 10 Aug 2023 01:09:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:17 -0700 (PDT)
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
Subject: [PATCH v3 4/9] arm64: dts: qcom: sa8775p-ride: move the reset-gpios property of the PHY
Date: Thu, 10 Aug 2023 10:09:04 +0200
Message-Id: <20230810080909.6259-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
References: <20230810080909.6259-1-brgl@bgdev.pl>
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

Device-tree bindings for MDIO define per-PHY reset-gpios as well as a
global reset-gpios property at the MDIO node level which controls all
devices on the bus. The latter is most likely a workaround for the
chicken-and-egg problem where we cannot read the ID of the PHY before
bringing it out of reset but we cannot bring it out of reset until we've
read its ID.

I have proposed a comprehensive solution for this problem in 2020 but it
never got upstream. We do however have workaround in place which allows
us to hard-code the PHY id in the compatible property, thus skipping the
ID scanning.

Let's make the device-tree for sa8775p-ride slightly more correct by
moving the reset-gpios property to the PHY node with its ID put into the
PHY node's compatible.

Link: https://lore.kernel.org/all/20200622093744.13685-1-brgl@bgdev.pl/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 09ae6e153282..a03a4c17c8f0 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -279,13 +279,13 @@ mdio {
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
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
 		};
 	};
 
-- 
2.39.2


