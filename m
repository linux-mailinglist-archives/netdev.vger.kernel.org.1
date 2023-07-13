Return-Path: <netdev+bounces-17443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF69175198D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DFB281C47
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCB612E;
	Thu, 13 Jul 2023 07:10:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E76108
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:10:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26953172C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH97+WuKHqBQdocoYXLIYcQEi+UD9lwNNAejAnD2PTafQS7c6t155s+yIQJ3mtSEvCQtHJ/b+YB/mPoX2Qw5xLMOsKGUX7S/V1IP4Qf6eyVWV1rg7GF6WJsO5gEE/BEE0Sz/FHyqbdIXvcWKAIgA6SwOVDzkaxKsP4RCmjIPQNC5EYthOxkjMNWNgMqKom0ZTZTtAuOJL8s4C1Igc6UKnXE4PTzwHPwsLax3MRvlwtFOjJyjao01F6h14YaRZH6BBwlXKwIMnn/MKolh+S32iSANkH3E1Lw68bhh6wTQn9mHCxiU0zx1ybkzuyHyBR4cvF1JqvKucobgq41ak+b1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouIfZD9fH6Mu5ElPS6Kz6vcu7GVLUX81LBfnwyLfwYQ=;
 b=VXfksOU5YCIfr33UUmsfnsPjpN06mH6hAcHMXelNAG0p2n1FoHPVJqCFUg+C/e6wpG1GJE29lNyDDF74QYE+7saEs32/bd71Nl/2UR3q+IDAe3MzvEwujBvzmRLK36xdxxE5NXoXrd6NGMTT8B2h/s9FovWiH9BppK2Exzcfbe6GBNZvkOZqaAuhCahFGlcwdBALBCCpHqY97x0zHnYxrPAxwQ5Y/InxJbaUUzq7YnuaJhJaVG1GjERF0CI9zTyh1ZMsueEm58gW3YgydFjcQici8fu7d2N9i9SP5R0zwv/Sa1y7XRrOJKgQNJaGxuZxTtVsFoN3R8jOhEaM2MLl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouIfZD9fH6Mu5ElPS6Kz6vcu7GVLUX81LBfnwyLfwYQ=;
 b=rEPNYxZ1kg0MI2fyX1V0dvPj+gNisKL17Z+j0KSZLkLGDRCsyluBj9jcHNXw8zESAwE1h7y84ZKWLuMifxgBfzswv3PDnnGptNlwE1Ffz7P/JHURa38tdOZfzr/ZV6sUYVVjbNaIJHNudP7SPZ72OdrgNUCvVrGCgn3JZxdz/3QKbtXa2tTGo37O7sPP9GetkqK//KlUT85aaXIOx6TvGJlU52uXDl1+klyzw9ifmV7MvM8p2387FPtlUmY1oPZRxbD46LJOCjTS8mvzTWbjqIoppiWj6+oS16VBDaFDTFz4ZaU8pm0Oluh3x2Di6A/GRtMW/YMNGozmaZaPfDcNwg==
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 07:10:34 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::ff) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.7 via Frontend
 Transport; Thu, 13 Jul 2023 07:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 07:10:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 00:10:19 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 13 Jul 2023 00:10:16 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <roopa@nvidia.com>,
	<dsahern@gmail.com>, <petrm@nvidia.com>, <taspelund@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [RFC PATCH net-next 3/4] bridge: Add backup nexthop ID support
Date: Thu, 13 Jul 2023 10:09:24 +0300
Message-ID: <20230713070925.3955850-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713070925.3955850-1-idosch@nvidia.com>
References: <20230713070925.3955850-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b3c15b-acaa-4c0e-bb78-08db837040ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QaJdhfJO7l59+9UbQGtYfOuwcHkZsmCI1zYwtJqUKpAzEMi0Pbnwa/b95AaGmw3e4xQekEDMvgFtM+iJyS+oMysc5b3l0xYNjL4Ay/X5yKlVi6O7h9J4l8D3zBBxhwbEfi0eNCG9Kwpy/iNmvjDOUDgqjnk3YeRxbkeAq/kqRpij4kZYqgK8bPcZ+rqeDwPtK+ViC78FYxLALfCi3vRKNOm4jej6doTpbRS0YO2ICssCynRSOQwOmY+/UL49MoUQxz6Q0kqnen/hzoCw4YZ6ivlgijjkvavyoCRXoEY3eJf9yZGRVNiUCoZJyJ9oI5mAp3ni+aES8n+rlSzsNN8/sSt+SeZuuYd43LaGxq9h89fZHjDHHK4rwUNT0QR/MRG4cXaNwFIAKcGSo7eT4gpok13Qoa0Vh1C+XwWAz+3rY/CnrwoAU6Yt6cZ20jRYEpZvQ1xiZJHe7Z9Xapny4YeAxhRrUrrlqRf6BwSZJDguyE8QmXAU4zKpccJzij+03hJk7ndQptajyBW4PZDEqAEpK8pCaK3ZbTZfbKroYXdKhks5Qs/oAZyNAedjS3aZR8CKGhmh0mNKXsrhmeyWZmLbSlUaYTECvqx/OiS2WxgVuoIno3nlX5kyxo5qEkah5OcyUaSV4Qmv/jc94yWlC04jdhyr8iuA9jiCQGaCnLGUdDK9JUo5NoyrdyyfKhL1/hq51eUMDlZnBpcIy57ypZDDGq4naorfBhVh6kwxoBAF9fKBk5UogTbgMkwiL9RcvxYQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(336012)(82310400005)(316002)(6666004)(54906003)(110136005)(4326008)(40480700001)(40460700003)(36756003)(7636003)(356005)(70586007)(70206006)(2906002)(82740400003)(2616005)(83380400001)(16526019)(426003)(478600001)(5660300002)(36860700001)(8676002)(8936002)(47076005)(186003)(107886003)(41300700001)(1076003)(86362001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:10:34.5598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b3c15b-acaa-4c0e-bb78-08db837040ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new bridge port attribute that allows attaching a nexthop object
ID to an skb that is redirected to a backup bridge port with VLAN
tunneling enabled.

Specifically, when redirecting a known unicast packet, read the backup
nexthop ID from the bridge port that lost its carrier and set it in the
bridge control block of the skb before forwarding it via the backup
port. Note that reading the ID from the bridge port should not result in
a cache miss as the ID is added next to the 'backup_port' field that was
already accessed. After this change, the 'state' field still stays on
the first cache line, together with other data path related fields such
as 'flags and 'vlgrp':

struct net_bridge_port {
        struct net_bridge *        br;                   /*     0     8 */
        struct net_device *        dev;                  /*     8     8 */
        netdevice_tracker          dev_tracker;          /*    16     0 */
        struct list_head           list;                 /*    16    16 */
        long unsigned int          flags;                /*    32     8 */
        struct net_bridge_vlan_group * vlgrp;            /*    40     8 */
        struct net_bridge_port *   backup_port;          /*    48     8 */
        u32                        backup_nhid;          /*    56     4 */
        u8                         priority;             /*    60     1 */
        u8                         state;                /*    61     1 */
        u16                        port_no;              /*    62     2 */
        /* --- cacheline 1 boundary (64 bytes) --- */
[...]
} __attribute__((__aligned__(8)));

When forwarding an skb via a bridge port that has VLAN tunneling
enabled, check if the backup nexthop ID stored in the bridge control
block is valid (i.e., not zero). If so, instead of attaching the
pre-allocated metadata (that only has the tunnel key set), allocate a
new metadata, set both the tunnel key and the nexthop object ID and
attach it to the skb.

By default, do not dump the new attribute to user space as a value of
zero is an invalid nexthop object ID.

The above is useful for EVPN multihoming. When one of the links
composing an Ethernet Segment (ES) fails, traffic needs to be redirected
towards the host via one of the other ES peers. For example, if a host
is multihomed to three different VTEPs, the backup port of each ES link
needs to be set to the VXLAN device and the backup nexthop ID needs to
point to an FDB nexthop group that includes the IP addresses of the
other two VTEPs. The VXLAN driver will extract the ID from the metadata
of the redirected skb, calculate its flow hash and forward it towards
one of the other VTEPs. If the ID does not exist, or represents an
invalid nexthop object, the VXLAN driver will drop the skb. This
relieves the bridge driver from the need to validate the ID.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_forward.c      |  1 +
 net/bridge/br_netlink.c      | 12 ++++++++++++
 net/bridge/br_private.h      |  3 +++
 net/bridge/br_vlan_tunnel.c  | 15 +++++++++++++++
 net/core/rtnetlink.c         |  2 +-
 6 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 0f6a0fe09bdb..ce3117df9cec 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -570,6 +570,7 @@ enum {
 	IFLA_BRPORT_MCAST_N_GROUPS,
 	IFLA_BRPORT_MCAST_MAX_GROUPS,
 	IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
+	IFLA_BRPORT_BACKUP_NHID,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 6116eba1bd89..9d7bc8b96b53 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -154,6 +154,7 @@ void br_forward(const struct net_bridge_port *to,
 		backup_port = rcu_dereference(to->backup_port);
 		if (unlikely(!backup_port))
 			goto out;
+		BR_INPUT_SKB_CB(skb)->backup_nhid = READ_ONCE(to->backup_nhid);
 		to = backup_port;
 	}
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 05c5863d2e20..10f0d33d8ccf 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -211,6 +211,7 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_IN_OPEN */
 		+ nla_total_size(sizeof(u32))	/* IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT */
 		+ nla_total_size(sizeof(u32))	/* IFLA_BRPORT_MCAST_EHT_HOSTS_CNT */
+		+ nla_total_size(sizeof(u32))	/* IFLA_BRPORT_BACKUP_NHID */
 		+ 0;
 }
 
@@ -319,6 +320,10 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 			    backup_p->dev->ifindex);
 	rcu_read_unlock();
 
+	if (p->backup_nhid &&
+	    nla_put_u32(skb, IFLA_BRPORT_BACKUP_NHID, p->backup_nhid))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -895,6 +900,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_MCAST_N_GROUPS] = { .type = NLA_REJECT },
 	[IFLA_BRPORT_MCAST_MAX_GROUPS] = { .type = NLA_U32 },
 	[IFLA_BRPORT_NEIGH_VLAN_SUPPRESS] = NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_BRPORT_BACKUP_NHID] = { .type = NLA_U32 },
 };
 
 /* Change the state of the port and notify spanning tree */
@@ -1065,6 +1071,12 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 			return err;
 	}
 
+	if (tb[IFLA_BRPORT_BACKUP_NHID]) {
+		u32 backup_nhid = nla_get_u32(tb[IFLA_BRPORT_BACKUP_NHID]);
+
+		WRITE_ONCE(p->backup_nhid, backup_nhid);
+	}
+
 	return 0;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a63b32c1638e..05a965ef76f1 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -387,6 +387,7 @@ struct net_bridge_port {
 	struct net_bridge_vlan_group	__rcu *vlgrp;
 #endif
 	struct net_bridge_port		__rcu *backup_port;
+	u32				backup_nhid;
 
 	/* STP */
 	u8				priority;
@@ -605,6 +606,8 @@ struct br_input_skb_cb {
 	 */
 	unsigned long fwd_hwdoms;
 #endif
+
+	u32 backup_nhid;
 };
 
 #define BR_INPUT_SKB_CB(__skb)	((struct br_input_skb_cb *)(__skb)->cb)
diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 6399a8a69d07..81833ca7a2c7 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -201,6 +201,21 @@ int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
 	if (err)
 		return err;
 
+	if (BR_INPUT_SKB_CB(skb)->backup_nhid) {
+		tunnel_dst = __ip_tun_set_dst(0, 0, 0, 0, 0, TUNNEL_KEY,
+					      tunnel_id, 0);
+		if (!tunnel_dst)
+			return -ENOMEM;
+
+		tunnel_dst->u.tun_info.mode |= IP_TUNNEL_INFO_TX |
+					       IP_TUNNEL_INFO_BRIDGE;
+		tunnel_dst->u.tun_info.key.nhid =
+			BR_INPUT_SKB_CB(skb)->backup_nhid;
+		skb_dst_set(skb, &tunnel_dst->dst);
+
+		return 0;
+	}
+
 	tunnel_dst = rcu_dereference(vlan->tinfo.tunnel_dst);
 	if (tunnel_dst && dst_hold_safe(&tunnel_dst->dst))
 		skb_dst_set(skb, &tunnel_dst->dst);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3ad4e030846d..9e7e3377ec10 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -61,7 +61,7 @@
 #include "dev.h"
 
 #define RTNL_MAX_TYPE		50
-#define RTNL_SLAVE_MAX_TYPE	43
+#define RTNL_SLAVE_MAX_TYPE	44
 
 struct rtnl_link {
 	rtnl_doit_func		doit;
-- 
2.40.1


