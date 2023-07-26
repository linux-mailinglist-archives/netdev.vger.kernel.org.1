Return-Path: <netdev+bounces-21638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA85764140
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7391C2145C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55F1CA08;
	Wed, 26 Jul 2023 21:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2691C9FC
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E68C433B7;
	Wed, 26 Jul 2023 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407139;
	bh=rmeX1QDBCzJ00WHRfIz8CVq8Cyms37ZXJtQn2PAvi+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVbJPycd+AiyyQD5sMxQQsczg0fKb3QRUM4p/77aJfmVg/TdBzBHW6uouXReAqmrd
	 olMl/+nSDjchXZl3QeTAgKNBTlbRI8HUnZpjHAPyiYIUtz1k1I23AOZOvbjGMRRipa
	 k88FdJUt6uBNg0AHB5jTVgqEBtHsrcpxZMb9zcf9SBUacxGL4rkDUQHQZFadQlO9hB
	 JyXD8uEzjcELQP5WnoGuaR52n8Sx748b/btDdstWclk0EP7S8WzaNQGuhUiaidu8AC
	 7G2tJZUP1Slao+qYHAcl+PB/JDQh2OCgTqRPyqvni78frcxFAEIvb6KHDju8nOi8uv
	 MRHzJktvQ3xVg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net 11/15] net/mlx5: Bridge, set debugfs access right to root-only
Date: Wed, 26 Jul 2023 14:32:02 -0700
Message-ID: <20230726213206.47022-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Buslov <vladbu@nvidia.com>

As suggested during code review set the access rights for bridge 'fdb'
debugfs file to root-only.

Fixes: 791eb78285e8 ("net/mlx5: Bridge, expose FDB state via debugfs")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20230619120515.5045132a@kernel.org/
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_debugfs.c
index b6a45eff28f5..dbd7cbe6cbf3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_debugfs.c
@@ -64,7 +64,7 @@ void mlx5_esw_bridge_debugfs_init(struct net_device *br_netdev, struct mlx5_esw_
 
 	bridge->debugfs_dir = debugfs_create_dir(br_netdev->name,
 						 bridge->br_offloads->debugfs_root);
-	debugfs_create_file("fdb", 0444, bridge->debugfs_dir, bridge,
+	debugfs_create_file("fdb", 0400, bridge->debugfs_dir, bridge,
 			    &mlx5_esw_bridge_debugfs_fops);
 }
 
-- 
2.41.0


