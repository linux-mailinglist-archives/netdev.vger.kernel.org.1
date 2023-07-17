Return-Path: <netdev+bounces-18222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B15755E0C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 10:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C261C20A6C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45FC9471;
	Mon, 17 Jul 2023 08:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91883A922
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:13:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::607])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE77B10E9
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 01:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHJBsU011pJZZty0ySWikavO+/XhEKl2RLUxiDCzX2RYxpDX2UZXoTkmyG/IMC8hCrjthceJdA9W9jHEHMX4ICf0Wxur9NQdwXB6JbMmgQLzhS9lS2/fHr6rvlKFTsT+LVu61U/cyT4ncr6XOTQtl4eHNlbcXIzszFRlwRpjqTX8q58rLpO6YcByHnmS+kmKNz7m01X8yKh/ed4VJRCQVOPFZjDpkODq7RBTG559CjtaKE8fKKbOiqXvBmKGuTKXlplzzVPxlQnI9DQLyHE2l5T7ZcpiJXF97K5zIvisaf6Ka9TWuFy1+aP+Q6a5x80434UXnoN83cOY1OI71oE2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqYFahB00/19BjAhK9JoHjeOzcOwhrxH0RfpizqjMww=;
 b=Gk//2YDKWU4S1WdrY1srbcyFF7TBaPoTA6XpsPeWQovqa0qJF5S0vvHilWInqkmv2nbERVuA9o2e+GuTHQhJbMc92LsU3N8gl7eiBd+WeJ9NjotVcbjPqnJmO9xaJeE3k5Vqfb86WRuuMNsr726/Du/NnOTZRiVbdgu7ruqG7uwYpEETtk/Sa3COz3jWqfvxtihdNDDJ6O8AuexMaqj5JZfbdgNkMW6kRpqf6+ATPqBQN0hi8PTuHCWryXkoaqu3dUX01YyzDpe40kMC2fFfplKUtasj1Q7AM4Ds+lkhX+lqVyUE27pemnPq7Ukgsda2BAa1Hx0YL3UrUPQQSvbyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqYFahB00/19BjAhK9JoHjeOzcOwhrxH0RfpizqjMww=;
 b=P/bk0r3KCKKcVhQJZwpIXYMSVNq/zvUjqKdg2p7fl3BK47EvsLAM6KzXL36WOjLYSKImivFhnnZRywTWuDi4xkQZedm4OQfoRiDFldergu5vUdC3Am8pKAv0tEltU75MCuxIAiDJapo2RtcF0HX1L6A8Ahd0YXRRt7Jole4LNtyf3yaqH4FUa6QXnvZzIH627KUQFnpoxDnNn5deuxZp6pKK9ZJVzByuA5O41yZK83ECSWsVBVPx4RxijJ2Hg9r5KN84QiwomwVjmxz1niai66yAc14xcF6t+lp4CIwWPS3J4RZsqT54OoNTaWn4iCGF9gzowApK7N1HGtKrZNcNmA==
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 08:13:16 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::39) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 08:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 08:13:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 01:13:04 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 17 Jul 2023 01:13:01 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <roopa@nvidia.com>,
	<dsahern@gmail.com>, <petrm@nvidia.com>, <taspelund@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 2/4] vxlan: Add support for nexthop ID metadata
Date: Mon, 17 Jul 2023 11:12:27 +0300
Message-ID: <20230717081229.81917-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a71e52d-f7f5-47f7-3703-08db869dac28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LHvNkeQDPy7OhsaVEH8pqgUa/bza20BDl4GbZCsfsYUvYzbe0VxwdQnXpI77RE1DPHos6eyPWwuBwhuC/wg4RGxvzkgFfJdM+26y39Meu+iVjNQsb7qCMfNn5NAkdUCoSczMh3k///cDlpt6ehw3SIkhfrmi2Civ9E0xxSNcmP36r9wGzA/6EbD8qYjCyO4RgqLUwpHXou+OxHh25uAEZJelqcnnHOeXPJJWeja7kluM3JYm+R66atfU/D9w4lToQW2ZWN8aZ1Qipyt6NX5jdSQNVn6zXrMzucPXNtdsb5FN2ptW1rG+H1ZxehIFiHE41t0c0qwZITLGlTrmvovZh8vbqI7JdZ5uaWnG+tYaPunh+hMEG+Oz3652xndT5w8QKQogcUthicuK24fd8uegkGfZdCemN1kin+SFLzt1D7ocD9SY4ouStHioiu/qftDJZbXTdI1pPOQxXvPGDkEAu4s62B9xFYO16QzpAW6V2i4hnufL0suBZ3doh0JfoRF7DZ1KLala3VGeNwqWd4xuE1Xrumszg0Zi3udo5gvCzhvWVzNMYiJ2DeOqTyXLifPYLGbkM6JCsuS/GZG0v7iPbezB5zH15mcH4WzP9N1mxLrcHsseu4u2zu5yQhV4g8roPL9s7xK23cwuI3Xq+/KUXuZF1sOfXaPaKlqKLcoc2r1imSRoVj0HsC29/04sM/x60Au7qm6zNfudAZxOqGIf7ZqN42IjghO/666woTNO9BS6Bm0nXDi0n50J6WmgnOO7
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(86362001)(2906002)(36756003)(40460700003)(40480700001)(47076005)(426003)(16526019)(336012)(186003)(83380400001)(36860700001)(1076003)(26005)(107886003)(356005)(7636003)(82740400003)(54906003)(6666004)(110136005)(4326008)(70206006)(70586007)(316002)(2616005)(5660300002)(8936002)(478600001)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:13:15.7798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a71e52d-f7f5-47f7-3703-08db869dac28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

VXLAN FDB entries can point to FDB nexthop objects. Each such object
includes the IP address(es) of remote VTEP(s) via which the target host
is accessible. Example:

 # ip nexthop add id 1 via 192.0.2.1 fdb
 # ip nexthop add id 2 via 192.0.2.17 fdb
 # ip nexthop add id 1000 group 1/2 fdb
 # bridge fdb add 00:11:22:33:44:55 dev vx0 self static nhid 1000 src_vni 10020

This is useful for EVPN multihoming where a single host can be connected
to multiple VTEPs. The source VTEP will calculate the flow hash of the
skb and forward it towards the IP address of one of the VTEPs member in
the nexthop group.

There are cases where an external entity (e.g., the bridge driver) can
provide not only the tunnel ID (i.e., VNI) of the skb, but also the ID
of the nexthop object via which the skb should be forwarded.

Therefore, in order to support such cases, when the VXLAN device is in
external / collect metadata mode and the tunnel info attached to the skb
is of bridge type, extract the nexthop ID from the tunnel info. If the
ID is valid (i.e., non-zero), forward the skb via the nexthop object
associated with the ID, as if the skb hit an FDB entry associated with
this ID.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/vxlan/vxlan_core.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 78744549c1b3..10a4dbd50710 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2672,6 +2672,45 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	dev_kfree_skb(skb);
 }
 
+static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
+				   u32 nhid, __be32 vni)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst nh_rdst;
+	struct nexthop *nh;
+	bool do_xmit;
+	u32 hash;
+
+	memset(&nh_rdst, 0, sizeof(struct vxlan_rdst));
+	hash = skb_get_hash(skb);
+
+	rcu_read_lock();
+	nh = nexthop_find_by_id(dev_net(dev), nhid);
+	if (unlikely(!nh || !nexthop_is_fdb(nh) || !nexthop_is_multipath(nh))) {
+		rcu_read_unlock();
+		goto drop;
+	}
+	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
+	rcu_read_unlock();
+
+	if (vxlan->cfg.saddr.sa.sa_family != nh_rdst.remote_ip.sa.sa_family)
+		goto drop;
+
+	if (likely(do_xmit))
+		vxlan_xmit_one(skb, dev, vni, &nh_rdst, false);
+	else
+		goto drop;
+
+	return NETDEV_TX_OK;
+
+drop:
+	dev->stats.tx_dropped++;
+	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
+			      VXLAN_VNI_STATS_TX_DROPS, 0);
+	dev_kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
 /* Transmit local packets over Vxlan
  *
  * Outer IP header inherits ECN and DF from inner header.
@@ -2687,6 +2726,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct vxlan_fdb *f;
 	struct ethhdr *eth;
 	__be32 vni = 0;
+	u32 nhid = 0;
 
 	info = skb_tunnel_info(skb);
 
@@ -2696,6 +2736,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (info && info->mode & IP_TUNNEL_INFO_BRIDGE &&
 		    info->mode & IP_TUNNEL_INFO_TX) {
 			vni = tunnel_id_to_key32(info->key.tun_id);
+			nhid = info->key.nhid;
 		} else {
 			if (info && info->mode & IP_TUNNEL_INFO_TX)
 				vxlan_xmit_one(skb, dev, vni, NULL, false);
@@ -2723,6 +2764,9 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif
 	}
 
+	if (nhid)
+		return vxlan_xmit_nhid(skb, dev, nhid, vni);
+
 	if (vxlan->cfg.flags & VXLAN_F_MDB) {
 		struct vxlan_mdb_entry *mdb_entry;
 
-- 
2.40.1


