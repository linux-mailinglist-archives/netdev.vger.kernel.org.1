Return-Path: <netdev+bounces-26189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B759777242
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3321C2030E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B81ADF8;
	Thu, 10 Aug 2023 08:09:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A91ADF7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:09:17 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4C10EC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so9843261fa.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654955; x=1692259755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ie4XHfXmLN17VpRpXqW8hX803ADkU00/SZ+VLSEgXo=;
        b=Hq+/takm7mG/JzYZdoPMLRzMncOo+pJwi3qya1XAGOY5caiL0xscmhVnPwNc1RPtVv
         dIhPLCCsYug4tXukVatgw4215Q3ijgiblxlRe93XGG1Qhyk036Vu4lRjkEdprhaLDt7X
         WQA7EMBaSQXV7M2owB3Cof4mO4BLSXfAVfu40Rj/VOnECqzDPsDuzITlxvd8tqwDCfch
         Q4P69/Az4N1BXhxdk004RIQfZALbKmKDyKVVJERWyCV563GqaaMWnU8f4Ql1VbIzZsRo
         4i4lL1wluHcQZSORRUoTDcwu3CG7D8qVJ8RQ79le1hx7MZ+h7S638SOs3GO+Mo7NBDjO
         Sj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654955; x=1692259755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ie4XHfXmLN17VpRpXqW8hX803ADkU00/SZ+VLSEgXo=;
        b=UYy/t7HfUd54cL7l4eslSy/hjAPEfXY52r3a1BJfnMyjs5gKKSZmGpHInozNtrE64K
         AN4moI2fxFh/Lrzypt/2jgXmUMyc7nFKe0Sc5Y4VpFyzGtrrRhSjmak91gqVvvHOrh+/
         HITQkeQJWpfT7yMBD/aE9oTZPGCgEEnJeUvd/dZFQR2oGQ2ZTGxsJnSIBfHl6xA4pSGt
         1y/uFsFkshT47YzTRBvESpHXjf6p4fTuJhphURnIKnuUa/GlKSIU7HWQETCqulNMJCgn
         kn+o1AIBV0PhHxI7jvTHLEWf7MT1plhL9qsH7xGysSuyKm6aN4LfSr+/6o9OqGwod2qf
         E6qQ==
X-Gm-Message-State: AOJu0YzPf+SnJaHlBawYrtKBYf7ID2oVJ9mJfTHAqNRPfLTEODcszB2F
	helWnJZh/Aviy6vv/iLxZUpqkQ==
X-Google-Smtp-Source: AGHT+IGYachim5YZFTB4/OS81PMKVTpqicCYQY5WZZFI1VQQMvNmVJWHKT1resQUK5uwm5kf3VTtrg==
X-Received: by 2002:a2e:998c:0:b0:2b6:9f5d:e758 with SMTP id w12-20020a2e998c000000b002b69f5de758mr1333858lji.9.1691654954704;
        Thu, 10 Aug 2023 01:09:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:14 -0700 (PDT)
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
Subject: [PATCH v3 1/9] arm64: dts: qcom: sa8775p: add a node for the second serdes PHY
Date: Thu, 10 Aug 2023 10:09:01 +0200
Message-Id: <20230810080909.6259-2-brgl@bgdev.pl>
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the SerDes PHY used by EMAC1 on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 7b55cb701472..38d10af37ab0 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -1846,6 +1846,15 @@ serdes0: phy@8901000 {
 			status = "disabled";
 		};
 
+		serdes1: phy@8902000 {
+			compatible = "qcom,sa8775p-dwmac-sgmii-phy";
+			reg = <0x0 0x08902000 0x0 0xe10>;
+			clocks = <&gcc GCC_SGMI_CLKREF_EN>;
+			clock-names = "sgmi_ref";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,
-- 
2.39.2


