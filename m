Return-Path: <netdev+bounces-25533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17F774770
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F4E281694
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3FA168CF;
	Tue,  8 Aug 2023 19:13:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F508168BE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:13:56 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C6521797
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 12:01:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-313e742a787so91944f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691521315; x=1692126115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d53EJjFlLE6Vxh8rngWYlz+t9p6FK75e/MN7XlFoNvQ=;
        b=0mQ0RfHRO+1lGkEC4ULzUiM+kikaqEOjK+ShXWBesckmHuUXhxzIJBz1fxXjqyLDQT
         GGrbC09X0pk84cmVVQMIxX6g3fXU4ulMug6SwMwWgKtOExqT03adQB/j4r/+XwHpC5Dy
         Pxd41d42eCl+mKXxhXnrhW4uOITiFPu00wnkkPej10l5t5e4z5rXw/o3BcgLLDJ9zQwC
         HB/+CgBAqOaHcVDmKmFgNR0tSmlDcMey8w5tb9MuR9eg+oLdaI23s6gVb/cMkvV/n/4B
         bvmtSK8ZgBmAz7x8asFB/1SXrMyViYCYLi1m/wNAKHgSPjY7tcUXUEeO3J7hnpZHzH5U
         lzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691521315; x=1692126115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d53EJjFlLE6Vxh8rngWYlz+t9p6FK75e/MN7XlFoNvQ=;
        b=c+aEMJbb9u5wtQW15LJWlwkirRfkXwJmIh3H9LgjJ4rPvp8UPRwtIrbJOytElx8ORz
         FIsRY8hDhQeDaIwFLmMx2RwhdUIIVwbiyZXJcJd51oxhkxCT0E+PFP/pA/GpM4Oq3054
         +N8+iTU5LjMI5MZML4Qszdcu0mmWxlJFh6RYS8SF3gyU8G0jUY0SdlAuXsXM0eNmucGB
         BaRmQqTG5y4nrxZBCpGQT2cCUJzQpO+khHp56AyfzY1aAxkfjH6nJb1a0ZOWbsFMZwDI
         iOHNAy4GOMLmDyIQqnksQiJKQE8eb/cfnY3Ej/UpA/FNRS/YjN+d3Qsb/Nz1THHBpGPL
         oK8g==
X-Gm-Message-State: AOJu0YzdzrpJXuO5g6Y11GHXQq468m4vOR7Fcr/0cKO2qYxDSWjvCsBd
	uTCdq0w9b1U71OCS9lwEtMtBAA==
X-Google-Smtp-Source: AGHT+IFWnNZIQE2PU/Slv7+JXexxG+sPvEaCIjrbyb56uRSRja0OiEpq4PkjM/6HDxE36i0dUfAoUQ==
X-Received: by 2002:a5d:6ac5:0:b0:317:6570:afec with SMTP id u5-20020a5d6ac5000000b003176570afecmr9124359wrw.3.1691521315696;
        Tue, 08 Aug 2023 12:01:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6a08:bcc0:ae83:e1dc])
        by smtp.gmail.com with ESMTPSA id z14-20020adfe54e000000b00317e9f8f194sm7301055wrm.34.2023.08.08.12.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:01:55 -0700 (PDT)
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
Subject: [PATCH v2 3/8] arm64: dts: qcom: sa8775p-ride: enable the second SerDes PHY
Date: Tue,  8 Aug 2023 21:01:39 +0200
Message-Id: <20230808190144.19999-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808190144.19999-1-brgl@bgdev.pl>
References: <20230808190144.19999-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the second SerDes PHY on sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
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


