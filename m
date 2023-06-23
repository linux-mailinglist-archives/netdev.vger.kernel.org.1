Return-Path: <netdev+bounces-13560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F9573C053
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810B11C20ADC
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3581111AD;
	Fri, 23 Jun 2023 20:39:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5611C80
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 20:39:19 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F130C6;
	Fri, 23 Jun 2023 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687552728; x=1719088728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvnR65uyKMk5CUoToEoiuPKzluNwCII060FV6LYqd6M=;
  b=RYnhptDshMMsZd4/PLsPgGBG4dI8hSWKfH3vdAmNOtKTQZX6P97xH2Fv
   3OdbWKaUJyRhzjKgIqsgxQ2i7UkBhoU4HSxQIC9IMMT66yFoxufdWsI6g
   hL0qgFB0emP+fN/qehLoiJENwHmJ8F/rGnCXAF8jTn30+rS5HR3Z+Nf2H
   FqV9Zy58aMwqkc+qwVK+Ddys3APAkiV93dywntJUWhbIzHtF9pW5YaH8V
   K1zDqFPCFO8fvGSEQ0hs8Dd07jBLdMU6CQzlqItdLyrP3hIvcWQ9dzgmn
   f5+QJffHAERiWurcgktZYgokgEuefLz8FgJrtS+LWQK02QHEn1jwoXw8T
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="158362329"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2023 13:37:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 13:37:48 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 23 Jun 2023 13:37:21 -0700
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
Subject: [PATCH v2 13/45] dt-bindings: atmel-sysreg: add bindings for sam9x7
Date: Sat, 24 Jun 2023 02:00:24 +0530
Message-ID: <20230623203056.689705-14-varshini.rajendran@microchip.com>
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

Add RAM controller, shutdown controller & SFR DT bindings.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index ab1b352344ae..1e7349987d77 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -11,7 +11,7 @@ PIT Timer required properties:
   shared across all System Controller members.
 
 PIT64B Timer required properties:
-- compatible: Should be "microchip,sam9x60-pit64b"
+- compatible: Should be "microchip,sam9x60-pit64b" or "microchip,sam9x7-pit64b"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for PIT64B timer
 - clocks: Should contain the available clock sources for PIT64B timer.
@@ -31,6 +31,7 @@ RAMC SDRAM/DDR Controller required properties:
 			"atmel,at91sam9g45-ddramc",
 			"atmel,sama5d3-ddramc",
 			"microchip,sam9x60-ddramc",
+			"microchip,sam9x7-ddramc",
 			"microchip,sama7g5-uddrc"
 - reg: Should contain registers location and length
 
@@ -89,7 +90,7 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
 
 required properties:
 - compatible: should be "atmel,sama5d2-shdwc", "microchip,sam9x60-shdwc" or
-  "microchip,sama7g5-shdwc"
+  "microchip,sama7g5-shdwc" or "microchip,sam9x7-shdwc"
 - reg: should contain registers location and length
 - clocks: phandle to input clock.
 - #address-cells: should be one. The cell is the wake-up input index.
@@ -156,7 +157,7 @@ required properties:
 - compatible: Should be "atmel,<chip>-sfr", "syscon" or
 	"atmel,<chip>-sfrbu", "syscon"
   <chip> can be "sama5d3", "sama5d4" or "sama5d2".
-  It also can be "microchip,sam9x60-sfr", "syscon".
+  It also can be "microchip,sam9x60-sfr" or "microchip,sam9x7-sfr", "syscon".
 - reg: Should contain registers location and length
 
 	sfr@f0038000 {
-- 
2.25.1


