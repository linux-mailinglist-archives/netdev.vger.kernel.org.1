Return-Path: <netdev+bounces-287155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHBZEEoqA2oR1QEAu9opvQ
	(envelope-from <netdev+bounces-287155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:25:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D561C5211D4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C67430D2183
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B339E9AE;
	Tue, 12 May 2026 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XJOkjWP8"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AB39AD5B;
	Tue, 12 May 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591783; cv=fail; b=mq92exnMFszK01m/KGad3SP3SE9wq4rKywLRlGg+tWeGhE4bG4BWuBm0X/XTXbL/u58jQY5/6Ac3k15D8S1kl/vNAbY19dV1RD3XLuyOOMBgQJ2K+pTnhCEAX2aTiOTyC1WYSr0o2U3YQLaek8mDkY0q2UymjJ+APHJu9fNKjTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591783; c=relaxed/simple;
	bh=VKl8pzq8ei4oMdYXNJHtCc92fiBld2b8hqzK4jhxYx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AuEKGggwKFE1TAsMZws54deuRFlMBxKGuSdTvZwf1ikVrmoXs2K8Uixa3MUf1QiCG+sxFbPI7fd1fC76eNRedLWGtPU61sgFjqKGvW4By+zGbmnHuNB+yLmWpJDSBo8C0OxzIObB2Wb36fDNcHWzNsiRDZfJG79YbgFjyKQbYDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XJOkjWP8; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2WlHWfzemlhuGVpn+GYmlvdE/NKXod/SRYe0oh2WQS2PuDbj/kfa5n4S7V0An1r4/iLcgumPVGWe4STaJMfVHYNvuO7gmVHdzhxdN+gmRzOA2Iw6+grn9xwKcuMmbNoWiPNn4oWZ+p9POaYGrZif+I9Evv75oJy/QcxEGOs6IH4n61Za1hnRL3XBs7zZH0HNIqk2+V22yoVqF2eA0KVIrKMpQ1T/I+1s4bI7suefqLrJTr8hp0cu1sbxuyzLA/eOJlPixQ4NhraTNuoxAFGNcx3xDopHjXkiSR7zIP2MS87KDRTJdvIaz7D54zO+f9YWLKLrZUED5g0pFajtk2YCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwtdX1/8zSUVREGOhbC2laPBoBgJw2u0Dyq6fpoCqjI=;
 b=XZkvNIB2UVroIisnVgu0FWLLsAyLaLuUWw8NkvFH1tGkFnDyAUMR9J+xTGJPv/MgD7T743Zcfnvmcma2NkFZJJP2DGBEe5RZHPnbvo80heiVJfBOrls+yVyJDnzm/MwGB1sSqQS6HR6djNR3wXRubqygjLF5YU/z/CAHtnioKRfZs7f8JMsVzS4z6DOaFgdnXkuTHEzQ9IbMSpw1C9NhZIoa6tQO/HE8Zqvjyq77H1xwH/c5ZPmYsDRIM7XLtNpM6mnBF7ayS4WyFXjAyJX/mQHJQa0NTrNAQ/F2PpF5qzFuU5MKYUp1lkd9w8F4wnzKW66FF0PHzzWZCVYyX0NaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwtdX1/8zSUVREGOhbC2laPBoBgJw2u0Dyq6fpoCqjI=;
 b=XJOkjWP8WAA5cW2gHGr2rZhlOcro94QdjWDyXmYmeiXikTzSHZfjpg09zzJ0sVUm/AxDUC5CVgirLfEbz/q8jHtsJxjuq3CgiKzgqsig1j8c1rSHIrDNEBPpKNuNpn78hO8Q8bztJYxrXkm/92Xi+gJIhv28ys1E4aoMDFj68BxL6G+UcMMDMIDAqULS8O4AZVnPm6kDEOEeCZ6if0ZL37anZk8OmS6XoCt1dV6FM2PYLzcDhPvnyl5/UdvNg+QgHaUY0gPMdWJ5BMpf4/Ft6puKsBv3YmVe56Js1pmgaiukvXBATLI+mBkLSSX6h7q4YHnQC+Poo+6mV8usKwuo8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DBBPR04MB7657.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:16:17 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:17 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 04/13] dpaa2-switch: extend dpaa2_switch_port_set_fdb() to cover bond scenarios
Date: Tue, 12 May 2026 16:15:45 +0300
Message-Id: <20260512131554.952971-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0180.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::17) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: f36ba54a-2422-4827-0c11-08deb028a656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BpDjDPK5S9OsxLISe1XsD7q8LRcclMOUj6AgkGDGnyDsPGMgRi0afRwYcyDL0gdZx7r+MTA1ErmGnMwY2htBF6phC5qEbA78zPk0zlmRGSxC7OzzEJ+08raw8bOWbtbT82tMLUTB9MGwaPDhTxgTOlC250OWn23SIvyySbnDXbvmmaUX0ha9TbPN/msN/Enh2vFlu4KjOOMXEzdKt/epDO6swicMj4f8C+HT9KhrdPbjf8xdsAdCgTxGA9csvUVq6hrETqWHXROpH9Aa7LqWvxenalNKiGJhpYE9T5KFk33JMmbPsyD6z4dfC/67BZoi0n1ghi4dJcyRUoSYyjEZCQFGln7WhBBEV1AR6oQP2QOlppu0B37dvdy430JSNy3O61mLp4LeSfJ0B/md2ckfOsy3iAAW5PSnoThQ4pongME1OQ4YoAD3/nbW3sexB/8DULCBAblIHxUA/bEPGJQB1fT4UBVhFgt2NJJRTZ54DphDg1R6bcHA0F9Oengi4ZNr0x3UNulH3O1Fd2UZ8e+Rrvz6nB/JDqptiv7VPvnO4HOKY3lsRkrzJDGYL4V9FL6wwaf209Y7bQKLurOIHchJdN/uysY6Mu7kNcDRfnANQHZJn+x7OQ0eJhiKFhrOylSnjjjBRxr2/cWh+ez7iLE0gJV8uvUXUWkHIzm0uJkgE5z+o307DAT/TCr3gD6ACx1f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(56012099003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Y7r2VhbOXHDSTeZllsdm7Bh87HPoCE0LlEF1LhToPDdS1FsaZF/YLmlkD1y?=
 =?us-ascii?Q?zEJPULtKD1gajEtmcsKcjEqFZFx0rc88xJUHDZv4KoldhMGlc7ndQ6SH2ePP?=
 =?us-ascii?Q?FoKI/Re1z/YV5/AD5XujitZfyC+tEbpzxclycmbGs2doUccvI/5TpeqAEfo1?=
 =?us-ascii?Q?krHLdSzG2fUWvoN5DFGHjnliv+8ZzT2tgTCqshrrqlYcirPHJAVYUle4EyiO?=
 =?us-ascii?Q?mg+Zs/1ShqD+R+bGbnjsAW+qzH+Jgy6qdvYJqOMqOqResFGUapCekmMUjL14?=
 =?us-ascii?Q?AgNj9M421TKjNFXq1W6L3hVHsZt3AnRkMcsh2Xyf9I6EziaSK55Gbe9QehC2?=
 =?us-ascii?Q?5B3bbx/kcuNPIzkr10nlgSJwrWdWxNIYrIJKXAl63KHySmS+7hPdayBV8Rlh?=
 =?us-ascii?Q?44r5EUanGDHVLveOA4G2bqAnwaQg9WNyYOGyeRKii/W//I8Tcu17qQdprLIr?=
 =?us-ascii?Q?As6az8zNpprhM9Pkn99UDU1N2LnVjgvkwx0j9xOccp5P7eA3NiQ3Q9TjxY6c?=
 =?us-ascii?Q?Exd3fE58NWfmHhoJ+5hOWHecXxHMJha3vti7UJ93UkqRjt+qni6HOlIXfv/B?=
 =?us-ascii?Q?S9uyS5w89Ut4wSTnPIM+43KKt1piMmnv+s5o46/096kO4gNFv0c8hCKTtwiY?=
 =?us-ascii?Q?63ZJEXMQ6clkpczGO4SWci1XNIEoLFxai8BtzvLtIvA/n1w5DNOecYjt/kSq?=
 =?us-ascii?Q?YqyitGtJ8mbpaVpIiH2N6D9czmZaypEZZEVNaiAE+psPFvYbc02Vc9wV2H6a?=
 =?us-ascii?Q?EEMxFEIeLPI9ERI5CdimCigV+4whqbPm/8mCf6m6jRKHnjOWqrF+09D6g872?=
 =?us-ascii?Q?KTE7PqqRShZ2viUtrcibFvOJpJSAmj/RBqYFLyR3vHC9pp1pd4nWxzJ8hW7n?=
 =?us-ascii?Q?5hqFw3NYrqYKU/DFyo3ZJbrmeiKEYBRNs6QL1a7xPWrlwrj4Vam/Zgx/2iOX?=
 =?us-ascii?Q?vMJH5sKgJ2nnBlweBKVatLykU5e4zIa+8Z3vGezphsm7kiR/osrDEUckv+xp?=
 =?us-ascii?Q?kTZj7TSwKOEYUy3sAPq67S+AX8gVeuWwBYvx+Pqqq89SnmvVzRbStdJZDN7x?=
 =?us-ascii?Q?fUCag+5TNMkkcJW5AmaaWTU2UZlKrR7TOC1CLI0xyToVDojKH5nLzRJjmOJ9?=
 =?us-ascii?Q?yTcmQi08xKucSIzxHUrsJhiT9/RGynlSuJiDeCBU1/1H/X4ixJMwhy3QV6ps?=
 =?us-ascii?Q?QJpRskInVjgKQN4A1v5OMjxqBRAdADOoELQUjA8KoErqduXCXYV9RwAoRMQ7?=
 =?us-ascii?Q?T/HPpTPqvgX/PP890KKNFFuV7Bbiw4LjRGGhGle3l/stmBbqagnkcINMdplH?=
 =?us-ascii?Q?ujmI9l9xABjO+r9UA7+Ejfk98dFicB1KLC8OnF/5BODHiVkL17TAjinlk4Kj?=
 =?us-ascii?Q?vSIu9zoYRwU84SxaULjO3Umegb1swsl7iofI2don3QO976HgyR4Ing13MEJ2?=
 =?us-ascii?Q?8nnS43CzERNOJjgZtGH6VgSBP+7PaN/yB75lJVM9exiH4NlutxU574/owcK0?=
 =?us-ascii?Q?aRCWy5tVQUZoYz4o7d23t1N7zXQSG1JXK6MM5neUSAsYJxeq7YN076bBDZlY?=
 =?us-ascii?Q?27HL9kab/f481JFEzmI3HFq9DEADR0zX+esNkBg/2RNpFeYA2WyZcLPYCKfO?=
 =?us-ascii?Q?7uVVPSYTXL8BbyhJS3iRwjYHLRTbUkHZEztLmS22lbPK0/sGB4l6zIkrCSjq?=
 =?us-ascii?Q?Ba+e9eMkpXjC0JDSqihUSKKj0d7RDnaDLCtAvdHquz4oY8NCnpTazg4EieHE?=
 =?us-ascii?Q?FRqaaWv6Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36ba54a-2422-4827-0c11-08deb028a656
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:17.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8jJlAQw/sAhM/9kPU1nf/JcMSl7HEiCF1TtJZNyunN4/o9qux2PmmRljxjMYR31nU1qkKLGWFLN4PAdOhg+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657
X-Rspamd-Queue-Id: D561C5211D4
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
	TAGGED_FROM(0.00)[bounces-287155-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The dpaa2_switch_port_set_fdb() function is responsible with determining
what FDB should be used by a port as a consequence of changing its upper
device. This patch extends the function to also cover the circumstances
in which a DPAA2 switch port offloads a bond device.

This will allow us, for example, to setup the same FDB on all DPAA2
switch ports which are under the same bridge, even though not directly
but rather through an upper bond device which is bridged. How the
function does this is by first determining a DPAA2 port is already under
the same bridge and if so, choosing its FDB. To cover the entire
hierarchy in depth, we add an extra walk through all the lowers of a
bridged bond device.

When leaving an upper device, the DPAA2 switch port must find a new FDB
to use. If before it just searched for an unused FDB to go along with
its new standalone status, now it first checks if the port is still part
of a LAG and then uses the FDB of any port that already left the same
bridge.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 102 +++++++++++++-----
 1 file changed, 78 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 91be5a12a006..8af8b1f769d4 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -66,28 +66,59 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				      struct net_device *upper_dev,
 				      bool linking)
 {
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct ethsw_port_priv *other_port_priv = NULL;
-	struct dpaa2_switch_fdb *fdb;
-	struct net_device *other_dev;
-	struct list_head *iter;
+	struct net_device *other_dev, *other_dev2;
+	u16 fdb_id_old = port_priv->fdb->fdb_id;
+	struct dpaa2_switch_fdb *fdb = NULL;
+	struct list_head *iter, *iter2;
+	int i;
 
-	/* If we leave a bridge, find an unused FDB and use that. */
+	/* If we leave a an upper device, be it a bond or a bridge, find an
+	 * unused FDB and use that.
+	 */
 	if (!linking) {
-		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
-
-		/* If there is no unused FDB, we must be the last port that
-		 * leaves the last bridge, all the others are standalone. We
-		 * can just keep the FDB that we already have.
+		/* This port leaves a bridge, but it's still under a bond.
+		 * Search for the first port under the same bond which already
+		 * left the bridge.
 		 */
+		if (netif_is_bridge_master(upper_dev) && port_priv->lag) {
+			for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+				other_port_priv = ethsw->ports[i];
+				if (!other_port_priv)
+					continue;
+
+				if (other_port_priv == port_priv)
+					continue;
+
+				/* Found a port which is under the same bond
+				 * device but already left the bridge. Use
+				 * this port's FDB.
+				 */
+				if (other_port_priv->lag == port_priv->lag &&
+				    other_port_priv->fdb->fdb_id != fdb_id_old) {
+					fdb = other_port_priv->fdb;
+					break;
+				}
+			}
+		}
 
-		if (!fdb) {
-			port_priv->fdb->bridge_dev = NULL;
-			return;
+		/* Try to get hold of an unused FDB to use */
+		if (!fdb)
+			fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
+
+		if (fdb) {
+			port_priv->fdb = fdb;
+			port_priv->fdb->in_use = true;
 		}
 
-		port_priv->fdb = fdb;
-		port_priv->fdb->in_use = true;
-		port_priv->fdb->bridge_dev = NULL;
+		if (netif_is_bridge_master(upper_dev))
+			port_priv->fdb->bridge_dev = NULL;
+
+		/* In case all FDBs are already in use, we must be the last
+		 * port that becomes standalone. We can just keep the FDB that
+		 * we already have. Nothing more to do in this case.
+		 */
 		return;
 	}
 
@@ -97,18 +128,40 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	 */
 	ASSERT_RTNL();
 
-	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
-	 * to be present in that bridge
+	/* In case we are joining an upper device, be it a bridge device or a
+	 * bond device, we will use the FDB of the first DPAA2 switch interface
+	 * that is already present under the same upper device.  For this to
+	 * happen we have to extend our search so that we can find any DPAA2
+	 * interface that is a lower of a bond bridged port
 	 */
+	other_port_priv = NULL;
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-		if (!dpaa2_switch_port_dev_check(other_dev))
-			continue;
+		if (netif_is_lag_master(other_dev)) {
+			/* Search through all the lowers of the bridged lag */
+			netdev_for_each_lower_dev(other_dev, other_dev2, iter2) {
+				if (!dpaa2_switch_port_dev_check(other_dev2))
+					continue;
+				if (other_dev2 == port_priv->netdev)
+					continue;
+
+				/* Skip the port if it's the same upper */
+				other_port_priv = netdev_priv(other_dev2);
+				if (other_port_priv->lag == port_priv->lag) {
+					other_port_priv = NULL;
+					continue;
+				}
+				break;
+			}
 
-		if (other_dev == port_priv->netdev)
-			continue;
+			if (other_port_priv)
+				break;
+		} else if (dpaa2_switch_port_dev_check(other_dev)) {
+			if (other_dev == port_priv->netdev)
+				continue;
 
-		other_port_priv = netdev_priv(other_dev);
-		break;
+			other_port_priv = netdev_priv(other_dev);
+			break;
+		}
 	}
 
 	/* The current port is about to change its FDB to the one used by the
@@ -126,7 +179,8 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	}
 
 	/* Keep track of the new upper bridge device */
-	port_priv->fdb->bridge_dev = upper_dev;
+	if (netif_is_bridge_master(upper_dev))
+		port_priv->fdb->bridge_dev = upper_dev;
 }
 
 static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
-- 
2.25.1


