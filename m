Return-Path: <netdev+bounces-18223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FA755E0F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 10:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99D228138D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790E9476;
	Mon, 17 Jul 2023 08:13:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568608493
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:13:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E4170B
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 01:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLqFiOzEdnUy64rfQivtDwf147qqXjj8up2j6ndKkxyH0cC9nhzo4b6y8r3DhzQOzOZWisTmXwuLzl7pS8gPcpdc6R9RXYm/lMsgNookGZUv1QpVxUmg7WapotXGhnkMIcbC+teyU2LEzT+9GTCMiOFzMdMpRvw0WCWsh/LpNymyC2k2sRpC+wTXwCb2ux9BUZT3piepgSl0noHahHZ0jkZd76ewlvsf8RFjOpHgadruhqwshoxkSAgphzYimosyNSzrC7ZYuCFBDneo+zPa69VYbLs9IeEwgHjrTB7sebp43RIV7ar2ypOHSt/Pv/N5vVEmq6Rnje4q9mBsYoXcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDWiEVL/kj2zpvXyEutiwstY2fsYbzvzxhCyDrOorc0=;
 b=TW1XvDS8nlOmw2/01F3arin6ZJRJ5GmvwBZdmHZEB9Pj1weiltediDfXLVrcRPZ5AWGNbfN1lS2Ip9UY925Bgf8cTxKy6V5q1sJzEF2/wi9v5XFr7LaRIVjG3dWHXi07ZpvXB2+OF1Afb217XQg6Dh4Z6GkCv7TxjmTRZWzmd+9EcmTS70JOoZN194oVatBotC8n2b9YnbgFSNgpZxZsQhSJBcnWrbc82cxOGNzT33rL2rCy5UDF+ATSB55iyrUm3UVWrQ59IDEWLREtG1L9k/j++L0zRpnnMvEbRPh+BCB59sC7xde1GGTqbn5PHkpG4o2gA8rhfQn2trOFfX3FkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDWiEVL/kj2zpvXyEutiwstY2fsYbzvzxhCyDrOorc0=;
 b=N418fqf9bUt++YKkNDkUBrrSq9MpK2NYcn7JBJDiZHTSYts7cyvbnCoczmM965qB/dVW8Azg/taSQ6SfZoCpgTrKvCSJrYym75mzqbwbqMjptvvz/whjqi87bMQA9KODIEfR5F0VjFK7RymezO44kgML7lNjpHY5V10ST4aNl6brDpCLK9Z41ZxfKFmLPwD0L6WghE4/Nsfu0jy5XZeUWnbg1KvREzHJ8u8Yv6K8qEVYldnl5KADjCeStKd7od8v+YXPxYVrnDoAB8NDE0M2dMESGGAZ+Woi+0zmOjIAR5FIsfm7DbIR3gYZfhM9c5ggQQzmhwqc4MMri1APdLqcUw==
Received: from MW4PR04CA0212.namprd04.prod.outlook.com (2603:10b6:303:87::7)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 08:13:20 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::a6) by MW4PR04CA0212.outlook.office365.com
 (2603:10b6:303:87::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 08:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 08:13:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 01:13:08 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 17 Jul 2023 01:13:04 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <roopa@nvidia.com>,
	<dsahern@gmail.com>, <petrm@nvidia.com>, <taspelund@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 3/4] bridge: Add backup nexthop ID support
Date: Mon, 17 Jul 2023 11:12:28 +0300
Message-ID: <20230717081229.81917-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717081229.81917-1-idosch@nvidia.com>
References: <20230717081229.81917-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|DM8PR12MB5462:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c5ab94-6bb4-40fb-4e75-08db869dae7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JATxxAi9eaYMAkW0tgl4QfIfj2sdUmYQf2VWU6u0fM0k0zb3Jv1pkRTO/W594woD9z93mjNcdW3ZiwEoe39UYf2jsWMi0ImTK9Zru/bmln5Px7admZqY3Yt4nh2xl4sa32gIAfDn2LAwafpvBstEh8RwiAHk/Kp2gRXsAR+qaCjMkWMfAWkFmujAUkhrzcMXgx+cq+CQBVXGR9aH2vOd8hcbO+QL3BEdC5PSJ2wxwkw/Lywt+NQJqsjtbXzsUNy7dgPE9PwAO3h0uEiEcy2nX6L5eSyjOHSVbIyCfNs6iRTrVBdX9fBbt6xjWJngA81RuPnKI/+X6G37AFMd7aBM6JOjT/Uipk8F5R/tihzB5j1rkzbFNhjzpHdqKq4dA/JYypvUIwcpayk83R0IFMdhbfqpENe6OZRP8JDBztEJix+qaQisMSIaHv8SIaMAnNUzEqD8T17nMZcQwb9+9qrC4oLjKBSpDCqlQhBMu+FFxzqz1IEzHzK42Tsd01pib+cECLYkIo6k/e0yB1qbWCQQWSUy/72f4479vkBV/v/hLQwQvLHBf9P1RSeBMU3UxvqtxbM8J1ByxCKzJIM1Pdz25iCfK4pvM7+e7S+qf2pQFyU+DoYOg+aoTGFHn80ai1gTj7FS0NmJdFCmf2VKAy/H/aN8ba2Z/2JyFRV6zXF8kbOrxvYBYJW6T+4l4DhVNroz37dbVgIJKYUSceAl1nm1FQ073+9TW2XfXxTzlXt+tX1XAwIv55LHwvUId5sLMPzv
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(70206006)(54906003)(336012)(110136005)(356005)(7636003)(82740400003)(478600001)(6666004)(8936002)(41300700001)(5660300002)(8676002)(316002)(4326008)(70586007)(2616005)(16526019)(426003)(36860700001)(186003)(47076005)(83380400001)(26005)(1076003)(107886003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:13:19.6733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c5ab94-6bb4-40fb-4e75-08db869dae7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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


