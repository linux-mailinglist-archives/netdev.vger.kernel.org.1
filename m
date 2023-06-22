Return-Path: <netdev+bounces-12916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4831A739707
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E3928185C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6E418C15;
	Thu, 22 Jun 2023 05:48:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227F18002
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1391FC433C9;
	Thu, 22 Jun 2023 05:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412881;
	bh=z9QpmUqBYV7JYhyCBxMxx84OYqy5vkkdf1FlmXOpXHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRICv19bo1GMmk4hBK7P0hpXyGm4SSCLVEFOdkoGaJrfqGFNHqVgAVgNPCSTgflJr
	 +BKPxDkfAk/uHszBypyN7mJkBHincoF/+UGzOM2ON9Iy+S8q3xQGwH5pJYS2vOgjq1
	 SVTW7osMp8doNHgIj1waFMmJQfHniovIrrXDRkkDG49YHrh+YqNrnmyKouXa1nXUDN
	 l/wTtPnq4jopSlWTL8OkOjBUYKVMxtid4F0s9fFImuJ+Z6e0p+yb5mk1BrrHhrbHVs
	 F+9bc0v8TKgBUfdhhjqTXuGAdpBYwVPGSM7OXfPTZY7vSRWPpdcn31lYakAXX2lCW5
	 Tj1WQH4z4kTOg==
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
Subject: [net-next 12/15] net/mlx5: Remove redundant MLX5_ESWITCH_MANAGER() check from is_ib_rep_supported()
Date: Wed, 21 Jun 2023 22:47:32 -0700
Message-ID: <20230622054735.46790-13-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622054735.46790-1-saeed@kernel.org>
References: <20230622054735.46790-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

MLX5_ESWITCH_MANAGER() check is done in is_eth_rep_supported().
Function is_ib_rep_supported() calls is_eth_rep_supported().
Remove the redundant check from it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 617ac7e5d75c..3b1e925f16d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -151,9 +151,6 @@ static bool is_ib_rep_supported(struct mlx5_core_dev *dev)
 	if (!is_eth_rep_supported(dev))
 		return false;
 
-	if (!MLX5_ESWITCH_MANAGER(dev))
-		return false;
-
 	if (!is_mdev_switchdev_mode(dev))
 		return false;
 
-- 
2.41.0


