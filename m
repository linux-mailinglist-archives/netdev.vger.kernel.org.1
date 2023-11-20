Return-Path: <netdev+bounces-49339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13C7F1C5B
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986E31F25A15
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB0231A8F;
	Mon, 20 Nov 2023 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gaLwew+o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3392
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlCI8XUldkgTDeEiHPddMJVZ3a9HxLAK6BCDuda7QOzApLPgSS+WoesJEGzbt6BNRas5YlvIJv5/a5jBqLlkxOC57oR/+1Q5fdLIgMuwVrXNm5zqvArBKOwZ+2nc/0Scc7MChvn5B8LaWjcdIKrqgL7K9EIv5XfncoE7VhJvgRV7LBH9vAK4gdRV493BE78bjrgGgejXF/0nyXBml2bn/jh8gcFafEcoqdwf36nCu40gD26i4VLXkcA3fmiEiHfnK299UqrAgNRIPkX/a8wClQ6VB5FRYc1yjhh3Y/FEx1f3GyhzYTfr6jbMQraoos5bUFyke4kuSIGylYW/HOYnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnjLEfU1ttZ1AJv7cawqtQGqbgj/1eU7JQ/t+wVG1wo=;
 b=VHtipwA+Ph+50xLhC1s6hnbyb2gPYlmYX5BiTq++3iz6IzLv0pedDFK8H/3K9ShyOsk/cswF6/EFJyAkI3bT7c9QjmxDHTjm1Fw+ObSdXCeCD4x7Pxut4RtjV9Ct9YHIfOO6YqOKO/mc1GhcDGamB7Net8wlOw+Gkd7uuk51cDTp2xnjuPSa/TjuciuoKFezH5vGTPhgDKaDgjjGzCmV97SV6lM9D+fX4z4iBgtQAhBSSAXsol6ZDC6WJNWnv5MPAszME0NLq9RJt6bymRsM/uiWyFIHWm4n9MiKmUwhC4EUgRMMabMZJn/lCL0/qoYsn9IHBX6DXmlhwRtF+3lPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnjLEfU1ttZ1AJv7cawqtQGqbgj/1eU7JQ/t+wVG1wo=;
 b=gaLwew+oOEF8O9xYHkD9BdonVV/COJ4zU76ecCdy4Yk8zXVPx21aPX5h15BjTWjF3dKeuGHjBBN72aivIFY1k4zic0GatxqFpCmSvaHYi/vjgfYom9rdycfHNRRo5PuMEkOXe59aQLpm1Hf4EthWDD1PWSh4D46X5YjRtCMc48nPLFZh1klfIdElPantDK4w9XLL0VjDZe/cNPvKOytWh0G+u7A/EEwiOgptfaS2p/6OrmVLa/8swg/4IPunVqZOnlrO6Vd2vegI72IZKDWBd6HUT/C8tENGZxrMrCubLvBBl11f/aTtiDYmIwD5QTLtRXy/MxxlQy91caSljDBi5Q==
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.27; Mon, 20 Nov 2023 18:27:58 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::70) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:27:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:47 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:43 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 06/14] mlxsw: reg: Drop unnecessary writes from mlxsw_reg_sfmr_pack()
Date: Mon, 20 Nov 2023 19:25:23 +0100
Message-ID: <04a51ea7cf31eea0ef7707311d8e864e2d9ef307.1700503644.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d84612b-effc-4311-be4a-08dbe9f66bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MJRNIJGkOdpXP0gaNXt9PB/z3azQqlGdPywqf+TCgH/NgrLaSEK58ylKi0+BfTLX71wJKtB2260vk/pvz0sBwnCi0rHSJ3HOax1kiz6kKFuYfli5j7o3QRcg924An5tldiTYesco5b1l+jjvD+3JAIOgOdVU2zpx1QoYeE2JObO1DEVO3b5P7s5WyJs03L3OGENP7g2hyM3JzdlsmDz/l17HXl/Bd4LOn5wB132mgr6ia0zN0JHRk5NNn8MrVqKG/qN2b7yoAeIXAkwqMnad0RzGVV4ikIWJrXlhDzbil2jI9k8Qw+YkFujs52jzvx79HlpTvWRVEOkPLv3RYjkZwBBHRj1pR/1vcpb5inW626GiRBsdp6qbJXnKxfCaQnurtTT5ehHT54eGMlH1rzhKuiVB01X/3Y0ybFtslpj5LrGd0SFABrNN/PfVanCUZXrNzOdMcLkqAfasheACfQ6C9D3WshhFWcFd+xZwgHd1Y3zaAqr64D7nwtwX7Y62QDzQ6ZSJapPA7QIc6SgsLCi5sIUCYvHuZPQhr2Z0TlEs5CtAZfoHxuUQE0Jh3OSsszdx8M+7+w0xsAebB96jRKrRBI8u+Jkh9QH2g1/lBobpPEkHRKYS7+71CKCcnswovq5K2QtPKnTIDSRoeSQ1wp/yIBrOg9dNLGViHv/g/nPsgGTkeumM+MCDMCnH5VadVq52+enbKQNLcDe6vtxji8x5Nxd40c5IKMhkjBB3K+8JjtS90YQ2YtzhCIGFUpt6hQCc
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(5660300002)(40460700003)(2906002)(6666004)(86362001)(478600001)(107886003)(2616005)(16526019)(26005)(8676002)(316002)(54906003)(70206006)(4326008)(110136005)(8936002)(36860700001)(47076005)(426003)(336012)(82740400003)(356005)(7636003)(83380400001)(36756003)(70586007)(41300700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:27:58.3988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d84612b-effc-4311-be4a-08dbe9f66bf5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

The MLXSW_REG_ZERO at the beginning of the function wipes the whole
payload. There's no need to set vtfp and vv to false explicitly.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index ec0adddd4598..e8f7a4741bd3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -1973,8 +1973,6 @@ static inline void mlxsw_reg_sfmr_pack(char *payload,
 	mlxsw_reg_sfmr_op_set(payload, op);
 	mlxsw_reg_sfmr_fid_set(payload, fid);
 	mlxsw_reg_sfmr_fid_offset_set(payload, fid_offset);
-	mlxsw_reg_sfmr_vtfp_set(payload, false);
-	mlxsw_reg_sfmr_vv_set(payload, false);
 	mlxsw_reg_sfmr_flood_rsp_set(payload, flood_rsp);
 	mlxsw_reg_sfmr_flood_bridge_type_set(payload, bridge_type);
 	mlxsw_reg_sfmr_smpe_valid_set(payload, smpe_valid);
-- 
2.41.0


