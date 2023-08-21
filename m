Return-Path: <netdev+bounces-29392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06362782FCD
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3731A1C209AB
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD4911713;
	Mon, 21 Aug 2023 17:57:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D311712
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C66C43391;
	Mon, 21 Aug 2023 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640677;
	bh=7HrxsAiRQQGAlgUo8TRfdwOUbQuteDJw+o0x/Cdltrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaK7EB+oDN3FwXKzJGvCB0qTITyH4TrLldZHLBo7mkG/sjWN+YZRYhTjz5eBNz9/3
	 CSxLBYteJHFVciFikhkDuyBYBQgHmzdFMV9Btqw8vdcW5SjAmvdtal3cemoJj9hVU7
	 DXkAXQKnJZQoJMCXQm6FZUtISRlMLfSXyr+TQ1VSyS4RSpqLUScY5FcNQfu4pOV4KR
	 byONPEicVN+xZLM4kVIaR4+wtkEGtw+eozA1k0mDcmzszvEwe++fckW2/MbSfdDavl
	 aBPQyC0cI5YgpKJRq6E3eE3rEPdocGClz/FjcL4v8iObwp/wWNN2XlvAratixPFGH4
	 F3xefXUB6RkFw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net-next V2 07/14] net/mlx5: DR, Remove unneeded local variable
Date: Mon, 21 Aug 2023 10:57:32 -0700
Message-ID: <20230821175739.81188-8-saeed@kernel.org>
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


