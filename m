Return-Path: <netdev+bounces-51750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A07FBE94
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B532A2824CB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9B35294;
	Tue, 28 Nov 2023 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="secVFOLY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A8E12A
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:52:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb8dbrWYH07tStWzP07a/DrHA/fEAWDLB35V5IjarcMo415nTI0ZmTgq+vYARO3bm/AFBocCZoT/NggHWvp40EFlb/bf+0FcZ6+zxXHFMj+FTDxVQDVktLX2FN4chtRJh56ITDo8wV6nWBrk6PSNTiQpAU7vpqNJLKLwrjsYVknl6CpP5Mu5y78fwc8plyoad6JTcXrt9RDwd/X4UaJ/xcCYdDO+B+NZdyFbmcb3TGHJVf/jrojrvPhGuiO/iwYA/iNayZDCGZtOoZflh8bP3EbxeRJBBtSGFQhEV4055OHbRkcnpl8ZPw2yzyV5gQ2wOPzRcwTK2ozpu2cOMknB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQV79axdq0SmpqaPopUxA4oJxhj8ac1RTvzqMnaYkKU=;
 b=SxXFouQlkNXmY2aY08SdBGb8dkRswrDK/jPcu6uoGwCcpzw+GmeEMkFl9C6gNm7BywqdkPb9e0Cbo+8vRsVOqOyLWHdX5RwG1+ur65vnITAHPff/e8mdcDDeHsatBgaiGugiyp95erYc9UZlJAQnhsAhRvRb0j/H9Vwtj3IoRw17oHEN3hKCqCfgEc8xSboCU9sSXEHABwBq7NEwnwAFMPcgTwZSR1izF01LANfRko+AGiCEE/rB52PVtbuEq0GWsGSRV2pa+Km4VvH6QXuML97faKtNggpDCYm0q4RIU29TuV4dKiWwcQAjz5xnCBhw48yOigVKJzZkDNijdkjdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQV79axdq0SmpqaPopUxA4oJxhj8ac1RTvzqMnaYkKU=;
 b=secVFOLYYV5bqbYMLZaK/4jf4/ShJs9BIQwSjRWEnlj/EdjIXZRiTn+bdxtG0b60m3RT05QsZzm5ucLzWD5umpEUboIj+IX+cQBq4nC7wNI2q1632BrlpjzHBY1rsJw6ZmB/rP00g4rWmF2g+Mnr1TTOUUIpwhNERXTrN71dx85UVrDnGLvPmdGQqdfSk4dNTIXI/xxEhdMNSv/QFDK3VqM/i27BAGNTFEDJ88CPWrisIIxra7+WRbX4aj9/OoOzluOFcU5ZILj42S/w6F+SWL5lWDpJFwaVlpACPOpuzuhq6N0cCyVIgZvnqzCMAyGUR2QvhCCMCtoaOFqyz10mWQ==
Received: from MW2PR2101CA0002.namprd21.prod.outlook.com (2603:10b6:302:1::15)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 15:52:03 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::55) by MW2PR2101CA0002.outlook.office365.com
 (2603:10b6:302:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14 via Frontend
 Transport; Tue, 28 Nov 2023 15:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:52:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:46 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:44 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 15/17] mlxsw: spectrum_fid: Add a family for bridge FIDs in CFF flood mode
Date: Tue, 28 Nov 2023 16:50:48 +0100
Message-ID: <ca40b8163e6d6a21f63ef299619acee953cf9519.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db29662-7ce5-453d-f02e-08dbf029f6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5anfnRdKhwI0+rVdmSgNhGoVgRzCObGm4AP3QaKuft9jDMpAkmFreOEMftUQ1ha42nCYZasmf2lcK+Sa1SZ6tYQGC06CpKhmhLENzzEQtdJNGt172f7bppCQsBiFV0OCvMz1itWXgQIGRVItX0GWThfUGN00LWc+EalZITYKny16Fbvz4TqdO/WAgDgu/8hE/WKVD59S1p+Tzx+9WTeSrznGUCv7dF9fDIrT5yh9LJLxhqtkKpniSVaftQdyRs1mZRuuSRiWE4dVDAziN7wQYIvO1ruisWLUxzC2anmVvtVg1jFyCEZnB7UsLOry61AXnuPvbFNuMSnnKlA7HMmsemOb573dPr9428oKBIp4S9GrBahEXP18Zu3eJYvHxKGNJQXWNIwZlHt8+KPzZXa3qK/gZhUUunVHT+nenwHxYdCrEPMtpwUjv4Yt3+dRzf6cco7EZtlq0w7G18yQ4VjFaDIBanZJVsdw0qhQsapxSvGGtOb6w5P/FYC+3IglZpjbk1DW3BBDuDabcPsOfXT3ReM0MnGYYqzLxo/TcEzkFCM9gvVO0f5irrgG1G3Z+BJG6HjyAQfx9879xtSHUYa+8mZfARRHrHreUo4At7C2TnKwyntfADa190syjuCEG5SgwBgCv/c+TzCWaIzeyj0AGzsrE1nuc9D/CtqdYDi07AykBO/qJHBXyGqdEjHKa5G+NrBxq2omr9Ow7EjRhGv+RIt8ezXYGtFOvJqt768xnWaGSZhudfZ0siDxJN6f3pbd
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(8936002)(8676002)(4326008)(66899024)(54906003)(110136005)(70586007)(70206006)(316002)(478600001)(40460700003)(47076005)(36860700001)(7636003)(356005)(36756003)(41300700001)(86362001)(107886003)(16526019)(26005)(40480700001)(2906002)(2616005)(83380400001)(426003)(336012)(5660300002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:52:02.6375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db29662-7ce5-453d-f02e-08dbf029f6bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

In this patch, add the artifacts for 802.1d and 802.1q FID families that
work in CFF flood mode.

In CFF flood mode, the way flood vectors are looked up changes: there's a
per-FID PGT base, to which a small offset is added depending on type of
traffic. Thus each FID occupies a small contiguous block of PGT memory,
whereas in the controlled flood mode, flood vectors for a given FID were
spread across the PGT.

The term "flood table" as used by the spectrum_fid module, borrows from
controlled flood mode way of organizing the PGT table. There flood tables
were actual tables, contiguous in the PGT. In the CFF flood mode, they are
more abstract: a flood table becomes a collection of e.g. all first rows of
the per-FID PGT blocks. Nonetheless we retain the nomenclature.

FIDs are still configured through the SFMR register, but there are
different fields to set under CFF mode: PGT base and profile. Thus register
packing gets a dedicated op overload as well.

The new organization of PGT makes it possible to treat the PGT as a block
of an ordinary memory, allocate and deallocate on demand, and achieve
better flexibility. Here instead, we aim to keep the code as close as
possible to the previous controlled flood mode, support for which we need
to retain for Spectrum-1 and older FW versions anyway. Thus the PGT
footprint of the individual families is the same as before, just the
internal organization of the per-family PGT region differs. Hence the
pgt_size callback is reused between the controlled and CFF flood modes.

Since the dummy family has no flood tables in either the CTL mode or in
CFF mode, the existing one can be reused for the CFF family array.

Users should not notice any changes between the controlled and CFF flood
modes.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 8c4377081872..696a7ed30709 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -493,6 +493,32 @@ static void mlxsw_sp_fid_pack_ctl(char *sfmr_pl,
 					     fid->fid_family->bridge_type);
 }
 
+static u16
+mlxsw_sp_fid_off_pgt_base_cff(const struct mlxsw_sp_fid_family *fid_family,
+			      u16 fid_offset)
+{
+	return fid_family->pgt_base +
+		fid_offset * fid_family->flood_profile->nr_flood_tables;
+}
+
+static u16 mlxsw_sp_fid_pgt_base_cff(const struct mlxsw_sp_fid *fid)
+{
+	return mlxsw_sp_fid_off_pgt_base_cff(fid->fid_family, fid->fid_offset);
+}
+
+static void mlxsw_sp_fid_fid_pack_cff(char *sfmr_pl,
+				      const struct mlxsw_sp_fid *fid,
+				      enum mlxsw_reg_sfmr_op op)
+{
+	struct mlxsw_sp_fid_family *fid_family = fid->fid_family;
+	u16 pgt_base = mlxsw_sp_fid_pgt_base_cff(fid);
+
+	mlxsw_sp_fid_pack(sfmr_pl, fid, op);
+	mlxsw_reg_sfmr_cff_mid_base_set(sfmr_pl, pgt_base);
+	mlxsw_reg_sfmr_cff_prf_id_set(sfmr_pl,
+				      fid_family->flood_profile->profile_id);
+}
+
 static int mlxsw_sp_fid_op(const struct mlxsw_sp_fid *fid, bool valid)
 {
 	struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
@@ -1168,6 +1194,32 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops_ctl = {
 	.fid_pack		= mlxsw_sp_fid_pack_ctl,
 };
 
+static u16
+mlxsw_sp_fid_fid_mid_cff(const struct mlxsw_sp_fid *fid,
+			 const struct mlxsw_sp_flood_table *flood_table)
+{
+	return mlxsw_sp_fid_pgt_base_cff(fid) + flood_table->table_index;
+}
+
+static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops_cff = {
+	.setup			= mlxsw_sp_fid_8021d_setup,
+	.configure		= mlxsw_sp_fid_8021d_configure,
+	.deconfigure		= mlxsw_sp_fid_8021d_deconfigure,
+	.index_alloc		= mlxsw_sp_fid_8021d_index_alloc,
+	.compare		= mlxsw_sp_fid_8021d_compare,
+	.port_vid_map		= mlxsw_sp_fid_8021d_port_vid_map,
+	.port_vid_unmap		= mlxsw_sp_fid_8021d_port_vid_unmap,
+	.vni_set		= mlxsw_sp_fid_8021d_vni_set,
+	.vni_clear		= mlxsw_sp_fid_8021d_vni_clear,
+	.nve_flood_index_set	= mlxsw_sp_fid_8021d_nve_flood_index_set,
+	.nve_flood_index_clear	= mlxsw_sp_fid_8021d_nve_flood_index_clear,
+	.fdb_clear_offload	= mlxsw_sp_fid_8021d_fdb_clear_offload,
+	.vid_to_fid_rif_update	= mlxsw_sp_fid_8021d_vid_to_fid_rif_update,
+	.pgt_size		= mlxsw_sp_fid_8021d_pgt_size,
+	.fid_mid		= mlxsw_sp_fid_fid_mid_cff,
+	.fid_pack		= mlxsw_sp_fid_fid_pack_cff,
+};
+
 #define MLXSW_SP_FID_8021Q_MAX (VLAN_N_VID - 2)
 #define MLXSW_SP_FID_RFID_MAX (11 * 1024)
 
@@ -1522,6 +1574,25 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q_ops_ctl = {
 	.fid_pack		= mlxsw_sp_fid_pack_ctl,
 };
 
+static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q_ops_cff = {
+	.setup			= mlxsw_sp_fid_8021q_setup,
+	.configure		= mlxsw_sp_fid_8021q_configure,
+	.deconfigure		= mlxsw_sp_fid_8021q_deconfigure,
+	.index_alloc		= mlxsw_sp_fid_8021d_index_alloc,
+	.compare		= mlxsw_sp_fid_8021q_compare,
+	.port_vid_map		= mlxsw_sp_fid_8021q_port_vid_map,
+	.port_vid_unmap		= mlxsw_sp_fid_8021q_port_vid_unmap,
+	.vni_set		= mlxsw_sp_fid_8021d_vni_set,
+	.vni_clear		= mlxsw_sp_fid_8021d_vni_clear,
+	.nve_flood_index_set	= mlxsw_sp_fid_8021d_nve_flood_index_set,
+	.nve_flood_index_clear	= mlxsw_sp_fid_8021d_nve_flood_index_clear,
+	.fdb_clear_offload	= mlxsw_sp_fid_8021q_fdb_clear_offload,
+	.vid_to_fid_rif_update	= mlxsw_sp_fid_8021q_vid_to_fid_rif_update,
+	.pgt_size		= mlxsw_sp_fid_8021d_pgt_size,
+	.fid_mid		= mlxsw_sp_fid_fid_mid_cff,
+	.fid_pack		= mlxsw_sp_fid_fid_pack_cff,
+};
+
 /* There are 4K-2 802.1Q FIDs */
 #define MLXSW_SP_FID_8021Q_START	1 /* FID 0 is reserved. */
 #define MLXSW_SP_FID_8021Q_END		(MLXSW_SP_FID_8021Q_START + \
@@ -1633,7 +1704,32 @@ static const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr_ctl[] = {
 	[MLXSW_SP_FID_TYPE_RFID]	= &mlxsw_sp_fid_rfid_family_ctl,
 };
 
+static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021q_family_cff = {
+	.type			= MLXSW_SP_FID_TYPE_8021Q,
+	.fid_size		= sizeof(struct mlxsw_sp_fid_8021q),
+	.start_index		= MLXSW_SP_FID_8021Q_START,
+	.end_index		= MLXSW_SP_FID_8021Q_END,
+	.flood_profile		= &mlxsw_sp_fid_8021d_flood_profile,
+	.rif_type		= MLXSW_SP_RIF_TYPE_VLAN,
+	.ops			= &mlxsw_sp_fid_8021q_ops_cff,
+	.smpe_index_valid	= true,
+};
+
+static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021d_family_cff = {
+	.type			= MLXSW_SP_FID_TYPE_8021D,
+	.fid_size		= sizeof(struct mlxsw_sp_fid_8021d),
+	.start_index		= MLXSW_SP_FID_8021D_START,
+	.end_index		= MLXSW_SP_FID_8021D_END,
+	.flood_profile		= &mlxsw_sp_fid_8021d_flood_profile,
+	.rif_type		= MLXSW_SP_RIF_TYPE_FID,
+	.ops			= &mlxsw_sp_fid_8021d_ops_cff,
+	.smpe_index_valid	= true,
+};
+
 static const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr_cff[] = {
+	[MLXSW_SP_FID_TYPE_8021Q]	= &mlxsw_sp2_fid_8021q_family_cff,
+	[MLXSW_SP_FID_TYPE_8021D]	= &mlxsw_sp2_fid_8021d_family_cff,
+	[MLXSW_SP_FID_TYPE_DUMMY]	= &mlxsw_sp2_fid_dummy_family,
 };
 
 static struct mlxsw_sp_fid *mlxsw_sp_fid_lookup(struct mlxsw_sp *mlxsw_sp,
-- 
2.41.0


