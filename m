Return-Path: <netdev+bounces-302578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uf8uKS9XQmpJ5AkAu9opvQ
	(envelope-from <netdev+bounces-302578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:29:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 031856D96D5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:29:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=cicUAex2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302578-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302578-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB42430A4762
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A23FE36A;
	Mon, 29 Jun 2026 11:23:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDD3FC5CE;
	Mon, 29 Jun 2026 11:23:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732216; cv=fail; b=n2DJv+lQnGk1ePNlZJFuHFG9nlilBGMAHS+cONVtocVFASuVNS6UwL9gFRBsXURQMVQv/TpW4glgvnUoPqv0Fsb4ymazqV+PNfV3lQISPwYqd6i3gNllRQy54GEtX29cF1viFMl6XvBN3BvqPMFa3/0JnvZobVQsOWr3WA5QEDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732216; c=relaxed/simple;
	bh=KLOFppAiYABXRlvMJR3XC45yPvcMoA9IWoKxMB1L4Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1NUa75zKWG/gwveZpthUA9zNTLB6lMBtmm/gfDIjpsrYQ3bnFuB3nbpqSuagPf3PPuPn9wH4k27csXnwukhOLInRoRBAQBzNqjPAfRCD6TClKkNiuYDX7rFUOP415i13XxK9JmjitgFZf5L5dCw+cCs/iBaNJFPqC29DhG2hV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cicUAex2; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7CNfzOyWsAJ4URw2IdHi6SrPKYcAHjIToFjrnMUjUgwjd2cna52J45YiD+kTTu6j+EF99P6E4OjCjVXbcbH+wrMm5iqRzIOBkkZTFg2OgzTIP8hGKOJ8PA+jbDWsp7PvnXA8InncoRAY3c2WFNpGV07P0KujLkNkJkVPxI6EQGbJq/5Y1U9VyklBVD402Xgog1cE02GO3h4ZjBvg4IgDPMcesFN2ZBF3qOFoYPedJmLTNbqcJTKJ6VVFUkKuL1uavRUc3fiCw4VPSG/gZifr1elFprcqegBBIlkKumc7Hl++Hn6g2xPsWV0ssKQ4tnvY9ppao6FRdr95BmkyyY5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUJJvS5HVIiQymUUhjodJ9U9b5WZKOjSnDhPw3hKyPQ=;
 b=tlMvwQvnWb9/EzF4QwZ/xPXf8pyjFvkWFJNkCS/SI98A7G5KJUHg5fWWUa3CKIWPAC6ONlfHUKJSUMMTT1UfpnR5aIeLd01p6ImYiF2kfWK977NIiXFBVEk67VGsSJj2KPgroa6PAKKA6PInLWBWMXlkVVCRhaiW7/YRQ7WL9uAyUhQdTNJ/Gy4tmfmV/VVRekA6AN+uExYVb9FXKecYBc5AOzO+uu5uBvAJ/PxpVMLHKDD4j8peuKtPGA4q/U2tqUM4C3PIJcQy4Uw/LwVgseIvWcQM6SU727a2JBC9uArRNuvr7O3W8eqXg/BiVXphuYaCTX3V5MbAMcky8G2pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUJJvS5HVIiQymUUhjodJ9U9b5WZKOjSnDhPw3hKyPQ=;
 b=cicUAex2YpX5HAv/0OzXt52sF1LM6XcnK2A3Y/Ww9/YKvOxpwky4V4KEQj8Agdxae8CFynsOyzKo26kHq9fIIx9rpzumZhKneEZJNm+qCYEkpCSCr7DIY6IQ94zNP5NRdukVxkc6ax2Kt+2YnEGT2CA2gBLlfGaFpJXsh/rT3H0R+UTK7mwCOOs+Lr18lhhlaHFSHeoMq3bbpKnw2JtoTqTc0zWx9Ca3Giv1pWwKGFnef2Egm58umc3ORZYg6AKpdHo72U7VBz7iLoSasX1HW1Ks7I+/W/x1w+8TFYQjaCPRvliNyj6vIdEmtlmBm7Qli6KNjUJKtX7O8ZpRk4NXpA==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:31 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:31 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 04/13] dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
Date: Mon, 29 Jun 2026 14:23:00 +0300
Message-Id: <20260629112309.154328-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::31) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f3f464-6133-49b7-d23a-08ded5d0d947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lemam3h9+YWKbgWBREI5pH84iVzYHHpb3r8sv32ikRp1lWGVL6RmiZKnKaANVW770LOdn98npgn3rENwrogJE1rb3Kw9HhrIrzW4pCuPbxk5xHxM3iVYqQ7yeJJqUjddljKjVwakcGNdv5ZIcRHqGhM6hE/XD/LhYIDvl4kXegSkpFs823razc8AxySbqwYA9Dgn8ycG+Qnw+rhmAvND+V0nvppcRRL7UFV74dGdUOjjQwDt1sjEShjsAE+23VK5nq7/Z+A3DhJtyIyWb0CbXtPFGJ6M87VLOkm2h07BOcizE87CLddAWpKQkMMoNYsJoki04P5a9nbDymuuqFAnqlcBM6HlFhWhisnshuhhiQmFhtAvvF058tAyz3Nsq1t0PN9A4WbKV4LaSTuCEOGn3elOW+1y835nxKcErcsqUeV6o463Hfgl3ZkS30LgDW55uT93LzVDbGdnUFjT1K76Jv8qEdc3fvw6Nxqm/aQ8gLY2MBdrSjIG2GrlGevT6sINdwabQuJwwhwY+Jf2DrlUF9udYDLF2M8QL/Zft4zU1ijY/vf3AhqmRHrT4xZsLo3GjxsxrCilyq5ZsrkJy83+smOoCnywpkTbIH54XLDFz9Eys3Wi3QbMVqD1MwusbuXzH69fLicTzI12taH3lJ1kziCWWjI3PMWmKctkCIqOCgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y/sycdQ9tSLyCiXrWJwFPcGD44JGojL1d+ZRudXo3dWxiHevSefxsvX0R+Ac?=
 =?us-ascii?Q?BE3kM1e58rxxMoCivl78Cecy69zfX0Z1LUvXVqG2CHywSou9duZI6OEC+HU1?=
 =?us-ascii?Q?aDHazo4T1DdpxEnXTAWzBAimzoaQw066p1ypPkBkXPksSHFxp8FWRVx6QPH7?=
 =?us-ascii?Q?GfwFjTYsVayXyYjXmQHTJ+kJYshkiog9Rs+/WFvluqM7IyxvGfx1ehcqlmnU?=
 =?us-ascii?Q?SkJlq3lIobnbB3W7BpPyjQClE6o/ewP/szS8UZC8HsIrxbHD06GiGecenS3O?=
 =?us-ascii?Q?8GkQYRqc9ec5MDLkq4SmJzwITHH1kJ2tLt2/I+QZcCehlrvWCECTXIbW6B73?=
 =?us-ascii?Q?ivR2lKOs2p/f6WyytRt24DDE1whFjA050ftFJuzjty1VnWY7mJOLS0FWa/AX?=
 =?us-ascii?Q?dv6Y3Wijyjh3UUA975Rjx7Qq4uMPItQEYO1Alck8x15DdT978sczFDpaVYFk?=
 =?us-ascii?Q?Uu9/HdZMhNA+c1+BJL7FxnJnc7Brjse/o8/EaIDZWRlLuc06lKyuqwj1EV7K?=
 =?us-ascii?Q?iwlDBywxN3+77ZRCxfi+bOQ7NZTotH2aZ8ckY9tDuJWwv/imTYo7MqC/EoFy?=
 =?us-ascii?Q?7+i4Gj1zhJUl/mt5nGTgj4+2OPyiF/2I+sXfOdeeWd2k3W5JTd1LwMyMgHjv?=
 =?us-ascii?Q?KoxI5DFw8CRSJ1+PT6cmpiRU4Wb+ZUUbm6F/TB+y+bivPYe7CDqwHiZW09rW?=
 =?us-ascii?Q?lzhZlToXqasvBAW1m+LP6EYMq0qlYKxRmw9URB9x4VR6NfoD0yWDpfKozcWv?=
 =?us-ascii?Q?Lj9sWd5AUbxSZr4EwIrvRgFX+T9xhrFjwpn9N1JhQcHRUc/D3tXL0ZX/ehzO?=
 =?us-ascii?Q?UV5/HEec0F1nu/PoqBiX7JCHJWs/fy5zyib0R7W9PCp/LH6HaR5OWvk/zdfT?=
 =?us-ascii?Q?OHq9brIt4lqOvNKHA+POtFzJeT9elNaNqO63zsrnS6yt9oxHYhnjcu2vo1Qn?=
 =?us-ascii?Q?AFU6ghIb/7G/bqbdHwMm2xFva74npzP5xTdeU17nxF9YZoNB5GwljKcr0hgb?=
 =?us-ascii?Q?NekzqAtNGiyDiGC4Qe2kR9xgmjv1n8lj7E9SaCjMakf+RXM+n0aprGq0/4g4?=
 =?us-ascii?Q?QHH2G6Wn5myl8pta4kMgeB1Ppk7mXn5CgCxUfhDwcqi16WXEsCJ94/UWucKV?=
 =?us-ascii?Q?AmdwrtfmeYxKAcW8rZkf+0Br7naIeh+Yvy7NtYVrmtklFS+6GetAG0kxAK8a?=
 =?us-ascii?Q?qCxIBSWd2uDnAgJM5qDgDj+Kv+W9zWDEEIAeO6CUWdfadHCrvlbOXb2ymh1+?=
 =?us-ascii?Q?qjkajpGrNjNv1zrO3ETtTR+QwiFEALt9//qNWWjzG07btOJuFqWY6yggnpCU?=
 =?us-ascii?Q?7sma9xZb3t42d/ygt3ZYVyfY3n6Ta0zUXDDMrXbFdaZ2XRbVH4Rlj7y4leSj?=
 =?us-ascii?Q?FTdMoo9jJLNwVqe8T88VTAzz7R3MFgmpevM+5+Z4LtVrHklUqWW9ePCctq3K?=
 =?us-ascii?Q?eDK2X1ONlXkhOG4dmXSN02tCQfYWftblNXKCUOoLei8K43czRKiZ6FN+F9mY?=
 =?us-ascii?Q?awy90C7Hh48J7vGUK0aEtAn7wuyznIfnQrVT97XpPzNKSUrCg5GizOz7sVq1?=
 =?us-ascii?Q?zjY3w5+vfniyj+Tm7yea517zOXdCt9OgmQzIuVcD1JDWCAfD+GT9BRfrtRz5?=
 =?us-ascii?Q?JozT4YEeK8PqOru+IiGeHvUI3/glAkrMw0GQcVnP0+TMq6K+D05+L50PNXhe?=
 =?us-ascii?Q?y0MJDx7t4aabiwtb56JDQQcRoIgmBdvJJCF6qLej7y5VdbxYB9mRitsg91GY?=
 =?us-ascii?Q?pCa87brL+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f3f464-6133-49b7-d23a-08ded5d0d947
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:30.9825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/raYpw9qjqDGJQ79eZgUjqy0mMBNC8aelDLDW3cMQKV635N+RPvCpkFBdOffQk/7yeoEponigDb9MctCCUBMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302578-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 031856D96D5

Create a separate dpaa2_switch_port_fdb_event() function that will only
handle the FDB related events. With this change, the
dpaa2_switch_port_event() notifier handler can be written in a way that
it's easier to follow.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- none

Changes in v3:
- Get hold on port_priv->ethsw_data only after we know the device is a
dpaa2-switch one

Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index eacab00b586a..c7c84bf2fde7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2337,21 +2337,18 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 	dev_put(dev);
 }
 
-/* Called under rcu_read_lock() */
-static int dpaa2_switch_port_event(struct notifier_block *nb,
-				   unsigned long event, void *ptr)
+static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
+				       unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
-	struct ethsw_core *ethsw = port_priv->ethsw_data;
-
-	if (event == SWITCHDEV_PORT_ATTR_SET)
-		return dpaa2_switch_port_attr_set_event(dev, ptr);
+	struct ethsw_core *ethsw;
 
 	if (!dpaa2_switch_port_dev_check(dev))
 		return NOTIFY_DONE;
+	ethsw = port_priv->ethsw_data;
 
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
@@ -2390,6 +2387,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 	return NOTIFY_BAD;
 }
 
+/* Called under rcu_read_lock() */
+static int dpaa2_switch_port_event(struct notifier_block *nb,
+				   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dpaa2_switch_port_attr_set_event(dev, ptr);
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		return dpaa2_switch_port_fdb_event(nb, event, ptr);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int dpaa2_switch_port_obj_event(unsigned long event,
 				       struct net_device *netdev,
 				       struct switchdev_notifier_port_obj_info *port_obj_info)
-- 
2.25.1


