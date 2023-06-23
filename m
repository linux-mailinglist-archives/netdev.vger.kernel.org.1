Return-Path: <netdev+bounces-13526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D173BED6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1071280E07
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1041078C;
	Fri, 23 Jun 2023 19:29:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526710979
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901FDC433AD;
	Fri, 23 Jun 2023 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548564;
	bh=HqrvWx2R+TezNLWMHGY8ND7dcInmsr5SqXUqZ3+TF/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYAUF5d3C3m91UYhqzBm99rJaBFJqPNN0xbJlPSZMw9B8tF4TxKJWetAZwZk1Schi
	 KVt3Vqz4jUsv6zsuvH2fwsUIaNf/UrJSH9MysF2sDeBX4yxyJ5QMy0E3kQ3dX8WwHB
	 5N33lM/MDf3/3+XVEGbvz4doA6Mk/DSihSwRqB1zqT4ScUgVnFNAKrT+bYNEeRT4w2
	 7dTXLCnjrxod+1hI6ePJQ6o6RLBDRFfT6EcUi+IOZGEpjX6yDgvbBC/mH40zbbhdnp
	 xA6P8elKNia8/MWlB89btlR4f92uK/MAD0reqhPjRwg+3qf9ixVoVFbAyDLRPtvOlm
	 EkuhmYx9/XT5Q==
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
Subject: [net-next V2 10/15] net/mlx5e: Remove redundant comment
Date: Fri, 23 Jun 2023 12:29:02 -0700
Message-ID: <20230623192907.39033-11-saeed@kernel.org>
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


