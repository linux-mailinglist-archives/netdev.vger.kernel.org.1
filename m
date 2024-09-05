Return-Path: <netdev+bounces-125378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7ED96CF3B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B5B1F26646
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373A18BC04;
	Thu,  5 Sep 2024 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxyBiIPl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052818BBB8
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517680; cv=none; b=cpx+pvxxLaSbxM6iOVOG27mOxKrAn4C6uqAI+0s/i0JIf+8jCtM6mL0qslxtQK7Shjom+sqfdhZzlrJu0WVChu48eTMf3O9V89L/LsSqiWxg3J1375/0YxhBvqCE3AwZMg4k+bwQTXWEG11NGxG3WToXT5eLMqyz3j1C3FgTwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517680; c=relaxed/simple;
	bh=QXuBPXrIIPPVHG42N2a6WI6jC7DZNbTCPmY9FJQXn6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz961JDIXI43zURr7UgcJaVkdN7JckCtokIADvZFRE5Jw/c/e8dlZApn/ykEH1Z8UTXVd6qKZrGK4ZZvCT5acxi4YjntoE3GYvID8w+g+zkUwjGWzWXBRnlDSXZwYuBss3N8oxGu1HeuBKEs/XTp7Q9uaU+zIMqx0yVHEvWr0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxyBiIPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF426C4CEC4;
	Thu,  5 Sep 2024 06:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725517679;
	bh=QXuBPXrIIPPVHG42N2a6WI6jC7DZNbTCPmY9FJQXn6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxyBiIPlJRsd4IIQVv96RSdYjMxxoO9sKTvfALZB0Q8yweUMD+b6O+4/NRDanZeRY
	 g6X5rtbJiMzysgy00sQ3DOHD2t+DGhzHz4YDfGYE3wvuSnpMRhBlIgrKVrEPx2HPIT
	 VWbxSrUMiMc6VS+QyyQbAy+zyul61uDSzoK3p04fmm6Z7lYXX3Ot7PirEBoU3Q3fE9
	 GpcRVuk2a1UCP6SLT0VkFuJCRVo1m2qFKDcNWEhXlHX7WbhReNSH4CXi6v/Wya4gZ5
	 /8hINyiPuPyAEbBaPng3YCS9XWVAWhPr6zUjyObRjYau6P290/4QWatPxZ/rbbwczm
	 V98j3pDQ8ugzg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Hamdan Agbariya <hamdani@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net-next V2 02/15] net/mlx5: Added missing definitions in preparation for HW Steering
Date: Wed,  4 Sep 2024 23:27:37 -0700
Message-ID: <20240905062752.10883-3-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905062752.10883-1-saeed@kernel.org>
References: <20240905062752.10883-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

As part of preparation for HWS, added missing definitions
in qp.h and fs_core.h:

 - FS_FT_FDB_RX/TX table types that are used by HWS in addition
   to an existing FS_FT_FDB
 - MLX5_WQE_CTRL_INITIATOR_SMALL_FENCE that is used by HWS to
   require fence in WQE

Reviewed-by: Hamdan Agbariya <hamdani@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 8 ++++++--
 include/linux/mlx5/qp.h                           | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 78eb6b7097e1..6201647d6156 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -110,7 +110,9 @@ enum fs_flow_table_type {
 	FS_FT_RDMA_RX		= 0X7,
 	FS_FT_RDMA_TX		= 0X8,
 	FS_FT_PORT_SEL		= 0X9,
-	FS_FT_MAX_TYPE = FS_FT_PORT_SEL,
+	FS_FT_FDB_RX		= 0xa,
+	FS_FT_FDB_TX		= 0xb,
+	FS_FT_MAX_TYPE = FS_FT_FDB_TX,
 };
 
 enum fs_flow_table_op_mod {
@@ -368,7 +370,9 @@ struct mlx5_flow_root_namespace *find_root(struct fs_node *node);
 	(type == FS_FT_RDMA_RX) ? MLX5_CAP_FLOWTABLE_RDMA_RX(mdev, cap) :		\
 	(type == FS_FT_RDMA_TX) ? MLX5_CAP_FLOWTABLE_RDMA_TX(mdev, cap) :      \
 	(type == FS_FT_PORT_SEL) ? MLX5_CAP_FLOWTABLE_PORT_SELECTION(mdev, cap) :      \
-	(BUILD_BUG_ON_ZERO(FS_FT_PORT_SEL != FS_FT_MAX_TYPE))\
+	(type == FS_FT_FDB_RX) ? MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, cap) :      \
+	(type == FS_FT_FDB_TX) ? MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, cap) :      \
+	(BUILD_BUG_ON_ZERO(FS_FT_FDB_TX != FS_FT_MAX_TYPE))\
 	)
 
 #endif
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index ad1ce650146c..fc7eeff99a8a 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -149,6 +149,7 @@ enum {
 	MLX5_WQE_CTRL_CQ_UPDATE		= 2 << 2,
 	MLX5_WQE_CTRL_CQ_UPDATE_AND_EQE	= 3 << 2,
 	MLX5_WQE_CTRL_SOLICITED		= 1 << 1,
+	MLX5_WQE_CTRL_INITIATOR_SMALL_FENCE = 1 << 5,
 };
 
 enum {
-- 
2.46.0


