Return-Path: <netdev+bounces-12914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39E739704
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AEE281871
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167AD15ADC;
	Thu, 22 Jun 2023 05:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333B14AAE
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FB1C433C0;
	Thu, 22 Jun 2023 05:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412878;
	bh=HqrvWx2R+TezNLWMHGY8ND7dcInmsr5SqXUqZ3+TF/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XF98QQ+eyoD/nPrGAD3s8lY7qrYFIOdc2biRxvklkzHMmZr/ycWRYhTOnOOZbeGAq
	 +cwkAQWlFkyS5a6Q/iOTDfC1sf676CP62jMaNS0P8ViBifKEFb5zpSNZo2YccTLrcv
	 Tttet1QnJ7ZcgoFx4zU7HSfwYl02wyoNDqt/MM9cwoAc0nGf6zRBRT/kZPPjuo8mDM
	 1I3/H3A/NIZI5B7YmJmd53BoYs9Ou7YDTMfTPFgQCyY2253gF10Iox3l4IXwcQM0vU
	 imsTmvhagDFMmuiK66nt+2pSHNLazwDlmjy+pSP3TOXfotYBXeAUUpjOEyCpUHjtzA
	 n8yozkiN5j06A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Roi Dayan <roid@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 10/15] net/mlx5e: Remove redundant comment
Date: Wed, 21 Jun 2023 22:47:30 -0700
Message-ID: <20230622054735.46790-11-saeed@kernel.org>
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

From: Roi Dayan <roid@nvidia.com>

The function comment says what it is and the comment
is redundant.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index ee507b12e908..612be82a8ad5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1904,7 +1904,6 @@ static int esw_create_vport_rx_group(struct mlx5_eswitch *esw)
 	if (!flow_group_in)
 		return -ENOMEM;
 
-	/* create vport rx group */
 	mlx5_esw_set_flow_group_source_port(esw, flow_group_in, 0);
 
 	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, 0);
-- 
2.41.0


