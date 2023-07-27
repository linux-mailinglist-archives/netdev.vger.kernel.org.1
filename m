Return-Path: <netdev+bounces-22028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01583765B82
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B3B1C21595
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D1E1CA13;
	Thu, 27 Jul 2023 18:39:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74091C9ED
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E72CC433CA;
	Thu, 27 Jul 2023 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483172;
	bh=9HPMgzP1VpnPfSM+5ynHx12PlsFUHRgKFE5See3xJUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XipfDzYa88HbLXSel8oTM739LxCYuXbo9nbb2bYuJkWDutOQ6HlfY4joEyDUNK68/
	 rNEMAiGhs6wSxduo9ze2Ob830IxDTYIQVlQxopAKZPqji3XvUu4tdZhpij2gtBcd4x
	 jZhKMFMdIb7r1l1GMhxRdSP9XPUvqNWJFQ0OJwkSl6TzKh4TD4gaoaiCUnSSoVoC7K
	 CiGu3+jBEQfJKdr4E3u4KmmBxzjvziHP6aFVJWq6C8othlF7lYacL2jmgUGBZsx/0r
	 /rY8Rg9Uu05eRNY+HZ5BiDZjyEvVKjM9l8SfjN+9paJTzxHXgqI+4OTbCl0u54sfam
	 4nMQiycGVqclg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Roi Dayan <roid@nvidia.com>
Subject: [net-next V2 10/15] net/mlx5e: Make flow classification filters static
Date: Thu, 27 Jul 2023 11:39:09 -0700
Message-ID: <20230727183914.69229-11-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727183914.69229-1-saeed@kernel.org>
References: <20230727183914.69229-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Get and set flow classification filters are used in a single file.
Hence, make them static.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h         | 3 ---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b1807bfb815f..0f8f70b91485 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1167,9 +1167,6 @@ int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 int mlx5e_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key, u8 *hfunc);
 int mlx5e_set_rxfh(struct net_device *dev, const u32 *indir, const u8 *key,
 		   const u8 hfunc);
-int mlx5e_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
-		    u32 *rule_locs);
-int mlx5e_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd);
 u32 mlx5e_ethtool_get_rxfh_key_size(struct mlx5e_priv *priv);
 u32 mlx5e_ethtool_get_rxfh_indir_size(struct mlx5e_priv *priv);
 int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 27861b68ced5..04195a673a6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2163,8 +2163,8 @@ static u32 mlx5e_get_priv_flags(struct net_device *netdev)
 	return priv->channels.params.pflags;
 }
 
-int mlx5e_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
-		    u32 *rule_locs)
+static int mlx5e_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
+			   u32 *rule_locs)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
@@ -2181,7 +2181,7 @@ int mlx5e_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	return mlx5e_ethtool_get_rxnfc(priv, info, rule_locs);
 }
 
-int mlx5e_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
+static int mlx5e_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-- 
2.41.0


