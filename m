Return-Path: <netdev+bounces-302582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /vgbEa1YQmqq5AkAu9opvQ
	(envelope-from <netdev+bounces-302582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:36:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C46D9811
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:36:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=kdqzTwQV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302582-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302582-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E794315BCC1
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65237401A15;
	Mon, 29 Jun 2026 11:23:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2549400E19;
	Mon, 29 Jun 2026 11:23:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732224; cv=fail; b=qLZh0kA06d1uwEMNynxkyoOspbRruQMfN8Mj75KgUu6uFPEJKHVLHHJjdVfjdnWTau/rdZyXHlDz/9xj4EK/w7hpgYVm1JfSfWpp1CXRyrDdkyjYLpO05F2n5UXe2ALuHC0bcKX3Ix7Zomi8oVWprY+HxN7VEpDe7aoKoe2Y06U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732224; c=relaxed/simple;
	bh=pG+XmPfMwZkZGkTxTc5IsdocKnTn507Gh+MDxb/Fb/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WfRF0ZHWuuvJM8Yf8cI8dp3m2Ixe8+QcPLPDsM7Bm3F4dR4KWp85H1uLMzWvDZXulPRSLleV/fTlK8AK8d7EnwJWyHNJ2C6B3l4B6FtDLvxMA5HKGXRxZNTQYchUxhKjXgTWUpJhuxcfLzVJxQ+M7xy3rEExjysiGOwPNsTdpCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kdqzTwQV; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zV5QB8hcpwJINEzPWe+s7q8/SyHGf6IyZBXN3rNGurMD7YVmw7FNXQTzQxfQV5IDgc1jmlnLyfHVzxBTgMZ7c3jIBWbG2Z95V8CY+0yUrQX2puKarraX6/B/scPVtbqsphXQQ/x//CQYiYiPHG74NBdH7zCemJqYpjnh3QBbzXA/WM7+oOg5vtpRKz4z1YfTpbVk2VNEVbsPHJ9bAdzRTicQ85QwxeObwMSNvDIlE+0DPaVyjIuELW7nDDFbmq+268C+Zwoa0bLxNCZ6ukUrsGLPcrqvY3B6qPv6FnV8r4NI3rsO0jZWVvCOlnnwbUkLWKlkuDyae7fwJRc7Dj/z7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfy4j/5xIp04pH4iFzDwHQ/+jaBx1JfbsmO4hgQazHo=;
 b=S2CDItwMXkY75Ha7kQbO1eMvaU5ZcDlRwQa5KpsFEKDgAVXflUgLPbPWBwAx23bOhKnJJn56eAm54nTox4/u0kxA/JqZI4YRFCAuj+EDA3sr0xD94TrPNYyp4xkkGHUMQLSfhovW4z5DKsw2PuW8Du3s1+v52dd2PAtA6uCBMRtQkxDTm9zLhtVz6wPpcKdkTtgSP3BngFYzG6cCNhAmA31m3SCJeGCQ61dRbbQscrq0cfG+2vicx0afhKDrC9KTo5delpTbAJ0EEsQB8d2lwfKActy1Ofvc9++0YikAisW8+zYLinumqk9Srtenk5uT5o+gXcT2aRShN0VPnF7B2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfy4j/5xIp04pH4iFzDwHQ/+jaBx1JfbsmO4hgQazHo=;
 b=kdqzTwQV7zUUNt4suWvRhZbkPv/iTA5ybfqhfFfkQ7T9U/0rgiHeV5GZP87UOzycqxEurp5qNqV7UvsOKP1r1Q4brj3XAxewZQUJ5JLeT73AHN6yTaNkh1VhsVHOhe5dUvOfjpjXe8ZQv3h3A0kECPggQ0Ik9ZyYLsy0zBfCBLpV/JDI5VhJshvk4f8Rjax9+YK6jMfHtKIh3Yr+29FgKP9Q4i2PzKrek8Y0mYmf2WoqRabQojCt+j6DEPMRbrEbbseRFgIXCO1DpbsHy3i6Q2D3droXMvo/q/qc2WnJ7PQvqTvHxZNGqGaIvNPlaw7D3iijgqd23oDjw7MaGiCB0g==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:40 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:40 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 08/13] dpaa2-switch: add LAG configuration API
Date: Mon, 29 Jun 2026 14:23:04 +0300
Message-Id: <20260629112309.154328-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::7) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|AS8PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: ee700046-eff6-465b-acac-08ded5d0deef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jj4JAHjIpDhatGm+wm960vFLY9RrbUK72CzYTVY5PEMgiUt2QMEecXFpdWwrmVk6d95mn4bCOriPs6YeEnADLuEtaxZ8U3dK50mOATuhP/er8JEbpgJ1/iey98irLgx6NLrteJnixbJ4UUs7Fuasl0tcpBQr0EXgtkR5nU1oEdOnqE7KFglSCXQ5vrjE80xk7dDXWC4iU5ipTDMaptcSjJ9FoRcXQKJ/h25dOyje2F+DG2AzHrE67AgjgiFgjsU31XOjQVzG+NFAMnedV+WFQw1zFcw0U/XhULBlwHFUmeF5H9BhiJi8s5kizwiIvML20KfMSDy/4ESb2td/7bCBrltx1rDpvcCxjWNwoTeSL9rNRPuKu4HJGXRf1HL/kByk+rChXhzUMDYoyb1M622DiOYyvuQKhfNz1bHKGMSJUaTEtPCVmE1tEeGDrc1G+wzZcCl5SZPHR/q2IVpuH1VyL/lGF7YlAE6pVDgTgyzwF9PsJOjHyDZ9cxQFpd0TNIEOEtOP1AJZQFe51f6Y52N995Gqbx4B8Yy+QquXl6nEBXTJT2QTMsxRMuNdrm54FhmnybsfheKjG78Wdf3plP3wOB+JXKuu59FEyqunRmt5+wtDpx8KnHkSuW0ERKz3U60Ws1pTMZ/1JR+hKqkAGTc3fz4F0+JcDxQo63+aWheH5is=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pVOsHJImfDffR9lO/Fsed+EruGRiHU3M09fj/QUI9HDNE1ACUqZOXJZvwtP6?=
 =?us-ascii?Q?LcB5nQrCvPiSIk6zrFUaIYOZq+1xu3eehtSgEMNP730T8yDO6KcLLgfUz+SO?=
 =?us-ascii?Q?kVy7dUCQAkiTWBI0gQDO7ukSQEr5LSDKQ+2M1xrIB9NBuz8yYfQn6MFcC3Nw?=
 =?us-ascii?Q?DjNGr5+2hkmzpnge+JSMcpNvlXtKC2qTDkqGbOxHi4wyinV4KELHQhyi23mY?=
 =?us-ascii?Q?E8pj+Iai1I9gCa3Nd/U5fReqYFWjri+hmblbYI1ZCEIh+bmy26DImtz+fj1J?=
 =?us-ascii?Q?SWBEgRSzMu6hNRo3qTKeJxcydwtr3pSqjtwxruzthhQCN3C/gUS4/hgIY3TN?=
 =?us-ascii?Q?hqhlT9HMDUZ4J5md0wQU/ZkSw5Qg3ga0bPcjL92xi86pS4oBMwbzExLM9NFD?=
 =?us-ascii?Q?SfzMR+FhRJuNRwL9W5I796AADG3fZgWws3PnONOz3K7QnyCQ5sCRM0/i6KwY?=
 =?us-ascii?Q?XPTWhHizNs8UIFDcaU27re3ZAzsCcJR44meAVE+qf7BzRvMqx0xH9wWpSlCM?=
 =?us-ascii?Q?0YfCsPCmbYFmpLFAF6XzoszcpfFvfQGFCXnCb0/DZqEfBfw/J6fYtCIjCqJI?=
 =?us-ascii?Q?Pm+H6zCFOB0g9a8KUtmdf3iai5891abv6fCaedwivzUPjo69IvW20TT74qRz?=
 =?us-ascii?Q?25FtxzAZV5Qo4JFehvW9RO/pcgaJrUx/qy1MRJW98/rnKYvkq0Vvrvj+/Ide?=
 =?us-ascii?Q?VOXvU+L/kUEYGZwzeBKE0U3gWrfOlPnyRXy3iHkgZW1XDgm3tQ6mjhULMhzh?=
 =?us-ascii?Q?vqs7/fwmfohQAeCfSs1HY7PUyKGiJRm/gRzn0GNhPKF8aaHavuEkuX3ua7wK?=
 =?us-ascii?Q?hy19VbK/RRPAFzNChmNwwvGm/MgXwG3PfqHzQajKPVl4vOz7pR4q40kS0T6N?=
 =?us-ascii?Q?/2GpsxaqlGo0Od4Dh+1cGrsCe60YbJdZvEcwdtTi9Y654PeQc6x/Twbmm87q?=
 =?us-ascii?Q?YLbo2ihAxwzfn9mwn+Y2ikL3qVwdXVzgHpAqC3kxCCyfeulkdrHBzt+87PsK?=
 =?us-ascii?Q?8OSbr4sZwgKjpyOAH3IcKMoI0hj3+1xb+ERVRl/yEFhD5r+k1TRZGAuXU97w?=
 =?us-ascii?Q?XToN4EIYVPWp8s+VkCo5rpym4qBMgN3Cj6+ZDUN90+dtYC+buVPxhmANG3pr?=
 =?us-ascii?Q?BlAkNRGqIlNAp2+uqPeuBMfPRGnDNLXimZyTjhqv6X6uA5gUxVs5C2gJm+a/?=
 =?us-ascii?Q?4RixGzKM3/xdz4i1HMNydYrvGh8i/WqDpbUU7r7NFvYiAWjVgkjHQdHknM34?=
 =?us-ascii?Q?VSX1nsGOFpWBuyy/ng1qU1SEHNND7w6h1UnDcAqLqYddITrQBOCXlVoMe1/O?=
 =?us-ascii?Q?+HSxgQzZgpfGQmk7gzCg7SB8jfHrd4duvum3cJ+YJV0RwP7WxwARnZL8OgvR?=
 =?us-ascii?Q?mpZwkmwfUsvuNW+z6JhW097LtwuCuNt6bPjLQ4m7z/NVGfc184CzK4siz+mK?=
 =?us-ascii?Q?h4CAMdtbeDsSow+7+IvQ61VKtvOJtdhi5DqVD3mrIZyn4tMf87HQJHN322S6?=
 =?us-ascii?Q?ykSq1lamW9cYPuA3LCpH8jzQiO1EtCWVHg1S8zWEivj3c8ka2KxD8Q8NyNls?=
 =?us-ascii?Q?zxE4c9dN8nwrXloeEGEsyPdwRNmjZYJNpfeBPqpVT0/E2MkP2t+xjGIFqiw6?=
 =?us-ascii?Q?vTUp1/pCaj1mNjs+755OIW4yzRQgiTac/gWl06OX2ijD8Y5Vio8peLdLVLyA?=
 =?us-ascii?Q?l8g78Kp0MiwmshiTEP4asHN4nLxt9z9YcBd/i/Z34bi9OwI0bdHUvDJowonu?=
 =?us-ascii?Q?f5eTEiLIaw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee700046-eff6-465b-acac-08ded5d0deef
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:40.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPuuCGYprLD6ofiELZR0qNWYa+nenTqHYq3ZoNGxX7ubt7zJLAt9nOCgDuFjEUQYSaafslKA2FRBWBMC0Fnu9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302582-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA7C46D9811

Add the necessary APIs to configure and control the LAG support on the
DPAA2 switch object.
 - The dpsw_lag_set() function will be used to either verify that a LAG
 configuration can be support or to actually apply it in HW.
 - The dpsw_if_set_lag_state() will get used in the next patches to
 change the per port LAG state of a specific DPSW interface.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- None

Changes in v3:
- Add a check in dpsw_lag_set() for cfg->num_ifs against
DPSW_MAX_LAG_IFS
- Add kerneldoc for the dpsw_lag_cfg structure.

Changes in v2:
- none
---
 .../net/ethernet/freescale/dpaa2/dpsw-cmd.h   | 18 +++++-
 drivers/net/ethernet/freescale/dpaa2/dpsw.c   | 60 +++++++++++++++++++
 drivers/net/ethernet/freescale/dpaa2/dpsw.h   | 30 ++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h
index 397d55f2bd99..9a2055c64983 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h
@@ -12,7 +12,7 @@
 
 /* DPSW Version */
 #define DPSW_VER_MAJOR		8
-#define DPSW_VER_MINOR		9
+#define DPSW_VER_MINOR		13
 
 #define DPSW_CMD_BASE_VERSION	1
 #define DPSW_CMD_VERSION_2	2
@@ -92,11 +92,14 @@
 #define DPSW_CMDID_CTRL_IF_SET_POOLS        DPSW_CMD_ID(0x0A1)
 #define DPSW_CMDID_CTRL_IF_ENABLE           DPSW_CMD_ID(0x0A2)
 #define DPSW_CMDID_CTRL_IF_DISABLE          DPSW_CMD_ID(0x0A3)
+#define DPSW_CMDID_SET_LAG                  DPSW_CMD_V2(0x0A4)
 #define DPSW_CMDID_CTRL_IF_SET_QUEUE        DPSW_CMD_ID(0x0A6)
 
 #define DPSW_CMDID_SET_EGRESS_FLOOD         DPSW_CMD_ID(0x0AC)
 #define DPSW_CMDID_IF_SET_LEARNING_MODE     DPSW_CMD_ID(0x0AD)
 
+#define DPSW_CMDID_IF_SET_LAG_STATE         DPSW_CMD_ID(0x0B0)
+
 /* Macros for accessing command fields smaller than 1byte */
 #define DPSW_MASK(field)        \
 	GENMASK(DPSW_##field##_SHIFT + DPSW_##field##_SIZE - 1, \
@@ -552,5 +555,18 @@ struct dpsw_cmd_if_reflection {
 	/* only 2 bits from the LSB */
 	u8 filter;
 };
+
+struct dpsw_cmd_lag {
+	u8 group_id;
+	u8 num_ifs;
+	u8 pad[6];
+	u8 if_id[DPSW_MAX_LAG_IFS];
+	u8 phase;
+};
+
+struct dpsw_cmd_if_set_lag_state {
+	__le16 if_id;
+	u8 tx_enabled;
+};
 #pragma pack(pop)
 #endif /* __FSL_DPSW_CMD_H */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw.c b/drivers/net/ethernet/freescale/dpaa2/dpsw.c
index ab921d75deb2..f75cbdce42ba 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw.c
@@ -1659,3 +1659,63 @@ int dpsw_if_remove_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+/**
+ * dpsw_lag_set() - Set LAG configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @cfg:	pointer to LAG configuration
+ *
+ * Return:   '0' on Success; Error code otherwise.
+ */
+int dpsw_lag_set(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		 const struct dpsw_lag_cfg *cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpsw_cmd_lag *cmd_params;
+	int i = 0;
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_SET_LAG, cmd_flags, token);
+
+	if (cfg->num_ifs > DPSW_MAX_LAG_IFS)
+		return -EOPNOTSUPP;
+
+	cmd_params = (struct dpsw_cmd_lag *)cmd.params;
+	cmd_params->group_id = cfg->group_id;
+	cmd_params->num_ifs = cfg->num_ifs;
+	cmd_params->phase = cfg->phase;
+
+	for (i = 0; i < cfg->num_ifs; i++)
+		cmd_params->if_id[i] = cfg->if_id[i];
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_if_set_lag_state() - Change per port LAG state
+ * @mc_io:      Pointer to MC portal's I/O object
+ * @cmd_flags:  Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:      Token of DPSW object
+ * @if_id:      ID of the switch interface
+ * @tx_enabled: Value of the per port LAG state
+ *     - 0 if the interface will not be active as part of the LAG group
+ *     - 1 if the interface will be active in the LAG group
+ *
+ * Return:   '0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_lag_state(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			  u16 if_id, u8 tx_enabled)
+{
+	struct dpsw_cmd_if_set_lag_state *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_LAG_STATE,
+					  cmd_flags, token);
+
+	cmd_params = (struct dpsw_cmd_if_set_lag_state *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	cmd_params->tx_enabled = tx_enabled;
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw.h b/drivers/net/ethernet/freescale/dpaa2/dpsw.h
index b90bd363f47a..89f0267de8e9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw.h
@@ -20,6 +20,8 @@ struct fsl_mc_io;
 
 #define DPSW_MAX_IF		64
 
+#define DPSW_MAX_LAG_IFS	8
+
 int dpsw_open(struct fsl_mc_io *mc_io, u32 cmd_flags, int dpsw_id, u16 *token);
 
 int dpsw_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
@@ -788,4 +790,32 @@ int dpsw_if_add_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 int dpsw_if_remove_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			      u16 if_id, const struct dpsw_reflection_cfg *cfg);
+
+/* Link Aggregation Group configuration */
+
+#define DPSW_LAG_SET_PHASE_APPLY 0
+#define DPSW_LAG_SET_PHASE_CHECK 1
+
+/**
+ * struct dpsw_lag_cfg - Configuration structure for a LAG group
+ * @group_id: Link aggregation group ID. Valid values are in the
+ * [1, DPSW_MAX_LAG_IFS] range.
+ * @num_ifs: Number of interfaces in this LAG group, valid range is
+ * [0, DPSW_MAX_LAG_IFS].
+ * @if_id: Array containing the interface IDs of the ports part of a LAG group
+ * @phase: Use DPSW_LAG_SET_PHASE_APPLY for LAG configuration processing or
+ * DPSW_LAG_SET_PHASE_CHECK for LAG configuration validation.
+ */
+struct dpsw_lag_cfg {
+	u8 group_id;
+	u8 num_ifs;
+	u8 if_id[DPSW_MAX_LAG_IFS];
+	u8 phase;
+};
+
+int dpsw_lag_set(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		 const struct dpsw_lag_cfg *cfg);
+
+int dpsw_if_set_lag_state(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			  u16 if_id, u8 tx_enabled);
 #endif /* __FSL_DPSW_H */
-- 
2.25.1


