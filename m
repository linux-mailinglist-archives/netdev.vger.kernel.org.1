Return-Path: <netdev+bounces-25099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96590772EED
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F19328155A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDB4171A5;
	Mon,  7 Aug 2023 19:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834ED171A4
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:35:30 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA77199D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:35:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so41422915e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436926; x=1692041726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXijTi+fw045QoNdeTPxW/V/zvFWSaYckmdhiKlT43Y=;
        b=nQ0YhXdb0Gawik4S9oNhaFX3oFYmErvHsSkJFLP4KU4VfeCfxmYtbYzk46J+VCJ9rs
         phVvTd5F56QVrMItRcUY4cSYy3uY7lbYLlvGnlDxWggRnlUf6G59ZmpuwaTv8dkIRlGi
         EH+F1UO4x/KPac4o4iRSt7KzkU2ajTL87j5lJoLmlfN4ye0edqP1+0EznYlqeUhzFz2r
         KdEQ1Ouvm6FAUMFNCpyrPex/7iUW4K6H9twoKUrmpEZbVtaAWE5CzcIKbTx3PUN6fIcu
         DsfeWJ7dI2U2YzA2HseiDQZ8jX1VrcbhH8z3zke5vBxBlNDQgzlwTUnxE+RMIMm/rWes
         RzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436926; x=1692041726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXijTi+fw045QoNdeTPxW/V/zvFWSaYckmdhiKlT43Y=;
        b=KAr+C/9ck2W0gFyi/qIn1z7Y3oBistMBStFnJjn3mFixyFibloqMQVQGweYtKM/G65
         IgBoGzqYsSDeFXmkIJuNjXgwKxOJI1rEbNke5MUevontN4oONUJaw1dKWFj6HeLD0+G3
         ohv6EWhXj358d1gkiz5/kLCMcRryh0bCKrB7aU6J5HaISBuaZ0QUgvSmJc/HCLy/6hIQ
         pwZRUDaET1Ga/4CCC0n/uo31O0w81yxg2t44vBOwRGvfUuBt20nBB86AD2HKiNnpQ+pV
         JWaR3nybpkagZhXmznBnxAw3ImjeqWSzthrQnKbpPdxEbPA5uhwzxHBHvf0ADj74yBNB
         52ig==
X-Gm-Message-State: AOJu0YzjmwB8SoMaxDAJDPSAEG9tnaHVevOM/MEwhIpOOyL+UQs5lpNx
	+fGEGpBa2y0uZuA1bCNVcB9aYw==
X-Google-Smtp-Source: AGHT+IHOIrVMzqjzWgyRU91RS5tj42hdUhLwDTcRhbiSO0SO8qH18LzXTR/OlH1mLyIbwlbCIWzcNQ==
X-Received: by 2002:a05:600c:ad8:b0:3fe:1d4c:d5e5 with SMTP id c24-20020a05600c0ad800b003fe1d4cd5e5mr6693813wmr.18.1691436926827;
        Mon, 07 Aug 2023 12:35:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:26 -0700 (PDT)
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
Subject: [PATCH 8/9] arm64: dts: qcom: sa8775p-ride: label the mdio node
Date: Mon,  7 Aug 2023 21:35:06 +0200
Message-Id: <20230807193507.6488-9-brgl@bgdev.pl>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a label to the MDIO node on ethernet0 so that we can reference it
from the ethernet1's node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 5b48066f312a..af50aa2d9b10 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -274,7 +274,7 @@ &ethernet0 {
 
 	status = "okay";
 
-	mdio {
+	mdio0: mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.39.2


