Return-Path: <netdev+bounces-22031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49D0765B87
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF5281B64
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A291F172;
	Thu, 27 Jul 2023 18:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00A1C9F9
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9A5C433B7;
	Thu, 27 Jul 2023 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483175;
	bh=hoosqXaQoRWcS1jQCD71akFUbbD+8y72dh07aWQKLws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSxDrvGUB8hRX5ln8SN7Og0MdTq6f6Qy4DsnZ1meY8D1w8CHsDuINli71O+STcE4f
	 S8AR7JID4tiAnDgIvgPlsx1JlXFEIRrsST85+BF5ZI4g5kauCowgnXtDcIJvztgXjc
	 IEvbPseUWuHBEEKoHJXFM5bKxlNZ7WpY3abkbh4Svw5blG4yJ0eZE1HNtlujlgGKZ7
	 lALCXylS5gbGfray7VgW+l4d9EQkaArOGKIrg8P5FS0T+9eBMN0mZS/kdIT3RCxV7a
	 7ph/zpbAw2IJdFGr9D+Hq6rn9ec592AYRKOb2KWF+0qYX/0Z/YA0lGwwCkvCcStdF4
	 n6eVXttR9Vp8A==
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
Subject: [net-next V2 13/15] net/mlx5: Make mlx5_esw_offloads_rep_load/unload() static
Date: Thu, 27 Jul 2023 11:39:12 -0700
Message-ID: <20230727183914.69229-14-saeed@kernel.org>
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

mlx5_esw_offloads_rep_load/unload() functions are not used
outside of eswitch_offloads.c. Make them static.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          | 3 ---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 9b5a1651b877..6f360a15aa62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -730,9 +730,6 @@ void mlx5_esw_set_spec_source_port(struct mlx5_eswitch *esw,
 int esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num);
 void esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num);
 
-int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num);
-void mlx5_esw_offloads_rep_unload(struct mlx5_eswitch *esw, u16 vport_num);
-
 int mlx5_eswitch_load_vport(struct mlx5_eswitch *esw, u16 vport_num,
 			    enum mlx5_eswitch_vport_event enabled_events);
 void mlx5_eswitch_unload_vport(struct mlx5_eswitch *esw, u16 vport_num);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index c192000e3614..b4df57962b2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2391,7 +2391,7 @@ static void __unload_reps_all_vport(struct mlx5_eswitch *esw, u8 rep_type)
 		__esw_offloads_unload_rep(esw, rep, rep_type);
 }
 
-int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
+static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	struct mlx5_eswitch_rep *rep;
 	int rep_type;
@@ -2415,7 +2415,7 @@ int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
 	return err;
 }
 
-void mlx5_esw_offloads_rep_unload(struct mlx5_eswitch *esw, u16 vport_num)
+static void mlx5_esw_offloads_rep_unload(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	struct mlx5_eswitch_rep *rep;
 	int rep_type;
-- 
2.41.0


