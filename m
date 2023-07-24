Return-Path: <netdev+bounces-20573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A84D76028F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BAC1C20C66
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC4812B65;
	Mon, 24 Jul 2023 22:44:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817211CB3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B046C433CA;
	Mon, 24 Jul 2023 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690238670;
	bh=A/u/Jyvfhal+y+AhUAgwNz+gTs0QoTJkVu3PwcBiHY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2ULBIvMug6841aIlsqrdgT9qhwsnVsnfX4SFnJs5GgdRveVM9M3pjwFdGtcyg69+
	 uKRJL6MCAF6x9YfBMiVa8Rdj4g1zLuDp+KwWNpNuBis67mZXfq3vddFUDp7l4WZtBP
	 yBEFbsv4k9rGCME5MsPKJnIRixZlPyo/8/df4+QSrh5hndonBJwtbIkFskpvA/CCxo
	 ZaY8BegV26NmMh3EasBMFOMdBMZmhIxG7DhhR/goEwG3vpmBFraRPPb9AEYGT0Htgt
	 nKZjdXLIyY5H3zyRU3ypH4zL5yfpP4eeZjxTN0Ms3c+uodFnCg+OmlPWgwyWqzYvvB
	 9AWrm75Q//7hA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 01/14] net/mlx5: Expose port.c/mlx5_query_module_num() function
Date: Mon, 24 Jul 2023 15:44:13 -0700
Message-ID: <20230724224426.231024-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724224426.231024-1-saeed@kernel.org>
References: <20230724224426.231024-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adham Faris <afaris@nvidia.com>

Make mlx5_query_module_num() defined in port.c, a non-static, so it can
be used by other files.

Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index c4be257c043d..6cebc8417282 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -176,6 +176,7 @@ static inline int mlx5_flexible_inlen(struct mlx5_core_dev *dev, size_t fixed,
 
 int mlx5_query_hca_caps(struct mlx5_core_dev *dev);
 int mlx5_query_board_id(struct mlx5_core_dev *dev);
+int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num);
 int mlx5_cmd_init(struct mlx5_core_dev *dev);
 void mlx5_cmd_cleanup(struct mlx5_core_dev *dev);
 void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 0daeb4b72cca..be70d1f23a5d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -271,7 +271,7 @@ void mlx5_query_port_oper_mtu(struct mlx5_core_dev *dev, u16 *oper_mtu,
 }
 EXPORT_SYMBOL_GPL(mlx5_query_port_oper_mtu);
 
-static int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num)
+int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num)
 {
 	u32 in[MLX5_ST_SZ_DW(pmlp_reg)] = {0};
 	u32 out[MLX5_ST_SZ_DW(pmlp_reg)];
-- 
2.41.0


