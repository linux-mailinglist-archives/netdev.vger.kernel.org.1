Return-Path: <netdev+bounces-14194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC58173F6C3
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4ED1C20A70
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D93168C7;
	Tue, 27 Jun 2023 08:16:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B2168C1
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 08:16:16 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC826A6
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:16:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso9980655e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687853769; x=1690445769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpBVPAKTok015GFuGr3EUx7kWd0lyxxnZqUym4JaeO4=;
        b=ZQo8rjS3M43oVtjApvtLlboCA+7nsIRrPeGPpDp2QybbPqx2dtnCqtIYjqmERYsoyK
         e1gd+OAZ6ldoRUOnLdLFu+HzLh3+RM08HQoo3FCceC6CvFV9td45EoX/EKPPJ1DEAO+M
         wJtas4eOMauFMwdX5iwzp/MNtCroMopvKAPnCDps7a/UDbyCRKgxVELGrWcf9ZWSPqIR
         C08rQiw2WJ3hRIuH8Q/i9RD3PXcThS+5P0V2nKJw9PMCfM/6JuJruBgdRMh0WMB2hR5Q
         A2nRsTNNsYrhwrNwnq6a5i2LW9HwwenH4yhAIitoist08xJ3Z2ZM2uHEc29LMHjKiq5x
         0vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853769; x=1690445769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpBVPAKTok015GFuGr3EUx7kWd0lyxxnZqUym4JaeO4=;
        b=cCBoWXQGyu53jR/7D7Yt7nxMUr7hX6SQlyOXvW/lnm+Ri9mRM+rcWSjVvclLz1Vtyf
         IYHLghUnC5jhAMZT+x/X0AFpU4hrZuDDfHmXceC09OcDVUt5PXYeNBYI1WKFfMXZC2Jf
         6nFVxwwExo5Fi5eXrUfO6JTbaT0IuOqVh+hJL0ZzFfJcw8MueAT5+CuRhRptkOoxCLtU
         nzJer0BTvsPEkSnrBRwxWj+e98mwClcXvT2yYYUajgcP2ORSoX+imxyGFHm5eAMUAAvW
         6WUShVPrNqXH1qyF0KE4Z4wWTgMrqJUdDzYILKf9gkYgVEfojMnDZ1dMmrzVnK1w/J+b
         eX0w==
X-Gm-Message-State: AC+VfDwaViIG6OUsnpxcsc2UX0wnigl+Odfp/GHeorH9OHA25JyxwdqI
	LXlNsRjkIp21rCbjAuYDGisFAQ==
X-Google-Smtp-Source: ACHHUZ4iJV35Qhf/eHohnuHCSGC1/jskmwlcjwe9pybhzXdx2fgXkcopzP+c55nSL5t6EIuFxjsAgg==
X-Received: by 2002:a1c:4b11:0:b0:3f7:e78e:8a41 with SMTP id y17-20020a1c4b11000000b003f7e78e8a41mr34257351wma.18.1687853768782;
        Tue, 27 Jun 2023 01:16:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003faabd8fcb8sm3922480wmi.46.2023.06.27.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:16:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 27 Jun 2023 10:15:57 +0200
Subject: [PATCH v2 4/5] arm64: dts: qcom: sm8550: add UART14 nodes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-sm8550-upstream-bt-v2-4-98b0043d31a4@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <bgodavar@codeaurora.org>, 
 Rocky Liao <rjliao@codeaurora.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jaEK1SW0U7tuAtTapDJNwvxMKnI1nWuMsJihPmoQlrc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkmprB7csm8NK59FIRf37oWsYMsFzp8vr3jW15ZUbT
 5t8cumCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJqawQAKCRB33NvayMhJ0R/LD/
 wIHevPwfj1Ukpd5iMRwuoLG9MKWLcB6AXx/pQfrRYvossKg41fiiLcDXztNq3ZxiQ3ijdK9VJEkZNb
 4D49dHXO4gowVFYSGSyKulhhazUrXo58CBS9jqiziNEQ+JhAWWHHJb3t7+OnsBaCgdUrc+XyskIzeF
 3yeEtn+OOFbEjg9b8svDP1Yjchf1iEbLBCG2T4CFVrlreQUxy0ixocoe2et5yxACvF0MrDaEwbCJOj
 7L1mQ7G+fcEQdtvoGEAOtmy+Q7b78NFkLm6nENio+QUHyxQ84C1vhG3puMsI8Uoz8Z0J3a1fGje6Eq
 +MiuU46+kUlRGGTsYnZqKJ5hEzzNHeo7liHsfmDrCeuY5WTzkt/7ZHhDRvQ5PddhStTbnl5cIg2l+v
 1DK5x68AYWpFnK4KVeYxcYY0HBL61K7deBFrkn6nD6CgcCOPOaRoRqr67Klj2YIlaCJkIxkKX1vjXx
 7oq3GWcLPIHtTPXSKVDJqZNdKBmYZTgUdc6ftR1UgSGgGSi0OTIJmi1Kb97doJG0Wu1S4B9e9jDdx9
 rU4FFpKpGy0BeTlygCjJxHIyuYmHdGswSmW/j0rLAyEFDzwXzd6AIt2E0UwB83tISn/zVfYPXowdx8
 Tth0KwGuEIHB68XYPaDBohR6bD3dcMw29pNhYMOShyH7HdUb0sdSnBLpDaXQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the Geni High Speed UART QUP instance 2 element 6
node and associated default pinctrl.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 75cd374943eb..252e3863322c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1053,6 +1053,20 @@ spi13: spi@894000 {
 				status = "disabled";
 			};
 
+			uart14: uart@898000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x898000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart14_default>, <&qup_uart14_cts_rts>;
+				interrupts = <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
 			i2c15: i2c@89c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0089c000 0 0x4000>;
@@ -3382,6 +3396,22 @@ qup_uart7_default: qup-uart7-default-state {
 				bias-disable;
 			};
 
+			qup_uart14_default: qup-uart14-default-state {
+				/* TX, RX */
+				pins = "gpio78", "gpio79";
+				function = "qup2_se6";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart14_cts_rts: qup-uart14-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio76", "gpio77";
+				function = "qup2_se6";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			sdc2_sleep: sdc2-sleep-state {
 				clk-pins {
 					pins = "sdc2_clk";

-- 
2.34.1


