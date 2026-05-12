Return-Path: <netdev+bounces-287156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMZbMNg2A2pM1wEAu9opvQ
	(envelope-from <netdev+bounces-287156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76552234F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B516931BEFAB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF23ABD96;
	Tue, 12 May 2026 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fcbRgkb1"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235F39E9AF;
	Tue, 12 May 2026 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591784; cv=fail; b=tfqc8jnTdGjMRls2eWz4YNu/Yh4yIQrZfWigBYsY//7Qp1n01vHBqPPQMJoMwP7ag/a6X0rxf6RmyeQ4M86gN3mkV9wHf6Y8r2HAU7aiq+PQ5sL32k43tWfFLth47BDY4T6Pv4MnCoIWlwBtgxYlcY94EMUG4jXtVPgmP3k4M1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591784; c=relaxed/simple;
	bh=xo4oCHSMOmauuE9Vbn8Sh3Jr53NgnIgxSuUalmpsIjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1ZIN+04NqVQ4PAKf46chRCrNUakHObr2zIg2O45LJQuPy4G8TYRJ06B7u4M2gvMnPF+MhHOtd5PFYzF9xPZHOadGZApk7tVLLoPBErEF3ZnX+EDs87BGzfusidJbGh7JmmU2F2q1e9puOlBotAzNndEdvni81Sr7Ce/dK51TNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fcbRgkb1; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5XldbjmjyK3rpC/VUyzUc5uphL19e7Fe/ifb8mfz/1CJ+rA2/U0aRiOfYNFxWTSKhk6tLPizU9zgAtPW2AeQmzm1sXnppkB1r9g4SsgIRFISOqhg8TUU0078qeXndBbkaOnBwD/C7Pe2EhCrCAiB/nOSyCVDu6NsYsaSKZGfrVrCzritNfD5UlO3CVIUCASPQAnk/DiPZ97QTT6xxRGeEz+0sb72AaUAnaEHBEMVsnBxZJYXZUibZA8w8aa+NNM4hiHPZMscMdAOdHg7s+fAAlVZkDrWtLE5oRM/GpWAzJWXGaBwTMzQrViVIOdVNzrTzA4Ia0eo9EWBTXasOo3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRpnfDPMghLSghMp9lnodSaljuSHR3PypLUCUQJYIT4=;
 b=wGpWrx6UrYAT5WV/4QVfLFfVhE2qFaRm6++zeDEBvkEjcIedC3gD7YwFS5YGGsWBXdEOOJQgtWyCsIop4PCbdjFDFltgkaUhaEiRshK9BuUhz8DtxUA63IVpS40JXs+Q+GTrhbUKEZ5RH9X83YQS7LvVdEPfwTJAVgyawem+tlo64UOthziuegn4d7DScfoFQWju6Z5XRKNASC7PSMyDDLU9nKqXxdIni6VLShdKRDIYBlBdJYdG1zOeVQJ44l+XzHIFuZaVqvZ6IlDWumIKOTDHAp3no/XS3cBqcg8++GmxuuEC/Qv6aAUxqi1e0HUgFv2086W0Ey3CWFzWm20KOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRpnfDPMghLSghMp9lnodSaljuSHR3PypLUCUQJYIT4=;
 b=fcbRgkb1izFZnXTxk70B1fX7L4mOHl3x+hP3PoqGylhHitbAHnbC6qwYywRMtxi+hjeYgQfTIjMeDL5c2ZNLf93SKGRYBlJz93zxzLT79FcKn+kQCiwqBD5ZvvIu9P7mzA57U3K2XsbRQ4FmuJK86WUg/QUJ/cJXfJnmbRaKKDIP6uM+7KL6VYCKagFSXIAw0/gxJYz3gSnCWnQcgh1EUMGJ04s/aEvAMqcSm6bFHdfvBIXHkFaTjSZXA5sqXvPywGwepk+HQ+P9X2hQmGMYGE/EdtRCfWC10ZbYIIeVbXgf6DqXR1qIcS5fiimRN63VwGlUAm5gjJPKijvfNImjEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DBBPR04MB7657.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:16:19 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:19 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 05/13] dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
Date: Tue, 12 May 2026 16:15:46 +0300
Message-Id: <20260512131554.952971-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0171.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::8) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c61b45-275b-4d4b-b2ac-08deb028a7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f2CkYx+KAjFRa4VlPKzbIZw26cbRKRa9Zh1ZnWmg11lzm9GCVCn1wRqoQKEBvAx2aRjy6ciaBH5JWvfZkzqeRg1L2kNOoi1J/H5m4ovSLCfmdYqOSZ9/KF/Vo8RHNE+yC2Dlt20wDJ6IkAOF2+AMHiCmQdxNU6QWxcpvfpHgb5jZTpaZSQEl/S31X7aROGdOtgB3DjdQGy6qxj8/BAAQ02cu1ZDrKwcsE7D7brX25kPrfwA8aUPpHMIN4fI1hDTAvbu7tEqOY/7xQs8dwFXrzAawM6q18aTB4l9kyv/d2OljcxH1eE4PoFgCVf/xxxRO2sKzcpV8HTssmHzGd/P3/WwPbzZOTu/GgnFe+skuZwajlAWttsLNNKQTDKYLlLHJRdLHwaNQO/MjyDlYVK+S0+0wCkyZdXBGONyKmO+v6nRz6H4DhubdARD1DVha+3pPb5ko5cLvqqfrjRS9iNLaMlN88MfOWVxlfksMmEktkjfG7v5p7QpUIf9lRnpC4STXxXV5Z6XqhUmmnordnoBOx9csimZGxskW3pyDNU+Ox1k/VncmjNR0qICyj7cq2oLEjFyvz6HQ2xrIzvx0w/T6xxijysbo4IMS+DlK0994BSyl64geaSOTCX5s5tEdOlxqjYqFZJyB8jOz0NNDiIl8LbfQtKepFSQDwY7U8JzVNJl8v8rRgEqR2BmwLOGUtBuw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(56012099003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9U4r0P0Am4ox7X7H30qHQVlKjShucn1SKrSHBWohX1YTxZDhS1MePjt1FUq+?=
 =?us-ascii?Q?b3t6Pweqt0PVkuf746X3oqp7OJ/yJ+9SrPI4ojstjgL5tGRWz/um1TLKeTTJ?=
 =?us-ascii?Q?2/TAg15Y7CidsKIknk/2RL2o2IUOS7DHG+wBtwi7rGxUDQ4zWIt4YftqtYf1?=
 =?us-ascii?Q?J4EtjwMIcqLzhvwmhtzkwfRYfHVl/2N987CBc8SUe11cavtYRba8RdBEGZLE?=
 =?us-ascii?Q?2uC2QU1IH+oUmOabHcIoUg50K0ajpwyfchsW/POo8GIRLVr5Wyokq2qpHZfg?=
 =?us-ascii?Q?VKT/XsX5z2HrsnoGTZFQheQgCI+kYZcv8Ub64Oj5cNPNSgENxLM4QUDfM8ZM?=
 =?us-ascii?Q?95YaM+JXvz83Tqb0ZXkPrv2diHa0cHyBkWq+dbuplTnizSPQqVBAG5yEkDU4?=
 =?us-ascii?Q?s/gQczG+tsy7fLlRIdjRAzZWmqjVKJAL9m/18d/z0IE2KzKE3LoRnzxQ/OSs?=
 =?us-ascii?Q?VRgjGntKZWD7CqSEx+L4ehhOhNwzIx8Dmf7EUh+zY9ZGUb8xKGf3ZaZ1rcBy?=
 =?us-ascii?Q?gbBNaU1+l6/f+W4Hh5oO+39/QbDH62tr0uKlhonXGj9ECWKYMhMiMshPryix?=
 =?us-ascii?Q?tbZRMx4+Z5OyendPt8iclCDjpThfD+V8goanSypg4n5asVgkKJpn0Xi4t4p2?=
 =?us-ascii?Q?+fvcYVNSJ25H7o0jxTk4Ba7/UVvzdNVpEmDtVSnpZFVIiP4+e9B5FMJYfNdP?=
 =?us-ascii?Q?4HDRRRm+aUdphZhdB79ox+0UfHwRfDENbHEp/a8jvc8PLGNdWFSxHQIBlZqv?=
 =?us-ascii?Q?9Be3dpPyTGv2pLpXAUuNEi/7qzZTc+SuH/mOq+JZZwFa2DuwDZyW841a849w?=
 =?us-ascii?Q?L5HxiKWoqtw2DIgBIxjaKx88Y7fUycMHE2jdJu1eMftuZuTWYTiFJ4pIMiIa?=
 =?us-ascii?Q?RScMcVOxdCYwfdqipz1o1h29diS5xMEXsNxE8xRjFHNjH5Wg3FYb3Ep6OHMM?=
 =?us-ascii?Q?7xg+MWouz/Ezq1lQZlNNkhpz7QdsQh0ABukteujSHjbGOEqRMjexULEl7S/7?=
 =?us-ascii?Q?qTPxyz+7D0WOuzwGCDUsZiBLRhJMD5ujwsJSMZcY3y+5u3sx6wTa301y0GYZ?=
 =?us-ascii?Q?hF8z0Sw3LhJb1gWhBOPkdoOBFOPdtjmvbNUK1qh+JaK9cmR0AkLXBGmCaWOa?=
 =?us-ascii?Q?FrqiB/tZ52iYbtOa+IcERDO/LXrQ/sWdSAhHeYiTWylAaESxAAo/2613v0Zn?=
 =?us-ascii?Q?zpwH/7P6HptHRS/Dt4cGGLhJMFVwK5Hz3l31gVT92Q0US/0n5pnxZHFhkeX6?=
 =?us-ascii?Q?FGzjJSyt42G5Bz43JwcQ9pOoVA5bBP/iQ23VIU8vLodi+bdNYA0iapp6m+u1?=
 =?us-ascii?Q?xnthSD1FSzbg2vm9wur7Qmu8G0AO5q4A9DVoL1rCxk8cYkE6N6bI3kVVHUmL?=
 =?us-ascii?Q?H3O7a9Aje5ZcSEv3GIC8q6DK9BCwYXL9kZB84q68L9HUJcg9NHxKVQ5FZYng?=
 =?us-ascii?Q?ULdIg4YBS7ENg0tdSsI1OjZeB8rKzDTEJYhi1Zha8vFnxusUfyTP8os7XhMj?=
 =?us-ascii?Q?BKpeJ2IOe0ftpBQv04EvYMdGZoGvs7i7r44aZeMYYwWHxhqxVO3F6yHA5pqA?=
 =?us-ascii?Q?+6X+9rObdefYa4wMYhvSCc8DXlogb1heTXm6EDi3OIlCuyfcUiY5pWxvMxAB?=
 =?us-ascii?Q?O3JbBbgQMb3iM++NDfhTrqnIa2EHyTUmm8mB7DGq2733UGee0J9UY/raXrcw?=
 =?us-ascii?Q?c4SKPXzSYP2FrymiuGjAWFfBT+6sKzV5Ms07S9y6cNgDZLpnHYdLH6GlfSML?=
 =?us-ascii?Q?SWvM7EXGXQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c61b45-275b-4d4b-b2ac-08deb028a7cf
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:19.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5slEXmwjLoYcmRm0472bEE4l3fNbrO0fen2vI5LPljMvQeT6iNTw6HcmUrn0ImexIxLeCzRgdaLkTwMe/YJDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657
X-Rspamd-Queue-Id: 2B76552234F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-287156-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

With the addition of offloading support for upper bond devices we have
to let the switchdev framework know if a specific bridge port is
offloaded or not, even if that port is bond device.

For this to happen, create the dpaa2_switch_port_to_bridge_port function
which will determine the bridge port corresponding to a particulat DPAA2
switch interface and use it in the switchdev_bridge_port_offload call.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 8af8b1f769d4..aa6a6731dafa 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2076,6 +2076,18 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static struct net_device *
+dpaa2_switch_port_to_bridge_port(struct ethsw_port_priv *port_priv)
+{
+	if (!port_priv->fdb->bridge_dev)
+		return NULL;
+
+	if (port_priv->lag)
+		return port_priv->lag->bond_dev;
+
+	return port_priv->netdev;
+}
+
 static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 					 struct net_device *upper_dev,
 					 struct netlink_ext_ack *extack)
@@ -2083,6 +2095,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *brport_dev;
 	bool learn_ena;
 	int err;
 
@@ -2094,7 +2107,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	dpaa2_switch_port_set_fdb(port_priv, upper_dev, true);
 
 	/* Inherit the initial bridge port learning state */
-	learn_ena = br_port_flag_is_set(netdev, BR_LEARNING);
+	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
+	learn_ena = br_port_flag_is_set(brport_dev, BR_LEARNING);
 	err = dpaa2_switch_port_set_learning(port_priv, learn_ena);
 	port_priv->learn_ena = learn_ena;
 
@@ -2108,7 +2122,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		goto err_egress_flood;
 
-	err = switchdev_bridge_port_offload(netdev, netdev, NULL,
+	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
+	err = switchdev_bridge_port_offload(brport_dev, netdev, NULL,
 					    NULL, NULL, false, extack);
 	if (err)
 		goto err_switchdev_offload;
@@ -2143,7 +2158,12 @@ static int dpaa2_switch_port_restore_rxvlan(struct net_device *vdev, int vid, vo
 
 static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
 {
-	switchdev_bridge_port_unoffload(netdev, NULL, NULL, NULL);
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct net_device *brport_dev;
+
+	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
+
+	switchdev_bridge_port_unoffload(brport_dev, NULL, NULL, NULL);
 }
 
 static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
-- 
2.25.1


