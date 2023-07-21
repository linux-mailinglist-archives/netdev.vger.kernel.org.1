Return-Path: <netdev+bounces-19827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BC775C85A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DEA1C216BA
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833E11EA8A;
	Fri, 21 Jul 2023 13:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788031EA77
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:50:28 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C750130EA
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:50:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so17336575e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947419; x=1690552219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRBYGxiJV+fUO8L5x5OkCA3grJdrnxlxanjlGq4MKP4=;
        b=X/b4lfScvLyO50oKagC+JEFYqdE8/h/2h/kB633hueE2yocwWU1uR7k887yaktJC0P
         N/diOKoYfnh1vTgtHytcXoF9fRLm1Ug8stz8oznWSd/Ho8d0E97HtQzZIAGe44lP1h8m
         TYktfCtqjSidnkGcASViXJnDGwKUFJIyP1fGyt7xHIKkGMoFjY8Yw2OrS8XDQwMDFPUJ
         YSHCN0hUU9JZ11XvrY0GhQe2wp1RiPlg4ONWI50U1hxbGTPEyqtFE+AwHQxn+5zV+K1Z
         QozEK7YynhD8V0RLAkXxBueGLC9fAp+Zsv2dwO0dd/cHoMJZLI9z/QUq/v2ulF79xeXY
         gMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947419; x=1690552219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRBYGxiJV+fUO8L5x5OkCA3grJdrnxlxanjlGq4MKP4=;
        b=KZx+ab+UiCfGuFntP/8n96BY0TdlwNKTi1gOiAn15vg6cbOnCvLLq156ZKfgMp1lts
         LmDjqM3ebDpCis31jZASjnk1Rk6iIq4i6qnO0VZ976P9se88UtIQEw1cCswSVmB3OlSk
         Kgrmch4qmVTkQMprJ4oCipKOR583l1dF7E34k/jTwWS60vMECWB2HxKl4pUFYYoh8boJ
         ZbYLjmUACRx5CBz+62wUSw69qAzXHc0w+wm/mc2d92jPxDdYvdNXPNQm3h453awNDVM0
         FnKrsLrHnVvOo3kiL4cTBRvwrnClkfIwRlNPKXUCBXWQnrsHRCuHnxw1lHlVUY46D8zG
         ncWg==
X-Gm-Message-State: ABy/qLZvff1ziOAGf1Inm1Z+3uRk8NL0w3+D9OIVHPhMAyeAm/ejwXi7
	edqFwfoFAt4zrIH65K29TKWaZA==
X-Google-Smtp-Source: APBJJlFgG2WeFkm/yf/wlFlPZiCNsdoffBh//BtztWnERSfUFPNj2OMuWQPhdMMl7iGF3Y9DuEJvtA==
X-Received: by 2002:a05:600c:20c4:b0:3f4:d18f:b2fb with SMTP id y4-20020a05600c20c400b003f4d18fb2fbmr1623924wmm.8.1689947419766;
        Fri, 21 Jul 2023 06:50:19 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:19 -0700 (PDT)
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
Subject: [PATCH v3 6/6] can: tcan4x5x: Add error messages in probe
Date: Fri, 21 Jul 2023 15:50:09 +0200
Message-Id: <20230721135009.1120562-7-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721135009.1120562-1-msp@baylibre.com>
References: <20230721135009.1120562-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To be able to understand issues during probe easier, add error messages
if something fails.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2d329b4e4f52..60380b50e553 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -402,6 +402,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	/* Sanity check */
 	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF) {
+		dev_err(&spi->dev, "Clock frequency is out of supported range %d\n",
+			freq);
 		ret = -ERANGE;
 		goto out_m_can_class_free_dev;
 	}
@@ -420,16 +422,22 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
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
 
 	version_info = tcan4x5x_find_version(priv);
 	if (IS_ERR(version_info)) {
@@ -438,16 +446,22 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	}
 
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


