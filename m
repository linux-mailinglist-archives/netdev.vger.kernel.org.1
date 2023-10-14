Return-Path: <netdev+bounces-41026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF837C95AA
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E34F1C20A98
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6753B273D1;
	Sat, 14 Oct 2023 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3Ar3LqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D7273C3
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10117C433CA;
	Sat, 14 Oct 2023 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303977;
	bh=S/dNW+lHtZ9vKUkYmLjmMl6yA5P0aF/X7c7bjAtbeKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3Ar3LqCaPyHToJZOOKIeBDocxviEs8ZIeAuJtj1lZB10dwo9YxE9xyB3LK5xw0Jp
	 mpzFcaCHdHPsy7C1PrTW3WBJrcAN3NH34YJTmznbrSrg4UnwudtHHb50/IQZpX5R+y
	 MJTupC9198RrobCS5r425o37OTnuwQZmKUrznjdvPdCoilfrdklx1HaghMt6zJoOVk
	 2BnuvilTrHatNl4TuNQ+STwX8FCPENpWrCCDDqfYv89oaYJr803YyvJzBKtoEzBtLC
	 Of3lij3jik4FDqUNRP+YQuik8AgF1ROkr+pzkHDCICtoAqnHz1Yyw0xVIFEIULW82S
	 gwadfsxTWKLzw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V3 14/15] net/mlx5e: Increase max supported channels number to 256
Date: Sat, 14 Oct 2023 10:19:07 -0700
Message-ID: <20231014171908.290428-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014171908.290428-1-saeed@kernel.org>
References: <20231014171908.290428-1-saeed@kernel.org>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index be8f62998ac2..b2a5da9739d2 100644
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


