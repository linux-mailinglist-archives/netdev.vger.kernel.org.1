Return-Path: <netdev+bounces-25077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500A772D7E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F70828138A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2933715AC2;
	Mon,  7 Aug 2023 18:05:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673DB156D2
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 18:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E8FC433C9;
	Mon,  7 Aug 2023 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431514;
	bh=mzk71NWb88xS7VyuFnDy5cLjpTsU/+dCWG/qpNuLc20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbH0T0EUr9EOEFuCGdvN0xKqcybFsdQ/MEryb95ofTOyxnbKkR5kN+YuZk45OOUk2
	 f1sIoe6P21gi52/aBlKkfey+Xpvhct+2XKKklFsvLDJ+labtGibXCwLKSTfa7w0OX8
	 kpRiVy+I7X50NJ8Z3f8p+Hc1FFfrKn2Cb159xLFJFBCdi65UvNzpw+KU4G9R+rYxjR
	 fVfqpBPjHSK3IFMqxf9ABJW+90GsjxHaFnSwqDA83EaOgOVfY8lQg1FbksLOaVsbwY
	 VB579fN7sxxpuOtKfnXuyjwXO4s48QzuGFqF14yp5yK9NiwN+3X8RbF8tki0L+zQ9l
	 FruIgDqkX8D8Q==
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
Subject: [PATCH net-next V2 1/2] net/mlx5: Expose port.c/mlx5_query_module_num() function
Date: Mon,  7 Aug 2023 11:05:06 -0700
Message-ID: <20230807180507.22984-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807180507.22984-1-saeed@kernel.org>
References: <20230807180507.22984-1-saeed@kernel.org>
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

CC: linux-hwmon@vger.kernel.org
CC: Jean Delvare <jdelvare@suse.com>
CC: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 43b0144121ca..d54afb07d972 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -176,6 +176,7 @@ static inline int mlx5_flexible_inlen(struct mlx5_core_dev *dev, size_t fixed,
 
 int mlx5_query_hca_caps(struct mlx5_core_dev *dev);
 int mlx5_query_board_id(struct mlx5_core_dev *dev);
+int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num);
 int mlx5_cmd_init(struct mlx5_core_dev *dev);
 void mlx5_cmd_cleanup(struct mlx5_core_dev *dev);
 int mlx5_cmd_enable(struct mlx5_core_dev *dev);
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


