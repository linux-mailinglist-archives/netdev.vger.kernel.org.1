Return-Path: <netdev+bounces-25093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C78772EE1
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558AB1C20D1F
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FEC16435;
	Mon,  7 Aug 2023 19:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972D1641E
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:35:24 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC911717
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:35:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so22897745e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436922; x=1692041722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPPAITnbHpLfLDmJySJco6dXqEzZhAIXMSVGP9xkG5c=;
        b=LZUM+utIDiGPi1xiYzGnVUrRE3JD6gHk+30APuYmhtNMPSSmObsmOtbItrpQNOUN4t
         zPNRHnd/puwUeyY8unq1z7weAe9GtY/5yrcmoPS+hB8xwUb1JmqYBGOzMk2hykf43FV/
         JhknVj5AStv2OENppgyTANVXuWUsC2bvnRFSG1x6OgEG1ByNZBS+kCGEMETLhsbomQZM
         UISYg4NWmRR6dc3GjwO15BzSebHDnO1UkuYxttotBSkOksk5um5Xi9vpIcI+OVDAYNQs
         e2aFmuv1l+CEl8miLYyIDslzQJZnpgFqV4zJsfbH2s+E/LJGrmR9lPrvVbAO7TmwxSQY
         pGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436922; x=1692041722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPPAITnbHpLfLDmJySJco6dXqEzZhAIXMSVGP9xkG5c=;
        b=dpxJEU5mjQj4YPKBPShgRp34Uoe5WHtNcCMA2IanmInhaMo6oQJG7Axzq8qVePjidc
         7O7SL4mnWYTy55IwPZ8Pm4knZPiC8y/OFeV0ZFwEa5A7KO+7aEDxa3cfakTsin15tZ8o
         zQNE5BEIrDrp+BpNQvnz5M8lg5erXGzeJMS8avLsxZM9wKUQHPCJVaJntTL2Wu4anQ0N
         gmTDryld3t1wYyvyVvBo9asMpM4UKd9yFFB8bBFrj5Tis/E8AKOORv6Jq/DLoNhHTZeT
         3szeNdjcAUudiKTXcZq35RNWfIIkR0gbB8RxcPZtkKvJFd7VNHqCku9P2m3nWYt/0nRM
         TQ1g==
X-Gm-Message-State: AOJu0Yz1OqrsuQfLFbyK99EjgXhUYhZ26oOd8lk6up0Ph/M0buZOs2uK
	bGR92Zzfjjv65dJIrUEHQB4Mqw==
X-Google-Smtp-Source: AGHT+IFZBRammuhICZdtkXlyPRUK42qVBcukcnqsd5LnVIL+qxwyxBJJMFPvA2T0zkK5l6u8AsitCg==
X-Received: by 2002:adf:cc8f:0:b0:314:1f1e:3a85 with SMTP id p15-20020adfcc8f000000b003141f1e3a85mr5993739wrj.61.1691436921811;
        Mon, 07 Aug 2023 12:35:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:21 -0700 (PDT)
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
Subject: [PATCH 3/9] arm64: dts: qcom: sa8775p-ride: enable the second SerDes PHY
Date: Mon,  7 Aug 2023 21:35:01 +0200
Message-Id: <20230807193507.6488-4-brgl@bgdev.pl>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the second SerDes PHY on sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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


