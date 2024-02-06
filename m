Return-Path: <netdev+bounces-69327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263F84AB36
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EDB1C22F4D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1425CEDF;
	Tue,  6 Feb 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5wMrPHf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF74A34
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180938; cv=none; b=KNhd+TR5SAEQP+gKhx7wNt5eqI6BR2IINexuUS8sVflhabcGe+Bh9XjnAqpRo+kXXl7pUrArVKrgyZin2ikWDMt0bmj507GUjmZRxFzwI3jHOVNXiETCkg0L+9kIDWfilLlti7bhgW0sMMPSWeBGt5ZHoL9naN2Vu+873jBMkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180938; c=relaxed/simple;
	bh=yCvanqdBUlXvyRqal3E5fgJVxVd3vx6uUIpnH0Aio8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxegkKULtJCG4RRdjBJ2kjHj6ZG6DX0PlvWcgllTf3WcavJur+LAVvInhQ8GwFWJEHKWxjOykzRpWOOrDXVbE9Y+QMnxLyYnz3EDJLz9itt/wt7U/gh+tcYU6fJZFqU2pkJXOq8ZH7RNhkKnRCXZX6iFeVMmsyDmCrFRJXGnqPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5wMrPHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DED3C433C7;
	Tue,  6 Feb 2024 00:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180937;
	bh=yCvanqdBUlXvyRqal3E5fgJVxVd3vx6uUIpnH0Aio8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5wMrPHfub2KsxGUUP2UjQybJch6u6HhbyvsOP7lgPFKvoEMNnORsGR1/GD4tcqnq
	 qohMBspnCWibDP70DlrncWbauYCGEk11ngA0cY6tk5FFL2qgEkUQ7hp2AV0sAynXyE
	 ODxuBvlbAT5ARKNQyd3V/atHzy0c1T/zDtr+x/Erd9587LU+LLkINvfxfA+D9q1FPf
	 Cxvmi7BNnsKbeuRIZHBzqJeVXWhkYS2yjyPZupvlOjVo3mGvWJwki4z9N8cmzOIsDE
	 Nck2W99qelSzo4pR1gyMHkC7of7mXBJD2ULYLyfsoZmmblCRvab86B+6GUegn4C+p/
	 cDOpthxAIFSuQ==
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
Subject: [net-next V4 06/15] net/mlx5: Rename mlx5_sf_dev_remove
Date: Mon,  5 Feb 2024 16:55:18 -0800
Message-ID: <20240206005527.1353368-7-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206005527.1353368-1-saeed@kernel.org>
References: <20240206005527.1353368-1-saeed@kernel.org>
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


