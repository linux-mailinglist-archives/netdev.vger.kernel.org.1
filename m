Return-Path: <netdev+bounces-50060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E67F482D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E45CB20E91
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE4B4AF9C;
	Wed, 22 Nov 2023 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SP0stuAR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBBFD6F
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:49:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3nSi2I4MzH5nv/LOaS/E9rTS6yKb75zdWJ3w+MxwCwdMPElCGNgwia7KkB36uX5LZuwp4GTPw/lgVU3Aan3nI86MwcHWImGpL4TQvQHM235vcf3R72Cel4v5aCr600wmh+Sga1TPhQf0C8x5/IjvzYDe3CRJwd4cixMqvmFI7vJlFZsSXvC/NDapeDPl1riXJgI8IUjMuc5xYrTd0mTpnPrw4Pil35E68jTfWeXl9QaEUbB3Pfj9QE8d86Acw1KSg/L7qVyGcTv7YRhwTjithH3xtju7fCwn5rjfohqc+vlPmztQaHxrqD9C86p3+28VthOxOHv9AiWeBeCMz1XBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2tSoZ3iT66rNXAP8OdSPtOyu6OiqwlCNJ8UQWUenAc=;
 b=APM3PWTkvFEOYKgeT8YCWxBjZ62iZhpR3jEm/FDIjy8kVineUipRglDPDqaLTL7NuInPRroTVf3m4iF8XwE5shWYFjWldB4AhCqz8p9yaREDXc4YLmqPBnN4jDZ2eiyekJdBqsbP/v/nSlW1sd96o2IuIS8ZSJM2woBE/s8IByV4TdXeh79G/LK7YlpxarunmfD3riawY7sfrpZWjoOq9MgRONyK/0/mOXW5awEPaoyOWYVBxghy/SjsP4iyRnYssjSLTtPxfA6+tR4bthjmAlbit7fdrvIyz75sc/YIH9gLrsuozbK6wGhErg5jiA/4abs69fZ16l4B2P/6WxyORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2tSoZ3iT66rNXAP8OdSPtOyu6OiqwlCNJ8UQWUenAc=;
 b=SP0stuAROfpdbY8l0uZO6W+pYW9OYF2INeJ/Yv3wZplIvypqLrAbQd+qnWL5vK+0NeHbtHsKIsULitOfTmmtZy2vnKuSbyoFGAaaOmi7XwP+k9/1NCVPnsQ8UL7e0ajOPovb5sVd7PFdxS9NlC7kYCTEAcT8T9DHB96DbkMwad56QjEGtjZNLFLDey/8FFFGkUtLTAqBoyNJ6o3RG1QCuxXbVAywGSqGXEqnFjl6SvMk/MDtRvgrOXQezKMU9Y2gx7HIJV98z1BW4+KdtffyOo3w7+PcDxvp0SLvoAOfd/tt4K6NIyAPAxCXI5abAMM3hqG6GDYHB0nGJBPrLP4NDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:49:39 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:49:39 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v20 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Wed, 22 Nov 2023 13:48:25 +0000
Message-Id: <20231122134833.20825-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0588.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2d2e1b-22b3-4562-d0d2-08dbeb61def3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+aRDSxdRbZ1lnqc6us0jWvqb1I70LgAec3ImYpGUY8yNlU4hXQhPiGIeSwE9Bvo3mxsRQ/qiR5YCgOX8INl8lT58exiz/SN5ml4gweVCEtLWZUc47I2QWVGmx4BOV0xEs2xeRh3gWU7PBY4m2Q5pcWe7HDRlyXyXaEhK4P5GXQhZsWtixwlgPD5nkVFPy+lKw1zLz/QZo+DdgQP4/EUGdyxSx6smoRPVn78+9PWeEzea5gXgN5SBL+QuyqctAYEQM/xWqjXIxNqLSY2mUzENOTdTb6eNiFAhC284/uYA3DsanRKrMyBvITEYUH1aDQnCYAvH371dzFOha1MrggSwaPS433ZUe0+he6ftvboeLdZaZgNeBa0sYeEPlOItYQ1kOgAV1BLDU+rQjmQbTfldHDov4ZjFWOxaLX8BxkxZpm7z2OCJIurt4LojJmMFtxFaEZJTX+lGh2c9JwU6fKJmD3730IMeKe/nhwAcKtUn7bSvc5K3YkhLn00kO7/5pEh20tdUnMbGvrwMjeRCszKEnH3orABLSLjf4n8Iv7QnvYzAIgxLDnegalGs5w/p1TCi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(2616005)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(107886003)(6666004)(7416002)(6486002)(478600001)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B24RRCG9d/JCofc8Rf+5f6aMOo7IMnH904EvIcuftRqjMTy1+s5JjL+mwRW1?=
 =?us-ascii?Q?XG7CwOweS5UlGN71HIlfgcMLQjMcCEnez85ait0W5BoflRm/3/aA9iTLNNvu?=
 =?us-ascii?Q?sfBGL2d6+mOYWCu8HtFSFTyY7ffpzl8hcaJ1MIudBzdpibL2QNbSS0+oIIp3?=
 =?us-ascii?Q?m+2UNVECyU2dFVZFJ3VJYh4pATZVBSvyRDlk4dO4fECfGFkXpQfgdoO29QQx?=
 =?us-ascii?Q?h2HieuraajpEJSWHfg/ot3KMs/Vt1C0jqAr1EsfMfChZlBPWAAa+OvrVXq61?=
 =?us-ascii?Q?9RKymyzwi1g4Y054arIANKrRXwKfemUP/FFT6osgpViSXPL30EhVjIkUfUWf?=
 =?us-ascii?Q?gZEJculQG5DQYhAD5y5vlM8UgPtov7FBdwoq62dj5lMJ9CqiOiKV5xSzadiR?=
 =?us-ascii?Q?s6YcMJ3+puszDpZOtY3dLvBbkQQYnF4u3eAarZmQBWzEmjq/76n+jZIoabGG?=
 =?us-ascii?Q?uyszyWv/DAqKSZ3fMgGAsryldo0t0v4r4MIzmjTO2U43fnLwXQiqtylbdSCN?=
 =?us-ascii?Q?NLmEZKKFrZpJjVSvIRR9O1cHhhuago/8ZoITal+sN5skC1VnF46NM6SKR7/x?=
 =?us-ascii?Q?CFM9lJ82gmlE1bnGLuNJcdJtRtbK/Pl9CAbzOo8V958q4r6ZVAknCWULmad8?=
 =?us-ascii?Q?/G15ToB7bDzx6vvVa0ZFPe9XY4qnuuYeW1YoAMl9AgDD4tf9IK0W5WW3hHgE?=
 =?us-ascii?Q?Y5jydBLCflGSakSHVofvMBsYPoQL8G+VfXAWkMmjWmjDU11VsTnc9j/ulEvz?=
 =?us-ascii?Q?gHjzekCEjA9NAYrcLKdGYscs0oXkRvHluoukhHmtc3w5tMNCRvRS/lbpDJBu?=
 =?us-ascii?Q?PaBY5DXX9PbEAj6VSThnRQRiq+LqMfI2/uYcikzC5g2FCJSCSIw++1m4l1Bx?=
 =?us-ascii?Q?JLJNeEdMlpVoMBOsvNW6igHWIa0qBepSIrH9yeqQvDRBFia++dhIXU43k1Ny?=
 =?us-ascii?Q?eXniWf7aw88YRDhKM9MyWyJHOVqYQLocbZDnKXRA6oo4MuB5wTXO6C0sae7w?=
 =?us-ascii?Q?4vG8Svy43uYX2NBpi68g/DfRX8DY8rCnl2cjl83ES/PFq+MT9AiY9lms086O?=
 =?us-ascii?Q?FKLlujOiyTBkr3a5TO/LiyO0zOnde4AFwcEKq5J/nUxUDxfSKg0myD/+l6Bj?=
 =?us-ascii?Q?7ynEN7dykFHHfa89+Nm8/7amJ4HGZbsXsLsrmCCs0no8PQl/dVrhG6wJhxKQ?=
 =?us-ascii?Q?rNDoKZyEQUna2UOOOhrtSicndZMUJTKzwotz8MwDcV2ItEfRkcp2gt7lJY8b?=
 =?us-ascii?Q?nfaI7HvNXZIrWDsM5D+tfnxf1zBxEpDxcl68OzNtaZGAZF46rZQs9S7c0n3M?=
 =?us-ascii?Q?BuiU90y/Et2OyYeyIgbfDtdDPi4PUxohOMuNdXMH74dR9u913sd0ctrnCktA?=
 =?us-ascii?Q?ZSv2D8FZ24KoCQD5J5VmCX/dVqNXDj2801B5WBv4cGbOpcs2ygf5lNACPeo/?=
 =?us-ascii?Q?nnhP/kf+8Z0f4L425j6YmD2ja8BbHAfWGu26dGWEVk+QUgBDrjeUfjRO/069?=
 =?us-ascii?Q?N3mAITeSPpySgtAPwP0jT9/85unRXdWnyJ+eM9p56stq2SJ2EwNE2QcFJwPt?=
 =?us-ascii?Q?JtOEysAzBo9DsYUM+rgWtT7Pf9qpoziEeigpCvM9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2d2e1b-22b3-4562-d0d2-08dbeb61def3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:49:38.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSeuAYFlOJCmXyFt4oQUmfZ89hCbWF0oOPr3MYXLyZEI+mmGTPYdiFA0XKpokPX9THphcMTjyZ1zswF5ueEOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

From: Ben Ben-Ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:
- Create mlx5_cqe128 structure for NVMEoTCP offload.
  The new structure consist from the regular mlx5_cqe64 +
  NVMEoTCP data information for offloaded packets.
- Add nvmetcp field to mlx5_cqe64, this field define the type
  of the data that the additional NVMEoTCP part represents.
- Add nvmeotcp_zero_copy_en + nvmeotcp_crc_en bit
  to the TIR, for identify NVMEoTCP offload flow
  and tag_buffer_id that will be used by the
  connected nvmeotcp_queues.
- Add new capability to HCA_CAP that represents the
  NVMEoTCP offload ability.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  6 ++
 include/linux/mlx5/device.h                  | 51 ++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 75 ++++++++++++++++++--
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 58f4c0d0fafa..f1745f69337b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -280,6 +280,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, nvmeotcp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_NVMEOTCP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index f1dde3c6a3f3..6416a5e8a8e6 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -264,6 +264,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -798,7 +799,11 @@ struct mlx5_err_cqe {
 
 struct mlx5_cqe64 {
 	u8		tls_outer_l3_tunneled;
-	u8		rsvd0;
+	u8		rsvd16bit:4;
+	u8		nvmeotcp_zc:1;
+	u8		nvmeotcp_ddgst:1;
+	u8		nvmeotcp_resync:1;
+	u8		rsvd23bit:1;
 	__be16		wqe_id;
 	union {
 		struct {
@@ -847,6 +852,19 @@ struct mlx5_cqe64 {
 	u8		op_own;
 };
 
+struct mlx5e_cqe128 {
+	__be16 cclen;
+	__be16 hlen;
+	union {
+		__be32 resync_tcp_sn;
+		__be32 ccoff;
+	};
+	__be16 ccid;
+	__be16 rsvd8;
+	u8 rsvd12[52];
+	struct mlx5_cqe64 cqe64;
+};
+
 struct mlx5_mini_cqe8 {
 	union {
 		__be32 rx_hash_result;
@@ -882,6 +900,28 @@ enum {
 
 #define MLX5_MINI_CQE_ARRAY_SIZE 8
 
+static inline bool cqe_is_nvmeotcp_resync(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_resync;
+}
+
+static inline bool cqe_is_nvmeotcp_crcvalid(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_ddgst;
+}
+
+static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_zc;
+}
+
+/* check if cqe is zc or crc or resync */
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
+{
+	return cqe_is_nvmeotcp_zc(cqe) || cqe_is_nvmeotcp_crcvalid(cqe) ||
+	       cqe_is_nvmeotcp_resync(cqe);
+}
+
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
 {
 	return (cqe->op_own >> 2) & 0x3;
@@ -1222,6 +1262,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1429,6 +1470,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, \
+		 (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
+#define MLX5_CAP64_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, \
+		   (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 7388410292ae..ea321c96c1c2 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1462,6 +1462,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_7   = 2,
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+	u8    reserved_at_40[0x7c0];
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x10];
 	u8         shared_object_to_user_object_allowed[0x1];
@@ -1486,7 +1500,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         event_cap[0x1];
 	u8         reserved_at_91[0x2];
 	u8         isolate_vl_tc_new[0x1];
-	u8         reserved_at_94[0x4];
+	u8         reserved_at_94[0x2];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3475,6 +3491,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3727,7 +3744,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3758,7 +3777,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11974,6 +11994,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11981,6 +12002,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12347,6 +12369,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    reserved_at_60[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12360,6 +12396,13 @@ enum {
 
 enum {
 	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
 };
 
 struct mlx5_ifc_transport_static_params_bits {
@@ -12382,7 +12425,20 @@ struct mlx5_ifc_transport_static_params_bits {
 	u8         reserved_at_100[0x8];
 	u8         dek_index[0x18];
 
-	u8         reserved_at_120[0xe0];
+	u8         reserved_at_120[0x14];
+
+	u8         cccid_ttag[0x1];
+	u8         ti[0x1];
+	u8         zero_copy_en[0x1];
+	u8         ddgst_offload_en[0x1];
+	u8         hdgst_offload_en[0x1];
+	u8         ddgst_en[0x1];
+	u8         hddgst_en[0x1];
+	u8         pda[0x5];
+
+	u8         nvme_resync_tcp_sn[0x20];
+
+	u8         reserved_at_160[0xa0];
 };
 
 struct mlx5_ifc_tls_progress_params_bits {
@@ -12681,4 +12737,15 @@ struct mlx5_ifc_msees_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_44[0xc];
+	u8    cccid_ttag[0x10];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index bd53cf4be7bd..b72f08efe6de 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -227,6 +227,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


