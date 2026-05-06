Return-Path: <netdev+bounces-284903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4McBBixd+2nbaAMAu9opvQ
	(envelope-from <netdev+bounces-284903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:24:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A44DD24B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 670A2305A5EB
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A183FBEBD;
	Wed,  6 May 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cC2yFW18"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49BB48C8C1;
	Wed,  6 May 2026 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080589; cv=fail; b=PsHLe6KC57sdCxIjrYiyX0JqictgpH9D7sn2x0RFVXVTtW3qIygvJl8PkVISrN3muY4VQZbQlRJ2pel6fNBFubb/f5Z3VcLRM9DmtG6yf4F4VFoZe164mGeSnTTpJhAfO948UnOSrVFTNusDTYlX7AeRovHa0gw99uq4dG73Tg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080589; c=relaxed/simple;
	bh=Fa+w6cqkNJ18IdNfUGjudm/h4DMbOel21fuxjk7TrJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbEJCjMR5dTpHf3bBkEa84tjyhAqWSkEi9z5yOnPuBs+HlfWEAqXV3EmFwKAjFJV7R2bGR2858FRrVeThBJHcsLVkpFyDnX6EWL7O2JV5WGoBPwGsix4Eh1UD6ddp8wwMXs69zCSIoi5trJ1VyMh846axBMZDpaccIbUq66EM3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cC2yFW18; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6uLLEaCtKpll4S0tE8h2R7I/7icaKrj/N3tewqRHMo8sEQMHZYqFlXWp1hrSPyjs3zt+OuWTgJ7HK3mhk0rWLdkFH3+NxknnfacKM0GK6vWuKU4lxaBIoi5EKL8PrZrRMvKk7mnZnCNaPSyqL0iC4U1zKiP4zXF1zHxxWKW/24Up/bPHtfXweiN89Vy2Yqp2na9lG+wwipdjCR+OQaAsRUVUi8xZTZCiwdHJLU0kX/L4qgAeHOwBY2fT1Z3/4imrA/r0qyv09TM08hJX50hSIxDzrRtOb2zQ2p2U5gMXKdrrJT+xZoOFwxtxz9JorhdeThU+2VIyFbdz6GZqMvPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0nqYAbJP+6QnkLBzCACNMeswzlp773u9KIkIsTSrhY=;
 b=rCKRLQBVPe1g6JeLbr1iwISADTxA7Bfc6NZIlgXVvO/qk5jR+vEOFhTnhc61+Hs4wIkpliQva58v5NIiWQk0gx/WYw5KSh3IMg97D73ZZQfVFyV+BQ9VF7YzrYeDLW6pHCJ9KSKbvta8RqaIylK16XjVvlyf3lHmxBF0fSTZxzTvjS5furFsb344KfCLjOai+cFQuOawgQwdJB0YLb4SZrZbjA9m8uzfyiSJIpTwMkzpjtwzF2mJPaM1RQsG9mdIa0YPzbwkXE6Y4DdW0dYeiWdX2s0Uqm8nu7Pcue5FhX+lwi7lhLe6Pv3og4h7az1nITfxWV2i5LQj0S6lP6dZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0nqYAbJP+6QnkLBzCACNMeswzlp773u9KIkIsTSrhY=;
 b=cC2yFW18nWfvss8nCnjnS0NJ2YR0uqmGi4xCdLm4eqIXPj6K8lBQ4DHYzwdkQ5rLVD8cWktECjrivGTRexuoyClKXRCs2/lFukd8/CXU373WIDLiQpuKVtWPeAZlTcfk5crlmPD8xghmIuiUYmQujkQ/R6lWIycpXDvvmFSTcE6bdjgdtfYQ1IciLROWZHPGpiurHFTe8Fm5faYu6l9kCqSAbQQA7vfzJOHRfec1O92RfmWDjLeXgWnzSC/54snAZzstj57nHp0BgGylnOLkBYY2r1Lj8C1yrS86c4uNxCo6tlGHDjd5GA8/NZTgm7gSMDUI50HqqnDRx8ncZV5SRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by AS8PR04MB8277.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:16:16 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:16 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/13] dpaa2-switch: consolidate unicast and multicast management
Date: Wed,  6 May 2026 18:15:35 +0300
Message-Id: <20260506151540.1242997-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::10) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac68201-c043-4399-fcad-08deab826ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lXuSPwMkD17KazSBW9JNL7KsGg18Ok5P20l+yhKg+UqWVitiNCYEYL+KCE5N5l6EinWsyi5dgIM5ClqK6vxNrYxekfrfLPq5Zn8Jg3oDe+MNN8HFQHGHXWb/R6y298H8fkVva8cRCYa/3Ugonr9sf/VFJNYyTj3UI9KOsPoOK9GV8FQJOBM7ZU0KPQPjyREY6k4dhWw4W/ZMTM8AX9yE3CiugDUrjGboDplRZMcibiksBZqgirP4VugcoTHB3ZL1OwmjjeDOoBwyOFfp/tZ3SD5Q0RsAgNKCfxLZy0fW4r8I/sXHLQjiN3E3Pf5lO+9SaRHad6GHTqSYqYAIxhG5nFLv6s7YCE2DO7bzM9K5eBdhfZU9IDCwmpDUPjbW8ghDD9MmVGqplFvx6PvPZiuIP+eLwuqCKsHQtlChqszjYyu/0ds6Kr95uOkU/2UaWchYuCC1qv5MjdaEUHUw21BnwebJOJNmrCEPqzSaYe/F6iMC+FJKOkdXrKoAGXPCq2O4mIhFBJBQO2jBQ7eTjMGsFenne2CZsRIMG4wo1Tn9RywLllX4LvGjj4ZyxtjFlalK/e83DLLg2mpAFDOjJ9RZwzFzu/SkLIxaQlfw/FYl8AC+bJr1wXvd9jJ02jNPQsOPV8MGTgEtimcuxuvmFJOyXt9QdC3ilRck2+a2K7LCpVNWvXoesazASFXdv5Sx711F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wPKTiISrsOtFjW9Ql2JnFErEaKdGNqbS6paW6iy7gqmx4XnH488+vFLBnPo3?=
 =?us-ascii?Q?IxcIiATTzOsbtpMJjn/Q2FlrmL4corhhS/CCgsQVVrGmEpdM1R7D9ZcHbztx?=
 =?us-ascii?Q?ddg7/zopUBlYFh4Olq+W/+OzjorvGIqS6P4Xno3YDJbUnD55HHVt4AbvaZBw?=
 =?us-ascii?Q?kxP9RT9kiQ+kuuLcNXqleBi7JLUiF46DIbVIFaMLlhQc7k4ych3rV8/W+fMM?=
 =?us-ascii?Q?MoKRxIruIffrkYoyvYYdV27cbvbURloqUUhzGKE8QQxHdMsX3ENLAr5AFex0?=
 =?us-ascii?Q?D5keadlo6eKnjPnzu84cxVxXsDlIrd5zAcwoPqgvd9WGxHuj7gcv3jH3UbhZ?=
 =?us-ascii?Q?gj9NiYrtNYdeo+eL3/iTPchWT4OwylBxBsF5jKKd5Jytt0xfICXA+MvOLGuZ?=
 =?us-ascii?Q?OX6KaH5GR0CVr+Zwtw2DIS+R/G1HQvoCalkyObfsp51a/EI4kdBpBNhT9Gzb?=
 =?us-ascii?Q?NER9LiZC7xeEs9B4JghcZPR80P7hGrsiCCr7o4Zt360EYgXAOJfNK4N37IEY?=
 =?us-ascii?Q?UHQ3o7w4wVp9nfYFKLmR0EIPOnJj24tA9pA5wYOJhXuXppiRDPQdzFnSzfdC?=
 =?us-ascii?Q?eIT8dMdBahk/Uk+tohOSzduDFGfqDHcvKx/fJ4rMmqdUpVV8ZNnOiSQFTKjI?=
 =?us-ascii?Q?mnyzgz8NXkDOSbxPyp/dsV0na5OHLCUiR2ZZri/BFY2bmIUo/X6DVqD1BWOv?=
 =?us-ascii?Q?mwRSNUV5Me+tpZqcsr1zFJAXJEp74PQFhkOmKavYstUR7h+bqLmzMHMnnqYf?=
 =?us-ascii?Q?shG9RnVaVRtP1/v5e+G72x7NbjcZIo7uDaDi+9OSNItuMFzpJ35c2jCbgKaS?=
 =?us-ascii?Q?gil3jIKLpWBZTagcVit/pzlxH2LIGXtA9CJMsem15zI2RL/QFX9mniGNTOij?=
 =?us-ascii?Q?qKHVKEotNUeDle55k5cCUAM4+eC6dlr3ZTM9/0lDEnMk64Zj9XE3neAGq6Eq?=
 =?us-ascii?Q?dwtcGOBfonvoM8wXPhqBjhIuve0RIzxzMfLKZavtBOnCp+F/bV29gK05MG0u?=
 =?us-ascii?Q?ZfueEsKzd5RC4Z/IuaRfJtjHhL8yJWPQmIEj5/76RRtifnAzJdoQhhlkJZzU?=
 =?us-ascii?Q?nd1vKNikT1hpV3TbhPF7iaaYnY59W5ny5Y3YhuIdiHWmpjKaf/HBTGebqXGs?=
 =?us-ascii?Q?XKRZRT1XkMm1KWm3M2oiz/DoVLfIFLvWkpSDVJRlMAa8O5iPkehW25mda9D3?=
 =?us-ascii?Q?Gpl5kkvTZ0Is+hdYbSa4litAha/OutbTn7AtwFOzpf6gC96Ms78qd/IOrO0T?=
 =?us-ascii?Q?1EPNIb3hAn14J8owNty0uImuEHNOBwlRDzXqspETGKBO4BhnVZhvSid4K1X7?=
 =?us-ascii?Q?BUf0o8R/Qfx2Cljifx+KdhVJFIt+dqcAVz20vwFUhUEMdicsL+3q84myP9+N?=
 =?us-ascii?Q?KPp7k0WkqB9XGVCMPZEAiuw7V2gbD2w2pgPQDjluFpadEHO0UIammo5WX/GA?=
 =?us-ascii?Q?qIABs2RI0wODLB+UoENzd+iDPQBGQjRH4nAaZMRGJZMxSjqH0I9VgsMievys?=
 =?us-ascii?Q?fejeb0VL83fVffhzi/r4OwuLvMG+ZAcO3BBdF9I8KufBLQMY/mBFBWKILHwM?=
 =?us-ascii?Q?malzRuc3FM446OG9yALVQXseAvO3YHBgf3R+zzzoBYQq9k9NNOjl5neuvpEN?=
 =?us-ascii?Q?Y2b3QLEslcuqMTFWSKGev+BUobk8ou3o5KMzr4yMKlqRIjZtnpjI8MLx/vP/?=
 =?us-ascii?Q?iPNzM7AXm3FYdCoGgdoAox0XHppUXkh6p9kJfsDPRwMEQv4TczrJhH2h8Ous?=
 =?us-ascii?Q?+yLavseJCg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac68201-c043-4399-fcad-08deab826ae0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:16.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QN6ubJYgeDinNlCtOqLOBDOnjPF0/Cl6WCTrFg5Iq/b/T45UJlLuAl7JNWPgVH9VJaMx/w4abHIaDE40vAoDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
X-Rspamd-Queue-Id: 153A44DD24B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284903-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

This patch consolidates the unicast and multicast management by creating
two new functions - dpaa2_switch_port_fdb_[add|del]() - which can be
used for either uc or mc addresses. Having this common entrypoint for
both types of addresses will help us in the next patches to streamline
the same addresses but on LAG ports.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 39 +++++++++++++------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a057fd85bd27..bced37335a9e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -551,6 +551,28 @@ static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
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
@@ -1915,7 +1937,7 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -EEXIST;
 
-	err = dpaa2_switch_port_fdb_add_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
 	if (err)
 		return err;
 
@@ -2033,7 +2055,7 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -ENOENT;
 
-	err = dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 	if (err)
 		return err;
 
@@ -2725,12 +2747,8 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
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
@@ -2738,10 +2756,7 @@ static void dpaa2_switch_event_work(struct work_struct *work)
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


