Return-Path: <netdev+bounces-26191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4EB77724B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884DD280602
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5011DDDD;
	Thu, 10 Aug 2023 08:09:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F911DDD4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:09:19 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CF910F5
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so5138575e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654957; x=1692259757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i/SrZF+jY6u1jae550/qtxZRbJK0LYhJpc6f9zoYy0=;
        b=TSkZ/z19Ewdl3ii6ZrEpjy0SNsDYae+B7yxQS8iwRCi1WEu2S+GgYSD4gR0F7PXXyS
         JPZ+CZ58O4/ChchZJF6+bT7dYKRFqgJWnxq1w18KrL6Cd1ypmiU06phL3s+ye7RWoNIP
         iy8lqyG/45vIMyiZwX4JBx6/XUSY255F6HIldfVQC/o5uZHIUVKdXuTXR3peA984D8SC
         THWVHrngTGtBG9wISwBKfWv59BFyZtf/CBPCTUIoBAepxec30C1feXqhyl9yKZIebBmY
         UNvtdgdYEe4JgwO2qZp5Wc0qjxUByJDLSsF/LnFtMxenYNP6QuCmOCtt8L1GtqsizFPS
         /+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654957; x=1692259757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7i/SrZF+jY6u1jae550/qtxZRbJK0LYhJpc6f9zoYy0=;
        b=T7MxC5KAZrtJ6UJ677NtHhT9P1ARtt6ukfgLOu98sMlK4spdXcM1UB8PtW/tJCwJAF
         dVBItb3xWcEETGU3foupKKLxQnCs5ntJF53YWEdC2c0D+V2of5XHpqDsV8ZFmzHAh87U
         3HgDwUJix9w6AFKl7ZmMllbmPG+6/K//cHheKDFzyhk9nUvcobHMPGwmD+AW3cmOmkmc
         Q2Rio4OUgVVYsYbaajCXpAvB8mIqWb64R86b0cw/uB/Bd1E/tFtecowylubz8Cno4yMA
         fcVh4DO5FOiI7VkCEAbgOyIMdm4T2ITkIftoUoofkCSoo1ugGa1qXjOeE6pqieT2NEB4
         irkQ==
X-Gm-Message-State: AOJu0Yyo8JH8ui2BtoQwzgKLj4zx/2TE/VxP1BRpydrEHfhn9I2rH9TA
	R64ly0trqStRAlLKQgm5DOc1rQ==
X-Google-Smtp-Source: AGHT+IFXte2Z3OPC0mOtun/00VY/jOftBufylvOjCscAxfiFS59vQyoj6n4WvAWwPTvqANfIkD47LA==
X-Received: by 2002:a7b:ce0b:0:b0:3fe:3004:1ffd with SMTP id m11-20020a7bce0b000000b003fe30041ffdmr1291842wmc.4.1691654956853;
        Thu, 10 Aug 2023 01:09:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:16 -0700 (PDT)
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
Subject: [PATCH v3 3/9] arm64: dts: qcom: sa8775p-ride: enable the second SerDes PHY
Date: Thu, 10 Aug 2023 10:09:03 +0200
Message-Id: <20230810080909.6259-4-brgl@bgdev.pl>
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

Enable the second SerDes PHY on sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index ed76680410b4..09ae6e153282 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -448,6 +448,11 @@ &serdes0 {
 	status = "okay";
 };
 
+&serdes1 {
+	phy-supply = <&vreg_l5a>;
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32764>;
 };
-- 
2.39.2


