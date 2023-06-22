Return-Path: <netdev+bounces-13038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE873A06E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82FC1C210E7
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29131E520;
	Thu, 22 Jun 2023 12:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74271E511
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:02:18 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD73A1FD8
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:01:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f90a1aa204so67140065e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687435313; x=1690027313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnFCRdd8+pW5G4gM6AK4GzwvX/vcLvio6wOvkwBDM+o=;
        b=qNSdKl27WHz74NTSxtk27+pswSnyVPMIg1ifP13s+3R0ayxVeErIzjtpJBA99E+Wnw
         UQjQp6JsMtBzTDEnYFP+5Y6wqyHS6dEDOBnscad4hPXUE9vcV/kMVekdhUv3KQRwCnz4
         wALFmkZ0rcKXhvWmyKEscxuDFtxtCgJOjpF5O6Afg0p95I36ANdOCAtKpsf3ds1aLbiL
         4alSNiCUG8viAhIo9+lOMzd5JUeJXz8FhtuPGX5ocL+bt95PHEjS6iBYs+t6dI3Ovnfj
         xM1Xd8/Xf+f6LVPntBo2jRRgYdhD3lpnMOXFrS928Bwb3GSEIBzE++PwxwtzuQJ8UMmz
         FByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435313; x=1690027313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnFCRdd8+pW5G4gM6AK4GzwvX/vcLvio6wOvkwBDM+o=;
        b=NZ9wlhmQXjmxK8XPAIcXX+DaL/G6xnjeDhVOwMbtLnyPBO4JrOKLQfrbon/Z/ppZXA
         JWSGXsWgt1zJCnukhEHCj68rtFXtgFKsIGya3K5x4GKd8QN2Nmvh2eCYrEH5ifSJmsUi
         aAl2fCDiBPJR9tvOD/dY/2DS3gg2Pyhbcu5Ke602Lb9O31oUSkDcRAaWDm1bFv60Y/8v
         9Au7Xf7lG3OzphS6vDFjZOiMSDQGz1hbTyRi+LbpqaN34jeM33xgsRW5Qj151h2sLYli
         HjdcwizSy1GJSryb0IqWGL1ZwSi8VyCjKShCFM5n8LFS2G8T/MYMjiXHTE4TsgE35b3/
         3dkA==
X-Gm-Message-State: AC+VfDyZ1TlA7yhLrbmiBicuCLzLJIuHlNa9J77filJSoPT/nOfd/ES8
	2HTMxVrKSIXLoAI0bnKFO0/SZw==
X-Google-Smtp-Source: ACHHUZ408WOhA6NS6AUuXtIaCDiEf9IM1PrOMR2VsLC/ea5uw9bJ0cpiL5TqyGEJ/fZYIrt8khR7BA==
X-Received: by 2002:a05:600c:214c:b0:3fa:71c7:5bad with SMTP id v12-20020a05600c214c00b003fa71c75badmr2438988wml.39.1687435313366;
        Thu, 22 Jun 2023 05:01:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d785:af3e:3bf5:7f36])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003f8ec58995fsm7594296wmo.6.2023.06.22.05.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:01:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 2/5] arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface
Date: Thu, 22 Jun 2023 14:01:39 +0200
Message-Id: <20230622120142.218055-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622120142.218055-1-brgl@bgdev.pl>
References: <20230622120142.218055-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the node for the first ethernet interface on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index b6d95813c98c..59eedfc9c2cb 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2315,6 +2315,39 @@ cpufreq_hw: cpufreq@18591000 {
 
 			#freq-domain-cells = <1>;
 		};
+
+		ethernet0: ethernet@23040000 {
+			compatible = "qcom,sa8775p-ethqos";
+			reg = <0x0 0x23040000 0x0 0x10000>,
+			      <0x0 0x23056000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			interrupts = <GIC_SPI 946 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			clocks = <&gcc GCC_EMAC0_AXI_CLK>,
+				 <&gcc GCC_EMAC0_SLV_AHB_CLK>,
+				 <&gcc GCC_EMAC0_PTP_CLK>,
+				 <&gcc GCC_EMAC0_PHY_AUX_CLK>;
+			clock-names = "stmmaceth",
+				      "pclk",
+				      "ptp_ref",
+				      "phyaux";
+
+			power-domains = <&gcc EMAC0_GDSC>;
+
+			phys = <&serdes0>;
+			phy-names = "serdes";
+
+			iommus = <&apps_smmu 0x120 0xf>;
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <16384>;
+
+			status = "disabled";
+		};
 	};
 
 	arch_timer: timer {
-- 
2.39.2


