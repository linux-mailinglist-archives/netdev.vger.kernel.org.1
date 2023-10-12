Return-Path: <netdev+bounces-40443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDBB7C76B8
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2896F1C21150
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16723B7BC;
	Thu, 12 Oct 2023 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq4F6Jwm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2953B291
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552DEC433CB;
	Thu, 12 Oct 2023 19:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697138879;
	bh=CE8cN4XacrSvgmzVRGb+j/WhYw36SVBv9HIp/QQ5mH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fq4F6Jwmi9hEu4pDkwBMyLBotKfUSmycCJBu6Iwn+u8dvFe9scBRhtK1zQUtDcA4s
	 2Nra18o/shuw8bEgonG02xbTs50SW0KcotHSpGWd04MHaYlNIy6lG8ZfmhhYdDI1Wu
	 KbmKJFoDsA6q8/1yhAav3UxjY49AYb4KtlFposVwl7pk0+vdhlTkqoVKSpwwcI4aZH
	 ohAPzMZVwd5b+KhJIgilpaJYI+T1ZYJp5VFsVu+cdCufxgvDH8ks2k34gss5MyMh+Z
	 zQ40CHR9AGD1FON1AN5aqv8o2UTT7R1zZbCsYQdupPtt8gDcF6rPVUEfH3OT4UpTXo
	 szJGHb8EmpCew==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [net-next V2 06/15] net/mlx5: Remove unused declaration
Date: Thu, 12 Oct 2023 12:27:41 -0700
Message-ID: <20231012192750.124945-7-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012192750.124945-1-saeed@kernel.org>
References: <20231012192750.124945-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

Commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
declared mlx5e_ipsec_inverse_table_init() but never implemented it.
Commit f52f2faee581 ("net/mlx5e: Introduce flow steering API")
declared mlx5e_fs_set_tc() but never implemented it.
Commit f2f3df550139 ("net/mlx5: EQ, Privatize eq_table and friends")
declared mlx5_eq_comp_cpumask() but never implemented it.
Commit cac1eb2cf2e3 ("net/mlx5: Lag, properly lock eswitch if needed")
removed mlx5_lag_update() but not its declaration.
Commit 35ba005d820b ("net/mlx5: DR, Set flex parser for TNL_MPLS dynamically")
removed mlx5dr_ste_build_tnl_mpls() but not its declaration.

Commit e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
declared but never implemented mlx5_alloc_cmd_mailbox_chain() and mlx5_free_cmd_mailbox_chain().
Commit 0cf53c124756 ("net/mlx5: FWPage, Use async events chain")
removed mlx5_core_req_pages_handler() but not its declaration.
Commit 938fe83c8dcb ("net/mlx5_core: New device capabilities handling")
removed mlx5_query_odp_caps() but not its declaration.
Commit f6a8a19bb11b ("RDMA/netdev: Hoist alloc_netdev_mqs out of the driver")
removed mlx5_rdma_netdev_alloc() but not its declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |  1 -
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h   |  1 -
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  2 --
 .../mellanox/mlx5/core/steering/dr_types.h         |  4 ----
 include/linux/mlx5/driver.h                        | 14 --------------
 6 files changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index e5a44b0b9616..4d6225e0eec7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -150,7 +150,6 @@ struct mlx5e_flow_steering *mlx5e_fs_init(const struct mlx5e_profile *profile,
 					  struct dentry *dfs_root);
 void mlx5e_fs_cleanup(struct mlx5e_flow_steering *fs);
 struct mlx5e_vlan_table *mlx5e_fs_get_vlan(struct mlx5e_flow_steering *fs);
-void mlx5e_fs_set_tc(struct mlx5e_flow_steering *fs, struct mlx5e_tc_table *tc);
 struct mlx5e_tc_table *mlx5e_fs_get_tc(struct mlx5e_flow_steering *fs);
 struct mlx5e_l2_table *mlx5e_fs_get_l2(struct mlx5e_flow_steering *fs);
 struct mlx5_flow_namespace *mlx5e_fs_get_ns(struct mlx5e_flow_steering *fs, bool egress);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 9ee014a8ad24..2ed99772f168 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -54,7 +54,6 @@ struct mlx5e_accel_tx_ipsec_state {
 
 #ifdef CONFIG_MLX5_EN_IPSEC
 
-void mlx5e_ipsec_inverse_table_init(void);
 void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state *x,
 			    struct xfrm_offload *xo);
 void mlx5e_ipsec_set_iv(struct sk_buff *skb, struct xfrm_state *x,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
index 69a75459775d..4b7f7131c560 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
@@ -85,7 +85,6 @@ void mlx5_eq_del_cq(struct mlx5_eq *eq, struct mlx5_core_cq *cq);
 struct mlx5_eq_comp *mlx5_eqn2comp_eq(struct mlx5_core_dev *dev, int eqn);
 struct mlx5_eq *mlx5_get_async_eq(struct mlx5_core_dev *dev);
 void mlx5_cq_tasklet_cb(struct tasklet_struct *t);
-struct cpumask *mlx5_eq_comp_cpumask(struct mlx5_core_dev *dev, int ix);
 
 u32 mlx5_eq_poll_irq_disabled(struct mlx5_eq_comp *eq);
 void mlx5_cmd_eq_recover(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 0b60b02518c1..4e083fd3cc8d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -295,8 +295,6 @@ static inline int mlx5_rescan_drivers(struct mlx5_core_dev *dev)
 	return ret;
 }
 
-void mlx5_lag_update(struct mlx5_core_dev *dev);
-
 enum {
 	MLX5_NIC_IFC_FULL		= 0,
 	MLX5_NIC_IFC_DISABLED		= 1,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
index 55dc7383477c..81eff6c410ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
@@ -436,10 +436,6 @@ void mlx5dr_ste_build_mpls(struct mlx5dr_ste_ctx *ste_ctx,
 			   struct mlx5dr_ste_build *sb,
 			   struct mlx5dr_match_param *mask,
 			   bool inner, bool rx);
-void mlx5dr_ste_build_tnl_mpls(struct mlx5dr_ste_ctx *ste_ctx,
-			       struct mlx5dr_ste_build *sb,
-			       struct mlx5dr_match_param *mask,
-			       bool inner, bool rx);
 void mlx5dr_ste_build_tnl_mpls_over_gre(struct mlx5dr_ste_ctx *ste_ctx,
 					struct mlx5dr_ste_build *sb,
 					struct mlx5dr_match_param *mask,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 37c2101e4f63..217c7e3ad76c 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1041,10 +1041,6 @@ void mlx5_trigger_health_work(struct mlx5_core_dev *dev);
 int mlx5_frag_buf_alloc_node(struct mlx5_core_dev *dev, int size,
 			     struct mlx5_frag_buf *buf, int node);
 void mlx5_frag_buf_free(struct mlx5_core_dev *dev, struct mlx5_frag_buf *buf);
-struct mlx5_cmd_mailbox *mlx5_alloc_cmd_mailbox_chain(struct mlx5_core_dev *dev,
-						      gfp_t flags, int npages);
-void mlx5_free_cmd_mailbox_chain(struct mlx5_core_dev *dev,
-				 struct mlx5_cmd_mailbox *head);
 int mlx5_core_create_mkey(struct mlx5_core_dev *dev, u32 *mkey, u32 *in,
 			  int inlen);
 int mlx5_core_destroy_mkey(struct mlx5_core_dev *dev, u32 mkey);
@@ -1058,8 +1054,6 @@ void mlx5_pagealloc_start(struct mlx5_core_dev *dev);
 void mlx5_pagealloc_stop(struct mlx5_core_dev *dev);
 void mlx5_pages_debugfs_init(struct mlx5_core_dev *dev);
 void mlx5_pages_debugfs_cleanup(struct mlx5_core_dev *dev);
-void mlx5_core_req_pages_handler(struct mlx5_core_dev *dev, u16 func_id,
-				 s32 npages, bool ec_function);
 int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot);
 int mlx5_reclaim_startup_pages(struct mlx5_core_dev *dev);
 void mlx5_register_debugfs(void);
@@ -1099,8 +1093,6 @@ int mlx5_core_create_psv(struct mlx5_core_dev *dev, u32 pdn,
 int mlx5_core_destroy_psv(struct mlx5_core_dev *dev, int psv_num);
 __be32 mlx5_core_get_terminate_scatter_list_mkey(struct mlx5_core_dev *dev);
 void mlx5_core_put_rsc(struct mlx5_core_rsc_common *common);
-int mlx5_query_odp_caps(struct mlx5_core_dev *dev,
-			struct mlx5_odp_caps *odp_caps);
 
 int mlx5_init_rl_table(struct mlx5_core_dev *dev);
 void mlx5_cleanup_rl_table(struct mlx5_core_dev *dev);
@@ -1202,12 +1194,6 @@ int mlx5_sriov_blocking_notifier_register(struct mlx5_core_dev *mdev,
 void mlx5_sriov_blocking_notifier_unregister(struct mlx5_core_dev *mdev,
 					     int vf_id,
 					     struct notifier_block *nb);
-#ifdef CONFIG_MLX5_CORE_IPOIB
-struct net_device *mlx5_rdma_netdev_alloc(struct mlx5_core_dev *mdev,
-					  struct ib_device *ibdev,
-					  const char *name,
-					  void (*setup)(struct net_device *));
-#endif /* CONFIG_MLX5_CORE_IPOIB */
 int mlx5_rdma_rn_get_params(struct mlx5_core_dev *mdev,
 			    struct ib_device *device,
 			    struct rdma_netdev_alloc_params *params);
-- 
2.41.0


