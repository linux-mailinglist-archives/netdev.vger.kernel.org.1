Return-Path: <netdev+bounces-26197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1EC77726B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04331C20E53
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933871EA92;
	Thu, 10 Aug 2023 08:09:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6D1DDD4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:09:28 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A94226AB
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so5519905e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654963; x=1692259763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XnXEHTpcZwsLX4QNNcVLRlqnkdUgZEa6wcYgGVtY88=;
        b=KHxobwMmJ5xLuQ3fTqWbKzB6qgqvAQdnuSJxNgr8p3NLWm51+bi9KztXc/Nn3jKmBQ
         /znodQXxIzxDNtXb62bMYgIR4q5VIXgRjdEt9TlcM2Ge/V2PVRicEt8B91KIdIxIB8I3
         o2ygAkhRR5mE+tO56OrSQormCUMSUVslpOF2yCabPGeHuwEYFeisK27aj4qjDhDbFhAG
         CF0pwVxYjxHLE+WGC/Zc+dLbfOsNVuXytzniNciQ0AF2oyVg7cfnK41Eq2xUluLtbTw3
         xy+rl9k9YOvAB9YDtV2uvbqqYyAx/YhIeUzrfjB8OFMO4ynncy9HfMohXrBr+9ghvcTw
         gPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654963; x=1692259763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XnXEHTpcZwsLX4QNNcVLRlqnkdUgZEa6wcYgGVtY88=;
        b=gHYqUxVdJQl7c0wgafW5aLBYDue3kbfp5Elj6va1XKONWUMPbRAWmYbUxFJgsuV0Lp
         3CX6gUO9k4T47hx6rLGliRwRPsR6/T4IFfyQoRbK6Rx+d/eBTGVZqCaiF/1T53RubhNQ
         z8zpvjogUnfSLdShXeFU8euyQYfgLaNLE4mH6s27Bwd9C38FkqzEVEcD3ud8NndBnFSB
         4QL87Wb0MkkBJGduLP0NaDVWzBrieFj1eBqCLNMxRbfVjWUlOvcqQNc7b7hEEUou6Pge
         goecDA6xWbBH/1Z0RfvcwMmdNp3NfKuksHAJ4c44H6Oz83xUSWlAAnB9dHa8mf+i22BI
         Dezg==
X-Gm-Message-State: AOJu0Yz1YPQgQpsVF0/CG+bCqWzkvzECjE6fRvgT6xRPXaZN06b30QPU
	nv59dtG9RJsvRiHDLnQcLlB4Tg==
X-Google-Smtp-Source: AGHT+IGuwA9g6Dv+9oaRLjpG3wLqlI4/PqOEjOrVytYMFrFOB7GDlqo/TdgkN3fFponJHiXh3bKVaQ==
X-Received: by 2002:a05:600c:b4e:b0:3fe:19cf:93ca with SMTP id k14-20020a05600c0b4e00b003fe19cf93camr1278555wmr.8.1691654962976;
        Thu, 10 Aug 2023 01:09:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:22 -0700 (PDT)
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
Subject: [PATCH v3 9/9] arm64: dts: qcom: sa8775p-ride: enable EMAC1
Date: Thu, 10 Aug 2023 10:09:09 +0200
Message-Id: <20230810080909.6259-10-brgl@bgdev.pl>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the second MAC on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 71 +++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 48119266c6fd..81a7eeb9cfcd 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -17,6 +17,7 @@ / {
 
 	aliases {
 		ethernet0 = &ethernet0;
+		ethernet1 = &ethernet1;
 		i2c11 = &i2c11;
 		i2c18 = &i2c18;
 		serial0 = &uart10;
@@ -359,6 +360,76 @@ queue3 {
 	};
 };
 
+&ethernet1 {
+	phy-mode = "sgmii";
+	phy-handle = <&sgmii_phy1>;
+
+	snps,mtl-rx-config = <&mtl_rx_setup1>;
+	snps,mtl-tx-config = <&mtl_tx_setup1>;
+	snps,ps-speed = <1000>;
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


