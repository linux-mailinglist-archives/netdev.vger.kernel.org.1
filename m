Return-Path: <netdev+bounces-252001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNBtD5wIcWmPcQAAu9opvQ
	(envelope-from <netdev+bounces-252001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:10:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA45A55A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A157A8C48A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F914449EB7;
	Wed, 21 Jan 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mOv2zb0F"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5A466B40
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013887; cv=fail; b=RlQEv/Wljdtq4lStjhntEJ2/V0p4C2ftN7G4WYxxCw6J63DpbN+9kUwhkJbO48sV6RmcIs07fpdltCVoURUfeXIOQCAJuldZ9obY5vdqWMsafhd9CBlzVCYi02BeuCZhWR1pxbFTMv/RCIsINPchyUHD5i6jIsj7myQdfXNy0A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013887; c=relaxed/simple;
	bh=LDm1h9pkt7kgtt4oL4faoT3JWNKOulbtkZp/nJ7Yyhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLzDwUNe4UqgRIJDuM6k/opPF4M7hVlwqxlx4R9KeSAhb+eFcOpTrsee1Q14WDQmLfzSRNcuARGJnMMkwKiTUNZlSjlQ6mrGyizK4+qZWy1VcTgp8opfEQCwrmE2qZ5w8g9f3ElrCamTvGC5dwUJQCQmKyR2+ppXIszsLmEY+qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mOv2zb0F; arc=fail smtp.client-ip=52.101.46.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQi98f2TwQd6fH2e35oOLAVWFzYKyd3a3B5ifDM6R7R1hGJPar9brnMLC2aTEkgx2wU5APHLm5tfraawDu37QP5sN1U7D/OX7e3p7DNmRudEV673gTxS53iPGoAw/4YK/f/ldmxVLEiCgOkCP7NOE9lGnpA5lnxXP/Nhdp/2EX4dhhCK+kKOxsQYsMqdzBBcByAJvZDdedSgtAEM+cRsUHkN3BNpAXK+GNB5zRyP+sMFEgDU2vkvcSmzSEYO4+P9U8svKn/jjNBQjo+SGdZiWYp7I0+MFIPjPuN0o9LQHPGiDOxzkPfhElrzR/81VN5pe/T5aDTrUGrUKcH7/dhh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFBguXWACdCeF+D4eghqRNku2uK4JasfrT/3ea7DO6A=;
 b=RrvMJ5gwSuCbcbJTXoCh3PerbqiB9O8AiBWO7c0EisBoKXaNuadPqYny9CAQKWu5Y3Kh/nPXd3NLcys10MNIfjzu7ue1suezASHpLPiQ7CHT6GhqTeQ0PgTG6YI/ePNZeBcyRjlsOYr1bshc4ySLmDK8UpqT/X+JNn5wPjgJ39vsifeN+3solI6YsqyiXLZUTeEXjhh0Mhv/Q4n903A7TjPa3VufErvJbG+faqjnfjYsCbrmQMDqC1+nuY6GVB9Lhruu6umh7WsSEHrU4X0XIhPRzsdL6ZFM/AhXZUXijCG9tLvaP+LHAI8YrE3rvZYyawahahOTbGg+8FPyNejivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFBguXWACdCeF+D4eghqRNku2uK4JasfrT/3ea7DO6A=;
 b=mOv2zb0FOY1x5cKc0jqGe5FW50g3/fK1tpMhFA9jSZOUYJnPEAo8/od7CYDUSvhQddQwwjGDYU3wMJWdYR0BZrHw2Z1eBQ/8Y8Ut7J1A4yVbXq5JGHSsrQBwcWVt0BRLxlxnh9LwDJ1i4O3BLfQAJQYdoyPPSwg9J93qtAkSYskDIBSjXwH10kSMuwMxmKrLKPcqub8q7P/Jp8ByLGQw9BwUSNYuWAbLJyB3DNNAlJGSHzY2avTA7Aq/pcBXCxyUoobc9m/k4WIt9LI+XBitMtWetank9U7HmEj1arVqtLohWq/YYsKYNavLM4+l17DfpiUfYJsxrgWceb+seNbb3g==
Received: from SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::14)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 21 Jan
 2026 16:44:39 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::24) by SJ0P220CA0010.outlook.office365.com
 (2603:10b6:a03:41b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 16:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:44:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 08:44:13 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 08:44:06 -0800
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
Subject: [PATCH net-next v2 2/8] net: core: neighbour: Call __neigh_notify() under a lock
Date: Wed, 21 Jan 2026 17:43:36 +0100
Message-ID: <4b4368dcc5f5a7e407009cb6c36b69cfb5282864.1769012464.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 155c54bf-0e4c-4023-d48f-08de590c5d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qby8EcXSqm059bds/ApPTtRkyciUKb2b7CoJWe2Xt8ZO34yk1BgoZ4LYELTU?=
 =?us-ascii?Q?JQDYInL3+ksuGoAKViGy4Mu0mNUAPcGAhKKqv09i82V8PbRGbWq2eAFBxk+4?=
 =?us-ascii?Q?MLFfDsOeCoaIMb0Oy4XMHZ1+wm3pWW+ihTLVtCBqcaCzL5GGSWOf3maCNQHK?=
 =?us-ascii?Q?2QzBT2HI1tYZHOIV2qUolXKFrNAiP0Tf9UsvXRc7+PGP/8WaRRncEWnzKwnA?=
 =?us-ascii?Q?v+9HtiRTqSaOG2/qrBnbvodNbzc3PA5Q93rfsto0lKA5DSbGktRSuj27ovMv?=
 =?us-ascii?Q?82YXO6004AyVRpYihrBKW5VM1DZBalFNHSsHPhA7Idqkb5Lm9UbrnaKEzwRf?=
 =?us-ascii?Q?QwNhwZf6aSTSDXUCn9Vmj1Y1z9ouwJbKoWRl4EFw2yCTIX4Av6NjVjwyK7MO?=
 =?us-ascii?Q?8SK/pyecwq6meyxuZu0ANnAPEgi0bAbsV1h5nlHwP8PEDL2J2aLLudOKTC4f?=
 =?us-ascii?Q?CnVbRFDUqgyDTH/PlwUTDOOfokn6+oOdOXz2/qK2Q8QvKc5GBGEdzOmzSZCs?=
 =?us-ascii?Q?5cIPpmJpRObC8hJQmYTkSRT2Mw2aKy/MQ4e9zKve4pvxzcmSqXq+jw5CkE44?=
 =?us-ascii?Q?CMi/UCg5KS/9IIdsJV13W9hBFJ0cUOjt2QOxcCp+QL2dN+n9mVdS5omenuPJ?=
 =?us-ascii?Q?+61Vg1I09PM1s5aV3WJhSiyVF1O0xjRMpOQMcT2Atwlaqw1IYHp+j9HxVSKT?=
 =?us-ascii?Q?vzXKfltGk+rJcgk9N5GAouEtz3PM1XohFOo6fn3o0W/t1Jy+ZtLa9bV2cF1G?=
 =?us-ascii?Q?meHnNJvENM5jzSrK3/1292KvMdrgJ4AsE0fO5Fx5oPSer4RjCnokLIepjx8i?=
 =?us-ascii?Q?fIeV5LeRcNNQE5jRGgqXBC58Vgkckxg9zEkeoT6Byv7Pj7bpzTBv2Wg1AcKz?=
 =?us-ascii?Q?0rFBRcjrMMlXqlkvdW72kngzHl4c5mphPpaJqMmW1Rk/dhE9ehJzVPqr7uLZ?=
 =?us-ascii?Q?3wHzuM5GNnieCB+1l8ucoTzXyoXK3AJMxESqNgjyzXosVrtppRKwPyxy8tWA?=
 =?us-ascii?Q?yB+yCPXQQcBEBygqVoLKT1y94q3QphZJ8NmCmztrl4EDGbZBuu0uoFqaf5z8?=
 =?us-ascii?Q?6/iwL1bVy/IHPytZi4Y3rpIzO8djR9/kmVj109/1PJMVSfymXV/+sb4kS2lZ?=
 =?us-ascii?Q?HIXN2gppW3Ant4Mvt30nMc2vwXnD1hVnrWl20csrWtlqw9gLqAI5l6E3w3Kg?=
 =?us-ascii?Q?9AfHqN6yB5MrPkYsqrpexfSdp3T/ESPW0lkwKyVId4PgqsxLZt8X3y/eyl99?=
 =?us-ascii?Q?MDL1c6A5w03+cITxrOv+2DqEsqaWya6kwuXzp9IEief+ZW0/2K+hFj8uQn4U?=
 =?us-ascii?Q?eUFP8rW4zOca/OehdrygdGegiHf2w/mmc0AJ125nniT6KgoYVNNQYLMbW1zP?=
 =?us-ascii?Q?7Q6IJ/ovMoDQ8b2PpFdpDmIOyoGIBEubM6quaX0UuneVgtqrjE6+/gBZi/BH?=
 =?us-ascii?Q?UD4DOS1Vp36SThiIjKxOXGcAQFTP6z1t79sG4R4/Soc63e7Q3MOPtH8UPTh/?=
 =?us-ascii?Q?orQJ5W6yPlyin6o48Hs+dORlAkU/TJmWu56jGC65wCIsw+LQTKOVIQKTeFE9?=
 =?us-ascii?Q?h6zRZ8MsobOnfq/ZvMM9kUjVGFVl0wwMxg/KRQcN3OoLreuBLYStEOyZha0K?=
 =?us-ascii?Q?lyobkY1nR8mXer3A2OBTjKdJXUAYBh/ZSUHKx1xXDPWLRl3F8TuoFj/gBLi3?=
 =?us-ascii?Q?KwG4qQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:44:37.6823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155c54bf-0e4c-4023-d48f-08de590c5d9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
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
	TAGGED_FROM(0.00)[bounces-252001-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 88EA45A55A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Andy Roulin has described an issue with the current neighbor notification
scheme as follows. This was also presented publicly at the link below.

    neigh_update sends a rtnl notification if an update, e.g.,
    nud_state change, was done but there is no guarantee of
    ordering of the rtnl notifications. Consider the following
    scenario:

    userspace thread                   kernel thread
    ================                   =============
    neigh_update
       write_lock_bh(n->lock)
       n->nud_state = STALE
       write_unlock_bh(n->lock)
       neigh_notify
         neigh_fill_info
           read_lock_bh(n->lock)
           ndm->nud_state = STALE
           read_unlock_bh(n->lock)
         -------------------------->
                                      neigh:update
                                      write_lock_bh(n->lock)
                                      n->nud_state = REACHABLE
                                      write_unlock_bh(n->lock)
                                      neigh_notify
                                        neigh_fill_info
                                           read_lock_bh(n->lock)
                                           ndm->nud_state = REACHABLE
                                           read_unlock_bh(n->lock)
                                        rtnl_nofify
                                      RTNL REACHABLE sent
                            <--------
        rtnl_notify
        RTNL STALE sent

    In this scenario, the kernel neigh is updated first to STALE and
    then REACHABLE but the netlink notifications are sent out of order,
    first REACHABLE and then STALE.

The solution is to send the netlink message inside the same critical
section that formats the message. That way both the contents and ordering
of the message reflect the same state, and we cannot see the abovementioned
out-of-order delivery.

Even with this patch, a remaining issue that the contents of the message
may not reflect the changes made to the neighbor. A kernel thread might
still interrupt a userspace thread after the change is done, but before
formatting and sending the message. Then what we would see is two messages
with the same contents. The following patches will attempt to address that
issue.

To support those future patches, convert __neigh_notify() to a helper that
assumes that the neighbor lock is already taken by having it call
__neigh_fill_info() instead of neigh_fill_info(). Add a new helper,
neigh_notify(), which takes the lock before calling __neigh_notify().
Migrate all callers to use the latter.

Link: https://lore.kernel.org/netdev/ed6768c1-80b8-aee2-e545-b51661d49336@nvidia.com/
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    - Drop the __acquires / __releases annotations at neigh_notify().
      They are not necessary with a symmetrically locking function.

 net/core/neighbour.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6cdd93dfa3ea..66f4a6525106 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -51,8 +51,7 @@ do {						\
 #define PNEIGH_HASHMASK		0xF
 
 static void neigh_timer_handler(struct timer_list *t);
-static void __neigh_notify(struct neighbour *n, int type, int flags,
-			   u32 pid);
+static void neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm);
@@ -117,7 +116,7 @@ static int neigh_blackhole(struct neighbour *neigh, struct sk_buff *skb)
 static void neigh_cleanup_and_release(struct neighbour *neigh)
 {
 	trace_neigh_cleanup_and_release(neigh, 0);
-	__neigh_notify(neigh, RTM_DELNEIGH, 0, 0);
+	neigh_notify(neigh, RTM_DELNEIGH, 0, 0);
 	call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 	neigh_release(neigh);
 }
@@ -2740,7 +2739,7 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid)
 {
 	call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-	__neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+	neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
 }
 
 static bool neigh_master_filtered(struct net_device *dev, int master_idx)
@@ -3555,7 +3554,7 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 	if (skb == NULL)
 		goto errout;
 
-	err = neigh_fill_info(skb, n, pid, 0, type, flags);
+	err = __neigh_fill_info(skb, n, pid, 0, type, flags);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in neigh_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -3570,9 +3569,16 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 	rcu_read_unlock();
 }
 
+static void neigh_notify(struct neighbour *neigh, int type, int flags, u32 pid)
+{
+	read_lock_bh(&neigh->lock);
+	__neigh_notify(neigh, type, flags, pid);
+	read_unlock_bh(&neigh->lock);
+}
+
 void neigh_app_ns(struct neighbour *n)
 {
-	__neigh_notify(n, RTM_GETNEIGH, NLM_F_REQUEST, 0);
+	neigh_notify(n, RTM_GETNEIGH, NLM_F_REQUEST, 0);
 }
 EXPORT_SYMBOL(neigh_app_ns);
 
-- 
2.51.1


