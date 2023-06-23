Return-Path: <netdev+bounces-13552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A715973BFFE
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6561C281D62
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33681094C;
	Fri, 23 Jun 2023 20:35:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A64111A0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 20:35:39 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379B130C6;
	Fri, 23 Jun 2023 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687552511; x=1719088511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1QGyJHdsdEC9quDqT4s3WD8JMv5A9Y0t0yBquA/F1eg=;
  b=FtE6K6XCuoT7QPAg7ABdDtOVzcCG4+qAUxk1+kyTtyghY4UQZ++TslFg
   yYKMwqP9EqJaxi91MHa/LWeYABR4Nabxi8/pkLoyLQuybtDWpYsOlsL2w
   hiq0VmpvuPfM6wgfbtN5jcVkS+3KpwwHH16+szeH2W3g/xv0TwtHnqWUv
   gEoR57ZA4upscAKGjBMMdSvotidhTdx2IkzBoKhOg6zI2W451anGWZUpr
   GfP8lC+1El9v2n+Qog2qTdGr2KRst72c/gWRxYAA1qOGoeeUzcVyars3U
   EK35ZP4DR3RxH/0rr1y+TFU/UQTmljXXZ9HMSGBPTXy9wq5IF6cJlHffX
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="217418437"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2023 13:35:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 13:34:56 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 23 Jun 2023 13:34:28 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <vkoul@kernel.org>, <tglx@linutronix.de>,
	<maz@kernel.org>, <lee@kernel.org>, <ulf.hansson@linaro.org>,
	<tudor.ambarus@linaro.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
	<olivia@selenic.com>, <a.zummo@towertech.it>, <radu_nicolae.pirea@upb.ro>,
	<richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>, <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
	<linux@armlinux.org.uk>, <sre@kernel.org>, <jerry.ray@microchip.com>,
	<horatiu.vultur@microchip.com>, <durai.manickamkr@microchip.com>,
	<varshini.rajendran@microchip.com>, <andrew@lunn.ch>,
	<alain.volmat@foss.st.com>, <neil.armstrong@linaro.org>,
	<mihai.sain@microchip.com>, <eugen.hristev@collabora.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-usb@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: <Hari.PrasathGE@microchip.com>, <cristian.birsan@microchip.com>,
	<balamanikandan.gunasundar@microchip.com>, <manikandan.m@microchip.com>,
	<dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
	<balakrishnan.s@microchip.com>
Subject: [PATCH v2 07/45] ARM: at91: add support in SoC driver for new sam9x7
Date: Sat, 24 Jun 2023 02:00:18 +0530
Message-ID: <20230623203056.689705-8-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623203056.689705-1-varshini.rajendran@microchip.com>
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for SAM9X7 SoC in the SoC driver.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/soc/atmel/soc.c | 23 +++++++++++++++++++++++
 drivers/soc/atmel/soc.h |  9 +++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index cc9a3e107479..cae3452cbc60 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -101,6 +101,29 @@ static const struct at91_soc socs[] __initconst = {
 		 AT91_CIDR_VERSION_MASK, SAM9X60_D6K_EXID_MATCH,
 		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
 #endif
+#ifdef CONFIG_SOC_SAM9X7
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X72_EXID_MATCH,
+		 "sam9x72", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X70_EXID_MATCH,
+		 "sam9x70", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1G_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 1Gb DDR3L SiP ", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 512Mb DDR2 SiP", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 128Mb DDR2 SiP", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 2Gb DDR3L SiP", "sam9x7"),
+#endif
 #ifdef CONFIG_SOC_SAMA5
 	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK, SAMA5D21CU_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 7a9f47ce85fb..26dd26b4f179 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -45,6 +45,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
 #define SAM9X60_CIDR_MATCH		0x019b35a0
 #define SAMA7G5_CIDR_MATCH		0x00162100
+#define SAM9X7_CIDR_MATCH		0x09750020
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
 #define AT91SAM9M10_EXID_MATCH		0x00000002
@@ -74,6 +75,14 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA7G54_D2G_EXID_MATCH		0x00000020
 #define SAMA7G54_D4G_EXID_MATCH		0x00000028
 
+#define SAM9X75_EXID_MATCH		0x00000000
+#define SAM9X72_EXID_MATCH		0x00000004
+#define SAM9X70_EXID_MATCH		0x00000005
+#define SAM9X75_D1G_EXID_MATCH		0x00000001
+#define SAM9X75_D5M_EXID_MATCH		0x00000002
+#define SAM9X75_D1M_EXID_MATCH		0x00000003
+#define SAM9X75_D2G_EXID_MATCH		0x00000006
+
 #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
 #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
 #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
-- 
2.25.1


