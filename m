Return-Path: <netdev+bounces-252006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FkBEOotcWmcfAAAu9opvQ
	(envelope-from <netdev+bounces-252006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:50:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A35C898
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8D1080B06D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BDE2D8376;
	Wed, 21 Jan 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GBYyzoF0"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DF1EB5E1
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013918; cv=fail; b=bwgswPHFTznDXxkEnpp5OFF/wTA4HmfjDzKxFg4WHF/SW6z9c+NKMksBOYulqblzIktUd2mxIh3BHmk9Tda3HO3E0s33+naa4e7EHo8LZUKFV13hpAlF7OUbEkfcWtIuRfXrdAUcI1yElxHzxxscC2DuNw11hwD0oDApcHZsOQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013918; c=relaxed/simple;
	bh=So1cLddDFqr/VcLXM6b9tTH/202/UlBmKhK9/KHcvnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Le31SZye0qrecbD/2GGeMh/QWEr3p7W8QaBBGT+dQiVTDfMflgEIC5pDkBENDwHtqmhvJ6RbDkR/bUWLmL6UdDGG/LNnbN7Q/+kvrHM/Gm0/6qcP3V3MzLi+Nk8CsjP6T1lk8NOlagDH6VXZbTYa4JP/5mcFdKMmrfKRESI9wRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GBYyzoF0; arc=fail smtp.client-ip=40.107.209.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHsoMqZSXEAbadGOuiOXoThzNbwWjvwUTi20C20+wfos22VRtD86TUI3VGX9wyuzudmZx0rVXkO9yrMf1SqeZqrfdq5vSB6IqUdvktpwXl/8yvU9GVpUEFkytxkoevAKP0f+aPlPc7CS8ZI3UsVT1/5JJH2jWeJ5oKOr3RvTUDppd47It4RgOhofsz/c9G5F9qJzEIF9Lgo7/QbADPesk6RTG7Kbcitte3leDFpvJhfg9LtEPhz6Jab7hSM5W3RG3/FSqmgVNftFO00HTF5zjQvnGaDnikgxF7XSHBaA/ThCsu/+NKpY8Hg/pv6DsepUUybmJeOMz9rL+sHY4Gm+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaYcu+plL2jUWvZUi3moOIkhQRyogRHsIA3S2Js6Qr0=;
 b=Cy0ekbQC1K8Np1F9YrLl5dDsyu4kawQ0Rzes99wJ2ukD5lVjx8iNN6RfTMg3rw/zUFefjdN8HKaYEuBGoCZhp01qsy8mtm6y+jc08AZJr5TPbJi/SPUyBB0gC9VzqkEkSxlDB5hm+qR4aHX4/17wCr05KFwNhesaafxftP+DCztZJ2eJQsAJVbSOKl9vkIAs5VEWOwbjxTMovK6i09gnf4axtBV/6/krOWfUGYSTytL/Ef65Eia7jQZi3hjYCgSE058Uh005siPJNZamDW4rII1+6aL6SqFIb7CM8e6eoeF1DrxGQ9uClhnhk+fCPaI+Y3u52BcDY1sehjm2mwLUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaYcu+plL2jUWvZUi3moOIkhQRyogRHsIA3S2Js6Qr0=;
 b=GBYyzoF0VIwaBLI6wnsg7Nxg30ZtbYPfMmyW43Nf6PJv3LrB0WmaSxUeUrOTGX82WVtSbv6k6nrNpZ+K4dvybDJctX9Ncr5oEzJIVtfteX5UUYyjg08iJ3hRm8aVzdZzK/gV3fCJo5aIRKkPUF9cYLAXbDvzys5WaG5p0X27jSgGToPFGU/PNfy4lc2bN37NvzRspfVXKLLQ4Es34TLlgp6yLNrOh3lw7kRusp+c4sse8tqGBs3u75l9FPjFTiULowW681DtTCy9UX1mBy03rWrcNPQMlbSLbbXMWaohgKB6IotwJ5JnevXEQmZWNSFu074xwimX9vIbHRWcw9pQXQ==
Received: from SA0PR11CA0029.namprd11.prod.outlook.com (2603:10b6:806:d3::34)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:45:08 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::6c) by SA0PR11CA0029.outlook.office365.com
 (2603:10b6:806:d3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 16:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:45:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 08:44:44 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 08:44:37 -0800
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
Subject: [PATCH net-next v2 7/8] net: core: neighbour: Make one netlink notification atomically
Date: Wed, 21 Jan 2026 17:43:41 +0100
Message-ID: <ceb44995498eb52375cb2d46c3245bdb9e74b355.1769012464.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 785874b8-73fb-4ae5-423d-08de590c6f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MqSuB+kFMMvZEKthqfI2R7CkEzRuW8somyr/L/w/uAwnRYAUibRqB/3DArEC?=
 =?us-ascii?Q?kgcWCPOatWZ60Ei/K0TNtXN5QW/a4XQ8LG1QavZUUj5Rp3a5GnCQZ2/hAG6U?=
 =?us-ascii?Q?T5/WttjwkXi5tWFn24UKYwaSFofXt6mqMoJd8DT9yG8ErrkJ7oH/uxEbnMVP?=
 =?us-ascii?Q?8P53PqfrS7ACrVjAQUaZJ2/NC8JSlyZWYj6u06zBluJJpzHKFr1tNLdrV4yt?=
 =?us-ascii?Q?u2yLuaOz4/Fk+psHH//z0exUCiXoOJ3+6oxzQiLlDG0x/NaUFm0xkM82GvY4?=
 =?us-ascii?Q?FIoJdCoPnZGmFtBxyKlCIpPtheS3tMa+Leb0+Df6nQi3qSxzkStPejINiZF6?=
 =?us-ascii?Q?bfx1qb7aVW8ZXejIf2NL1LaUGSReH95IxKjkIx0sd0xU5/lFnwWrC4tfavxC?=
 =?us-ascii?Q?rQTbqFKoXwp/qu0lVscFtnSuBh1d9ftBZOSMlo5eC75BLXfq7Pr250vL2aQp?=
 =?us-ascii?Q?nU/O+rxX0inuFuuKPEYIAukSmsxQ3iHSBcS5hGVVoAKYURmyy/+ggAz88UJC?=
 =?us-ascii?Q?dlmqLlgBNCtfBqqrsi567oYP5B4A82JtTootwQnwMTiHonxygfUDPe5FDvAX?=
 =?us-ascii?Q?O88SekbAV3whKTYiSYNe9gukLI2OJyUjxwqwYoFccq09WJBK0upaEWNCNhea?=
 =?us-ascii?Q?i/5ELxofHshVjNQCPeQuFiZDJg8bJ8V/PI6vqOP90DsG0+nI1ypL3a3orrDK?=
 =?us-ascii?Q?KWmlRHn7vuPImZUllK+aChD6I1w7numLFjqL0eH4pjBsP5R9HI/Vf+cHpvwH?=
 =?us-ascii?Q?0jLGLp4j4FvtRYp+pAqKDftmlISttVda6YE4ygsV+MMWCiZLj+lXFeeYfAEk?=
 =?us-ascii?Q?b80C0cQi80Srcber11W48GHIbQ4a6mdcNu5YD9kgtjyQZVmZUn1rwe669Zra?=
 =?us-ascii?Q?MCzC9ahfQ4G2p0PPmMOFGXmjSq6iKhinu9/RnwhxF/7LZZ1K1oy1sc3watO7?=
 =?us-ascii?Q?m30FOFFZF9BhTrHHXsAZ8tAkdhD5NgTb7OzJ/TmF2dHzJ2x2EckvZMoF9T4s?=
 =?us-ascii?Q?Fu3DWjbG3fboZ/SKAKPbfrJUSZD51qoKaEVQn0IfcXEZHRDtYjQ2yDc3uDOV?=
 =?us-ascii?Q?7VQtPKSx4Q1Fo7w0tw5UnKFDpLm6QjhKolhBBezUdXLe9kGJ88xbXIcPWpJw?=
 =?us-ascii?Q?s2xXJKWJpVov6hTML5NrIehzwKMISHc+G1ZjK0mfKnSaOfA+vzpslAtix9Cu?=
 =?us-ascii?Q?XbsQZ9g0bdeZMKgFL9kWuilDtER7lDQvvmw2k0GLWfix1p3y4tU0y/9PiSjM?=
 =?us-ascii?Q?4UD7ztRiorUPVlAUFlzOA+f4l20hJHxw3xt66QUPjYY5BSHpGatunAkp2Q5m?=
 =?us-ascii?Q?fCBEdXtyzujRKfCGgwEVz1rg7XzR8qpZ6kNqrTp62i6Szn8fB86Qj08b62fA?=
 =?us-ascii?Q?k3eH3aUuw96o3zMEpQevEhABtNNGbIuGoDMEgvhQAXBeKVPRpX16j5MAYTHG?=
 =?us-ascii?Q?R76AoYQUZo8j5n3OHiZDgn90qRwRXMY98plA6Von7jKKoRJN1MY762M/FjC/?=
 =?us-ascii?Q?YazxKd4PVZIhsUiKu8R01GY31f5lUZXASBMwsZeOXHyjcYOnglwcZbYqs7ju?=
 =?us-ascii?Q?DCFtVqHUBpIz6VEIO9wc3ZU/PosIZBFIM/9zX8/5/9ksA5gzvSmE8l2I1WXd?=
 =?us-ascii?Q?1oHtfwR/OQhC28JiYCKbl/5CyoWWFNjN78J02rJPj89tVNM/boeNaR02qom9?=
 =?us-ascii?Q?AnMGQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:45:07.0622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785874b8-73fb-4ae5-423d-08de590c6f20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F
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
	TAGGED_FROM(0.00)[bounces-252006-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0A7A35C898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As noted in a previous patch, one race remains in the current code. A
kernel thread might interrupt a userspace thread after the change is done,
but before formatting and sending the message. Then what we would see is
two messages with the same contents:

    userspace thread		       kernel thread
    ================		       =============
    neigh_update
       write_lock_bh(n->lock)
       n->nud_state = STALE
       write_unlock_bh(n->lock)
	 -------------------------->
				      neigh:update
				      write_lock_bh(n->lock)
				      n->nud_state = REACHABLE
				      write_unlock_bh(n->lock)
				      neigh_notify
					read_lock_bh(n->lock)
					__neigh_fill_info
					   ndm->nud_state = REACHABLE
					rtnl_notify
					read_unlock_bh(n->lock)
				      RTNL REACHABLE sent
			    <--------
       neigh_notify
	 read_lock_bh(n->lock)
	 __neigh_fill_info
	   ndm->nud_state = REACHABLE
	 rtnl_notify
	 read_unlock_bh(n->lock)
       RTNL REACHABLE sent again

The solution is to send the netlink message inside the critical section
where the neighbor is changed, so that it reflects the notified-upon
neighbor state.

To that end, in __neigh_update(), move the current neigh_notify() call up
to said critical section, and convert it to __neigh_notify(), because the
lock is held. This motion crosses calls to neigh_update_managed_list(),
neigh_update_gc_list() and neigh_update_process_arp_queue(), all of which
potentially unlock and give an opportunity for the above race.

This also crosses a call to neigh_update_process_arp_queue() which calls
neigh->output(), which might be neigh_resolve_output() calls
neigh_event_send() calls neigh_event_send_probe() calls
__neigh_event_send() calls neigh_probe(), which touches neigh->probes,
an update which will now not be visible in the notification.

However, there is indication that there is no promise that these changes
will be accurately projected to notifications: fib6_table_lookup()
indirectly calls route.c's find_match() calls rt6_probe(), which looks up a
neighbor and call __neigh_set_probe_once(), which sets neigh->probes to 0,
but neither this nor the caller seems to send a notification.

Additionally, the neighbor object that the neigh_probe() mentioned above is
called on, might be the alternative neighbor looked up for the ARP queue
packet destination. If that is the case, the changed value of n1->probes is
not notified anywhere.

So at least in some circumstances, the reported number of probes needs to
be assumed to change without notification.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 187615bcc1c3..1d7489f50b21 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -52,6 +52,7 @@ do {						\
 
 static void neigh_timer_handler(struct timer_list *t);
 static void neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
+static void __neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
 static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm);
 
@@ -1512,6 +1513,9 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 	if (update_isrouter)
 		neigh_update_is_router(neigh, flags, &notify);
 
+	if (notify)
+		__neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+
 	if (process_arp_queue)
 		neigh_update_process_arp_queue(neigh);
 
@@ -1522,10 +1526,8 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 	if (managed_update)
 		neigh_update_managed_list(neigh);
 
-	if (notify) {
-		neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+	if (notify)
 		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-	}
 
 	trace_neigh_update_done(neigh, err);
 	return err;
-- 
2.51.1


