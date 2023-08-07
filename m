Return-Path: <netdev+bounces-25073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13122772D6D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E1728120E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39627168C5;
	Mon,  7 Aug 2023 17:57:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA6168B9
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3878C433BA;
	Mon,  7 Aug 2023 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431026;
	bh=N4fncCSDsaKkxhM9I992ktW6OSYdq840f5yBN+FdJwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TzSW3FnicgJzhP0f+N4D7yzgRVa4LgAuyHtEB9jM6x7quZalmmhi9PZsiAbIApo0j
	 6svr3MUKLSUh8wkXnmt7j5LqvHVnBX8Cbvnk03qexFBBP59HCAkTj1u4GGHvpY1NTJ
	 Xym9q3PdIB8JEXXu0GZz4bkKkEwzepozrVTEPUo7BHpNH6K2WcMn1A/hsEqN9CXHeW
	 ER/ifyqnD6kRMJHLswxFiFo70wGPwBV75aQWW2ewUTeI85Occ+cetFxdQ+5u4eL0za
	 alJsU6/FFYoiYndARkCnsOJvceE+BDFJvUojDXk4ryr1TwgBbeiRIlTnD155QVgj67
	 quCrE98LwGhDA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next 13/15] net/mlx5: Fix typo reminder -> remainder
Date: Mon,  7 Aug 2023 10:56:40 -0700
Message-ID: <20230807175642.20834-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807175642.20834-1-saeed@kernel.org>
References: <20230807175642.20834-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gal Pressman <gal@nvidia.com>

Fix a typo in esw_qos_devlink_rate_to_mbps(): reminder -> remainder.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 7c79476cc5f9..1887a24ee414 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -740,7 +740,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *name,
 					u64 *rate, struct netlink_ext_ack *extack)
 {
-	u32 link_speed_max, reminder;
+	u32 link_speed_max, remainder;
 	u64 value;
 	int err;
 
@@ -750,8 +750,8 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 		return err;
 	}
 
-	value = div_u64_rem(*rate, MLX5_LINKSPEED_UNIT, &reminder);
-	if (reminder) {
+	value = div_u64_rem(*rate, MLX5_LINKSPEED_UNIT, &remainder);
+	if (remainder) {
 		pr_err("%s rate value %lluBps not in link speed units of 1Mbps.\n",
 		       name, *rate);
 		NL_SET_ERR_MSG_MOD(extack, "TX rate value not in link speed units of 1Mbps");
-- 
2.41.0


