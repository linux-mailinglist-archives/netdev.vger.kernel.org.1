Return-Path: <netdev+bounces-27499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BE777C298
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337D31C20381
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70325101C0;
	Mon, 14 Aug 2023 21:42:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCC10965
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09986C433B7;
	Mon, 14 Aug 2023 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049319;
	bh=ryVKlus+aSUwEoR7+dhX0qBECSOKc/VGjuAEFro+VH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MU1U3ErWUK9zvr94xxkfsE6T6ZktQrwa4FNkP+v32hiuQ6WaeUypo5aIVjeW3Nlvf
	 7V6D6rruzN6+QEakUg8gKguiw+D6O1CDU90MyR7H/jdropRu53wh1rom/WPNPWvf9C
	 UzUP7k1K7aLZLlomBN4EYCs1NZ3f+2nl70G9F0P0ulLgYOPXNp/YWEostQDbvExkou
	 +iad8yzG4s2hqvrBSprzwip6SWvQNOVFdyr6vgnGmEKdQCLetibz5jF8+9Tu0Q5YMa
	 P4FBUifak1GndqBb1LdEoblzueD8aoiSAqBsrexeaP0LVYVrBT7DcsAnFxFsU5veKt
	 yyzXIhdS+V9tA==
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
Subject: [net-next 10/14] net/mlx5: Remove redundant check of mlx5_vhca_event_supported()
Date: Mon, 14 Aug 2023 14:41:40 -0700
Message-ID: <20230814214144.159464-11-saeed@kernel.org>
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

Since mlx5_vhca_event_supported() is called in mlx5_sf_dev_supported(),
remove the redundant call.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index 39132a6cc68b..e617a270d74a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -299,7 +299,7 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 	unsigned int max_sfs;
 	int err;
 
-	if (!mlx5_sf_dev_supported(dev) || !mlx5_vhca_event_supported(dev))
+	if (!mlx5_sf_dev_supported(dev))
 		return;
 
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
-- 
2.41.0


