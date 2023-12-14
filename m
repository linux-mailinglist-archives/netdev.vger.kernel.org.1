Return-Path: <netdev+bounces-57183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17158812506
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3222828E4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028A79E3E;
	Thu, 14 Dec 2023 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4manZsK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6D2117
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B94AC433C8;
	Thu, 14 Dec 2023 02:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519726;
	bh=Px/x4p3IP0ZcrQDhRdDjr14SDFKybDRAD24gVzEY2ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4manZsKy6Kmhf7DJoDIqAE5I/Sx3kW9m2DT0OIKXxc0wVaKEUGK5rRzL+unI7jcT
	 Y7C7z7lExzL5xAeU2eYwKXqu7ZGv5Um+GPWhv0z00RvPBW7B+D0OjQq6LNLtAE4tfa
	 Xr8D8ihYJvxFBXYLMw0kJiTJQBhYpIK6B/yGOMgcNgiUtZ9IJKPFcVRKzyPU7AZXcX
	 EbHcALFT7AyVQ6IBaOOw5AqNxgQV3+Ln0gbWDy+GHbZGa8m88zA1voYe5HrNkGY2hi
	 cJB7ykxI4mXafJbjkU56BkT4/KZlbu1s1gNdlVaf7ifjseXS33N5asj3wTT8z4LTg5
	 BgAMhl+6Kinkg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 07/11] net/mlx5e: Statify function mlx5e_monitor_counter_arm
Date: Wed, 13 Dec 2023 18:08:28 -0800
Message-ID: <20231214020832.50703-8-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214020832.50703-1-saeed@kernel.org>
References: <20231214020832.50703-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Function usage is limited to the monitor_stats.c file, do not expose it.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.c
index 254c84739046..40c8df111754 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.c
@@ -36,7 +36,7 @@ int mlx5e_monitor_counter_supported(struct mlx5e_priv *priv)
 	return true;
 }
 
-void mlx5e_monitor_counter_arm(struct mlx5e_priv *priv)
+static void mlx5e_monitor_counter_arm(struct mlx5e_priv *priv)
 {
 	u32 in[MLX5_ST_SZ_DW(arm_monitor_counter_in)] = {};
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.h
index e1ac4b3d22fb..6beba7f075c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/monitor_stats.h
@@ -7,6 +7,5 @@
 int  mlx5e_monitor_counter_supported(struct mlx5e_priv *priv);
 void mlx5e_monitor_counter_init(struct mlx5e_priv *priv);
 void mlx5e_monitor_counter_cleanup(struct mlx5e_priv *priv);
-void mlx5e_monitor_counter_arm(struct mlx5e_priv *priv);
 
 #endif /* __MLX5_MONITOR_H__ */
-- 
2.43.0


