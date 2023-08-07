Return-Path: <netdev+bounces-25072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A938772D6A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0941C20CCB
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4036B1640B;
	Mon,  7 Aug 2023 17:57:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43E168AB
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3A3C433A9;
	Mon,  7 Aug 2023 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431025;
	bh=YcjxiwcWVZE2Eknfjcf7kCUFO1phdYqu3By7zOhCKNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwCDMqpzNYAMP/nfIMUbIE1ZWxk+BMmV+AHd1/bX9X6f6OkP2NddI9KIMbD01tYR2
	 EY1lxI8W280DjEjNzhZ43wQ/j12mDva73dPAwIBtBf7nLeT7Tl/uKXAtMSuwiEZEwC
	 HK9dHRGkX6iBnGaf61yYfVa4eK20c41ye+bor23l+0fvBVZyjoBkMTpmwQkOXPZbtR
	 YhumDYxdvzq8/eV/VR2BiWRa/jiMiRyLE8+fXAhTA/lf8sCw+0j3u+peElrA7Fcc0F
	 cw9Juo52lxCGViS63O0AFInadkA69aklOpJZb89GeNZHwaDAGCFzY3YpsT2X9NKbVY
	 ZxeJF+D64lQrg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next 12/15] net/mlx5: remove many unnecessary NULL values
Date: Mon,  7 Aug 2023 10:56:39 -0700
Message-ID: <20230807175642.20834-13-saeed@kernel.org>
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

From: Ruan Jinjie <ruanjinjie@huawei.com>

There are many pointers assigned first, which need not to be
initialized, so remove the NULL assignments.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c
index 39c03dcbd196..e5c1012921d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c
@@ -57,7 +57,7 @@ static const char * const mlx5_fpga_qp_error_strings[] = {
 };
 static struct mlx5_fpga_device *mlx5_fpga_device_alloc(void)
 {
-	struct mlx5_fpga_device *fdev = NULL;
+	struct mlx5_fpga_device *fdev;
 
 	fdev = kzalloc(sizeof(*fdev), GFP_KERNEL);
 	if (!fdev)
@@ -252,7 +252,7 @@ int mlx5_fpga_device_start(struct mlx5_core_dev *mdev)
 
 int mlx5_fpga_init(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_fpga_device *fdev = NULL;
+	struct mlx5_fpga_device *fdev;
 
 	if (!MLX5_CAP_GEN(mdev, fpga)) {
 		mlx5_core_dbg(mdev, "FPGA capability not present\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
index 4047629a876b..30564d9b00e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
@@ -40,7 +40,7 @@ struct mlx5_hv_vhca_agent {
 
 struct mlx5_hv_vhca *mlx5_hv_vhca_create(struct mlx5_core_dev *dev)
 {
-	struct mlx5_hv_vhca *hv_vhca = NULL;
+	struct mlx5_hv_vhca *hv_vhca;
 
 	hv_vhca = kzalloc(sizeof(*hv_vhca), GFP_KERNEL);
 	if (!hv_vhca)
-- 
2.41.0


