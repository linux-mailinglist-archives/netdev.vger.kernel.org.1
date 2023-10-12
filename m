Return-Path: <netdev+bounces-40451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1337C76C0
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC793282F99
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6703CD0C;
	Thu, 12 Oct 2023 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7rLqt9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC443CD0A
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A4EC433C8;
	Thu, 12 Oct 2023 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697138886;
	bh=fSsZDWSR/g1QvzStY3BbhVrtWab3KA1fptbWooAnfsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7rLqt9lt8iPQQJzgpEL0QYwRRnM0PGMtOFJGt1YBTxVyDNh41EadsEa/ZSOOo1t9
	 FVh4RbgbJIJQeU89Sq/i5hNanzWq/BXl1GNPvanTStiMqQyWMH4t368CPVlluGug0h
	 uuTW7ThncPOYcpwvEaPhFR8higBdHIMSWmqfeh3mAzM15FtroED8JAxcl1VqwSPOqf
	 WnEb6y0n9aIK1nuEmYGC1TVJqM/PMA8iuniMNDJ7hda3BHiOEcQT1b927BFmdA+w9m
	 yXNAUHEIfF2yC2Z+0ify2eTKfw5JQIzRnRA0tVkPuXpmcN37s+Ou9h2R9jEzzvcVrO
	 1g2GD+/T9pnAw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>
Subject: [net-next V2 14/15] net/mlx5e: Increase max supported channels number to 256
Date: Thu, 12 Oct 2023 12:27:49 -0700
Message-ID: <20231012192750.124945-15-saeed@kernel.org>
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

From: Adham Faris <afaris@nvidia.com>

Increase max supported channels number to 256 (it is not extended
further due to testing disabilities).

Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2130cba548b5..e789f0586c3d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -141,7 +141,7 @@ struct page_pool;
 #define MLX5E_PARAMS_DEFAULT_MIN_RX_WQES_MPW            0x2
 
 #define MLX5E_MIN_NUM_CHANNELS         0x1
-#define MLX5E_MAX_NUM_CHANNELS         128
+#define MLX5E_MAX_NUM_CHANNELS         256
 #define MLX5E_TX_CQ_POLL_BUDGET        128
 #define MLX5E_TX_XSK_POLL_BUDGET       64
 #define MLX5E_SQ_RECOVER_MIN_INTERVAL  500 /* msecs */
-- 
2.41.0


