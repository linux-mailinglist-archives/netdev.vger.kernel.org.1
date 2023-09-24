Return-Path: <netdev+bounces-36015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A757AC723
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 10:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 3479B1C20821
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1589CA54;
	Sun, 24 Sep 2023 08:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4365B
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 08:19:15 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE69AEE
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 01:19:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502a4f33440so7438111e87.1
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695543552; x=1696148352; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hHLqx//+KHKke7RxCV9Yuyp7jdtEnxin017FD+uo04=;
        b=j5sXX0y9otl1g2XHDtxW2ZZalq5xYNivaSQ8SC0z0+ojPDPmwsajQO6vg4MOyrLBXE
         J68QpllXYRSs7lE6dLGUJAZe501gxmQm3h6/kJHHGffTIxZMKlukEP5MzEV7A9Pllbm4
         YIpOvuVVgrIn7m95jBUQKLnQF0MUpG6o7Q8biARUrYs1858qE21xaGRmbi4MYi1bYGVW
         O4CLuHb0P1Q55hEbRhk+J/SMOfqXBlFUVW+Mr5k079o/5Ji92q947QwdhWftGQzUhbQQ
         AbJTizFNYQuFUaSLSVL0L3N+Je0H7wvTEq4h201tHcpBZaRY9krvunS/Y/M9Zo8I00+4
         f91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695543552; x=1696148352;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hHLqx//+KHKke7RxCV9Yuyp7jdtEnxin017FD+uo04=;
        b=Sv6vc2Jp74bX8wLT/haLrz63UAXZ4ZbIkE5lDc8FstMGPsIQMsn+4ygqlXLUvbHyMs
         voIIfubxhFvpb1uNSLfb7F91jjW1f8B7GXF/8cugA0VQMWFcsqDmqf/7mVHECXdtZK40
         ne62R9VPJGfouAH1isORvQQteC+sCTXijPYcAdmq/Lc/qwfGnVpt5dt7og0YHBa3JrLk
         Azp7MJMOQCgVPhbxK55BNe+zBWet0ackDjME72LKT4EQ1amdzT2m8Fo1pZ2OcZoZIdq+
         RBuETDQfeSNs/yv6Tw2KVfiZ1uJOkp6+dd/gjRJ6QpzArgyGPR2gwqw1lxlNw39f3Hqg
         pv5A==
X-Gm-Message-State: AOJu0YxVCasrxNsrgRgWhrR0ENFxK/R0iX/Sg/250eAcpWssZX+4pRQR
	5740wNjTNK1eA+czuqYiiI8SUQ==
X-Google-Smtp-Source: AGHT+IHGm7AQbFXuimot0EDmqmJRuWEsigBLLH9wurZI26YcE210hwvBjgQtg2QBwug/Mmho6/dcrw==
X-Received: by 2002:a05:6512:546:b0:503:2dce:4544 with SMTP id h6-20020a056512054600b005032dce4544mr2945667lfl.59.1695543551864;
        Sun, 24 Sep 2023 01:19:11 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id c19-20020a197613000000b005033948f108sm1335674lff.272.2023.09.24.01.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 01:19:11 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 24 Sep 2023 10:19:02 +0200
Subject: [PATCH net-next] net: phy: amd: Support the Altima AMI101L
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230924-ac101l-phy-v1-1-5e6349e28aa4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPXwD2UC/x3MwQpAQBRG4VfRXbt1Z5B4FVlM/LiloRmJ5N1Nl
 t/inIcigiJSmz0UcGrUzSeYPKNhcX4G65hMVmwhjS3ZDUbMyvtycy0lGiemsqgoBXvApNc/68j
 jYI/roP59P/FOBkZmAAAA
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The Altima AC101L is obviously compatible with the AMD PHY,
as seen by reading the datasheet.

Datasheet: https://docs.broadcom.com/doc/AC101L-DS05-405-RDS.pdf

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/phy/Kconfig |  4 ++--
 drivers/net/phy/amd.c   | 33 +++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 107880d13d21..421d2b62918f 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -69,9 +69,9 @@ config SFP
 comment "MII PHY device drivers"
 
 config AMD_PHY
-	tristate "AMD PHYs"
+	tristate "AMD and Altima PHYs"
 	help
-	  Currently supports the am79c874
+	  Currently supports the AMD am79c874 and Altima AC101L.
 
 config MESON_GXL_PHY
 	tristate "Amlogic Meson GXL Internal PHY"
diff --git a/drivers/net/phy/amd.c b/drivers/net/phy/amd.c
index 001bb6d8bfce..930b15fa6ce9 100644
--- a/drivers/net/phy/amd.c
+++ b/drivers/net/phy/amd.c
@@ -13,6 +13,7 @@
 #include <linux/mii.h>
 #include <linux/phy.h>
 
+#define PHY_ID_AC101L		0x00225520
 #define PHY_ID_AM79C874		0x0022561b
 
 #define MII_AM79C_IR		17	/* Interrupt Status/Control Register */
@@ -87,19 +88,31 @@ static irqreturn_t am79c_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static struct phy_driver am79c_driver[] = { {
-	.phy_id		= PHY_ID_AM79C874,
-	.name		= "AM79C874",
-	.phy_id_mask	= 0xfffffff0,
-	/* PHY_BASIC_FEATURES */
-	.config_init	= am79c_config_init,
-	.config_intr	= am79c_config_intr,
-	.handle_interrupt = am79c_handle_interrupt,
-} };
+static struct phy_driver am79c_drivers[] = {
+	{
+		.phy_id		= PHY_ID_AM79C874,
+		.name		= "AM79C874",
+		.phy_id_mask	= 0xfffffff0,
+		/* PHY_BASIC_FEATURES */
+		.config_init	= am79c_config_init,
+		.config_intr	= am79c_config_intr,
+		.handle_interrupt = am79c_handle_interrupt,
+	},
+	{
+		.phy_id		= PHY_ID_AC101L,
+		.name		= "AC101L",
+		.phy_id_mask	= 0xfffffff0,
+		/* PHY_BASIC_FEATURES */
+		.config_init	= am79c_config_init,
+		.config_intr	= am79c_config_intr,
+		.handle_interrupt = am79c_handle_interrupt,
+	},
+};
 
-module_phy_driver(am79c_driver);
+module_phy_driver(am79c_drivers);
 
 static struct mdio_device_id __maybe_unused amd_tbl[] = {
+	{ PHY_ID_AC101L, 0xfffffff0 },
 	{ PHY_ID_AM79C874, 0xfffffff0 },
 	{ }
 };

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230924-ac101l-phy-704e9a0152e5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


