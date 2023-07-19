Return-Path: <netdev+bounces-18963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98A47593B4
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB8F281283
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC7312B7A;
	Wed, 19 Jul 2023 11:02:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07213AE2
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0846186
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my9n+kYX78DXdxVr/c7VKwx7g1X4voxTmZTknhTAERmmq26wHSUcU9vhw9hk3GtZe1g8ZgM6yMRrgH85vFUgRwDFPhfhGyqI1uFu1NjbCCD/W1nmyJSTZ8/hkhv4BzOxCQS7bk4IkOH/+1WcqEjTDUyByL1xojLVrfQHqVSfEa5kgTDz8dmXRVMcbKwEUG37tMESqTqIDomOACY6tiOdV6XA50xjg5Xc0T9bVD6o+ZTq4YYUSbat+qgMOabmytvcNblLxpdkgeJFbiv8FKQTKPiNxtCXTFiyiTXQMo4szLRsfZitzL422HQ/+RMpbjqqiGWwtwAsFCGmKo9oB0Mryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU9QbTVQZGNS1nCOOT2mkq0w7JUJmPDBNvt6bmcbHbg=;
 b=EUPZwKVCYJ/yZZP9eynEtyi+fyb/pb7TpFbpDN3O6G+TXFMU+JQCw9hxmG6JJe0xe6FyaB1JbBwmptxaDbC/MmM1C/MXfVtArExmH0gy1fW3J5FLQFRSHdI92jm4dF2obofDwg4/NmBaaBC51YAxWleArTs9IYTM9Ru4GBOPLqtur6o1YaUk3efFVQjDwUpHYajsVxfx7JGzP45jZPqyCqNlmcXAWVfECxKe2akLDPe0Z/moshhdhQah9TVYw42HG3tDClHo4/gWmDkE0zSI3lojt3+UyVKM7gEuy7eYkDzPKlxjiOxRzQxvHrW5s8VaIrKgEvIhDt4P8BvquSeZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU9QbTVQZGNS1nCOOT2mkq0w7JUJmPDBNvt6bmcbHbg=;
 b=Hd0Hns/rImVkTI9ZeTS7LXrAqBQS11HNqy+/7Qh/scz8N+3WW3K4cVYHfcOcCWhhpju+4BEdrNs5f5/CGK4NmY0iKD/98ilf27OIct4UOUHFkM74HA2Kmsrnt2dKWTWXe1WTcqmoCZDb2CI3a1Bzdr7y1ljL1A4Z1WcIgnG3yakRo63e6F6p+ar8vDFSa+Xpdi1P0W9SK33RzNDUF0oL1+2gM1JSFzjbUw4/ASofRtWjtKw6MwKndwZU0VLAJYcCYEyTIql96TUvDsYQMWHXFzTw98o29mP6w18pTZ6YbAFYF+1yZwuknkKZa5gfGbntc9PxQEYxQDAzph2OlzS/fA==
Received: from BN7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:408:34::28)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 11:02:37 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::64) by BN7PR06CA0051.outlook.office365.com
 (2603:10b6:408:34::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 11:02:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:22 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:19 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/17] mlxsw: spectrum: On port enslavement to a LAG, join upper's bridges
Date: Wed, 19 Jul 2023 13:01:24 +0200
Message-ID: <49e06d7bb6a139378ecba2b6b4e5f81706e934f5.1689763088.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbd0ccf-fcf5-495e-8db5-08db8847a965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k/OFvug/+QSvnS321oRtpglUvT38jE5ezTFEZLrIhCSCpPa1gQWzKIzNWnGpSRd6PF4VLfl3sNkeY69zyQFKbe5MiMr/3CLH74o8evagNzlirzwo3ALzRyEFrcDEhTpbSxTgS/EqYfli7hQGfyjUrNoQPaAzCfmtYXO1PUYxgS1v+P0528i+TTh8rdd3ej4xZiC1u1oycjGsfJrX8QYG6LMDGFtSAQZL5fssicAIxIRYDxFB11WMLkf8Dgff9ne0nFgCx0RSarfvme0uPwopvkuUU72/8WOPSUoAdc6O3GJ8LFn2edA2ZVG/G47RzIBwd4m1Y7Dc8qI+eGpNF6+aqfGgA8Tft6q/MJyFC36ZnHUvLFSmdgFsW0UWiybaUpkpnBxu/GTwRjpfKyiIsotecgVvgFWj6RO9WjWst5OA8xKqwFYMXdgAqTTNGpibDrWXgRLOzrEblt2LPy0Aup95Jd1YoNFdVDmPSXu1H56hw6Vsar3jBUWVS4P2eOHg1FnlT5B0Rm6Mnw1x5mQteiId6PYcxE/LOiGBRrb12kFAc/cOtdaPvMYs206heuKKSdjid5VjnjWIj3jgixbWWtC0Ok5VKUWooeaBw31o8j3lrsy069qP3YJz4TvmwpKLE4CSla0y4F42PWEsCVN8ydw0xPF7tJrxYmXVBryFLmfx0RjmuFSuu81KRuya3jJGZxAKqASLCJHHgOxtbxrurjy6Z4oMb4PS/YxSPq6HyY97eeqrI9LDLJVIzxPAPJvrjm/x
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(8676002)(70586007)(8936002)(70206006)(2906002)(6666004)(54906003)(7636003)(356005)(86362001)(4326008)(36860700001)(316002)(47076005)(36756003)(5660300002)(2616005)(426003)(40460700003)(186003)(336012)(26005)(40480700001)(107886003)(82740400003)(16526019)(110136005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:36.7242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbd0ccf-fcf5-495e-8db5-08db8847a965
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently it never happens that a netdevice that is already a bridge slave
would suddenly become mlxsw upper. The only case where this might be
possible as far as mlxsw is concerned, is with LAG netdevices. But if a LAG
already has an upper, enslaving mlxsw port to that LAG is forbidden. Thus
the only way to install a LAG between a bridge and a mlxsw port is by first
enslaving the port to the LAG, and then enslaving that LAG to a bridge.

However in the following patches, the requirement that ports be only
enslaved to masters without uppers, is going to be relaxed. It will
therefore be necessary to join bridges of LAG uppers. Without this replay,
the mlxsw bridge_port objects are not instantiated, which causes issues
later, as a lot of code relies on their presence.

Therefore in this patch, when the first mlxsw physical netdevice is
enslaved to a LAG, consider bridges upper to the LAG (both the direct
master, if any, and any bridge masters of VLAN uppers), and have the
relevant netdevices join their bridges.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index b9ceffe258bf..9a6e1ce4e786 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4337,6 +4337,88 @@ static int mlxsw_sp_port_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 	return -EBUSY;
 }
 
+static int mlxsw_sp_lag_uppers_bridge_join(struct mlxsw_sp_port *mlxsw_sp_port,
+					   struct net_device *lag_dev,
+					   struct netlink_ext_ack *extack)
+{
+	struct net_device *upper_dev;
+	struct net_device *master;
+	struct list_head *iter;
+	int done = 0;
+	int err;
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master && netif_is_bridge_master(master)) {
+		err = mlxsw_sp_port_bridge_join(mlxsw_sp_port, lag_dev, master,
+						extack);
+		if (err)
+			return err;
+	}
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (master && netif_is_bridge_master(master)) {
+			err = mlxsw_sp_port_bridge_join(mlxsw_sp_port,
+							upper_dev, master,
+							extack);
+			if (err)
+				goto err_port_bridge_join;
+		}
+
+		++done;
+	}
+
+	return 0;
+
+err_port_bridge_join:
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (!master || !netif_is_bridge_master(master))
+			continue;
+
+		if (!done--)
+			break;
+
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev, master);
+	}
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master && netif_is_bridge_master(master))
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, lag_dev, master);
+
+	return err;
+}
+
+static void
+mlxsw_sp_lag_uppers_bridge_leave(struct mlxsw_sp_port *mlxsw_sp_port,
+				 struct net_device *lag_dev)
+{
+	struct net_device *upper_dev;
+	struct net_device *master;
+	struct list_head *iter;
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (!master)
+			continue;
+
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev, master);
+	}
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master)
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, lag_dev, master);
+}
+
 static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct net_device *lag_dev,
 				  struct netlink_ext_ack *extack)
@@ -4361,6 +4443,12 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	err = mlxsw_sp_port_lag_index_get(mlxsw_sp, lag_id, &port_index);
 	if (err)
 		return err;
+
+	err = mlxsw_sp_lag_uppers_bridge_join(mlxsw_sp_port, lag_dev,
+					      extack);
+	if (err)
+		goto err_lag_uppers_bridge_join;
+
 	err = mlxsw_sp_lag_col_port_add(mlxsw_sp_port, lag_id, port_index);
 	if (err)
 		goto err_col_port_add;
@@ -4390,6 +4478,8 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 				     mlxsw_sp_port->local_port);
 	mlxsw_sp_lag_col_port_remove(mlxsw_sp_port, lag_id);
 err_col_port_add:
+	mlxsw_sp_lag_uppers_bridge_leave(mlxsw_sp_port, lag_dev);
+err_lag_uppers_bridge_join:
 	if (!lag->ref_count)
 		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
 	return err;
-- 
2.40.1


