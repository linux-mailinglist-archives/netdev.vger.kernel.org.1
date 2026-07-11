Return-Path: <netdev+bounces-306767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LN+WATf7UWoyLAMAu9opvQ
	(envelope-from <netdev+bounces-306767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:13:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69440740DDC
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:13:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pigmoral.tech header.s=zmail header.b=po3bRHUv;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306767-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306767-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E5530027E1
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3427383338;
	Sat, 11 Jul 2026 08:13:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C133F597;
	Sat, 11 Jul 2026 08:13:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783757617; cv=pass; b=a9CGDJjt6h9tJYBsfE4K6f7WdoYpPdkXslLt6zoDvIZjQTW7b+OWJqA1oVcVtCM358G4f+qzsORe3Ch4YDP/2x0+ngH49Uog8/O1avT+rKhj5/eNXDyHG7X+PnnsXU8qYzYRK7+Jaqz79cmvS2ExzoajSg1IAy4I6XK16AbJP20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783757617; c=relaxed/simple;
	bh=2nbAp5wgLvB3GVbm/bh5SLh3tvImZ6mCw5JMPh8KgPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7IMai1jmwYxomve6KrikaHrNyEwP19Ov+6Uge8DNFsRhYU7QW6dItzb4azV9HJHfWpbJZGCCHAreJoJW1QJHxyXacHXzVdeQk/VirxrVO+CAm0Gbh/aNKn+M3e/DT/iL+96rh9HEDpT8SUohvB4ZBTnHMCraIUGlqvcjXKzpkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=po3bRHUv; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal: i=1; a=rsa-sha256; t=1783757574; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B86tUVUVurn1RROWNOeRi7HDvHZ+NJPXU18H7kAni6XpkuIMPi7sfCj+suIFXBo7Z6DIZXffawpGkrwrLnu0mSoEviWZ9krlwW3CurYJYW6V7XOsScUSylzTpC08eo1XnJ9BVIzYi1xE5+OUFhkEEMWVdfr1bkL3B/kpcCN2duE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783757574; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WGl7teXPgThhyd7Mnm7ajod1+36ftebilIYFXIlgL0M=; 
	b=Eg3Hr7LpcmlWcz1DAEd2GDnyi1R3b5xZzH6iZ85WDmpLmK4Sf3/+lQcoD+WfbHhYOa10O110Z8b0c4WSYyRs51TQ/LKtgsfJ6X+A7ZahSL6wuQ25gaoeM7BhZ/wSRnKhGX6XAnCsRFbVuQCieim3Ca69hLI5eNYGiCOY+Rzlk7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783757574;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=WGl7teXPgThhyd7Mnm7ajod1+36ftebilIYFXIlgL0M=;
	b=po3bRHUv6o0xx84bNe5QIus8JM8sM98N3FhxR24HZ2aaqDE2v728A+Om4IP5q+H+
	pxSp4eSqPeGr5eybdYGnPMqpAoCtMouscJA0LNCeoTD1fyO5l/hhIPkR21B+oIXEGxc
	w0T6nu4IpdiyOBppUdK3qpczDt9PjpRAetjWWNx0=
Received: by mx.zohomail.com with SMTPS id 1783757571732200.7153726655515;
	Sat, 11 Jul 2026 01:12:51 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 11 Jul 2026 16:10:34 +0800
Subject: [PATCH v2 8/8] clk: sunxi-ng: a733: Add reset lines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-a733-clk-v2-8-974d188cbe0c@pigmoral.tech>
References: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
In-Reply-To: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783757449; l=6917;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=2nbAp5wgLvB3GVbm/bh5SLh3tvImZ6mCw5JMPh8KgPQ=;
 b=hEKIEUQ7/k4zgY9aOi6OTBUpFGX7wJsm0EGyQFA9u7IbtBfkXDW5bXNeraYVJdCjsVLutevno
 ZWU7DKBnd1ZDHpJsZrNYTQVsK4+Fyr9uuWAWUw6QUiUEaC0PrIq7q9+
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:junhui.liu@pigmoral.tech,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:jbrunet@baylibre.com,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[pigmoral.tech];
	FORGED_SENDER(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,sholland.org,pengutronix.de,pigmoral.tech,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[pigmoral.tech:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306767-lists,netdev=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,pigmoral.tech:from_mime,pigmoral.tech:email,pigmoral.tech:mid,pigmoral.tech:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69440740DDC

Add the reset lines for the Allwinner A733 SoC. These reset control bits
are integrated into the Bus Gate Reset (BGR) registers, typically
sharing the same register address with their corresponding bus clock
gates. Integrate them into the main CCU driver using the existing
sunxi-ng ccu_reset framework, allowing the CCU to also function as a
reset controller for the SoC.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 126 +++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
index 48d7c0395ae8..ff64c35206d2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -17,6 +17,7 @@
 #include "../clk.h"
 
 #include "ccu_common.h"
+#include "ccu_reset.h"
 
 #include "ccu_div.h"
 #include "ccu_gate.h"
@@ -2156,11 +2157,136 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 	.num	= CLK_FANOUT3 + 1,
 };
 
+static struct ccu_reset_map sun60i_a733_ccu_resets[] = {
+	[RST_BUS_ITS_PCIE0]		= { 0x574, BIT(16) },
+	[RST_BUS_IOMMU0_SYS]		= { 0x58c, BIT(16) },
+	[RST_BUS_MSI_LITE0_AHB]		= { 0x594, BIT(16) },
+	[RST_BUS_MSI_LITE0_MBUS]	= { 0x594, BIT(17) },
+	[RST_BUS_MSI_LITE1_AHB]		= { 0x59c, BIT(16) },
+	[RST_BUS_MSI_LITE1_MBUS]	= { 0x59c, BIT(17) },
+	[RST_BUS_MSI_LITE2_AHB]		= { 0x5a4, BIT(16) },
+	[RST_BUS_MSI_LITE2_MBUS]	= { 0x5a4, BIT(17) },
+	[RST_BUS_IOMMU1_SYS]		= { 0x5b4, BIT(16) },
+	[RST_BUS_DMA0]			= { 0x704, BIT(16) },
+	[RST_BUS_DMA1]			= { 0x70c, BIT(16) },
+	[RST_BUS_SPINLOCK]		= { 0x724, BIT(16) },
+	[RST_BUS_MSGBOX]		= { 0x744, BIT(16) },
+	[RST_BUS_PWM0]			= { 0x784, BIT(16) },
+	[RST_BUS_PWM1]			= { 0x78c, BIT(16) },
+	[RST_BUS_DBG]			= { 0x7a4, BIT(16) },
+	[RST_BUS_SYSDAP]		= { 0x7ac, BIT(16) },
+	[RST_BUS_TIMER0]		= { 0x850, BIT(16) },
+	[RST_BUS_DE0]			= { 0xa04, BIT(16) },
+	[RST_BUS_DI]			= { 0xa24, BIT(16) },
+	[RST_BUS_G2D]			= { 0xa44, BIT(16) },
+	[RST_BUS_EINK]			= { 0xa6c, BIT(16) },
+	[RST_BUS_DE_SYS]		= { 0xa74, BIT(16) },
+	[RST_BUS_VE_ENC0]		= { 0xa8c, BIT(16) },
+	[RST_BUS_VE_DEC0]		= { 0xa8c, BIT(18) },
+	[RST_BUS_CE]			= { 0xac4, BIT(16) },
+	[RST_BUS_CE_SYS]		= { 0xac4, BIT(17) },
+	[RST_BUS_NPU_CORE]		= { 0xb04, BIT(16) },
+	[RST_BUS_NPU_AXI]		= { 0xb04, BIT(17) },
+	[RST_BUS_NPU_AHB]		= { 0xb04, BIT(18) },
+	[RST_BUS_NPU_SRAM]		= { 0xb04, BIT(19) },
+	[RST_BUS_GPU0]			= { 0xb24, BIT(16) },
+	[RST_BUS_DRAM0]			= { 0xc0c, BIT(16) },
+	[RST_BUS_NAND0]			= { 0xc8c, BIT(16) },
+	[RST_BUS_MMC0]			= { 0xd0c, BIT(16) },
+	[RST_BUS_MMC1]			= { 0xd1c, BIT(16) },
+	[RST_BUS_MMC2]			= { 0xd2c, BIT(16) },
+	[RST_BUS_MMC3]			= { 0xd3c, BIT(16) },
+	[RST_BUS_UFS_AHB]		= { 0xd8c, BIT(16) },
+	[RST_BUS_UFS_AXI]		= { 0xd8c, BIT(17) },
+	[RST_BUS_UFS_PHY]		= { 0xd8c, BIT(18) },
+	[RST_BUS_UFS_CORE]		= { 0xd8c, BIT(19) },
+	[RST_BUS_UART0]			= { 0xe00, BIT(16) },
+	[RST_BUS_UART1]			= { 0xe04, BIT(16) },
+	[RST_BUS_UART2]			= { 0xe08, BIT(16) },
+	[RST_BUS_UART3]			= { 0xe0c, BIT(16) },
+	[RST_BUS_UART4]			= { 0xe10, BIT(16) },
+	[RST_BUS_UART5]			= { 0xe14, BIT(16) },
+	[RST_BUS_UART6]			= { 0xe18, BIT(16) },
+	[RST_BUS_I2C0]			= { 0xe80, BIT(16) },
+	[RST_BUS_I2C1]			= { 0xe84, BIT(16) },
+	[RST_BUS_I2C2]			= { 0xe88, BIT(16) },
+	[RST_BUS_I2C3]			= { 0xe8c, BIT(16) },
+	[RST_BUS_I2C4]			= { 0xe90, BIT(16) },
+	[RST_BUS_I2C5]			= { 0xe94, BIT(16) },
+	[RST_BUS_I2C6]			= { 0xe98, BIT(16) },
+	[RST_BUS_I2C7]			= { 0xe9c, BIT(16) },
+	[RST_BUS_I2C8]			= { 0xea0, BIT(16) },
+	[RST_BUS_I2C9]			= { 0xea4, BIT(16) },
+	[RST_BUS_I2C10]			= { 0xea8, BIT(16) },
+	[RST_BUS_I2C11]			= { 0xeac, BIT(16) },
+	[RST_BUS_I2C12]			= { 0xeb0, BIT(16) },
+	[RST_BUS_SPI0]			= { 0xf04, BIT(16) },
+	[RST_BUS_SPI1]			= { 0xf0c, BIT(16) },
+	[RST_BUS_SPI2]			= { 0xf14, BIT(16) },
+	[RST_BUS_SPIF]			= { 0xf1c, BIT(16) },
+	[RST_BUS_SPI3]			= { 0xf24, BIT(16) },
+	[RST_BUS_SPI4]			= { 0xf2c, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_GPADC0]		= { 0xfc4, BIT(16) },
+	[RST_BUS_THS0]			= { 0xfe4, BIT(16) },
+	[RST_BUS_IRRX]			= { 0x1004, BIT(16) },
+	[RST_BUS_IRTX]			= { 0x100c, BIT(16) },
+	[RST_BUS_LRADC]			= { 0x1024, BIT(16) },
+	[RST_BUS_SGPIO]			= { 0x1064, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_LPC]			= { 0x1084, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_I2SPCM0]		= { 0x120c, BIT(16) },
+	[RST_BUS_I2SPCM1]		= { 0x121c, BIT(16) },
+	[RST_BUS_I2SPCM2]		= { 0x122c, BIT(16) },
+	[RST_BUS_I2SPCM3]		= { 0x123c, BIT(16) },
+	[RST_BUS_I2SPCM4]		= { 0x124c, BIT(16) },
+	[RST_BUS_SPDIF]			= { 0x128c, BIT(16) },
+	[RST_BUS_DMIC]			= { 0x12cc, BIT(16) },
+	[RST_USB_PHY0]			= { 0x1300, BIT(30) },
+	[RST_BUS_OHCI0]			= { 0x1304, BIT(16) },
+	[RST_BUS_EHCI0]			= { 0x1304, BIT(20) },
+	[RST_BUS_OTG]			= { 0x1304, BIT(24) },
+	[RST_USB_PHY1]			= { 0x1308, BIT(30) },
+	[RST_BUS_OHCI1]			= { 0x130c, BIT(16) },
+	[RST_BUS_EHCI1]			= { 0x130c, BIT(20) },
+	[RST_BUS_USB2]			= { 0x135c, BIT(16) },
+	[RST_BUS_PCIE_PWRUP]		= { 0x138c, BIT(16) },
+	[RST_BUS_PCIE]			= { 0x138c, BIT(17) },
+	[RST_BUS_SERDES]		= { 0x13c4, BIT(16) },
+	[RST_BUS_GMAC0]			= { 0x141c, BIT(16) },
+	[RST_BUS_GMAC0_AXI]		= { 0x141c, BIT(17) },
+	[RST_BUS_GMAC1]			= { 0x142c, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_GMAC1_AXI]		= { 0x142c, BIT(17) }, /* From the vendor kernel. */
+	[RST_BUS_TCON_LCD0]		= { 0x1504, BIT(16) },
+	[RST_BUS_TCON_LCD1]		= { 0x150c, BIT(16) },
+	[RST_BUS_TCON_LCD2]		= { 0x1514, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_LVDS0]			= { 0x1544, BIT(16) },
+	[RST_BUS_LVDS1]			= { 0x154c, BIT(16) },
+	[RST_BUS_DSI0]			= { 0x1584, BIT(16) },
+	[RST_BUS_DSI1]			= { 0x158c, BIT(16) },
+	[RST_BUS_TCON_TV0]		= { 0x1604, BIT(16) },
+	[RST_BUS_TCON_TV1]		= { 0x160c, BIT(16) },
+	[RST_BUS_EDP]			= { 0x164c, BIT(16) },
+	[RST_BUS_HDMI_MAIN]		= { 0x168c, BIT(16) },
+	[RST_BUS_HDMI_SUB]		= { 0x168c, BIT(17) },
+	[RST_BUS_HDMI_HDCP]		= { 0x168c, BIT(18) },
+	[RST_BUS_DPSS_TOP0]		= { 0x16c4, BIT(16) },
+	[RST_BUS_DPSS_TOP1]		= { 0x16cc, BIT(16) },
+	[RST_BUS_VIDEO_OUT0]		= { 0x16e4, BIT(16) },
+	[RST_BUS_VIDEO_OUT1]		= { 0x16ec, BIT(16) },
+	[RST_BUS_LEDC]			= { 0x1704, BIT(16) },
+	[RST_BUS_DSC]			= { 0x1744, BIT(16) },
+	[RST_BUS_CSI]			= { 0x1844, BIT(16) },
+	[RST_BUS_VIDEO_IN]		= { 0x1884, BIT(16) },
+	[RST_BUS_APB2JTAG]		= { 0x1c04, BIT(16) },
+};
+
 static const struct sunxi_ccu_desc sun60i_a733_ccu_desc = {
 	.ccu_clks	= sun60i_a733_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun60i_a733_ccu_clks),
 
 	.hw_clks	= &sun60i_a733_hw_clks,
+
+	.resets		= sun60i_a733_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun60i_a733_ccu_resets),
 };
 
 static const u32 pll_regs[] = {

-- 
2.54.0


