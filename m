Return-Path: <netdev+bounces-17646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD8752824
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0401C2140D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566B01F17E;
	Thu, 13 Jul 2023 16:16:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62B1F176
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC9BE74
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj9J9jIhIuis11PTd/NjblPN+6hF/EuJX8Rt7oWyeNi638omVqEU9Qjmec7+CNfMebnK2W9vbhzgub2NErTVHAIb37U89OKujeR1FFo3s/3wDtxeIyHec3tXPJvnetYUUjCxRuBBkH2sMNe/oJzPknfds23q9UJsKcGudDEI24Hm+2xgmvYtZuQlliAXMRtXhbslsPUS6ACFtQ/PfFjOryBPAAb0TKXvK2Mnx9vRartVsBgVc0RnOspdrybRJOqrLwbtb9aWoaKTU1IzxTTJQxmm6DaVzRdqURef1ZTkOFGy9V+M8SKdlQV/z+Cac38cxwSMsBy7M+ENDuD/MOQL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzVhwATNr33ddQPnjbnRwYSdesLDzEu5E4VDeuhd+LA=;
 b=MeYNLuDPTbBn5qkN/Q1h52AScN65ViG+rKQOxXTdBkJ+XH1iEwL5ZzQn5EHnR0FAzlVcYqlJIzDr/XbMxmplDTwdO248PT4CY4KvSrfmsER5zdmKC2hB5nYEblpcqm2vdysryPzkRR4dppscuFwN6ooVW8iRUK2ipKJaz+YxywphoX47wccc4LlmFg0kqoyBxsiT9X21bL5IOp4UWToj1KmxRykxDgVs5Tn15yUICNWuF0gxiwtcAApL9hvsQOqojdEVl9shZUDVx77fnUftz31s44IF9/WR/29kZGgsjBNcCs0gUVK2EDlDs1ZHqcPx01GbUtlnK0wRCoH4o8/GIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzVhwATNr33ddQPnjbnRwYSdesLDzEu5E4VDeuhd+LA=;
 b=nCh9B9Ho/oGz5HkH3zWN1WZeBpckjbi7XAgaaVlFLCSk/k+vsr9OIqr//uMfq2RIHEOJq9cWth835+2MDQJket5vySSLwK/9p96+nhVhAeNIjYWMA1LatwRBNnRyHMjgjtRil8qded78fd7JGuazx/KBMCe6tKKvjiZIFs5p42mP53xUjKKghwQqcVoIgX7sp4CvmbXhsG9tI68nlefMb4yh6hKzua+6VdkR6JatGP/YbHgnepTBAjXnCEnxKOU2XR4IUos7eRxeUUQeKejhcbZnm+g/chydWU51hOyst7/p+KN2ODiSmkv0hIn9S0s050jnrU7XsuZKGh6zd35jRg==
Received: from BN0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:408:ec::33)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 16:16:23 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::d4) by BN0PR04CA0118.outlook.office365.com
 (2603:10b6:408:ec::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 16:16:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:09 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:06 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/11] mlxsw: spectrum_router: Take VID for VLAN FIDs from RIF params
Date: Thu, 13 Jul 2023 18:15:26 +0200
Message-ID: <3f8afcd841425ed5d11b71f2952e79b76b34307b.1689262695.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de78ce2-7116-4035-adb7-08db83bc7fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rDfIaijNQcng0UvvE92lru+xPruf6w2F7Bivvu5bawd6I+HNxVTZfY1ebmdlj+tIVM8f4sfP7YcVSWIiT60ep1s8Zq4LWxeprR5Ba6ZBfSt8xO1LBNvN63wLK+QysY5qn3vpVW3f8jR0Llw00vhZIytUFeJbQC54k8Rh8iCYTS8hRPigWXKisHfbQgO7H374l4ZR1oQe8ULG1frw2K5nsMUECbLENT52S2G+YJI3xj4mYYZGdttEXcCEibhcDGhRmVM9/SVNfFZoQkvBNCWYFx+JoDUsXhu7Tojx4tSCIJX1enENxu3hs9cLkFxL31Q11qkpExKTeKxY421+l4LnZyuClj/Fw8xzuqmrftpc+GtxJmZYYXEd0j76W2XZbG+SdwP4U55XkmcWJFHOzWubHyU9DS8QHYFRtkKu3e2KTavALLQw+RPuRK3Q39yIL22j9nY3ZM95abAFFlKQcZ0sf6O678AH49KCXIK5YzlCWh5tG9+Wl4RnocObhB6Q7BzhkkanBpscjgdVOtifIG/x65lu0RP3/oA+fq0ry0MisBUExJtk3e9eInbSp87eZhPumcnVV4JprU1LnMBUhTyrwUPctpAMHp6jst5bFYCYGTeo0A/NwGjeVBOakxS2X6L3g5M4CpQ2wpJI16s4cvruF/GAzOWqiv8XRwfzeDNHm409RBMR+t+mSO+nbYCgS7Cd3OGLkdUJO5yQQOdNmgkD0pUteKBWBV67iqje2a9uOTbnUbrN3yxTQ3R9RSc/x8rF
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(110136005)(54906003)(186003)(16526019)(336012)(4326008)(70586007)(70206006)(82310400005)(41300700001)(66899021)(478600001)(316002)(6666004)(8936002)(8676002)(40460700003)(107886003)(40480700001)(86362001)(26005)(5660300002)(83380400001)(36860700001)(47076005)(7636003)(2906002)(82740400003)(36756003)(2616005)(356005)(66574015)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:22.2997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de78ce2-7116-4035-adb7-08db83bc7fda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, when an IP address is added to a bridge that has no PVID, the
operation is rejected. An IP address addition is interpreted as a request
to create a RIF for the bridge device, but without a PVID there is no VLAN
for which the RIF should be created. Thus the correct way to create a RIF
for a bridge as a user is to first add a PVID, and then add the IP address.

Ideally this ordering requirement would not exist. RIF would be created
either because an IP address is added, or because a PVID is added,
depending on which comes last.

For that, the switchdev code (which notices the PVID change request) must
be able to request that a RIF is created with a given VLAN ID, because at
the time that the PVID notification is distributed, the PVID setting is not
yet visible for querying.

Therefore when creating a VLAN-based RIF, use mlxsw_sp_rif_params.vid to
communicate the VID, and do not determine it ad-hoc in the fid_get
callback.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index adfb1ef2a664..e840ca9a9673 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8665,14 +8665,17 @@ __mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
 {
 	struct mlxsw_sp_port *mlxsw_sp_port = mlxsw_sp_port_vlan->mlxsw_sp_port;
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
-	struct mlxsw_sp_rif_params params = {
-		.dev = l3_dev,
-	};
+	struct mlxsw_sp_rif_params params;
 	u16 vid = mlxsw_sp_port_vlan->vid;
 	struct mlxsw_sp_rif *rif;
 	struct mlxsw_sp_fid *fid;
 	int err;
 
+	params = (struct mlxsw_sp_rif_params) {
+		.dev = l3_dev,
+		.vid = vid,
+	};
+
 	mlxsw_sp_rif_subport_params_init(&params, mlxsw_sp_port_vlan);
 	rif = mlxsw_sp_rif_subport_get(mlxsw_sp, &params, extack);
 	if (IS_ERR(rif))
@@ -8830,6 +8833,7 @@ static int mlxsw_sp_inetaddr_bridge_event(struct mlxsw_sp *mlxsw_sp,
 		.dev = l3_dev,
 	};
 	struct mlxsw_sp_rif *rif;
+	int err;
 
 	switch (event) {
 	case NETDEV_UP:
@@ -8841,6 +8845,13 @@ static int mlxsw_sp_inetaddr_bridge_event(struct mlxsw_sp *mlxsw_sp,
 				NL_SET_ERR_MSG_MOD(extack, "Adding an IP address to 802.1ad bridge is not supported");
 				return -EOPNOTSUPP;
 			}
+			err = br_vlan_get_pvid(l3_dev, &params.vid);
+			if (err < 0 || !params.vid) {
+				NL_SET_ERR_MSG_MOD(extack, "Couldn't determine bridge PVID");
+				return -EINVAL;
+			}
+		} else if (is_vlan_dev(l3_dev)) {
+			params.vid = vlan_dev_vlan_id(l3_dev);
 		}
 		rif = mlxsw_sp_rif_create(mlxsw_sp, &params, extack);
 		if (IS_ERR(rif))
@@ -9877,23 +9888,17 @@ mlxsw_sp_rif_vlan_fid_get(struct mlxsw_sp_rif *rif,
 {
 	struct net_device *dev = mlxsw_sp_rif_dev(rif);
 	struct net_device *br_dev;
-	u16 vid;
-	int err;
+
+	if (WARN_ON(!params->vid))
+		return ERR_PTR(-EINVAL);
 
 	if (is_vlan_dev(dev)) {
-		vid = vlan_dev_vlan_id(dev);
 		br_dev = vlan_dev_real_dev(dev);
 		if (WARN_ON(!netif_is_bridge_master(br_dev)))
 			return ERR_PTR(-EINVAL);
-	} else {
-		err = br_vlan_get_pvid(dev, &vid);
-		if (err < 0 || !vid) {
-			NL_SET_ERR_MSG_MOD(extack, "Couldn't determine bridge PVID");
-			return ERR_PTR(-EINVAL);
-		}
 	}
 
-	return mlxsw_sp_fid_8021q_get(rif->mlxsw_sp, vid);
+	return mlxsw_sp_fid_8021q_get(rif->mlxsw_sp, params->vid);
 }
 
 static void mlxsw_sp_rif_vlan_fdb_del(struct mlxsw_sp_rif *rif, const char *mac)
-- 
2.40.1


