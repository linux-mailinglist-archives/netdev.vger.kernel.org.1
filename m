Return-Path: <netdev+bounces-67850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53878451F8
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056191C23DA2
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB28158D94;
	Thu,  1 Feb 2024 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpEJeO7E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB521586E8
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772736; cv=none; b=kQDbvE74LsjO2DdWqBErM4C/+u5zxhuvzgjBkdiSSmVbY7DUbmS0S7le0JVJuvVCnjGFPCIHqvJ5TNZ5jDiA65JhF8AG6I6alzDhCJJJxLMZWCKcacmqEu+QnrnJU7lmVopig8ALMuyj2fNy2btatIvtLLHpD4Wf1ARC+2StoWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772736; c=relaxed/simple;
	bh=t8VI7ziTN3qu1cp3q9PFJfIEdQgye8yQzMvRV0yZSp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xf/6ySPkezCMJjK86iqNt7GlYuFU0QrOeFniBbL9OytTLPBeoYlzeUj/ywkcr3FZD5vHE/f1fZlk9CE5yj9rbzMVgd9jcy0VEOiBZ0qjYJRio4ZlgjBei6mtkrJOaKMAvL8W4fZoJttXJ9cua7TTApCNlMlXYfmfmDmul6i4lDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpEJeO7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13419C4166D;
	Thu,  1 Feb 2024 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772736;
	bh=t8VI7ziTN3qu1cp3q9PFJfIEdQgye8yQzMvRV0yZSp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpEJeO7E05eUK8DsiDGOjnUzY7IMrcrn58rGycwIKRQcoBFEQj46oo+gVlTs1r9k2
	 aI0R3yGesxVvdGQYGRYoYxJBfD/93U7oe4F9rsLKeIDp0O8jfL/UMgm5qFBjA+vpqa
	 ySz3YD4HNREjzYk0vVtZ40S7I1X9VJhcuABS4lx05dTMcDCHc0QyBGHjQv1ysCY9ad
	 OVT2WASWEIKJ2RJh/6R+BObVqZ87u27Nv+7UdMNu7mKKQLrFo+k1QBFHdWluglf+zx
	 rTkfT91SlgAY3Vrw+UHYrIfuIyKgoN1/VBfs4tC7xmHXXEOfRtdXWh1tVdVLFIxkNn
	 12F7Ru4fVoqcQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V2 04/15] net/mlx5e: Delete obsolete IPsec code
Date: Wed, 31 Jan 2024 23:31:47 -0800
Message-ID: <20240201073158.22103-5-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201073158.22103-1-saeed@kernel.org>
References: <20240201073158.22103-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

After addition of HW managed counters and implementation drop
in flow steering logic, the code in driver which checks syndrome
is not reachable anymore.

Let's delete it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  1 -
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c  | 25 ++-----------------
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  1 -
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c |  1 -
 4 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index adaea3493193..7d943e93cf6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -137,7 +137,6 @@ struct mlx5e_ipsec_hw_stats {
 struct mlx5e_ipsec_sw_stats {
 	atomic64_t ipsec_rx_drop_sp_alloc;
 	atomic64_t ipsec_rx_drop_sadb_miss;
-	atomic64_t ipsec_rx_drop_syndrome;
 	atomic64_t ipsec_tx_drop_bundle;
 	atomic64_t ipsec_tx_drop_no_state;
 	atomic64_t ipsec_tx_drop_not_ip;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index 51a144246ea6..727fa7c18523 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -304,12 +304,6 @@ bool mlx5e_ipsec_handle_tx_skb(struct net_device *netdev,
 	return false;
 }
 
-enum {
-	MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_DECRYPTED,
-	MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_AUTH_FAILED,
-	MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_BAD_TRAILER,
-};
-
 void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 				       struct sk_buff *skb,
 				       u32 ipsec_meta_data)
@@ -343,20 +337,7 @@ void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 
 	xo = xfrm_offload(skb);
 	xo->flags = CRYPTO_DONE;
-
-	switch (MLX5_IPSEC_METADATA_SYNDROM(ipsec_meta_data)) {
-	case MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_DECRYPTED:
-		xo->status = CRYPTO_SUCCESS;
-		break;
-	case MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_AUTH_FAILED:
-		xo->status = CRYPTO_TUNNEL_ESP_AUTH_FAILED;
-		break;
-	case MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_BAD_TRAILER:
-		xo->status = CRYPTO_INVALID_PACKET_SYNTAX;
-		break;
-	default:
-		atomic64_inc(&ipsec->sw_stats.ipsec_rx_drop_syndrome);
-	}
+	xo->status = CRYPTO_SUCCESS;
 }
 
 int mlx5_esw_ipsec_rx_make_metadata(struct mlx5e_priv *priv, u32 id, u32 *metadata)
@@ -374,8 +355,6 @@ int mlx5_esw_ipsec_rx_make_metadata(struct mlx5e_priv *priv, u32 id, u32 *metada
 		return err;
 	}
 
-	*metadata = MLX5_IPSEC_METADATA_CREATE(ipsec_obj_id,
-					       MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_DECRYPTED);
-
+	*metadata = ipsec_obj_id;
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 2ed99772f168..82064614846f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -43,7 +43,6 @@
 #define MLX5_IPSEC_METADATA_MARKER(metadata)  (((metadata) >> 31) & 0x1)
 #define MLX5_IPSEC_METADATA_SYNDROM(metadata) (((metadata) >> 24) & GENMASK(5, 0))
 #define MLX5_IPSEC_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(23, 0))
-#define MLX5_IPSEC_METADATA_CREATE(id, syndrome) ((id) | ((syndrome) << 24))
 
 struct mlx5e_accel_tx_ipsec_state {
 	struct xfrm_offload *xo;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
index e0e36a09721c..dd36b04e30a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
@@ -51,7 +51,6 @@ static const struct counter_desc mlx5e_ipsec_hw_stats_desc[] = {
 static const struct counter_desc mlx5e_ipsec_sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_rx_drop_sp_alloc) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_rx_drop_sadb_miss) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_rx_drop_syndrome) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_tx_drop_bundle) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_tx_drop_no_state) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_sw_stats, ipsec_tx_drop_not_ip) },
-- 
2.43.0


