Return-Path: <netdev+bounces-252004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C+ZCG8TcWkwdQAAu9opvQ
	(envelope-from <netdev+bounces-252004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:57:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF37D5AD8E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28FB6AEE4C3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A38495523;
	Wed, 21 Jan 2026 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="doJcHB34"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0049550B
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013901; cv=fail; b=R21GW5vBCNEMGXbjUjUdKjImRpYmW6vYrDuyE1/P6dPMXmzPm3EVIaEeiVfrzP52XwkLCuHZmlKqGgAYchhtEEeTvKZkZPs6V/7EYqJix50wvS7GcmbsnuYfot4dBONmKrllmef30KSTKEbz8iXvSjj/kpeJak2aOggl8hJASj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013901; c=relaxed/simple;
	bh=7Cl4R0QS4XIxiTB2Ogtl1F10iUHU8rPN5zgRHAMA8/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUMjW6xG7xZKaRlNaBvUBr+k//QL2JJJA2ubDD+Os+dWr02xEedBd0C85yYbc3tT3cx2r9Qo7jz+q1U7Zvywo6WJVzXVYzbfDU+mWWWEcKA1MfNMoUPnHo1XGq5R7N9xNQpc5bdW45YRzmNnmXjHySMsaNogWgJVfzXrqLUFkk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=doJcHB34; arc=fail smtp.client-ip=52.101.52.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyjZ+gYI7YOqUFMeWV2p4eT/NxOlMAZhvbSqvWJsMy90Y9h71Ap8l/WZF5gpkXgVMze6zRm2Trexqeg9awuC0mATMdcGowuF05CpBGRluwX9cS9Jr7utJZ89vW+kRn48YyzhfVELjcMdLtLQHwQfW9bkrxbJan3Z/TSa648EqRUzIRsRqCb5zags6RQkP5VLhapjbT197FoPZn6hvlrVpeNLHaoNyh9z10TY3Vxn5sUx1aj7bsrF4jedzsQHKFPhW5GRRGdsr9g1nWLYSAOqbi9YtH0jDQUi33+McX+TKcND7RnuEXRNdwGmhPVT90Mce/HwrmrQFniP3Gqq2bLqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1S16gCn+7ht46nrSEcMoHzlBptcCD2OmCRou/ZH4mg=;
 b=Vex5ojmxoABPd1n0B17LrpI22+yx4YCMiS/tXktTVCNnZMhCGn/WAwqZgPw+OCXd/OaoYRNJkzR7LW8P9joty6N9FtrRwviHB+2oHBvvlAPwnEN+AvuCSc60TtkY6WJ5p2U+ER6OJKkfmnBkw1urLl8GtWwyXPPJx/jJFq3ThQ81SHNe8tTgjv1X8Ml5l6eYSBlR+iQYYv0qbBQdvJIUaklPB2jFoBGjyVlqw0bLztXsGmAI2qr8kYhByAYiUu2swp9l3MdK+tpJV0O2ENEg8sIRAzDIGC0yQDlC8Xr+KwWDgaWmViEs1ir4RDCECc6BO44DqQRbuDxmlybpky0ysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1S16gCn+7ht46nrSEcMoHzlBptcCD2OmCRou/ZH4mg=;
 b=doJcHB349BEQuTUHqeZ66X++eJrAa5eZg80X7rIOvyoKtvvRmtCIjXAd6lZacAiy0rSwLuAab+FR6bqDAfBs9G09mg1piic2NSflKsK6YV7qVI5+xlUMKi3wf+SQtoTqY1VlzymMe4jj2ZY197bwLn/cviygEE5qJJ7ZF/lh9+2nw/NaXWfx+hMJ0DgFyRj7dSDho+JmMznetCyX+HOLbejvC4ELQSKjRI7t205KEmJumP59zscEBHZeOkMPwWnotbxXGsjlr2jmtIjPzeSHjdNmpNMPleBHy3qFrkj6Rpjs24Nx9lVKdpzTUGOj+XU1/IpS8Zobk6MWmnvSh2eerw==
Received: from SA0PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:d3::6)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Wed, 21 Jan 2026 16:44:50 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::12) by SA0PR11CA0001.outlook.office365.com
 (2603:10b6:806:d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 16:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:44:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 08:44:31 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 08:44:26 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 5/8] net: core: neighbour: Inline neigh_update_notify() calls
Date: Wed, 21 Jan 2026 17:43:39 +0100
Message-ID: <e65dce5882bc6f4aa2530b8a4877d0e003071a1a.1769012464.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769012464.git.petrm@nvidia.com>
References: <cover.1769012464.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: fdba4925-4d0e-47dc-301d-08de590c64e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LIJny1Zd+nuj2hP9CsCXNIJiOoXyGXABIIHePlNJwigaggekmoVTqRxC062Y?=
 =?us-ascii?Q?6SC2KU0nbHn26D0rNSARsnX4ETJeczZgiS9UOuWNGa0iwV9vQQtSOfpNM5Ro?=
 =?us-ascii?Q?fZ3++GS7/ruWd5RxtMGVaAWQYsACj22Nk/pATnYbGk3uvRvyfT1oOfqUtDPR?=
 =?us-ascii?Q?NgcMWn7GmP9eAN572/RJX+AqmezxL2Kxi5vvP7E60P0TQ4s09YvOpDtomq6p?=
 =?us-ascii?Q?0xZ7Fj/jT5VA1+xid2UDzH+I6nEVGVtc6aH3Nh0jEGoh3ye4NyiMLiwbhP8n?=
 =?us-ascii?Q?KHIH4T/vkG03H5XfrESe4gANd6H1kOHuIBXkdVhlC5bZuOoWoSgXgfEDUPlT?=
 =?us-ascii?Q?35D0L7u1ydrkZlCDm21ms9XsW0LXB4gTBU42zjBMtzJKVG3edD6MyOHEybXF?=
 =?us-ascii?Q?QcnZatT+D27SqlaQ3siz2SSARsMmGUsHjg0+aS7yH2W4j3oS43p4Z2INDIOS?=
 =?us-ascii?Q?VYjl5AYgbUybe7DFCq3FjwAZDg7ZfCaP74UfKlL/3yxN3wWiJfh5urHheJcu?=
 =?us-ascii?Q?nzqwobhPfLz6G1AZKGNgBd800UvZusirjv6YBAfgf7Jf3QYDW9IlWZdW1s+7?=
 =?us-ascii?Q?mI5k5VpAiGBRLytb2/WzUFQeq5l/zEldmk3CUoYgwjM0d2PhIlCvAY2J1JzR?=
 =?us-ascii?Q?Tr30MDnuLIyeaKHbyqKGV0CGqwkWva/UA46QrGTEEOQNMoK4kX4M0DzI5CO2?=
 =?us-ascii?Q?NOcpU2Eb8mHCozaG3Ug0tDvo8sbV8OxV7rbFYD+UykuCj2eOuaL6kae67YWL?=
 =?us-ascii?Q?hZn+LzedgYYdKyy82XELdBynlXLvRXKiEaNYfrhxTu58NQFnF+YQdlLfUBo9?=
 =?us-ascii?Q?1fOC+soG92mJnOi7qqC+FBvhX11xiMPNmLYtSSmMHeggn94hNDhunWPAiTwz?=
 =?us-ascii?Q?4sBJCBFONzTqDwuK5YgExuDUxqpoy0hUZLWjfyZW8SKZwUX2sIc2nWx7nZR3?=
 =?us-ascii?Q?F192eJ+O6jjapLgKFOiidB2Ntf5AIyEBPE1/G8qTWPp1azWHD7Mn3TC7i0lM?=
 =?us-ascii?Q?yEXT96HoWWqVklqWV6SUGcFavZk5nf2hnFnIkeyca7b5w4inr4HWInznnufX?=
 =?us-ascii?Q?wPzLWiD8uShhIHS0gc3HejVEaPx30Jn0u9IoQyTQpxPOmyUcad0/iKMvC7qD?=
 =?us-ascii?Q?99FuJ3qWcsnFtSbSkcFWgtGdH6ZTcSD24Xt4Yu9LAsRbVZA/Z6zjT9CNd0xI?=
 =?us-ascii?Q?g5WUyFwP2iStXy5cFJySqzt7u40lGbn1aCYr8uc3Q9ZI7ZD3TVQs0iSNpVXj?=
 =?us-ascii?Q?5A2RBxaw6Oxk462ZSbRIA1b6VOQk39zdyn3h1eUHLSn/VwikKXUJYrBzXtBW?=
 =?us-ascii?Q?pdDQLHnSI644t7V8KqCd+gz+K3iyChrszQnCBEmVB3/xFBdHfB6VdCq0CIyx?=
 =?us-ascii?Q?+l5eh4IoJgrQ+4U/hX4ktY302C3qv9CrWRdu52mMEopFQDX6T5vW9GB859IF?=
 =?us-ascii?Q?a3TfDEArqwcTyuw/M/CoPrM1LSPGwxdIM/n9759b56OyG2Qh1ptkS2xFbK2D?=
 =?us-ascii?Q?vJtaJt39uQ5uFFvn3FlitusXeG/LL5wvYoYlfMn28qq4kfmoJXsGSUTxue4M?=
 =?us-ascii?Q?Te0gHolOl707CH3UoOBCxmBy6IFZ2T4xx+vVVZzPOQq0ACTc0yB5usTjWmcN?=
 =?us-ascii?Q?PnUgN9uUnuvtyqZbui2l8FGXeH8GJ6j6nMe1yB8srX/kahVrKn4JUTgLDR4h?=
 =?us-ascii?Q?4fn0iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:44:49.9211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdba4925-4d0e-47dc-301d-08de590c64e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252004-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,Nvidia.com:dkim];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BF37D5AD8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The obvious idea behind the helper is to keep together the two bits that
should be done either both or neither: the internal notifier chain message,
and the netlink notification.

To make sure that the notification sent reflects the change being made, the
netlink message needs to be send inside the critical section where the
neighbor is changed. But for the notifier chain, there is no such need: the
listeners do not assume lock, and often in fact just schedule a delayed
work to act on the neighbor later. At least one in fact also takes the
neighbor lock. Therefore these two items have each different locking needs.

Now we could unlock inside the helper, but I find that error prone, and the
fact that the notification is conditional in the first place does not help
to make the call site obvious.

So in this patch, the helper is instead removed and the body, which is just
these two calls, inlined. That way we can use each notifier independently.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 3d969f0190a1..0fbdaae7df99 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -52,7 +52,6 @@ do {						\
 
 static void neigh_timer_handler(struct timer_list *t);
 static void neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
-static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm);
 
@@ -1187,8 +1186,10 @@ static void neigh_timer_handler(struct timer_list *t)
 		write_unlock(&neigh->lock);
 	}
 
-	if (notify)
-		neigh_update_notify(neigh, 0);
+	if (notify) {
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
+		neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
+	}
 
 	trace_neigh_timer_handler(neigh, 0);
 
@@ -1520,8 +1521,12 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 		neigh_update_gc_list(neigh);
 	if (managed_update)
 		neigh_update_managed_list(neigh);
-	if (notify)
-		neigh_update_notify(neigh, nlmsg_pid);
+
+	if (notify) {
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
+		neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+	}
+
 	trace_neigh_update_done(neigh, err);
 	return err;
 }
@@ -2750,12 +2755,6 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 	return -EMSGSIZE;
 }
 
-static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid)
-{
-	call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-	neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
-}
-
 static bool neigh_master_filtered(struct net_device *dev, int master_idx)
 {
 	struct net_device *master;
-- 
2.51.1


