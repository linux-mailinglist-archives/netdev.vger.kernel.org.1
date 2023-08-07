Return-Path: <netdev+bounces-25100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F6772EF7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807BC1C20D00
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7A1168B1;
	Mon,  7 Aug 2023 19:35:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F52171A4
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:35:32 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726AE19A6
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:35:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso41867465e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436927; x=1692041727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo95VHacSOouEChX8JO8J2HsGNhYMKSzCOBU0ZPBnt4=;
        b=4qMn/9J/Lk2cBYAMpaJ+2vRHdGu6OkayegJxPaIgrZtyjc3dQzvSYRspTRgjtn+b2p
         dpsMTm+l9Z6ZSVwztLf2OQbec8/mRniGaTrUoTu6YwJ5u5Y80DNo7hbNQ26bdmzIYUkS
         D/27tCJnW1yHH9WI1FFIXmpUkl1a0vdHMEbpRQ0upjMLgQmqrwFH3Gh5tfgPXosi1R/o
         yyt41rY/No/0jfcae/hPZ/IhM2NJdKhzwHm3YHCrHkygzuudvV4Y3M72VujNLEsqzNNp
         LJkwvhGtrLuO4EBykjyVlWsAhh5YKsTpNB9CTWndSBZsHtcduDGPXwDIbKgnQ3V4QjNa
         HVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436927; x=1692041727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo95VHacSOouEChX8JO8J2HsGNhYMKSzCOBU0ZPBnt4=;
        b=Y4P6MgawDTb5LHclHcQD/Nx6iP/2yqMfXICceuzDWO428RTflKM+T+7qZxHUCp/G4e
         0nrhlxsv7oZCIgc8h+pflYh2tKusUY6mDtcelUxYq4HZPTHqS78uYCy0GxQOb1nWK/AL
         lW4MqE8/6ceY7zhcmlONsAvV5LpvQk8X4kX+6pdVldO4j36tGItAhAC5rqfrRAyQN80X
         c8PsjpPh+ptz7qFecvTF3Pyh6fWP9iNMWH7uSrS1LoKK31CT17uIp1A2e5ARoNitAEia
         Eg9jAjTydbeNVoB4CHqCUNWxFagDsgT+ZVH3UyPk1R/rVISWOW9sdO3OaGoykDmK+Omz
         trVA==
X-Gm-Message-State: AOJu0YzNw/DU1x0kL7k09I5OVChy82N+tVaPA1BDR0aoJJDprFFAudQ3
	Lqk1V5WO5lSDkMuUZ3TxS9zmvA==
X-Google-Smtp-Source: AGHT+IG8+ARG74TxYu0rJtXTmYwK0yAnAFoMjeeXJYE8/TO+exRWTkRiyDEGFAmQcXp5cftSvKFKeg==
X-Received: by 2002:a1c:f70f:0:b0:3fb:ffef:d058 with SMTP id v15-20020a1cf70f000000b003fbffefd058mr6645779wmh.0.1691436927715;
        Mon, 07 Aug 2023 12:35:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:27 -0700 (PDT)
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
Subject: [PATCH 9/9] arm64: dts: qcom: sa8775p-ride: enable EMAC1
Date: Mon,  7 Aug 2023 21:35:07 +0200
Message-Id: <20230807193507.6488-10-brgl@bgdev.pl>
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

Enable the second MAC on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 74 +++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index af50aa2d9b10..0862bfb4c580 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -356,6 +356,80 @@ queue3 {
 	};
 };
 
+&ethernet1 {
+	phy-mode = "sgmii";
+	phy-handle = <&sgmii_phy1>;
+
+	pinctrl-0 = <&ethernet1_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup1>;
+	snps,mtl-tx-config = <&mtl_tx_setup1>;
+	snps,ps-speed = <1000>;
+	snps,shared-mdio = <&mdio0>;
+
+	status = "okay";
+
+	mtl_rx_setup1: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup1: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+		snps,tx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &i2c11 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&qup_i2c11_default>;
-- 
2.39.2


