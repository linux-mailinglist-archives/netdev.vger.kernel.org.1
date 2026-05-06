Return-Path: <netdev+bounces-284899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAKwDopb+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:17:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68484DD00B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B59A33006791
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827648C8D1;
	Wed,  6 May 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aHD495rM"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620148B39D;
	Wed,  6 May 2026 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080577; cv=fail; b=u/GaIOK0Uh38zHP4Gsga1CFd029aAlge4fkf8vBnCQgTK6z+iQwVg5L17meZTTK6XhIlaoYY3LKPXcj7pslhU5UO7re/g9IE9FEPwdqZLj0Va9JhjIdBQ0fsl8OcG2qQYcihbqA5Rkfi9Nddruf6REvlE25EcyfKr/wKsDk/uQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080577; c=relaxed/simple;
	bh=ABosSjfTDu7oq13Sl//uf2huFrw0qLIrwQi8Twgk25k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kMDWhcXECatbTNGuK1efBX2B8wpWBH1wZ/zQ8whp7qdhTwNl9sy7F3iYUywu7vI6nEX3Jlc8fbYtbbvmSoHtbWmYvEaMSeZcqR64RyM/yXX5flGWgDuLWPj0uBsh4GjPEds+k5i7ViLNhwq0+r9+d1eDBpVI6ASM+MD61J75skg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aHD495rM; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ0tSbhTs0AQB+i6KgFyW+FHO1W0CjLesmEK4jzU0gBzdk6Bj68N8MCO5ZeEAiDjWOakHJ+ZqQt3KkjSJlA+xRuhTQGNQef7DFCw6k1YMTWaDlfPTIiWfa2nwJDyFEGuwksHkusNz1U/CowQT9j2Eq7RWkB1NXAe9ajJAeGDAQbc+iFJghrKtAIYjBTyeDW0cJe+5TxcrdjcXT2syqaAqMtOt2Qie6T+hyRJ4Y4Adt5QeHn8At6eE/fsKC0NXM+lVNAA7lWzLoY0/YTkE2VRMMA+K91wmUDhmbQqK/TC6tP1CjxLW8j5SLONFZif1i4IBI9sLSlEywyJrxJ9rOeR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgvMh50UL64nZuJOnDYr1vGpOWE3md74JeenNLL8xX4=;
 b=kz4P6hWUXVm+G4pIABhynfaSI1hYuPgbiQvSayv+hh58D5++124U/cSMYk6N+ENgGAq207wlVqv5AoUUyz9f/02GUtNCgnsct7zS4/K7Z3wvWjSZwQqusTIYJXAEZS6hhsvTi9yOI2Kbuo3CSJW9Xyvyk747huvyjlmvxYJ2X5K0dqtmJenn6GsFZKcpDh2JSdXcKyS3+lpjzm3ZXShfchgzSIP57YBATNEA9PLDT93eF6k2KHUygR4BdCO89FNigHWUNZdgRcSegrH+Dhiw1HX9O0tMvuz7H4ys+pXLkrZ9nfVgJs1z5WjKq/BZdcjjPjd8/VeFMxCnsr+MwUJjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgvMh50UL64nZuJOnDYr1vGpOWE3md74JeenNLL8xX4=;
 b=aHD495rMnbjaIXyFptRvWuAKasBoz5WwaCVCPhFngqjRTyy7KWjnGr3yn8bULs4bVf4caz2qlGzpMVCn25bp+Y7tsT3dZmtmSuAbAL3NNP8sX+TTay7bPRuSv9e7B3y33Nj8jrRmfAKRIQw9Tjd558FBzJZ+D1iKuKiPc9Fqc4umgT6hNX/Lez+G2pNjibp25+0t8uOQb3bQbly+GqolwLuTh0Jq2GXQg574TePjTVH8Jt4PhCa0tGrhl1ce3Fi9mqKEp0TWKSJ+vsLMPXZNg+SYTS8K0QFSujMYLCN8ekLEQIaRHTYV3rWe8ltOTuB+c8LAVS88VW1UA+I+ehXfAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PA1PR04MB10626.eurprd04.prod.outlook.com
 (2603:10a6:102:48e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:16:00 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:00 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/13] dpaa2-switch: add support for LAG offload
Date: Wed,  6 May 2026 18:15:29 +0300
Message-Id: <20260506151540.1242997-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::13) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PA1PR04MB10626:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bad51d-6230-4e38-0a87-08deab8261b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gE2p1ADqzDgBX2GA/rwr+lD3uaooQlfGGVd+A+CHlDvMcWjAmt1D5Lzj16+SjKjZye0J7kVPVrbj/1FpmzDHlxla2X3XC3IUUF+5N80BxFhqv3VGj3u1EySG06jArIlp+c1NBW86APVQ2IREjyNVonmfzMVIYGlrIp5DVsLhV9jyWvlz5MWM3EB1vN0xl4v6IWeaEQ0/kTGGHRswDe2BvqJ8bsJSY6fxYXm1xvmpTupOQ8gPRQolTGYx8cUVdyx5CIP7Oi0FpUKogm2XlVIHjUKzFWksHoirILn/V9Q+Eq2WmaRReG3HHcDgUC7mvO17V6ooJ8RG+m2QVHxnBZnsZeRZ1IdTLmjV4GxWIym3Y9XRDvA2Fn1P0RMZ13tDF8nswi4I+/bO1quIl5A6+upAD5Cp5DMjtNZ4DTlno2LRZAHjdMmYxXU7b4UnDg/J2e0IRPxD7P2ZenTErCkvLn1cX7nZr54b43bAYuTu6E9DJQfVZZrVo1L5gGHiwYEZ/CkzO43b6KFcRDN6xB4Z2L0x8DsVv/GhFi+kiampyv0nbU48Sv3hMxSz6AKlgdMGNMmoUJ1SyRwybX1uOgM8xf1VWlvhz2/vrO+/8LdSAQOGAJcdaOfO9yXGz/Jbh/8GVQ/DC/BGfGp4o54q3Y224lHO6ydfbjz+k28XHQso+2xmtQSGrLXJQQ+vNjuxtL9GVzVB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrkco1xdDAwtIZgRgnLMRLhgJm8k2UBi+xtR67oELUF5ZqAQAHrDVxfIIRtM?=
 =?us-ascii?Q?OwmKQq8JZQ2wTc5IySPlrq+u1cJTco5K7qVA0R6u4VGSJXY9J0xODyqFcwj/?=
 =?us-ascii?Q?0c1mUKD9dfTav+beMjposjBFPqnhjOtwTsfHJxS5PzsKvA7lkYNUm5h6VN0L?=
 =?us-ascii?Q?+w1+sul/T9XbhJsmDKx/4/Hdqy96wV0yM+5UIZ2XAPVCpKdEG31BrovjnQ7x?=
 =?us-ascii?Q?kKSJvRRHH1Ovu4rBRdzMN1UqlXzQWTQhZH6jh5uE88XbggJdX5UMX6Juq/DD?=
 =?us-ascii?Q?cBCHqXNJSAmGBF0tn1VTSHkpJW56Ka9f21qpcajrABN/if0VVxcwUqEe4rrU?=
 =?us-ascii?Q?nXNUlsinbdTLqPJkcOF2OyBNglbyHEchxKRX0OhFNgDxxmy3XO6VU76Qx3++?=
 =?us-ascii?Q?4NGIi6OsXnpzJVSeIoN/9vnJG5hWeVEAcqiL6+KWALOLOi/0lgzmvCibOHPx?=
 =?us-ascii?Q?3Sg1y2CeFCh2quPNs3rIyhS780+GYk5pAJRmGj383+AKtYQ8DGA7DfMJAOvp?=
 =?us-ascii?Q?CFw0eRi8Q7Qmf3rHfGE8rUScEKoVb9mTziF5+2tOs9LugIKFZzBRYO1qFHNY?=
 =?us-ascii?Q?R+hAlCr52XDypYuHiDFTO46ChA6YPI/Ad0nRw9HU2/EX/zMRdcXK//fNy2Od?=
 =?us-ascii?Q?KOWOohJtCLwy/rUv9cPPo+KsXVHurvaD1u2GIO3n8mznfH6mdxnNBjkSofAI?=
 =?us-ascii?Q?+6rLbTy4YSnHI1hlEFLbxrZpAEVFEciyOevu56Uefsu44+gxxraiyyvd2kXK?=
 =?us-ascii?Q?bAoIcmqCsyO14L8GBjaGKNVXMRpeAkXykKh+TRxWXlZQKWVn9G7YUf2hFdQ8?=
 =?us-ascii?Q?V2odaXHl0j38pZi1yBHUhmkB+ShTOYS1XbX2qj7vaaMb1TJelYvkdi82xlG9?=
 =?us-ascii?Q?sYN6+gqo90tZ039Y3ArorARpOHSYcwkJHVCzXzziObT5cjDm75rqDmqeWrcW?=
 =?us-ascii?Q?3peWKWOPtV22n/w312lMNBCjSGkgYDS+UhkTWDqaKg2+mLgGGAX8izKi9TUd?=
 =?us-ascii?Q?v6eBcGyueUne+QdDLaoFXpCBRX1vXWTj6AmgBtObBIdLCj5hjtLjtHI0YVaX?=
 =?us-ascii?Q?MX2+3gVFNwapbThlCBS9J5hreF49lqMABDU3KuGlIe3cTd9rlIX6Cr4zEIBQ?=
 =?us-ascii?Q?zg4ZXtXq8nLMASpOSmIK+ZiHCqkEdvGXRuAB+zi+xmaOMW33tCQETZMOlXAN?=
 =?us-ascii?Q?bJPzsljRlTgDeOWabcprjZP4Fs+/duesqGHWpkvhgA9Y2gxXeor0h0RFdOk9?=
 =?us-ascii?Q?p5RAFhB0Vym6Iit0nj7IGbkLXbFRDRVfIiCFzd1yh0pxvfczqnGo53BEIrZ4?=
 =?us-ascii?Q?kLqHzgPL4O2thYtjJGhHCLvZqjS9gxB1ZO8pdZ546VuHH4Gg5UjmXnSCoUSn?=
 =?us-ascii?Q?RpvJZTazQW5+89Wbbyv69eu+GmH8P9oghMUYbS5bsv4ZD45gI6Zk/EJ+RuKh?=
 =?us-ascii?Q?31oHHP0g48D4yLo0tEJ8/LMhHss3nfxSoyRF6cLhKenzaf4MvsFS/zAVV6ux?=
 =?us-ascii?Q?/hLIsfh73eCeBTttMgHk/KTqOIjd2fR6NGT7Xpcka8GWslyN6RsfAFiT34Ec?=
 =?us-ascii?Q?BSvfc8VZO+q2A+nDhyQdFZcBP/cTAK8NWK9NebQE76JkAuJwxAcrxfgq+ciW?=
 =?us-ascii?Q?JxOOzlr3jgv2zKkVfBfJJ+//5u5V0JKqFT/27Qzi/a7R2k91KPpsLcuf+HzG?=
 =?us-ascii?Q?Jdg8bQfqHg9mkYP0gJSSuQQemid5SwaHkJ7UkIsv1A3DZIyrk9MI+bLgCbFZ?=
 =?us-ascii?Q?xCLSbIiN4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bad51d-6230-4e38-0a87-08deab8261b5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:00.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Taw7SeprDqI9y6QTVhuybCYIf9p2B0Xodrl2Be5bGIphabncfa4OY360kFN3pE8iDwvqmqG9F3lQ8eyDzBWyPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10626
X-Rspamd-Queue-Id: A68484DD00B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284899-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

This patch adds the bulk of the changes needed in order to support
offloading of an upper bond device.

First of all, handling of the NETDEV_CHANGEUPPER and
NETDEV_PRECHANGEUPPER events is extended so that the driver is capable
to handle joining or leaving an upper bond device.
All the restrictions around the LAG offload support are added in the
newly added dpaa2_switch_pre_lag_join() function.

The same events are extended to also detect if one of our upper bond
devices changes its own upper device. In this case, on each lower device
that is DPAA2 the corresponding dpaa2_switch_port_[pre]changeupper()
function will be called. This will start the process of joining the same
FDB as the one used by the bridge device.

Setting the 'offload_fwd_mark' field on the skbs is also extended to be
setup not only when the port is under a bridge but also under a bond
device that is offloaded.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 390 +++++++++++++++++-
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  14 +-
 2 files changed, 402 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 52c1cb9cb7e0..6367873401c0 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -51,6 +51,17 @@ dpaa2_switch_filter_block_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
+static struct dpaa2_switch_lag *
+dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
+{
+	int i;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		if (!ethsw->lags[i].in_use)
+			return &ethsw->lags[i];
+	return NULL;
+}
+
 static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				     struct net_device *bridge_dev)
 {
@@ -2195,6 +2206,266 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 	return 0;
 }
 
+static int dpaa2_switch_pre_lag_join(struct net_device *netdev,
+				     struct net_device *upper_dev,
+				     struct netdev_lag_upper_info *info,
+				     struct netlink_ext_ack *extack)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port_priv;
+	struct dpaa2_switch_lag *lag = NULL;
+	struct dpsw_lag_cfg cfg = {0};
+	struct net_device *other_dev;
+	int i, num_ifs = 0, err;
+	struct list_head *iter;
+
+	if (!(ethsw->features & ETHSW_FEATURE_LAG_OFFLOAD)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "LAG offload is supported only for DPSW >= v8.13");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload LAG using hash TX type");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->hash_type != NETDEV_LAG_HASH_L23) {
+		NL_SET_ERR_MSG_MOD(extack, "Can only offload L2+L3 Tx hash");
+		return -EOPNOTSUPP;
+	}
+
+	if (!dpaa2_switch_port_has_mac(port_priv)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only switch interfaces connected to MACs can be under a LAG");
+		return -EINVAL;
+	}
+
+	if (vlan_uses_dev(upper_dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot join a LAG upper that has a VLAN");
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		if (!ethsw->lags[i].in_use)
+			continue;
+		if (ethsw->lags[i].bond_dev != upper_dev)
+			continue;
+		lag = &ethsw->lags[i];
+		break;
+	}
+
+	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
+		if (!dpaa2_switch_port_dev_check(other_dev))
+			continue;
+
+		other_port_priv = netdev_priv(other_dev);
+		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Interface from a different DPSW is in the bond already");
+			return -EINVAL;
+		}
+
+		cfg.if_id[num_ifs++] = other_port_priv->idx;
+
+		if (num_ifs >= DPSW_MAX_LAG_IFS) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot add more than 8 DPAA2 switch ports under the same bond");
+			return -EINVAL;
+		}
+	}
+
+	if (lag) {
+		cfg.group_id = lag->id;
+		cfg.if_id[num_ifs++] = port_priv->idx;
+		cfg.num_ifs = num_ifs;
+		cfg.phase = DPSW_LAG_SET_PHASE_CHECK;
+
+		err = dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot offload LAG configuration");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static void dpaa2_switch_port_set_lag_group(struct ethsw_port_priv *port_priv,
+					    struct net_device *bond_dev)
+{
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port_priv = NULL;
+	struct dpaa2_switch_lag *lag = NULL;
+	struct net_device *other_dev;
+	struct list_head *iter;
+
+	netdev_for_each_lower_dev(bond_dev, other_dev, iter) {
+		if (!dpaa2_switch_port_dev_check(other_dev))
+			continue;
+
+		other_port_priv = netdev_priv(other_dev);
+		if (!other_port_priv->lag)
+			continue;
+
+		if (other_port_priv->lag->bond_dev == bond_dev) {
+			port_priv->lag = other_port_priv->lag;
+			return;
+		}
+	}
+
+	/* This is the first interface to be added under a bond device. Find an
+	 * unused LAG group. No need to check for NULL since there are the same
+	 * amount of DPSW ports as LAG groups, meaning that each port can have
+	 * its own LAG group.
+	 */
+	lag = dpaa2_switch_lag_get_unused(ethsw);
+	lag->in_use = true;
+	lag->bond_dev = bond_dev;
+	port_priv->lag = lag;
+}
+
+static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
+				    struct ethsw_core *ethsw)
+{
+	struct dpaa2_switch_lag *lag = &ethsw->lags[lag_id - 1];
+	struct ethsw_port_priv *other_port_priv = NULL;
+	struct dpsw_lag_cfg cfg = {0};
+	u8 num_ifs = 0;
+	int i;
+
+	cfg.group_id = lag_id;
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		other_port_priv = ethsw->ports[i];
+
+		if (!other_port_priv)
+			continue;
+		if (!other_port_priv->lag)
+			continue;
+		if (other_port_priv->lag->bond_dev != bond_dev)
+			continue;
+
+		/* No need to check against DPSW_MAX_LAG_IFS since this
+		 * was done in the prechangeupper stage. The flow will
+		 * not reach this point in case there are more DPAA2
+		 * switch ports under the same bond than we can accept.
+		 */
+		cfg.if_id[num_ifs++] = other_port_priv->idx;
+	}
+
+	cfg.num_ifs = num_ifs;
+
+	/* No more interfaces under this LAG group, mark it as not in use */
+	if (!num_ifs) {
+		lag->bond_dev = NULL;
+		lag->in_use = false;
+	}
+
+	return dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
+}
+
+static int dpaa2_switch_port_bond_join(struct net_device *netdev,
+				       struct net_device *bond_dev,
+				       struct netdev_lag_upper_info *info,
+				       struct netlink_ext_ack *extack)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
+	struct net_device *bridge_dev;
+	int err = 0;
+	u8 lag_id;
+
+	/* Setup the egress flood policy (broadcast, unknown unicast) */
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev);
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
+	if (err)
+		goto err_egress_flood;
+
+	/* Recreate the egress flood domain of the FDB that we just left. */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
+	if (err)
+		goto err_egress_flood;
+
+	/* Setup the port_priv->lag pointer for this switch port */
+	dpaa2_switch_port_set_lag_group(port_priv, bond_dev);
+
+	/* Create the LAG configuration and apply it in MC */
+	lag_id = port_priv->lag->id;
+	err = dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
+	if (err)
+		goto err_lag_cfg;
+
+	/* If the bond device is a switch port, then join the bridge as well */
+	bridge_dev = netdev_master_upper_dev_get(bond_dev);
+	if (!bridge_dev || !netif_is_bridge_master(bridge_dev))
+		return 0;
+
+	err = dpaa2_switch_port_bridge_join(netdev, bridge_dev, extack);
+	if (err)
+		goto err_bridge_join;
+
+	return err;
+
+err_bridge_join:
+err_lag_cfg:
+	port_priv->lag = NULL;
+	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
+err_egress_flood:
+	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	return err;
+}
+
+static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
+					struct net_device *bond_dev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct dpaa2_switch_lag *lag = port_priv->lag;
+	int err = 0;
+
+	/* Delete the default VLAN, we might change our FDB in this operation */
+	err = dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
+	if (err)
+		return err;
+
+	/* Setup the FDB for this port which is now standalone */
+	dpaa2_switch_port_set_fdb(port_priv, NULL);
+
+	/* Setup the egress flood policy (broadcast, unknown unicast).
+	 * When the port is not under a bond, only the CTRL interface is part
+	 * of the flooding domain besides the actual port.
+	 */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
+	if (err)
+		return err;
+
+	/* Recreate the egress flood domain of the FDB that we just left. */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
+	if (err)
+		return err;
+
+	/* Add the VLAN 1 as PVID when not under a bond. We need this since
+	 * the dpaa2 switch interfaces are not capable to be VLAN unaware
+	 */
+	err = dpaa2_switch_port_add_vlan(port_priv, DEFAULT_VLAN_ID,
+					 BRIDGE_VLAN_INFO_UNTAGGED |
+					 BRIDGE_VLAN_INFO_PVID);
+	if (err)
+		return err;
+
+	/* Recreate the LAG configuration for the LAG group that we left */
+	port_priv->lag = NULL;
+	dpaa2_switch_set_lag_cfg(bond_dev, lag->id, ethsw);
+
+	return 0;
+}
+
 static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 					    struct netdev_notifier_changeupper_info *info)
 {
@@ -2216,6 +2487,9 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 
 		if (!info->linking)
 			dpaa2_switch_port_pre_bridge_leave(netdev);
+	} else if (netif_is_lag_master(upper_dev) && info->linking) {
+		return dpaa2_switch_pre_lag_join(netdev, upper_dev,
+						 info->upper_info, extack);
 	}
 
 	return 0;
@@ -2240,6 +2514,80 @@ static int dpaa2_switch_port_changeupper(struct net_device *netdev,
 							     extack);
 		else
 			return dpaa2_switch_port_bridge_leave(netdev);
+	} else if (netif_is_lag_master(upper_dev)) {
+		if (info->linking)
+			return dpaa2_switch_port_bond_join(netdev, upper_dev,
+							   info->upper_info,
+							   extack);
+		else
+			return dpaa2_switch_port_bond_leave(netdev, upper_dev);
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_switch_lag_prechangeupper(struct net_device *netdev,
+				struct netdev_notifier_changeupper_info *info)
+{
+	struct net_device *lower;
+	struct list_head *iter;
+	int err = 0;
+
+	if (!netif_is_lag_master(netdev))
+		return 0;
+
+	netdev_for_each_lower_dev(netdev, lower, iter) {
+		if (!dpaa2_switch_port_dev_check(lower))
+			continue;
+
+		err = dpaa2_switch_port_prechangeupper(lower, info);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+static int
+dpaa2_switch_lag_changeupper(struct net_device *netdev,
+			     struct netdev_notifier_changeupper_info *info)
+{
+	struct net_device *lower;
+	struct list_head *iter;
+	int err = 0;
+
+	if (!netif_is_lag_master(netdev))
+		return 0;
+
+	netdev_for_each_lower_dev(netdev, lower, iter) {
+		if (!dpaa2_switch_port_dev_check(lower))
+			continue;
+
+		err = dpaa2_switch_port_changeupper(lower, info);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_switch_port_changelowerstate(struct net_device *netdev,
+				   struct netdev_lag_lower_state_info *linfo)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	int err;
+
+	if (!port_priv->lag)
+		return 0;
+
+	err = dpsw_if_set_lag_state(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				    port_priv->idx, linfo->tx_enabled ? 1 : 0);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_set_lag_state() = %d\n", err);
+		return err;
 	}
 
 	return 0;
@@ -2249,6 +2597,7 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 					     unsigned long event, void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changelowerstate_info *info;
 	int err = 0;
 
 	switch (event) {
@@ -2257,13 +2606,29 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 		if (err)
 			return notifier_from_errno(err);
 
+		err = dpaa2_switch_lag_prechangeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
 	case NETDEV_CHANGEUPPER:
 		err = dpaa2_switch_port_changeupper(netdev, ptr);
 		if (err)
 			return notifier_from_errno(err);
 
+		err = dpaa2_switch_lag_changeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
+	case NETDEV_CHANGELOWERSTATE:
+		info = ptr;
+		if (!dpaa2_switch_port_dev_check(netdev))
+			break;
+
+		err = dpaa2_switch_port_changelowerstate(netdev,
+							 info->lower_state_info);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
@@ -2500,8 +2865,11 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 	skb->dev = netdev;
 	skb->protocol = eth_type_trans(skb, skb->dev);
 
-	/* Setup the offload_fwd_mark only if the port is under a bridge */
+	/* Setup the offload_fwd_mark only if the port is under a bridge
+	 * or under a bond device that is offloaded.
+	 */
 	skb->offload_fwd_mark = !!(port_priv->fdb->bridge_dev);
+	skb->offload_fwd_mark |= !!(port_priv->lag);
 
 	netif_receive_skb(skb);
 
@@ -2517,6 +2885,9 @@ static void dpaa2_switch_detect_features(struct ethsw_core *ethsw)
 
 	if (ethsw->major > 8 || (ethsw->major == 8 && ethsw->minor >= 6))
 		ethsw->features |= ETHSW_FEATURE_MAC_ADDR;
+
+	if (ethsw->major > 8 || (ethsw->major == 8 && ethsw->minor >= 13))
+		ethsw->features |= ETHSW_FEATURE_LAG_OFFLOAD;
 }
 
 static int dpaa2_switch_setup_fqs(struct ethsw_core *ethsw)
@@ -3301,6 +3672,7 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 	kfree(ethsw->fdbs);
 	kfree(ethsw->filter_blocks);
 	kfree(ethsw->ports);
+	kfree(ethsw->lags);
 
 	dpaa2_switch_teardown(sw_dev);
 
@@ -3328,6 +3700,7 @@ static int dpaa2_switch_probe_port(struct ethsw_core *ethsw,
 	port_priv = netdev_priv(port_netdev);
 	port_priv->netdev = port_netdev;
 	port_priv->ethsw_data = ethsw;
+	port_priv->lag = NULL;
 
 	mutex_init(&port_priv->mac_lock);
 
@@ -3435,6 +3808,19 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 		goto err_free_fdbs;
 	}
 
+	ethsw->lags = kcalloc(ethsw->sw_attr.num_ifs, sizeof(*ethsw->lags),
+			      GFP_KERNEL);
+	if (!ethsw->lags) {
+		err = -ENOMEM;
+		goto err_free_filter;
+	}
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		ethsw->lags[i].bond_dev = NULL;
+		ethsw->lags[i].ethsw = ethsw;
+		ethsw->lags[i].id = i + 1;
+		ethsw->lags[i].in_use = 0;
+	}
+
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		err = dpaa2_switch_probe_port(ethsw, i);
 		if (err)
@@ -3481,6 +3867,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 err_free_netdev:
 	for (i--; i >= 0; i--)
 		dpaa2_switch_remove_port(ethsw, i);
+	kfree(ethsw->lags);
+err_free_filter:
 	kfree(ethsw->filter_blocks);
 err_free_fdbs:
 	kfree(ethsw->fdbs);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 42b3ca73f55d..56debbdefd13 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -41,7 +41,8 @@
 #define ETHSW_MAX_FRAME_LENGTH	(DPAA2_MFL - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define ETHSW_L2_MAX_FRM(mtu)	((mtu) + VLAN_ETH_HLEN + ETH_FCS_LEN)
 
-#define ETHSW_FEATURE_MAC_ADDR	BIT(0)
+#define ETHSW_FEATURE_MAC_ADDR		BIT(0)
+#define ETHSW_FEATURE_LAG_OFFLOAD	BIT(1)
 
 /* Number of receive queues (one RX and one TX_CONF) */
 #define DPAA2_SWITCH_RX_NUM_FQS	2
@@ -105,6 +106,13 @@ struct dpaa2_switch_fdb {
 	bool			in_use;
 };
 
+struct dpaa2_switch_lag {
+	struct ethsw_core	*ethsw;
+	struct net_device	*bond_dev;
+	bool			in_use;
+	u8			id;
+};
+
 struct dpaa2_switch_acl_entry {
 	struct list_head	list;
 	u16			prio;
@@ -163,6 +171,8 @@ struct ethsw_port_priv {
 	struct dpaa2_mac	*mac;
 	/* Protects against changes to port_priv->mac */
 	struct mutex		mac_lock;
+
+	struct dpaa2_switch_lag	*lag;
 };
 
 /* Switch data */
@@ -190,6 +200,8 @@ struct ethsw_core {
 	struct dpaa2_switch_fdb		*fdbs;
 	struct dpaa2_switch_filter_block *filter_blocks;
 	u16				mirror_port;
+
+	struct dpaa2_switch_lag		*lags;
 };
 
 static inline int dpaa2_switch_get_index(struct ethsw_core *ethsw,
-- 
2.25.1


