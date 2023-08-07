Return-Path: <netdev+bounces-25069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCC3772D66
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C36C1C20C99
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4408316432;
	Mon,  7 Aug 2023 17:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF47A1640B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BEAC433BC;
	Mon,  7 Aug 2023 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431022;
	bh=BzNSVPkrKjN/tywLIy5ljeiY5Qb9FpYFYtorxgxhb9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLJ2ih12LzDiDVHnALDVmDMbnYafQJdPWoh6lFpbHYMOZADglZbe9QLBG5pl98j4d
	 c6zQpMaeomMvwQZPxUxvinkxdDF0wlRqOeJGDZl5zwPQPVCdEkrY49BGlblmGkDAek
	 R7XZi0zQ4LEuxgJSg0+FcB1BYG9XoznU9WvhQkcd0zAsZQLMttjHmXbae4cQcUQ3Rn
	 xSNq3KUT4W74w+cqaFCqG8fQVCaA7akVA8K0c4igrcfQEnl4LMhGfWmElP/Mi+W3WN
	 qR70jFsG2J6+OzWfTakHZYGXhC1EsO3UHcoVe8wV4Rvnohm99OolousvkWgxgI6O/9
	 tGssoIt3a7qEQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next 09/15] net/mlx5: Rename mlx5_comp_vectors_count() to mlx5_comp_vectors_max()
Date: Mon,  7 Aug 2023 10:56:36 -0700
Message-ID: <20230807175642.20834-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807175642.20834-1-saeed@kernel.org>
References: <20230807175642.20834-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

To accurately represent its purpose, rename the function that retrieves
the value of maximum vectors from mlx5_comp_vectors_count() to
mlx5_comp_vectors_max().

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c                          | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h               | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c               | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c | 2 +-
 drivers/vfio/pci/mlx5/cmd.c                                | 2 +-
 include/linux/mlx5/driver.h                                | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f0b394ed7452..3c25b9045f9d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3685,7 +3685,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (mlx5_use_mad_ifc(dev))
 		get_ext_port_caps(dev);
 
-	dev->ib_dev.num_comp_vectors    = mlx5_comp_vectors_count(mdev);
+	dev->ib_dev.num_comp_vectors    = mlx5_comp_vectors_max(mdev);
 
 	mutex_init(&dev->cap_mask_mutex);
 	INIT_LIST_HEAD(&dev->qp_list);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 0f8f70b91485..c1deb04ba7e8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -193,7 +193,7 @@ static inline int mlx5e_get_max_num_channels(struct mlx5_core_dev *mdev)
 {
 	return is_kdump_kernel() ?
 		MLX5E_MIN_NUM_CHANNELS :
-		min_t(int, mlx5_comp_vectors_count(mdev), MLX5E_MAX_NUM_CHANNELS);
+		min_t(int, mlx5_comp_vectors_max(mdev), MLX5E_MAX_NUM_CHANNELS);
 }
 
 /* The maximum WQE size can be retrieved by max_wqe_sz_sq in
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9ec7b975c549..5710d755c2c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2856,7 +2856,7 @@ static void mlx5e_set_default_xps_cpumasks(struct mlx5e_priv *priv,
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int num_comp_vectors, ix, irq;
 
-	num_comp_vectors = mlx5_comp_vectors_count(mdev);
+	num_comp_vectors = mlx5_comp_vectors_max(mdev);
 
 	for (ix = 0; ix < params->num_channels; ix++) {
 		cpumask_clear(priv->scratchpad.cpumask);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 2f5c0d00285f..6272962ea077 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -1052,11 +1052,11 @@ int mlx5_vector2irqn(struct mlx5_core_dev *dev, int vector, unsigned int *irqn)
 	return vector2eqnirqn(dev, vector, NULL, irqn);
 }
 
-unsigned int mlx5_comp_vectors_count(struct mlx5_core_dev *dev)
+unsigned int mlx5_comp_vectors_max(struct mlx5_core_dev *dev)
 {
 	return dev->priv.eq_table->max_comp_eqs;
 }
-EXPORT_SYMBOL(mlx5_comp_vectors_count);
+EXPORT_SYMBOL(mlx5_comp_vectors_max);
 
 static struct cpumask *
 mlx5_comp_irq_get_affinity_mask(struct mlx5_core_dev *dev, int vector)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
index 4a5ae86e2b62..24bb30b5008c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
@@ -1096,7 +1096,7 @@ static struct mlx5dr_cq *dr_create_cq(struct mlx5_core_dev *mdev,
 	if (!in)
 		goto err_cqwq;
 
-	vector = raw_smp_processor_id() % mlx5_comp_vectors_count(mdev);
+	vector = raw_smp_processor_id() % mlx5_comp_vectors_max(mdev);
 	err = mlx5_vector2eqn(mdev, vector, &eqn);
 	if (err) {
 		kvfree(in);
diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index deed156e6165..eee20f04a469 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -1025,7 +1025,7 @@ static int mlx5vf_create_cq(struct mlx5_core_dev *mdev,
 		goto err_buff;
 	}
 
-	vector = raw_smp_processor_id() % mlx5_comp_vectors_count(mdev);
+	vector = raw_smp_processor_id() % mlx5_comp_vectors_max(mdev);
 	err = mlx5_vector2eqn(mdev, vector, &eqn);
 	if (err)
 		goto err_vec;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e686722fa4ca..43c4fd26c69a 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1108,7 +1108,7 @@ int mlx5_alloc_bfreg(struct mlx5_core_dev *mdev, struct mlx5_sq_bfreg *bfreg,
 		     bool map_wc, bool fast_path);
 void mlx5_free_bfreg(struct mlx5_core_dev *mdev, struct mlx5_sq_bfreg *bfreg);
 
-unsigned int mlx5_comp_vectors_count(struct mlx5_core_dev *dev);
+unsigned int mlx5_comp_vectors_max(struct mlx5_core_dev *dev);
 int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *dev, int vector);
 unsigned int mlx5_core_reserved_gids_count(struct mlx5_core_dev *dev);
 int mlx5_core_roce_gid_set(struct mlx5_core_dev *dev, unsigned int index,
-- 
2.41.0


