Return-Path: <netdev+bounces-33142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175C779CCE6
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6151C20F18
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C615417740;
	Tue, 12 Sep 2023 10:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7E168D5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:01:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0759C10DB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSO0sp3tseqp92rkYWI7ZidGGeMlgzY+nEk3xVnlVM7TCPzJ30x7JCQ351S1CLWnSPoWLlEW7B7zPlWFk61vGulOCzg9cWptT3yAs40zc+wbqQAndugMAPhjNAiOjlRc+JfLkDpdWQzMvup8tYncDzbP+O+w4gUtbpncz0fr6czNCzm5vyL5LciBtGZl/9qr9jIyIj7L1BpgYDMGLNihCdybfU3zyfN+BtmAP02Su0qBC8B6mc9zUEydV0MFTq4MdsSLIqnvRRDKtIy6BuxuD5qU3tCliZelE4lbnKtmehfJPwrPrgJ1QPj95SrlpRYg7l7YuUz6KF7R4OfVJnOXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwlzK9SkwhyGMNdY8ffnINM2B9sPombX/cxmxIbMrjg=;
 b=MtYgDCzjVvDLcxBbRBBxsChpvtx7BGOiHQCdGuVLnsdaz93e91GOj77BpxWVrS/PfvwCG/8DZ0tjIrIIouqvi9h9clHdDMO2r8xatHzJ04gtWvCN2UnWgZGx1HSryFDleCGxZFBRqcBPOkS4dxNTJhMx8f45z1qUw+lueVpfWTWJfqntXqCb1zzY1BGppnQs+XhItKVl0SiX0EGrpxM7tjstW4btyg87RJa63yILjBoR0Y2xUpbHYvUyIIWzclD3Gp+IHMoixn5vOFN/iPi/Sug+Aw/PCoYC/Bcn9Z1NBvTRv2VYntJvLquSywEkQ2CY9e9x07kq5w/zz7Jj4+BOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwlzK9SkwhyGMNdY8ffnINM2B9sPombX/cxmxIbMrjg=;
 b=I4U8rMgyFZv1yvFtIhx7XgGpdPZecXYXpRznH+jqihVTi2TdJi0EotbbJpsXsI5DTGhoPOccHtYnjhPizD0YThKiCobshqnoTMkWaDh/JLPn93yw2GNZ+E2e46ihhwGhhpoehJrJFmhOjU8B04lIvU6u7r1Hoa9urRR6m2TbFA+27UXTLN41q0eK/2k+HmZ2lUFzTEEwawOcM/iWUlDUGdhPdT2JR5vxE2PpCPXvQN1m1l8O81wj676t228pWLEY7GszC3mJW/isLI69CBg9zNN0M0REX0YajXqAsM4K4KAaprAj3jUGNYECTVjjpE6Hxjr5xEM3SVRcBiWjwuPX4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:01:21 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:01:20 +0000
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
Cc: Ben Ben-Ishay <benishay@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v15 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Tue, 12 Sep 2023 09:59:41 +0000
Message-Id: <20230912095949.5474-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::16) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f119ca-0111-4e30-825b-08dbb37736de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gzK2eldkWcHwJQLP8uWhB/aPUP0sLhALDO8uaK9lDe4y4GHr8EWf8TcWCymBKxtuNjZ3uV9AZ4l0BTB4SrWbafxwPDiTw39KwYlIcIGP87oQNEjkQ4I4XFV5i4xF3peHaX3liAHAgDS6R/fG0OFLObBYlZ2MqMflpHnnRsX7T4yzG3OVQwONmX0wmsB6bNmSnH9wM2pq1vPwVEYtPkpBWl2VtyMaEDjlkn+AB90kAEAvUIGkIaodOx7AFvYmDUhSGCQeg0ClxB5xJaQq4yz8hn+h0ujtwRlb3NFr0Urv0/v8Jzg/ynpEmkJli59B8jvXWSFy0WxyHpJwsScYGgCwZ1flvvcxeyjTcDUkYgb+XLXDHRMNhCSFPMxRT8STiUIfU2CxDl4qEgjQQPA09RMIRIdrFEA88w1Q4dNLYwXz94KuhWVaJgcpLlib7yH3W0TLYxNaCZTedTxtLOt6L7RbAPIpnFJTfYYm6VyxqfHomXIOOYsvZHuAm3aKMTvEEmJYD19hNePhND8OIDJpmdxANQoIU0RMSnEj0YVHU4Cg/ETAsQ1sw0zN0gQob+nenuNY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(107886003)(86362001)(83380400001)(2616005)(6486002)(6506007)(2906002)(6666004)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLdByYvjPKVlV0Iu92VdBAKQzgJqVnZ9hX0TvjWWdJ+xa3cAPP9G0/RKqaGg?=
 =?us-ascii?Q?41ENlfmilS6Oh4rXjKIZGQebx8Y9A4kqVe7Jl2cmjlOm/7S+up35fJhp0IG3?=
 =?us-ascii?Q?LGTsqEa37Vx7K3DlSree5G+7sFD+bDBTouyfgRRTUh/J47kPRjLJNCp2ZHzo?=
 =?us-ascii?Q?uq0Ylby8XItj+VSGpMeZLU70GSgPPcD8pfIM3VuyVroZmWNth3ACAoINnRIh?=
 =?us-ascii?Q?ryC7czckswf35AvZIOJT/6wALjq3k5PaSNPMMalnGF9JKLkSrvbvmAZibJwU?=
 =?us-ascii?Q?DAlXIDRnocKvRL0wrGRquZzVCgYBaor0snG6i3+vPin0/NBVnokWqCxTchxf?=
 =?us-ascii?Q?UMoP3dJUUIhAsZMD/J7BI12zA04+Cff3f+f/dUpBNQo+WY2u786UOv8PzTjt?=
 =?us-ascii?Q?0AilTmdcbOMMpWLQdo0eCT4sw92ji8lYUjCgrTlGnp8QuwCJSmPQ/Btq7W6R?=
 =?us-ascii?Q?ekhQS17A4v4YZp6c+K83O75aPc8Ap8KkZ7ldKCS35N7pDqrmq4xox9H23B6d?=
 =?us-ascii?Q?/gLyThkBiLhg879fLtNGZedaZhY5wPpvZbknWAXGIhJVWpF6IQ8RKMvQLyzq?=
 =?us-ascii?Q?/yk9hZb9gtspcym4lSufNFs50MbW150v4R6QBi3F7jytnCSODX9VAnP1cBGH?=
 =?us-ascii?Q?aIDIeJAwTMhE0xzixdmGbq2JRs4Aecn011l45fDD5fZdBfSTeMAziGZf+e0r?=
 =?us-ascii?Q?xD0laQFMMFvXRJRO74nQ1BvkTAwM2SvvAixSbrCx6Yde5UTTYFsGH37iIL+/?=
 =?us-ascii?Q?5x11oe31tWY+e+1JLx3MMYf5vYZ311z0skf3GC1CqjL7KHh9bUjGfIG5jfX+?=
 =?us-ascii?Q?t2TX3J7O5RNOLud3HAcnX0xPomuBmH/DWN+SogoBb7q5WBDbhq8/jbWo0Lvl?=
 =?us-ascii?Q?QrIflhNT5tDmxu9irwC8DYxua00BOMdTshLcBY12omuzn/AeDD7ltHhIA4Xy?=
 =?us-ascii?Q?0uj3QZCotDse0VoMIAL02kdzNti7lC2B6qiJJhhzQkJdRzNtmBDhE+ZjA+uC?=
 =?us-ascii?Q?VF0rPSmahm7JsyXJ26fNSy4HCmRpe3QpAb+a5XyoQ/XUuKfp7lopiW9gvRku?=
 =?us-ascii?Q?mMhkt4SQtbXKvv3Q+PUaZg3FKiHZVAKtkEZxr6WDrF4abnwRS5ug7AmIMq3w?=
 =?us-ascii?Q?513+rf0P5FuL2T+figTxlsbvP0UAN8FtMinpfio4CX7X7Jie32sg0S/MnVFx?=
 =?us-ascii?Q?zb7QEFt/FChJd02dWInfj4lfALVoqnM7K82jJe7Z7C58ZT4m3Yvhk+L3uQCz?=
 =?us-ascii?Q?4KHUA441vLCiFJYcTmKTVEFV09dVKsLnV3IMUyIe+3SJ66xD29mHNGJjphc8?=
 =?us-ascii?Q?y3SRA80XYMZa98Bq5qzIlXaHCpnHNtWigbjJAIXXUAXMuL5ggve0Ce6VieeV?=
 =?us-ascii?Q?qoTOP60V2yWL3FmnLecBY/cgfoOY3hIs116ZKknmo3yyFyXgL8ti4Co/l9HV?=
 =?us-ascii?Q?9ELxPeWFG9Gu4/YFSvPg4J/7Vg8nMCimRXs89ipkvsg+2ec3wUwL9vfrGU2v?=
 =?us-ascii?Q?8V4PgcNF+8lbdwYnmMS0dqyQ1ENaOKd/PvFeQekGFzHaYkPjo3AZ4N+0bAWG?=
 =?us-ascii?Q?cftQeS7BFhEmhMMgAA1pRMWX8zFX67XqnRNMRSLr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f119ca-0111-4e30-825b-08dbb37736de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:01:20.7695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DVoKGB9sYmO3hWjUgZUKGOqn8Vz/Cz5ikumBJ5Ib8yxlCSRuJA/to/fFP+l1LrLd8NSr7tw0e+dTFCzChlf1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034

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
index d7191c046c3e..aea67ac33691 100644
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
@@ -795,7 +796,11 @@ struct mlx5_err_cqe {
 
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
@@ -844,6 +849,19 @@ struct mlx5_cqe64 {
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
@@ -879,6 +897,28 @@ enum {
 
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
@@ -1219,6 +1259,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1426,6 +1467,14 @@ enum mlx5_qcam_feature_groups {
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
index 058abd75728d..182385a7ea5a 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1455,6 +1455,20 @@ enum {
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
@@ -1479,7 +1493,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
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
@@ -3454,6 +3470,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3706,7 +3723,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3737,7 +3756,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11907,6 +11927,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11914,6 +11935,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12279,6 +12301,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
@@ -12292,6 +12328,13 @@ enum {
 
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
@@ -12314,7 +12357,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -12553,4 +12609,15 @@ struct mlx5_ifc_modify_page_track_obj_in_bits {
 	struct mlx5_ifc_page_track_bits obj_context;
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


