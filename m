Return-Path: <netdev+bounces-29391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD3782FCA
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99744280157
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530561171E;
	Mon, 21 Aug 2023 17:57:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5C11713
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507A5C433CC;
	Mon, 21 Aug 2023 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640676;
	bh=x1vMogn1t79/i+ShLHMDDDYmX5snd4KRw9jf2Mp35p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFp0me60JcIDSq49OWK/cPqYVAtN02goSi/0EloFpiqHmHCEEkcIM9NpefsgszkDH
	 rSnIzo8bSiO+M1b2SAlP/p7naAE3q8xlxTRe59XOTE1eImjLGJIxCoSZwKu7mq78zP
	 ojtyL9e7wEoSHWYIMMxR4GYhjpu7W4VNzXElkT+UCuMHAFK50juJYJBbDY/hIeNw6f
	 Yfqpp5E/TupEprPiLaWaSzSaD55TuFaAtL+/AJvedWPT1Si78PAxUZypor0IOZz0Vg
	 eUpgzAv2lCyPWoTYLNmrh5yyAOzjZlFlkoa53NQ8haFyu2diO40fs3Qp6LYGgDC7BQ
	 jdyXuTrIudblA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net-next V2 06/14] net/mlx5: DR, Fix code indentation
Date: Mon, 21 Aug 2023 10:57:31 -0700
Message-ID: <20230821175739.81188-7-saeed@kernel.org>
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

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
index feb307fb3440..14f6df88b1f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
@@ -336,7 +336,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		if (fte->action.pkt_reformat->owner == MLX5_FLOW_RESOURCE_OWNER_FW) {
 			err = -EINVAL;
 			mlx5dr_err(domain, "FW-owned reformat can't be used in SW rule\n");
-				goto free_actions;
+			goto free_actions;
 		}
 
 		is_decap = fte->action.pkt_reformat->reformat_type ==
-- 
2.41.0


