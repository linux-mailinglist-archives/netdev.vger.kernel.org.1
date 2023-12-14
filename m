Return-Path: <netdev+bounces-57444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043E5813191
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC91283208
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AC356462;
	Thu, 14 Dec 2023 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h91mZCTg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB181BB
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:27:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJaIKVXdVQ43ZWy5geQqSDlMsEt//C1ByxY0IzRQmawcks5YTaqUTiaqOox+oGcEcADqf/lLAT2yWyGYov+YUIcDWe6yHVeW/doGpHNSwI0HvxcuY0tV/ZalSeCw423WPJ2H32bere5ea7QFNjFEVEg3lBFN+n5sGU39JNjGropyjdWWAZXapK5QcQzky8F8+9szWfhJfzFjxvRuUMhLBHyOzzXjelRuabOiiRtU+qEJSEYefusfPBmc1NnHR2fL8NSve2OasobfQM2cyCMbaqhho39ee2UiM9bgn92NqQ0Ni9bKqf4z36Omqrv31YotyM0P8/dCBWpIhMzeDu4x2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqtZCLO4Y4zH4yfPX0F507i/zP5ywdVWLtna6KO07xQ=;
 b=msRAcOoxkviAOLEmUVQcAyB6mBA3iwPegTL0MUbrE6s1WsAv9pxabweWy0xGJqtpIYxIEQBFHLKzPPiZ7wXId1/aERr1PtAh89NeU2M/MchSzfxIp1jzCS8qAthoFpQpTtNfLkOc8o0Us5zaiPpHPvNqyu+wc31dWLdoPax/+fsp7diTEutHOuHiNpOBCszLeeKbA98I2DUAPEADN+nHqv2wkCjMxybHZ0dcqcOOPqqBRcga1jl2qzBQuK126xAffZvQpJeAhZ0aedWHaproEplaT+tbtg0JicH5RkLoXiyL3knIU96UtogRt8g+Ybb5NYtaXlTjihlqAHeaOa6XDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqtZCLO4Y4zH4yfPX0F507i/zP5ywdVWLtna6KO07xQ=;
 b=h91mZCTgk7SJpyFCkU3/vRfKc0LOLLSoY1jWUui599sVgrTkFU3lsay1GO9rE0JeanAJjP94/Sb34qhuskA6mso4gudLYgeSkCWKW7PbcRbW0pp87cwe/PWUQEyJCxwnYwNHSQ6lsOuA+FvB3YbFXN9SsUf2Kkv0dkUbbVFmLQmIRF8SVI1fOYOyqlL9gPBUdJddapX7RtMOAUKfCvMp+UzJ1ry+gtuL6VS0QyGA0HdXbFUqk0aF6jSOXiZE1cI5yMmLpfKd3VM6l3XhIo5DOem5MRuu+2RbyCX4GuzeMn59os4zzUN1g+kn9Ke1fjTfXiAxdE+jBNRDxraNLYnGxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:41 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:41 +0000
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
Subject: [PATCH v21 13/20] net/mlx5e: NVMEoTCP, offload initialization
Date: Thu, 14 Dec 2023 13:26:16 +0000
Message-Id: <20231214132623.119227-14-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: e05a8cf1-daf9-4975-75aa-08dbfca8722d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TO4YCy2nVnBnhw6y9x+DNvEOI+fEhCVrBpSn6/mYetxisi+KgIhUSA7CW2GjKpsS8POWgrIxlIYxJ9X4YPH2+e0B1BAGku5uYY6OWEdntbI00K8myGttKWaDKsDxKd58vPb8XAQz5MfoPqLBYBhnaSXKL2ESKww1yqVpOH0157DMpXdzEW0Ep/76Cfiws8Y7xhOUTs5bwBfAihtZNi2XCXbPUcaHsaMwEtSNorpXitJciU5gOsrhSmItz2FD0vics2duZAQmYfVGV/8OT7TGQ/2hJDOqxnf9ENL14w8ifuMCZHV4xSPsumEea9/fe1k+NwQVuATMUggKWp5AlzAfxAyjpeVNPTLjt0CCyCP0yL/4/TB7DDcAPDOkhwRLrAjgJia6mGQmI3kfgB5lfPY7RboPGGqweE8E80x94SMDqjhoUEo9+Wbvt2vHlPk3huU2aguBEHBantKTnP/smfTgeecxO76l+dgnpjvbYlM5+/F1esgkCv3JkTuxDP+9af5gWwxCGm53GvKGLY72GjEb+IZbp0C9E4tjKzXmBgo/bsqBS29rWuP663joh47ictTV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(41300700001)(66899024)(83380400001)(38100700002)(316002)(7416002)(5660300002)(26005)(107886003)(1076003)(86362001)(8936002)(4326008)(2616005)(6512007)(478600001)(6486002)(2906002)(8676002)(6666004)(6506007)(66556008)(66476007)(66946007)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syGWFPmCS/Pac+3SGDRyqjYODIzXKXyqTx+xaEgIli6EyYjCOwWMzNCPj6Ub?=
 =?us-ascii?Q?5qeZoXxDiu/yOG0wa1AGZZieh+6qLSgsgjIMrTNyoNIRWFrznBvNopl5qJ3x?=
 =?us-ascii?Q?goxPcvMDaLWANibNMVq1ODEigPTdeo2AZQZ6vvCgBpglnOAivYBTLOaJ1UBu?=
 =?us-ascii?Q?aRaQIpUTFSU7vJ8fkphHTJc7ylpSH5gkslmKi6aPyLQY2UGuMK4w89F5egO5?=
 =?us-ascii?Q?3ujPGTUUR8h1hjdqiTGO9WuVqiFQQPNQwP59KqqQhqI570ah/G6GJAnvv4DK?=
 =?us-ascii?Q?vzFlJEZMykJvNj9oqKu6SAA3J0BzbYsu9GoofXw1WilE7hEstf+l65cXaARc?=
 =?us-ascii?Q?r2vlftUGFcARhbAesqRORqOJLFLOq9QCNzBbou0Y/Vj9X37W+5rsq6Oynul1?=
 =?us-ascii?Q?Pz0frZzq4KuorI/QF8bz5aLsrnrWc1iXtjx8SwuYI5Pmf/KraYKpi5VK02jV?=
 =?us-ascii?Q?stWZ4d+4vSnZ2xZBHvwM2PnYMD6ejFwuQL0WPUbpXhdCoBtEuKdhpgU+mYTV?=
 =?us-ascii?Q?VsojPxnJ3vqabItFXdjMy+8FBM42n2gbsI09zgQJnvYBwNLTe5dGY67q4zbr?=
 =?us-ascii?Q?ANzhyTeGz/noVUiNSQ6yxQqe5bBp9ojM8flWCxqy/7J3TTsrUdku06PkYgsQ?=
 =?us-ascii?Q?dOD8beF2DTQLGSDlYA0y5TpQeechgJSucsRB1xKCkD+VLzGB1jJwRwl/oFht?=
 =?us-ascii?Q?tJgnG7nGGEbOo7FeMOQV/T/iRlnE1VQxnQJPn7CaFqbGPRuLEOABh/N64R7h?=
 =?us-ascii?Q?2JKBVS+IF+J5Kis+BdIMKCrpWSlPoitBCRSFVvPYRFey8gQeHrU4zy2tVuz2?=
 =?us-ascii?Q?756cHovL6mkKzGBj6K1YxYlFyxS1cnHbjwxJpzPRw/QmWOfmvSbhsnGegTTD?=
 =?us-ascii?Q?WiBR4E+ElLfBB1jbfWZVdDlz2JbW4O2N94r0f3t3RppVsFvFdkrHAnFEnAXM?=
 =?us-ascii?Q?HiWHkcZmD7I5KqzIQ52s1bOXctqRHcmalIhdn1y3/mYxPmVT2duuAkRSVrol?=
 =?us-ascii?Q?5NuNX+CTN/8B/NVSj05SBBuxEdw1IsR219ZE7jp14llIVuex9zU8iJ/g4g0s?=
 =?us-ascii?Q?4B9vvwDxSFd4lrGrIUBuokF6BBg5uZwkvp3CxFF8pCd/V+Ibev32OWMv6C3h?=
 =?us-ascii?Q?8kWbU9/L+6dVWwpksDYHGNQj/xZGaMMVyPdbfXhtZmECXn18QcNsVh01pipY?=
 =?us-ascii?Q?D+2lQUSdIiQWTUgtQ8nvoYnL4tM+H3jlzKD65I2Q7JC22T+ev+c8ZV3Uj/QO?=
 =?us-ascii?Q?T2BY9qG1zDOZ9+0/IxappszaEIaQXun3wABL9BLrz5lVhvrYtQYG2m36zTYQ?=
 =?us-ascii?Q?+QfZtNoGcj+YME+M9N9oK1P5HpaWaJU/MoUgDi8d0am/ZD+NFcDwgeYGMC74?=
 =?us-ascii?Q?EJPnwdyxZbyQF/VhKqpmng60QU99xgbg7xlUtoxRCAxKDayCqpBwJJWMVfd2?=
 =?us-ascii?Q?oX8o/ZYHYrlTFPMy/X9QMpur977Ga/W5njB33TbY1RwLUCULJ5sgHqKh8PQn?=
 =?us-ascii?Q?/QrI2bwjS19vgxjcNFDMQ7bSrThfGAvCC5dsY3XqP2X2EqxSGF/cqe9lsUqr?=
 =?us-ascii?Q?v9KNaQNFnwSmldtyfxqgOsqvJ+ES0JwCncsvCjQ9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05a8cf1-daf9-4975-75aa-08dbfca8722d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:40.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLZgu3u0UotzrbWjeNhuPBJ38rN6cdewfKmFAEmXEm8JJLWV2yCs16EI0TOMFxkmxxbanYnGzqUEWPUVmU2HWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

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
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 217 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 120 ++++++++++
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  16 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
 14 files changed, 396 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 685335832a93..5935c2cdefec 100644
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
index c44870b175f9..f397e2eb0cdc 100644
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
index 34be754f712c..577665af30c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -327,6 +327,7 @@ struct mlx5e_params {
 	int hard_mtu;
 	bool ptp_rx;
 	__be32 terminate_lkey_be;
+	bool nvmeotcp;
 };
 
 static inline u8 mlx5e_get_dcb_num_tc(struct mlx5e_params *params)
@@ -936,6 +937,9 @@ struct mlx5e_priv {
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
index 4d6225e0eec7..780e8b5ae8e0 100644
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
@@ -169,7 +169,7 @@ struct mlx5e_fs_any *mlx5e_fs_get_any(struct mlx5e_flow_steering *fs);
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
index caa34b9c161e..070dabb03bd4 100644
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
index 000000000000..8f99534430f0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -0,0 +1,217 @@
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
+	/* There may be offloaded queues when an netlink callback to disable the feature is made.
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
+	DECLARE_BITMAP(old_caps, ULP_DDP_CAP_COUNT);
+	struct mlx5e_params *params;
+	int ret = 0;
+	int nvme = -1;
+
+	mutex_lock(&priv->state_lock);
+	params = &priv->channels.params;
+	bitmap_copy(old_caps, priv->nvmeotcp->ddp_caps.active, ULP_DDP_CAP_COUNT);
+
+	/* always handle nvme-tcp-ddp and nvme-tcp-ddgst-rx together (all or nothing) */
+
+	if (ulp_ddp_cap_turned_on(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP) &&
+	    ulp_ddp_cap_turned_on(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP_DDGST_RX)) {
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
+	} else if (ulp_ddp_cap_turned_off(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP) &&
+		   ulp_ddp_cap_turned_off(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP_DDGST_RX)) {
+		nvme = 0;
+	}
+
+	if (nvme >= 0) {
+		ret = set_ulp_ddp_nvme_tcp(netdev, nvme);
+		if (ret)
+			goto out;
+		change_bit(ULP_DDP_CAP_NVME_TCP, priv->nvmeotcp->ddp_caps.active);
+		change_bit(ULP_DDP_CAP_NVME_TCP_DDGST_RX, priv->nvmeotcp->ddp_caps.active);
+	}
+
+out:
+	mutex_unlock(&priv->state_lock);
+	return ret;
+}
+
+static void mlx5e_ulp_ddp_get_caps(struct net_device *dev,
+				   struct ulp_ddp_dev_caps *caps)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	mutex_lock(&priv->state_lock);
+	memcpy(caps, &priv->nvmeotcp->ddp_caps, sizeof(*caps));
+	mutex_unlock(&priv->state_lock);
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
+	.get_caps = mlx5e_ulp_ddp_get_caps,
+};
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
+	if (!(MLX5_CAP_GEN(priv->mdev, nvmeotcp) &&
+	      MLX5_CAP_DEV_NVMEOTCP(priv->mdev, zerocopy) &&
+	      MLX5_CAP_DEV_NVMEOTCP(priv->mdev, crc_rx) &&
+	      MLX5_CAP_GEN(priv->mdev, cqe_128_always)))
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
+	/* report ULP DPP as supported, but don't enable it by default */
+	set_bit(ULP_DDP_CAP_NVME_TCP, nvmeotcp->ddp_caps.hw);
+	set_bit(ULP_DDP_CAP_NVME_TCP_DDGST_RX, nvmeotcp->ddp_caps.hw);
+	nvmeotcp->enabled = false;
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
index 000000000000..29546992791f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -0,0 +1,120 @@
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
+	struct ulp_ddp_dev_caps ddp_caps;
+	bool enabled;
+};
+
+int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv);
+int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable);
+void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
+#else
+
+static inline int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv) { return 0; }
+static inline void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv) {}
+static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en) { return -EOPNOTSUPP; }
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+#endif
+#endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 792a0ea544cd..fea15b4562c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -38,6 +38,7 @@
 #include "en/ptp.h"
 #include "lib/clock.h"
 #include "en/fs_ethtool.h"
+#include "en_accel/nvmeotcp.h"
 
 void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo)
@@ -1934,6 +1935,11 @@ int mlx5e_modify_rx_cqe_compression_locked(struct mlx5e_priv *priv, bool new_val
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
index 777d311d44ef..853e30f221c8 100644
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
@@ -1557,7 +1557,7 @@ void mlx5e_fs_set_any(struct mlx5e_flow_steering *fs, struct mlx5e_fs_any *any)
 	fs->any = any;
 }
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 struct mlx5e_accel_fs_tcp *mlx5e_fs_get_accel_tcp(struct mlx5e_flow_steering *fs)
 {
 	return fs->accel_tcp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5740772a7b10..1587ae90a893 100644
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
@@ -4268,6 +4269,13 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
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
@@ -5021,6 +5029,9 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_has_offload_stats   = mlx5e_has_offload_stats,
 	.ndo_get_offload_stats   = mlx5e_get_offload_stats,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	.ulp_ddp_ops             = &mlx5e_nvmeotcp_ops,
+#endif
 };
 
 static u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout)
@@ -5361,6 +5372,10 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (err)
 		mlx5_core_err(mdev, "TLS initialization failed, %d\n", err);
 
+	err = mlx5e_nvmeotcp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "NVMEoTCP initialization failed, %d\n", err);
+
 	mlx5e_health_create_reporters(priv);
 
 	/* If netdev is already registered (e.g. move from uplink to nic profile),
@@ -5381,6 +5396,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
+	mlx5e_nvmeotcp_cleanup(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index bccf6e53556c..af3865578c8c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1744,6 +1744,7 @@ static const int types[] = {
 	MLX5_CAP_MACSEC,
 	MLX5_CAP_ADV_VIRTUALIZATION,
 	MLX5_CAP_CRYPTO,
+	MLX5_CAP_DEV_NVMEOTCP,
 };
 
 static void mlx5_hca_caps_free(struct mlx5_core_dev *dev)
-- 
2.34.1


