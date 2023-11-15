Return-Path: <netdev+bounces-48188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2900C7ECDAF
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8721C20BF0
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC93C493;
	Wed, 15 Nov 2023 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpCpnWte"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640F3C48F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3A0C433CA;
	Wed, 15 Nov 2023 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700077023;
	bh=RJCHsO/j81Ch3TOk+80uDyM7v3CGIJRGarrYVT4QWXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpCpnWte0gGGfGlL7KZzeEgij0S4pR8lsZm14tAdIZl3WjMwUqpbNs2Cggk/0lYgX
	 c9i2adqV8o8kq2HhjsCqcPR6o2/tWlIds1cGSABoWrRtrF9UaAV1RaH6oLX9aWPMmS
	 Hcg7hRQPqSlXEZOXBP7ViQcI1+0yvI4bKx9oE/bRiU/3rXQWC0U0R26XqD/mWNBtlB
	 De7BNtoM+QrOX8AAcv4KSPmkTfgBvpTUv0mopKfEYCD8tgnHYIbIfNPY7EUdDy1P8O
	 V/DbVxnfxkjbARt5owJyMb0u2mJVkqWgA6TSw+yMvD3Z6mlyDavTajvU9d9ptDbeQq
	 b8alIWjPhV0xA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next V2 13/13] net/mlx5e: Remove early assignment to netdev->features
Date: Wed, 15 Nov 2023 11:36:49 -0800
Message-ID: <20231115193649.8756-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115193649.8756-1-saeed@kernel.org>
References: <20231115193649.8756-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

The netdev->features is initialized to netdev->hw_features at a later
point in the flow. Remove any redundant earlier assignment.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea58c6917433..3aecdf099a2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5244,7 +5244,6 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->gso_partial_features             |= NETIF_F_GSO_UDP_L4;
 	netdev->hw_features                      |= NETIF_F_GSO_UDP_L4;
-	netdev->features                         |= NETIF_F_GSO_UDP_L4;
 
 	mlx5_query_port_fcs(mdev, &fcs_supported, &fcs_enabled);
 
-- 
2.41.0


