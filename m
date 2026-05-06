Return-Path: <netdev+bounces-284904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEpZFMNb+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:18:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F1A4DD05D
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BE7F302B922
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB634921BC;
	Wed,  6 May 2026 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H/rBNkhe"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431A48B38B;
	Wed,  6 May 2026 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080590; cv=fail; b=oSF0McEBomcXGJJHkkhrE7cUbxp+IBI22knq7nzhAq1Mj1/IE0JDI9W0+NmOghUibvbXWjwo2uevq4y6UmiKGhguIzcG6WfzpiG0lGlToboYql6JEWeHn9NoswX4oa9ZB/mFDMOxdqEx9Q/r3Ay1UWRdp1RdhmQZXiUg4d5mf74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080590; c=relaxed/simple;
	bh=SqOM+auauzTkPv1djAvdzDTOldodlsdQogNSOrWfgKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SWeSMCYO7qtZXJJM0y/TUMVSNVdGsvVajFkGaRZXnMy7a6f/aaOPaxYKQzqmuFObm6XAjMC68PtKsTpbu9xKzlY3XAG4Rfqvza9EaLmVkutvTKCdH6XL+VqzXEWnGMsdrC/CCzQNTRUJhIxzZdgXp/EZuq+frN7t6uVMsWRzuok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H/rBNkhe; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+Y6sMMe7QTGaFeFdMcHQQQ2N6QGfBJCZ1LRLO8p89cSiOZ9geJeqVeXQW/xKGZg0CjeyYa7UL9/8nG4Ddgmtzvhel99Ob7/BN4KYdb1H5AgTcjIcuCBb2EwyFUeMVRlcRzrAnuKy0GzG67ot8rzp9l/UInY/u3FTH/uhk3/pCuKcrTbsSxMArG2ZWSgvYYE/fNXj8lQsITNf9FGXMiuDRBs9KTkJIvkN2M2b+QSyn4us7sp7oeW4ndqVWzWy7QX7hTqWXnsMg0jaqBVLemaNS25MwHyzk1iGogUDD/2+RVO1bX1Vh5Cvkbthy0HvcY64ZTBIWv1g95mBfehkSk8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GUK2CKmYNMpoy+TamzfnJ2fwozIwGzcWiGJD90cOU8=;
 b=ui0BQSrU+4s5gNYV6UR4iWuNjTBnZPtd79E1+J1yLgxc0LOUpzvN6DPWeUJZj4Tliq1bD+etYUL0JsZr0Gk0Y8ZYQ9dY0ExthyDTHakvXZ8GTrWOJrGNuEO5p8krS2ex541psKgWXM0CqBqoE2SYbidMhdNOOL64J7pHYAh++uirvz4a06VSd3TyncJuKNnL+eVdPRVvwExBvkszDO0AhUc7qnnYVt7BRgLKGD0WZW0PNhi/q64Rfiv92dNmqApmAdkAICTzZincQv7YEMnoN3mD/9qP+VKUOQpznGkDBfijzVCkp3MFijZyoIGR6664GW9LAuFzwiS0N0DRgnwIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GUK2CKmYNMpoy+TamzfnJ2fwozIwGzcWiGJD90cOU8=;
 b=H/rBNkhe8oRNHmXOS63z31n42qXXLQYV75JigySxKo1/GXeG1SDO7B20Ni7tler75Hcs8aP+vcN126ZbRBVpNXbPEaFuUvMjtJE2a9JavaI1sx2THCuMyXkEv/xWTa62TUZ2yds6ImqmYWIL3t8YbRmyr9WT15sMYJVeQeBWenyXy1pPrc/2XtDgTX+Q2YwWFulUoOz92JqwmPetrVnM4xhHfU/k8ximfQ+bqTfn3aFb+FqVYAq+ypMBdvDRCKzLjhNRL9U7yB55+ZkWP6+b4J1xJn1taFG7AvU9gl5ew4my5+iJLU5rjHrkSTmvn8ObT+BsEeCjivUQgOxO6MbTFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PA1PR04MB10626.eurprd04.prod.outlook.com
 (2603:10a6:102:48e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:16:08 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:08 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 05/13] dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
Date: Wed,  6 May 2026 18:15:32 +0300
Message-Id: <20260506151540.1242997-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::8) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PA1PR04MB10626:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ec8d59-11fc-40a0-8680-08deab82664b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p8Sn18qypZQxiTSeoDZ5tfYFcVp60Escgd1GIoC6bZO+lp/JQS1xmcC/+m4zubvkF4lAsS1z+kJabNl3w3BEqWqZsBtfkXUkIlwwgFiGgOrgM9NzjcJ9m61pTqHTiyyHz1kpGmc2YvfTU08mew6eNe7OCq3fkFquQCbKzyaiwIYOdvDxAILtamVigHnxe5I3BfzpxDrzyG9RHim+Wa0qpLfghO4eg74BjyjLE9bw2aLC6oaiMAZ+wGystaRtB4bUXyilld55znW3qHezU7O/0F2YgVvr2NG2t9LdovQF19YoEzWKG4OUI0Gq5olnss3LNfbsPB+SEJQtN8q8JZ4GwAp6aQz8CHf0ZJpm5lhrwJ/DJaKXacZQZNHUX213u+y+sfNJXceL+0gj+gzJwaO2eIPkck4Uz5ATbaTh6ib3L4wGI0aHv2fh2x8YW2kDk6HcQpKlViwJYhQfLkXUkAvEoSIk3fG1FPzRFmIlQ58ocIvQwfze+Mam6fqxab+UDRqPlBeBejo0spLoOYZClcQLqasZaenuKlCDJwXRsdzuWoRei2w6fzVAqhLOxtP1uoCzWh07NWXAo7qt/aM22gDKyCD25u5VGQeK3DcRcwzGzfqFDnyj9GgD+cX6hI5WZV7TfsVL70GJheW5XQ+6EFsY2ohXT9LP9LKE/HXiQot3lBrze4NZFJOnuld2/1OU0GxS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzIKCkItau4EsGck72DaEZGIJL10fOtPaOVb/p61dS5782//Mh5WTVa4AEIN?=
 =?us-ascii?Q?pEePr00pYBnLPL5jH564uVuxwmjVFzDjckU5GVm2hkjzYZffAYPiQ4BP6yGb?=
 =?us-ascii?Q?Pmi3IG1j0ZfcEtHgP+EzNGwiM8AAaZfZmpWUSODhXfgJTrbGUz4rz+PDfYol?=
 =?us-ascii?Q?8DkTcoVx+07Qu7CFfTsIOQZcJhkeSGhFZKKNGcjhiKQR2JPzhMz4MMwwgVtv?=
 =?us-ascii?Q?W0+phbyc0YYajl5HpO2pOK2ItOKNiGEtirTeOpI39vcSS2Y6RA4rQSD7hU/Z?=
 =?us-ascii?Q?FigWJa+GBHY+yWnqhwGvopc06jR2z3ry2YHZUBZlZiF6R+FbxSnzUJwmi45W?=
 =?us-ascii?Q?HIRE6mQTBEYS0biQAZRXa/sMn8CKEFR7B7BZ8BM/bRLjD+YU+0so0JUB5DlH?=
 =?us-ascii?Q?LH6JqzfAeBfVNv2tr/IJM/z4N6leFJJqVm+FyLwuNHlZDYvx7SSjVJrmEX6L?=
 =?us-ascii?Q?RKpOZ89nc4Jb4o/uc9al5G9kxrucnsJ9fDF/SWJUeMMpfgXxy+nBUjBpolXR?=
 =?us-ascii?Q?X/cHpS9B/DlOp2rfXVsuJA+VnApZG2dy+2PLFAKanMbOP37i0p0pqB1rlliY?=
 =?us-ascii?Q?wZ9BGXAiNPpLrMU2YSDpNXTgA2fhoISTu5cm2h15UgaOyKu17PWJBEaItk+i?=
 =?us-ascii?Q?1B3qMNOeETs1+RLkiRuAX5IHxOGVEXAblRaIO7aeFgaKaIv+sVjZPQRExeot?=
 =?us-ascii?Q?Ss2nyqxxLpd0y30hZCX5giYDAs1IB4doA4CUgma5E6bW2dt8B7+tgv/G/hq0?=
 =?us-ascii?Q?CDBzsxHtWjJG28QY8amhLtIPsBwpRdVcp2lOOcZT4k1LbeC7P445H/6OVEtA?=
 =?us-ascii?Q?TwuhjZqMCh4/s3Yoydq5ZAKmv8ZsM19diZ+l1Dz1ShlWMhbJEelBe87H+MnM?=
 =?us-ascii?Q?MesFcX/sBEjP/MNhd3Ef2ZJ2t+eOTr3UXAF8oto54QCbHvX9qtFwOWsq0fRn?=
 =?us-ascii?Q?jn/nUmKW8gW0SptG8bXtkeYToRkDSt2rhwO5NCPLXZBDpPlzRJnwiAk/RhiP?=
 =?us-ascii?Q?rtV9dF2wU9x86WGupQ+TjahjSxV9Ur5JclwuF3W7wNG+uI3oW10j7RYkwlyW?=
 =?us-ascii?Q?Oq8y1mTiNch0Oe8ZwaLvzduFCRYrHgdAK4oW2+0huQk92i+cBRn0gljZtl84?=
 =?us-ascii?Q?+6s3EETqN99sUCpi5IhtIXzghEZevI7IA/hmcZLoh8SAmEE1hD99Xd//5wIH?=
 =?us-ascii?Q?q/Lqf4DOWpa2AXufRSfu1oPNU522bqsvB0wCM1ElEnGVpdIpmJ8ZKhWIKtDz?=
 =?us-ascii?Q?ich9go53tRdj4HFkS+EvDciP2Xiem60ZrjCPVow+27leNaHs3NBRKiYhWBSi?=
 =?us-ascii?Q?/pxIHoQmgknEGwV/d877NkjccQ1z5B097Dq0ppt93hX77sjpVH3fnR0Hg+IO?=
 =?us-ascii?Q?POoUIMsTwfs/tc7Zo0SbNVXlZSQCE6IHV9RSvqT79TX6LM9sJEdPgqFpE2c8?=
 =?us-ascii?Q?BDeDjzExQo/skgWx77d2hrv5VMYD2fTYw8UGc6h7b9oLhed3GKdxI9VriIbf?=
 =?us-ascii?Q?5/GGfLyp/U26E4ryF1O2D4rseJRNEmC1ilBbtWvX7Z2azG4ek4lygX2AG8Rx?=
 =?us-ascii?Q?zLTgYeea6L0D9P9WT6Wz/7xw9CCkDS/gHb1gWdpAndoaXowiC545R2r8d+Zu?=
 =?us-ascii?Q?cff62QxjqghbUjOaKLxfuRCzkSVzRPt7kX/uJHbDxb5xEZHXC6jlGTQ+kjvd?=
 =?us-ascii?Q?ekHhpV5SCHwH5GAGPpmmXTNwS3LbvNWNBtIpXOL3l2Vr4kSutqUs22r5qLkb?=
 =?us-ascii?Q?BGj2nlhG+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ec8d59-11fc-40a0-8680-08deab82664b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:08.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvhUTj6ZJh81bPAnlUM5Jh6LsQV0QVdNZC/NZAMM82SrD+HfbuXtoKyJkNGIS/vqt8/v8eDYpyLuRM73W7PLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10626
X-Rspamd-Queue-Id: E2F1A4DD05D
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
	TAGGED_FROM(0.00)[bounces-284904-lists,netdev=lfdr.de];
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

With the addition of offloading support for upper bond devices we have
to let the switchdev framework know if a specific bridge port is
offloaded or not, even if that port is bond device.

For this to happen, create the dpaa2_switch_port_to_bridge_port function
which will determine the bridge port corresponding to a particulat DPAA2
switch interface and use it in the switchdev_bridge_port_offload call.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 9d3a0aef1568..aaa22dc15038 100644
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


