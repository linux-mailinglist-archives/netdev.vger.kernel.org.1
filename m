Return-Path: <netdev+bounces-16900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4BD74F5FF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDBC1C20FDF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23291DDCD;
	Tue, 11 Jul 2023 16:45:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF601DDC2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:45:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96CA2707
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWQaELT6nW1ODZ4WiXmSQaSX4SDVe20//rYXFpIQRgYu2fAda8Y9hX4r/qpj7p7V0x2L+nvXT/iA5M44NV/SEZrO7dGrId+jtKP/Zqx20o9UheNaZg0N20nqCXfQgpHGlJnS5xmvrFNK/BxPZkdktm2cCzZXgMEBghrEoeASIgia1pbaQBpMGagZT8p1aOnU382t03NQpNzq1RnDC2WVpYQXqEivvBrZOR9B/4OCocOXF297eb9UT+KN2p5PrB1tZGzyHeYRuj4rqYTJKLcC/UHwPHOiJOG7as/EjiedfjeYbZO1s+UtFpbvR8UVxGT86HSDvZUo1QXV2t+hJv7Q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOssHaa1bRucqKGXMR0UCAIoR09fxUacvi2UICywhmQ=;
 b=b9H/MdHr1vQSWt/zPtz9tFbvXts+ii7eju/qM2smbpldg/2JwiqLX+InY7Y/AvhSxyIRywEgnvORVwR9eQ7jmq8ZRIlpH+luQXT5GwNTRmMekntevCX4AdQT09eIjkMlpH/rl5/7SuBA8yEOe3oEj9Sa+OiUap6pONTDEu9vvPlBkyEuXy5Bgws/QwKmFSlij7xO1MQYgv5mhSd2NXTP9Nn0XECc49Gz9OsFjOukO/KL/akJglW5rThUsPfzDx/6gNxdsW9EocZfjDuuVMm0DnTih+FdSc8xIqW9ZQFGjKZpWvy6jGhAMonA1gePTsqE8mGHHEvApSqT/EipYsNmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOssHaa1bRucqKGXMR0UCAIoR09fxUacvi2UICywhmQ=;
 b=AMPes3J6UYh/d+ejakG9X+xG2qSp79Og0jYXJvx2KbaNNkjK3u0q7ED/9xEBzVeA13u44brrYdF+kPsBlIPuQsjf+Negf1Bw+nuudAuiau9uty1vp59fc46uYrof27F5T5Uezn+fcvfbRczzsCkWEl2B9Yzi0oEqu1QVfG5PDKxfVa9bSnTgaBSNEAWzJBC0mrVddd2gxTrv3YerUOV1eIRV2yzeDL7kl1tNEuLVQkrlGFgbV4ADiv8+p+jlaKpUiYvFMLvjmkp8K5UqqigV4nKeiqWQwheCNZEvQ1r9ORSZJ3b7dhAHn5MRZG984UcUTNMX4HHH9vOdok/JDEYM4Q==
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 16:44:51 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::6f) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:35 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 04/10] mlxsw: spectrum_port_range: Add devlink resource support
Date: Tue, 11 Jul 2023 18:43:57 +0200
Message-ID: <7945e0c715dc5efb1617f45f7560c1f1bd0bcf8a.1689092769.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689092769.git.petrm@nvidia.com>
References: <cover.1689092769.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: f6abd26b-4614-4b91-0edd-08db822e254e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	csilugC8YWotTpyG2CPxySbCWuR1MR++B4Bd4hkJomxPYcR82cZCHuqr84FXAla42xUTMWdNoDnUAH3HIJHmQUMVcQ+XkpiMmZwftdBE11p07biGg/RUnV8yVy6hLkr0h6Qhr+27iDZq6Ph5IesrvnUCxDG/DAooWKtJwRS1s5/avUejnY6Qb9rQoS7hEKKnTo7mIjGf6rDfSHsi9HTwE5U7O6aau7KNlaC2OEiagyhNN3vvjQNPsJSHWInE7ghkOIX09nXu6pDpSBsJJSo/moxFVDNezDo3+4i5iiriEnWn/ss8VdtLSl060WM5T1ePitD2R66MQn3aJJaBFjn0PyV/DEjVBjCiiqkCuNEkyHvDXTKdyniFVwA1eRsA//lNFU1H53aVvCyYphq2eRLWK0yK3uiFGcvYruqPbW4J/4HzEuCenBSOEdG62difgs71NTR0RrEQr21kVskGpG7ei9UU1GdG2APz4LCFFyuI9hvQ3Qq1lw/DDkxcl9GFEWBGnzB/QeZY2Y7jrUaIWraJOL8trk/54WLoyNhHCpH1y3wJ7qiZGdGAtsUiL5zA8Rwiw16aexdg2yIL9VYnHUzrSbXjfvad8cRhbYhZGhk01HnUDPz414mPCOLispfRcoPL18movq/SfRjo66VyfrSMpLOdmpELB1OnnVA1YPyweODpdUhqn6H4Jx1xwsIKqqScuIlBrisopi/RsEwANT3I+qUeikBE39wwctqeXXtCDhhTyRmoQP3DIYlvA9xfByfx
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(2906002)(4326008)(70206006)(70586007)(5660300002)(82740400003)(356005)(7636003)(86362001)(478600001)(8676002)(316002)(8936002)(6666004)(47076005)(82310400005)(107886003)(36756003)(26005)(83380400001)(426003)(336012)(186003)(16526019)(40460700003)(110136005)(54906003)(40480700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:50.7473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6abd26b-4614-4b91-0edd-08db822e254e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Expose via devlink-resource the maximum number of port range registers
and their current occupancy. Besides the observability benefits, this
resource will be used by subsequent patches for scale and occupancy
tests.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 30 +++++++++++++++++++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  1 +
 .../mellanox/mlxsw/spectrum_port_range.c      | 19 ++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index c0edcc91f178..86e2f0ed64d3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3739,6 +3739,26 @@ static int mlxsw_sp_resources_rifs_register(struct mlxsw_core *mlxsw_core)
 				      &size_params);
 }
 
+static int
+mlxsw_sp_resources_port_range_register(struct mlxsw_core *mlxsw_core)
+{
+	struct devlink *devlink = priv_to_devlink(mlxsw_core);
+	struct devlink_resource_size_params size_params;
+	u64 max;
+
+	if (!MLXSW_CORE_RES_VALID(mlxsw_core, ACL_MAX_L4_PORT_RANGE))
+		return -EIO;
+
+	max = MLXSW_CORE_RES_GET(mlxsw_core, ACL_MAX_L4_PORT_RANGE);
+	devlink_resource_size_params_init(&size_params, max, max, 1,
+					  DEVLINK_RESOURCE_UNIT_ENTRY);
+
+	return devl_resource_register(devlink, "port_range_registers", max,
+				      MLXSW_SP_RESOURCE_PORT_RANGE_REGISTERS,
+				      DEVLINK_RESOURCE_ID_PARENT_TOP,
+				      &size_params);
+}
+
 static int mlxsw_sp1_resources_register(struct mlxsw_core *mlxsw_core)
 {
 	int err;
@@ -3767,8 +3787,13 @@ static int mlxsw_sp1_resources_register(struct mlxsw_core *mlxsw_core)
 	if (err)
 		goto err_resources_rifs_register;
 
+	err = mlxsw_sp_resources_port_range_register(mlxsw_core);
+	if (err)
+		goto err_resources_port_range_register;
+
 	return 0;
 
+err_resources_port_range_register:
 err_resources_rifs_register:
 err_resources_rif_mac_profile_register:
 err_policer_resources_register:
@@ -3806,8 +3831,13 @@ static int mlxsw_sp2_resources_register(struct mlxsw_core *mlxsw_core)
 	if (err)
 		goto err_resources_rifs_register;
 
+	err = mlxsw_sp_resources_port_range_register(mlxsw_core);
+	if (err)
+		goto err_resources_port_range_register;
+
 	return 0;
 
+err_resources_port_range_register:
 err_resources_rifs_register:
 err_resources_rif_mac_profile_register:
 err_policer_resources_register:
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index fe6c6e02a484..a74652ea4d7c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -69,6 +69,7 @@ enum mlxsw_sp_resource_id {
 	MLXSW_SP_RESOURCE_SINGLE_RATE_POLICERS,
 	MLXSW_SP_RESOURCE_RIF_MAC_PROFILES,
 	MLXSW_SP_RESOURCE_RIFS,
+	MLXSW_SP_RESOURCE_PORT_RANGE_REGISTERS,
 };
 
 struct mlxsw_sp_port;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
index a12a62632721..2d193de12be6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
@@ -5,6 +5,7 @@
 #include <linux/netlink.h>
 #include <linux/refcount.h>
 #include <linux/xarray.h>
+#include <net/devlink.h>
 
 #include "spectrum.h"
 
@@ -17,6 +18,7 @@ struct mlxsw_sp_port_range_reg {
 struct mlxsw_sp_port_range_core {
 	struct xarray prr_xa;
 	struct xa_limit prr_ids;
+	atomic_t prr_count;
 };
 
 static int
@@ -71,6 +73,8 @@ mlxsw_sp_port_range_reg_create(struct mlxsw_sp *mlxsw_sp,
 		goto err_reg_configure;
 	}
 
+	atomic_inc(&pr_core->prr_count);
+
 	return prr;
 
 err_reg_configure:
@@ -85,6 +89,7 @@ static void mlxsw_sp_port_range_reg_destroy(struct mlxsw_sp *mlxsw_sp,
 {
 	struct mlxsw_sp_port_range_core *pr_core = mlxsw_sp->pr_core;
 
+	atomic_dec(&pr_core->prr_count);
 	xa_erase(&pr_core->prr_xa, prr->index);
 	kfree(prr);
 }
@@ -145,6 +150,13 @@ void mlxsw_sp_port_range_reg_put(struct mlxsw_sp *mlxsw_sp, u8 prr_index)
 	mlxsw_sp_port_range_reg_destroy(mlxsw_sp, prr);
 }
 
+static u64 mlxsw_sp_port_range_reg_occ_get(void *priv)
+{
+	struct mlxsw_sp_port_range_core *pr_core = priv;
+
+	return atomic_read(&pr_core->prr_count);
+}
+
 int mlxsw_sp_port_range_init(struct mlxsw_sp *mlxsw_sp)
 {
 	struct mlxsw_sp_port_range_core *pr_core;
@@ -168,6 +180,11 @@ int mlxsw_sp_port_range_init(struct mlxsw_sp *mlxsw_sp)
 	pr_core->prr_ids.max = max - 1;
 	xa_init_flags(&pr_core->prr_xa, XA_FLAGS_ALLOC);
 
+	devl_resource_occ_get_register(priv_to_devlink(core),
+				       MLXSW_SP_RESOURCE_PORT_RANGE_REGISTERS,
+				       mlxsw_sp_port_range_reg_occ_get,
+				       pr_core);
+
 	return 0;
 }
 
@@ -175,6 +192,8 @@ void mlxsw_sp_port_range_fini(struct mlxsw_sp *mlxsw_sp)
 {
 	struct mlxsw_sp_port_range_core *pr_core = mlxsw_sp->pr_core;
 
+	devl_resource_occ_get_unregister(priv_to_devlink(mlxsw_sp->core),
+					 MLXSW_SP_RESOURCE_PORT_RANGE_REGISTERS);
 	WARN_ON(!xa_empty(&pr_core->prr_xa));
 	xa_destroy(&pr_core->prr_xa);
 	kfree(pr_core);
-- 
2.40.1


