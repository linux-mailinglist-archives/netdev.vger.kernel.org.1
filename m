Return-Path: <netdev+bounces-126076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B079796FD91
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E49B2289D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630315A86B;
	Fri,  6 Sep 2024 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvrPef+3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1C15A87F
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659658; cv=none; b=T7ScBHkRtTrg1gxkUHGJ0IYTSTmwbVynLPqt3R0Gv9pmq7QLXpjSpipM+SF50r9a0nILZFGBfkbBrVoNgbxK0tB9k1tLPuOMICbvu5Uei9VPzPv2OJ8mTmq6Zjt6NiF/na4BZgfyFGCy9+ZMVjG8hFuruDNBD8D9lpgxrJywSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659658; c=relaxed/simple;
	bh=QXuBPXrIIPPVHG42N2a6WI6jC7DZNbTCPmY9FJQXn6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNlXkwuP+wWkkFPuDQXzy+RXRxe9aan0YXSQFuLkW30gxFfNLEeJvz1BFP/JqW6GqYFRad8f4KGs7W6dkPzCyvUYtZNDt3YeloSr9g7/+XXfpTBghbyCEvcjFZ9ESPoNa9UMKPYuHpoykAGY2sX3zF1xSXu7G/0aqi04iCpqp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvrPef+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F293BC4CEC5;
	Fri,  6 Sep 2024 21:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725659658;
	bh=QXuBPXrIIPPVHG42N2a6WI6jC7DZNbTCPmY9FJQXn6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IvrPef+3XGy4paIF9bEljRKcGBbR+649LmnU489QSSMpoFtDPBJw/kGsqCjA2UQAW
	 gr11QZ1GZtxmtQaOKwVS7+jUyPJHcAiVX1vgZEwwopUgz1Rlf12LhBGIep7VVwg7eh
	 0oj86M5rPIHqyOA08cdAHyLD9CXtDe9KpPttd5D6q6jIFba/KQ1Cpn25nBRLCIM4Tg
	 kLLYuOHTt+fbTxuSm3173PBnK0kwTxDAhFthB+vm3tyvlFIs2GMFiYR5dQXEQEOjVg
	 gI5GPePIRbgRtSL53mBcruBBwBzOQB7jcFQuZPXa8QdcGgPGWqJ1yRiChCumyKHcDy
	 84tvFk8BkFM9w==
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
Subject: [net-next V3 02/15] net/mlx5: Added missing definitions in preparation for HW Steering
Date: Fri,  6 Sep 2024 14:53:57 -0700
Message-ID: <20240906215411.18770-3-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906215411.18770-1-saeed@kernel.org>
References: <20240906215411.18770-1-saeed@kernel.org>
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


