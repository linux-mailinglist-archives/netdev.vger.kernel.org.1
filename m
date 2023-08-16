Return-Path: <netdev+bounces-28233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87D77EB42
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7101C20EE1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4191ADF1;
	Wed, 16 Aug 2023 21:01:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EA1ADD4
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002ABC433B7;
	Wed, 16 Aug 2023 21:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219663;
	bh=7HrxsAiRQQGAlgUo8TRfdwOUbQuteDJw+o0x/Cdltrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KB/UDDL1fxzpwbm35uoeGxasx7fnlPmDYslShUOZLJYPmYUFurTvknrhWHIEensxW
	 Le9erkRNvPe8fqHlyyneMD+xNz4xmHha+v7FDSooKo4hJHxD9Fyc38Ai4Rmi/pvIut
	 /6NH1Xr+99+4k4AJqVdtNCuvKL5fUQqw/HxaYzRQ2I4Cm4/MMTgoo9Cuv1hOQFP5Dj
	 MnpzGv9D4dlfdCPp8ba1NOG10XDYRmgE16a7pNox65w1u83TKuICHKfJjRSkV9RKXe
	 65dgzaK6vedOyCEUAVX1prWLDadAk0m1tc8THLtRXEvDFYkz7xdCkyew/7vJPoJGu3
	 vVpBuD9M7E1rQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net-next 07/15] net/mlx5: DR, Remove unneeded local variable
Date: Wed, 16 Aug 2023 14:00:41 -0700
Message-ID: <20230816210049.54733-8-saeed@kernel.org>
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

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Remove local variable that is already defined outside of
the scope of this block.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index 54bb0866ed72..5b83da08692d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -1422,7 +1422,6 @@ dr_action_create_reformat_action(struct mlx5dr_domain *dmn,
 	case DR_ACTION_TYP_TNL_L3_TO_L2:
 	{
 		u8 *hw_actions;
-		int ret;
 
 		hw_actions = kzalloc(DR_ACTION_CACHE_LINE_SIZE, GFP_KERNEL);
 		if (!hw_actions)
-- 
2.41.0


