Return-Path: <netdev+bounces-18966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6807593CB
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA192816F2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B268812B80;
	Wed, 19 Jul 2023 11:02:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D612B6C
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ED0186
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3xCA0J/K6JpxPxQmhtFGFtTLV5Xk6AmlQqLPnZKWJPRa6zHj5/LkvuyyBchFkH+357WQELXEei2ApjA5Ot78jg/vm5zpx508hrQ5w4Y0tyodtjYBb80/xm4/L6bPx0CMQ6NNDwBjo5zX4aIxYxApdJavncLWzLSLQqeVdH3qHDw5lzFH64MjCrD8tHqkcN+WABRNTQh8gfBUvmq+PzG5gYJw7TL682uh3WtseawiR6miFM6ZFcqoCwW5qHiNA8G3wOjkt/gbhwdemhelFqVRYyBztUHzNq57fJ4T+vbuvAV5HF2sOR8riYZ/i0jXbZvABcljeRPGtmdU9f1FIn+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmKRnYM4W0ipdsOSHNPyqKhyLAH6W6bDsnvxGrmntvU=;
 b=SBfeJrngsNrLas+dn4WdxtLGTDDqf8wbX6+I8X4SayRe1wEDRk9pBroPJabE1WBGdukd9kqy8kjfEfyCC4yOhSP5tHZC6OeU6oCr35wYCIu3B6mwEVA8oxY8meS7+1eYMOP8uTS4ANPKo1W78VxwKutG4holz94/Q7Py82lXihpzfNrbnwP9ZBXu+O+zgYCj7N+ZvGz7ZntLepxlq2+2s95hM1xMcu73ZlMziTHn4q5V1STQqzPYl9QO3jck5Q/iZHmSmQl7tsr8vSaZY7XtYc508ONL1ge6j814F8CTpXTMZzx9cDtc6JnnaKGFnZ+CbHrm24rgV64sY6YvMB0BzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmKRnYM4W0ipdsOSHNPyqKhyLAH6W6bDsnvxGrmntvU=;
 b=bQd/5qoQp2OI8Ydi7SvyDZgNJyz65rvHZDp3aAyGyr2F1GxBKDbEOpes4rmYccMG/12WJD06OST5/zS/44Z21HfElo7pYNOEuH6lqcUO5U1jQb0Bcup5puDlvnn7hhckxf0wu27a+CsesVTrPe8/f7x26/8v13iWj9voYY4tJHshrLdhtI1+jv6eV15voV12OZ3tXz72Y95PCYsTf0t+OcLFpfSz6OP+60qy+QszupPERkIohpXPvaZloEsUZgad3HTIyZQ3pqoDrwgRtxlKYP6G50kwJ2o72gNzdqv5y4szRP2zjeQiy5+JNKTyEVflnLLUqNvJPXfMkQD+xlpnfA==
Received: from BN0PR04CA0188.namprd04.prod.outlook.com (2603:10b6:408:e9::13)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 11:02:41 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::94) by BN0PR04CA0188.outlook.office365.com
 (2603:10b6:408:e9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:28 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 11/17] mlxsw: spectrum_router: Join RIFs of LAG upper VLANs
Date: Wed, 19 Jul 2023 13:01:26 +0200
Message-ID: <e7e69b46f4401270be3bb7462ce9ce2b47b9b9e7.1689763089.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f23555e-eba5-4a17-1eb1-08db8847abd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nsXwv6leiRpOAys55Ebeq58qt+/UrnmfDCTigsrEgsQ2P4aGM2o1DctYRqzjwGDdcEi2ylDJ9w61j9dyaj/wWf1NYgN1nb+QqgTCu+rc5cb+MVpXOLn3lR6FJJW389op9wR4JMFZKHLnUuSxQwbPwTFxme00LJ4XbR5FOADBZK/X9gwqBfprZXOKotNHuFERJEmKFRGX6mGJ1094k17Cv6fVvltBoZm0qIsmh2OwBOTEG5+LqyL/F8hayMWvxSMh07UbtbgZ+Z1Cha1ho8+gLgvQ8oVlLWaBSQTt+AU/BGxeaAAKPdxxkwrBgIn51aw83SeSLK7suXaFR4bLlddW7k70JMFrU0hbPjQcmJX6U1gTt7aw8IBHs0z9ZLoMTv6OY2GuHOuNe9fxxzksma+diKGTQKyFuuzIovkUcWv0JAS/kOjNok0KccPtTX+7qjlLoafq7BxVY5rdq+w0eLaIctF2bPOspIQ3vMjp1ZGOffy3bMk5tlR/PDnanOPCPDxWtMLrx5+4nyjQnYJ4zG68mnpkJPrel8UUXy0XJzUxI9DMCaLQbk40sqFoWROfyd1ztqvOe2Uj19e6FIbj0fY8KbC/rbNJaV7WlSkyAUroNDwK7qJ1UrcEiIZzM2OYZvMT8+zNVpyaxy3RsSOtVO+qqneXDPCjvtf7ZKMgIvSor58Qjh+nKkc9eF1Ipn/ogEjvJVCyNUBltndiyRwAtQ0XYGZW0swtfsJWi6ZGm9+dfEQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(36860700001)(70206006)(40460700003)(107886003)(2906002)(356005)(7636003)(316002)(8676002)(8936002)(4326008)(36756003)(66574015)(5660300002)(82740400003)(47076005)(16526019)(70586007)(426003)(2616005)(186003)(40480700001)(336012)(26005)(41300700001)(86362001)(478600001)(83380400001)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:40.7821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f23555e-eba5-4a17-1eb1-08db8847abd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the following patches, the requirement that ports be only enslaved to
masters without uppers, is going to be relaxed. It will therefore be
necessary to join not only RIF for the immediate LAG, as is currently the
case, but also RIFs for VLAN netdevices upper to the LAG.

In this patch, extend mlxsw_sp_netdevice_router_join_lag() to walk the
uppers of a LAG being joined, and also join any VLAN ones.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 55 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 18e059e94079..ae2d5e760f1b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -9685,15 +9685,64 @@ mlxsw_sp_port_vid_router_join_existing(struct mlxsw_sp_port *mlxsw_sp_port,
 						       dev, extack);
 }
 
+static void
+mlxsw_sp_port_vid_router_leave(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid,
+			       struct net_device *dev)
+{
+	struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
+
+	mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_find_by_vid(mlxsw_sp_port,
+							    vid);
+	if (WARN_ON(!mlxsw_sp_port_vlan))
+		return;
+
+	__mlxsw_sp_port_vlan_router_leave(mlxsw_sp_port_vlan);
+}
+
 static int __mlxsw_sp_router_port_join_lag(struct mlxsw_sp_port *mlxsw_sp_port,
 					   struct net_device *lag_dev,
 					   struct netlink_ext_ack *extack)
 {
 	u16 default_vid = MLXSW_SP_DEFAULT_VID;
+	struct net_device *upper_dev;
+	struct list_head *iter;
+	int done = 0;
+	u16 vid;
+	int err;
 
-	return mlxsw_sp_port_vid_router_join_existing(mlxsw_sp_port,
-						      default_vid, lag_dev,
-						      extack);
+	err = mlxsw_sp_port_vid_router_join_existing(mlxsw_sp_port, default_vid,
+						     lag_dev, extack);
+	if (err)
+		return err;
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		vid = vlan_dev_vlan_id(upper_dev);
+		err = mlxsw_sp_port_vid_router_join_existing(mlxsw_sp_port, vid,
+							     upper_dev, extack);
+		if (err)
+			goto err_router_join_dev;
+
+		++done;
+	}
+
+	return 0;
+
+err_router_join_dev:
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+		if (!done--)
+			break;
+
+		vid = vlan_dev_vlan_id(upper_dev);
+		mlxsw_sp_port_vid_router_leave(mlxsw_sp_port, vid, upper_dev);
+	}
+
+	mlxsw_sp_port_vid_router_leave(mlxsw_sp_port, default_vid, lag_dev);
+	return err;
 }
 
 int mlxsw_sp_router_port_join_lag(struct mlxsw_sp_port *mlxsw_sp_port,
-- 
2.40.1


