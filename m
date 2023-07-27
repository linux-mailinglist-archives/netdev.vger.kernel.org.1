Return-Path: <netdev+bounces-22033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F124B765B8A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A73B1C215D7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424B71CA1C;
	Thu, 27 Jul 2023 18:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C91C9F9
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4DAC433CC;
	Thu, 27 Jul 2023 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483177;
	bh=k5lq8L4+wTLb/dRKRVYSUVWj/lWt6uLXP9eEQbBxTtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWPc4KNQWP67NbL7iIvoeKhPgjvreILX/Q8Rk4zpnslcZ3RJ+TVsORMoxm9PLa3KG
	 1N8L1R7/2GG2HFLJuqHw9IlM4VCh3tUkBA00amWqwlAaR9QqWN82BPiqC/sgomJig1
	 EPzfVsuEpl8IxLg+eJ/6EZ6Uk+TbWIyUsdtS/QSWHJ/Dqd/o1pa8ifFbS2ctRwljSc
	 VpfMSlWIaedupbgGy7Y51TFWszpCW94/x/v0iGhqgC013bvmQU3JzDXYDLKtcOSfCS
	 3ayg/I9jOrN/CpcwFf/3C4cXX9DXoxFuUOVDk2VAEwdK1RfdXW4xVw/c9XKuPJrFqa
	 6+ke2jrnkJkiw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next V2 15/15] net/mlx5: Give esw_offloads_load/unload_rep() "mlx5_" prefix
Date: Thu, 27 Jul 2023 11:39:14 -0700
Message-ID: <20230727183914.69229-16-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727183914.69229-1-saeed@kernel.org>
References: <20230727183914.69229-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

As esw_offloads_load/unload_rep() are used outside eswitch.c it is nicer
for them to have "mlx5_" prefix. Add it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c      |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h      |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4b13269f49e0..4a7a13169a90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1077,7 +1077,7 @@ static int mlx5_eswitch_load_vport(struct mlx5_eswitch *esw, u16 vport_num,
 	if (err)
 		return err;
 
-	err = esw_offloads_load_rep(esw, vport_num);
+	err = mlx5_esw_offloads_load_rep(esw, vport_num);
 	if (err)
 		goto err_rep;
 
@@ -1090,7 +1090,7 @@ static int mlx5_eswitch_load_vport(struct mlx5_eswitch *esw, u16 vport_num,
 
 static void mlx5_eswitch_unload_vport(struct mlx5_eswitch *esw, u16 vport_num)
 {
-	esw_offloads_unload_rep(esw, vport_num);
+	mlx5_esw_offloads_unload_rep(esw, vport_num);
 	mlx5_esw_vport_disable(esw, vport_num);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 837bdd03557b..2944c9207487 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -727,8 +727,8 @@ void mlx5_esw_set_spec_source_port(struct mlx5_eswitch *esw,
 				   u16 vport,
 				   struct mlx5_flow_spec *spec);
 
-int esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num);
-void esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num);
+int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num);
+void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num);
 
 int mlx5_eswitch_load_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs,
 				enum mlx5_eswitch_vport_event enabled_events);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b4df57962b2b..f83667b4339e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2425,7 +2425,7 @@ static void mlx5_esw_offloads_rep_unload(struct mlx5_eswitch *esw, u16 vport_num
 		__esw_offloads_unload_rep(esw, rep, rep_type);
 }
 
-int esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num)
+int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	int err;
 
@@ -2449,7 +2449,7 @@ int esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num)
 	return err;
 }
 
-void esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
 		return;
@@ -3361,7 +3361,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 			vport->info.link_state = MLX5_VPORT_ADMIN_STATE_DOWN;
 
 	/* Uplink vport rep must load first. */
-	err = esw_offloads_load_rep(esw, MLX5_VPORT_UPLINK);
+	err = mlx5_esw_offloads_load_rep(esw, MLX5_VPORT_UPLINK);
 	if (err)
 		goto err_uplink;
 
@@ -3372,7 +3372,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	return 0;
 
 err_vports:
-	esw_offloads_unload_rep(esw, MLX5_VPORT_UPLINK);
+	mlx5_esw_offloads_unload_rep(esw, MLX5_VPORT_UPLINK);
 err_uplink:
 	esw_offloads_steering_cleanup(esw);
 err_steering_init:
@@ -3410,7 +3410,7 @@ static int esw_offloads_stop(struct mlx5_eswitch *esw,
 void esw_offloads_disable(struct mlx5_eswitch *esw)
 {
 	mlx5_eswitch_disable_pf_vf_vports(esw);
-	esw_offloads_unload_rep(esw, MLX5_VPORT_UPLINK);
+	mlx5_esw_offloads_unload_rep(esw, MLX5_VPORT_UPLINK);
 	esw_set_passing_vport_metadata(esw, false);
 	esw_offloads_steering_cleanup(esw);
 	mapping_destroy(esw->offloads.reg_c0_obj_pool);
-- 
2.41.0


