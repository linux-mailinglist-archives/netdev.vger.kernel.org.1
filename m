Return-Path: <netdev+bounces-51737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD7F7FBE83
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3945E1C20E85
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA11E4B7;
	Tue, 28 Nov 2023 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mo6GLL+Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99221D2
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWSnIpyszEkcAiU82WKwp03BJKla6i4pgrim4/IH6MNPxa1LJJ6Kpem7sJKdpw9Rc/2/afvnQNo+4k0PILNqg4vqRoMmjE8muIIAwyS8uvZ70A4i+mSfgRRHnzop1EcIErx+RIvnVQDRQCT9D4aD5KGau5o29nU3WtzYTP5jgvBzWZrvfsxQiJPDm8Epr8d0wqZxwylM9sHCobdOIrT79xWbY1+tKit/jZM8Kx001Qg5BwtxkwMkl3lhGLyTntu5IEDghE1vwM5R0+XYSu7UvSfysglnJyk0gLgcNhm8vNIWiw3aJ9QbzUqALRzKGu1KUfaiIxu1kHI9gT1YUbFtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqSlNQtEPXHuR1didDrhQy1O+KtPSmqgV3hZTnNiu94=;
 b=fXx3K8we2iGuPBDaZJfl8/vqpiJCuy8YIvZREZkI5Lo8hVIgAfnFqGDzR2vMz8jFceaZYqRfBzqeDjvT7h8Z/cQxkqP8JyACDkyha5/pzOROmNj2zoOwVv2K3lEazO13a2qyqQt2OTJTqbQpAaGOFuCx2J9kiFQ3qQi89AHxUi3T32FJdwjUglkqiHA8XIRMSu1wugV/SMyLflQMnB4R9awGxEdGq3nEfwuPKmwHHdpFjwOjM76zRzn/o2gKnkPYWP16zFBHf8gB72kqz8zRjehdfiQekFe6wy01Bq+IhSHF3/FU4V1RIOKHjG7kRH4zXJdUJ2AKP3OyztZ63gS/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqSlNQtEPXHuR1didDrhQy1O+KtPSmqgV3hZTnNiu94=;
 b=mo6GLL+YaFyT8KOhyA7gfzCRa29+5ymaBi6Rxsy2lffviwTmmJBsqUR8mfcswcWadOyAZB2HayTFjoiFkA2H6UeooiJoPcup7tJaAxAkBGFR5CEViQogvmNGTdvDqnWZeZ/VSTHCtxpzSVTcrNesoQfoHiDjKeNWBNyEjomV8DHS/tnqlbMEQR7erYDT0doSybgryBcfp6BoYtmZas4lJnwNTH59hEKcfSO2FzcZ8uDdwls7OfaMRaEYLpedwZF8jZfmqTAJxbthPeUhyhYwTOqbePrqVqpOsxtfCVQLHBCT7ZD2y8DD/sZwnCJ7LyeDwG2iip7n1NtIYKVGPpS58g==
Received: from CYXPR02CA0091.namprd02.prod.outlook.com (2603:10b6:930:ce::6)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 15:51:28 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::c7) by CYXPR02CA0091.outlook.office365.com
 (2603:10b6:930:ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:20 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:18 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/17] mlxsw: spectrum_fid: Move mlxsw_sp_fid_flood_table_init() up
Date: Tue, 28 Nov 2023 16:50:38 +0100
Message-ID: <aef09e26b0c2dd077531e665d7135b300bdaf0a8.1701183892.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701183891.git.petrm@nvidia.com>
References: <cover.1701183891.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 8211ef91-e58b-48d8-2ab0-08dbf029e1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FpSy5aMjLdvn7nZc16iqzrtJa8enuhd0t9Vicz8D/rGd+eiJKA2fK2i/YLpmFe1WiFN/eCTsIJzQreQAoq+fr7zS+VbNE30yeEQTUBbsIKuqxIAIk3HbaC1ClzshDCJrRexpc2wTEYH2VwS4C62Ckpt2jsp/8PmTB4ZIpzZe4H8Ytf/FVgyL+0naUaPBD0hM1f6KUQRc/zvP/V7wwPuO6BeH6SjttJNG7vPQdwQUGpfuzP22wIfCyo9yr1FrKR9kiMaBpQT+pcyhZasN4g1VltOkmwlJ7FAgGRStD2ztNLM2K6ykdINyQWoDS0ZzIz1Z5e6J0JS0lqSMcZZqxVHxX75Pl+NmmTDD5iBt6Um0wTKPHtbio/I2h273GRT/UgWFmlBnjHrch18/A/p2/qMbXXwqajBkmYxNiB35kmQw5UIFMSwN6lZzdLJGi+T+wCgyUvXGkf64WG39YyVqi4lnollVFh4C4iNePb/QwmiKgTLq92I08ylHwAbOAheuZxDsBfvetFyyHca38EHS4SYqqeF3G058yd6xFY9F5KHjfTIAMt3PDo89Hv0wwvWlQDGuJId+vgCxWEL3spHg9UAqJbqDotrV3l7Xo8pMtv790MBKZUFy3ET0U7p5Xq/3DLyv5HWoLgmiWa7UfSljD4xgaBcyzo8tBehXc7GEjJYlRrJEgsdviLRvz/nX+o9b0ICV7rdtYSI1mj/2R6JxCK3o68ueWnNXndIu400pKtCqBWQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(83380400001)(356005)(7636003)(47076005)(82740400003)(336012)(5660300002)(8936002)(4326008)(8676002)(6666004)(426003)(86362001)(70206006)(316002)(110136005)(70586007)(36860700001)(54906003)(478600001)(36756003)(40480700001)(41300700001)(2906002)(107886003)(16526019)(26005)(2616005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:27.4214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8211ef91-e58b-48d8-2ab0-08dbf029e1c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

Move the function to the point where it will need to be to be visible for
the 802.1d ops.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 60 +++++++++----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index ab0632bd5cd4..0c7295d7e693 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -1077,6 +1077,36 @@ mlxsw_sp_fid_8021d_vid_to_fid_rif_update(const struct mlxsw_sp_fid *fid,
 	return 0;
 }
 
+static int
+mlxsw_sp_fid_flood_table_init(struct mlxsw_sp_fid_family *fid_family,
+			      const struct mlxsw_sp_flood_table *flood_table)
+{
+	enum mlxsw_sp_flood_type packet_type = flood_table->packet_type;
+	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
+	const int *sfgc_packet_types;
+	u16 mid_base;
+	int err, i;
+
+	mid_base = mlxsw_sp_fid_pgt_base_ctl(fid_family, flood_table);
+
+	sfgc_packet_types = mlxsw_sp_packet_type_sfgc_types[packet_type];
+	for (i = 0; i < MLXSW_REG_SFGC_TYPE_MAX; i++) {
+		char sfgc_pl[MLXSW_REG_SFGC_LEN];
+
+		if (!sfgc_packet_types[i])
+			continue;
+
+		mlxsw_reg_sfgc_pack(sfgc_pl, i, fid_family->bridge_type,
+				    flood_table->table_type, 0, mid_base);
+
+		err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfgc), sfgc_pl);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops_ctl = {
 	.setup			= mlxsw_sp_fid_8021d_setup,
 	.configure		= mlxsw_sp_fid_8021d_configure,
@@ -1675,36 +1705,6 @@ struct mlxsw_sp_fid *mlxsw_sp_fid_dummy_get(struct mlxsw_sp *mlxsw_sp)
 	return mlxsw_sp_fid_get(mlxsw_sp, MLXSW_SP_FID_TYPE_DUMMY, NULL);
 }
 
-static int
-mlxsw_sp_fid_flood_table_init(struct mlxsw_sp_fid_family *fid_family,
-			      const struct mlxsw_sp_flood_table *flood_table)
-{
-	enum mlxsw_sp_flood_type packet_type = flood_table->packet_type;
-	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
-	const int *sfgc_packet_types;
-	u16 mid_base;
-	int err, i;
-
-	mid_base = mlxsw_sp_fid_pgt_base_ctl(fid_family, flood_table);
-
-	sfgc_packet_types = mlxsw_sp_packet_type_sfgc_types[packet_type];
-	for (i = 0; i < MLXSW_REG_SFGC_TYPE_MAX; i++) {
-		char sfgc_pl[MLXSW_REG_SFGC_LEN];
-
-		if (!sfgc_packet_types[i])
-			continue;
-
-		mlxsw_reg_sfgc_pack(sfgc_pl, i, fid_family->bridge_type,
-				    flood_table->table_type, 0, mid_base);
-
-		err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfgc), sfgc_pl);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 static int
 mlxsw_sp_fid_flood_tables_init(struct mlxsw_sp_fid_family *fid_family)
 {
-- 
2.41.0


