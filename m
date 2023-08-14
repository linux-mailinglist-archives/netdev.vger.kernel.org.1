Return-Path: <netdev+bounces-27500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1B77C299
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54521C20B8C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA510965;
	Mon, 14 Aug 2023 21:42:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995F11197
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5A9C433B8;
	Mon, 14 Aug 2023 21:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049320;
	bh=rlCoCIBYA64oZ15pQpOHtdonMcGWkuUu1zK7mlYGezQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFqWhCPEvn9uSN1N0w2x9DEmRCnnJRngsSC5vcN2YgaSwbQd/APyz2Bs01IguBuhM
	 5IKXCDZvW5mRyrIpfjVV3njmW7coTNv46IGlejAkKMck5RyXp7rx2s57/Xjg+BDIUp
	 bR8u4v+9ZasUsIp+9OvRoMbp1qR16endA75vJuWvfZy/3E4Z+zHERiMI0vbffuqHvj
	 QLda6qUDeN3GMHG8a8EjqgewcBbkoKb45Vep4w/dTKBKZ7Yhsp4WwqLIY8oQ4+l7xQ
	 4FpCOllx88wLQVBUjaqWsIzb8ZYzi+rDoeSWSxS/dzAd0MwRlUjQH89sFM88/2q/Be
	 gafnrKnWjRa1w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 11/14] net/mlx5: Fix error message in mlx5_sf_dev_state_change_handler()
Date: Mon, 14 Aug 2023 14:41:41 -0700
Message-ID: <20230814214144.159464-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

sw_function_id contains sfnum, so fix the error message to name the
value properly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index e617a270d74a..05e148db9889 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -185,7 +185,7 @@ mlx5_sf_dev_state_change_handler(struct notifier_block *nb, unsigned long event_
 			mlx5_sf_dev_del(table->dev, sf_dev, sf_index);
 		else
 			mlx5_core_err(table->dev,
-				      "SF DEV: teardown state for invalid dev index=%d fn_id=0x%x\n",
+				      "SF DEV: teardown state for invalid dev index=%d sfnum=0x%x\n",
 				      sf_index, event->sw_function_id);
 		break;
 	case MLX5_VHCA_STATE_ACTIVE:
-- 
2.41.0


