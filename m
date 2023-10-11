Return-Path: <netdev+bounces-39843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96A17C49BE
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1679E282565
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A810A39;
	Wed, 11 Oct 2023 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd+WoyhV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3E179A0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13EDC433C8;
	Wed, 11 Oct 2023 06:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697004766;
	bh=fSsZDWSR/g1QvzStY3BbhVrtWab3KA1fptbWooAnfsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pd+WoyhVfN/2A2nOj7coV8+NkHD48nxAKUVrvVsnRPwXImAoDw4BOJE0PaO8YCz9R
	 FBGCKY8UvwZkZMHOk+OSF45W5T702Cqs5lkQW2dtseXib8RO4n54RxnSXtGn4ddfCV
	 eFz1zSSpnpUfrzIlDmgdl1smvNVXK5n1v8QpQIF98nibDJbzBob7MoqHYsHiBLar14
	 n7Rt9tWW6OEvtahDs4HM9nqcJ3B+EOXPv5SQOP0LXe2ZdYjhZJ6cOnxTMYx3s/Bx/H
	 k6id7b67b7+O2eUx/uW4eh+2qTmVphsKRSvqZiVxlCBY1ExnR3pi6kbdHCElLKGCVu
	 RFgGe0VSrdJsg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>
Subject: [net-next 14/15] net/mlx5e: Increase max supported channels number to 256
Date: Tue, 10 Oct 2023 23:12:29 -0700
Message-ID: <20231011061230.11530-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011061230.11530-1-saeed@kernel.org>
References: <20231011061230.11530-1-saeed@kernel.org>
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


