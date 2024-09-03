Return-Path: <netdev+bounces-124357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23819691B9
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 05:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4ED1C22AC0
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704F1CDFC7;
	Tue,  3 Sep 2024 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn8tHFoI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214B1CDFC5
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725333593; cv=none; b=TmPQiaNa2dmMe4aCNYNJEainxKEs6MzKBqekAZ/v5e4gP/i5SfwnT27rzzHg9tb8PPNQcinGgVVYD2zqotrIkEp5yanD1WBXcNzd50f7BhoUljA3pj65ttWUg1oLO38YY58Srv3GPxAF1UBDWJfVRQR53MG8lmIuquXuFHRRFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725333593; c=relaxed/simple;
	bh=QXuBPXrIIPPVHG42N2a6WI6jC7DZNbTCPmY9FJQXn6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP07zgeju/JztZkXH9WWyBs3U0Eo1skcnZjMB37/w51UvMHHdIzCWYqJfXbuRmMGMvKXAlvcCsq4mM2mdGmmP8WigQMOpMJ5VpyFNymbTOsVUA2Luc5PmWSC6zEFok3+jUiuNPDvbV1/0RS0ZEiMQqmiUBSUvtNS7vTNjz5AVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn8tHFoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE1DC4CEC2;
	Tue,  3 Sep 2024 03:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725333592;
	bh=QXuBPXrIIPPVHG42N2a6WI6jC7DZNbTCPmY9FJQXn6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dn8tHFoIol31ovugUKMDvWBCE1Es2yzudwKkbrWKpi8MqklYWsqEDZmO1phdKHxBR
	 JGCHOfJAV9j/TLcdTQHU+ISPRFOhBkRW/9PwuFAGJ6VEF0L8nwoH505XIMFonS8lK5
	 0CdsfFj2jmmC7UBpsT1avEOenCyj9TvqL78rqazq+hfTJMzYF7bD002O96uA59M07O
	 TnfVp+2uleZ4eV6xY+btcL2Iv9NQTce34mXsJPT6Ds+pnNBMzewk4Ob9lnk8c00P6e
	 6tXYEd/UPxFbR02hh2bhoMfRimjLUNYFsL/gpaDzcul7E6/wo8a7RU/e1Z7myKCDhx
	 vOqcyCQqaYIfg==
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
Subject: [net-next 02/15] net/mlx5: Added missing definitions in preparation for HW Steering
Date: Mon,  2 Sep 2024 20:19:33 -0700
Message-ID: <20240903031948.78006-3-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903031948.78006-1-saeed@kernel.org>
References: <20240903031948.78006-1-saeed@kernel.org>
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


