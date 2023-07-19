Return-Path: <netdev+bounces-18962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E17593B2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B33A1C20F6A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62ED12B6E;
	Wed, 19 Jul 2023 11:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964D13AE6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56918D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVtllsaV61zO1Uq8fAJwZ0c1NgzyPzMbrHsF87FIfRgjYqef/REZ8V1JWLmt2zrw2nhfT4drzSZuAHbXCvO1gzGad2Ciii1vec6Mdx5GUA50CKn7hsg3uGSZxOwmnMioMGn6zbYs9cZxXKI1SQFDmoiUmkfN6kIvOsnJ83dqLErqs1md+S61OnJMYpH408KBk2oBVD2OQP+F6cXvX3hTQSwsckIGdSKf+GjMgzBIncOK1ySxXIQcXX+l2GjMBmfL/8YeCBBIxlIwr6aQsV1yeMb4ISzHh+Yh6aEioyP0yOQg6N8xjz7HETuF5U596N0ntB8VBVFEYlLkdEv6z+Lnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5tnSeg9y5Bu8DjdrJ+TXcTzKepIqy5K4zDnOiaH0p4=;
 b=Hc/hi2IKCt8AKzD+P/vJDJFEKgfrmWhkdK168GjcK7jWTtWhQPin6Z/mdDsmnvIzQEa6tNZost9DlZhTkVEx8IXAE4Hu/j1Ff7AAwUA50iCKHL+zDiXXTeSdirv7hDyPQLHNC9rp4cZdiPyP6/SUpfFPS6davl3s7ojc0E9AHcmboPWzsDvoVZ3j/sstblXPq8Ux8e8+Z8K6XDA740byAPols9/sBxqbYR97XwtYSXzhlp0BUFXXfu4nYsn5Uslkt4u0/4gFgpW8TplWiZlANNztmrPF66EBxBKNGaJEWZG4ligMdKbUis4yZtAzAmtzhLxYvaQDRvPdTvufYqDvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5tnSeg9y5Bu8DjdrJ+TXcTzKepIqy5K4zDnOiaH0p4=;
 b=rOFcLEmR3LawUtJYCPznrrZir3BHDrorP+11VQvzt78KtHTBaYirIAkuQ5P9d2j17DCYvRJef/X3mA0GE/src5I/qNCKZKYJ1nH9u1ybt7ZdHv7RNrHS4ehSJU1r01gKw1F6UCbHVw9N/tA4Nqp6i0XiyQkBzBj90HS8dK6cmB6Nua9VamUk1wX4SvNJcuckFil7h1BI7I5DjABhw84IszVKBZCoq2+JO2W8J+/hYQZlLV7FVgdjpQMbkMpCzIT8F8rGj86mEzl92JhW4GNgLfMLt5Z++2S+2V6heKQeDBX59YowPlKjmkSJ6GVCWsbTS8ksYLelf1ghqRPbuQRtiw==
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 11:02:30 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::89) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:17 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:14 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 07/17] mlxsw: spectrum: Allow event handlers to check unowned bridges
Date: Wed, 19 Jul 2023 13:01:22 +0200
Message-ID: <ef33b2c960341712310b9448d601c87fb7de6394.1689763088.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a15ae5b-7b06-4b29-5d18-08db8847a568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fVdwYQKBk4OlSSgfLrvGFqE9CBCfF9NGNc5fXaxFFQIIck2rWajZQjlJBRFyGucL7lAIOQ4d2ZXAdcppfIZxJOklDRKVXpp8CDz+LXoi4DcWvo6kAD1eoUtzCmlOTnWbF9KrNXRZQ/w09cEN+cC+BMr4wIMEMC9sStxAl0bLug1DYzYQZJJTQRMK9wk3SgYEvYpUZotP/bcPbUDBRBEFSP1w+NKVAobKZoI89OV/jRVEZcNs/K3bwRj63Lv8tmyXEqJgDxMkCP1JWv/SoYDrTq6l2xG1Yf0/Nl+kt8EZKZlof2BEdC1e/odpa+8dA6b9GU6rpcBv2e0yFeTDMuGDlyL8LoIgUdBLw8fJHPXWibj54eR5GMLygmmZIiKasMa81RD39ENwoAg1nA+QYlflBwXVksgYFXp9KFCbNz1jYsx+55em7Kt5KX/1uq6KPWaIT+KGHPCpJEoJ3iDPXuet0shMIaKsdyrssniMQ2iXogm4gpmTdcbSN47PnLgwPBHYxA25u42Kpl6iH//Mg6TyjIps+ExAKdrSRnPAlthzV1qiziDgMIOMQoOSwk60SSJX5LoS8kM0Vj1jHvrxRUaYUpBsHa3sbJ3ivjVh6dy2dgWclJ3lWm/SN1HMkPb++nnVg1oFF9JsJGBgmWgkth965LiIVdx4MdK2YP0uITHSYXTM9UScRGqvpeQWomuWgXXBAReAdzcbVH++uShMjIrtFWOrQ0vRlB1GiEjbUwpOqbE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(6666004)(478600001)(54906003)(110136005)(336012)(186003)(16526019)(26005)(107886003)(2906002)(82740400003)(316002)(41300700001)(4326008)(70206006)(5660300002)(70586007)(8936002)(8676002)(7636003)(356005)(86362001)(40460700003)(36756003)(36860700001)(426003)(2616005)(83380400001)(47076005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:30.0161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a15ae5b-7b06-4b29-5d18-08db8847a568
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently the bridge-related handlers bail out when the event is related to
a netdevice that is not an upper of one of the front-panel ports. In order
to allow enslavement of front-panel ports to bridges that already have
uppers, it will be necessary to replay CHANGEUPPER events to validate that
the configuration is offloadable. In order for the replay to be effective,
it must be possible to ignore unsupported configuration in the context of
an actual notifier event, but to still "veto" these configurations when the
validation is performed.

To that end, introduce two parameters to a number of handlers: mlxsw_sp,
because it will not be possible to deduce that from the netdevice lowers;
and process_foreign to indicate whether netdevices that are not front panel
uppers should be validated.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 40 +++++++++++--------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 0488fe5695bd..3d1a045ff470 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4936,17 +4936,17 @@ static int mlxsw_sp_netdevice_lag_port_vlan_event(struct net_device *vlan_dev,
 	return 0;
 }
 
-static int mlxsw_sp_netdevice_bridge_vlan_event(struct net_device *vlan_dev,
+static int mlxsw_sp_netdevice_bridge_vlan_event(struct mlxsw_sp *mlxsw_sp,
+						struct net_device *vlan_dev,
 						struct net_device *br_dev,
 						unsigned long event, void *ptr,
-						u16 vid)
+						u16 vid, bool process_foreign)
 {
-	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_lower_get(vlan_dev);
 	struct netdev_notifier_changeupper_info *info = ptr;
 	struct netlink_ext_ack *extack;
 	struct net_device *upper_dev;
 
-	if (!mlxsw_sp)
+	if (!process_foreign && !mlxsw_sp_lower_get(vlan_dev))
 		return 0;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
@@ -4979,8 +4979,10 @@ static int mlxsw_sp_netdevice_bridge_vlan_event(struct net_device *vlan_dev,
 	return 0;
 }
 
-static int mlxsw_sp_netdevice_vlan_event(struct net_device *vlan_dev,
-					 unsigned long event, void *ptr)
+static int mlxsw_sp_netdevice_vlan_event(struct mlxsw_sp *mlxsw_sp,
+					 struct net_device *vlan_dev,
+					 unsigned long event, void *ptr,
+					 bool process_foreign)
 {
 	struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
 	u16 vid = vlan_dev_vlan_id(vlan_dev);
@@ -4993,22 +4995,25 @@ static int mlxsw_sp_netdevice_vlan_event(struct net_device *vlan_dev,
 							      real_dev, event,
 							      ptr, vid);
 	else if (netif_is_bridge_master(real_dev))
-		return mlxsw_sp_netdevice_bridge_vlan_event(vlan_dev, real_dev,
-							    event, ptr, vid);
+		return mlxsw_sp_netdevice_bridge_vlan_event(mlxsw_sp, vlan_dev,
+							    real_dev, event,
+							    ptr, vid,
+							    process_foreign);
 
 	return 0;
 }
 
-static int mlxsw_sp_netdevice_bridge_event(struct net_device *br_dev,
-					   unsigned long event, void *ptr)
+static int mlxsw_sp_netdevice_bridge_event(struct mlxsw_sp *mlxsw_sp,
+					   struct net_device *br_dev,
+					   unsigned long event, void *ptr,
+					   bool process_foreign)
 {
-	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_lower_get(br_dev);
 	struct netdev_notifier_changeupper_info *info = ptr;
 	struct netlink_ext_ack *extack;
 	struct net_device *upper_dev;
 	u16 proto;
 
-	if (!mlxsw_sp)
+	if (!process_foreign && !mlxsw_sp_lower_get(br_dev))
 		return 0;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
@@ -5147,7 +5152,8 @@ static int mlxsw_sp_netdevice_vxlan_event(struct mlxsw_sp *mlxsw_sp,
 }
 
 static int __mlxsw_sp_netdevice_event(struct mlxsw_sp *mlxsw_sp,
-				      unsigned long event, void *ptr)
+				      unsigned long event, void *ptr,
+				      bool process_foreign)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct mlxsw_sp_span_entry *span_entry;
@@ -5166,9 +5172,11 @@ static int __mlxsw_sp_netdevice_event(struct mlxsw_sp *mlxsw_sp,
 	else if (netif_is_lag_master(dev))
 		err = mlxsw_sp_netdevice_lag_event(dev, event, ptr);
 	else if (is_vlan_dev(dev))
-		err = mlxsw_sp_netdevice_vlan_event(dev, event, ptr);
+		err = mlxsw_sp_netdevice_vlan_event(mlxsw_sp, dev, event, ptr,
+						    process_foreign);
 	else if (netif_is_bridge_master(dev))
-		err = mlxsw_sp_netdevice_bridge_event(dev, event, ptr);
+		err = mlxsw_sp_netdevice_bridge_event(mlxsw_sp, dev, event, ptr,
+						      process_foreign);
 	else if (netif_is_macvlan(dev))
 		err = mlxsw_sp_netdevice_macvlan_event(dev, event, ptr);
 
@@ -5183,7 +5191,7 @@ static int mlxsw_sp_netdevice_event(struct notifier_block *nb,
 
 	mlxsw_sp = container_of(nb, struct mlxsw_sp, netdevice_nb);
 	mlxsw_sp_span_respin(mlxsw_sp);
-	err = __mlxsw_sp_netdevice_event(mlxsw_sp, event, ptr);
+	err = __mlxsw_sp_netdevice_event(mlxsw_sp, event, ptr, false);
 
 	return notifier_from_errno(err);
 }
-- 
2.40.1


