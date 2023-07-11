Return-Path: <netdev+bounces-16780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F774EAE8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEF51C204FB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742CF1DDFB;
	Tue, 11 Jul 2023 09:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58D1DDFC
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFB4C43397;
	Tue, 11 Jul 2023 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689067813;
	bh=a71ngs8pOlV9H9klePr2uTei+ZVJcgJfZjpg9atOA6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MvvUk+NXPsHlsBOBAJ0VL+cWeB8eYWIPkGNFQ+TaHh3XA0FWUC/PG/w3C/aKEtIEz
	 gRWDbQXBB0Gm4tBQuUQk1IsukOsjRewY574y4D2pbGqkaJC5tCztYLNeDzAlwz3yuu
	 x6bqivIg5R1z09dMxaS58qsA73H8bBknTcIrw8CgP8IfoPqeF5X3wAfEtn8BCEIOYp
	 svHNELU1kDL4qkuKG3nQa2WHGR9VbAcdSJAh0pHU4KlMSwAaHT3AdLm0pRI5x6SQUP
	 OkgVR13ygcgqz8DWeNwsyHB4Wnqn+9cJbK35hfafufcQ9dyJ3rWfqjp5gFDF7zreXc
	 ahfp+Y6GaLl9g==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next 12/12] net/mlx5e: Add get IPsec offload stats for uplink representor
Date: Tue, 11 Jul 2023 12:29:10 +0300
Message-ID: <450ae222c2389c13a5c828e4d5e8a3529ee7037d.1689064922.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689064922.git.leonro@nvidia.com>
References: <cover.1689064922.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

As IPsec offload is supported in switchdev mode, HW stats can be can be
obtained from uplink rep.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 152b62138450..373f37584619 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1341,6 +1341,7 @@ static mlx5e_stats_grp_t mlx5e_ul_rep_stats_grps[] = {
 	&MLX5E_STATS_GRP(channels),
 	&MLX5E_STATS_GRP(per_port_buff_congest),
 #ifdef CONFIG_MLX5_EN_IPSEC
+	&MLX5E_STATS_GRP(ipsec_hw),
 	&MLX5E_STATS_GRP(ipsec_sw),
 #endif
 	&MLX5E_STATS_GRP(ptp),
-- 
2.41.0


