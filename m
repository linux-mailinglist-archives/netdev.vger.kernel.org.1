Return-Path: <netdev+bounces-21974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB021765829
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20FB282229
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AF218035;
	Thu, 27 Jul 2023 16:00:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36818034
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:00:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D460DBC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N95DC55vitIvbfHgPxKawLpxRu/hfI0mZK2VnBt7jDN2WCsu47NRC93RnkTjJvxcLeRE4Pbcm7StFylHEBzM/CMnc8inpayCkpQ922vIj9qg+5G14uGPVDT+E8lUabqqoO0S7GSogl8sF8BvJ0smgRrvVsqkUqs8Q8+0yAo1GyPr/YkdLIp0JFDR5jJzwypPTmGzgr1RWlhvgmk9Tji2hvHfjZy07KfBXiIPUd9d0uwVOnPP4VZKKpLg7iTqx8c1L7iqVPKsdPv/KbNOKeN0Hc4BDN7bdYAXOS0eYlI4BvvgS+LgmVU41zA8W3FAxPnPSX1dAHrlxJlGZG+HY/AQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS7bqzzktasQFNzaqU14tfwUjM1TQJPGr4t1kbKEiE8=;
 b=PyRalcV+aDGv/P3gs8sZQaAdy6mL3NUIqlrfcMWRagh1zIJLusXR2qJ6eIwKh6NNdzOIFW+7YzA0twW9ATY3Z7fM6d0t6ANF42LpBTRqYAdN7BFoRxRWyVvS4hgRfUXYfmGrss7QaxeUG/6Un5ZCFbPjItgZVhuJ9WnALJNOTrKLs4KrF3cyV5LXpOfT0ndDYcjSXjSBvn/vTI336QajL434p3uEk1BTB8Dddv8HwUMa1CoD+MJeVx26D9YvtS2sxiAqNr9H1B5XCTPpT8XVmD5gMrTlJl1jnWH+j/lc5laBfMUzypVh2gdAwqMk5I4A2sEg2f3Xfqx9T0oqWcTp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS7bqzzktasQFNzaqU14tfwUjM1TQJPGr4t1kbKEiE8=;
 b=cDq/ID7DPTzaZYBFbK6ZvXMENabIPitmH/CbtRVDNgKpheTUBvOmpEuq0vBeDFpDY+FjOg3GKxVS5y3ApA99oFeZk7K1PQ5GoDaqYqOgXfTbu8cPEA5rP4y0PLvx8c4xU0/niGKdPgqUi63rupNhkg6QoUKUQoyYSM8g81tR4BRrHRfNf9hahxJGFQvISDFT8yCG/aTszf+X49f3K/qvvmuSp9lClKhF9p7hsbRk496+BHWKhlT9ae32yFlR933WQ1/IKwHz0sLcnAlPp1JM5QCC1CTTHRQkTazXlWSsKdqXASxGZ567oKMDOiOaKbb3WJMxolDaLjHn9BcpguV5+w==
Received: from BN0PR04CA0196.namprd04.prod.outlook.com (2603:10b6:408:e9::21)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:31f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:00:11 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::ff) by BN0PR04CA0196.outlook.office365.com
 (2603:10b6:408:e9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:00:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 09:00:02 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 08:59:59 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 1/7] mlxsw: spectrum: Drop unused functions mlxsw_sp_port_lower_dev_hold/_put()
Date: Thu, 27 Jul 2023 17:59:19 +0200
Message-ID: <d0adcd7cb4ea19416294a0f861100edba84c9f36.1690471774.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690471774.git.petrm@nvidia.com>
References: <cover.1690471774.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e8d35c-e9fc-407b-1beb-08db8eba8ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	do6fjpjyUsCPXhyrWfYS4aaGH30OOAVB8WlA2RTQ7XH1mkKA9AKl8Qg2XQ7d8DXx8FdwDVCjSVNyemg74BrMW3+3iQsLXT1HCprnXAoWy03WbP7W0Ob0b3N4jGH2BJMWe7n3nIXs2pXbm9YKoJf7q4wStaE5j8NRvdJO/GANFXqIaM8EtItWbXyx5v6ZtK2Fd4ErOLVWLIolPKhf88BAxdicXMPWO1Ev0w3R2tiwSfx2nU/eAfet5+0SaoQ7fh+HDyL3aGR1eZ7jx5xa3g5PoJLT5zgq2bHtMv72tJv+jw1n3WjsDLvIqS+8AHZDsAqMufcWm29kXgcmzVRfBwqOWmuJed4Tbj4vLrHSDxfg866EZVaQuB1rExxM13NF5uV9ccjWxMzYpEqjVIaklFHrrEdCPD1vHVS1vJoB20A1hmJQqDNrODIpicExTybZd04y2qROlMTeVY5xhmr/zMdfOVW2Kk80/ScphVwWpbfYheCxc6Nht2pBO72ki0tOqtfH5GpMBd81X5voUXuXgEA8V652s3Z0VmmoiuszY+Mu4voKFpIgiBEZaUITHpomVQuTnsYDy69v7ddQeNWds7wmSPSgNYAM42Ke9iuL9aEGiOuVoOtIiN41GIqKxr9BhcV0e4eREtNxKMvYv4LVIO2FNQsAQ11NnGiQJJTiIsT4VpBfmtrjKPtXJU2ZsiVc/nOvgZWjZbXLXd1dr7HrkrJ7C6HOC6ZRaVw3iUofktHQpb4XlqziMfwz8aONSgGuRROw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(478600001)(356005)(82740400003)(83380400001)(47076005)(26005)(107886003)(70586007)(70206006)(110136005)(7636003)(54906003)(4326008)(426003)(186003)(336012)(16526019)(36860700001)(66574015)(2616005)(5660300002)(40460700003)(41300700001)(316002)(2906002)(8936002)(8676002)(86362001)(40480700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:00:10.9141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e8d35c-e9fc-407b-1beb-08db8eba8ea3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As of commit 151b89f6025a ("mlxsw: spectrum_router: Reuse work neighbor
initialization in work scheduler"), the functions
mlxsw_sp_port_lower_dev_hold() and mlxsw_sp_port_dev_put() have no users.
Drop them.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 17 -----------------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index f0f6af3ec7c5..9dbd5edff0b0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4112,23 +4112,6 @@ struct mlxsw_sp_port *mlxsw_sp_port_dev_lower_find_rcu(struct net_device *dev)
 	return (struct mlxsw_sp_port *)priv.data;
 }
 
-struct mlxsw_sp_port *mlxsw_sp_port_lower_dev_hold(struct net_device *dev)
-{
-	struct mlxsw_sp_port *mlxsw_sp_port;
-
-	rcu_read_lock();
-	mlxsw_sp_port = mlxsw_sp_port_dev_lower_find_rcu(dev);
-	if (mlxsw_sp_port)
-		dev_hold(mlxsw_sp_port->dev);
-	rcu_read_unlock();
-	return mlxsw_sp_port;
-}
-
-void mlxsw_sp_port_dev_put(struct mlxsw_sp_port *mlxsw_sp_port)
-{
-	dev_put(mlxsw_sp_port->dev);
-}
-
 int mlxsw_sp_parsing_depth_inc(struct mlxsw_sp *mlxsw_sp)
 {
 	char mprs_pl[MLXSW_REG_MPRS_LEN];
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 65eaa181e0aa..62151f0531ae 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -720,8 +720,6 @@ int mlxsw_sp_txhdr_ptp_data_construct(struct mlxsw_core *mlxsw_core,
 bool mlxsw_sp_port_dev_check(const struct net_device *dev);
 struct mlxsw_sp *mlxsw_sp_lower_get(struct net_device *dev);
 struct mlxsw_sp_port *mlxsw_sp_port_dev_lower_find(struct net_device *dev);
-struct mlxsw_sp_port *mlxsw_sp_port_lower_dev_hold(struct net_device *dev);
-void mlxsw_sp_port_dev_put(struct mlxsw_sp_port *mlxsw_sp_port);
 struct mlxsw_sp_port *mlxsw_sp_port_dev_lower_find_rcu(struct net_device *dev);
 int mlxsw_sp_parsing_depth_inc(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_parsing_depth_dec(struct mlxsw_sp *mlxsw_sp);
-- 
2.41.0


