Return-Path: <netdev+bounces-28238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367E77EB52
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFD11C2124B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30B91CA03;
	Wed, 16 Aug 2023 21:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884E17AA2
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C302C433A9;
	Wed, 16 Aug 2023 21:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219668;
	bh=iC2fGKkW8+k7zwi6L4Kt7/LWSZlJohRv6bgiUjKGMTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9nqD028kgYvARzloMSdjvXT5LXZmaGnqQVB+MH7fiKV6QJkh/Qn+8tk+h2M71u6H
	 tvZ3TEkv5ey98S7TS5K3I/ZLs4eQ10BRz7V4HuPv247XTB/DZU3ocJ1h3zw/8ot5jy
	 1RWn3VFCvugcI+gp2Y8S9uvMWD/P7C5y5srwh0TnLAqsiu79rdRuWEewU5XnvGhqP2
	 QTlt51rd/8uO2u7bzCw0JfyX+lKNgX1XBXgYYfqhHS8Usismtpcu3GLhf+XndZzImd
	 c/rQdvnx1eenGKjd2I12uZbhdBLmP2l4IlCO+dpw5UArXYCRuqcxaFbjVhIu4KHDqG
	 isfZQfhuGFOVA==
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
Subject: [net-next 12/15] net/mlx5: Rename devlink port ops struct for PFs/VFs
Date: Wed, 16 Aug 2023 14:00:46 -0700
Message-ID: <20230816210049.54733-13-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

As this struct is only used for devlink ports created for PF/VF,
add it to the name of the variable to distinguish from the SF related
ops struct.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index ccf8cdedeab4..234fd4c28e79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -63,7 +63,7 @@ static void mlx5_esw_dl_port_free(struct devlink_port *dl_port)
 	kfree(dl_port);
 }
 
-static const struct devlink_port_ops mlx5_esw_dl_port_ops = {
+static const struct devlink_port_ops mlx5_esw_pf_vf_dl_port_ops = {
 	.port_fn_hw_addr_get = mlx5_devlink_port_fn_hw_addr_get,
 	.port_fn_hw_addr_set = mlx5_devlink_port_fn_hw_addr_set,
 	.port_fn_roce_get = mlx5_devlink_port_fn_roce_get,
@@ -95,7 +95,7 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 	devlink = priv_to_devlink(dev);
 	dl_port_index = mlx5_esw_vport_to_devlink_port_index(dev, vport_num);
 	err = devl_port_register_with_ops(devlink, dl_port, dl_port_index,
-					  &mlx5_esw_dl_port_ops);
+					  &mlx5_esw_pf_vf_dl_port_ops);
 	if (err)
 		goto reg_err;
 
-- 
2.41.0


