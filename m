Return-Path: <netdev+bounces-159064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E1A14445
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AB916BA37
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0282419FB;
	Thu, 16 Jan 2025 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKeeXnER"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA72419F3
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064553; cv=none; b=L7ZcOaLf9F1h8KC/qQmufNdFrd5/Qo1BTeeis5n9//aIwvYVEhlqtaps7iP5RwV1q0pDWihe3hE5AtLMGY7JmwEcq6hVdISCQ5BJrMd7AFePs7Ryj0ojpXXvfNbILkwxCQJPjtpOKIvilqoF7il1vksyOTtfS/4D75Yr4hDqNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064553; c=relaxed/simple;
	bh=Wf5GnrHiQaqb1/kvJYQNOcQP9e+ej3XSCEPkodxKUIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcztKEafXOG9ZjbHdqwJVb7M58xu5u8Rry21E5vc5q3QS15b+b9u7FCBTpOpDKoiFJ7NWoSSMPM3mtE5H0g5bhE4r4LJSBiDT400qq90xFZRIZU12VdjCouQTu9o3cFFbiKWL72yQtNe7/RZpaCj9ZhB3/cNoMCrMkWDc3LXHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKeeXnER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A641C4CED6;
	Thu, 16 Jan 2025 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064553;
	bh=Wf5GnrHiQaqb1/kvJYQNOcQP9e+ej3XSCEPkodxKUIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKeeXnERn+bqD4mz7GXmX8P8skH66v9soU3u6XRDnshWxw2H/7no4peNZvf2hXwDC
	 0KnzaaLEewiowhnLGbwHMcuThZW8GwjRUsoG47P5q0GvwkH+Qw/T4OhRLTDZm0vnMz
	 L3o6f3T32HjX1ktsLoah1Rv3zMhxfj2sLWLtiU5JVUCt+HtA0wfjitDeeFe0LjRkuL
	 is4f3YyuhpwiRkgy3V193GJdmTlw79mV9sKU6pKgTxMCwQyLFPzQQtiupgdYhuYaRY
	 N66CrRj50b639OwZE5983Hx7UZga9usgTEWC4n342IFb7aZ4Ct8rwZe2IAyw2iVXG6
	 jM6nMS9rS7rIA==
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
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 03/11] net/mlx5e: SHAMPO: Remove redundant params
Date: Thu, 16 Jan 2025 13:55:21 -0800
Message-ID: <20250116215530.158886-4-saeed@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116215530.158886-1-saeed@kernel.org>
References: <20250116215530.158886-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Two SHAMPO params are static and always the same, remove them from the
global mlx5e_params struct.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h        | 4 ----
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c   | 4 ----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 66c93816803e..18f8c00f4d7f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -274,10 +274,6 @@ enum packet_merge {
 struct mlx5e_packet_merge_param {
 	enum packet_merge type;
 	u32 timeout;
-	struct {
-		u8 match_criteria_type;
-		u8 alignment_granularity;
-	} shampo;
 };
 
 struct mlx5e_params {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 64b62ed17b07..377363eb1faa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -930,9 +930,9 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 			MLX5_SET(rqc, rqc, reservation_timeout,
 				 mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_SHAMPO_TIMEOUT));
 			MLX5_SET(rqc, rqc, shampo_match_criteria_type,
-				 params->packet_merge.shampo.match_criteria_type);
+				 MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED);
 			MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
-				 params->packet_merge.shampo.alignment_granularity);
+				 MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE);
 		}
 		break;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c687c926cba3..73947df91a33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4047,10 +4047,6 @@ static int set_feature_hw_gro(struct net_device *netdev, bool enable)
 
 	if (enable) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_SHAMPO;
-		new_params.packet_merge.shampo.match_criteria_type =
-			MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED;
-		new_params.packet_merge.shampo.alignment_granularity =
-			MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE;
 	} else if (new_params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_NONE;
 	} else {
-- 
2.48.0


