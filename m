Return-Path: <netdev+bounces-22038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA47765BC5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09E61C21353
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272C8198A7;
	Thu, 27 Jul 2023 18:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEBA18059
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBA3C433C9;
	Thu, 27 Jul 2023 18:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690484383;
	bh=NS2KTbj73riFkmJ8tdmEQt7PhzrwwF2iy0ONe1phkpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZy4gc754vEwGMXJKWliiX7dj0QQ0h5nzQgCd8URFT9Jcs9ba6JPf2XixD1mKKQp0
	 MvowNM3sLUURMDZz2DQQGeZtqYDMlPY14we8rXFbZn8dTB1zLytTudfi26bfP1ZFlp
	 FKobuzb0wzkZcnad0tASIx1DOWdn0QfVVwfISZ3UBxzPB0iCpM9yIRzlGkMIu5x/zj
	 UdT+YtNas6pLuRnyLYW2mZMbcWc/hlVUQA5i10meYU4ULTPqOi7JDKhQ2eh2apAU1M
	 iilhuk8jaYEYGMszESBpCW0nVcM+h9CedGWzy0l72vSYsNapNRSsoRyFfjw3f8NDdl
	 W1lAaR5ejDVkg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Adham Faris <afaris@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 1/2] net/mlx5: Expose port.c/mlx5_query_module_num() function
Date: Thu, 27 Jul 2023 11:59:21 -0700
Message-ID: <20230727185922.72131-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727185922.72131-1-saeed@kernel.org>
References: <20230727185922.72131-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adham Faris <afaris@nvidia.com>

Make mlx5_query_module_num() defined in port.c, a non-static, so it can
be used by other files.

Issue: 3451280
Signed-off-by: Adham Faris <afaris@nvidia.com>
Change-Id: I2c5d7e968ae3ef632f38b1bedda1586058096b4a
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index c4be257c043d..6cebc8417282 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -176,6 +176,7 @@ static inline int mlx5_flexible_inlen(struct mlx5_core_dev *dev, size_t fixed,
 
 int mlx5_query_hca_caps(struct mlx5_core_dev *dev);
 int mlx5_query_board_id(struct mlx5_core_dev *dev);
+int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num);
 int mlx5_cmd_init(struct mlx5_core_dev *dev);
 void mlx5_cmd_cleanup(struct mlx5_core_dev *dev);
 void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 0daeb4b72cca..be70d1f23a5d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -271,7 +271,7 @@ void mlx5_query_port_oper_mtu(struct mlx5_core_dev *dev, u16 *oper_mtu,
 }
 EXPORT_SYMBOL_GPL(mlx5_query_port_oper_mtu);
 
-static int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num)
+int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num)
 {
 	u32 in[MLX5_ST_SZ_DW(pmlp_reg)] = {0};
 	u32 out[MLX5_ST_SZ_DW(pmlp_reg)];
-- 
2.41.0


