Return-Path: <netdev+bounces-13529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9426F73BEDA
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9711C2132C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C726134AD;
	Fri, 23 Jun 2023 19:29:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A9511C9B
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D805CC433C0;
	Fri, 23 Jun 2023 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548567;
	bh=z9QpmUqBYV7JYhyCBxMxx84OYqy5vkkdf1FlmXOpXHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyAQwJFpIW7OjfpOOGILpT75fgFzasfysF1HxPUJrkM9AAlKPkYmS5qqlqNpTP49G
	 kpfQgovmb5Y1QrXheoCz2ZE3qAPnTsSvIO2apRgzgYvwhDfUleOSjDXpcISCPcBmYR
	 aN5OC9Za9xh4JJeXPzNQkmWtUt1MmBrHzrc2/M3CfJpECGJ4PWlF2oj8q11e7JgWk6
	 T8tyMeRMeeBFH3sXaJVd/6KJ2sjHPcPxnOf4JOHj6zSCDtHHymNqE0OyoSz95ndv3+
	 5wgjnJawaDrQFAx8ljwQUbnEOGvJin6c9wcvIov6W080NKG7kSvRjsdWGIqlWCtW5Y
	 K/qnUMt43HWtw==
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
Subject: [net-next V2 12/15] net/mlx5: Remove redundant MLX5_ESWITCH_MANAGER() check from is_ib_rep_supported()
Date: Fri, 23 Jun 2023 12:29:04 -0700
Message-ID: <20230623192907.39033-13-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623192907.39033-1-saeed@kernel.org>
References: <20230623192907.39033-1-saeed@kernel.org>
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


