Return-Path: <netdev+bounces-68682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81684795F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C01C28C41
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009C12C804;
	Fri,  2 Feb 2024 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6vwZnkw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B412C802
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900947; cv=none; b=M7HYDaYGNun/8phcRwdzrX4RPwKYUIUB/O42dIF+M9+2QSRLT1QdOLNjbmlLnxrbEctDLM7c9LaxY4eQWmv6y6hhtfMfwWIQjy7aimBNxuYaO7fLalsvdZ6ahLDbqsFWzuvES/rZ+AANZVdmokmHyCWOcv4y6tzuVEYnU7XgGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900947; c=relaxed/simple;
	bh=yCvanqdBUlXvyRqal3E5fgJVxVd3vx6uUIpnH0Aio8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icvmi+s71wnC6/svrltEbUNIdi8eTcauu6/A/76IeHRkQncX4M3yoqTWpjQsZll++53G8f+RdYuvZjHVJuI8zlS1XJwrwsLNkefmMaoklv7XPzSNE0A6ebs2ho+Uu5XzPMLAjZ2DCyVgUkA4k6xb9gqVVQnjc5ihweB2eD3+cDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6vwZnkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81238C433F1;
	Fri,  2 Feb 2024 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900946;
	bh=yCvanqdBUlXvyRqal3E5fgJVxVd3vx6uUIpnH0Aio8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6vwZnkwXOxgzDA96PZMlAs50tdfmAHsq8aywjUQRWERKc3jW88NfTPRzPQupFuaA
	 s13qbL/ecCCb7xOAljPKrf3Oegu2P/jjdp17qbQq+H7qnbLONtFTu9srjj7ptKGJcq
	 IgOSLoatJP6F2E09gWG2nt/O1MEgjLCDlFCSeid+OBMtpqwAU5d6MU0DvGzYym6Znf
	 ydS3ZjeuvJDBbpRbw0yyCA0DVNZPsi7+F76DpyDN9/GMfSiUVgR8P3AO2Qoxa5xWGx
	 sEFvPdfGkHvWZp7/a0w4FUq0jKJSWWrLFtbckMwHJBD4cAo/NZ3HGathJgUcFKVKm2
	 isKTr+gRMLKHg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next V3 06/15] net/mlx5: Rename mlx5_sf_dev_remove
Date: Fri,  2 Feb 2024 11:08:45 -0800
Message-ID: <20240202190854.1308089-7-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190854.1308089-1-saeed@kernel.org>
References: <20240202190854.1308089-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

Mlx5 has two functions with the same name mlx5_sf_dev_remove. Both are
static, in different files, so no compilation or logical issue, but it
makes it hard to follow the code and some traces even can get both as
one leads to the other [1]. Rename one to mlx5_sf_dev_remove_aux() as it
actually removes the auxiliary device of the SF.

[1]
 mlx5_sf_dev_remove+0x2a/0x70 [mlx5_core]
 auxiliary_bus_remove+0x18/0x30
 device_release_driver_internal+0x199/0x200
 bus_remove_device+0xd7/0x140
 device_del+0x153/0x3d0
 ? process_one_work+0x16a/0x4b0
 mlx5_sf_dev_remove+0x2e/0x90 [mlx5_core]
 mlx5_sf_dev_table_destroy+0xa0/0x100 [mlx5_core]

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index c93492b67788..99219ea52c4b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -74,7 +74,8 @@ static void mlx5_sf_dev_release(struct device *device)
 	kfree(sf_dev);
 }
 
-static void mlx5_sf_dev_remove(struct mlx5_core_dev *dev, struct mlx5_sf_dev *sf_dev)
+static void mlx5_sf_dev_remove_aux(struct mlx5_core_dev *dev,
+				   struct mlx5_sf_dev *sf_dev)
 {
 	int id;
 
@@ -138,7 +139,7 @@ static void mlx5_sf_dev_add(struct mlx5_core_dev *dev, u16 sf_index, u16 fn_id,
 	return;
 
 xa_err:
-	mlx5_sf_dev_remove(dev, sf_dev);
+	mlx5_sf_dev_remove_aux(dev, sf_dev);
 add_err:
 	mlx5_core_err(dev, "SF DEV: fail device add for index=%d sfnum=%d err=%d\n",
 		      sf_index, sfnum, err);
@@ -149,7 +150,7 @@ static void mlx5_sf_dev_del(struct mlx5_core_dev *dev, struct mlx5_sf_dev *sf_de
 	struct mlx5_sf_dev_table *table = dev->priv.sf_dev_table;
 
 	xa_erase(&table->devices, sf_index);
-	mlx5_sf_dev_remove(dev, sf_dev);
+	mlx5_sf_dev_remove_aux(dev, sf_dev);
 }
 
 static int
@@ -367,7 +368,7 @@ static void mlx5_sf_dev_destroy_all(struct mlx5_sf_dev_table *table)
 
 	xa_for_each(&table->devices, index, sf_dev) {
 		xa_erase(&table->devices, index);
-		mlx5_sf_dev_remove(table->dev, sf_dev);
+		mlx5_sf_dev_remove_aux(table->dev, sf_dev);
 	}
 }
 
-- 
2.43.0


