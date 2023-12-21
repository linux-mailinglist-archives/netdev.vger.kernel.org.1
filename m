Return-Path: <netdev+bounces-59772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C96E81C03F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33C5B24C2F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C17764A;
	Thu, 21 Dec 2023 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4N0td5D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1D76DDC
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qd6INjYybMnhWK5DIEvWCT+DEuZJqTNmba0nTxolHcrUQB8r1wWaDm73/HO+g3+bt/dQbZlJwA4b/eVOIDp1lAlRWBB6JBSbe699O3qCUdF4XyqIkBjglnxNmBRvIDfonGRuc2dW7jNa66WJ8Mq3vMAQfpMluQSlNdB0JQPGIUGyX96u9x/judbR6xAjPRT4geFjM+F/ji8Mo51s9ktCmAmpJ3sbQ9TZODSIMCg9zVnUq/p9H1bXufqSzpVqycqloWDyvidh6xpxoZB7fv5VYSco/7Lc1jyz9pnxlyufaEikqzPPYyDrH5bve6iKaC1UZ/CudoAAcSoF04fqJbp7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/tHnrHvLYAwRXyiGrR5BTXybg8Pj4BCVeXhZaRTll4=;
 b=S70OYFm6qYaYH3mLs/WS2SylgdLBX5p+qOjEg2bZHIfhyQyZhOCPn8t+FgW22FWeOs9eVJy1IQigDwkghIe7D3xUgRrv2CykTkusikEGVnEH+LkTLgqzlc+ClWLYX/1lWsvimhnpuHfHWgLEWee9wEOyJ2F8URukB4LJH+W/PTePYEo8kiqwh6/H1mKbg7c3c3BQHBijJJsNlL6acp1SHqrtlDvf2nSSl9z+78oImu+iTH81vjF728I6fyHLb2jcSXyOjLZFt5uMlQJ1l0W/ya/WJ/DOxTgpIwdftAwlgxoMGOp2/t/NnYbYJKpPpacKfBfrFE+0fA7gZjVmd2oZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/tHnrHvLYAwRXyiGrR5BTXybg8Pj4BCVeXhZaRTll4=;
 b=m4N0td5D0B6AhujllRrxgn6zKZw9iGj33ArsxM+X6i+4XcYN7yQREZ52LQmApK+zZsekBEhtnUj24SldI5x6DHWDfi2QyIx0OdMny1D5VCK98UmLn1AI7yqC24/ub7X3y/1Y2YP73WbQi13loMV+hzpi37IUss0h/fXRORHg0uIcxYx7JlBD320Koo+V1lpqwc0RA0a8gQWUDJWRg8mYsQ6DKiSxvAIaVCrRsTEul6wpk5hutFlGgReGRn4gfdYXCMza6WGXGXlUjMGa9+Q4n0HX92yeGeLbBGlr6YMCSs/mdxVEMNCVdJYuvNEG9D41kWPJGQm9zszEOmZEC7Segw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:34:54 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:34:54 +0000
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
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v22 10/20] net/mlx5e: Rename from tls to transport static params
Date: Thu, 21 Dec 2023 21:33:48 +0000
Message-Id: <20231221213358.105704-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::28) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd63385-0706-41a8-792b-08dc026caba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nlv7tKABnrXff1HUkWfgYs3X6J9iirr2G5PEhy5FGIB6TzteVCSYL36dC564oZBQHBiny4dqWl9Nsej5Y2QjFzkTyLpHYo81FrJDf0/rRBDZzo/umFbwkAtDUHRU05HhtZzVebZKrazlnhLEMxL0bzmyczZNZeGeBlS6Ppz5ph1eQZPc5cpOKY3IJsYzbV7nOt9xrBdc93XAg9ykEm0NEt6HpTQh7oxewl8Jpe1+BgX7StfZ1hAnNHCSB1PwauNjEWjZZz8607nYAuQQhgL1g5L//Aa21xUSNKC3QI4rN/IXQcKT+JQZCG2gvcI0yaQR2cykGW0OzxCuSPB8v/DeK0E1dgEXx0nHqwuTciJBneKp0Tc4Q8QsuLSxzyeyxkRBMmrauLE+LNyibTcxkSDxnUprV5gcB1XzND8zDYPmZTymK3Mo7mX3k7mysvlVbXYtU2VPiBCj46qrwfNd+15IZvjNIE4oQZt9diQrtKHinL4bmNlLibzVvOuN7CQ2ddmMado+BLHqRxiqT/jx3fgWfnvJs3Eo94grUZJsPMVkcQ8lHwif5Rc7b66PO8jZTiXnqKcqb+2iNP1DzI3wfzoP0lHWQ8gQuQva10NuLMk/ecI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(6666004)(30864003)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(107886003)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/7C3C/0dlWdClnsU7V1dgBu7qZXBIXjjulWanIt+RgvP8PwszuF3Bxa8m5z?=
 =?us-ascii?Q?5fJSKI6soGK5jPnj0zoaoKhqanmgX5ANrGYuKL43ARoH5f998k4em8CbPZEI?=
 =?us-ascii?Q?JktiYzIC3uEBOv9N+B9Yjo579HtSkat9Sxvduw3biza1F7ZjqqOkNS5B8tB3?=
 =?us-ascii?Q?/9sQos8q0oHqY5m2346aYE/UQCuensPOBwG9s7mkyapA5JzVyMsXWTVQDUst?=
 =?us-ascii?Q?+qQoHjKBQ0EOwal6M4vJBZDm86VuLEuFgmwuvgPG3K6NxG03b/KoNG8Iwie5?=
 =?us-ascii?Q?+55uAM3G77sxP4QgitocBjyrDDyRHZ3T5lkAbYoHiRYC3DPvFPt4P/Mex5w+?=
 =?us-ascii?Q?jhMfDXnYceDwrr334wn6mzmj4XK3u2ER1FVjcLmwsXpu9V30fTgFtCTwZXz4?=
 =?us-ascii?Q?dQLi7px2CIaowEl5uc6glRvL2b5W7Ycg6Fb6mNEv1H7OMmICcOs6x+hr4wyT?=
 =?us-ascii?Q?0LH7b95Uydy19wLM7S7Lj/5zKTyZs3/BHwoNROZqI5PPLWlhKwTn9YeWErdd?=
 =?us-ascii?Q?itpR2w6sy4KC7YfeqGobV1XKi5eGf95cUCUthq1LC72FSe09i6nf9A+7dQ2p?=
 =?us-ascii?Q?XFauPaX/2BEi+BFJy+HMZU6DYJzpwNliZeXV9GonOfEUwgfzeZj2YVnvv0kS?=
 =?us-ascii?Q?LamdKsIs2bNLveZ6KR+/deo4PniQhSM/SMgG1jhN3RReaI3koyLImumBEB4L?=
 =?us-ascii?Q?0XfsNc0AjZsJN2GDtb4jqJMg4C0TNhmcheWziJr/rcMm7tXHNA4USfQyR8/k?=
 =?us-ascii?Q?gx1/qs+mewNQomz5p6of2Km7W2i8m+fHScaXs4s5k3tAMk/ysC6WR2SWuCZk?=
 =?us-ascii?Q?ZJuSXVeoIKMixnBQ876u82m1PIqDJMKDonBtstQ39n56d365wJNWDvmIf0U7?=
 =?us-ascii?Q?SxTp9rUtOX5IqRtCyCXTNhxXH+m8p5xmyfcbJDiaChvLKXWzvlCBp8Eo8tmV?=
 =?us-ascii?Q?FJblQ5eUd/3ZE4+65a6mPgv1v9SPWfL+KUvr1F6q23LPUIYS8g1AKrMoHtZy?=
 =?us-ascii?Q?6c2/VGHnCuoGQYheu/c5g9HURZOIuHeH+6uYd06iKz3qxOvtamDEi5Y9v/0V?=
 =?us-ascii?Q?V+p+Vp83x9SOmasuHbMCJyGU+C5fjw2MpcYxiQ3Nhxymddl04wiHOnzLUmz8?=
 =?us-ascii?Q?sguP7QGHuJiASIskgd5Nn23fZjsGTqJdzJeeqep+yLz5J2/OVWU27rJXGOO6?=
 =?us-ascii?Q?aQ+D//VO/iJUUk++nwRlYzJoXpHYmo8EOmOYm6qY4uBw1R01G7R4LvjJcW87?=
 =?us-ascii?Q?v+ylMGsLfY6z4msPeUY9KuMqSocra+23a2MxoOcoudfHjrYnsk9p2DzR7VTB?=
 =?us-ascii?Q?5dalTZufjVZbmMrjYtpaMFiC1GZUEhvb6xcYgt5QLieQ/SGdhXvP4Bw9k2ti?=
 =?us-ascii?Q?geb3glYv+t2Wrxoag2Kw5vw0kV05ixV6qgyIFPm9K1v8F53WlVAjDeP4yyFl?=
 =?us-ascii?Q?kiAaQfHTBQZEgUcR5mOYc43CWOoCz7Xk3QAJEZXpbyd3hURPrIX45dZoCWkA?=
 =?us-ascii?Q?z5v2MDHr1XK3g7nX8P+EAK6tGjt1I0ouqTUqlAjV9R0uIYG0vRwyHPRZlQjn?=
 =?us-ascii?Q?5xzWj/gYbqPODa1nw2TdXE/nMNeN9mRU8BUvmr1G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd63385-0706-41a8-792b-08dc026caba3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:34:54.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYBu88IoTg74t1rmp0Z9j045rmHNltgveSDJGyMLEwp89qWjVj35DxmgVVfMq2AOUfTNI43k+wNyzt6infcyGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

From: Or Gerlitz <ogerlitz@nvidia.com>

The static params structure is used in TLS but also in other
transports we're offloading like nvmeotcp:

- Rename the relevant structures/fields
- Create common file for appropriate transports
- Apply changes in the TLS code

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/en_accel/common_utils.h         | 32 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/ktls.c        |  2 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  6 ++--
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  8 ++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 36 ++++++++-----------
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  | 17 ++-------
 include/linux/mlx5/device.h                   |  8 ++---
 include/linux/mlx5/mlx5_ifc.h                 |  8 +++--
 8 files changed, 67 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
new file mode 100644
index 000000000000..efdf48125848
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_COMMON_UTILS_H__
+#define __MLX5E_COMMON_UTILS_H__
+
+#include "en.h"
+
+struct mlx5e_set_transport_static_params_wqe {
+	struct mlx5_wqe_ctrl_seg ctrl;
+	struct mlx5_wqe_umr_ctrl_seg uctrl;
+	struct mlx5_mkey_seg mkc;
+	struct mlx5_wqe_transport_static_params_seg params;
+};
+
+/* macros for transport_static_params handling */
+#define MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS \
+	(DIV_ROUND_UP(sizeof(struct mlx5e_set_transport_static_params_wqe), MLX5_SEND_WQE_BB))
+
+#define MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
+	((struct mlx5e_set_transport_static_params_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_transport_static_params_wqe)))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ \
+	(sizeof(struct mlx5e_set_transport_static_params_wqe))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT \
+	(DIV_ROUND_UP(MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ, MLX5_SEND_WQE_DS))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE \
+	(MLX5_ST_SZ_BYTES(transport_static_params) / MLX5_SEND_WQE_DS)
+
+#endif /* __MLX5E_COMMON_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index 984fa04bd331..bab9b0c59491 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -100,7 +100,7 @@ bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 		return false;
 
 	/* Check the possibility to post the required ICOSQ WQEs. */
-	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS))
+	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS))
 		return false;
 	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS))
 		return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 9b597cb24598..20994773056c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -136,16 +136,16 @@ static struct mlx5_wqe_ctrl_seg *
 post_static_params(struct mlx5e_icosq *sq,
 		   struct mlx5e_ktls_offload_context_rx *priv_rx)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	struct mlx5e_icosq_wqe_info wi;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, num_wqebbs)))
 		return ERR_PTR(-ENOSPC);
 
 	pi = mlx5e_icosq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_rx->crypto_info,
 				       mlx5e_tir_get_tirn(&priv_rx->tir),
 				       mlx5_crypto_dek_get_id(priv_rx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index d61be26a4df1..0691995470e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -33,7 +33,7 @@ u16 mlx5e_ktls_get_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 
 	num_dumps = mlx5e_ktls_dumps_num_wqes(params, MAX_SKB_FRAGS, TLS_MAX_PAYLOAD_SIZE);
 
-	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS);
+	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS);
 	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS);
 	stop_room += num_dumps * mlx5e_stop_room_for_wqe(mdev, MLX5E_KTLS_DUMP_WQEBBS);
 	stop_room += 1; /* fence nop */
@@ -550,12 +550,12 @@ post_static_params(struct mlx5e_txqsq *sq,
 		   struct mlx5e_ktls_offload_context_tx *priv_tx,
 		   bool fence)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_txqsq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_tx->crypto_info,
 				       priv_tx->tisn,
 				       mlx5_crypto_dek_get_id(priv_tx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
index 570a912dd6fa..8abea6fe6cd9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
@@ -8,10 +8,6 @@ enum {
 	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
 };
 
-enum {
-	MLX5E_ENCRYPTION_STANDARD_TLS = 0x1,
-};
-
 #define EXTRACT_INFO_FIELDS do { \
 	salt    = info->salt;    \
 	rec_seq = info->rec_seq; \
@@ -20,7 +16,7 @@ enum {
 } while (0)
 
 static void
-fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
+fill_static_params(struct mlx5_wqe_transport_static_params_seg *params,
 		   union mlx5e_crypto_info *crypto_info,
 		   u32 key_id, u32 resync_tcp_sn)
 {
@@ -53,25 +49,25 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		return;
 	}
 
-	gcm_iv      = MLX5_ADDR_OF(tls_static_params, ctx, gcm_iv);
-	initial_rn  = MLX5_ADDR_OF(tls_static_params, ctx, initial_record_number);
+	gcm_iv      = MLX5_ADDR_OF(transport_static_params, ctx, gcm_iv);
+	initial_rn  = MLX5_ADDR_OF(transport_static_params, ctx, initial_record_number);
 
 	memcpy(gcm_iv,      salt,    salt_sz);
 	memcpy(initial_rn,  rec_seq, rec_seq_sz);
 
 	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
 
-	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
-	MLX5_SET(tls_static_params, ctx, const_1, 1);
-	MLX5_SET(tls_static_params, ctx, const_2, 2);
-	MLX5_SET(tls_static_params, ctx, encryption_standard,
-		 MLX5E_ENCRYPTION_STANDARD_TLS);
-	MLX5_SET(tls_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
-	MLX5_SET(tls_static_params, ctx, dek_index, key_id);
+	MLX5_SET(transport_static_params, ctx, tls_version, tls_version);
+	MLX5_SET(transport_static_params, ctx, const_1, 1);
+	MLX5_SET(transport_static_params, ctx, const_2, 2);
+	MLX5_SET(transport_static_params, ctx, acc_type,
+		 MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS);
+	MLX5_SET(transport_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
+	MLX5_SET(transport_static_params, ctx, dek_index, key_id);
 }
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
@@ -80,19 +76,17 @@ mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg     *cseg  = &wqe->ctrl;
 	u8 opmod = direction == TLS_OFFLOAD_CTX_DIR_TX ?
-		MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS :
-		MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS;
-
-#define STATIC_PARAMS_DS_CNT DIV_ROUND_UP(sizeof(*wqe), MLX5_SEND_WQE_DS)
+		MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
 
 	cseg->opmod_idx_opcode = cpu_to_be32((pc << 8) | MLX5_OPCODE_UMR | (opmod << 24));
 	cseg->qpn_ds           = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
-					     STATIC_PARAMS_DS_CNT);
+					     MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT);
 	cseg->fm_ce_se         = fence ? MLX5_FENCE_MODE_INITIATOR_SMALL : 0;
 	cseg->tis_tir_num      = cpu_to_be32(tis_tir_num << 8);
 
 	ucseg->flags = MLX5_UMR_INLINE;
-	ucseg->bsf_octowords = cpu_to_be16(MLX5_ST_SZ_BYTES(tls_static_params) / 16);
+	ucseg->bsf_octowords = cpu_to_be16(MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE);
 
 	fill_static_params(&wqe->params, crypto_info, key_id, resync_tcp_sn);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
index 3d79cd379890..5e2d186778aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
@@ -6,6 +6,7 @@
 
 #include <net/tls.h>
 #include "en.h"
+#include "en_accel/common_utils.h"
 
 enum {
 	MLX5E_TLS_PROGRESS_PARAMS_AUTH_STATE_NO_OFFLOAD     = 0,
@@ -33,13 +34,6 @@ union mlx5e_crypto_info {
 	struct tls12_crypto_info_aes_gcm_256 crypto_info_256;
 };
 
-struct mlx5e_set_tls_static_params_wqe {
-	struct mlx5_wqe_ctrl_seg ctrl;
-	struct mlx5_wqe_umr_ctrl_seg uctrl;
-	struct mlx5_mkey_seg mkc;
-	struct mlx5_wqe_tls_static_params_seg params;
-};
-
 struct mlx5e_set_tls_progress_params_wqe {
 	struct mlx5_wqe_ctrl_seg ctrl;
 	struct mlx5_wqe_tls_progress_params_seg params;
@@ -50,19 +44,12 @@ struct mlx5e_get_tls_progress_params_wqe {
 	struct mlx5_seg_get_psv  psv;
 };
 
-#define MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS \
-	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_static_params_wqe), MLX5_SEND_WQE_BB))
-
 #define MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
 #define MLX5E_KTLS_GET_PROGRESS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_get_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
-#define MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
-	((struct mlx5e_set_tls_static_params_wqe *)\
-	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_static_params_wqe)))
-
 #define MLX5E_TLS_FETCH_SET_PROGRESS_PARAMS_WQE(sq, pi) \
 	((struct mlx5e_set_tls_progress_params_wqe *)\
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_progress_params_wqe)))
@@ -76,7 +63,7 @@ struct mlx5e_get_tls_progress_params_wqe {
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_dump_wqe)))
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 820bca965fb6..f1dde3c6a3f3 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -454,8 +454,8 @@ enum {
 };
 
 enum {
-	MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS = 0x1,
-	MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS = 0x2,
+	MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS = 0x1,
+	MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS = 0x2,
 };
 
 enum {
@@ -463,8 +463,8 @@ enum {
 	MLX5_OPC_MOD_TLS_TIR_PROGRESS_PARAMS = 0x2,
 };
 
-struct mlx5_wqe_tls_static_params_seg {
-	u8     ctx[MLX5_ST_SZ_BYTES(tls_static_params)];
+struct mlx5_wqe_transport_static_params_seg {
+	u8     ctx[MLX5_ST_SZ_BYTES(transport_static_params)];
 };
 
 struct mlx5_wqe_tls_progress_params_seg {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index ce2e71cd6d2a..7388410292ae 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12358,12 +12358,16 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
 };
 
-struct mlx5_ifc_tls_static_params_bits {
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+};
+
+struct mlx5_ifc_transport_static_params_bits {
 	u8         const_2[0x2];
 	u8         tls_version[0x4];
 	u8         const_1[0x2];
 	u8         reserved_at_8[0x14];
-	u8         encryption_standard[0x4];
+	u8         acc_type[0x4];
 
 	u8         reserved_at_20[0x20];
 
-- 
2.34.1


