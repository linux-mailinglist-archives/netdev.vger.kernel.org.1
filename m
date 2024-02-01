Return-Path: <netdev+bounces-67852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E1B8451FD
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3516228B77D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AC0159594;
	Thu,  1 Feb 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0waNcCb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2915958A
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772739; cv=none; b=TskscOXxdUpW6fyCCYy2WHjNrwbCA9Ffa7ga5lZb87TsUNAw4aV5rlunPrtjUAQm74DI0HmPIyrB1yhZ30HG0Tx4fpLnAKPvafzdXgmROZCXHvwCsk0ufYODtIwoUW06yOcS/GEmDg3+XrZaSRzYl8SmrQTW9CCSD4ljdjllgPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772739; c=relaxed/simple;
	bh=yCvanqdBUlXvyRqal3E5fgJVxVd3vx6uUIpnH0Aio8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O98AHhgzMO7EjI+zasjx4KlHdYdR68UnyqAwk655RUbMFP/nMA2N1GWtjkPR/YRnW1I0DfpY+/x674BAFR54EubX311XP3BBL3MXQJnHwVHg92hkPZQM2kUEraLYfMLejXtmr0Uic0AJq0WGKT9Vgji818iRs7QzPb1Q4kqxKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0waNcCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46783C433A6;
	Thu,  1 Feb 2024 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772739;
	bh=yCvanqdBUlXvyRqal3E5fgJVxVd3vx6uUIpnH0Aio8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0waNcCbqsvOkScO+3K9AiLIRbxSm4ucWZ+xTb0yXGESKrJoi7F1ZiSXje+PCWqUv
	 wa4I0MY/+VCsgEdkSZ+34Gfsbw3IdsJfb7T6bQv7wdpLDIQE0KzZHjqgAB/tp+59R4
	 u5EfN5tB6Va4HzeeIhsa6tuUnKqEDNg79Qdix6MRhkGkDyUOGfLQWijsza4V0DlQ/B
	 XNADPZB2FwMSMe0aBO7ifzACmd1v3UZITguSlq6EHlvJoij2901JjeRauDWYMTp1zO
	 1S8SlNLdaTbrOO3iH3u6PeipMIqqQXWHdbERj/lDd0vFbdthDlXoWKdGp9A3J7ZLyx
	 0uGOuO5Oqu+dQ==
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
Subject: [net-next V2 06/15] net/mlx5: Rename mlx5_sf_dev_remove
Date: Wed, 31 Jan 2024 23:31:49 -0800
Message-ID: <20240201073158.22103-7-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201073158.22103-1-saeed@kernel.org>
References: <20240201073158.22103-1-saeed@kernel.org>
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


