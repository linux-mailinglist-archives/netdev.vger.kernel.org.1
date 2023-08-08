Return-Path: <netdev+bounces-25531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 271C1774759
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C461C20F41
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011611643A;
	Tue,  8 Aug 2023 19:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EBC15AF8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:13:54 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F062127D
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 12:01:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e742a787so91925f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691521313; x=1692126113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVWCwLOI0RDSefmknyaUf7dplb4DpGR8Zf3HZcRuHo4=;
        b=1wHx9o3c4Yz2BeeZHkHGOHcZ7QmYbWaBwzImwoUkKtTdUE7gcUEqg65Ywp8TyX7ZOz
         i5YW7K5tIajPgn2Y2nLPv26Zt5GkrsAhc1YgQOe4h0Hm7GwYqDuuFsxCtAGKT4oLxv9G
         qRtwgCh0j0yOIIhnKMENx16+kM6RfrRWfH7mkiPmdKdsN006Kvl3rv4qY8OhTrZ0dXq0
         2BxlIghJlo4SaL+SKXv3kDjcVjru4ZKO+AKAsN9dZMBLcDYTGLL1RcFeUyINhPNXVQj8
         ElJVfErnmvaj+OfkjXiLtN3rb+sztKz8UvOT04xDNprnyQ9ToBZZ/klOO3UunsHY+bp7
         Sb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691521313; x=1692126113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVWCwLOI0RDSefmknyaUf7dplb4DpGR8Zf3HZcRuHo4=;
        b=GuHnXXvhXypC8fJq+gqg4VR/IF1MKXmM2pBFEbpJh2YeXpk0moB/gJMFk5ytfhtCS1
         0uC91fe0fpIfq1Jy5PK2zgRWTg/uzt+5lA8rP0jDiwqxXU89cxKjhtPutrm5oMbGz8qg
         4ZkHQLdzLYyiRnfolJ2fCP8O+fJ/o7xTIihB9me2HgCmg9A9rpUqHI8uTaMNyEbV+8Bi
         tAupOyzVPf2QeafBjFW8C8xLjiJjf1NLLlTtunfpzkYmVGo6fWzrdSp00n1pN+2wkRTS
         r6Mj0UtZO5Vy3VyJFbmpDydorFq0veXZJsgPOeXfcGEtb1OfxRZAgdvRbmfsOKYoCMYS
         +csg==
X-Gm-Message-State: AOJu0Yykxu0wt45ArH//pQnq8Sy4h/9HNiI5RgrauoyCCRftSXmXmkyn
	gOlxmLArLUTgyUhpTTVHORJ60w==
X-Google-Smtp-Source: AGHT+IHtndLWibUQVcwtqnOkWRdaTuE84A1QwcAl7MRWdOnbv6AROq7OdLzJRoheCl6qZfsNQHrHtg==
X-Received: by 2002:a5d:49c8:0:b0:315:acbc:cab6 with SMTP id t8-20020a5d49c8000000b00315acbccab6mr515129wrs.16.1691521313474;
        Tue, 08 Aug 2023 12:01:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6a08:bcc0:ae83:e1dc])
        by smtp.gmail.com with ESMTPSA id z14-20020adfe54e000000b00317e9f8f194sm7301055wrm.34.2023.08.08.12.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:01:53 -0700 (PDT)
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
Subject: [PATCH v2 1/8] arm64: dts: qcom: sa8775p: add a node for the second serdes PHY
Date: Tue,  8 Aug 2023 21:01:37 +0200
Message-Id: <20230808190144.19999-2-brgl@bgdev.pl>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the SerDes PHY used by EMAC1 on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
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


