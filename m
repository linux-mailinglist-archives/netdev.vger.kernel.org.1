Return-Path: <netdev+bounces-29676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E609C784513
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A3D1C209C5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0A1D315;
	Tue, 22 Aug 2023 15:06:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8ED1FD0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:06:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD97198
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJT9Xj/blxvOHWmvFHHihg1t6Orvp9oLjNPgACbV4dzQFXTQZKRfg7c2f3CLUFuUqEN/5Bj9iYIM7/ubVZKUzc7u63DL1yJx+HIT361JoQ6JQ64uwTGRkm8NvYJPzYSVeXCXuf6uKrr79TFtWhfxIEnuasOUiYxogksHTX31hfFmDV2b3h03cCAhEBqocmCvEBpvfRhcWW8PYgBrkRBx9tcu3Z/6wMCJlWJ7uX99q3MYpR2BAXn2Mbe38uXeCNENEGGF0kc046vnOJ8VKflEFYbdArMp6t4MKNluZxeCUdPTPGjMvMkrJcHcNfHkUUEGAxnNqcPQvniTO1ZxXVfl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xko18i7vSC2+kECQf3JSVzIHUFF09gPOBmRgaXfQCOA=;
 b=SXa97dYICqP7bexgGfpPdsdsQMuy9zEVtzNr2I8Hbx5HO7gw3y4Qx8sCm58Ex9A6Ln2+tZQq9ScPm3r7THFYEC5qf03eslm6K8zKV2BvK68ZE1XdROccdRE7psXQNd9xxpV8HHppq1CflH7N6WFVoMtXLGcI+oiEdzq+KqrdaA5hbLeuOCSwOivKuDB6F5tczVY6/ymksdVBTc5jCuilt62sOwOv/RB/zd24GPsag9wKldCcPJUPdZeBIqPVgMblRUEZqMlD9lg/1a4un7VQ+woVyNqdzsmloHTJJFCIhpClOvuE+jRSge7UeNo6UhZ9c8cat9cjsN0IEfHHF88JwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xko18i7vSC2+kECQf3JSVzIHUFF09gPOBmRgaXfQCOA=;
 b=PCn+wiYajv7eeZq3pNW0RYusc9sRbrMnLsFbAt/x1bfsopNO6H2VlwFrZHplz0hdyQdy/6GFt4K/R0RPIP/IGLWPp7cocge9o8OZYH9TTFM2+BCHvVIf+t64DN02OqfRcI+MHmITglXmzXV/NqzGdH+TiYUDmupwdHLa5PqsUIsn0ftQkTuo0v+638ty1woc3VH/433HZ7cc517jC7eV/n+9aWbXD4/HXLSEBMNT8pO7aaQ5jsQ8EKmmAqw6qWTRkNnYVNRDfD87MdMTbNZ4y0ODj//lrbHrNSeYDQi9RO3OXjM0D+Eg0eMbknyvbp4j8p7lqcA4JtTLADezy1j84Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:06:26 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:06:26 +0000
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
Subject: [PATCH v13 17/24] net/mlx5e: NVMEoTCP, offload initialization
Date: Tue, 22 Aug 2023 15:04:18 +0000
Message-Id: <20230822150425.3390-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c32d0c-dd89-4304-58af-08dba3215b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZSX/ZOBU2uzvhgcdUKLwgePfSTxpST6oxeI+iiOseSR7WGT9JXXjJWje1+D1C9aEqiknEBj5GOr4Omc5m9x2Och0HuT7Q8M6wfYztEu9qc7KZ29Yql1vujdMpA41ehDm4OKFgb9ueW7OAluST0wKlwHRNzVkZgRx1/Eg5NKIBS6EO1rpDwzpojWQAjnwDeLM1bA1yW/55LhHVL/XyFFZHAtqOgRh6mtSuJtQqDvSOqZMdtOhcwa7eazqYGeiWVABusOsfDaF7lxJbkBbT3f1m0mJDCj2bzgTxSmmv6cuY6Ji2JD8KLcSkdG8u2SL1GJq4jy5N7yml3OlvPNcJQ6SKW1NGgn8kpt5xC2Dq1KLS8kSNB4lAowait/TYWnOoyy/Dg2JZ0xA70kuuSSqAdwRjpFB1QQspKZH5XcdyEkk5YZk6AL6DdnaKMq7KY7TEXjevfnfK+bMBEPc0qbA3CIfmarqKa7qGcR9ETynpy8rtpSd479uODnOIjV0svc5p3WOwelFjM2AUvRcQeLvXxx0mPzwoSi+fMFv0eTqEej5XgxCw+TUUAJBNDUvKRX2bWc2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(66899024)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(30864003)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DGO0fbvgOhMxlFNg8x9JG2CzEJh8o7x1p0uxRpnK1qatmQQZMJAYPvym4xx5?=
 =?us-ascii?Q?0vRhaiosEKMB6sM0klPoVyJjkTTorASUveNKC0PBlkxMyNTzza/PWyQNiT4o?=
 =?us-ascii?Q?bPXj2rIFR8NMXx2K/397F+45dFjvsxemNkJdcKXAwh33ZUXxqCye8dHGxtgP?=
 =?us-ascii?Q?Y7xCbJlIIQZu0+bkt2XSJxoI3jEYwomFHp6P6AGFSNbgX5Ua3d/JeESpXKno?=
 =?us-ascii?Q?J+zCNovkz01A6jbKkK4W0Jc0zU/fS3GFp8CGfbRA31B6IwRFTVHs5q6uEpj3?=
 =?us-ascii?Q?Nm9yts9RXHwyRgWAZ8yq3cqCq4X8l6s4hn6LNmYGqwzlgqnKq+FtesKwHAvj?=
 =?us-ascii?Q?SBIkng7fhf0ap/FKAyFM9RmojO/5ajs/KWEo/YDFBT7da1Uit8FxYD5W21iA?=
 =?us-ascii?Q?43ZcEKiUS2s2116eKtERhtg56gEUKjGiqC7JZaYWUJWmVW1k6O0Q8uavGHun?=
 =?us-ascii?Q?yet0fwiGuTx3BtZuQIVO0RoxqC/B0wm2azaalMYzxCS/+uZpwwfE8e/Xdoi2?=
 =?us-ascii?Q?pXscc6ih+Se+u0vwPfN6B1NNBO3Q5tBLJdBaM9WZwWC8RxYPBfpMaht7Yw93?=
 =?us-ascii?Q?Im8NMmLOEretPWk6Z69X2+tIhnAIWFVBpwSU/d9zNFJMC1aNaI5F+cSWvBig?=
 =?us-ascii?Q?tAf0Anr2g3+L8eXVC96J2zcIBHTWaXdo+eLR1dWmDX8zzk/kUwmYqYu4Afc2?=
 =?us-ascii?Q?bTxs07uXkb0hXM0kTXFX6o4CZk4K16nMskzxl8DMHXLBzMaVB4Z+EPK0TpTU?=
 =?us-ascii?Q?nzoln9mErmV08xELO331bcxp2WAU0LRo4Qh1lg3ixkMJro00AxBohHXeHPA0?=
 =?us-ascii?Q?+wKS9t3aFhwNvyTcHsTHwO5+kyU/+tP+lrbfFPX41ob5Jmjn+71cgeD5POVy?=
 =?us-ascii?Q?DKuSdTpxGcJ8WYm+OlhkHFdpbrM+XzS1KegV03tYKu3/OxnnCvm4v6M7Gd04?=
 =?us-ascii?Q?K40SpoyOquLE4x41v2Ghs+wcyv6IsSJ/1DQq5kEbFEA2iRdt4hHoRdnLHrbV?=
 =?us-ascii?Q?vYrrI3HujtB1Md99OFcibdqusTgEuq+6ecyLm0iyOjEFokcco29n7oqGVqyt?=
 =?us-ascii?Q?QVNLCn+mngxeya/WM+rbavB4MsJcvOjnXxz/tONnedt97JoX6/FQRqwW0nLx?=
 =?us-ascii?Q?u1ODepLtu9CRMffp9QBm3ajpeq2V5buP3l9r+Ct6I+tdBoWSO1c/kzobI8Cs?=
 =?us-ascii?Q?vRxlL9DTSfyiBDTYY5WLsrs6EjQloZpmfrT2gfDL9se3M755TqmGnsQCj1lU?=
 =?us-ascii?Q?Ti68f1eLRZ2dFKLdtNCxsCG4XW33tM7E6eH8JxZkMqSxlh/QzmRVBT+OeXK8?=
 =?us-ascii?Q?OA7esKSlGupidcnMwsYIEoa23ZJOxBPzdJSGiBOh5ANEqNfzPc7jlH777qhp?=
 =?us-ascii?Q?+WWTFpJCsyfZJ9n0q+BWZkC+JkXA0g0+PMgs+tyrUOMhwRkyZDNHK5N5ZvAt?=
 =?us-ascii?Q?EdSTjG8n+7Vg9X2U3N/syMYbh8RU64DuiIDqW5ZCtGTy52vDPAsVQMgYXlvB?=
 =?us-ascii?Q?/mBMAgsA3UdEvoQVheU1UxswrXvtxxRZBYKWKrLU8z7asO2LkzKz7/yBiuLW?=
 =?us-ascii?Q?UFQzTj/jdXVi8pchyDs5VMEbiFMtY9LvxAlPcDv5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c32d0c-dd89-4304-58af-08dba3215b2a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:06:26.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hgoZhwkXUjlDMRqSbvEVAFBcD6Qa9aEIkkG8rpB5cDRLoH2n5VD8IioQ7ZbZQ5hrWai9u0XmjH5PuIF2XwkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ben Ben-Ishay <benishay@nvidia.com>

This commit introduces the driver structures and initialization blocks
for NVMEoTCP offload. The mlx5 nvmeotcp structures are:

- queue (mlx5e_nvmeotcp_queue) - pairs 1:1 with nvmeotcp driver queues and
  deals with the offloading parts. The mlx5e queue is accessed in the ddp
  ops: initialized on sk_add, used in ddp setup,teardown,resync and in the
  fast path when dealing with packets, destroyed in the sk_del op.

- queue entry (nvmeotcp_queue_entry) - pairs 1:1 with offloaded IO from
  that queue. Keeps pointers to the SG elements describing the buffers
  used for the IO and the ddp context of it.

- queue handler (mlx5e_nvmeotcp_queue_handler) - we use icosq per NVME-TCP
  queue for UMR mapping as part of the ddp offload. Those dedicated SQs are
  unique in the sense that they are driven directly by the NVME-TCP layer
  to submit and invalidate ddp requests.
  Since the life-cycle of these icosqs is not tied to the channels, we
  create dedicated napi contexts for polling them such that channels can be
  re-created during offloading. The queue handler has pointer to the cq
  associated with the queue's sq and napi context.

- main offload context (mlx5e_nvmeotcp) - has ida and hash table instances.
  Each offloaded queue gets an ID from the ida instance and the <id, queue>
  pairs are kept in the hash table. The id is programmed as flow tag to be
  set by HW on the completion (cqe) of all packets related to this queue
  (by 5-tuple steering). The fast path which deals with packets uses the
  flow tag to access the hash table and retrieve the queue for the
  processing.

We query nvmeotcp capabilities to see if the offload can be supported and
use 128B CQEs when this happens. By default, the offload is off but can
be enabled with `ethtool --ulp-ddp <device> nvme-tcp-ddp on`.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   4 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  12 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |   3 +
 .../mellanox/mlx5/core/en_accel/en_accel.h    |   3 +
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |   2 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 216 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 121 ++++++++++
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  17 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
 14 files changed, 397 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index d537d517cabe..a6fa867b5552 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -164,6 +164,17 @@ config MLX5_EN_TLS
 	help
 	Build support for TLS cryptography-offload acceleration in the NIC.
 
+config MLX5_EN_NVMEOTCP
+	bool "NVMEoTCP acceleration"
+	depends on ULP_DDP
+	depends on MLX5_CORE_EN
+	default y
+	help
+	Build support for NVMEoTCP acceleration in the NIC.
+	This includes Direct Data Placement and CRC offload.
+	Note: Support for hardware with this capability needs to be selected
+	for this option to become available.
+
 config MLX5_SW_STEERING
 	bool "Mellanox Technologies software-managed steering"
 	depends on MLX5_CORE_EN && MLX5_ESWITCH
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 946310390659..3470d80ab4dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -109,6 +109,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o
+
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
 					steering/dr_icm_pool.o steering/dr_buddy.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 365433c54edb..819727652f5b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -319,6 +319,7 @@ struct mlx5e_params {
 	int hard_mtu;
 	bool ptp_rx;
 	__be32 terminate_lkey_be;
+	bool nvmeotcp;
 };
 
 static inline u8 mlx5e_get_dcb_num_tc(struct mlx5e_params *params)
@@ -926,6 +927,9 @@ struct mlx5e_priv {
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	struct mlx5e_tls          *tls;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	struct mlx5e_nvmeotcp      *nvmeotcp;
 #endif
 	struct devlink_health_reporter *tx_reporter;
 	struct devlink_health_reporter *rx_reporter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index e5a44b0b9616..c817308c6102 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -77,7 +77,7 @@ enum {
 	MLX5E_INNER_TTC_FT_LEVEL,
 	MLX5E_FS_TT_UDP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 	MLX5E_FS_TT_ANY_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	MLX5E_ACCEL_FS_TCP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 #endif
 #ifdef CONFIG_MLX5_EN_ARFS
@@ -170,7 +170,7 @@ struct mlx5e_fs_any *mlx5e_fs_get_any(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_any(struct mlx5e_flow_steering *fs, struct mlx5e_fs_any *any);
 struct mlx5e_fs_udp *mlx5e_fs_get_udp(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_udp(struct mlx5e_flow_steering *fs, struct mlx5e_fs_udp *udp);
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 struct mlx5e_accel_fs_tcp *mlx5e_fs_get_accel_tcp(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_accel_tcp(struct mlx5e_flow_steering *fs, struct mlx5e_accel_fs_tcp *accel_tcp);
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index e097f336e1c4..21b7d8628dd3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -873,7 +873,8 @@ static void mlx5e_build_common_cq_param(struct mlx5_core_dev *mdev,
 	void *cqc = param->cqc;
 
 	MLX5_SET(cqc, cqc, uar_page, mdev->priv.uar->index);
-	if (MLX5_CAP_GEN(mdev, cqe_128_always) && cache_line_size() >= 128)
+	if (MLX5_CAP_GEN(mdev, cqe_128_always) &&
+	    (cache_line_size() >= 128 || param->force_cqe128))
 		MLX5_SET(cqc, cqc, cqe_sz, CQE_STRIDE_128_PAD);
 }
 
@@ -903,6 +904,9 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 	void *cqc = param->cqc;
 	u8 log_cq_size;
 
+	/* nvme-tcp offload mandates 128 byte cqes */
+	param->force_cqe128 |= IS_ENABLED(CONFIG_MLX5_EN_NVMEOTCP) && params->nvmeotcp;
+
 	switch (params->rq_wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		hw_stridx = MLX5_CAP_GEN(mdev, mini_cqe_resp_stride_index);
@@ -1242,9 +1246,9 @@ static u8 mlx5e_build_async_icosq_log_wq_sz(struct mlx5_core_dev *mdev)
 	return MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE;
 }
 
-static void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
-				    u8 log_wq_size,
-				    struct mlx5e_sq_param *param)
+void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
+			     u8 log_wq_size,
+			     struct mlx5e_sq_param *param)
 {
 	void *sqc = param->sqc;
 	void *wq = MLX5_ADDR_OF(sqc, sqc, wq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 6800949dafbc..f5a4d6f5d5bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -17,6 +17,7 @@ struct mlx5e_cq_param {
 	struct mlx5_wq_param       wq;
 	u16                        eq_ix;
 	u8                         cq_period_mode;
+	bool                       force_cqe128;
 };
 
 struct mlx5e_rq_param {
@@ -147,6 +148,8 @@ void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 			     struct mlx5e_params *params,
 			     struct mlx5e_xsk_param *xsk,
 			     struct mlx5e_sq_param *param);
+void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
+			     u8 log_wq_size, struct mlx5e_sq_param *param);
 int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 			      struct mlx5e_params *params,
 			      u16 q_counter,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index bac4717548c6..39510370847d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -40,6 +40,7 @@
 #include "en_accel/ktls.h"
 #include "en_accel/ktls_txrx.h"
 #include <en_accel/macsec.h>
+#include "en_accel/nvmeotcp.h"
 #include "en.h"
 #include "en/txrx.h"
 
@@ -202,11 +203,13 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
 
 static inline int mlx5e_accel_init_rx(struct mlx5e_priv *priv)
 {
+	mlx5e_nvmeotcp_init_rx(priv);
 	return mlx5e_ktls_init_rx(priv);
 }
 
 static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
 {
+	mlx5e_nvmeotcp_cleanup_rx(priv);
 	mlx5e_ktls_cleanup_rx(priv);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
index a032bff482a6..d907e352ffae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
@@ -6,7 +6,7 @@
 
 #include "en/fs.h"
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs);
 void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs);
 struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
new file mode 100644
index 000000000000..9ddee04a1327
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include <linux/netdevice.h>
+#include <linux/idr.h>
+#include "en_accel/nvmeotcp.h"
+#include "en_accel/fs_tcp.h"
+#include "en/txrx.h"
+
+#define MAX_NUM_NVMEOTCP_QUEUES	(4000)
+#define MIN_NUM_NVMEOTCP_QUEUES	(1)
+
+static const struct rhashtable_params rhash_queues = {
+	.key_len = sizeof(int),
+	.key_offset = offsetof(struct mlx5e_nvmeotcp_queue, id),
+	.head_offset = offsetof(struct mlx5e_nvmeotcp_queue, hash),
+	.automatic_shrinking = true,
+	.min_size = MIN_NUM_NVMEOTCP_QUEUES,
+	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
+};
+
+static int
+mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
+			      struct ulp_ddp_limits *limits)
+{
+	return 0;
+}
+
+static int
+mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
+			  struct sock *sk,
+			  struct ulp_ddp_config *tconfig)
+{
+	return 0;
+}
+
+static void
+mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
+			      struct sock *sk)
+{
+}
+
+static int
+mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *ddp)
+{
+	return 0;
+}
+
+static void
+mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
+			    struct sock *sk,
+			    struct ulp_ddp_io *ddp,
+			    void *ddp_ctx)
+{
+}
+
+static void
+mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
+			  struct sock *sk, u32 seq)
+{
+}
+
+int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_params new_params;
+	int err = 0;
+
+	/* There may be offloaded queues when an ethtool callback to disable the feature is made.
+	 * Hence, we can't destroy the tcp flow-table since it may be referenced by the offload
+	 * related flows and we'll keep the 128B CQEs on the channel RQs. Also, since we don't
+	 * deref/destroy the fs tcp table when the feature is disabled, we don't ref it again
+	 * if the feature is enabled multiple times.
+	 */
+	if (!enable || priv->nvmeotcp->enabled)
+		return 0;
+
+	err = mlx5e_accel_fs_tcp_create(priv->fs);
+	if (err)
+		return err;
+
+	new_params = priv->channels.params;
+	new_params.nvmeotcp = enable;
+	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	if (err)
+		goto fs_tcp_destroy;
+
+	priv->nvmeotcp->enabled = true;
+	return 0;
+
+fs_tcp_destroy:
+	mlx5e_accel_fs_tcp_destroy(priv->fs);
+	return err;
+}
+
+static int mlx5e_ulp_ddp_set_caps(struct net_device *netdev, unsigned long *new_caps,
+				  struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	DECLARE_BITMAP(old_caps, ULP_DDP_C_COUNT);
+	struct mlx5e_params *params;
+	int ret = 0;
+	int nvme = -1;
+
+	mutex_lock(&priv->state_lock);
+	params = &priv->channels.params;
+	bitmap_copy(old_caps, netdev->ulp_ddp_caps.active, ULP_DDP_C_COUNT);
+
+	/* always handle nvme-tcp-ddp and nvme-tcp-ddgst-rx together (all or nothing) */
+
+	if (ulp_ddp_cap_turned_on(old_caps, new_caps, ULP_DDP_C_NVME_TCP_BIT) &&
+	    ulp_ddp_cap_turned_on(old_caps, new_caps, ULP_DDP_C_NVME_TCP_DDGST_RX_BIT)) {
+		if (MLX5E_GET_PFLAG(params, MLX5E_PFLAG_RX_CQE_COMPRESS)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NVMe-TCP offload not supported when CQE compress is active. Disable rx_cqe_compress ethtool private flag first\n");
+			goto out;
+		}
+
+		if (netdev->features & (NETIF_F_LRO | NETIF_F_GRO_HW)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NVMe-TCP offload not supported when HW_GRO/LRO is active. Disable rx-gro-hw ethtool feature first\n");
+			goto out;
+		}
+		nvme = 1;
+	} else if (ulp_ddp_cap_turned_off(old_caps, new_caps, ULP_DDP_C_NVME_TCP_BIT) &&
+		   ulp_ddp_cap_turned_off(old_caps, new_caps, ULP_DDP_C_NVME_TCP_DDGST_RX_BIT)) {
+		nvme = 0;
+	}
+
+	if (nvme >= 0) {
+		ret = set_ulp_ddp_nvme_tcp(netdev, nvme);
+		if (ret)
+			goto out;
+		change_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active);
+		change_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT, netdev->ulp_ddp_caps.active);
+	}
+
+out:
+	mutex_unlock(&priv->state_lock);
+	return ret;
+}
+
+const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
+	.limits = mlx5e_nvmeotcp_offload_limits,
+	.sk_add = mlx5e_nvmeotcp_queue_init,
+	.sk_del = mlx5e_nvmeotcp_queue_teardown,
+	.setup = mlx5e_nvmeotcp_ddp_setup,
+	.teardown = mlx5e_nvmeotcp_ddp_teardown,
+	.resync = mlx5e_nvmeotcp_ddp_resync,
+	.set_caps = mlx5e_ulp_ddp_set_caps,
+};
+
+void mlx5e_nvmeotcp_build_netdev(struct mlx5e_priv *priv)
+{
+	struct net_device *netdev = priv->netdev;
+	struct mlx5_core_dev *mdev = priv->mdev;
+
+	if (!(MLX5_CAP_GEN(mdev, nvmeotcp) &&
+	      MLX5_CAP_DEV_NVMEOTCP(mdev, zerocopy) &&
+	      MLX5_CAP_DEV_NVMEOTCP(mdev, crc_rx) && MLX5_CAP_GEN(mdev, cqe_128_always)))
+		return;
+
+	/* report ULP DPP as supported, but don't enable it by default */
+	set_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.hw);
+	set_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT, netdev->ulp_ddp_caps.hw);
+}
+
+void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv)
+{
+	if (priv->nvmeotcp && priv->nvmeotcp->enabled)
+		mlx5e_accel_fs_tcp_destroy(priv->fs);
+}
+
+int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nvmeotcp *nvmeotcp = NULL;
+	int ret = 0;
+
+	if (!MLX5_CAP_GEN(priv->mdev, nvmeotcp))
+		return 0;
+
+	nvmeotcp = kzalloc(sizeof(*nvmeotcp), GFP_KERNEL);
+
+	if (!nvmeotcp)
+		return -ENOMEM;
+
+	ida_init(&nvmeotcp->queue_ids);
+	ret = rhashtable_init(&nvmeotcp->queue_hash, &rhash_queues);
+	if (ret)
+		goto err_ida;
+
+	nvmeotcp->enabled = false;
+
+	priv->nvmeotcp = nvmeotcp;
+	return 0;
+
+err_ida:
+	ida_destroy(&nvmeotcp->queue_ids);
+	kfree(nvmeotcp);
+	return ret;
+}
+
+void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nvmeotcp *nvmeotcp = priv->nvmeotcp;
+
+	if (!nvmeotcp)
+		return;
+
+	rhashtable_destroy(&nvmeotcp->queue_hash);
+	ida_destroy(&nvmeotcp->queue_ids);
+	kfree(nvmeotcp);
+	priv->nvmeotcp = NULL;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
new file mode 100644
index 000000000000..a665b7a72bc2
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_H__
+#define __MLX5E_NVMEOTCP_H__
+
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+
+#include <net/ulp_ddp.h>
+#include "en.h"
+#include "en/params.h"
+
+struct mlx5e_nvmeotcp_queue_entry {
+	struct mlx5e_nvmeotcp_queue *queue;
+	u32 sgl_length;
+	u32 klm_mkey;
+	struct scatterlist *sgl;
+	u32 ccid_gen;
+	u64 size;
+
+	/* for the ddp invalidate done callback */
+	void *ddp_ctx;
+	struct ulp_ddp_io *ddp;
+};
+
+struct mlx5e_nvmeotcp_queue_handler {
+	struct napi_struct napi;
+	struct mlx5e_cq *cq;
+};
+
+/**
+ *	struct mlx5e_nvmeotcp_queue - mlx5 metadata for NVMEoTCP queue
+ *	@ulp_ddp_ctx: Generic ulp ddp context
+ *	@tir: Destination TIR created for NVMEoTCP offload
+ *	@fh: Flow handle representing the 5-tuple steering for this flow
+ *	@id: Flow tag ID used to identify this queue
+ *	@size: NVMEoTCP queue depth
+ *	@ccid_gen: Generation ID for the CCID, used to avoid conflicts in DDP
+ *	@max_klms_per_wqe: Number of KLMs per DDP operation
+ *	@hash: Hash table of queues mapped by @id
+ *	@pda: Padding alignment
+ *	@tag_buf_table_id: Tag buffer table for CCIDs
+ *	@dgst: Digest supported (header and/or data)
+ *	@sq: Send queue used for posting umrs
+ *	@ref_count: Reference count for this structure
+ *	@after_resync_cqe: Indicate if resync occurred
+ *	@ccid_table: Table holding metadata for each CC (Command Capsule)
+ *	@ccid: ID of the current CC
+ *	@ccsglidx: Index within the scatter-gather list (SGL) of the current CC
+ *	@ccoff: Offset within the current CC
+ *	@ccoff_inner: Current offset within the @ccsglidx element
+ *	@channel_ix: Channel IX for this nvmeotcp_queue
+ *	@sk: The socket used by the NVMe-TCP queue
+ *	@crc_rx: CRC Rx offload indication for this queue
+ *	@priv: mlx5e netdev priv
+ *	@static_params_done: Async completion structure for the initial umr mapping
+ *	synchronization
+ *	@sq_lock: Spin lock for the icosq
+ *	@qh: Completion queue handler for processing umr completions
+ */
+struct mlx5e_nvmeotcp_queue {
+	struct ulp_ddp_ctx ulp_ddp_ctx;
+	struct mlx5e_tir tir;
+	struct mlx5_flow_handle *fh;
+	int id;
+	u32 size;
+	/* needed when the upper layer immediately reuses CCID + some packet loss happens */
+	u32 ccid_gen;
+	u32 max_klms_per_wqe;
+	struct rhash_head hash;
+	int pda;
+	u32 tag_buf_table_id;
+	u8 dgst;
+	struct mlx5e_icosq sq;
+
+	/* data-path section cache aligned */
+	refcount_t ref_count;
+	/* for MASK HW resync cqe */
+	bool after_resync_cqe;
+	struct mlx5e_nvmeotcp_queue_entry *ccid_table;
+	/* current ccid fields */
+	int ccid;
+	int ccsglidx;
+	off_t ccoff;
+	int ccoff_inner;
+
+	u32 channel_ix;
+	struct sock *sk;
+	u8 crc_rx:1;
+	/* for ddp invalidate flow */
+	struct mlx5e_priv *priv;
+	/* end of data-path section */
+
+	struct completion static_params_done;
+	/* spin lock for the ico sq, ULP can issue requests from multiple contexts */
+	spinlock_t sq_lock;
+	struct mlx5e_nvmeotcp_queue_handler qh;
+};
+
+struct mlx5e_nvmeotcp {
+	struct ida queue_ids;
+	struct rhashtable queue_hash;
+	bool enabled;
+};
+
+void mlx5e_nvmeotcp_build_netdev(struct mlx5e_priv *priv);
+int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv);
+int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable);
+void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
+#else
+
+static inline void mlx5e_nvmeotcp_build_netdev(struct mlx5e_priv *priv) {}
+static inline int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv) { return 0; }
+static inline void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv) {}
+static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en) { return -EOPNOTSUPP; }
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+#endif
+#endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index dff02434ff45..2f26ad83f218 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -38,6 +38,7 @@
 #include "en/ptp.h"
 #include "lib/clock.h"
 #include "en/fs_ethtool.h"
+#include "en_accel/nvmeotcp.h"
 
 void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo)
@@ -1929,6 +1930,11 @@ int mlx5e_modify_rx_cqe_compression_locked(struct mlx5e_priv *priv, bool new_val
 		return -EINVAL;
 	}
 
+	if (priv->channels.params.nvmeotcp) {
+		netdev_warn(priv->netdev, "Can't set CQE compression after ULP DDP NVMe-TCP offload\n");
+		return -EINVAL;
+	}
+
 	new_params = priv->channels.params;
 	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_COMPRESS, new_val);
 	if (rx_filter)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 934b0d5ce1b3..37492af5b038 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -62,7 +62,7 @@ struct mlx5e_flow_steering {
 #ifdef CONFIG_MLX5_EN_ARFS
 	struct mlx5e_arfs_tables       *arfs;
 #endif
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	struct mlx5e_accel_fs_tcp      *accel_tcp;
 #endif
 	struct mlx5e_fs_udp            *udp;
@@ -1561,7 +1561,7 @@ void mlx5e_fs_set_any(struct mlx5e_flow_steering *fs, struct mlx5e_fs_any *any)
 	fs->any = any;
 }
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 struct mlx5e_accel_fs_tcp *mlx5e_fs_get_accel_tcp(struct mlx5e_flow_steering *fs)
 {
 	return fs->accel_tcp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 40277594c93a..fd0e6f4f1ae6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -50,6 +50,7 @@
 #include "en_accel/macsec.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ktls.h"
+#include "en_accel/nvmeotcp.h"
 #include "lib/vxlan.h"
 #include "lib/clock.h"
 #include "en/port.h"
@@ -4199,6 +4200,13 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 		features &= ~NETIF_F_NETNS_LOCAL;
 	}
 
+	if (features & (NETIF_F_LRO | NETIF_F_GRO_HW)) {
+		if (params->nvmeotcp) {
+			netdev_warn(netdev, "Disabling HW-GRO/LRO, not supported after ULP DDP NVMe-TCP offload\n");
+			features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
+		}
+	}
+
 	mutex_unlock(&priv->state_lock);
 
 	return features;
@@ -4952,6 +4960,9 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_has_offload_stats   = mlx5e_has_offload_stats,
 	.ndo_get_offload_stats   = mlx5e_get_offload_stats,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	.ulp_ddp_ops             = &mlx5e_nvmeotcp_ops,
+#endif
 };
 
 static u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout)
@@ -5221,6 +5232,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	mlx5e_macsec_build_netdev(priv);
 	mlx5e_ipsec_build_netdev(priv);
 	mlx5e_ktls_build_netdev(priv);
+	mlx5e_nvmeotcp_build_netdev(priv);
 }
 
 void mlx5e_create_q_counters(struct mlx5e_priv *priv)
@@ -5292,6 +5304,10 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (err)
 		mlx5_core_err(mdev, "TLS initialization failed, %d\n", err);
 
+	err = mlx5e_nvmeotcp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "NVMEoTCP initialization failed, %d\n", err);
+
 	mlx5e_health_create_reporters(priv);
 
 	/* If netdev is already registered (e.g. move from uplink to nic profile),
@@ -5312,6 +5328,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
+	mlx5e_nvmeotcp_cleanup(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 15561965d2af..6cd1f3660340 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1727,6 +1727,7 @@ static const int types[] = {
 	MLX5_CAP_MACSEC,
 	MLX5_CAP_ADV_VIRTUALIZATION,
 	MLX5_CAP_CRYPTO,
+	MLX5_CAP_DEV_NVMEOTCP,
 };
 
 static void mlx5_hca_caps_free(struct mlx5_core_dev *dev)
-- 
2.34.1


