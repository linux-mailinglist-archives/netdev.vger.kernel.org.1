Return-Path: <netdev+bounces-17650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB075282A
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6281C21325
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76531F92F;
	Thu, 13 Jul 2023 16:16:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916341F92B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF76E74
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUy4tN7wN7c8UyfvepIN1tFFUiPHLc/Ase78WLGmQI5cj54sHSe1U00NDayA1utT4EB0HCPJEYxYBsHLliAYXOaC0NFOWlLkmasDVa06MoI6Yo8uMLbGfYjZ4V2hehmYxQeYZxyMPIo69v4wQ4GEt/E0Hy1Hr9T2ScoNxYtOgffHvIZTR7Qd7w40ns+QZSk2UwAwufDYqNzc5BkjNDDB/R3q8qUgEcVphb9cJ/vUFiZI1TtjvCPzrDQ9GqAWR7S4ZVFC918D5hS48rG9t4nFbH/gm38oOsk/WmF2bj+e7OhKzMSy0fOruzjMG5b4Mj6HKYczVBODnUUsGtaYtBi2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rlj87rezkz2Cho8i+lJgGx5l3mJm0QwKbA5Hi9zNyzM=;
 b=Drk/oibyj+dhb9eKFJdma0DZv50eXf1mux8H4mqGhRNSFmR9Io7GWW+YNThL1DhsUOSg7HcicjtjELrQO2i2RGilfZUyYOw/aFkRw0TsGAazoJKGaKBuZTJDYaT5AkCtqlXbPk7Oq3ifeRazNMno9lcgSlEaOl3zZNAzOQBWwi0Mc3FnT7eTpJmc630OgSaXKaQ+2mQ2HVbbOBDk/Kl7RZGGPN08g+yLQOw9efEjrJRmOmqHOuxhG7G9bwXT4gHpmqgpT8XBK7bHoNRFqdXnh2omIVCr8QFb+R3SryTzCACX+tjrxjQHjHZ8P+38kCTV+7VM5O1HQDmb5uaTZp7LOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rlj87rezkz2Cho8i+lJgGx5l3mJm0QwKbA5Hi9zNyzM=;
 b=sMD22NO6Ia1M1YT3Tb90c6A7ZfeWBDOi0cHuDHNUZMRS3SgyF5I09XBX+N71bxetW2N+ZWx6Hl8a0BGvqkCJs5w6e3TTegF3YFn/nYWnrio8JHAjBYQn5V4rSLcCThDtHuszyFwvAkij2BXT3AH0AUkrwmZ/hJhmUkhRsZ7YHg+TXHXzFWVhOO6/mII3gJERPxMlak9EmsMGGtqYLb6GMPAi4eUaHgxWyGpqoiQSbEEVk5khhyIWcnn5T+/zV789mSWtRp9Cy1TIibFrCzfZ1Dc3t5tJpfwsYKAW1sIfM69z5bgdifL0JD3adQNlYibuCC+gFrGN3Mv3896f/cWmgQ==
Received: from BN9PR03CA0108.namprd03.prod.outlook.com (2603:10b6:408:fd::23)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 16:16:33 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::7c) by BN9PR03CA0108.outlook.office365.com
 (2603:10b6:408:fd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:17 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:14 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 06/11] mlxsw: spectrum_switchdev: Manage RIFs on PVID change
Date: Thu, 13 Jul 2023 18:15:29 +0200
Message-ID: <892cf8137e4a84da23cbb6f8f0cbdd1b3f31139b.1689262695.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689262695.git.petrm@nvidia.com>
References: <cover.1689262695.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|BY5PR12MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe1311d-39d3-4357-7088-08db83bc8605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WiabQhw7Q98GWAKYHCCmtqijnEdHxuLTzsMxOwROIJm57MI90l7W9Wgwt8xmp68Qw+mvX+ViFBSA/RWU0NVE6+G0WqjwsupQt3V+G8+ptOxIeDQw55EdglldIvTw1FhkIY65PSq/JMQ/1Fw9R3yXyvmhAwxciZ3zCdLnvsYl9GdRgT8ClmrnQfai7kz7WPmuKk404lPirW2AeEtoPcJlvIAFRyTqCioOqqs8rVyyXtFAeHOMaBwixlkNf1fg6+w5k2RmfO9jD0HY0wN3jOc277voBv7HfsOJWMcWqEoQit0gWk9VvYmUyUaTm748tckulq2raR2MKKxOOMPaOziQRrtQqzPSyD6mBhrI5VLwHunTFiQOf+Sakz+r0MIdgyPqlQEcZIwgkAIUCzrsLGDq2W082c2XT15mN4qfX0hxBHgheELp6f9qaATsFwxbaJOKpQ3fe1Xc1xF1MQb3BdjzHJ3vcAWcL5AXJSRAc3r5EsprRn02IMyDjCBW7FiS2c6yi8Q1OLWZshrb8FMCbpIoaEuGz1ec6+ZBkf58EkTSoJRVRMdFJmCqhsnMFcwStMcs8TTxJaWn/u55uvXJMR1IeRh4LiiE3yprk9N3zYwHDiBhJmuC7Q4bKa3kyq9FbsJJYjWhhQY2W6ltgniYi94NTqs+I/zzX3uOHC2t7WR8RjO0PWWl/BRnYJdJgFh0oN1ApLx7zs8tAYRkexViF25fhAuKDajdkXcGCPCdjuPe/vaS4a3dywuMKirWOhoPBM+S
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(478600001)(82740400003)(356005)(7636003)(4326008)(86362001)(6666004)(54906003)(110136005)(70206006)(70586007)(316002)(83380400001)(36860700001)(41300700001)(47076005)(66574015)(426003)(336012)(2906002)(36756003)(2616005)(8676002)(8936002)(40460700003)(107886003)(26005)(16526019)(5660300002)(40480700001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:32.6619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe1311d-39d3-4357-7088-08db83bc8605
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, mlxsw has several shortcomings with regards to RIF handling due
to PVID changes:

- In order to cause RIF for a bridge device to be created, the user is
  expected first to set PVID, then to add an IP address. The reverse
  ordering is disallowed, which is not very user-friendly.

- When such bridge gets a VLAN upper whose VID was the same as the existing
  PVID, and this VLAN netdevice gets an IP address, a RIF is created for
  this netdevice. The new RIF is then assigned to the 802.1Q FID for the
  given VID. This results in a working configuration. However, then, when
  the VLAN netdevice is removed again, the RIF for the bridge itself is
  never reassociated to the VLAN.

- PVID cannot be changed once the bridge has uppers. Presumably this is
  because the driver does not manage RIFs properly in face of PVID changes.
  However, as the previous point shows, it is still possible to get into
  invalid configurations.

In this patch, add the logic necessary for creation of a RIF as a result of
PVID change. Moreover, when a VLAN upper is created whose VID matches lower
PVID, do not create RIF for this netdevice.

These changes obviate the need for ordering of IP address additions and
PVID configuration, so stop forbidding addition of an IP address to a
PVID-less bridge. Instead, bail out quietly. Also stop preventing PVID
changes when the bridge has uppers.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 119 +++++++++++++++++-
 .../ethernet/mellanox/mlxsw/spectrum_router.h |   4 +
 .../mellanox/mlxsw/spectrum_switchdev.c       |  34 ++---
 3 files changed, 128 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 63f40d16be3b..109ac2db0d65 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8411,6 +8411,110 @@ void mlxsw_sp_rif_destroy_by_dev(struct mlxsw_sp *mlxsw_sp,
 	mutex_unlock(&mlxsw_sp->router->lock);
 }
 
+static void mlxsw_sp_rif_destroy_vlan_upper(struct mlxsw_sp *mlxsw_sp,
+					    struct net_device *br_dev,
+					    u16 vid)
+{
+	struct net_device *upper_dev;
+	struct mlxsw_sp_crif *crif;
+
+	rcu_read_lock();
+	upper_dev = __vlan_find_dev_deep_rcu(br_dev, htons(ETH_P_8021Q), vid);
+	rcu_read_unlock();
+
+	if (!upper_dev)
+		return;
+
+	crif = mlxsw_sp_crif_lookup(mlxsw_sp->router, upper_dev);
+	if (!crif || !crif->rif)
+		return;
+
+	mlxsw_sp_rif_destroy(crif->rif);
+}
+
+static int mlxsw_sp_inetaddr_bridge_event(struct mlxsw_sp *mlxsw_sp,
+					  struct net_device *l3_dev,
+					  int lower_pvid,
+					  unsigned long event,
+					  struct netlink_ext_ack *extack);
+
+int mlxsw_sp_router_bridge_vlan_add(struct mlxsw_sp *mlxsw_sp,
+				    struct net_device *br_dev,
+				    u16 new_vid, bool is_pvid,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_rif *old_rif;
+	struct mlxsw_sp_rif *new_rif;
+	struct net_device *upper_dev;
+	u16 old_pvid = 0;
+	u16 new_pvid;
+	int err = 0;
+
+	mutex_lock(&mlxsw_sp->router->lock);
+	old_rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, br_dev);
+	if (old_rif) {
+		/* If the RIF on the bridge is not a VLAN RIF, we shouldn't have
+		 * gotten a PVID notification.
+		 */
+		if (WARN_ON(old_rif->ops->type != MLXSW_SP_RIF_TYPE_VLAN))
+			old_rif = NULL;
+		else
+			old_pvid = mlxsw_sp_fid_8021q_vid(old_rif->fid);
+	}
+
+	if (is_pvid)
+		new_pvid = new_vid;
+	else if (old_pvid == new_vid)
+		new_pvid = 0;
+	else
+		goto out;
+
+	if (old_pvid == new_pvid)
+		goto out;
+
+	if (new_pvid) {
+		struct mlxsw_sp_rif_params params = {
+			.dev = br_dev,
+			.vid = new_pvid,
+		};
+
+		/* If there is a VLAN upper with the same VID as the new PVID,
+		 * kill its RIF, if there is one.
+		 */
+		mlxsw_sp_rif_destroy_vlan_upper(mlxsw_sp, br_dev, new_pvid);
+
+		if (mlxsw_sp_dev_addr_list_empty(br_dev))
+			goto out;
+		new_rif = mlxsw_sp_rif_create(mlxsw_sp, &params, extack);
+		if (IS_ERR(new_rif)) {
+			err = PTR_ERR(new_rif);
+			goto out;
+		}
+
+		if (old_pvid)
+			mlxsw_sp_rif_migrate_destroy(mlxsw_sp, old_rif, new_rif,
+						     true);
+	} else {
+		mlxsw_sp_rif_destroy(old_rif);
+	}
+
+	if (old_pvid) {
+		rcu_read_lock();
+		upper_dev = __vlan_find_dev_deep_rcu(br_dev, htons(ETH_P_8021Q),
+						     old_pvid);
+		rcu_read_unlock();
+		if (upper_dev)
+			err = mlxsw_sp_inetaddr_bridge_event(mlxsw_sp,
+							     upper_dev,
+							     new_pvid,
+							     NETDEV_UP, extack);
+	}
+
+out:
+	mutex_unlock(&mlxsw_sp->router->lock);
+	return err;
+}
+
 static void
 mlxsw_sp_rif_subport_params_init(struct mlxsw_sp_rif_params *params,
 				 struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan)
@@ -8847,13 +8951,20 @@ static int mlxsw_sp_inetaddr_bridge_event(struct mlxsw_sp *mlxsw_sp,
 				return -EOPNOTSUPP;
 			}
 			err = br_vlan_get_pvid(l3_dev, &params.vid);
-			if (err < 0 || !params.vid) {
-				NL_SET_ERR_MSG_MOD(extack, "Couldn't determine bridge PVID");
-				return -EINVAL;
-			}
+			if (err)
+				return err;
+			if (!params.vid)
+				return 0;
 		} else if (is_vlan_dev(l3_dev)) {
 			params.vid = vlan_dev_vlan_id(l3_dev);
+
+			/* If the VID matches PVID of the bridge below, the
+			 * bridge owns the RIF for this VLAN. Don't do anything.
+			 */
+			if ((int)params.vid == lower_pvid)
+				return 0;
 		}
+
 		rif = mlxsw_sp_rif_create(mlxsw_sp, &params, extack);
 		if (IS_ERR(rif))
 			return PTR_ERR(rif);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
index 9a2669a08480..74242220a0cf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
@@ -171,6 +171,10 @@ int mlxsw_sp_ipip_ecn_encap_init(struct mlxsw_sp *mlxsw_sp);
 int mlxsw_sp_ipip_ecn_decap_init(struct mlxsw_sp *mlxsw_sp);
 struct net_device *
 mlxsw_sp_ipip_netdev_ul_dev_get(const struct net_device *ol_dev);
+int mlxsw_sp_router_bridge_vlan_add(struct mlxsw_sp *mlxsw_sp,
+				    struct net_device *dev,
+				    u16 new_vid, bool is_pvid,
+				    struct netlink_ext_ack *extack);
 int mlxsw_sp_router_port_join_lag(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct net_device *lag_dev,
 				  struct netlink_ext_ack *extack);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index a3365f7437d6..79d45c6c6edf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1479,30 +1479,15 @@ mlxsw_sp_bridge_port_vlan_add(struct mlxsw_sp_port *mlxsw_sp_port,
 }
 
 static int
-mlxsw_sp_br_ban_rif_pvid_change(struct mlxsw_sp *mlxsw_sp,
-				const struct net_device *br_dev,
-				const struct switchdev_obj_port_vlan *vlan,
-				struct netlink_ext_ack *extack)
+mlxsw_sp_br_rif_pvid_change(struct mlxsw_sp *mlxsw_sp,
+			    struct net_device *br_dev,
+			    const struct switchdev_obj_port_vlan *vlan,
+			    struct netlink_ext_ack *extack)
 {
-	u16 pvid;
+	bool flag_pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 
-	pvid = mlxsw_sp_rif_vid(mlxsw_sp, br_dev);
-	if (!pvid)
-		return 0;
-
-	if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
-		if (vlan->vid != pvid) {
-			NL_SET_ERR_MSG_MOD(extack, "Can't change PVID, it's used by router interface");
-			return -EBUSY;
-		}
-	} else {
-		if (vlan->vid == pvid) {
-			NL_SET_ERR_MSG_MOD(extack, "Can't remove PVID, it's used by router interface");
-			return -EBUSY;
-		}
-	}
-
-	return 0;
+	return mlxsw_sp_router_bridge_vlan_add(mlxsw_sp, br_dev, vlan->vid,
+					       flag_pvid, extack);
 }
 
 static int mlxsw_sp_port_vlans_add(struct mlxsw_sp_port *mlxsw_sp_port,
@@ -1519,9 +1504,8 @@ static int mlxsw_sp_port_vlans_add(struct mlxsw_sp_port *mlxsw_sp_port,
 		int err = 0;
 
 		if (br_vlan_enabled(orig_dev))
-			err = mlxsw_sp_br_ban_rif_pvid_change(mlxsw_sp,
-							      orig_dev, vlan,
-							      extack);
+			err = mlxsw_sp_br_rif_pvid_change(mlxsw_sp, orig_dev,
+							  vlan, extack);
 		if (!err)
 			err = -EOPNOTSUPP;
 		return err;
-- 
2.40.1


