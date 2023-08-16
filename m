Return-Path: <netdev+bounces-28229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D877EB38
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC524281C52
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535C119888;
	Wed, 16 Aug 2023 21:01:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257901AA73
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8732C433C7;
	Wed, 16 Aug 2023 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219660;
	bh=FPyFCYt6tNz0ySlSJHuR/P2HJXXxMUU8sBFlFoNVol4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjaI+/KgDa6Fu0ybF97P6Etf2JFuvjcB+mNjbLFH8cL9IO5o0lA8s++3oIY/mb6M1
	 zA3VYLVwBCRMjfXzLwYB+PL3FW+8b1ab8UzJ0S8mPIBfKblJgNTnj9Y5jBo+RD0Zv/
	 pUlcLHoPbCrFVr6Awy8OsvqMbNrQnLIjikBmKRzWwdouFgDXw93xIzjmxscNU5O1ay
	 ZWJga3EoIFl62Ny871V5K5LnUE03ZV9K0YA0S9HEu33eWMjmjb+xkzYScrUXstbGOJ
	 MsqZ1R2CWJVTQdqQnP6/W+4amZdhDz1dEukfLzbU1sTwYhNVGBcexO1j//2sYQIzDk
	 UmSYgC9yWALDQ==
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
Subject: [net-next 04/15] net/mlx5e: Fix spelling mistake "Faided" -> "Failed"
Date: Wed, 16 Aug 2023 14:00:38 -0700
Message-ID: <20230816210049.54733-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
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


