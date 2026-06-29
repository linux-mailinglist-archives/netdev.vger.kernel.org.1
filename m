Return-Path: <netdev+bounces-302575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VkM7KxJXQmo45AkAu9opvQ
	(envelope-from <netdev+bounces-302575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:29:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1796D9691
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:29:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=LIJTJBkD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302575-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302575-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55E55302AC06
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5943BB673;
	Mon, 29 Jun 2026 11:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812A3BAD92;
	Mon, 29 Jun 2026 11:23:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732210; cv=fail; b=RN2/R1sY8sl1uLpxuDpN+y1WnxvE/FJ8mnEiqsgdXCDslzuPd1WCs2421S4l038zvv9LJPKDOo7b4Xg0ZLvq/MnUTcerUrRO7Bx8ADU2aTISIkWo/emMG5akc7Uwae3TQNGroj0OItgj3XOX4D41/rGYXURsAXFaLXolJGlj4lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732210; c=relaxed/simple;
	bh=Z88bmDPv2T9moben0hdtNCJz3A/ld+N5rhLMVkuDzGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FPLG2vdGxAlgoajStG84vRA+hvXjIvbsWVp5LkTQDGfAjRP5O2cYBtk6lmFveV8QReXuKryr+j7kPHJ0sHsdOdfwDjvAupnEeQg2Sr6b9GXeEVcnTXjKmnFAxCTcs+Fb0tb6TMHJ9aRu/LwawGs+Tx+G5mlMfKbmhGUf4xHq/E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LIJTJBkD; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYNPIdnv6JzbbJ63evSeKfzCWZCa/ioh6P+L0JlCfWYCnP7toylQBMLlAone9ivsU52oz3egobW9oS5831LXS8DLo4BUm85rlNqLRJ337fYDy+/nrxhmZ/OFncOESVA+HFso0c83s9WSbX1gQ1rEDEXFaafBCHw6jfwYKfsYfNTrXNGblMc1v0TYBAQ72FTZ8q7I2S8vEULOnPAV9K5Rfyf2LdvwxElz7/5JJbCFuhqU5GtnuZeVBe8Fr+AaJDswy5pIrp5uRWRZGCr4MiLV49QTu+wZWEf6swyLLmxb5n/5JZt3cG1h37G+q0HU+6kUq/glUTQG2Km3yScMvQg1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUnFQ0u2I8+7hYr/8SkupQfFq3k+w3PV6bRB9rw6juM=;
 b=zSA9I5HjT6i6r+/FxJAS0MMSl/Ad+eLn9KWU+LSLZR/nLWxqZ+W1BLiduCCnWcglgxSKw9aMHGHixvZK3evfbSiZefNyGFu87O72TNQWAXsE3ToauGRr2Fi3+47IeBmAV4ESoPY2/3EIPYNiHsMknymX8FaRf5F/3FRB52sM40V3iy155j4Jx3phj23gXd0IWkjKm/IOKBCwBXIHI7zIZNSdn/GRhXIh2sv9klBrmKELl6j54aczwxjGUDzzghD+GJZIFtSslu4pDjfD2qHdaIgbEeZcdKuWH/phGjwHgnyYFghUssF+VVkErWLCERKYJQ1CuDXB19Ukphuankg6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUnFQ0u2I8+7hYr/8SkupQfFq3k+w3PV6bRB9rw6juM=;
 b=LIJTJBkDzMP+wEKqPamukgmiuCBf+ayOq8pwnSkHhEwSR0zRBRQI+0yt3YvzDso2Jl1mpnw4gj8gM1Aq3YnrYZO1nSPX/J9BW8INosD6uiAklNW/nkjHxkCm33WJVV0vEs2zt6QQosiE9djYjNathE7rc3Ilt4ORoRdEvRhJbSevTihWMNSK5MzNiYb1Xn0R895a2xr2YgYaWRFcnSg5ZHfUDWeDnGHsIvi5lJHcGtzcDSfptVVDximF6gmKzPgn2gy7RkAi2AUSoEo2hu+i+YmYtjIqtQLskQviCMRn8nNzgbkyf3wmhpkBOiXLdNpiL8fytDyF341eX+bwYI5XLQ==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:26 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:26 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 02/13] dpaa2-switch: avoid holding rtnl_lock in dpaa2_switch_event_work()
Date: Mon, 29 Jun 2026 14:22:58 +0300
Message-Id: <20260629112309.154328-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::20) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|AS8PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: b5817d77-2b50-4050-d05c-08ded5d0d6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	LlSPjxidy9F29zP+cf7rDXmgoIr9GFVMBcDHQRCqQ72WgYZvzAw12R1ykydtwbQ4WjG12K7NbBpJptXYR1YhRyhVB48tr+xTZOH9vvM5SNM2qY7gtRlR3ZI3nSyrFCOYk+vMJeGBmjtmD5sWV40aPaeSLNYdrqo+Cmkb/tKLYQZJ8jBEWzjOfAp6pFQFGS07hPEFvvEpq42y0gEZ4TzB1SXnQlvN1qsXNCcVNyt8gOwI7pGAv8JwBjIMN1DWKswNTZ0vB3il7l3tJnOSjq2gjRh+lJjmcMHWITwr6D/4NNPdDxwjzy67ftGJgspzF2iEEWKYm+OP0Hj3hKqQRyasjeoLFjt0S2gGlyzrZPqPKoCzAeBM91ZG2fTowFIVc9h67pznZagXSIQgr36R1CcXQxEoSaYFE21eqzrrCvqARgsR2eUE3gmPlXpR7/6QnuUua/bInk0Ii9K5LOcJapEo8vJrfOAfT1+ixqUYRxZTa+N6xp4i+LCF74+97XkmWPOTLdjiFhdQ04l8F6ZA8ZtZ3ziScpH8yV7n9lXJiQGbYxFrkx/yjYT7M61MQTARap/jDVtl/PExAmaTKptw4Bew50LlHzG7GpTd0266ZBMGh60CmWa6iGZOY5+XKyiSAolpgOInWnFPet+Srig41P/vacNyE/N0LZeaoX6uVI/dfRY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g3bWwrtyHGsaWzWuZPlK9HGwIGth3u+M2s4pGgKoxoFaoaU7LbaaB/nWFTYa?=
 =?us-ascii?Q?coJVXupGv7vzMA3d38RuFpYFzWORSCq6oFNSlGXh0zqT1CvKBD7ZutR47cg9?=
 =?us-ascii?Q?gaPLGrFg4RAFsiMmwOOKcnZ7DCh3VrvGP5Eql4TtRo8UMc8hucLDU9q0SdPv?=
 =?us-ascii?Q?aDsSfaEsZvOyAe/GzceYbrrP3tJwqpvFg2jbZmd55B4ADcvggFm8AlD2CyTb?=
 =?us-ascii?Q?nNwI9hZQfMvJP9sQe6enIuzX6tYNU74FcrH+AAImO2JvzY1yGX4YjVPi1JDu?=
 =?us-ascii?Q?K3uiDtMUn9B48p1n0nIccqWT9+8vbfyzlXC17pDibNTAWNpVnNarB8I+6EPl?=
 =?us-ascii?Q?ynlEWk/WIPoiTN8+lCdi9ZTXsxfRAkAMObNJF961FHb2r7hFSgsSxkkYhP1X?=
 =?us-ascii?Q?zCOL8pKlanNzxibCnomAbG2k4EUYJLqQufrToMtSclU66GulanmBSfTHi5a+?=
 =?us-ascii?Q?WXK6sHT9oGThSZeqJ0/QDKjGp8Oj0MCVRN6BhwzIxO/I477LD4QbQZx1jLu2?=
 =?us-ascii?Q?aclkzuxGkUtrxdv5flgAWJT8Eox+SgV0JFFSVgfTDZEDpj9aRCylU9zzfuRV?=
 =?us-ascii?Q?OlXjyxZXAWLXEqyjTagz8byoiy0lqVEITMMjHLFKFx53Nx2iA1Ot/EAT2VeI?=
 =?us-ascii?Q?/jLNrCiJW550VCW57oNXEMBY1eMFbxoIyzyGJG0PgMuXV/held5fv9aU1R16?=
 =?us-ascii?Q?jEEnCcjCQ1ez9+yC5/lRuXOxtJtbHDDQsdHcUTgabbgTsUgcIGDfxod0Rc34?=
 =?us-ascii?Q?VDS2x67tPV7PAr7TSgoLiwc6IJgvbx9Wls11iKtvNOZrmQwg9YlykGif0vpd?=
 =?us-ascii?Q?Dcz8evXyT/pr35IkBtpcEwdCSmh+HUPVDCfyHeBhS243fGdypTa/Xjzlkx3A?=
 =?us-ascii?Q?i7dvvopZaruVUHUC5v1GSEbrQp0kduiWAxKkG6YfDZHQR+kpFXO5s3s7RLcp?=
 =?us-ascii?Q?t+kC/6pSrKUKTD79SPcSLrdbtAdz59WmmJ+7aq9F7j/zNSvmxG6yeG6oM6P8?=
 =?us-ascii?Q?ndGj3XlMFRBGPY3fG4ice10BIAtNwZp3szIky6WT5DAf9oznMJVlmWZIhZ2Q?=
 =?us-ascii?Q?wg0gEWHCMxWJY9aUGMpRPKfhIlcA1CMwHJKIotCVMxWOLikkdjkEWi2+xHRg?=
 =?us-ascii?Q?Qc4I3wadrekQ8kbD2Qv9ybuuilXEStQda2bEjFuikcnSCWWOpBj+neKF3OG0?=
 =?us-ascii?Q?IKPe/08kGxlRRU/cHEWXt78k1LAUo73DmuqIrEZvVQhZ7x3nDxKCsYtmmliK?=
 =?us-ascii?Q?ZyAq5yDnwoecQsLgEERdmyRxi3npe/CjQtkHueaSzIDiA3U75I85aMRqyWlh?=
 =?us-ascii?Q?MYt4ywG/CwHQxZb7QOJa16mNdej6n/PdNT2J5w4pCyO7lHGMmDrbAU6/4lim?=
 =?us-ascii?Q?0SJdSXKmpSd/jYXA8YA8sXbUAJGcvgjQbaP4un3Tuf+4K8qwk3LcXztjj8hZ?=
 =?us-ascii?Q?DmQVP3cynrAIPOgJGabXWjLNkoN+oXFZ7hjX0VSEvfH+HN3mbQgidlMIO0ub?=
 =?us-ascii?Q?rGRj9tHSDHxY44r4vuX++1ZTZs5bSPxz7nqGnO6UxJCASMM98g5sLaILm9xe?=
 =?us-ascii?Q?Rg3dD3Af6ai0ZKusXPE9bkjCKeOiFOKM5+rg64K5crwTwlZ/KWhDDifxk2cA?=
 =?us-ascii?Q?IkDhvCrGqDLLq4VYgDpP36zRAzvyd2xqHCaaTEfAjAfDjRDMNI0Xfod7QNnS?=
 =?us-ascii?Q?45oD5yQoZl2i5AQn9wY2WO1X4sWV2hMDOmQT7WTEAKPDqN9n0TF/VtjpAD9P?=
 =?us-ascii?Q?KjQ8uZM+Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5817d77-2b50-4050-d05c-08ded5d0d6b3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:26.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRHKwiszhcZJ5TNJ5iEza6Gb20kFtRcAfgh/49L2iDcCH9M6KF9GYBP90XEwS2itR00WXT48a6L++OCjmtZffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563
X-Rspamd-Action: no action
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302575-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E1796D9691

The only reason why the rtnl_lock is held in the
dpaa2_switch_event_work() is so that there is no concurency between the
changeupper notifier which manages the per port FDB assignment and the
workqueue which adds / deletes addresses into that forwarding database.

To avoid this kind of concurency without a rtnl_lock, flush the event
workqueue as the last step from the pre_bridge_leave so that any
in-flight operations targeting the current FDB are finalized before the
bridge layout (and the per port FDB assignment) changes.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- New patch.
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index d70e6f06ac15..67c639fad0db 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2069,7 +2069,15 @@ static int dpaa2_switch_port_restore_rxvlan(struct net_device *vdev, int vid, vo
 
 static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+
 	switchdev_bridge_port_unoffload(netdev, NULL, NULL, NULL);
+
+	/* Make sure that any FDB add/del operations are completed before the
+	 * bridge layout changes
+	 */
+	flush_workqueue(ethsw->workqueue);
 }
 
 static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
@@ -2281,7 +2289,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 	struct switchdev_notifier_fdb_info *fdb_info;
 	int err;
 
-	rtnl_lock();
 	fdb_info = &switchdev_work->fdb_info;
 
 	switch (switchdev_work->event) {
@@ -2310,7 +2317,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 		break;
 	}
 
-	rtnl_unlock();
 	kfree(switchdev_work->fdb_info.addr);
 	kfree(switchdev_work);
 	dev_put(dev);
-- 
2.25.1


