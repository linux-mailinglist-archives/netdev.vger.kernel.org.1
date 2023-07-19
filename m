Return-Path: <netdev+bounces-18972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F37593D8
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889141C20CC2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D2514A92;
	Wed, 19 Jul 2023 11:03:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749D12B89
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:03:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D2186
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCpQHspTK0R7N7q58amicWeihM6uOdhJNTDd3l5D/xnzUxpXGTF5HRBa8zJ+EMuEixJCANVRmNzGDfzPWIJ+gsAPe00LkCWqOWC1rYxDhi8P3cfDHqTBcz8qxUy7bZKiMZD7r7ppdDvSG4/5le7yITxl21SgwQlAjF+pynKfI5ClCnmep1lBPVn0zSQsSx4wWd8+Kl3MbLzEysORr6YuGrgO+F8GvDhnpOA6igmOqzbu/ZsHdvjkldFf2h7TJGsXLiYNJjIra9nVx/c0Fr4m6L6tynoLGX8JfxO6NOvMwI5845w1CWeDs+3Kb8ho4KGxh+2kDHkHv66NpWQRCwn91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUypfBwwtTBFuAE60PZafIFUyJAGeoAtkYFOAC5DpuA=;
 b=Z6IKI2Zqz7RO8jGD90NwETDHwtD/zX8yGDfpCUNaUatc9ggvYig/RpR+UGiLrjFrSKK1NzXQVC3P9O26AgTso0Ai7Dxep409w//vaBhgBvTLHf9auaUe2Ah9QptpoiKIUG0t8bHBkiTtn5U2H/b+VoFFUl9O5f0mLaYWOo9+k1ShjXjOMm9dW+r8uSlhGLP15im7o3IFVv3KuFLQyjEU41ZaAQxIcWZ6m6D7Te4TKQeTHxK5uhw1gKv7sG3XQIJa7B1fYGE/HH0aMCXMcX+8PtEhwweeypQwVy51LuklE41TK3BoTtX5PBZhdRnL8ROsZUTkTX/PS4vFm/KZuEm6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUypfBwwtTBFuAE60PZafIFUyJAGeoAtkYFOAC5DpuA=;
 b=rbFQ0RZLO3uyPxy+yQQz/oECjduDx5AVRiXHoBK5L4M4Dzk3JrxjT/Jqapj8+7Twph90CDAfHh7VVBWu4fQ37pQUQFF/ludB2xSwcLzq/KXgDW9/hvToqTxUMG8pyp1k4N+U3vDwtz5KhdzZXBCXXubQed/XwhtwxXZFiC8xO8RD46+nZH1nwV6MQWfMeQ++wczDfAAOqnx5YVYOcLrRW0XEaLXNCnAUomcSv+Gd3AOcTDqMHun59xDhydYRaQqKPPX48YjoSdQjmH/HMrIxsWISU4tdZVEy1EiEVXvK0Ef897Gek87I2/yMkBtkUF+Q1s5e16831PF+AQG/9iQ/xQ==
Received: from BN9P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::27)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 11:03:01 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::14) by BN9P222CA0022.outlook.office365.com
 (2603:10b6:408:10c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:03:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:44 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:41 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 17/17] mlxsw: spectrum: Permit enslavement to netdevices with uppers
Date: Wed, 19 Jul 2023 13:01:32 +0200
Message-ID: <7510e6128f06e24730bed870b7fa04ffc11fa154.1689763089.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: fed639ea-336f-467b-6708-08db8847b79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AuitTvd4iNmwTomIPRzucsGKp96dZk6ksu+iC7WlV15qbSjq5BbaTMonFbMWHibm7A4yTJX1OuW4ODVAw0kDgj/cihl9nYF5y7ppvgtMGn91NeTkFGJNKWWlNYWZMw0BaOsosiDTidWyNAxbKhpszc7wNPJuvB7TKYzGY8oB9Pbdg9Ama4yhraqqx+re4hkAyxD8UqSrZTt2hOYOe/CbJD2pOwp7fn0y5HLDZY6GipCanp2fMA2cFL5ruJMy+qQZLVrlmqJ0oJKmlx/EFt7Ec8rBDNX6jnV+A0FTk7w7iSOYe0FVv+pdhNZrHUOQAiME7xX24v2KGAYgbzYk8LWUCVVqQ6CJmCKsufXvVF2fFF9aPasSfX48Sd9dZkUpGET16Zu5vKMkqr4KGnHIPSDP1ETWJ1hOS75o7OA0ryQxN85inNMUIVQjxxIYO3RWsaoV7yb0ysroBMBeCaJf5qfkNtW1d71OdU+sfqrTUNZF80QbeYYNkRhy2ZPM66PuYb9rzgDKwwOYEyq/EAsSYk2ejjlc1E5g5bRRX1hXArDg3BIUAJ42JcOpkW2do5avO0LqyT59reWf54VGjDCfWNuorD62jIrZksIrvhPQV8UKvye5gyy52R8VJryI0JaGahbVBkxZi2G+VvbAaQeIJuMHrxxzpg4pFiDOvbI+Zf1CQJZdCHuBUlFEZ2fD0kLLN63Fow/5oytkWuffYQLwWPb2njdxp+xfAGagW5cV+2qr1Uc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(107886003)(356005)(7636003)(478600001)(82740400003)(26005)(2906002)(40480700001)(6666004)(40460700003)(5660300002)(47076005)(83380400001)(316002)(70586007)(70206006)(4326008)(110136005)(54906003)(36756003)(426003)(36860700001)(8676002)(8936002)(41300700001)(16526019)(186003)(336012)(86362001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:03:00.5496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed639ea-336f-467b-6708-08db8847b79b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enslaving of front panel ports (and their uppers) to netdevices that
already have uppers is currently forbidden. In the previous patches, a
number of replays have been added. Those ensure that various bits of state,
such as next hops or switchdev objects, are offloaded when they become
relevant due to a mlxsw lower being introduced into the topology.

However the act of actually, for example, enslaving a front-panel port to
a bridge with uppers, has been vetoed so far. In this patch, remove the
vetoes and permit the operation.

mlxsw currently validates creation of "interesting" uppers. Thus creating
VLAN netdevices on top of 802.1ad bridges is forbidden if the bridge has an
mlxsw lower, but permitted in general. This validation code never gets run
when a port is introduced as a lower of an existing netdevice structure.

Thus when enslaving an mlxsw netdevice to netdevices with uppers, invoke
the PRECHANGEUPPER event handler for each netdevice above the one that the
front panel port is being enslaved to. This way the tower of netdevices
above the attachment point is validated.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 66 +++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index b955511fe5a2..f0f6af3ec7c5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4735,6 +4735,58 @@ static bool mlxsw_sp_bridge_vxlan_is_valid(struct net_device *br_dev,
 	return true;
 }
 
+static bool mlxsw_sp_netdev_is_master(struct net_device *upper_dev,
+				      struct net_device *dev)
+{
+	return upper_dev == netdev_master_upper_dev_get(dev);
+}
+
+static int __mlxsw_sp_netdevice_event(struct mlxsw_sp *mlxsw_sp,
+				      unsigned long event, void *ptr,
+				      bool process_foreign);
+
+static int mlxsw_sp_netdevice_validate_uppers(struct mlxsw_sp *mlxsw_sp,
+					      struct net_device *dev,
+					      struct netlink_ext_ack *extack)
+{
+	struct net_device *upper_dev;
+	struct list_head *iter;
+	int err;
+
+	netdev_for_each_upper_dev_rcu(dev, upper_dev, iter) {
+		struct netdev_notifier_changeupper_info info = {
+			.info = {
+				.dev = dev,
+				.extack = extack,
+			},
+			.master = mlxsw_sp_netdev_is_master(upper_dev, dev),
+			.upper_dev = upper_dev,
+			.linking = true,
+
+			/* upper_info is relevant for LAG devices. But we would
+			 * only need this if LAG were a valid upper above
+			 * another upper (e.g. a bridge that is a member of a
+			 * LAG), and that is never a valid configuration. So we
+			 * can keep this as NULL.
+			 */
+			.upper_info = NULL,
+		};
+
+		err = __mlxsw_sp_netdevice_event(mlxsw_sp,
+						 NETDEV_PRECHANGEUPPER,
+						 &info, true);
+		if (err)
+			return err;
+
+		err = mlxsw_sp_netdevice_validate_uppers(mlxsw_sp, upper_dev,
+							 extack);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 					       struct net_device *dev,
 					       unsigned long event, void *ptr,
@@ -4776,8 +4828,11 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 		    (!netif_is_bridge_master(upper_dev) ||
 		     !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp,
 							  upper_dev))) {
-			NL_SET_ERR_MSG_MOD(extack, "Enslaving a port to a device that already has an upper device is not supported");
-			return -EINVAL;
+			err = mlxsw_sp_netdevice_validate_uppers(mlxsw_sp,
+								 upper_dev,
+								 extack);
+			if (err)
+				return err;
 		}
 		if (netif_is_lag_master(upper_dev) &&
 		    !mlxsw_sp_master_lag_check(mlxsw_sp, upper_dev,
@@ -5008,8 +5063,11 @@ static int mlxsw_sp_netdevice_port_vlan_event(struct net_device *vlan_dev,
 		    (!netif_is_bridge_master(upper_dev) ||
 		     !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp,
 							  upper_dev))) {
-			NL_SET_ERR_MSG_MOD(extack, "Enslaving a port to a device that already has an upper device is not supported");
-			return -EINVAL;
+			err = mlxsw_sp_netdevice_validate_uppers(mlxsw_sp,
+								 upper_dev,
+								 extack);
+			if (err)
+				return err;
 		}
 		break;
 	case NETDEV_CHANGEUPPER:
-- 
2.40.1


