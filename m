Return-Path: <netdev+bounces-261009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NL0D40Rn2nNYwQAu9opvQ
	(envelope-from <netdev+bounces-261009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:13:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C9B1994EA
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51AC33125092
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A739B3D7D73;
	Wed, 25 Feb 2026 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H8gQgPVE"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CF3D6491;
	Wed, 25 Feb 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032063; cv=fail; b=WMHfTERRLtOuaiMEjI8IsA6DXpvktjQYT5e9ygWBT229Vy8rwJBq6mQWq+yeXziLHJHc+DMXbn6eau0oDbgbYbhftschsxweNnir4E62oOKCkWUqTBYuOtGqvyuC+gZzJfEP8sd4uRswDqBfA6wJE64NZDzeRZgahdytvGrIiNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032063; c=relaxed/simple;
	bh=n9Np0wFOf2lBIa1vz6KISIRUdoqCIWZG8ayfCDrt4A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DG++p/k2ErzliD+wUSZ3uFGhJ41U8aNr7QF1cRySKZaumkrodBh+6yLAq9UGXARx+jBDU5mycZXb1XbKLvR+FGAn0DSRoqQ/wvgarqYUqy3+qmu8qzqddj6Ohv2jAGmkGsfqh4ETrAcyAnGWV0KViW5zIZsHeHmCEtU3ilQ+h8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H8gQgPVE; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U60+MJuu5lFdyPmPn1yxAEOa1/LfydW4HLunPAmKSUivK83MNU2Cpxhm3JQ6IZXpwf3f+4OATUCp7XQEtgtY0aInae/2Dx3BxlmvZUJKjTLEbuqG4up8dxH1sRUivZcRANO7BFQrLAa1RJ68ZDYzZu0AuMMnVeNW4NDCXLwC8V/nxI6zw7wZP+vqyTbDIyJnL2uqWsiihZsAWMIRah77RCD/uVb4ViPp0R1fI0QSEcQw7xCluv5yuXfBtMaU0ZUBngVpQRCg2m3opftXnE8pr6MfKVtOqYBnm7lHcPcaPOADbcNNGyCdNqwkF4tAz7nE8sGNd4VTJUn35KYpQu1MXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA3ro42IfC1mIhkhpUsKLtJSTSwraMopxFZSxP4x+3w=;
 b=CVD2kJ83ZcgSkEUhg7h+Vtvjz8dDCoPdHNEn0Jq30KlA3/bL2Y/AblAm6wMCOJAEBvKmo/mAeYA7RwEWIlbfug8V+HUe9yPriJ3t94cLyz4ets0Wx5pRMa56hdxDUnEZbk3k7phUBYjlCS0LJqAiofHm7fdZCYHIPiwtsWMcTuxBBo4Bfv/tOh1PuvGLX6NSWiTwfihlhxD9MHF2VvKsOdJfxZ399/2QKVDacNr7CX0VwumQz6uk2Y/bt63nMKG74Z20vafeMszSzoS+a8FOfs28oIw1HHlbYxovJpQ2lqFTtmkav83kvnlzOzutm4+rP05VFjSGXQjW3ouxYsFGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA3ro42IfC1mIhkhpUsKLtJSTSwraMopxFZSxP4x+3w=;
 b=H8gQgPVE/OffCYsqiaZCfVSc4i5glCnt2q7TmHEHMGUe7/8dI1lMlL/ts8t7Qt0W17HB7Xo9/ERGjdyIb5/Qh2eTSgVMdcR3bwYprjfMsTbgVbWHs6C80zv0CdOYKymUrauI2P4+du0emGpmPG6sLh2lvwxz17lv7JCc5ZXaCRh9/SFYm06R3jk1WKR2Xqzf/Djl1SICyT9KV5buZP6im3uleKaN5OX7vzAgAMCFx+KtwfMzqP7Z+YRmchBRuRmVDpqVezkqNurCiJzi/TXW5H9CWdozOizFv8/J6MgKdj0XPvRiEOl2IpESaqVm0uhrVRp28vePvVRdv6x9IwvZbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:07:29 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:07:29 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/5] net: dpaa2-mac: extend APIs related to statistics
Date: Wed, 25 Feb 2026 17:06:44 +0200
Message-Id: <20260225150648.1542206-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::9) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: f703c87c-0953-4a78-bc6c-08de747f97d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	hIM3CudjY3lzV85nFVjg3Jdu+WEoWTofxiSbIhFyB4/dbSAO5rUplSYTq8YONLbthZrCpZhIRsBfJPpIY1S7Xp8OH50JoH0hI9z5uN2dCZvL2c2y3oCjuXERWdH1o1IhVJ/lA6k7bha2Ah4Xk9Hwf5lweDpwp0FRH7hS7xstYn7Wnhb/ClRb+qZpfsvNERizbq7/ADdRlQD6A2qzXshrXs/ii5FWm8CFK0aLLeLaXbNeS6aC133N2EOzHsq0gr7Ve04oLB6SR1p3SMqrSZQIe1YmpnCAr71n7f0ioxaLC/jYYbpjXlmyKHg8uZ2XUm0gpxVVZWpuuwU+McGn/dClL2aob6YposFvSzMG8TvljjEnthIbgnFNcFLQZPWQknzDULdFTTy3+nmFZmjBe16qz8N4N9jhXHC57dgUA9wOo2W+pSnFDuEF6a4IC3rxfZqJ/vRhY4PipkSWONZDZp3ufokai+L+K+XzThjpBhdNeebuDDLwI2Jk56j/wCnLQa5fC1Ebzf7V6pGI8hPzbG87nvrsX22OufzGaRy9dCqehScrmd7LFFbtLBfrBYCbAv6BSwahyVVUUwUyxa5R7RflsVPmKOGN8Wa3xvQ2nHXWbCKopvuGAsrtt99OLtGALuCNxQ/LckcaLyR/lijJOKcicKWbhKcZIAINGbMdMYqxUbZWUhJT33rbBgeLgOJqa9YNx/hpAhNIGphLRAOl6kQ1e6DUdaSfGKOZSaTJbkl+HyE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lCAQx7MhgfAYAvr1OQ75s8Jd/WyPgvdEciOH96n/hdUdwBHfhaJZl5F48HG4?=
 =?us-ascii?Q?kbUlOEMzuXCOaa/zPfBWQNvKSviOuPfMD5Ca4afUHH7Vbi7aSChv03W3Bo8q?=
 =?us-ascii?Q?kTKpu6Bt35c75RrZ3+GII4oeJYKgjVo4tl0DJhcfnrx/+axgXNe98j8wYNhO?=
 =?us-ascii?Q?PQVUKw5KxPt71FOw26b24orbZqpaF4ITF5vYOaHKNRKHAvBukvPP36kpKHqe?=
 =?us-ascii?Q?6xZcIDtUIzRDNefOJnuKtzM7ys2vnN/9x6y4gNBLyv6JYpPv9X2JuoGG7ifv?=
 =?us-ascii?Q?lvvXyBN6D8aXStKpe9TQkOkU8p1ZcoM0u7QDlak7I7O/hU4q+4r5HAxedhVF?=
 =?us-ascii?Q?HFa8Q8AQH/4dlBSsg49xGIimwpaK5ycQ/KBC4NBa9hW6y5vmFIgAmnbbdVs0?=
 =?us-ascii?Q?WH4sTkd9VvWfCGbZ/u3luaEpjwjgaF/S+4xjwxpiaQdHzoDKYck4JyJtI/cu?=
 =?us-ascii?Q?sch0nyMehuy3rwyhFxBsxFIq4Z/42uBlzYNoT//lSQo8eGcawLBpS4mrA2aI?=
 =?us-ascii?Q?8ahY0KtzZtqMtF5lT61nu0+cmVzmclSmTS7s9UIFpRjUnILJltlB+Df7X47m?=
 =?us-ascii?Q?cOAoJU3m+JsdXl76DqcbB4pS4LH8ELp0EkJw1ezRrcHF7lsRwK7u6WX6CR6b?=
 =?us-ascii?Q?7tnsZfLKNTNHn0/+xx1u4R43BPaFabBHjb08wk6lb+o7Dq1J0kpGkVmcSbvq?=
 =?us-ascii?Q?vRD6JdYAvegX9GIak7wnw1RlnTNdfIq+95LszVQURNhjxPEbz1H/lBfIZvj2?=
 =?us-ascii?Q?ZRX5xK/RFEIq07/Gvf6lMSJHDFYtUbnsfJwe1/npP6vZfuYcghHhHpNqi/fK?=
 =?us-ascii?Q?JkrvNgJnxZcbKLPIN4HvZ8KNfOwEsUU++ilxv5DrM/hina/okmjVX6vGaeGX?=
 =?us-ascii?Q?hompuuRIh8+491cRONfrnyHVw4YKp0Nb0V5IA05eX4LaxuzC3TT7YZjFF13P?=
 =?us-ascii?Q?e0Lx8GmPv7MrJ8ir8/1lAUnGeL5DNl4LOcviE4Ms1iO5M1TpITnYUjaY9+jw?=
 =?us-ascii?Q?OrCG6lWooNXAhTdwcL33Pxnv8M/1jwvNQAgXbUIrQSYe8N8g/XCuGru8gHo9?=
 =?us-ascii?Q?9o2NZ6f+yFl2HROPovusR8jEjPZUjYCuCF8YTtaTq8L6byfh7Da0+NAoOuQt?=
 =?us-ascii?Q?+4WTeUhRDFv7m87Jpx8xmy400giNMo1ADub4B9OnaRglzw2cLwBwnz6YqPyQ?=
 =?us-ascii?Q?Sh6dDzLU4HE9Ltpy+mUDV7iiIbhidNu6F/Ljt90PB8K65QVXmkiou4PKApzV?=
 =?us-ascii?Q?xKPQaZMDBBRq/WffUxVMHjgHa61YjnIEL1CXym3HvA9+eKd4cYtXqNfZTEjQ?=
 =?us-ascii?Q?RKuZ2nl7yC3VIxFSxJlNn+LKd7lYVAjm4pFgvBUMmAZDhuKnIWkHOmkb7+5h?=
 =?us-ascii?Q?BGfh6fDP8igFoPNLXu5P1swc98OgthNrnnLp4SC42NC5i7F/9DikLHPatzv4?=
 =?us-ascii?Q?FJdHZrMI5xd18G1b4LZglmAxFzlLB9OVYAURts+rTvKbVWUfwtf+A7uvfOKn?=
 =?us-ascii?Q?4IqfHDzWiqV8zJR7WvBBH6Ge64MGHZs4GVSzRz+pPVnSb6cF8zMWBOLRiF24?=
 =?us-ascii?Q?/cazGIwg7Bks5xrE1h+Qxgf0YEozPkgQIA//b2eWGBdyuUGd0CaX2hbR1lxn?=
 =?us-ascii?Q?6QpR6/KOy+fTgQw6RsCx/P6zHAAyaiZKeiHP7DhR1D76K4NNKUbX87dQj6AY?=
 =?us-ascii?Q?GXdc7t0vwN8Np/CL9fhMiZAUy/vcXCKlZUA80HVULShUBioXZ1jp2YX6PJIT?=
 =?us-ascii?Q?JTWlYUUgkQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f703c87c-0953-4a78-bc6c-08de747f97d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:07:29.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbP/1emIT9y9UQKCvoMdXPzwH/nDAXbMXui8UTRiecgxxjMwzZ6E3UP+p1w8cv4wd+qhjwiOqj8af4dzGbw18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261009-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2C9B1994EA
X-Rspamd-Action: no action

Extend the dpmac_counter_id enum with the newly added counters which can
be interrogated through the MC firmware. Also add the
dpmac_get_statistics() API which can be used to retrieve multiple MAC
counters through a single firmware command.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  | 11 ++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  | 30 ++++++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  | 86 ++++++++++++++++++-
 3 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
index e9ac2ecef3be..a864a99a0f75 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef _FSL_DPMAC_CMD_H
 #define _FSL_DPMAC_CMD_H
@@ -28,6 +28,8 @@
 
 #define DPMAC_CMDID_SET_PROTOCOL	DPMAC_CMD(0x0c7)
 
+#define DPMAC_CMDID_GET_STATISTICS	DPMAC_CMD(0x0c8)
+
 /* Macros for accessing command fields smaller than 1byte */
 #define DPMAC_MASK(field)        \
 	GENMASK(DPMAC_##field##_SHIFT + DPMAC_##field##_SIZE - 1, \
@@ -82,4 +84,11 @@ struct dpmac_rsp_get_api_version {
 struct dpmac_cmd_set_protocol {
 	u8 eth_if;
 };
+
+struct dpmac_cmd_get_statistics {
+	__le64 iova_cnt;
+	__le64 iova_values;
+	__le32 num_cnt;
+};
+
 #endif /* _FSL_DPMAC_CMD_H */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.c b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
index f440a4c3b70c..8957665c05fc 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #include <linux/fsl/mc.h>
 #include "dpmac.h"
@@ -235,3 +235,31 @@ int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+/**
+ * dpmac_get_statistics() - Get MAC statistics
+ * @mc_io:       Pointer to opaque I/O object
+ * @cmd_flags:   Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:       Token of DPMAC object
+ * @iova_cnt:    IOVA containing the requested MAC counters formatted as an
+ *               array of __le32 representing the dpmac_counter_id.
+ * @iova_values: IOVA containing the values for all the requested counters
+ *               formatted as an array of __le64.
+ * @num_cnt:     Number of counters requested
+ *
+ * Return:       '0' on Success; Error code otherwise.
+ */
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt)
+{
+	struct dpmac_cmd_get_statistics *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPMAC_CMDID_GET_STATISTICS, cmd_flags, token);
+	cmd_params = (struct dpmac_cmd_get_statistics *)cmd.params;
+	cmd_params->iova_cnt = cpu_to_le64(iova_cnt);
+	cmd_params->iova_values = cpu_to_le64(iova_values);
+	cmd_params->num_cnt = cpu_to_le32(num_cnt);
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.h b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
index 17488819ef68..857b40a5b339 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef __FSL_DPMAC_H
 #define __FSL_DPMAC_H
@@ -170,6 +170,50 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
  *			      pause frames.
  * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
  *			      pause frames.
+ * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
+ * larger (up to max frame length specified), good or bad.
+ * @DPMAC_CNT_ING_ALL_BYTE: counts bytes received in both good and bad packets
+ * @DPMAC_CNT_ING_FCS_ERR: counts frames received with a CRC-32 error but the
+ * frame is otherwise of correct length
+ * @DPMAC_CNT_ING_VLAN_FRAME: counts the received VLAN tagged frames which are valid.
+ * @DPMAC_CNT_ING_UNDERSIZED: counts received frames which were less than 64
+ * bytes long and with a good CRC.
+ * @DPMAC_CNT_ING_CONTROL_FRAME: counts received control frames (type 0x8808)
+ * but not pause frames.
+ * @DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC: counts the fully dropped frames (not
+ * truncated) due to internal errors of the MAC client. Occurs when a received
+ * FIFO overflows.
+ * @DPMAC_CNT_EGR_ALL_BYTE: counts transmitted bytes in both good and bad
+ * packets.
+ * @DPMAC_CNT_EGR_FCS_ERR: counts trasmitted frames with a CRC-32 error except
+ * for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ * are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all trasmitted frames, good or bad.
+ * @DPMAC_CNT_EGR_CONTROL_FRAME: counts transmitted control frames (type
+ * 0x8808) but not pause frames.
+ * @DPMAC_CNT_ING_PFC0: number of PFC frames received for class 0.
+ * @DPMAC_CNT_ING_PFC1: number of PFC frames received for class 1.
+ * @DPMAC_CNT_ING_PFC2: number of PFC frames received for class 2.
+ * @DPMAC_CNT_ING_PFC3: number of PFC frames received for class 3.
+ * @DPMAC_CNT_ING_PFC4: number of PFC frames received for class 4.
+ * @DPMAC_CNT_ING_PFC5: number of PFC frames received for class 5.
+ * @DPMAC_CNT_ING_PFC6: number of PFC frames received for class 6.
+ * @DPMAC_CNT_ING_PFC7: number of PFC frames received for class 7.
+ * @DPMAC_CNT_EGR_PFC0: number of PFC frames transmitted for class 0.
+ * @DPMAC_CNT_EGR_PFC1: number of PFC frames transmitted for class 1.
+ * @DPMAC_CNT_EGR_PFC2: number of PFC frames transmitted for class 2.
+ * @DPMAC_CNT_EGR_PFC3: number of PFC frames transmitted for class 3.
+ * @DPMAC_CNT_EGR_PFC4: number of PFC frames transmitted for class 4.
+ * @DPMAC_CNT_EGR_PFC5: number of PFC frames transmitted for class 5.
+ * @DPMAC_CNT_EGR_PFC6: number of PFC frames transmitted for class 6.
+ * @DPMAC_CNT_EGR_PFC7: number of PFC frames transmitted for class 7.
  */
 enum dpmac_counter_id {
 	DPMAC_CNT_ING_FRAME_64,
@@ -199,7 +243,41 @@ enum dpmac_counter_id {
 	DPMAC_CNT_EGR_UCAST_FRAME,
 	DPMAC_CNT_EGR_ERR_FRAME,
 	DPMAC_CNT_ING_GOOD_FRAME,
-	DPMAC_CNT_EGR_GOOD_FRAME
+	DPMAC_CNT_EGR_GOOD_FRAME,
+	DPMAC_CNT_EGR_FRAME_64,
+	DPMAC_CNT_EGR_FRAME_127,
+	DPMAC_CNT_EGR_FRAME_255,
+	DPMAC_CNT_EGR_FRAME_511,
+	DPMAC_CNT_EGR_FRAME_1023,
+	DPMAC_CNT_EGR_FRAME_1518,
+	DPMAC_CNT_EGR_FRAME_1519_MAX,
+	DPMAC_CNT_ING_ALL_BYTE,
+	DPMAC_CNT_ING_FCS_ERR,
+	DPMAC_CNT_ING_VLAN_FRAME,
+	DPMAC_CNT_ING_UNDERSIZED,
+	DPMAC_CNT_ING_CONTROL_FRAME,
+	DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC,
+	DPMAC_CNT_EGR_ALL_BYTE,
+	DPMAC_CNT_EGR_FCS_ERR,
+	DPMAC_CNT_EGR_VLAN_FRAME,
+	DPMAC_CNT_EGR_ALL_FRAME,
+	DPMAC_CNT_EGR_CONTROL_FRAME,
+	DPMAC_CNT_ING_PFC0,
+	DPMAC_CNT_ING_PFC1,
+	DPMAC_CNT_ING_PFC2,
+	DPMAC_CNT_ING_PFC3,
+	DPMAC_CNT_ING_PFC4,
+	DPMAC_CNT_ING_PFC5,
+	DPMAC_CNT_ING_PFC6,
+	DPMAC_CNT_ING_PFC7,
+	DPMAC_CNT_EGR_PFC0,
+	DPMAC_CNT_EGR_PFC1,
+	DPMAC_CNT_EGR_PFC2,
+	DPMAC_CNT_EGR_PFC3,
+	DPMAC_CNT_EGR_PFC4,
+	DPMAC_CNT_EGR_PFC5,
+	DPMAC_CNT_EGR_PFC6,
+	DPMAC_CNT_EGR_PFC7,
 };
 
 int dpmac_get_counter(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
@@ -210,4 +288,8 @@ int dpmac_get_api_version(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		       enum dpmac_eth_if protocol);
+
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt);
+
 #endif /* __FSL_DPMAC_H */
-- 
2.25.1


