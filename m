Return-Path: <netdev+bounces-57426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92AA813137
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808721F2225C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19E55769;
	Thu, 14 Dec 2023 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="px4CyyBM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768C116
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRJrfghbQyES+vvgW6N+OXBJVhUQXMHoc8nZteEmBPtPPyEKtKeYRWUJ5VxEnc6kpHbBSKvzyEqUPCyN8nVvOLZ/DI7eb/bz80w6/Oecjvvat48YPvhat3xHuQz0xxRKJ1M3vVLQbMrgBndtTZnEBJLeIDU8Gt0H8uOH2I78r/RaofnarzYmDV33zErNlMaK9hcdvH5rWPrO8yFTONqTkxcEb4zqzQhZnc3M6K/5xD6m5eKlJEcQLy9Qq0GjnE/owDlbWrgXoBBlavgYjI82kqnzbwAHn2Z7xnZnw0TFtgul9HuGXes9Cd4y68YqYBIV+63Tw42gFqiCNfE8mS+GAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfMkKP5wvfPC33SQ750b3iymbxJdwcbYXzWLUYCcjNs=;
 b=ZvqV5dtjJsVlTsi2U1CpRMh+Q0UU/e2XWM5VXxWo75F/5oDHlMP69IQdzEAwQuk+RmL9+P96vfdEPqutfiTv3HBoiwMEQjkKZcz+GEm3udPSMNYqkjXGLYnIMb7eLPZhKRwGEPmENjrmV/9Uu25LFhV7oTpV42GixzVNi0oXARqtPZbiboekXv4RiDzL1a9zU9QfEhla74CsoF55pXMrCRzM7E7lKOElqdWR4SC3ZVNjKvNg8I28I/Mynnu46+GPHBvFpE1NG4i9/fMNoaEmqH9akcOlFuzmkXJapzCl8cD+it2RL/c/S3F0UCciQe7lj7DwgWq0sta5EVnBkvlLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfMkKP5wvfPC33SQ750b3iymbxJdwcbYXzWLUYCcjNs=;
 b=px4CyyBM/90HrFo0rySr2mDZjPRO2amU/VgB6ym4YuolYrn5egnQuLLENh3LSjFr90Yuor7Kwa05Ouxqc2YEnHS50ri5Sti9J+Noit4NB9S7sIb3pXQ2tuRT+az/YNMvkolVZ+bpFfUS1cauWda13Pz9Uwx8tqzBYe0hi4L6qgsLwLzHDoeWYB41at6nyJhCncgdM639nwKjKMnwGVsPTdQB68R5SZNKrWPVHW3G3qu99WJ7L6WdZuppI0HHIzANlvMacKfpuZrS8usYeTRSH9Y2l+BZr4OkcQWpz0p8RbmVSlEyjRqBPWd9WONPe2EI69x6jbRSBiIMNlzXhcswpA==
Received: from MW4PR03CA0005.namprd03.prod.outlook.com (2603:10b6:303:8f::10)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.38; Thu, 14 Dec 2023 13:19:51 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::51) by MW4PR03CA0005.outlook.office365.com
 (2603:10b6:303:8f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 13:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 13:19:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 05:19:33 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 05:19:31 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/3] mlxsw: spectrum_fid: Add an "any" packet type
Date: Thu, 14 Dec 2023 14:19:06 +0100
Message-ID: <072ac59739e077cba93a4684b7a8a408010c8d29.1702557104.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1702557104.git.petrm@nvidia.com>
References: <cover.1702557104.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4faeb6-17b8-499c-0bc9-08dbfca75a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S1nUDjfc7A3fKY2+1H8jP/go8EfuTglSq5P0jBDUpdd4NmAaAwrbiyvkNeZYyfUrN/fAKhbMc4zprO6ZEL3PjvKoUQyRYOvQTWTZs489u5BRtW6hwcs2ut808aLyhaQluAu8zUD109D1HtRpE2mp0B38r28gOb3AZxxqu28+2vgrEU3Rus5URiA2xZxccSV8vP4GdWgb+rihXzHUmCY7Mk4jpR7k4GAgIFxRYT4YuVmPCEEBy98P5KM0MVRJOCTbGDlWfAyEFkEAxyr5fEEb/7NQi5Dl6PP/d4X7s02nnYfYunDZ1v6QipF6Vs0BV+ovfPZid/a+tm/7n1hILV6Rxs5aMrXITrdrYLPksnMJmRywh4Q6Al7vbWnkIJQC5IMMBB21UbiQKIDl2NaarxktJ/VrMT3RW85vpepWPGf0ObynVWzW7hBmf9aT9jMWmWsB2aDTnwRMpHFPwfS+es83izln9daKAUxSGNHvgfMybESPPWpKglLZLrbJuzd6NNuFBxBqhXpw3iWYfslza0U66jRli31+rStjxRVgJac/7q5xKB1Rd9FbZJ/iKbdjUfK/0Ebl6ttRUQhL23e0te/Ts8ST7azA6dYwkAA1aH6KjBuNyIcZ1P1j8bHCwOxvz+ceqNPyS5f65FPaJqE+joR5q09P8P/uN4yZTU6G+6xojQXUPa95SIeWFu5guu2vtSB0WivdGURR8W44Qakm7EN+9KYoUCZbBudDbwNdVDsJhAREaC62NQTu75wRg/8ER5kF
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(82740400003)(40460700003)(7636003)(426003)(2616005)(107886003)(336012)(26005)(47076005)(8936002)(8676002)(16526019)(4326008)(110136005)(316002)(5660300002)(2906002)(36860700001)(478600001)(6666004)(54906003)(70206006)(70586007)(41300700001)(356005)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:19:51.0748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4faeb6-17b8-499c-0bc9-08dbfca75a86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446

Flood profiles have been used prior to CFF support for NVE underlay. Like
is the case with FID flooding, an NVE profile describes at which offset a
datum is located given traffic type. mlxsw currently only ever uses one KVD
entry for NVE lookup, i.e. regardless of traffic type, the offset is always
zero. To be able to describe this, add a traffic type enumerator describing
"any traffic type".

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 61612c413310..a0c9775fa955 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -515,6 +515,8 @@ enum mlxsw_sp_flood_type {
 	MLXSW_SP_FLOOD_TYPE_MC,
 	/* For RSP FIDs in CFF mode. */
 	MLXSW_SP_FLOOD_TYPE_NOT_UC,
+	/* For NVE traffic. */
+	MLXSW_SP_FLOOD_TYPE_ANY,
 };
 
 int mlxsw_sp_port_get_stats_raw(struct net_device *dev, int grp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 401117086235..379a911f463f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -167,11 +167,22 @@ static const int mlxsw_sp_sfgc_not_uc_packet_types[MLXSW_REG_SFGC_TYPE_MAX] = {
 	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_IPV4]	= 1,
 };
 
+static const int mlxsw_sp_sfgc_any_packet_types[MLXSW_REG_SFGC_TYPE_MAX] = {
+	[MLXSW_REG_SFGC_TYPE_UNKNOWN_UNICAST]			= 1,
+	[MLXSW_REG_SFGC_TYPE_BROADCAST]				= 1,
+	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_NON_IP]	= 1,
+	[MLXSW_REG_SFGC_TYPE_IPV4_LINK_LOCAL]			= 1,
+	[MLXSW_REG_SFGC_TYPE_IPV6_ALL_HOST]			= 1,
+	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_IPV6]	= 1,
+	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_IPV4]	= 1,
+};
+
 static const int *mlxsw_sp_packet_type_sfgc_types[] = {
 	[MLXSW_SP_FLOOD_TYPE_UC]	= mlxsw_sp_sfgc_uc_packet_types,
 	[MLXSW_SP_FLOOD_TYPE_BC]	= mlxsw_sp_sfgc_bc_packet_types,
 	[MLXSW_SP_FLOOD_TYPE_MC]	= mlxsw_sp_sfgc_mc_packet_types,
 	[MLXSW_SP_FLOOD_TYPE_NOT_UC]	= mlxsw_sp_sfgc_not_uc_packet_types,
+	[MLXSW_SP_FLOOD_TYPE_ANY]	= mlxsw_sp_sfgc_any_packet_types,
 };
 
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_index(struct mlxsw_sp *mlxsw_sp,
-- 
2.41.0


