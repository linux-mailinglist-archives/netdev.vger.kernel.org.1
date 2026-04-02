Return-Path: <netdev+bounces-274483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WClbKNZUzmmEmwYAu9opvQ
	(envelope-from <netdev+bounces-274483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:36:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E438869B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EFC7310683C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1023C3C0F;
	Thu,  2 Apr 2026 11:14:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1EB3C13EE;
	Thu,  2 Apr 2026 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128463; cv=fail; b=T+lwUZ2qVCKZJA3NDqfX+AlLxhVLMAxd7YtWjDsGT7hsTtsUJaPEqedcqeL6NmDKOraRZdv5CEqa17S2Pnr+wTM8u7JTOy19p/zcFB2xpUrkC6LOGVQyzK2ZLL6enycNYObIZiA5YJRlPsbVnnSJIuK+I8S2rExt5YrohNMT78E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128463; c=relaxed/simple;
	bh=kauXsfDEuWs964peO2iiM8B6rmL7lIZQYl3Z1mQW67Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhrHaiEDi3XxrU9wvTgfoHqeq4fc8KHHaw1bjYpsQy6ZDncbEZ3jsLlbcPAMalTkFZ9mBqn1sjXjTd2F50pvKnTbKLfavfiXNhg7iYI5wL0sBMFwDiA8lbBNnNWjQSVsv74chGZ+lZzs6ijHoyizGXjKcb8HzDSrYlqqObHBOwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5nfS3K7/I6iJnlS6CeQuGWqAuhyIdp7w+H5fTWNhTI/eEqQYfalVFK7iLZpzFQXVjQKBLJ56ovWYMwrNBSrwXjNww35A5GneClVD9jcSJwnrbO6vCDmWxU9qovx39f/VWlLcwbL9oXFF1lBOGkFc/mDeQqSjHsQib76Gg4cbbxGGvmcL/oAuyAV0V1nHRjU26gkveOvEEp/h1a8HMIPUsaLw3PvdcNNHPj0GpU85tslA/dV8y/4tvTcSCJh2JNpgYEB6/QH5rHTid240cYZCPsfhhNAo/hnB/t++ElbwwSK2jvF16jYlPTB0L6ywcER8tEOQ8Q5FNYrZHAR7vZOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5lroEHcYLQquh/2JX6XWY8GUY8M+R22+DeOV5Hj0AE=;
 b=mGYKQZ0fCwtCu2CublY0z0iFqduROFLMjLYFQaGv6Vqbd13+iat4QTrC0G1wh4hImToilfxp5l8aNGjgieGyv1fRSQ7zU0FBZN8Ng3QIn1FT/40ojhTd2DOEZS+8y2thPhd6WqPcQ89EMjER9oT9IjLyhxtH8o6XlgkqAoX0SFPGPVFYJROzikYyhlScR3tRO1TYC348eovkGm4Hl8hQoV+pSgm7D6cFkTKqg+LcspXt/KffeGLr5A/aPKuRfSc1Qo4k2BfSqDAGFbD2rNHtsocUMkASV2ynwhpR+mcmsQsVf9wXGSb7VE4ZIQK5B6Nu0Z6OfJT45Of6b1WfiGex2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:20 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:20 +0000
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
Subject: [PATCH v1 20/22] clk: starfive: Add StarFive JHB100 Peripheral-3 clock driver
Date: Thu,  2 Apr 2026 03:55:21 -0700
Message-Id: <20260402105523.447523-21-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn (10.2.0.210)
 To ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn (10.2.3.165)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB1048:EE_
X-MS-Office365-Filtering-Correlation-Id: b82cf2b4-7707-45bc-4b5d-08de90a678f4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pfO4XB9C+UHpQau1RftyqDX/8Y4eVk3YMGh6CWVLUC3KBjvOAFnLuBxRzvmBo1NPjx4/RwWms+xOsrRsO7YK4cO22eHlanp81irFPKFafQx94mKM461XGTqwflrQA/Ze0Y/FM6OfDa+yE6MeqR/xqrwI9HUcXRljLrd7+sLxU3bw0d7djULUyTjbVzOMFZ03XYaSp31V4oEpKeiG5+7eMST7Prjei+6I3JgXekZfUTTV0N5MqwTfgn7CVP+hOx9OEyuX1nHnZrklDw0RJjFTTl/qQxb+/jfzoYFpaShcAXJyTpy8pFyglTMlmhu/AMaSGxhyEV3CN0lY0nnKlkK3HrRy4TO8waPV50VaENZ3tRiCQGpr1fluXO2W/F+CCcDqfSmd1ENAXLrzIS3IN9D1uIYfu6i4en2kNCh8BzzMXjf+mRdYSUdUGWvP+Xrkc9IpNBAojCgcrsocH5Sahlg0haJN57GcSuqfmuvOhQLDF15b45dFXrFXVww15i5ayFzJukm+tBsEdl8V6GPYZFIhf9iSxQYSrgdzAQHocfXQAvGyY67xkkwz5p63WNBKe3DbFpvZhJwRTWg2Q8F0XEdg3y4WolfbVHDf8nO2OCGHLso=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BCU9SIykbWyxh2gSVGC4vRxusCnMnCmyabONVxevSFt/q9raNRPKXYWhev5M?=
 =?us-ascii?Q?Pcxiv4Tg97DJMMRcgHHrlxQoOlQyQEHfAkzTJexmZF/og6hZwXrOz4a4dEsj?=
 =?us-ascii?Q?zXKzDOz/6IQu8hOyunxJQMI9snlxvwNfWq3fEY59FC5vVNFeGUxCZTiVH0fz?=
 =?us-ascii?Q?5oOgp6gNQ5w54WVWeaAjB9/87kaT+N8wuBZ9Vj5PT0nq1rJYRR9IUAulgX5/?=
 =?us-ascii?Q?0BZ+utrOyadq3Fjo1tw6G92Ftv94p/mobPIfOqrMuAgSQoZwlBqq+75R6dLd?=
 =?us-ascii?Q?vyzcbvb1x+72ypptosEwzBM6r/MEUThuS+c3uzbYnzmaLtzxj2b15T7AZizB?=
 =?us-ascii?Q?Q23hkT0b75HjGTXzQ9V5PYLiH/FOo4aiTS2wnn4n8lVI9K2fhW5jFqBpvVBq?=
 =?us-ascii?Q?a5G6krTbBOWCQ/H4PixstHebGaRbBM21hNhiKM1b2Qx/uL/RY9Qz22yzH7Hp?=
 =?us-ascii?Q?G4dqY8SyI1O4KM+a1I4iF/cWbyvwJk5gU+EcN+neAdEFgqasobxj2YMUIeaY?=
 =?us-ascii?Q?KJFJDUXCl4XLlhZNV436TBkuT5E83PliK4Pyqu76k8iTmR1StmAluNJ1Chhl?=
 =?us-ascii?Q?sDThKg0T5H0Y3g4NTKvjZ2bbL2eP/lahZKOaKERkgT/GJwCEpJomL8l/eeGj?=
 =?us-ascii?Q?JEB6qDbPPH8S6EET7p+syvzBnbFgt0vWkD8x5PYwtMS3KgvVMKinybNGReuv?=
 =?us-ascii?Q?Npe0rswCn5oZnL3hnxHsiTAiqOF4du6s7Iop/N931XPvlI/bR9Zkb3Lq+hfw?=
 =?us-ascii?Q?9adoidYr7CNvqOalMQqzhEQZVBcnykyE3JPUO6UzCZU42glRwwbI+h+o+tmM?=
 =?us-ascii?Q?te7421PtWeJFyaZtp0XXusBHoGNnYuyGLUFhmDWLZgijS2g3KYfPfDkr04CK?=
 =?us-ascii?Q?3EbHnsZ/Il8FAwzXUgCGn/M9+nQfjxFP29Ax+7PcP95v80S+Gs3tZ3mQEqzX?=
 =?us-ascii?Q?32/MSNULK9BU/d9IwaGnjc+EMQPO210Pn4ZbZ5dC4Yde9JAQSfEJqhyr32MR?=
 =?us-ascii?Q?h8wmk6YHAQCVoznWM5aCD9le8anYTDasG03SssfdA+zNcdltfM/X4b+Njmj2?=
 =?us-ascii?Q?5xsMcFPL5zpJU1tUY+E8WhGwCx1h6k/h3JtkrdOiMJpNybeMfl4viSO0MLDE?=
 =?us-ascii?Q?VKPF3/2En9tUieQAg3pn2y8n5O24dPhWxS/nEjUowit9SHAdhX1Wcax8foAx?=
 =?us-ascii?Q?OJYMig9mPO4Zxa4y/1wmJ8UXzx7Nz6AF+uHU237CvOHbz79ZKia4a+ZuY5Lf?=
 =?us-ascii?Q?HVdjAHHO0Js3+MoOwPuhXnBgP0DL7AhYRSEegCtZ9GwbB7xWihpXhgkeUc+I?=
 =?us-ascii?Q?fg0J7wtkqCfshevNFsI1DkJSw7SxEbo8ob/dhAsCsg9k/ts/3Cu8D05XbQVL?=
 =?us-ascii?Q?G9Zy05fVLwH/PG3i+eHJEH34PNw2a+IWSKCLozNmJ4blJWG2CKzNV+n2vo9I?=
 =?us-ascii?Q?VTMj5jTNlwyJI7qOooV0uAYNzNJcEipOxbkMALZmlCtTORnL39d77WtAmd1r?=
 =?us-ascii?Q?hmf4uW3TzBlwom24jN+66MMQpGrP6UEUhL/m07HxpsPX4Q7fddQBqW4OjVBe?=
 =?us-ascii?Q?S4N6TV2Tb14hgjIkTq8/4T+HA9o0f8GN/jXFCoVLN8tTpAJMN3McQ5qqN1Iz?=
 =?us-ascii?Q?BekGtS7OdHGmBI2MOj/Szsg41ZQ+ldRAvp0nkePqK8Kah3fZevkh0C+HXUx4?=
 =?us-ascii?Q?x9UO2Vl14RDQWwZIuIacQMsYeHewwZjmW73FHYhDAWarA1Ean1LYHOgnAPvt?=
 =?us-ascii?Q?23C1a0fck8GNVDsrckMpLOs04v44zrlmZQhRIU1VKpw8uK5uZkDx?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82cf2b4-7707-45bc-4b5d-08de90a678f4
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:20.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3LSnmtTD9C5WtIpQlSr5eUuTykNEl7mxS1i6Y4If732Z0acLqlBjsnvI0BAhSdXXHTnZ8vB1GaUfi4+1ZZ0yEuVNywLMEY4wlavrccyC5AoOtLvTp4bhEE9MZOxyTY6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274483-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.901];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 345E438869B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add driver for the StarFive JHB100 Peripheral-3 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 189 ++++++++++++++++++
 3 files changed, 198 insertions(+)
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
index 000000000000..5533bb481f6d
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-per3.c
@@ -0,0 +1,189 @@
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
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include "clk-starfive-jhb100.h"
+
+#define JHB100_PER3CLK_NUM_CLKS			(JHB100_PER3CLK_MAIN_ICG_EN_GMAC1 + 1)
+
+/* external clocks */
+#define JHB100_PER3CLK_100			(JHB100_PER3CLK_NUM_CLKS + 0)
+#define JHB100_PER3CLK_125			(JHB100_PER3CLK_NUM_CLKS + 1)
+#define JHB100_PER3CLK_600			(JHB100_PER3CLK_NUM_CLKS + 2)
+#define JHB100_PER3CLK_OSC			(JHB100_PER3CLK_NUM_CLKS + 3)
+#define JHB100_PER3CLK_GMAC0_RMII_RCLKI		(JHB100_PER3CLK_NUM_CLKS + 4)
+#define JHB100_PER3CLK_GMAC1_SGMII_TX		(JHB100_PER3CLK_NUM_CLKS + 5)
+#define JHB100_PER3CLK_GMAC1_SGMII_RX		(JHB100_PER3CLK_NUM_CLKS + 6)
+
+static const struct starfive_clk_data jhb100_per3crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER3CLK_300, "per3_300", 256,
+		      JHB100_PER3CLK_600),
+	STARFIVE__DIV(JHB100_PER3CLK_200, "per3_200", 256,
+		      JHB100_PER3CLK_600),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_PTP_REF, "gmac1_ptp_ref", 2,
+		      JHB100_PER3CLK_100),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC1_TX_125_MUX, "gmac1_tx_125_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC1_SGMII_TX,
+		      JHB100_PER3CLK_125),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_TX, "gmac1_tx", 50,
+		      JHB100_PER3CLK_GMAC1_TX_125_MUX),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC1_RX_125_MUX, "gmac1_rx_125_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC1_SGMII_RX,
+		      JHB100_PER3CLK_125),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_RX, "gmac1_rx", 50,
+		      JHB100_PER3CLK_GMAC1_RX_125_MUX),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_PTP_REF, "gmac0_ptp_ref", 2,
+		      JHB100_PER3CLK_100),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_RMII_PLL, "gmac0_rmii_pll", 2,
+		      JHB100_PER3CLK_100),
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
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_100),
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
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_100),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_ACLK_I, "ether0_sgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_300),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_PHY_PCLK_I, "ether0_sgmii_phy_pclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_100),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_SENSORS_PERIPH3, "main_icg_en_sensors_periph3", 0,
+		      JHB100_PER3CLK_100),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI0, "main_icg_en_peci0", 0,
+		      JHB100_PER3CLK_100),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI1, "main_icg_en_peci1", 0,
+		      JHB100_PER3CLK_100),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC0, "main_icg_en_gmac0",
+		      CLK_IS_CRITICAL, JHB100_PER3CLK_100),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC1, "main_icg_en_gmac1",
+		      CLK_IS_CRITICAL, JHB100_PER3CLK_100),
+};
+
+static int jhb100_per3crg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JHB100_PER3CLK_NUM_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JHB100_PER3CLK_NUM_CLKS;
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx = 0; idx < JHB100_PER3CLK_NUM_CLKS; idx++) {
+		u32 max = jhb100_per3crg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jhb100_per3crg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jhb100_per3crg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		if (!init.name)
+			continue;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jhb100_per3crg_clk_data[idx].parents[i];
+
+			if (pidx < JHB100_PER3CLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JHB100_PER3CLK_100)
+				parents[i].fw_name = "per3_100";
+			else if (pidx == JHB100_PER3CLK_125)
+				parents[i].fw_name = "per3_125";
+			else if (pidx == JHB100_PER3CLK_600)
+				parents[i].fw_name = "per3_600";
+			else if (pidx == JHB100_PER3CLK_OSC)
+				parents[i].fw_name = "osc";
+			else if (pidx == JHB100_PER3CLK_GMAC0_RMII_RCLKI)
+				parents[i].fw_name = "per3_gmac0_rmii_rclki";
+			else if (pidx == JHB100_PER3CLK_GMAC1_SGMII_TX)
+				parents[i].fw_name = "per3_gmac1_sgmii_tx";
+			else if (pidx == JHB100_PER3CLK_GMAC1_SGMII_RX)
+				parents[i].fw_name = "per3_gmac1_sgmii_rx";
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, starfive_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jhb100_reset_controller_register(priv, "r-per3", 0);
+}
+
+static const struct of_device_id jhb100_per3crg_match[] = {
+	{ .compatible = "starfive,jhb100-per3crg" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jhb100_per3crg_match);
+
+static struct platform_driver jhb100_per3crg_driver = {
+	.probe = jhb100_per3crg_probe,
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


