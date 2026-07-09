Return-Path: <netdev+bounces-306242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +jMbDASpT2r0mAIAu9opvQ
	(envelope-from <netdev+bounces-306242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:58:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B252C731E16
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:58:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b="VP//9UTR";
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306242-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306242-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03E3A312E1DE
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E094642314A;
	Thu,  9 Jul 2026 13:43:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BA41A79E;
	Thu,  9 Jul 2026 13:43:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604591; cv=none; b=AKU0KegYqckKUqfZGQn6+3MKChEx05LlxUAukpbSmStBX4m5nd5Ry926b3jNCoXhfz1d9PdDekSQ2mPhoZOPwi97coWOZcNuxPSQyr6QqpdWcc6DiiUBE1HaMu5w+5j02l2MiabIieCAe3IhhQak/YYNVa27GZVNfhNVMMsxeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604591; c=relaxed/simple;
	bh=0iPztvmI78QkGurYVCSEGCjiopYD7pP6BiUyKFDjSaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aICeCnpkTMqqodSCzvPv8rqrb8DX8742ttb0S+37BtZpckyOiVlWHX1JJ9nWF1vzvqwse1SLQJH7wKrTqF3p4z6tCouakc869o+q8EDkcptsLuTpp322Ue7iRhLmbj/n9A4GPJJOBWoVuKxxbW497qfteh1Q2qfR5Z3J16Pd93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VP//9UTR; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783604586;
	bh=0iPztvmI78QkGurYVCSEGCjiopYD7pP6BiUyKFDjSaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VP//9UTRBtTswiSyQORgRo0JFU3KDAyFRO0EjiGGHr5TUjKw3YuQ5ZAYJRPaf2qwQ
	 WLqbPFlXl6lAvIRXR31DtI71DuyMHtMoJjK1FWzVxQ5IJKnR+ZVXfP33srX9Z8ycoC
	 WVDW60hX7SX6a77uQqgXfD47ragN0wh33o4SoUs7GiWzszJD1sT6D98cOoQO2a+D96
	 bI2wQMehSmCPkf3bTXCcEn8bmFMKn7ZZkTAH7czXRArcZ93LZe5smbgLxp76aNFYa/
	 G+kUhsSKWbEccVWG5RvJkAcpZrbSYhAhx4Wdso8NXGivVEnbphe8jmNWuwm3mkLfM7
	 q7qMwcK4AZWpg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C142317E0D56;
	Thu, 09 Jul 2026 15:43:05 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 09 Jul 2026 15:42:49 +0200
Subject: [PATCH v2 09/18] clk: mediatek: Add MT8189 apmixedsys clock
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8189-clocks-system-base-v2-9-2926da3db6cf@collabora.com>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783604575; l=9564;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=0iPztvmI78QkGurYVCSEGCjiopYD7pP6BiUyKFDjSaY=;
 b=zSeyFM9MgJBTYQ5YncQL4nZER3IjXNWNnPsf66tLXv5o+zcVjfv4WitcrlJXP5wtGNmm3/2KZ
 tNzjdZGjW6AA+VT3iX+T1LT+laIhUaopYPCbiDrV3IDnICK5SRcXIq7
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306242-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:irving-ch.lin@mediatek.com,m:louisalexis.eyraud@collabora.com,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,pengutronix.de];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B252C731E16

Add support for the MT8189 apmixedsys clock controller, which provides
PLLs generated from SoC 26m.

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/Kconfig                 |  13 ++
 drivers/clk/mediatek/Makefile                |   1 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c | 196 +++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 2c09fd729bab..f67dfb6cd019 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -815,6 +815,19 @@ config COMMON_CLK_MT8188_WPESYS
 	help
 	  This driver supports MediaTek MT8188 Warp Engine clocks.
 
+config COMMON_CLK_MT8189
+	tristate "Clock driver for MediaTek MT8189"
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	select COMMON_CLK_MEDIATEK_FHCTL
+	default ARCH_MEDIATEK
+	help
+	  Enable this option to support the clock management for MediaTek MT8189 SoC. This
+	  includes handling of all primary clock functions and features specific to the MT8189
+	  platform. Enabling this driver ensures that the system's clock functionality aligns
+	  with the MediaTek MT8189 hardware capabilities, providing efficient management of
+	  clock speeds and power consumption.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index d8736a060dbd..66577ccb9b93 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
+obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-apmixedsys.c b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
new file mode 100644
index 000000000000..0657a50c30d9
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025-2026 MediaTek Inc.
+ *                    Qiqi Wang <qiqi.wang@mediatek.com>
+ *                    Irving-CH Lin <irving-ch.lin@mediatek.com>
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-fhctl.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+#define MT8189_PLL_FMAX		(3800UL * MHZ)
+#define MT8189_PLL_FMIN		(1500UL * MHZ)
+#define MT8189_PLLEN_OFS	0x70
+#define MT8189_INTEGER_BITS	8
+
+#define PLL_SETCLR(_id, _name, _reg, _en_setclr_bit,		\
+			_rstb_setclr_bit, _flags, _pd_reg,	\
+			_pd_shift, _tuner_reg, _tuner_en_reg,	\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,	\
+			_pcwbits) {				\
+		.id = _id,					\
+		.name = _name,					\
+		.en_reg = MT8189_PLLEN_OFS,			\
+		.reg = _reg,					\
+		.pll_en_bit = _en_setclr_bit,			\
+		.rst_bar_mask = BIT(_rstb_setclr_bit),		\
+		.flags = _flags,				\
+		.fmax = MT8189_PLL_FMAX,			\
+		.fmin = MT8189_PLL_FMIN,			\
+		.pd_reg = _pd_reg,				\
+		.pd_shift = _pd_shift,				\
+		.tuner_reg = _tuner_reg,			\
+		.tuner_en_reg = _tuner_en_reg,			\
+		.tuner_en_bit = _tuner_en_bit,			\
+		.pcw_reg = _pcw_reg,				\
+		.pcw_shift = _pcw_shift,			\
+		.pcwbits = _pcwbits,				\
+		.pcwibits = MT8189_INTEGER_BITS,		\
+	}
+
+static const struct mtk_pll_data apmixed_plls[] = {
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_LL, "armpll-ll", 0x204, 18,
+		   0, PLL_AO, 0x208, 24, 0, 0, 0, 0x208, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_BL, "armpll-bl", 0x214, 17,
+		   0, PLL_AO, 0x218, 24, 0, 0, 0, 0x218, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_CCIPLL, "ccipll", 0x224, 16,
+		   0, PLL_AO, 0x228, 24, 0, 0, 0, 0x228, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MAINPLL, "mainpll", 0x304, 15,
+		   23, HAVE_RST_BAR | PLL_AO,
+		   0x308, 24, 0, 0, 0, 0x308, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UNIVPLL, "univpll", 0x314, 14,
+		   23, HAVE_RST_BAR, 0x318, 24, 0, 0, 0, 0x318, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MMPLL, "mmpll", 0x324, 13,
+		   23, HAVE_RST_BAR, 0x328, 24, 0, 0, 0, 0x328, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MFGPLL, "mfgpll", 0x504, 7,
+		   0, 0, 0x508, 24, 0, 0, 0, 0x508, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APLL1, "apll1", 0x404, 11,
+		   0, 0, 0x408, 24, 0x040, 0x00c, 0, 0x40c, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_APLL2, "apll2", 0x418, 10,
+		   0, 0, 0x41c, 24, 0x044, 0x00c, 1, 0x420, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_EMIPLL, "emipll", 0x334, 12,
+		   0, PLL_AO, 0x338, 24, 0, 0, 0, 0x338, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL2, "apupll2", 0x614, 2,
+		   0, 0, 0x618, 24, 0, 0, 0, 0x618, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL, "apupll", 0x604, 3,
+		   0, 0, 0x608, 24, 0, 0, 0, 0x608, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x42c, 9,
+		   0, 0, 0x430, 24, 0, 0, 0, 0x430, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x43c, 8,
+		   0, 0, 0x440, 24, 0, 0, 0, 0x440, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ETHPLL, "ethpll", 0x514, 6,
+		   0, 0, 0x518, 24, 0, 0, 0, 0x518, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MSDCPLL, "msdcpll", 0x524, 5,
+		   0, 0, 0x528, 24, 0, 0, 0, 0x528, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UFSPLL, "ufspll", 0x534, 4,
+		   0, 0, 0x538, 24, 0, 0, 0, 0x538, 0, 22),
+};
+
+#define FH(_pllid, _fhid, _offset) {				\
+		.data = {					\
+			.pll_id = _pllid,			\
+			.fh_id = _fhid,				\
+			.fh_ver = FHCTL_PLLFH_V2,		\
+			.fhx_offset = _offset,			\
+			.dds_mask = GENMASK(21, 0),		\
+			.slope0_value = 0x6003c97,		\
+			.slope1_value = 0x6003c97,		\
+			.sfstrx_en = BIT(2),			\
+			.frddsx_en = BIT(1),			\
+			.fhctlx_en = BIT(0),			\
+			.tgl_org = BIT(31),			\
+			.dvfs_tri = BIT(31),			\
+			.pcwchg = BIT(31),			\
+			.dt_val = 0x0,				\
+			.df_val = 0x9,				\
+			.updnlmt_shft = 16,			\
+			.msk_frddsx_dys = GENMASK(23, 20),	\
+			.msk_frddsx_dts = GENMASK(19, 16),	\
+		},						\
+	}
+
+static struct mtk_pllfh_data pllfhs[] = {
+	FH(CLK_APMIXED_ARMPLL_LL, 0, 0x003C),
+	FH(CLK_APMIXED_ARMPLL_BL, 1, 0x0050),
+	FH(CLK_APMIXED_CCIPLL, 2, 0x0064),
+	FH(CLK_APMIXED_MAINPLL, 3, 0x0078),
+	FH(CLK_APMIXED_MMPLL, 4, 0x008C),
+	FH(CLK_APMIXED_MFGPLL, 5, 0x00A0),
+	FH(CLK_APMIXED_EMIPLL, 6, 0x00B4),
+	FH(CLK_APMIXED_TVDPLL1, 7, 0x00C8),
+	FH(CLK_APMIXED_TVDPLL2, 8, 0x00DC),
+	FH(CLK_APMIXED_MSDCPLL, 9, 0x00F0),
+	FH(CLK_APMIXED_UFSPLL, 10, 0x0104),
+	FH(CLK_APMIXED_APUPLL, 11, 0x0118),
+	FH(CLK_APMIXED_APUPLL2, 12, 0x012c),
+};
+
+static const struct of_device_id of_match_clk_mt8189_apmixed[] = {
+	{ .compatible = "mediatek,mt8189-apmixedsys" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_apmixed);
+
+static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
+{
+	int r;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	const u8 *fhctl_node = "mediatek,mt8189-fhctl";
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
+	if (!clk_data)
+		return -ENOMEM;
+
+	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
+
+	r = mtk_clk_register_pllfhs(&pdev->dev, apmixed_plls, ARRAY_SIZE(apmixed_plls),
+				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
+	if (r)
+		goto free_apmixed_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_plls;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return 0;
+
+unregister_plls:
+	mtk_clk_unregister_pllfhs(apmixed_plls, ARRAY_SIZE(apmixed_plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static void clk_mt8189_apmixed_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_pllfhs(apmixed_plls, ARRAY_SIZE(apmixed_plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static struct platform_driver clk_mt8189_apmixed_drv = {
+	.probe = clk_mt8189_apmixed_probe,
+	.remove = clk_mt8189_apmixed_remove,
+	.driver = {
+		.name = "clk-mt8189-apmixed",
+		.of_match_table = of_match_clk_mt8189_apmixed,
+	},
+};
+module_platform_driver(clk_mt8189_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8189 apmixed clocks driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0


