Return-Path: <netdev+bounces-18959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B07593AD
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D631C20F17
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6BF12B91;
	Wed, 19 Jul 2023 11:02:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AA134B4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::627])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E296186
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0UkfdvgYmeAJkVM3Yj36f+p2aMksUb2ygv4fpdoL8pte1bofsIbsWA2/1IVUGlrbrtAdzpCnkbpEnT+n/L7q6IC8L6HHVMBLUxyQCIcn+sG/PbB56xacgdmVsgrLHJD98S1LHBG3VbFMmesnVomIGE01QbUldyYeObFgOReLMUdU2y88XawYFzdq3jhuKYVcMKM26AS+Qc//4sgUUqr+bYhsq9J819EF/02wwu7SSO0mPH9ddLOvQSzHx8g7Njlpq5RCeOfXDDv4mbLuEFMUrBCq2nMLuAYYOz/TEwLPJyBjDPiaXZrCtJjMQJ6AfXdj5W3pJvTyYtdIcztn9CPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB8e3fl+qH43yTbBUm903A/vvhYdYzAT8Rcgukv82M0=;
 b=ZsoaqvC7TiEFCpALv3Q8qLMoR3dyfvKKW6P3our2Ir8zJtu9+7zUKm3+DcX6oFywaGRl7Ff96tOvh18ba1/0HDGKFy/jVuFfpJC3PLmKaiK+wV2rqlQiH+S2UqpaRs+xwoBHFpSiWtJOtRWTX+yVzkkj759c/5i5qfHUjgqYpkZWTG5kzGFfHTNdFRH7zbWYwYY/agicd/vVEolMTXsGwpGPT61ZFdcQbK9mq2SB6PLPkI6qIOPXZm0lpzBWVAG3QaGfGo6goMm8S/N8jcyKZlzXd4z/ALZHBpIq2OigvYOTIedAeMQjtINtbSqywTvtpulHCWwG+JEgGUEMj5QNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB8e3fl+qH43yTbBUm903A/vvhYdYzAT8Rcgukv82M0=;
 b=YPtKZranlYhhPWqbKTIbO1i7u2fLBT9fRwps8Szc7FegAl3yZgkPC1au9D56a918bBK/EdLreezmSpSYbJ/rZNRM6Et1of6Zqss63YOoNkFTTOmoOAdLP/BHDo9MPxatHTzovHoGtYc2PYWW52rUo2Ou9kt0xbSSajM6neyykvVdaZ7D0JB2aczcYR9XVfgrnQu44DYbwjwuXXfk1QtUCNdcjBtUyQC2dpedmoF3oEpYe1WqmXInJ8qGyUNXi+j261V9YObYCcJO5N+DvnEI1gkKz+YrKGUGz6f0Dh3mX10EFEoNK0dz7Y85b5vi7Ow83P4n3MKc2zYs6G2/NiGMCg==
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 11:02:23 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::f5) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:08 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:06 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 04/17] mlxsw: spectrum_router: Allow address handlers to run on bridge ports
Date: Wed, 19 Jul 2023 13:01:19 +0200
Message-ID: <2f0e4e83e827bd0e55f6df1ebb53355d06374409.1689763088.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 992647b2-7a95-4466-9233-08db8847a133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zy7ndKUR1fPPVVepBw9G4GeaX9NpkKgorseylAVM1GKBJ6RjqwSPIy5xs+BgyFqxnq3dKSMvQ0DjuJew9e4r/xzG4JurxPMph0CKMaX+DXjka867UWeyFHa4dur85syKC61s5D+rvXhZauj21/hTUwF0a+wDYg+WNkMF5QLOc/JHMwAanma/Yo+DE2/ecmy6kyvOAwl+hQA4+aGlKHgex7NQSW1kuV0IqOBeQr2pd632KhE396+9sEkaoUDzB2qc7nHNXp9hbHq9Z/Xx5Tzq5BeGmjVerMrFcG1GFqIxP2wwsYhhC5gE0SMDg8rXEIkc+wfou1w6N9rOTIycyeZVRq7xkisBULYwJwnMMEtwbNf4u7zXAvwsmRiFjHBF+fuin5wbAempEIvKS8eMAnot2aYR5/gVBahzc3KePtIoMJXxB5cTEPfkFlzuqGQMsDvU9vLbzrOEvCcMbokLqFvpI1DOXZc9y77pOEpLPK/ZLVhTgEhfMYZEKYrDT4voP/YH374EUyZ8DLXv4PSOMJECyzVt0W+hV1sNwTnqFHoGE0sBSMubIDCdDxtjQcenQ4Urad9GawP+ZswNEYWqH+fY3kEa0SZc6xUQeynLA8dLpb3wqCbHDoHFpKufhwkG2+kYX+Saop8C/lqeiw4lcSVn6mma0J1+qtzh/7VrO3m5x8CfU94YDh53Pp6MUo0y0wULi9UdGyh6AIaR5yrp+i3ZeZg9VMST6SKrP9XRiMLmwIXUok29nwPWdlAoq1IXvOOp
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(4326008)(54906003)(6666004)(478600001)(110136005)(82740400003)(2616005)(36860700001)(83380400001)(426003)(47076005)(40460700003)(86362001)(66574015)(40480700001)(356005)(2906002)(70586007)(186003)(16526019)(107886003)(26005)(316002)(7636003)(336012)(70206006)(41300700001)(36756003)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:22.9749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992647b2-7a95-4466-9233-08db8847a133
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently the IP address event handlers bail out when the event is related
to a netdevice that is a bridge port or a member of a LAG. In order to
create a RIF when a bridged or LAG'd port is unenslaved, these event
handlers will be replayed. However, at the point in time when the
NETDEV_CHANGEUPPER event is delivered, informing of the loss of
enslavement, the port is still formally enslaved.

In order for the operation to have any effect, these handlers need an extra
parameter to indicate that the check for bridge or LAG membership should
not be done. In this patch, add an argument "nomaster" to several event
handlers.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 41 +++++++++++--------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 109ac2db0d65..6b1b142c95db 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8884,10 +8884,11 @@ static int mlxsw_sp_inetaddr_port_vlan_event(struct net_device *l3_dev,
 }
 
 static int mlxsw_sp_inetaddr_port_event(struct net_device *port_dev,
-					unsigned long event,
+					unsigned long event, bool nomaster,
 					struct netlink_ext_ack *extack)
 {
-	if (netif_is_any_bridge_port(port_dev) || netif_is_lag_port(port_dev))
+	if (!nomaster && (netif_is_any_bridge_port(port_dev) ||
+			  netif_is_lag_port(port_dev)))
 		return 0;
 
 	return mlxsw_sp_inetaddr_port_vlan_event(port_dev, port_dev, event,
@@ -8918,10 +8919,10 @@ static int __mlxsw_sp_inetaddr_lag_event(struct net_device *l3_dev,
 }
 
 static int mlxsw_sp_inetaddr_lag_event(struct net_device *lag_dev,
-				       unsigned long event,
+				       unsigned long event, bool nomaster,
 				       struct netlink_ext_ack *extack)
 {
-	if (netif_is_bridge_port(lag_dev))
+	if (!nomaster && netif_is_bridge_port(lag_dev))
 		return 0;
 
 	return __mlxsw_sp_inetaddr_lag_event(lag_dev, lag_dev, event,
@@ -8980,7 +8981,7 @@ static int mlxsw_sp_inetaddr_bridge_event(struct mlxsw_sp *mlxsw_sp,
 
 static int mlxsw_sp_inetaddr_vlan_event(struct mlxsw_sp *mlxsw_sp,
 					struct net_device *vlan_dev,
-					unsigned long event,
+					unsigned long event, bool nomaster,
 					struct netlink_ext_ack *extack)
 {
 	struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
@@ -8988,7 +8989,7 @@ static int mlxsw_sp_inetaddr_vlan_event(struct mlxsw_sp *mlxsw_sp,
 	u16 lower_pvid;
 	int err;
 
-	if (netif_is_bridge_port(vlan_dev))
+	if (!nomaster && netif_is_bridge_port(vlan_dev))
 		return 0;
 
 	if (mlxsw_sp_port_dev_check(real_dev)) {
@@ -9132,19 +9133,21 @@ static int mlxsw_sp_inetaddr_macvlan_event(struct mlxsw_sp *mlxsw_sp,
 
 static int __mlxsw_sp_inetaddr_event(struct mlxsw_sp *mlxsw_sp,
 				     struct net_device *dev,
-				     unsigned long event,
+				     unsigned long event, bool nomaster,
 				     struct netlink_ext_ack *extack)
 {
 	if (mlxsw_sp_port_dev_check(dev))
-		return mlxsw_sp_inetaddr_port_event(dev, event, extack);
+		return mlxsw_sp_inetaddr_port_event(dev, event, nomaster,
+						    extack);
 	else if (netif_is_lag_master(dev))
-		return mlxsw_sp_inetaddr_lag_event(dev, event, extack);
+		return mlxsw_sp_inetaddr_lag_event(dev, event, nomaster,
+						   extack);
 	else if (netif_is_bridge_master(dev))
 		return mlxsw_sp_inetaddr_bridge_event(mlxsw_sp, dev, -1, event,
 						      extack);
 	else if (is_vlan_dev(dev))
 		return mlxsw_sp_inetaddr_vlan_event(mlxsw_sp, dev, event,
-						    extack);
+						    nomaster, extack);
 	else if (netif_is_macvlan(dev))
 		return mlxsw_sp_inetaddr_macvlan_event(mlxsw_sp, dev, event,
 						       extack);
@@ -9171,7 +9174,8 @@ static int mlxsw_sp_inetaddr_event(struct notifier_block *nb,
 	if (!mlxsw_sp_rif_should_config(rif, dev, event))
 		goto out;
 
-	err = __mlxsw_sp_inetaddr_event(router->mlxsw_sp, dev, event, NULL);
+	err = __mlxsw_sp_inetaddr_event(router->mlxsw_sp, dev, event, false,
+					NULL);
 out:
 	mutex_unlock(&router->lock);
 	return notifier_from_errno(err);
@@ -9195,7 +9199,8 @@ static int mlxsw_sp_inetaddr_valid_event(struct notifier_block *unused,
 	if (!mlxsw_sp_rif_should_config(rif, dev, event))
 		goto out;
 
-	err = __mlxsw_sp_inetaddr_event(mlxsw_sp, dev, event, ivi->extack);
+	err = __mlxsw_sp_inetaddr_event(mlxsw_sp, dev, event, false,
+					ivi->extack);
 out:
 	mutex_unlock(&mlxsw_sp->router->lock);
 	return notifier_from_errno(err);
@@ -9224,7 +9229,7 @@ static void mlxsw_sp_inet6addr_event_work(struct work_struct *work)
 	if (!mlxsw_sp_rif_should_config(rif, dev, event))
 		goto out;
 
-	__mlxsw_sp_inetaddr_event(mlxsw_sp, dev, event, NULL);
+	__mlxsw_sp_inetaddr_event(mlxsw_sp, dev, event, false, NULL);
 out:
 	mutex_unlock(&mlxsw_sp->router->lock);
 	rtnl_unlock();
@@ -9278,7 +9283,8 @@ static int mlxsw_sp_inet6addr_valid_event(struct notifier_block *unused,
 	if (!mlxsw_sp_rif_should_config(rif, dev, event))
 		goto out;
 
-	err = __mlxsw_sp_inetaddr_event(mlxsw_sp, dev, event, i6vi->extack);
+	err = __mlxsw_sp_inetaddr_event(mlxsw_sp, dev, event, false,
+					i6vi->extack);
 out:
 	mutex_unlock(&mlxsw_sp->router->lock);
 	return notifier_from_errno(err);
@@ -9598,10 +9604,11 @@ static int mlxsw_sp_port_vrf_join(struct mlxsw_sp *mlxsw_sp,
 	 */
 	rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, l3_dev);
 	if (rif)
-		__mlxsw_sp_inetaddr_event(mlxsw_sp, l3_dev, NETDEV_DOWN,
+		__mlxsw_sp_inetaddr_event(mlxsw_sp, l3_dev, NETDEV_DOWN, false,
 					  extack);
 
-	return __mlxsw_sp_inetaddr_event(mlxsw_sp, l3_dev, NETDEV_UP, extack);
+	return __mlxsw_sp_inetaddr_event(mlxsw_sp, l3_dev, NETDEV_UP, false,
+					 extack);
 }
 
 static void mlxsw_sp_port_vrf_leave(struct mlxsw_sp *mlxsw_sp,
@@ -9612,7 +9619,7 @@ static void mlxsw_sp_port_vrf_leave(struct mlxsw_sp *mlxsw_sp,
 	rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, l3_dev);
 	if (!rif)
 		return;
-	__mlxsw_sp_inetaddr_event(mlxsw_sp, l3_dev, NETDEV_DOWN, NULL);
+	__mlxsw_sp_inetaddr_event(mlxsw_sp, l3_dev, NETDEV_DOWN, false, NULL);
 }
 
 static bool mlxsw_sp_is_vrf_event(unsigned long event, void *ptr)
-- 
2.40.1


