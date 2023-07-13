Return-Path: <netdev+bounces-17442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DFB75198B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652031C212BA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849756112;
	Thu, 13 Jul 2023 07:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A216106
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:10:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC11BF0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdyLUMDiYeFtxSYLQh9DW+Z9Qg/gMDHwTA3EiZvPkBW41WT/QGix+OVu8I1HvIvwPJ+07mw6BmpMAUs2syVAooNwz00wsvbYWs1BEo7w6gwf5xbb/YzqDG3OiqKZCl84s7goQg3MovTFir8wVmFApzaiNvNnsZgfwvntqg9iWeDVLyw98OwGTbhAViMSokZwSe8X/qH1+qT3WSr1jCtbyYREy47gAj/oen0TBLY5jDDsLDbynjh8NCZK0Uv6JppJQWuF/tRFNOcBi9kpaOFpwVPTgqaWxkkRhLNJygzcOv9zGMEMkUhn93Ugha/wiKDOfXhcIhn6jWiXlbOEIsTbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atm9CGpPjeRFLS/syFuSAHEqrZlKZkYjuFPtkoz3LPo=;
 b=doXHssU6AeQid5Vod+H6q8kfsE78Ob9y0SmBCdUQIWVYM85ritnY2NHbe08do/6Gdj5JjsfBqjxmeZ8tLtSxpl5PYylFI6Wz29Bt0jGpiQLDO0AuTx5uH78is7cepH0CqUrZl4/z29g02qiqRAW1/wwxtw8zxF2oiBHsiajo1KZAVOOyjiK/La/qF244okxTets3I4JtBEISbgPBmhu6gvKEIuJD5X9X0UigoWBIvewnGBW0dyDE753styFcUAZS1n54s6ruGVrbvXph9ZgA3VlTKF8G77g48uDN2+a9Z0B9Fy9ZwNs22jdxk5+QXSqqCAeBkkpDvejzXRURWcbCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atm9CGpPjeRFLS/syFuSAHEqrZlKZkYjuFPtkoz3LPo=;
 b=MqHn1VqPIZ8oDwFZfM4H36gxVEHGtNiWzTN05W2c+PIC3WW03MAZoWdj4eKHvfLDemC9HZNf09vcT6tLAsjnxrOXlrJG4mGGJQ0DDvrZ4cKKP1BPqb8TtKoEp6O0/pfOPDXZ5cHHKi8hZuPXF3EN2zQQA4PObG8KNTSf+f03g5NQvUfA8k6mB0wfYr7esUEBye57Rs8wbWbElAP1XhoKJpLtaQziXu5sSVA0O39k69GEG/jke821e/l6a76ry1KbxdjCdZd3dOHHmxmclW3nWSjOL3CyrpsMcKBb4VtgUo4UguUTVBgZrQrdAsMNvYHE3w8TIsFtSFhP2TITCoT5yQ==
Received: from DM6PR06CA0002.namprd06.prod.outlook.com (2603:10b6:5:120::15)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 07:10:31 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::64) by DM6PR06CA0002.outlook.office365.com
 (2603:10b6:5:120::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 07:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 07:10:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 00:10:16 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 13 Jul 2023 00:10:12 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <roopa@nvidia.com>,
	<dsahern@gmail.com>, <petrm@nvidia.com>, <taspelund@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [RFC PATCH net-next 2/4] vxlan: Add support for nexthop ID metadata
Date: Thu, 13 Jul 2023 10:09:23 +0300
Message-ID: <20230713070925.3955850-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0870c6-11c1-4e64-648d-08db83703ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AZEz7fT6oLwGKdc/q8tWbn3+5mgP0bAovK6r9iUnnqSASd8sbFNOwI12+qU7PDsgeRs5TBWqGcR5Cf9L3FUFDS/O9UoO0K0tg3AZb+2qcSg6c+pJuySvLW26GoNufSEuBJHsvOSdWVXeFEJSW+tWMuoF6hgTXYvP7ziXyb73OBdCqh50eu1IEJ6xOgmukcID4JEdldo0n3G6jv+UgClEjX9Pp/Jmjc/wCgy7RGGwldU0xbbTdfy0a8EbWVfEb1poCkdAAAxCylB13Tv39Se4v6SaL7PmjoJwDNibrOJ0PP6udD8waaxWz4XEz+4P8R9AyVNN3pPfyusOk/zuzWQE0uSUiKmIp5qU66mrJrffTSRKOP2wkly2krQ6n9fqIJ/GyjfVxXCQEkbZgCL+hhhj5KKcxI/WPPbOOrbuPAA2ejZAWAwyTtBVk4A+zIOFe8a7BPrUORTEOIYduFNhTREpJrSxo6rXKbUwE+0tibiVhCVEXGOnDE+0iWuosLzTubABhRukLRMZHiBwk8Q7aSyXWjWTWzzdfhM1f212uRD3kQoIEb3cRGZv85A1X0Frkc5iAwqKExSvBz6ZKZp/Ce8WVReHONoOrDr6FYHOAeLXAUNHimmkd09bsSzS0n/XQtSRJCCEO4uY+J6iM4APO3edzzjbjPvWoV4H0RRV/578Zu3htzwnUW386XvdJBKUz1Ygj8QyuWpDkFHssNEIGAE4rY9/YtaWPLfAqqIzEu1CJvw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(82310400005)(82740400003)(40460700003)(40480700001)(36756003)(336012)(54906003)(110136005)(70586007)(70206006)(6666004)(356005)(7636003)(2616005)(36860700001)(107886003)(26005)(1076003)(16526019)(186003)(5660300002)(83380400001)(2906002)(8936002)(4326008)(8676002)(47076005)(478600001)(41300700001)(426003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:10:31.7143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0870c6-11c1-4e64-648d-08db83703ef2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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


