Return-Path: <netdev+bounces-49343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89967F1C5F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93BE1C216EC
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC2630CEE;
	Mon, 20 Nov 2023 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t5dfVv5c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195B1C9
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kfe97t951cr6+J7ZoayF91q9VIWiQ+aTIcumeu445Sght9rA9bk71OMhpXsRIKfSIFKXVvpnTKHHs8pbPTcOeQdw7r4yjqOqfXVQuz3uL8TCtMLq7LUfbNbgkQA/MNfvh6WVF0aSi2UdPK119b93KAGVBsyqq1CA0T1JecADfVWXOQjAcUC3tTjGjIKjBd67Ab3ekLBLOwwsHpdArC3kx/Nexmj/hYVchlIr+qAaHLpe3YsY+iBAQnfgJLKwVF6meyxi2FcdzOb70i3hPUn6SO1VUkgDwIQ7ZKeb4AgpwlVQF1Djc6L2WdwVh7GB51MPxHZDjP4T97834WOwfiBcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAeYgoWmIJSc6shZ58SBf5iI+J4B96/iA8ghBLh/re0=;
 b=EQPJi0cqaz0UlYyc8hjrCL2iN2Wxv1rvHytrgs9xvOc6voCSnKNAQCBEt7P0/rUWXdgrRhQTGTi5QJfPUM8Cqih3H74Sw9T0gXTaJkB7kyz432nzpHPO1Ry2BmhzWnAxO5GN2VZQ5PIRe7E7gXTLYcIERyogIryXpFg9nrV2UkOV0vEFic4vHlxtfLTkI28jX1M6dyY4W4b4IzutXHRIFF55i4Ueqd5wCZSJTCpDfaCZLLmU5Ddd3+2vl32NQLu7OhUyEabMzRKcobMt7QWl8sF2ahPwojX0L0j1XgGM2VUQpJqLZglKmd/IbvGyLYKiEOzJfgqw9mJCN2bvA8j1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAeYgoWmIJSc6shZ58SBf5iI+J4B96/iA8ghBLh/re0=;
 b=t5dfVv5c5PX465usSBcSlcZUFzWS0oq6zhXxaSAMXcdVMGVMRNRyQO2U4gdaxJGDVD3mbRdXl+BRbW0nQMNjWVbhUZwqAsgwYJNksk8RCMWZqcPz2S9m6q4w08mOBzVCFfHwNw7XWSdC3zCfURXMPSEZ0y1j0/V4z2yLkLrtI0E1aLOwY5WhG5Pw4iFYF5kej8Z5tymfHpfcvG2QxDdz0k+V5t3nvrvlyfLYSFprK6mPJXy2Uri9AnMCZxJQRmByqlHJ4C1KcmkJa2XZkvG7cNEOv4LBcPRHQEYb6z/XkfgvNAzWrbNUjWoZngmhzsBqhM+iFEa3WTyNElaPv2kQRg==
Received: from DM6PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:100::29)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 18:28:10 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::83) by DM6PR03CA0052.outlook.office365.com
 (2603:10b6:5:100::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Mon, 20 Nov 2023 18:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:28:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:57 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:54 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/14] mlxsw: core, pci: Add plumbing related to CFF mode
Date: Mon, 20 Nov 2023 19:25:26 +0100
Message-ID: <889d58759dd40f5037f2206b9fc4a78a9240da80.1700503644.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700503643.git.petrm@nvidia.com>
References: <cover.1700503643.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: df97c35e-9ae8-4eca-97f1-08dbe9f672e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o2NcuFb6gFtF8Mq2CYIfr2eB8eny2i+yPDGdIZFeuUPLNhhqiaay3drHQFhk3WlCgn7ionJLrWaliaYvatj3jijwYd8DOEMNux1GqvhcXkLbXr9XqVfbCi90qkf/BNyh7CspP+E59NAXTKtAc4i8NJNOaNAnBv/HXQpflzOhWEGUc5cKDPHA996v2VAFa4Tb7e8lBWoDCd9thlYWLyBTxT4G9HowsSknuQhuLQtW2KVHHJkqDDqnXoaaixR38BzgOFia0mfLqi1ssFbcf6DeE39gNXz70bGKX4A9ax5oi1uF6UB+yaIcFpH9QYjV861K5vZAiviitIgW9jiR0EFGCB3fMcGHAFNPmKnw0uzuK2kedM9dYgdcsnNISC895AIXgy25SscuTc880IWJuDOn76uqm808mDPqOVY8NXWgDBZ25Dc2VuS1LwRkGXndxQXmn+RieCV4P0ERENeyvaDdYBo6vUvvRDq3BaP6ubMtOxiuTkM3WEwJSK5XmvPPrgNugqt9yWyUIyCMhT9YxOuEBOOD5Jad5ErQWR2SsZFRXh+5EntymzZSNqW0HNMthfd5tbktRlkSPEQeyaghzqLXXK3DMQqtGwkA4a8hdlRVUoF5JMW+kS9xEQIk/5SsP4e662mYdh36oDQv/lfqz53Bk3mcRznSFC/RdLz42kjRnFBoPEwO1Yo/condvL3DE6GmBbZJeOIpF7Gm3c8Tm2Y+5Mcu/F7EB66lDID/36hX1UaEQCzFz64vB1gHu/R6IvYH
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(41300700001)(36756003)(86362001)(5660300002)(40460700003)(2906002)(40480700001)(36860700001)(356005)(478600001)(7636003)(6666004)(47076005)(336012)(426003)(2616005)(26005)(82740400003)(16526019)(4326008)(8676002)(8936002)(107886003)(316002)(110136005)(70586007)(54906003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:28:10.0305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df97c35e-9ae8-4eca-97f1-08dbe9f672e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

CFF mode, for Compressed FID Flooding, is a way of organizing flood vectors
in the PGT table. The bus module determines whether CFF is supported, can
configure flood mode to CFF if it is, and knows what flood mode has been
configured. Therefore add a bus callback to determine the configured flood
mode. Also add to core an API to query it.

Since after this patch, we rely on mlxsw_pci->flood_mode being set, it
becomes a coding error if a driver invokes this function with a set of
fields that misses the initialization. Warn and bail out in that case.

The CFF mode is not used as of this patch. The code to actually use it will
be added later.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c |  7 +++++++
 drivers/net/ethernet/mellanox/mlxsw/core.h |  3 +++
 drivers/net/ethernet/mellanox/mlxsw/pci.c  | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index f23421f038f3..e4d7739bd7c8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -211,6 +211,13 @@ mlxsw_core_lag_mode(struct mlxsw_core *mlxsw_core)
 }
 EXPORT_SYMBOL(mlxsw_core_lag_mode);
 
+enum mlxsw_cmd_mbox_config_profile_flood_mode
+mlxsw_core_flood_mode(struct mlxsw_core *mlxsw_core)
+{
+	return mlxsw_core->bus->flood_mode(mlxsw_core->bus_priv);
+}
+EXPORT_SYMBOL(mlxsw_core_flood_mode);
+
 void *mlxsw_core_driver_priv(struct mlxsw_core *mlxsw_core)
 {
 	return mlxsw_core->driver_priv;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index 764d14bd5bc0..a93e9c38848a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -38,6 +38,8 @@ unsigned int mlxsw_core_max_ports(const struct mlxsw_core *mlxsw_core);
 int mlxsw_core_max_lag(struct mlxsw_core *mlxsw_core, u16 *p_max_lag);
 enum mlxsw_cmd_mbox_config_profile_lag_mode
 mlxsw_core_lag_mode(struct mlxsw_core *mlxsw_core);
+enum mlxsw_cmd_mbox_config_profile_flood_mode
+mlxsw_core_flood_mode(struct mlxsw_core *mlxsw_core);
 
 void *mlxsw_core_driver_priv(struct mlxsw_core *mlxsw_core);
 
@@ -489,6 +491,7 @@ struct mlxsw_bus {
 	u32 (*read_utc_sec)(void *bus_priv);
 	u32 (*read_utc_nsec)(void *bus_priv);
 	enum mlxsw_cmd_mbox_config_profile_lag_mode (*lag_mode)(void *bus_priv);
+	enum mlxsw_cmd_mbox_config_profile_flood_mode (*flood_mode)(void *priv);
 	u8 features;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 5b1f2483a3cc..845edd43032b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -106,7 +106,9 @@ struct mlxsw_pci {
 	u64 utc_sec_offset;
 	u64 utc_nsec_offset;
 	bool lag_mode_support;
+	bool cff_support;
 	enum mlxsw_cmd_mbox_config_profile_lag_mode lag_mode;
+	enum mlxsw_cmd_mbox_config_profile_flood_mode flood_mode;
 	struct mlxsw_pci_queue_type_group queues[MLXSW_PCI_QUEUE_TYPE_COUNT];
 	u32 doorbell_offset;
 	struct mlxsw_core *core;
@@ -1251,6 +1253,10 @@ static int mlxsw_pci_config_profile(struct mlxsw_pci *mlxsw_pci, char *mbox,
 			mbox, 1);
 		mlxsw_cmd_mbox_config_profile_flood_mode_set(
 			mbox, profile->flood_mode);
+		mlxsw_pci->flood_mode = profile->flood_mode;
+	} else {
+		WARN_ON(1);
+		return -EINVAL;
 	}
 	if (profile->used_max_ib_mc) {
 		mlxsw_cmd_mbox_config_profile_set_max_ib_mc_set(
@@ -1654,6 +1660,9 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 
 	mlxsw_pci->lag_mode_support =
 		mlxsw_cmd_mbox_query_fw_lag_mode_support_get(mbox);
+	mlxsw_pci->cff_support =
+		mlxsw_cmd_mbox_query_fw_cff_support_get(mbox);
+
 	num_pages = mlxsw_cmd_mbox_query_fw_fw_pages_get(mbox);
 	err = mlxsw_pci_fw_area_init(mlxsw_pci, mbox, num_pages);
 	if (err)
@@ -1970,6 +1979,14 @@ mlxsw_pci_lag_mode(void *bus_priv)
 	return mlxsw_pci->lag_mode;
 }
 
+static enum mlxsw_cmd_mbox_config_profile_flood_mode
+mlxsw_pci_flood_mode(void *bus_priv)
+{
+	struct mlxsw_pci *mlxsw_pci = bus_priv;
+
+	return mlxsw_pci->flood_mode;
+}
+
 static const struct mlxsw_bus mlxsw_pci_bus = {
 	.kind			= "pci",
 	.init			= mlxsw_pci_init,
@@ -1982,6 +1999,7 @@ static const struct mlxsw_bus mlxsw_pci_bus = {
 	.read_utc_sec		= mlxsw_pci_read_utc_sec,
 	.read_utc_nsec		= mlxsw_pci_read_utc_nsec,
 	.lag_mode		= mlxsw_pci_lag_mode,
+	.flood_mode		= mlxsw_pci_flood_mode,
 	.features		= MLXSW_BUS_F_TXRX | MLXSW_BUS_F_RESET,
 };
 
-- 
2.41.0


