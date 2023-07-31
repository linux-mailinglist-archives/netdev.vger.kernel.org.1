Return-Path: <netdev+bounces-22797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB107694E7
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D7E1C20C1B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FD518019;
	Mon, 31 Jul 2023 11:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130D5182DC
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C211C43397;
	Mon, 31 Jul 2023 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802940;
	bh=aUfwNx6yGppSzqqm+wcQoSpLUo0e0ZtJOVGRnlQQN/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2g4bLc1DYM0l9udTa1vC3V78JWz9pDZRgFJwS7ojmxlFHpnGX6Xt+w2x/ncTSXSO
	 QO7JTpp61tVMl6Cmv5R1E4cJpN6xHsK/hyKWJEceC0BmCq5zTUN/njN+HNyk7QSidV
	 k2F7ZMv8IpkrKMt5kEjfkoTEIEvItkWsFXTGwGtXN3yZ5KoNinYNocAgi4rtlhI2g9
	 UvQf8Rwg6hUyb+/GJfTIQ9rciYNC1sAdZE6TQ3AB22y0+tzGBt9g7E0H6RY3fucqMt
	 CEn600FJjpkeLTYg9Ek69PZoKtdRuwcU+xTSUu7nNEBsf/ztgtn8FxsLLssx7O2H74
	 c7tcTFiAFQJxg==
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
Subject: [PATCH net-next v1 09/13] net/mlx5: Compare with old_dest param to modify rule destination
Date: Mon, 31 Jul 2023 14:28:20 +0300
Message-ID: <24adc60d05d7492359ba343c6da1ebbe9fe284f6.1690802064.git.leon@kernel.org>
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

The rule destination must be compared with the old_dest passed in.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 830ff8480fe1..59df6156246e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1066,7 +1066,7 @@ int mlx5_modify_rule_destination(struct mlx5_flow_handle *handle,
 	}
 
 	for (i = 0; i < handle->num_rules; i++) {
-		if (mlx5_flow_dests_cmp(new_dest, &handle->rule[i]->dest_attr))
+		if (mlx5_flow_dests_cmp(old_dest, &handle->rule[i]->dest_attr))
 			return _mlx5_modify_rule_destination(handle->rule[i],
 							     new_dest);
 	}
-- 
2.41.0


