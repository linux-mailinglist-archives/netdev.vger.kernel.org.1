Return-Path: <netdev+bounces-13039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF8173A075
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904EB1C210C3
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D241E511;
	Thu, 22 Jun 2023 12:02:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4921E505
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:02:22 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E41FF0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:02:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa71e253f2so5652405e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687435315; x=1690027315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVlJCvybdeYjvv8ryzmcQEkNwtr78sKz5e8xX8tuWYs=;
        b=C8BowXKmNG6ia2Wm3UtQT/5cWilxo2PodO7vNltAYIv52xh7T8IDrvCpJLHhLuw8Gl
         8qgtNfK3Rx3OZ9ggP2XkDDrJzmwbJpE/IPMx6mvtrCkQQDJg7m/AFmu4VgUb3/vHDCwO
         m0VVA3PnOWbZqSvStMGdItjm7lVYHVz5TPCDolF7MIED5mXRUn7VHgiXHYKzUwX8zN81
         TjKxoObpL0gtfkBwC4ffzWpyU87onzD3xwUcqQL5HW3hqM2chihrSGRl5Xe+nYIei4NX
         seYiC8DOGWFzTt5tNKY+bTHm6LnuP5vRVArtFdKT9oY+2fo3ttcsMxd2Hw4wSZiEl0IG
         Gn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435315; x=1690027315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVlJCvybdeYjvv8ryzmcQEkNwtr78sKz5e8xX8tuWYs=;
        b=RZe/Mx7Ko4gXtsAKYUn8ixSDlsObMPkTTP4OKNmPf29aKeSaiOrieZ28RLfCNFfydZ
         bYfuY0f/m/aZJRDcxc+s4wmgE/KmpxeFyO9+c9YP2Cj/65MWNZA5X/X3czyohfh4OizJ
         /DioQqRPNvnujUwWdRLpyYysqNUy+uqgSyfGoFOsWU8N9FmjvlQ5QGu0nPbHevzHopTK
         EB0c4MjF1HZfdelndKxzS2umqoDYZIf5AGoPAUWWUkoi3vkS4d/EPbxZTckGoVKqL8ce
         +ZjHYNXYYOI8kuF8y+OPxnUSRZpTVJdcGqhmwrOOG94xyZKZYmxvJpaDJVZ9+avmrrmj
         RLvQ==
X-Gm-Message-State: AC+VfDzwyRj3A6y3ndAhkyehbznfAxMlKjsQHfuOwhRsJpfFLbGWC/2a
	3yMTWFftusriqfTfhSMlPdU+hA==
X-Google-Smtp-Source: ACHHUZ6g2/qEcVS4UCzFHdCuPd1cab6E0b6lt6uXUOmWx9zVx49N7XM28BkCdrJ23x/f4uyw3i0m9g==
X-Received: by 2002:a05:600c:4f96:b0:3f7:f302:161 with SMTP id n22-20020a05600c4f9600b003f7f3020161mr22362886wmq.8.1687435314389;
        Thu, 22 Jun 2023 05:01:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d785:af3e:3bf5:7f36])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003f8ec58995fsm7594296wmo.6.2023.06.22.05.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:01:54 -0700 (PDT)
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
Subject: [RESEND PATCH v2 3/5] arm64: dts: qcom: sa8775p-ride: enable the SerDes PHY
Date: Thu, 22 Jun 2023 14:01:40 +0200
Message-Id: <20230622120142.218055-4-brgl@bgdev.pl>
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

Enable the internal PHY on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index ab767cfa51ff..9f39ab59c283 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -355,6 +355,11 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32764>;
 };
-- 
2.39.2


