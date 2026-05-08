Return-Path: <netdev+bounces-285645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGQgNLl3/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:42:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B164F2023
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADB30303525D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3343612EF;
	Fri,  8 May 2026 05:37:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F535F170;
	Fri,  8 May 2026 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218657; cv=fail; b=SCMssm79SwWrdIUrLpOj1L9qqCcvJFhAq2HbG54euXX6vP3S1UrbcCbSry/13aII42XbeHFqQhnyzo9zI3P+NjJ0rwdR8aBOv5GXAhbJwU7TteRJKNYUZu0yV8vhdVGkDlGqNaorFrDUjp8XRjTTenenKOxc5dd9q+D0h7y43+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218657; c=relaxed/simple;
	bh=e19qeuYNeHXyuLqUHZEZAee8jMEF3f13c5+P+i4xTDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUt7ZYgdAMtoAePcgcX5ug3ivxr1fXRO2v6WIg3GHPmtbEfPYrGSXXwcNQaI6TCT+IS46CpblBralzlvJFn2g1pgL2mLDP5yJxwXFo3JM6BTJT4XZ51BND5i6pByswNhf/I99dyah2udEL7c0lSAu5zzW+YNZF+0+sr97XZ3rD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFIb3wUORWLm06JwihWSwMXzJAIix7npVu5o5NqTh/nphuC5fAne7P8Jr4BD/uHJaibZRzjuHfkt0O20lS8ewrEgz8BoUUbT8+iuu1nOgjz5qYtUSVrIm6RbfacmflmBSPtQbN0AG+LxERW8JsJFMUkr7O8OqyLWswNc+n8g/UkVJBORrlofQCpYk7rGS/wgFgMhNP6ZObM8TP7v6iIJxWFkZ4LYfgvZ1LFMkYJCsxJbQXjXEGho4DCRoi0FNQJMoiY/cT2w6KVzHVJPTu3k9ThJRf7whzZqT7vYbG0VFtUvEB8IuT9UEBF53Wi3pWam5nVGCH/e3bcrsf6bYQ/tjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A48jdPiYxK0/AGpILS+rmZ1sN+gSiZEBHwFGv4mwHtQ=;
 b=Cip9jyunCnMuNnWD+4UxTc/HFsjeUwg6ehB14inveyATPjH8fjuIawYwXP1Aq6y9XNjxN4J06nFZc7cjOBNTzBabmL+2Yp6CH3/aA+fC8I1BVdErhuVnJixOCO2cLJTVU3CHR8v/YLDPH3FD7FsES8suX/OoGoU7NXjlaNG91G7HB1vRU5HookzjbnEDgikapDg3k4JzbqcoEZgQt9rqXQAJVgROWnxVo5qb66ytkSzEV0B111tN7R3aXsZ5UMVe28bvhebrvT3cfrtXzgu6J8vP5G2mfx/+nm9Z5DaDB2w5dbVXi6376IRkKcWUzCjbpFagLXCU6fbkNrzKOiWoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1252.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:13 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:12 +0000
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
Subject: [PATCH v2 18/22] clk: starfive: Add StarFive JHB100 Peripheral-2 clock driver
Date: Thu,  7 May 2026 22:36:28 -0700
Message-Id: <20260508053632.818548-19-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7defb20a-a1d4-413b-fcd9-08deacc3db1b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	06jcxzeLqu5XeP9V70taeu3XGbolXiKfBQHcUTho8uqymAFat26jf2PtUhE09IVTE4BwNo5vknMTejIrHiroaMkJz621NgM4y7ktEkdISfCh2yAphANH6WU3U2mfUNFXrxI8nPrTihs/QUaTrTuAFAKSIklSaiKenO/JQKzc6z9Go5+z+ytFiI6kqcdMlcPgvrKCZGRH6yeQeR7ha8lLPVeVdFRtWPcBDlizTxv8bw5cuUq+XbTykxyLJzuQGcVtSOckjbulzdV5srrVBICjbMjL1vthOqn54iOR2L0/ssl0GrCNpRlmE24fEjUexE6nsyRb1SiOCAefIsKKB6dV9CnQJ5DK+rbHmehpSzj4WR6owDgG7NzOfaZWVgdte7kdeuHx0j/me40n0G8cRBVq/kHK+mW2KkBbwR/jdsZREgtZYxpnQio7Jvdh6/H36IZvmc1yb50KhqpZ4XmcDkKNl/cFuafe9/HpYnLBHVZfFpkx1Xk3GuvN9Epaui82pJd0K/je1Rm+715kIwH4Is4IRGO8ELi8NjfWYu+lmp7DBeIV4U5qDZ58CQ/hi91AU/xROe/gs56CRQcG75YWv6qYBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaQAlvHzh9YiQ53hKpMyk3BUmXZnquwx2r+Np49b+jwUyRRAtiiN0QbB896h?=
 =?us-ascii?Q?rQNSEfUmszPR9zS00kNtI84DmhROItrvuggZg3dgNZ5Lyt/IRRP+9Yf0XXe3?=
 =?us-ascii?Q?eIjbz8Hswi0g8yLL9iWrlEHnApO9Zgq/3HtSCAklL4bv5gFo5OIytYWg2Ifs?=
 =?us-ascii?Q?227xSbFTBPcuq1pguebqE4RuGDgGrm3EnZAXUrfDoj6eyaCa1PZ43jPV0aC3?=
 =?us-ascii?Q?Vz7QVI++yxiZcwCiQYFe2dRqBsMU3qCnEIaGYnlZX5mlbSEWklcfCXUT1a2H?=
 =?us-ascii?Q?uD2OnOc06PNxiuErmSVwYBIq7aF/5mzunT5QuWihFKHKyKhu6iDgIW8rZXcW?=
 =?us-ascii?Q?StdWMIkiTtuef/fEgzJyH6+0NNNencWr+66cmvltnLqkKDxwqNDF8VGfIka5?=
 =?us-ascii?Q?7MTvG7zfMFJliK0VR5c/bnVBFAK7T8yETeO2jRyIVPIJ3iyUGg5y44y8qA1Y?=
 =?us-ascii?Q?UUNE81XHgTp/Qv7gPwfuNGBqUlBy7H+HZaF7212DwuHOJIRQVPFxlQKk8S1X?=
 =?us-ascii?Q?FApqU+mo96IQrQU1Vt7NUXkfrrTQnyRp8+Zv8MPgxvRrx4ahGmBuIdnlp8+D?=
 =?us-ascii?Q?ySDVEbm+AygLVzDIuaIov4pgxlMqQPB/50rnHIgSE2mEVks5t13ZJknHldgb?=
 =?us-ascii?Q?R1sURKvHJ1xuGGmz+fwXchANZCB/agokZcyHdpNPoT6ALj2M1VXVMVfbJy/O?=
 =?us-ascii?Q?agyxODHWZHtuE6tU7L6l5orW8gFV3F/+xtC+2ZVgfGXT7MHf80gOCxpD6cWG?=
 =?us-ascii?Q?bayoL8uqVVjVgqRA3QlNGkxFBOwx227fgADSh9SQunhgfiQ3px85g+VFDF5B?=
 =?us-ascii?Q?4Y1ezzkkHNxY/ZpWVWdc8Zpv6d3K9CZwUWMiROrGSOpMcikWpK+0pZixZzb/?=
 =?us-ascii?Q?EarpXW5XwXJ33Yh+Eh1Dbiuwpa0bj5ZO4UEVK2d4WywcWFdumFMFMO8tpV1B?=
 =?us-ascii?Q?l/yE+Kw2gCJnbZfpyMpjkMq5q48RsLnDpeMITS3cTkLEo+b8aV52Gyij5YB9?=
 =?us-ascii?Q?tfenbmWFRZwIxC1WQ1gFxFxIvjn0BaB51VNekmYE+xmdAiyOgKm9+JJw45Yn?=
 =?us-ascii?Q?vfs1z5WX0pOwWdMq2F2pw3OGizJxzuD8d9+xVPPfInUdVSzMgCQ7WdhUZx+X?=
 =?us-ascii?Q?xaOc6VAYwmW6QqHzUrvLv1wzBccNvLSOxe5s+FPeJxsJ7+B4WpYCqUtqm5zK?=
 =?us-ascii?Q?cQlXcFdwSBo+VsNu2/p9kiWoG5ZqLXf14EaANYNjohR7vS8tctlDBw3PkNMN?=
 =?us-ascii?Q?wmdn50DEDhlI8kyuuN4gy6p8BEIeg/kGxK45U3fCGypUa10+f/QeVVCJJLfm?=
 =?us-ascii?Q?uz4o8Ad1NDXvwNiIeuczwF2w8clmK1RGBvMHQnsf7rHYSNEUCuHOE45Lo09E?=
 =?us-ascii?Q?v/qyqwzy9pVcehA63e1d/yYfG4QFwgdHIIW82lsp/KDZs0Vnf3N3U4PiDL8k?=
 =?us-ascii?Q?e4RJkilT8C7r2CHfSgxObyOW6kZpIx4vcJtdACS2kZ4+wvLINMOezHt2j6yu?=
 =?us-ascii?Q?jsxeYGw8EMZOc1vFHmFwM/tnpdGGM/yjkHd4Ymr0ztSHkdzSGjtfwCzAH9mA?=
 =?us-ascii?Q?Uw5Y8/rwED9Vc1L/p18TbtN0LpmeW7T70bzWc+mkzkWVmOqgIEEcuKKheEK4?=
 =?us-ascii?Q?d4niwS2DMVee8sJrROWyWXl6SYVn6Clw4QEtWtNKZUUwWpLHZrYSzpSzJ4JR?=
 =?us-ascii?Q?qXAlV3HjlXQM95mf0nJg254S8NQ+Ajjd/VZ4ucbRMWYgOsl4kkbCUb2JOsk2?=
 =?us-ascii?Q?vztmVnqbMUnpe4NGn16alt9lcJPy30+P9SRzKgIb3MK5op2oSVtj?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7defb20a-a1d4-413b-fcd9-08deacc3db1b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:12.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ohjDhLRWgpF+5vRu2mt0Wc5f3SGkMQeYfcm8I17mGV3cSI+4g55e3K+3F1D08IOu+bntjuHd8x84+mm0io4+9cM01AN6vwYlR8WOOKRETBfdWWq6Ejzk5MDlqURjlec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1252
X-Rspamd-Queue-Id: 70B164F2023
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
	TAGGED_FROM(0.00)[bounces-285645-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.899];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Action: no action

Add driver for the StarFive JHB100 Peripheral-2 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per2.c   | 178 ++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per2.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 72cf314c6cfc..01d6d325dcd0 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -89,6 +89,14 @@ config CLK_STARFIVE_JHB100_PER1
 	  Say yes here to support the peripheral-1 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER2
+	bool "StarFive JHB100 peripheral-2 clock support"
+	depends on CLK_STARFIVE_JHB100_SYS0
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the peripheral-2 clock controller
+	  on the StarFive JHB100 SoC.
+
 config CLK_STARFIVE_JHB100_SYS0
 	bool "StarFive JHB100 system-0 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 51511086a727..044e1942ccfa 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER0)		+= clk-starfive-jhb100-per0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER1)		+= clk-starfive-jhb100-per1.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_PER2)		+= clk-starfive-jhb100-per2.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-per2.c b/drivers/clk/starfive/clk-starfive-jhb100-per2.c
new file mode 100644
index 000000000000..7f34d521c798
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-per2.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 Peripheral-2 Clock Driver
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
+#define JHB100_PER2CLK_NUM_CLKS			(JHB100_PER2CLK_MAIN_ICG_EN_GMAC3 + 1)
+
+/* external clocks */
+#define JHB100_PER2CLK_NCNOC_INIT		(JHB100_PER2CLK_NUM_CLKS + 0)
+#define JHB100_PER2CLK_CFG_400			(JHB100_PER2CLK_NUM_CLKS + 1)
+#define JHB100_PER2CLK_CFG_125			(JHB100_PER2CLK_NUM_CLKS + 2)
+#define JHB100_PER2CLK_GMAC2_RGMII_RX		(JHB100_PER2CLK_NUM_CLKS + 3)
+#define JHB100_PER2CLK_GMAC2_RMII_REF		(JHB100_PER2CLK_NUM_CLKS + 4)
+#define JHB100_PER2CLK_GMAC3_SGMII_TX		(JHB100_PER2CLK_NUM_CLKS + 5)
+#define JHB100_PER2CLK_GMAC3_SGMII_RX		(JHB100_PER2CLK_NUM_CLKS + 6)
+#define JHB100_PER2CLK_OSC			(JHB100_PER2CLK_NUM_CLKS + 7)
+
+char *jhb100_per2_ext_clk[] = {
+	"ncnoc_init",
+	"cfg_400",
+	"cfg_125",
+	"gmac2_rgmii_rx",
+	"gmac2_rmii_ref",
+	"gmac3_sgmii_tx",
+	"gmac3_sgmii_rx",
+	"osc",
+};
+
+static const struct starfive_clk_data jhb100_per2crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER2CLK_300, "per2_300", 2,
+		      JHB100_PER2CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER2CLK_100, "per2_100", 4,
+		      JHB100_PER2CLK_CFG_400),
+	STARFIVE__DIV(JHB100_PER2CLK_50, "per2_50", 2,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC2_RMII_50, "gmac2_rmii_50", 2,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN0_CORE_DIV, "can0_core_div", 20,
+		      JHB100_PER2CLK_CFG_400),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN1_CORE_DIV, "can1_core_div", 20,
+		      JHB100_PER2CLK_CFG_400),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN0_TIMER, "can0_timer", 100,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN1_TIMER, "can1_timer", 100,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_RTC_CORE_DIV, "rtc_core_div", 763,
+		      JHB100_PER2CLK_OSC),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_RMII_MUX_DLY, "gmac2_rmii_mux_dly", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_REF,
+		      JHB100_PER2CLK_GMAC2_RMII_50),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC2_RMII_DIV, "gmac2_rmii_div", 20,
+		      JHB100_PER2CLK_GMAC2_RMII_MUX_DLY),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_RGMII_125_MUX, "gmac2_rgmii_125_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RGMII_RX,
+		      JHB100_PER2CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC2_RGMII_DIV, "gmac2_rgmii_div", 50,
+		      JHB100_PER2CLK_CFG_125),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_TX_MUX, "gmac2_tx_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_DIV,
+		      JHB100_PER2CLK_GMAC2_RGMII_DIV),
+	STARFIVE__INV(JHB100_PER2CLK_GMAC2_TX_180_BUF, "gmac2_tx_180_buf",
+		      JHB100_PER2CLK_GMAC2_TX_MUX),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_RX_MUX_DLY, "gmac2_rx_mux_dly", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_DIV,
+		      JHB100_PER2CLK_GMAC2_RGMII_125_MUX),
+	STARFIVE__INV(JHB100_PER2CLK_GMAC2_RX_180_BUF, "gmac2_rx_180_buf",
+		      JHB100_PER2CLK_GMAC2_RX_MUX_DLY),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY, "gmac2_txck_mux_dly", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_50,
+		      JHB100_PER2CLK_GMAC2_TX_MUX),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC3_TX_125_MUX, "gmac3_tx_125_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC3_SGMII_TX,
+		      JHB100_PER2CLK_CFG_125),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC3_RX_125_MUX, "gmac3_rx_125_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC3_SGMII_RX,
+		      JHB100_PER2CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC3_TX_DIV, "gmac3_tx_div", 50,
+		      JHB100_PER2CLK_GMAC3_TX_125_MUX),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC3_RX_DIV, "gmac3_rx_div", 50,
+		      JHB100_PER2CLK_GMAC3_RX_125_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_SENSORS_PERIPH2, "sensors_periph2", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_FAN_TACH_PCLK, "fan_tach_pclk", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_I, "ether0_rmiiandrgmii_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_TX_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_I, "ether0_rmiiandrgmii_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RX_MUX_DLY),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_180_I, "ether0_rmiiandrgmii_tx_180_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_TX_180_BUF),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_180_I, "ether0_rmiiandrgmii_rx_180_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RX_180_BUF),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_PTP_REF_I, "ether0_rmiiandrgmii_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_50),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RMII_I, "ether0_rmiiandrgmii_rmii_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RMII_MUX_DLY),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_CSR_I, "ether0_rmiiandrgmii_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_ACLK_I, "ether0_rmiiandrgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_300),
+	STARFIVE_GATE(JHB100_PER2CLK_RMIIANDRGMII_IOMUX_GMAC2_TXCK, "rmiiandrgmii_iomux_gmac2_txck",
+		      CLK_IS_CRITICAL, JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_TX_I, "ether1_sgmii_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_TX_DIV),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_RX_I, "ether1_sgmii_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_RX_DIV),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_TX_125_I, "ether1_sgmii_tx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_TX_125_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_RX_125_I, "ether1_sgmii_rx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_RX_125_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_PTP_REF_I, "ether1_sgmii_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_50),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_CSR_I, "ether1_sgmii_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_ACLK_I, "ether1_sgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_300),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_PHY_PCLK_I, "ether1_sgmii_phy_pclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_REF_25_I, "ether1_sgmii_ref_25_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_OSC),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_CAN0, "main_icg_en_can0", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_CAN1, "main_icg_en_can1", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_DMAC_8CH, "main_icg_en_dmac_8ch", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_RTC_SCAN, "main_icg_en_rtc_scan", CLK_IS_CRITICAL,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_ADC0, "main_icg_en_adc0", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_ADC1, "main_icg_en_adc1", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_GMAC2, "main_icg_en_gmac2", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_GMAC3, "main_icg_en_gmac3", 0,
+		      JHB100_PER2CLK_100),
+};
+
+const struct jhb100_crg_domain_info jhb100_per2crg_info = {
+	.clk_data	= jhb100_per2crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_per2crg_clk_data),
+	.ext_clk	= jhb100_per2_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_per2_ext_clk),
+	.rst_name	= "jhb100-r-per2",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_per2crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-per2crg",
+		.data = &jhb100_per2crg_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jhb100_per2crg_match);
+
+static struct platform_driver jhb100_per2crg_driver = {
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per2",
+		.of_match_table = jhb100_per2crg_match,
+	},
+};
+module_platform_driver(jhb100_per2crg_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 Peripheral-2 Clock Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


