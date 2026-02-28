Return-Path: <netdev+bounces-262152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ87I00Co2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:57:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D95381C3BF8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D751A30FF491
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167344CF37;
	Sat, 28 Feb 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Q9vSWcg7"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021076.outbound.protection.outlook.com [52.101.125.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEE44BCB9;
	Sat, 28 Feb 2026 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290553; cv=fail; b=li/fbsktVRzvlIPTnB6uJVeQEd0ncMEVrfAjQfORgYxZHSMP6NdrBHfI9O9jXV3zUyugeuF63j7D89LOiwVhYcDiEW4HZxUYKU0HQ+P8ncb89LfD+3Ou9vu68xVuo5kJxtqH8NNM/cvsEqJ9YkLLd1tPkyP5YXEKbbRCSfdGUP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290553; c=relaxed/simple;
	bh=zQLa9bOnoHCwDeWYTV/rY8bZ5b5dl5x4sZDEVROpOa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njFuL304fakutloqBzbytKfy/kFr8zwRxi7Qe+9C6SoW9USwH/LvybrASf18qTonuU8RfVdPhMkRYVrEtY7KxQXK91XVhguwOJjjhe5ZXqbNBfGLfpyRoRLJoiIm/a879bozOEzHUoaIi+/VCvMiZdsm3XwnkDyWEk2Hv/8lygk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Q9vSWcg7; arc=fail smtp.client-ip=52.101.125.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2D5dgi66JtKLm+Vi+COhxQnSnGzskz2WAiLzAlviw66xplj6vj0OciDj/cAoqnqDnBZgpeQGUnjRkW7LuJRAveUfmFidBUfruW/mIZ6sIvmROXOfw0mTPOmUBZur+KaX3kIZBsj3e05HGr+e3mIsrjlEtvVOQ3EhhMNA0Ad0OSh/D2QIuSIk7FejpYwXUiT0QrpCGTT5Ix3rj5w4xaN+a6heKOzpmUiCujsUSE9TTDdre46h9G32+TogKHJB+qW8YjZtO++xlAUfqGNExSNQ482Ce+6fDhtmznjdVMhpcA/PNpVPDYmX3LSmsEPfujm9g0h0/DIc+po2yPJzytvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY5C4X9dZy+w/CE2+h/nTfa6h78czuprcim2Y5EaD/o=;
 b=GuYmAAgptXsxDKN1tIJzYcoQi+iJlgqJz4l1Q9KlkNSbZjjRoi13fyycn2cUkl9yaWVVigV/siIORhaZOGLkP8CCududBlXE+4+yGRqhllkjYHBDc8k2SeMyt5/+EGoDRtgFldwE6wq/wmhwDoR6ZoMQ9LBybL1tIq9ZVBamN0rHDiPGj9lGNMEWMkzjr193NZOxB5ZchLoqWg+n/oH+SZxixQPwXiqgrUCMCaJd72uhGFFplbR222O9sxX7q9vo0rwtS47nZg5FFjUNae4r2k0Ta5LWYOOIfISDQNWlpoCWb15BGc3gP6K3Hvc6UBDUodyQY1eXiYSm2Yan0qBf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY5C4X9dZy+w/CE2+h/nTfa6h78czuprcim2Y5EaD/o=;
 b=Q9vSWcg7BMbtFSQNjMV6RuKUIa2mIu67VmxJkjaZzyGdwCZnedKXoQRh8v3FOxHF3wSOFtx8MCrcPdZbNKDV4deSpNt6lSU4t5g7Q+GrNGV9PmI2BrQtlLNzS/FzYG7vGDWDGisG9AH8SqV2oU+52I/+BmLSETiPE+UQSvItHSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5596.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 14:55:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Sat, 28 Feb 2026
 14:55:48 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] net: ntb_netdev: Support ethtool channels for multi-queue
Date: Sat, 28 Feb 2026 23:55:38 +0900
Message-ID: <20260228145538.3955864-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228145538.3955864-1-den@valinux.co.jp>
References: <20260228145538.3955864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0151.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba7fdab-f3ae-44df-f484-08de76d975b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	Fn5ddDTnRqkidJlkl3BKaPH5741wj+rPo6NBcxFVy3gOmP9XdT6zhZJZpLDmrkRLXBt3INwIzx9UrVv7PObPW72cnFF+DDNb4gdE01GTf/dINtLutxMpZkysBAXqQI/G5W3dquHuoelI16K/ClJU+rUL66aSoRGNsK04tzULT7tJnCxToKZrtKO6HSqaf/byXi0gdQxS+YXTgJaBXi2kC4yH8zRUkhvXSZbP7jVHylQdGOnIW1X4PdOCQEwywbm7YplHnTuc9Xh03Nv/OFI7OBC9d5eIiz7iV/17H+NsOkYk/ola6/Nb444LgKaCLY7N26J0mNMdaMrjX81toTBxaxJJ8Dar0tmgxgwmzPJ79dBl3wAu2wofkpJu8HDSjldMIWvQA2PUiN2oFrg4h2vL18BX6dPhNRQwfkihHqaOYDSOGSm9FMavlH7Aslw+IyLR4Yt4dfy9xQX3epL0nfPxlADAFSAyWHifSvRVum6lzQMoj7O1VP/JwGE1QIaVZf1Gy2AQune0r83h1grdADypX94oVpeEe9GGpPbTyO40hUdD9MGkY8HDOosZNwrKFRxXnzhklbXn7ECmiWdOw3ZU6wbVLh3O6kg7FwHNbFA/ucN0IkerK9EZnA1ecER5y9q8VTp4fic+WpzgGo297QDOMF17ib1O5o/vJtqaHYgFJfxnkykgbJPjD4FHenZYKv2Iu4uxRZ03RECLZg7nad12rCJVo1ln3aMp2A6VmdjALA8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gIl7jiL02EybEEkwR9Ew5ZGlM1ERFJsohz/cI5c/Dd+SjPAlAUxy5NVO9BJC?=
 =?us-ascii?Q?3ku1mjXLHZMmEVM3DMMRGq2NCCNul9PQ78nzPNMohfJGwSTlq/qRaq3W9J2s?=
 =?us-ascii?Q?nUtcSZmxPfJmtBySd0D95XYenmu7azsjqF/BVUse/bZsJ93EjM9swH3U9ixC?=
 =?us-ascii?Q?cTSFRXOKnZf2bZHYtkqWQp3GEBcHRrsHgR5X+tDymE2C5P2bK93zjIOryDBF?=
 =?us-ascii?Q?sgn6AL0KZZX2xYwUhKvtPW+qARG8StdnYFO1xbWTTpxNwMbQJ9viT65qu4l2?=
 =?us-ascii?Q?UcmXgnUgx9z/g9l8rLXbOspfz/31vauHdY49BPIakZwM+GSAECpYBhVEZydv?=
 =?us-ascii?Q?o0UpF9uqtVxq5HOPeMoQyGGl6IFS/B7m8DOMk53KLwRDSSTRonoAy707z296?=
 =?us-ascii?Q?W4p4zoLrl+oXCij8rlhcjIlexPiRh85JciqPMet7gH9k1DtSA+eDDicRcKP7?=
 =?us-ascii?Q?D1QpVw3Rg0z2+HxXdYxK5f1aiw2KllrKuC03U30B/i5uZz+pOeAYxi6VPcop?=
 =?us-ascii?Q?tBGOI6h8DYGbgjHZT382BZ69Jvek6xegi8dFi9Sc0RS/sPHaSZDpD0+7+7Fi?=
 =?us-ascii?Q?8OEjN9YD2hSayYtnnscnFXr9i0Fx3z661dB0lsWQsxGfXx+ExKUOEkhsp93a?=
 =?us-ascii?Q?OKlEt/EsqmsTdkIWO1K6o5CwhUv67/J4BvKibInNHX5AHPn4osmRhFvqZfje?=
 =?us-ascii?Q?bxbAamtnXAMRQejyPbaS+SdrzBB5IV3q1cBIIiJI+hL3hjFua3TiUkRmXeYe?=
 =?us-ascii?Q?HqrOuaprZ1xBs9ASFlkVPSnTlV2ro3Nzui8hPp2IYzYcZEv2iNhfsiFyPw6e?=
 =?us-ascii?Q?ZdaYjjHhiwzJefUQsaELa0M/NgfVUwKMUSkTmSIUllwzWT+r141bf4SECGz2?=
 =?us-ascii?Q?QHtcTOqrTSyi+CH386dFmTXQ1pxRPoKv9V+yeTlprZ3R8PwDb4L+FVT5JaDG?=
 =?us-ascii?Q?DzJkCMwlgWkvWt7ou5+3qATL5yq3PM1po1VQPnJf23BH+EmXeEG8f9EduMst?=
 =?us-ascii?Q?v1EnvPENs1w1zWTSk87wvVjxxRDXnwqssQpubw1QqyTMVxwxsv9TBSXCKWjx?=
 =?us-ascii?Q?dCdrKgSy8mV+jcUJyQMwSHBIriPIdfDTVE4WD38iDh4Eg4lVfXAlXrf/LmHI?=
 =?us-ascii?Q?FrYtJ7srDzQlT8rx/niWRl9ARSI/uOmpDRt5HnT/ZFbvBkQL/Z92/VzTvREb?=
 =?us-ascii?Q?qPmMzIZaTcFoM9oG8N5WKg/ip4vD1V9s+xv6SXApt9FINoZBNdT2QqU73bIA?=
 =?us-ascii?Q?J4hRlW9/NYgOMaIFjJBpd0RupypyC2HGUuJhtMRE2BgNqoJ0I7bgUaV9Nhxx?=
 =?us-ascii?Q?EE+4H61S3uC9vslzlBYvDgo5rBR2oGt/xzueq4zWtVBklIeg1gy8lqtaTWJk?=
 =?us-ascii?Q?LDjlBtsQCBtpJ3PWKsK0pRQ4L1HQonGCVx3Tlc312eW13vWVmpnSzeaBwe7U?=
 =?us-ascii?Q?QTj5PoQXybIPFJaII72StPo9gAeF8qTzfAEcg98r0tSSztCUSAd5rVHO1E/G?=
 =?us-ascii?Q?8geGxcTwH+xlPBFZVptOFPxP+duHqbmPQqKg7eBb2ZNSO1Ks48FfBHZD2fpC?=
 =?us-ascii?Q?cMJcY+VWAFEwBBpqo5UsyzYyZ4BLPRkwYB11OketDkAzrKkx8AXg8iuQP+4w?=
 =?us-ascii?Q?+afUX8Lrz2pr77ukfQaqNLLkDTdFdYKf/H5tH1pR/fzJxaDim4UrQgZR7Iy1?=
 =?us-ascii?Q?P7saJbmTFEO4l/6Y8jD36ai6xy2xmKqiJABlgfwGemje9vB2UmAsA/5cQCAw?=
 =?us-ascii?Q?RHZ/fuuora0iwsFQ3YOjDjqWugKRkpIPeFU/jIIToVAXYhK39UOS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba7fdab-f3ae-44df-f484-08de76d975b6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 14:55:48.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jm7XzqMZ71duny4CrU4gArxohhYKwo7noEGwsc3yHxPyvSHIwEWsbk0QGEbNOWhLCqoi503+MSeMMGzyyTFFBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5596
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-262152-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D95381C3BF8
X-Rspamd-Action: no action

Support dynamic queue pair addition/removal via ethtool channels.
Use the combined channel count to control the number of netdev TX/RX
queues, each corresponding to a ntb_transport queue pair.

When the number of queues is reduced, tear down and free the removed
ntb_transport queue pairs (not just deactivate them) so other
ntb_transport clients can reuse the freed resources.

When the number of queues is increased, create additional queue pairs up
to NTB_NETDEV_MAX_QUEUES (=64). The effective limit is determined by the
underlying ntb_transport implementation and NTB hardware resources (the
number of MWs), so set_channels may return -ENOSPC if no more QPs can be
allocated.

Keep the default at one queue pair to preserve the previous behavior.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 147 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 6aa59316569c..c2b1886775bf 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -113,6 +113,24 @@ static void ntb_netdev_update_carrier(struct ntb_netdev *dev)
 		netif_carrier_off(ndev);
 }
 
+static void ntb_netdev_sync_subqueues(struct ntb_netdev *dev)
+{
+	struct net_device *ndev = dev->ndev;
+	unsigned int q;
+
+	if (!netif_running(ndev))
+		return;
+
+	for (q = 0; q < dev->num_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		if (ntb_transport_link_query(queue->qp))
+			netif_wake_subqueue(ndev, queue->qid);
+		else
+			netif_stop_subqueue(ndev, queue->qid);
+	}
+}
+
 static void ntb_netdev_queue_rx_drain(struct ntb_netdev_queue *queue)
 {
 	struct sk_buff *skb;
@@ -464,6 +482,8 @@ static const struct net_device_ops ntb_netdev_ops = {
 	.ndo_set_mac_address = eth_mac_addr,
 };
 
+static const struct ntb_queue_handlers ntb_netdev_handlers;
+
 static void ntb_get_drvinfo(struct net_device *ndev,
 			    struct ethtool_drvinfo *info)
 {
@@ -491,10 +511,137 @@ static int ntb_get_link_ksettings(struct net_device *dev,
 	return 0;
 }
 
+static void ntb_get_channels(struct net_device *ndev,
+			     struct ethtool_channels *channels)
+{
+	struct ntb_netdev *dev = netdev_priv(ndev);
+
+	channels->combined_count = dev->num_queues;
+	channels->max_combined = ndev->num_tx_queues;
+}
+
+static int ntb_set_channels(struct net_device *ndev,
+			    struct ethtool_channels *channels)
+{
+	struct ntb_netdev *dev = netdev_priv(ndev);
+	unsigned int new = channels->combined_count;
+	unsigned int old = dev->num_queues;
+	bool running = netif_running(ndev);
+	struct ntb_netdev_queue *queue;
+	unsigned int q, created;
+	int rc = 0;
+
+	if (channels->rx_count || channels->tx_count || channels->other_count)
+		return -EINVAL;
+
+	if (!new || new > ndev->num_tx_queues)
+		return -ERANGE;
+
+	if (new == old)
+		return 0;
+
+	if (new < old) {
+		if (running)
+			for (q = new; q < old; q++)
+				netif_stop_subqueue(ndev, q);
+
+		rc = netif_set_real_num_queues(ndev, new, new);
+		if (rc)
+			goto out_restore;
+
+		/* Publish new queue count before invalidating QP pointers */
+		dev->num_queues = new;
+
+		for (q = new; q < old; q++) {
+			queue = &dev->queues[q];
+
+			if (running) {
+				ntb_transport_link_down(queue->qp);
+				ntb_netdev_queue_rx_drain(queue);
+				timer_delete_sync(&queue->tx_timer);
+			}
+
+			ntb_transport_free_queue(queue->qp);
+			queue->qp = NULL;
+		}
+
+		goto out_restore;
+	}
+
+	created = old;
+	for (q = old; q < new; q++) {
+		queue = &dev->queues[q];
+
+		queue->ntdev = dev;
+		queue->qid = q;
+		queue->qp = ntb_transport_create_queue(queue, dev->client_dev,
+						       &ntb_netdev_handlers);
+		if (!queue->qp) {
+			rc = -ENOSPC;
+			goto err_new;
+		}
+		created++;
+
+		if (!running)
+			continue;
+
+		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
+
+		rc = ntb_netdev_queue_rx_fill(ndev, queue);
+		if (rc)
+			goto err_new;
+
+		/*
+		 * Carrier may already be on due to other QPs. Keep the new
+		 * subqueue stopped until we get a Link Up event for this QP.
+		 */
+		netif_stop_subqueue(ndev, q);
+	}
+
+	rc = netif_set_real_num_queues(ndev, new, new);
+	if (rc)
+		goto err_new;
+
+	dev->num_queues = new;
+
+	if (running)
+		for (q = old; q < new; q++)
+			ntb_transport_link_up(dev->queues[q].qp);
+
+	return 0;
+
+err_new:
+	if (running) {
+		unsigned int rollback = created;
+
+		while (rollback-- > old) {
+			queue = &dev->queues[rollback];
+			ntb_transport_link_down(queue->qp);
+			ntb_netdev_queue_rx_drain(queue);
+			timer_delete_sync(&queue->tx_timer);
+		}
+	}
+
+	while (created-- > old) {
+		queue = &dev->queues[created];
+		ntb_transport_free_queue(queue->qp);
+		queue->qp = NULL;
+	}
+
+out_restore:
+	if (running) {
+		ntb_netdev_sync_subqueues(dev);
+		ntb_netdev_update_carrier(dev);
+	}
+	return rc;
+}
+
 static const struct ethtool_ops ntb_ethtool_ops = {
 	.get_drvinfo = ntb_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_link_ksettings = ntb_get_link_ksettings,
+	.get_channels = ntb_get_channels,
+	.set_channels = ntb_set_channels,
 };
 
 static const struct ntb_queue_handlers ntb_netdev_handlers = {
-- 
2.51.0


