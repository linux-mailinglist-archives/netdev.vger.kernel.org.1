Return-Path: <netdev+bounces-29389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECCC782FC8
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD571C20977
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625E111700;
	Mon, 21 Aug 2023 17:57:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319831097C
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE121C433CC;
	Mon, 21 Aug 2023 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640674;
	bh=FPyFCYt6tNz0ySlSJHuR/P2HJXXxMUU8sBFlFoNVol4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbtQmAdDI4PI9ces7cmMBEI3gVcy22qAe3qr/8M2Xt1amAdhpLs6rKRL3AEbrqiJT
	 VnCCDolfXpvC6mXEwDqWlD4g1dCe03yDMZEMN+O3r+2LH8gYg2OrnGG+JVCtsx3TBI
	 cHDLc7zZ5caJKB6eiaXokCewLvLJ6x0hTciAph8GsRtHIwmHcnvS/qpgpm+7Wgm2sO
	 o0qYlHZpJ9+6YVQhUIc8aPh2r0AP/0XlCvNb7IDFAP9Thbubtr1A7rajUobZKikXb4
	 EinWT/vzM9zSDe6mY8eqkoIydw3i10HX7lGFTQvceE2R2XbzJlhMahKHYFrs5qTDfU
	 thO4NQpB9pkog==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next V2 04/14] net/mlx5e: Fix spelling mistake "Faided" -> "Failed"
Date: Mon, 21 Aug 2023 10:57:29 -0700
Message-ID: <20230821175739.81188-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821175739.81188-1-saeed@kernel.org>
References: <20230821175739.81188-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in a warning message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 455746952260..095f31f380fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -316,7 +316,7 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
 			err = mlx5_esw_ipsec_modify_flow_dests(esw, flow);
 			if (err)
 				mlx5_core_warn_once(mdev,
-						    "Faided to modify flow dests for IPsec");
+						    "Failed to modify flow dests for IPsec");
 		}
 		rhashtable_walk_stop(&iter);
 		rhashtable_walk_exit(&iter);
-- 
2.41.0


