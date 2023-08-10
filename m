Return-Path: <netdev+bounces-26194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC79777255
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D8D1C21401
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C091E52A;
	Thu, 10 Aug 2023 08:09:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D81DDD4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:09:22 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBA9211C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso868109e87.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654960; x=1692259760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHrp6Ft5M/sZ0FkW3Vzz3FknXdyR9hhUh3bpgMqvZnE=;
        b=Xyxh0icQq0/Iiu3mr6XTjxT4dRe3aN7c6Lp4HiDYlXIvQZWJ2B6+XWpRcPcwbXySLx
         nsG0/Wj9u8lgmk8FHbPftyLcL0i3HrignsIESoV2fcByiBBz5tn3/nIa11rImFhe5sil
         j3fDxwRO0bQ2AoRPhaHMUyrGENfmcHSkvStaKUJ5JlDy594+5sF/Qequiz9piGObjf5I
         nk4iZP3LEqmYzg5odtACe+mXDkRyMuefLoogJXMD6GAhdoKQ0YL1ebQ8neCwOj4Ve954
         KKFslwAs8pWd7HGmm/GSgwCweDWFQwKlXsfDkQuR4NbBC6CtA8PIj7qKi1q4Ulav5/uq
         VjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654960; x=1692259760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHrp6Ft5M/sZ0FkW3Vzz3FknXdyR9hhUh3bpgMqvZnE=;
        b=R+7Fn32Twinyi1bA31Y2PzTP+Z+dF6eF8gEkLG2XNgSOJrOO2zVpRzQTo+slZlncdj
         DS/DXzPuXv8HnIkd8GM09ECb9r3VHoCFd5HY6cRVzItqL542wyTpGPSXYlgnzxmTO8uH
         jl11uePKJlv2kDM84P7DI4U3EMg/vWYiS5HAj1cRPMlWKcNDdWv5J3a+hYqCseUO2lLP
         QWKBqhaWMfW1Du1VRQdV7bw5lXCMHDWWGpzfeITERWQARijSLxH4J+VCxUhhEUTsG9mP
         tB3MHUzbEmStgNhxw5THbr4Gno9UQCylnSNTv4yELmyPoYp32y1+X5gTLCXwtq0u0Id0
         teVQ==
X-Gm-Message-State: AOJu0YxeEaSPQ8gUpUAOiibgI31jSqfSrPMxpva/OB5NtN+9MEylXV4x
	NPuaxXYFwid8Wp2MjVEpubFgrg==
X-Google-Smtp-Source: AGHT+IGvaGx0zd413sbvjU6gfReN+Bzz4/M2soeQRahUIP628XQwAbyZgVC/DgJ+12HmFVpdaQZqTA==
X-Received: by 2002:ac2:4f06:0:b0:4f8:7568:e94b with SMTP id k6-20020ac24f06000000b004f87568e94bmr1611776lfr.56.1691654959869;
        Thu, 10 Aug 2023 01:09:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:19 -0700 (PDT)
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
Subject: [PATCH v3 6/9] arm64: dts: qcom: sa8775p-ride: add the second SGMII PHY
Date: Thu, 10 Aug 2023 10:09:06 +0200
Message-Id: <20230810080909.6259-7-brgl@bgdev.pl>
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

Add a second SGMII PHY that will be used by EMAC1 on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index f9e1a017798e..486cb48ecb9d 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -287,6 +287,15 @@ sgmii_phy0: phy@8 {
 			reset-assert-us = <11000>;
 			reset-deassert-us = <70000>;
 		};
+
+		sgmii_phy1: phy@a {
+			compatible = "ethernet-phy-id0141.0dd4";
+			reg = <0xa>;
+			device_type = "ethernet-phy";
+			reset-gpios = <&pmm8654au_2_gpios 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
 	};
 
 	mtl_rx_setup: rx-queues-config {
-- 
2.39.2


