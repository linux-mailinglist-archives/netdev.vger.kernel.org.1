Return-Path: <netdev+bounces-13086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BC73A1EE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8035F281987
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF00E1F934;
	Thu, 22 Jun 2023 13:34:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB21D2D1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:34:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96CBC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeO6UaEhha5HMu6HYBMCcHQxwkp6W3EkO+W5cNu7GQUJwy1VwFCs/GUS+8LEjglIb6ma0IWvPjb7z96QoOm+e0eF9hf7BefHW19FMvdOufjcSlaOz5KqGuBqIsQgUKKqm5Qxw5jZ5jbmOzbEtRBpLutytt0D1tSVruUqRg5zmjomPPkxGsyq3UZd87nWkVJo7Inlkdg6fZPC7HhP6osfn8RuX1oaiIY90yAkkrdtKhbGv7Xany4dadnweNyvlRG2B6MeXxx4fn3t1ipy7NusjiqE/1B/lYybFIzhWPOs7s2nvnBT/zPPfwOIAN0E/zJWrs6pxsSFv+4E6IDVejgaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqUXQRvmCQBmGLpAdAQfmwJK2wW+N0+O69f/M3I1xhI=;
 b=S0sI4XsI/7WRBXE8b57lbYoRSDnx6uJ0Z7SMj/TiFZYhc59MQnUpA5o5DnQ8Pq/rMT7Ef7P1VmzMOruYiTh9OnMRPl2OGf9lRpuCpZS5wO/NOyFGogDW4hQVXuab2PptNWHqkqxiPH+nAsIkyqGT9N2v5mm+ZbWpwpftyWpKLpLL3zqq7cW06Gv4Qf2OOzVG+nlvlXVeyvOaUIiofcC6BhPApAx+a35NTylLhlaaO5R9mzcy08xWgKFRkUeQWRiwYRjd9fSJhsRg9gNjcXVv0vrubMqpzM6j1j5fpLakFEL6JQGO1mN221Pif9pacGZ0rXEUeo0o6JVhLWqim9Tu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqUXQRvmCQBmGLpAdAQfmwJK2wW+N0+O69f/M3I1xhI=;
 b=PhXaB71kvbRndUD8LPP0QBRw1VEgIq58nVr16zRxl4W5pEoCbRf5b13sm/dj7ohUCzKxxs+AF2URPXpo6SWT7gSKpclpfsh6Vz0XcQLUfoMINQiQLL4Bu5V/aC61lAFt87ZWDhnRObn2aTsETFw/zDC9DInKAsv9ccvSikaHdM7b7chUGeNmAs0SJbPd9K+mqYFxN5aL7nyoc1ZyvpTPdkpwLbr8YlmuV7M9ADyHfBqpXkYElLlzRXTYvV0ndp7pguSs3/gP/mRnKbCcnJ7W1gt0BhyAvbJabA0jsniOlrj6pS6liLFSbbHioLCbL4nf4G6oky8ubulJ5XRDAQpNtQ==
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 13:33:54 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::b0) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23 via Frontend Transport; Thu, 22 Jun 2023 13:33:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 06:33:43 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 06:33:40 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 6/8] mlxsw: spectrum_router: Use router.lb_crif instead of .lb_rif_index
Date: Thu, 22 Jun 2023 15:33:07 +0200
Message-ID: <8637bf959bc5b6c9d5184b9bd8a0cd53c5132835.1687438411.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687438411.git.petrm@nvidia.com>
References: <cover.1687438411.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: f8cbdcfe-3aba-40be-c192-08db732552bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v4cyKBYrHU2jHnp7O2Dh6RzlFAoNtY/y1ge1L2b+teSSVzH4SwWZq5dnYnVsdUpV2pWCCO1C6KcFeGOxzFZ68wfWRygJj3F5UaLwT7EH7o0+9XJE2LMP2H3bzTMpNna+50Z1PFNJV/ZA2d8fMMxs3mznX1ClYhIrNzw40U9kkJfxViIygFadkmAT4FletmxQwreoy+oHmxVUHPOLWctxmRIxEkUWKzCVMMv5YWBZrAtFqJ5l4mVqv41CgZ9DXyTmBWJL28E7rccX9DllBQh+tS4ROko8hMwZTc9J5d0w5Ea2HiFvm2WSLBbVFsoe8xHXT2HORGbvVgOI4I/Mgi+h1vk+2PZR8E8N+WpvSSN6irFJC4sZpC3afTPVISLeBdOa5Z++uQntvvH7YAO7MCVK/p+bt2PWEzpwkHaJn3/mqOj3Gqh3KZ7UYibtPeVvDZzoYYJZZ1yXbqVWs5LASGEMXA6HbFMb+PzaTJsnRCjxqgkSlnfZ7qky1CbBpB0AVopTHh4A2ivz1EsfNXOW1hyOQ0RMaBlr2qJb4bfyqhXcc/2AA6drjW+KzvjzlskaJjvsORp1+j1PULI0zZO78Teym4Lwq2W9RblAaA2tSMEaeqeaVlK1Cd5trtglIu9+MOSk+bKM49HaSQXU9uyr1rw+SfSu42kB0ePGsnFOJP7OnFiYJICUHEZkuTAy0fKBcKCbxD+jikJtpzDNCHiBjIehUm2jC82gAM598lTz2GLr+c+eqF13JQELQ/IMtob0SnpXenGlb8kRowq0Tjje/A/fhg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(4326008)(316002)(8676002)(8936002)(107886003)(16526019)(41300700001)(26005)(186003)(2616005)(54906003)(110136005)(40460700003)(6666004)(426003)(336012)(82310400005)(2906002)(5660300002)(478600001)(40480700001)(356005)(7636003)(82740400003)(47076005)(36860700001)(66574015)(83380400001)(36756003)(86362001)(142923001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:33:54.0777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cbdcfe-3aba-40be-c192-08db732552bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A previous patch added a pointer to loopback CRIF to the router data
structure. That makes the loopback RIF index redundant, as everything
necessary can be derived from the CRIF. Drop the field and adjust the code
accordingly.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c    | 12 ++++--------
 .../net/ethernet/mellanox/mlxsw/spectrum_router.h    |  1 -
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index daa59fc59d3b..acd6f1b5eef9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3563,7 +3563,7 @@ static int __mlxsw_sp_nexthop_eth_update(struct mlxsw_sp *mlxsw_sp,
 	u16 rif_index;
 
 	rif_index = nh->rif ? nh->rif->rif_index :
-			      mlxsw_sp->router->lb_rif_index;
+			      mlxsw_sp->router->lb_crif->rif->rif_index;
 	op = force ? MLXSW_REG_RATR_OP_WRITE_WRITE_ENTRY :
 		     MLXSW_REG_RATR_OP_WRITE_WRITE_ENTRY_ON_ACTIVITY;
 	mlxsw_reg_ratr_pack(ratr_pl, op, true, MLXSW_REG_RATR_TYPE_ETHERNET,
@@ -4530,7 +4530,7 @@ static int mlxsw_sp_adj_trap_entry_init(struct mlxsw_sp *mlxsw_sp)
 	mlxsw_reg_ratr_pack(ratr_pl, MLXSW_REG_RATR_OP_WRITE_WRITE_ENTRY, true,
 			    MLXSW_REG_RATR_TYPE_ETHERNET,
 			    mlxsw_sp->router->adj_trap_index,
-			    mlxsw_sp->router->lb_rif_index);
+			    mlxsw_sp->router->lb_crif->rif->rif_index);
 	mlxsw_reg_ratr_trap_action_set(ratr_pl, trap_action);
 	mlxsw_reg_ratr_trap_id_set(ratr_pl, MLXSW_TRAP_ID_RTR_EGRESS0);
 	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(ratr), ratr_pl);
@@ -4846,15 +4846,13 @@ static bool mlxsw_sp_nexthop_obj_is_gateway(struct mlxsw_sp *mlxsw_sp,
 static void mlxsw_sp_nexthop_obj_blackhole_init(struct mlxsw_sp *mlxsw_sp,
 						struct mlxsw_sp_nexthop *nh)
 {
-	u16 lb_rif_index = mlxsw_sp->router->lb_rif_index;
-
 	nh->action = MLXSW_SP_NEXTHOP_ACTION_DISCARD;
 	nh->should_offload = 1;
 	/* While nexthops that discard packets do not forward packets
 	 * via an egress RIF, they still need to be programmed using a
 	 * valid RIF, so use the loopback RIF created during init.
 	 */
-	nh->rif = mlxsw_sp->router->rifs[lb_rif_index];
+	nh->rif = mlxsw_sp->router->lb_crif->rif;
 }
 
 static void mlxsw_sp_nexthop_obj_blackhole_fini(struct mlxsw_sp *mlxsw_sp,
@@ -10784,8 +10782,6 @@ static int mlxsw_sp_lb_rif_init(struct mlxsw_sp *mlxsw_sp,
 		goto err_ul_rif_get;
 	}
 
-	mlxsw_sp->router->lb_rif_index = lb_rif->rif_index;
-
 	return 0;
 
 err_ul_rif_get:
@@ -10795,7 +10791,7 @@ static int mlxsw_sp_lb_rif_init(struct mlxsw_sp *mlxsw_sp,
 
 static void mlxsw_sp_lb_rif_fini(struct mlxsw_sp *mlxsw_sp)
 {
-	mlxsw_sp_router_ul_rif_put(mlxsw_sp, mlxsw_sp->router->lb_rif_index);
+	mlxsw_sp_ul_rif_put(mlxsw_sp->router->lb_crif->rif);
 	mlxsw_sp_crif_free(mlxsw_sp->router->lb_crif);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
index 0909cf229c86..9a2669a08480 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
@@ -60,7 +60,6 @@ struct mlxsw_sp_router {
 	struct mlxsw_sp_router_nve_decap nve_decap_config;
 	struct mutex lock; /* Protects shared router resources */
 	struct mlxsw_sp_fib_entry_op_ctx *ll_op_ctx;
-	u16 lb_rif_index;
 	struct mlxsw_sp_crif *lb_crif;
 	const struct mlxsw_sp_adj_grp_size_range *adj_grp_size_ranges;
 	size_t adj_grp_size_ranges_count;
-- 
2.40.1


