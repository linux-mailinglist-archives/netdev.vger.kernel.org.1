Return-Path: <netdev+bounces-22032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53496765B89
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ED71C216DB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1331F92E;
	Thu, 27 Jul 2023 18:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04B1C9ED
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CB8C433BF;
	Thu, 27 Jul 2023 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483176;
	bh=AyH2QFLJ6qIso39O9DqajMk8VGK1zYZcw68OFucnzo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJzlMaT2nC8+c+TTKGJhjO5vePameupIjBusviBGFtwL1jOhapSi1krITzKMxjzWz
	 9NjPwp573uf1PEb7u8Mp+7k8rQmtWK1JGbEEyOQwXUtmEvkJcyoRNQFIdCFK1fTl7v
	 vPuc53b3KpPx2dQaTwbXReDEc4thviRt+ixvL1L1Gtdw6P7hqkYCcUoazrXdBKp+bd
	 kavnn+pblSG2+3OiRpnah+CgUuXcVD5QxQdOTVC9fcceWeFiAjz6UgyWUaOES7PUtc
	 8c2ecJCZEwzWUUscOY2XKNiDh93GeOB1v7RgKUiBpAArsaN25g8jrue5GHXsg7ulZI
	 Z3GG/UzBWRsGg==
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
Subject: [net-next V2 14/15] net/mlx5: Make mlx5_eswitch_load/unload_vport() static
Date: Thu, 27 Jul 2023 11:39:13 -0700
Message-ID: <20230727183914.69229-15-saeed@kernel.org>
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

mlx5_eswitch_load/unload_vport()() functions are not used
outside of eswitch.c. Make them static.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 7 +++----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 4 ----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 243c455f1029..4b13269f49e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1068,9 +1068,8 @@ static void mlx5_eswitch_clear_ec_vf_vports_info(struct mlx5_eswitch *esw)
 	}
 }
 
-/* Public E-Switch API */
-int mlx5_eswitch_load_vport(struct mlx5_eswitch *esw, u16 vport_num,
-			    enum mlx5_eswitch_vport_event enabled_events)
+static int mlx5_eswitch_load_vport(struct mlx5_eswitch *esw, u16 vport_num,
+				   enum mlx5_eswitch_vport_event enabled_events)
 {
 	int err;
 
@@ -1089,7 +1088,7 @@ int mlx5_eswitch_load_vport(struct mlx5_eswitch *esw, u16 vport_num,
 	return err;
 }
 
-void mlx5_eswitch_unload_vport(struct mlx5_eswitch *esw, u16 vport_num)
+static void mlx5_eswitch_unload_vport(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	esw_offloads_unload_rep(esw, vport_num);
 	mlx5_esw_vport_disable(esw, vport_num);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 6f360a15aa62..837bdd03557b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -730,10 +730,6 @@ void mlx5_esw_set_spec_source_port(struct mlx5_eswitch *esw,
 int esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num);
 void esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num);
 
-int mlx5_eswitch_load_vport(struct mlx5_eswitch *esw, u16 vport_num,
-			    enum mlx5_eswitch_vport_event enabled_events);
-void mlx5_eswitch_unload_vport(struct mlx5_eswitch *esw, u16 vport_num);
-
 int mlx5_eswitch_load_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs,
 				enum mlx5_eswitch_vport_event enabled_events);
 void mlx5_eswitch_unload_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs);
-- 
2.41.0


