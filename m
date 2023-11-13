Return-Path: <netdev+bounces-47495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111387EA692
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A862815B4
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8A93E499;
	Mon, 13 Nov 2023 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jtrm6bwD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11103D3A4
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B35C433C7;
	Mon, 13 Nov 2023 23:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699916490;
	bh=RJCHsO/j81Ch3TOk+80uDyM7v3CGIJRGarrYVT4QWXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jtrm6bwDbDtWGioKoYvwcGBwOPyyUByl3Osxo8t87SHKyM5tVmltvHo1GATm4CWbn
	 8rfwlVGYGFQxvAzAYAuQGPJiljwFbIJJCeKcuc/WKvAhTwe87lRIYaxShOfzBy0Zos
	 QO1/2jGC4Yx0Y38u1/w+XMgvw0UqoMtUAQExF8hqPDyJIQhqDzveJTncVWimY7lO74
	 p4n+AOBZdlpQ56RT2ANV5oxGeWOFeD2L57ESJcBKygsaBJQGVmI4AUM6FfWwGpbgCx
	 a03aYImbWtrS919g2FeT0ght/irDat5KP4+txiHMkquqZ0VmttRk8lZvCJG05/+F2K
	 LkRIrj3GJP34A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 14/14] net/mlx5e: Remove early assignment to netdev->features
Date: Mon, 13 Nov 2023 15:00:51 -0800
Message-ID: <20231113230051.58229-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230051.58229-1-saeed@kernel.org>
References: <20231113230051.58229-1-saeed@kernel.org>
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


