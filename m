Return-Path: <netdev+bounces-68680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A36B84795B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4554E1C28E25
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9C212C7EA;
	Fri,  2 Feb 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3kmrw5u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF512C7E6
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900944; cv=none; b=EqgWymj1KbF6yMjJQgbtfGIbECoblSQt9xlwlehBuGkl100btIvEq2OYdf8y774IluSKLvaBBHs+lx+OGVIHUeHgn4SloVpzvq+wHtHSp8ExLdAKhvEb5zQG5+aq5DtsLBNxJt3gu4/uySxUxcAWk0mAtMed/dzklLVNBdT7IlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900944; c=relaxed/simple;
	bh=t8VI7ziTN3qu1cp3q9PFJfIEdQgye8yQzMvRV0yZSp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDPlNRaERGb7sHf9z0tJm1y4DL1H9DJFB04KFz40KYTV71mc2Q0Ya1anvvfFyG3LgYGmwYNaCVlw6GbdWCBzj8+u9B9ddaNCl3Kxvgpr4Gs0khyND7fORax1j2FNF8kH6kuwc3XWay1CP9TYeXt9TW/DIHzPOslU67Y+TM4059c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3kmrw5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8D4C433F1;
	Fri,  2 Feb 2024 19:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900944;
	bh=t8VI7ziTN3qu1cp3q9PFJfIEdQgye8yQzMvRV0yZSp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3kmrw5uTzqp7T24+NyI4vSlM30EOAkriY8rFoMscO46/fnLgm4E+W/Zhxs0Yifgq
	 0wpGrQ/CzK5exTnCd1d4RjwdRu9HyTrim4TGcBSmmH7bqwDBcZp0CyQwhSMTxWh8Lp
	 n6A08RwarvmJwmOlH5Cw302EDGUa8JbdLtNpBvu18ZRWwWMAXE9mGxO+9W6jW8Ttla
	 LBBB5Zj+fom1J9ihm2I9mLlkxPNwPHWOu56pssG4j42ZMDXlpNts9S9ZTayZxh56ek
	 MQ+vHKr5qi+LfcfUOp/fs64T03zoazecWauRpywQiG8CDijhk5jd2nm+v7IynCcQnb
	 2r1VtOSpni6fQ==
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
Subject: [net-next V3 04/15] net/mlx5e: Delete obsolete IPsec code
Date: Fri,  2 Feb 2024 11:08:43 -0800
Message-ID: <20240202190854.1308089-5-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190854.1308089-1-saeed@kernel.org>
References: <20240202190854.1308089-1-saeed@kernel.org>
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


