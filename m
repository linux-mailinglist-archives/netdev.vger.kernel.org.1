Return-Path: <netdev+bounces-285650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDrQHpF7/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:58:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF44F22CF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50CA030459C7
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08873783BE;
	Fri,  8 May 2026 05:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789936E460;
	Fri,  8 May 2026 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218705; cv=fail; b=hhS3dDD+/UVZJrL9dnzF4+iA4+bKXjAHrSH/lRyeL1V1rc0EEALfBnXoR886bkcd67o1kyJZF0qY0ICGjEVosKQ88JZobWeZ0nIn5FHd2tVmcnNLXhMkTnsbtpeP5MB5HdvC6LP9Hdpi0JD7O8j4v+2QnKBAPeSOWeN/5Zqcjrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218705; c=relaxed/simple;
	bh=CY1qe70PWOCi/w3sNR5ElTNopvIK6Bom423avryFyq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=reMYzxp9wcqldXdv/0y2b+YL9UjmoEz+I2+bWStqqiM9xkjxp63ZznKJ4cZ/CVQLaKgGfuyAZoqHOZESe35yD20GZjwL6tfEaFBQm3NHmZFWNdejwHyPmb5efeybZiwpXCWzNRd/Cs2WB4ywA4vNNlcbOwjDhd/lQGzJKkU0NjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7rMBVCTbaZh5SCLBpjW+FfIL7IkOSLI9xTsZJuYZbIM2FsK8qVCA1ofrBsoNxkuJPhU+6gxlUh+S3EFzvpMsSYyOfvPb0Hj1NVog2t7HIdeRNH3UcL4+IPEVc1ZV0F2K8ZLeRhMJNtJ1fswSzHZMK+FEw1Wl6xv366o6u3qJAyp/u2hP6JOjD3qBZuGD7bTnSzFb2vJkUHL+PgKqdc6gIYKMApiw7js3js5eqwbshSd2nvSY8ixtxxwxx6r6zLdCbQGnRbmQxspMmSWKLQlyzRX4+Algh2gP1NDpvaf/WNq3ApkdISjJgf258BTeTRgsUT2op43sKHoBJl4xHTqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLliV/6V1FzowyTeqeJzBDYvWxuJiPmHW8H7VXfgnRU=;
 b=F1Yv9ySxYU/LS0WTyMCEWithH83SjzL+b0dFjBLtuhfHJfMpsHpjju9K1Pr0jC0N0mcodPI8V2ja04PctWD95c0x6JuUF6cfdIngmh4MUbulG7iOpzJfZ6HApTowruuLoGfbpUuQSyxJIz6YwmPlM40CpXNiny30S+eWrHdk4YiR74mCNPkI5AxniTSDdTt5zTWiLCS4cF7kTueKYylL+6LYCGNsABIfjsCyfR+X7H4I76oIws2cvF1WomMtQ9J0o3nwiZFwFB5MK8niqtsEdpjF26um5B/8wFAOif3P1jl3uyA9UchVLjkM/45YfidA/5/uosB5xD+l5/+jix4U6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1252.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:16 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:16 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 20/22] clk: starfive: Add StarFive JHB100 Peripheral-3 clock driver
Date: Thu,  7 May 2026 22:36:30 -0700
Message-Id: <20260508053632.818548-21-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::12) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1252:EE_
X-MS-Office365-Filtering-Correlation-Id: 7226ceee-0980-4b3d-e49d-08deacc3dd3b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MJr/XNYyo9Lt034TikOI6CQjzeNYmzc9kGUkKrzhaprdNRLkbyRP/6ZpkBUvg1n/RQD+OMAnKNs12z/7v5GT2fBzhuuM+UuxywlY4W//wCaTUnQXSY6Qg/7ziu6117rbVdO7IPNOPjuEFYweu95fB4kdHsDIGwYt0yOtM4k1wmIZOqXEaLQMujyzCwDAAV3+RfPpJNKTDCPp2VUiZhr4OASJP9376LWkunB0l+32HNVDnb3GDJ58AK4SI/wFWu/4XWBDZv8At/mGRyXujtvzR2Vz88xfYhpZS1sN6Hl0CdHUZxbyb2A2RKk93wwfvboC99BNrMB5AkQf0cp9+SNXzQ2CJ6gSQWlnhJrj2popGRc9Qhkz6O+yFNtoncBsy4MnzQWHAjjImQrD4pk6EfEUE7dt5thH5Uct2GY1P2iqbGjSACuhZe0hqJdQyCk5T02rN8NGpgcChntVBiRPOe+i1g1p/zNyaIzYQ6XzhNxz5yVeu+UAPukLIBJs1Z+990+1gdOQVbdsTfP2BlXHPwOQwBm71cyFl3JNl0VKZtFXNRZ0zT1Jugg8g+3+akhOMR8t6KZPRQANT7/rfsTcYTGZMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9HyRdhnSdE0fXc2PNVBLG8WamoK4upqH6GPt5AfaYmFy6Ni4gAx9yaaf+OU?=
 =?us-ascii?Q?nskzhjRmPys80zo/vlYU9OXOXetoNmnjbZrmxK8svCAq5uZ7qnake0EwEcrF?=
 =?us-ascii?Q?lsdd7BclvDvHwfWHH8eBH0jgz3ViDJVZLJCKXWSkJ7JL4KdgH+1vZDlgrUwB?=
 =?us-ascii?Q?2HBgZUVqf/z1Y41uzGwY8iJ450gmGN1BVpyPDk8iItLpRTcjOOfu7x4msFZd?=
 =?us-ascii?Q?noCXuJF3tfscvj8gBeiojRnV0Wj8WvKutxHL4+3tCM2PVCqcVaJQBQmf6Q/Z?=
 =?us-ascii?Q?PE+x1NbRgaRrfSY43INYhHDrwgplFAHmoAi7FxD6NNWPDUFSKwwJet1tdvfz?=
 =?us-ascii?Q?Ql16EE9PTLhEZNO3MX/eo/F0T+qA/0PTvQAYKMC2V8XyBRTlxnbB+HUkXHfU?=
 =?us-ascii?Q?UseQIBC9iVBlFOELP6oAhhSJrCBLKO1U8IGnstYPtW1ePfe7YJO1PDTBEP+r?=
 =?us-ascii?Q?UomSGdPT/Jh90LrmUKqWyZICAzW3S8hk1x3JOU0F3KPry7fErFrojA/QpMV0?=
 =?us-ascii?Q?xWW8zyIrc1Qv09dhpRrM4dkZhGO4iGR0lYiKyBwgtAIEopdTOgZfrBq+dNbs?=
 =?us-ascii?Q?4Oyr5trRYc0GcUnZ21VIyceKDzH4rlS1TqkK8D2xo/3g7iQWxBdQmvzzQXgV?=
 =?us-ascii?Q?FtDymCxbtKvEU2DNv+A6t/FoQq+y25t3zOZtfSacFTrlrHQ6GwY+no9fRtBI?=
 =?us-ascii?Q?YbN/h1RBG1HRVaUjQkv08VASZJxhHdSBLElbMx/T9fEIvFNXknqDkaOvYDOI?=
 =?us-ascii?Q?7F8TzQAZanpx7SrkMYFSSG49hmk8AaE2NXX+09UHjfKTz9nxT7xHrPD2Mxp3?=
 =?us-ascii?Q?c+p1sT1nNUWkl1KZBadGDFDGaiK2Xei6RX5M4Z1s0ORcNudIHH5Lq2WTuwR/?=
 =?us-ascii?Q?XpOr2Wgh7cR0XInwjmxDImQCFtn4bvsrX2v85lJtxlN6WDKY2xhb3sV2kICt?=
 =?us-ascii?Q?XndTnDS9V2Ne/y1e+nic42CK86wXH2X9PSfkl6ooD15VDsVvhvSJfHpjinxM?=
 =?us-ascii?Q?F+0GGWgg0/T7K3zMtUCir/y3n1r8mh7G7NvSMIT5vz2URqYtlgBnjVv4d3bs?=
 =?us-ascii?Q?Tk6wGtddDWRPGOGNxGmlOhcLewNugw/brkZZQO386HHkQ4s+K9bQG1Xq4a+X?=
 =?us-ascii?Q?IZiftTjpBnwFPOivsy0OeKQ4fc46ct0je7ANF9RVFy0otolad+4dT8Dma8a4?=
 =?us-ascii?Q?oOIeB56hgWBSFX7ur8it+j6++jNm2y8s/u+464A3F+mBfFESecp3EgETzIxT?=
 =?us-ascii?Q?szZTzVtUWtjN2SWY6YOMc1n7Pc5r0Yx65556WpGZCIhd6EdhFHOpWQo7DDXz?=
 =?us-ascii?Q?1h8Mw0h58//YgOZpSxhxl0EJeNwq7ARrMHOr25LNxchgFY/MeCzCIj7Z5ymk?=
 =?us-ascii?Q?Tcc9h8vDL1MUxpVS6YZEwUegbLRGudbQkC0+o5GFrCHPD7PEkUnoQD29faAr?=
 =?us-ascii?Q?SoahfpPicoScG558PgraMOLJuiNb6H+Qss/+HESWDHyKoaAOsS+DOSZ1VXMz?=
 =?us-ascii?Q?vGry8/R6cFJCE7kG3NZkPdc1xdTTU2Bc05Qjt3wnmc9vc0WI3FSFE2Ihadba?=
 =?us-ascii?Q?YlYUzxVO/91QMv5aC6KiGXRqVZEwA6Fw27yvKqbmpNCe/EfIud6vSOG0aXlS?=
 =?us-ascii?Q?z6ni8lPfG2Qk124STiFlNA9bLBmd9+LhcZdTupE0TuRnuDRRl2pSy8IGLBtL?=
 =?us-ascii?Q?zQn0hAqD7Ypq+9dAPm14k0tRhBRVsHLdjG/8hqjs/QqKz2ihxAfvxOUeTiub?=
 =?us-ascii?Q?BtzP55UNJWE9E9ubR2NCKv+U8A58QVCB6gKAdaEyo1RthFaL2fJN?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7226ceee-0980-4b3d-e49d-08deacc3dd3b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:16.4313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIKkt16vXXi8b07L+z/rre49GNqxLY/JmmORiOB/te/Uxl+iYDxcfS57Bo+pKGNGfb0r0xw5qDrMg7O5x4Mj5CAmxpg6+xFd/6/049XoZ2u5EA+VJzzUb2MT0ZmQHE+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1252
X-Rspamd-Queue-Id: E0FF44F22CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285650-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.904];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Action: no action

Add driver for the StarFive JHB100 Peripheral-3 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 136 ++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per3.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 01d6d325dcd0..c612f1ede7d7 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -97,6 +97,14 @@ config CLK_STARFIVE_JHB100_PER2
 	  Say yes here to support the peripheral-2 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER3
+	bool "StarFive JHB100 peripheral-3 clock support"
+	depends on CLK_STARFIVE_JHB100_SYS1
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the peripheral-3 clock controller
+	  on the StarFive JHB100 SoC.
+
 config CLK_STARFIVE_JHB100_SYS0
 	bool "StarFive JHB100 system-0 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 044e1942ccfa..f00690f0cdad 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER0)		+= clk-starfive-jhb100-per0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER1)		+= clk-starfive-jhb100-per1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER2)		+= clk-starfive-jhb100-per2.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_PER3)		+= clk-starfive-jhb100-per3.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-per3.c b/drivers/clk/starfive/clk-starfive-jhb100-per3.c
new file mode 100644
index 000000000000..23f6a3db655c
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-per3.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 Peripheral-3 Clock Driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <linux/platform_device.h>
+
+#include "clk-starfive-common.h"
+
+#define JHB100_PER3CLK_NUM_CLKS			(JHB100_PER3CLK_MAIN_ICG_EN_GMAC1 + 1)
+
+/* external clocks */
+#define JHB100_PER3CLK_NCNOC_INIT		(JHB100_PER3CLK_NUM_CLKS + 0)
+#define JHB100_PER3CLK_NCNOC_TARG		(JHB100_PER3CLK_NUM_CLKS + 1)
+#define JHB100_PER3CLK_CFG_125			(JHB100_PER3CLK_NUM_CLKS + 2)
+#define JHB100_PER3CLK_GMAC0_RMII_RCLKI		(JHB100_PER3CLK_NUM_CLKS + 3)
+#define JHB100_PER3CLK_GMAC1_SGMII_TX		(JHB100_PER3CLK_NUM_CLKS + 4)
+#define JHB100_PER3CLK_GMAC1_SGMII_RX		(JHB100_PER3CLK_NUM_CLKS + 5)
+#define JHB100_PER3CLK_OSC			(JHB100_PER3CLK_NUM_CLKS + 6)
+
+char *jhb100_per3_ext_clk[] = {
+	"ncnoc_init",
+	"ncnoc_targ",
+	"cfg_125",
+	"gmac0_rmii_rclki",
+	"gmac1_sgmii_tx",
+	"gmac1_sgmii_rx",
+	"osc",
+};
+
+static const struct starfive_clk_data jhb100_per3crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER3CLK_300, "per3_300", 256,
+		      JHB100_PER3CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER3CLK_200, "per3_200", 256,
+		      JHB100_PER3CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_PTP_REF, "gmac1_ptp_ref", 2,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC1_TX_125_MUX, "gmac1_tx_125_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC1_SGMII_TX,
+		      JHB100_PER3CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_TX, "gmac1_tx", 50,
+		      JHB100_PER3CLK_GMAC1_TX_125_MUX),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC1_RX_125_MUX, "gmac1_rx_125_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC1_SGMII_RX,
+		      JHB100_PER3CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_RX, "gmac1_rx", 50,
+		      JHB100_PER3CLK_GMAC1_RX_125_MUX),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_PTP_REF, "gmac0_ptp_ref", 2,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_RMII_PLL, "gmac0_rmii_pll", 2,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC0_RMII_MUX, "gmac0_rmii_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC0_RMII_PLL,
+		      JHB100_PER3CLK_GMAC0_RMII_RCLKI),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2, "gmac0_rmii_mux_div2", 20,
+		      JHB100_PER3CLK_GMAC0_RMII_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_TX_I, "ether0_rmii_clk_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_RX_I, "ether0_rmii_clk_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_PTP_REF_I, "ether0_rmii_clk_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_PTP_REF),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_RMII_I, "ether0_rmii_clk_rmii_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_CSR_I, "ether0_rmii_clk_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_ACLK_I, "ether0_rmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_300),
+	STARFIVE_GATE(JHB100_PER3CLK_GMAC0_RMII_RCLKO, "gmac0_rmii_rclko",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_PLL),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_I, "ether0_sgmii_clk_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_TX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_I, "ether0_sgmii_clk_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_RX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_125_I, "ether0_sgmii_clk_tx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_TX_125_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_125_I, "ether0_sgmii_clk_rx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_RX_125_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_PTP_REF_I, "ether0_sgmii_clk_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_PTP_REF),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_REF_25_I, "ether0_sgmii_clk_ref_25_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_OSC),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_CSR_I, "ether0_sgmii_clk_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_ACLK_I, "ether0_sgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_300),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_PHY_PCLK_I, "ether0_sgmii_phy_pclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_SENSORS_PERIPH3, "main_icg_en_sensors_periph3", 0,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI0, "main_icg_en_peci0", 0,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI1, "main_icg_en_peci1", 0,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC0, "main_icg_en_gmac0",
+		      CLK_IS_CRITICAL, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC1, "main_icg_en_gmac1",
+		      CLK_IS_CRITICAL, JHB100_PER3CLK_NCNOC_TARG),
+};
+
+const struct jhb100_crg_domain_info jhb100_per3crg_info = {
+	.clk_data	= jhb100_per3crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_per3crg_clk_data),
+	.ext_clk	= jhb100_per3_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_per3_ext_clk),
+	.rst_name	= "jhb100-r-per3",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_per3crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-per3crg",
+		.data = &jhb100_per3crg_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jhb100_per3crg_match);
+
+static struct platform_driver jhb100_per3crg_driver = {
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per3",
+		.of_match_table = jhb100_per3crg_match,
+	},
+};
+module_platform_driver(jhb100_per3crg_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 Peripheral-3 Clock Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


