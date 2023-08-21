Return-Path: <netdev+bounces-29397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD6782FDB
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51757280E2C
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7978712B6D;
	Mon, 21 Aug 2023 17:58:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F58125C2
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88F3C433CA;
	Mon, 21 Aug 2023 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640683;
	bh=iC2fGKkW8+k7zwi6L4Kt7/LWSZlJohRv6bgiUjKGMTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxjuTVM77Iua/mQwMM1HCxVENunwWlO7PKR+TeA96Xn7z+3Hik8kPN7o1+mNh6H09
	 qtKcSWB6TKudSbWZWDDuL4ODUq9Whoeqn9g/9w/bVZJul1E5lZBlWLGXeXH3q4sica
	 Tnqixdb1IKYEXrVrAITa8jHnWrQDGjlhpNgnUMdWqIY6E5KJpoL9xYsfVh4f2oHSp/
	 uaSAc0eTnLj8sSunldhpUy83g2LEX4CZXxtn5fwqHe4empc5YkZ0uGQKGqSfpa8mHE
	 Obr6Uqk38w4WX59Q2LvHZkFZuGdCEA5sMJseppQM8slbF8wJg7uBGYqrELEXo9HhuH
	 EHIdR9qV3x2hA==
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
Subject: [net-next V2 12/14] net/mlx5: Rename devlink port ops struct for PFs/VFs
Date: Mon, 21 Aug 2023 10:57:37 -0700
Message-ID: <20230821175739.81188-13-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821175739.81188-1-saeed@kernel.org>
References: <20230821175739.81188-1-saeed@kernel.org>
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


