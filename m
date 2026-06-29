Return-Path: <netdev+bounces-302581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1qtBNFBXQmpW5AkAu9opvQ
	(envelope-from <netdev+bounces-302581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:30:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0306D96F5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:30:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=IkjXtLr3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302581-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302581-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CCDA30C0D3C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA20401483;
	Mon, 29 Jun 2026 11:23:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D90400E0C;
	Mon, 29 Jun 2026 11:23:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732222; cv=fail; b=Nusm5lMm4EGFRGZdMigzAfD1gxYof/RUvsWQg/ZY9sjgo/umtnm6nEfRTHsZEOv64cGk4lqD6QDi1sXtG30CalNuuRKpdZtP+rEsBRL/E2R55QGouqViONTOOdGGEBs9t6V/MHiwAMToVzSBrk/lABXNMUv9boo6ck9CrkAWpqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732222; c=relaxed/simple;
	bh=gB+P05+mHxswlBM4QbUbwUwnRDbfApjPb3o5wRxlX1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X5YTTavXpH4VvP/J1asms4kH18xHV0/H+2d+mFH52ODgIj3pubJIxpmDOWoT1406Qq2ZHnZKBNy+l9NiOqE6OJyaaJL/VVkvoZgzzdgmgT3y8B5CAkQLykotSfD17atKXVYa0CbEzfCtY8XTh8vfKsvrpsNFcuzJc+clReTklRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IkjXtLr3; arc=fail smtp.client-ip=52.101.83.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUXKC+XIWnjiFEjidyVsV7YaZGi8ZqMYc/wVucCPt4C7BuQYjqGo/OCHxDO3GdK9MSr/VKVDJkcwXqa0Wra07/Q5afZm7OZjhCSf2GMrkWIPJ1T+q1g4i38DyZBT8Yozr0aBVVlUGt8WWe58j52y+1iZ5xi/r+ULpAMOIFRt2M5kKvwRpQb+UMshWoW/hvKXpuGGTXLwEcOve+mqhgCHOyThWEcAPiaWAmiAZqO7mqyXvMJonNKMUiGocgSHZzlOCxOQ1/H/cqgzEB1SQwm21uu829tnaBijAiVyuQHYivrboFvo0FcCyCrQpYFO5LKI1Ud67yZS6bq7ouZnDNnlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQymntYTJaBtwqplxDqSNO9yEHhkp9U5FihYklMdS1E=;
 b=H3LxfIxv+cjFJlCBTrp0mNoPMfHqsYIUQAHe7Gh1US2f5xWUc07flrJabR3XsusNNa06/Xew89XVbSYUSJ1bCLm2rxnyF1EhO6hc5EdaiockwW3rvcfGc7i2ayeCmByg71X3HZFgl7hFbsdxg9GBn8mITlDnDVtF/Nazeaeic6+Sx2kYvl29nsRayItIOz47lo+aiI3MAMS7zkbZP83zag+ZducV7Bg1vysewxVZyxucxefB2btykVK3qspw46wyIzp2js1adRE2bDyjvKNyMKOs84WcoigwrkpI4HXuOEHxvAYVNxPuqD3RBJ48h5kqQ1csVByUCVPLNaBxo3RZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQymntYTJaBtwqplxDqSNO9yEHhkp9U5FihYklMdS1E=;
 b=IkjXtLr30d4jAEqVfXO/s60L0utvDUMsyZlEdOW0Sh9cBsHmrYiTUUPxhu4lXgXe2C9vuRE1IbAr0xBC5BPYq3pYigbJfS5fkKvjWBhbVYqsO9rlgp75VH/MZZWHLozm34bYDyu2xFPIMfGpLOOGerfOxUaUvbnWheXGBhqiTS+n8ETOgaEuXlQaNjQtCA1sq+hUumILtH4UVXhDsPBPsq/DANJqzQIG7YWJEbyV4TzealyeIUim1YyM89HY/G8GRbZlbLfnkEzsXnRt5DBKA12w3PH8VNy1E19eZa6UjmUWm/bP8Tc+orV25CmlfpBSGhUZoccIdjG3zPbfboQjzw==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:38 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:38 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 07/13] dpaa2-switch: consolidate unicast and multicast management
Date: Mon, 29 Jun 2026 14:23:03 +0300
Message-Id: <20260629112309.154328-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::35) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 91538869-c010-4069-bd75-08ded5d0dd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CrcZscrxvDeurSkxPnfm8OMN8YkUCOXiQq2nt/61Q4HsZAVhdUxLaZzmsICpoN8QulUWZUsHZ9cHjlxOkr9NLFaB8eUsmnFZ6s3A/AqT7p8BbKV8h07RfjA4ZkelLC80UpdVEhT1+vGQvryVJYie6OuVru3wQ/fzHqp4mbW1GI4W/+bQF6a1Z0evNirRDUDuK2Xo18qZZVFlrHNa5eSLHe/1ni+xALCCH9EQwKT+4gxoh6MZTlw9/RAjyhJ9/S+q1pmfEGxn1UNDOA6xjvUZTVCOkE6onUk9qiTAVPSZnOGnuPRFxGYT/cVYj+5ngMvX/fBRItTUqIc7c1qIL0lplwarcKSM9nTrVp0hMIoXFU2ndZ49cbXuzqJph7h5jWD/Sd53KP7YVxuVBU5dQng3B1j8MmEKFgMOGd83zn9gyZfUPmEFLCLeW4PLQFDAgET05VZbLU+R0P1riwCkoysnKFENFH26owrpKyHGn/iCV0TFxWvvUZJQNK1mS1v9WW3cCeqmZNObOniOZbpVOxdxcVUobEvi+fdGcJMQDkGVRlXBJoMS3BG1fVhw6Y7RhD34QuxKofdG27wo1VSk0NNJgyNhhIbApl9rbik2MbtGBR1WPWLYn0kp9CtwuITrNJQsW55SXzRe5qkVY24Ia5CY4tvPBNgyUVgT/5b/FQ1W1TI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BF+iDFDmbIDOuQdhSllFn9xsnATDanus0dksmUXBkmjFCp34oTzeO+bapnm0?=
 =?us-ascii?Q?L2H0SBDLdJYd7mxwaiyoBd5tPJW/7wJ9FgyDq2yrjZrTMe6mkIs0O6z59Ks3?=
 =?us-ascii?Q?ZjTtc6a+b2mEluaBeGQyuy/UVsyBoDaU5QA7HugdF4bpO0BC4VISThIhuRRQ?=
 =?us-ascii?Q?n9SYTrV2jMbQidC80R6vm8x8fbZ9t/0Yxjs8wDHj2BoTHn3jMuloXjsXbBWt?=
 =?us-ascii?Q?DnL/buPd2AVjumb+cSTdmMUAxVWvWS4Jzg9D8sbqZAgKXpj+8+qMtUA3mjrX?=
 =?us-ascii?Q?p23sb6JwUjXkaUtOA8dOm6RpRasrxrAk3qtd6f/ElkyfewdHU1dShMu7Xuxs?=
 =?us-ascii?Q?dgiO06Xt9eTQyASJFZh8RthxwcVfpmeKhSJcrdtpjUd74YFu8DXOiTRKBP7o?=
 =?us-ascii?Q?IVf0uaPEGxRg1vkQ+GnMZJIKLLGcK/IVnRyUJBp7gpc7UdFT6xNzDFcP1VC8?=
 =?us-ascii?Q?7W1uUcHGRL4XfKfvhWrVvC8CUBOTo+79UIAEnj1uCqpyyjDspS4796Q1SKZk?=
 =?us-ascii?Q?zA6CSLpWv9aAdn51oHTFcYwtdY9sQg5w/2MITApnmc494ch1BFSpxy1ZxOvD?=
 =?us-ascii?Q?hkc4SGbofdPCICXJ3s5GEnMq4XqQTGxjPgfnLXWMc1bu2ZbDAkvUDQE+NW4Y?=
 =?us-ascii?Q?WYMv44LeZGXXyFFRjFEO1dx0f41y25wDaSpB98oEg/QCKb20pGvK/4/PYA3H?=
 =?us-ascii?Q?xe7cRvcr4Pc9kBtKy0ELyIR12NUD4U7Jyr3baJHCd4wsBp5Mr55S2YsNEtdt?=
 =?us-ascii?Q?Bd3ftbD3GxaJbTYqc7hbMDjXu4XePeE0Psrc8Z+1ueCW1PfeI8/0lplQwZQc?=
 =?us-ascii?Q?dr8RUNjJsLJw7464OJ6H8voh6/fDDJQvoXEeVufPYDEIKW6hf8ClYRe/Yb9h?=
 =?us-ascii?Q?isfnXKFycVHq0BjY170sP3L5xfVOnhdW/+qL/Be3tixSzpUAyluFXbxhOEB+?=
 =?us-ascii?Q?TpRHrtrd8PXgBIppq3bViSdFgYyGCOh0mO8qhPjXrGpfwmAQhnrYpfEhI42M?=
 =?us-ascii?Q?AGIUapUEfLcI3jF8yI62Pay930q11ySebr+KafxLnLqc74snEg6vbwSdz7tE?=
 =?us-ascii?Q?n/uy/jjCca4nggv35hBzI+LjrygGu1Zol2Thtp6ntXO/NoSpKO0ioMOrPy2N?=
 =?us-ascii?Q?7fomgj2YGHa2WHzbjfR+u/h2C3/rMTvzUHD5YkVCK0iBuWoT7bsk+I2JpnVV?=
 =?us-ascii?Q?9wQBsbzO8YY11OgSXNj7MCHM2pFFIHnkYJbbmeR6fuVeKgiG7PdkIqTulaxx?=
 =?us-ascii?Q?NIibBHkpS5oA48VFzz1v14tEpiyXM6C44T9I3iOEwja5abDQ5fCSKr9d8z/E?=
 =?us-ascii?Q?McStianTkYwnxcQyQCQrZ/cQh4y9PSXvW92cuOsUz/X3Ghw4L72sDOT5Wwlv?=
 =?us-ascii?Q?m/yaJsHfGTj+2a8sthh2Zr16kNigNNwMeMlgexU0l7KORDL0ZKzIPYPHGP/r?=
 =?us-ascii?Q?T6MH6sJfHMwz3xzNXWT9v1XydMWyqCBPT1jm+o6RhIX6vePLq5TDnIxACdj+?=
 =?us-ascii?Q?wFaod67WVxT1y2Bm0BxgpLw0BqTE6E9zdiGLuKd0z8yESApICUSMkLECiIVO?=
 =?us-ascii?Q?4KqeqtKs7K8g0ZQOl3gc1dicYMsRi6fV2QwUfBXXX6CbSxar2Zo9bMqDdyNf?=
 =?us-ascii?Q?Ue1RP/tZtQ0LlpA5wCQRz0KR1K3qAY3baQXuTuqTEyDo9pZ2qJY0astR9GFS?=
 =?us-ascii?Q?SnJYN7CCbKkTgpWg+AhDb1fFBXzzFj3BLdSx+efgdfujnVxe9puzJ20CtVNx?=
 =?us-ascii?Q?IyXJsUhOHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91538869-c010-4069-bd75-08ded5d0dd78
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:38.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEDppjwjixzIn9tEsxKpLuBLcx6euEi1ztNDMXf0dhshJYpcHlY4S+eYRV+6TBbdY9IcvB25wbFeB7JuoFS7jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302581-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
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
X-Rspamd-Queue-Id: 2E0306D96F5

This patch consolidates the unicast and multicast management by creating
two new functions - dpaa2_switch_port_fdb_[add|del]() - which can be
used for either uc or mc addresses. Having this common entrypoint for
both types of addresses will help us in the next patches to streamline
the same addresses but on LAG ports.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- Moved the commit ordering, no actual code changes

Changes in v3:
- none

Changes in v2:
- The rollback in dpaa2_switch_port_mdb_add() uses the newly introduced
dpaa2_switch_port_fdb_del() helper instead of the _mc counterpart.
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 39 +++++++++++++------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 88d199befbd9..3472f5d5b08a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -552,6 +552,28 @@ static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
 	return err;
 }
 
+static int dpaa2_switch_port_fdb_add(struct ethsw_port_priv *port_priv,
+				     const unsigned char *addr)
+{
+	int err;
+
+	if (is_unicast_ether_addr(addr))
+		err = dpaa2_switch_port_fdb_add_uc(port_priv, addr);
+	else
+		err = dpaa2_switch_port_fdb_add_mc(port_priv, addr);
+
+	return err;
+}
+
+static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
+				     const unsigned char *addr)
+{
+	if (is_unicast_ether_addr(addr))
+		return dpaa2_switch_port_fdb_del_uc(port_priv, addr);
+	else
+		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
+}
+
 static void dpaa2_switch_port_get_stats(struct net_device *netdev,
 					struct rtnl_link_stats64 *stats)
 {
@@ -1880,7 +1902,7 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 
-	return dpaa2_switch_port_fdb_add_mc(port_priv, mdb->addr);
+	return dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
 }
 
 static int dpaa2_switch_port_obj_add(struct net_device *netdev,
@@ -1984,7 +2006,7 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 
-	return dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
+	return dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 }
 
 static int dpaa2_switch_port_obj_del(struct net_device *netdev,
@@ -2325,12 +2347,8 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		if (is_unicast_ether_addr(fdb_info->addr))
-			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
-							   fdb_info->addr);
-		else
-			err = dpaa2_switch_port_fdb_add_mc(netdev_priv(dev),
-							   fdb_info->addr);
+		err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
+						fdb_info->addr);
 		if (err)
 			break;
 		fdb_info->offloaded = true;
@@ -2338,10 +2356,7 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (is_unicast_ether_addr(fdb_info->addr))
-			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
-		else
-			dpaa2_switch_port_fdb_del_mc(netdev_priv(dev), fdb_info->addr);
+		dpaa2_switch_port_fdb_del(netdev_priv(dev), fdb_info->addr);
 		break;
 	}
 
-- 
2.25.1


