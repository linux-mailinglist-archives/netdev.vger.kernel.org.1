Return-Path: <netdev+bounces-12524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF59A737F08
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A728158B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438DFC0C;
	Wed, 21 Jun 2023 09:31:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89367FBEC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:31:19 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AFC19B5
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f900cd3f96so44918895e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339876; x=1689931876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCNYj/86/5sdpI0dqVl7psoKKhFSLSkxZDdeHiB+vfs=;
        b=zKBvUDeuh/AFGKGg1KW0cPS/Z+YJwgyTetO5WMcCNXlsdpA6DjdA+JCVw45yfuzOQ7
         +ggePlPV3BBZnFVirubbyFlazU9n8ZAQj0zkNJ/DD+8+2atf/UTfto6Um/z+4M4Zq6B9
         EjBubPtKj/umzTqO5cGA7NrHohxZE4BCTl1MBpXkc8BnPRZwr9YUtV/s4CYuyxjCbokc
         P5vyN9h0L5kRalzYsd99rB177VmsDdNE8fI4EFcRb8+b6tJOlJ8DZiTvy3pnH0pRaWcZ
         tHRdrkMTSwHYtYfyih96fQ+/L8iuf0mZH0mZ5GaI7ysumftvk8TaZMPd5kO9ke+Ysz0U
         X8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339876; x=1689931876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCNYj/86/5sdpI0dqVl7psoKKhFSLSkxZDdeHiB+vfs=;
        b=BOQICw4iiATEmnokc17oeU63Em0tyolNeYIDwjo90ARNwOD9dAHj6T4C34e/XHlI9u
         IO+YJIa5Ml6p3ZGAaqTARbkDFqX2CTQk/pFUxqysYERLbDqT5nvod19euA9Uaqo6F2Nr
         PT2N+aFOjOl7KO73Fjyo6lCg25+PXpKcifDzFc7MF4v7kGt8DVaXbfbMDqbEgTR6ve45
         0Tt/GdisYmDTUWXvotQ/NziBWT+HEvou/eVXEMTIWv4NTCgwr56/CIySoUUk/ylVarwu
         oW9lOV57Z2ULMPozRKStaErj92zD4FknINhkwYSG6OjuHWaYTMDxM7dmE+oDIB4eb9uM
         X0Gg==
X-Gm-Message-State: AC+VfDyvBcL6lZVcWEjcx2z7rW+71OasYKUZLD4o+AGaiK94gh7CQa9+
	zYGNRfnx6mbUfKBwLNQxwMJn4Q==
X-Google-Smtp-Source: ACHHUZ7UtUgNUTqAfGOg4L/0CMP4+0xc+qarTvVyytZqEa5kddJf6P2sJTX0FK96SnjlHw6+Bk3Cpg==
X-Received: by 2002:a05:600c:248:b0:3f9:b3b4:4367 with SMTP id 8-20020a05600c024800b003f9b3b44367mr5036089wmj.15.1687339875812;
        Wed, 21 Jun 2023 02:31:15 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:15 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 6/6] can: tcan4x5x: Add error messages in probe
Date: Wed, 21 Jun 2023 11:31:03 +0200
Message-Id: <20230621093103.3134655-7-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621093103.3134655-1-msp@baylibre.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To be able to understand issues during probe easier, add error messages
if something fails.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 756acd122075..e30faa1cf893 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -397,6 +397,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	/* Sanity check */
 	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF) {
+		dev_err(&spi->dev, "Clock frequency is out of supported range %d\n",
+			freq);
 		ret = -ERANGE;
 		goto out_m_can_class_free_dev;
 	}
@@ -415,32 +417,44 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	/* Configure the SPI bus */
 	spi->bits_per_word = 8;
 	ret = spi_setup(spi);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "SPI setup failed %d\n", ret);
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_regmap_init(priv);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "regmap init failed %d\n", ret);
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_power_enable(priv->power, 1);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Enabling regulator failed %d\n", ret);
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_verify_version(priv, &version_info);
 	if (ret)
 		goto out_power;
 
 	ret = tcan4x5x_get_gpios(mcan_class, version_info);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %d\n", ret);
 		goto out_power;
+	}
 
 	ret = tcan4x5x_init(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "tcan initialization failed %d\n", ret);
 		goto out_power;
+	}
 
 	ret = m_can_class_register(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Failed registering m_can device %d\n", ret);
 		goto out_power;
+	}
 
 	netdev_info(mcan_class->net, "TCAN4X5X successfully initialized.\n");
 	return 0;
-- 
2.40.1


