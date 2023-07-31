Return-Path: <netdev+bounces-22802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9693D7694F1
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C689E1C20C34
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01809182A4;
	Mon, 31 Jul 2023 11:29:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5718B0B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CFBC433C9;
	Mon, 31 Jul 2023 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802959;
	bh=SaW4MwB1RnjJs/MSaB1lT7s1CsIRA3AGesDq2RNeABo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPoCtSj4Gl++jRtFTQK7hcHsalY7iYr18EPwYlMuJP0xJlgW1xCltICWBXkljlFgh
	 WdhTpoAouJLAmsua7h/4ATs+AqF9+xoX8X5pkpt3I0qnqqip4JbKwBAfUVesBSZTrd
	 9+AjZDXi+pP4bRLdcOXMLDqqD1bpAbChm67sr61AK99XfdFq6AvOKRyLpz4nAufjhp
	 MkSGr4gPdCXO5dmPCX3a3yLI5c5TVIAkHwbKhKAu1+HSGHWFSoI7AQaFOCPYxK16+w
	 jRqyIML/ywKAtbsMHLT8dBqBexBFBdFoIwciIZlW4jiDvN+bHo+Gr9GmYg51SJ0pHy
	 RkIj/HopXXCpw==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v1 12/13] net/mlx5e: Add get IPsec offload stats for uplink representor
Date: Mon, 31 Jul 2023 14:28:23 +0300
Message-ID: <b43c91c452f1db9c35c10639a029aa10fd8b7895.1690802064.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690802064.git.leon@kernel.org>
References: <cover.1690802064.git.leon@kernel.org>
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
index ca4f57f5064f..d2fed9615804 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1338,6 +1338,7 @@ static mlx5e_stats_grp_t mlx5e_ul_rep_stats_grps[] = {
 	&MLX5E_STATS_GRP(channels),
 	&MLX5E_STATS_GRP(per_port_buff_congest),
 #ifdef CONFIG_MLX5_EN_IPSEC
+	&MLX5E_STATS_GRP(ipsec_hw),
 	&MLX5E_STATS_GRP(ipsec_sw),
 #endif
 	&MLX5E_STATS_GRP(ptp),
-- 
2.41.0


