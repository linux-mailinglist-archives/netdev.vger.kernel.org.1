Return-Path: <netdev+bounces-110968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB192F276
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E01F21AB1
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57DC16D320;
	Thu, 11 Jul 2024 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npwL267X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14FC8289C
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739131; cv=none; b=FzYSsxz42OLA51UXBtafSZ7DT/ZODw7BmFOvW3GRlAgI6ygtMGDFy2XUuH/MDV+DRX5hZlILKqt7kDR3R8jpf62aviEhQbKXNM3tAdXTbSOmsGy8AKJ4eQxkRbq1RAwubWL8FM1BMR90cLMJBkZDqZdgrBdtwbCJmYE9XfnqNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739131; c=relaxed/simple;
	bh=eWSc1pj6MHWrSSQQMF0RuO15wKaEh58uBsgtWtZgIBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEkwIfjTl2/fwhbfk2omJVIYaegTgDQicu3lpeASVQ/Nf23lXKDC7j+QctfaztHogMz6Zt0tgRbaw019URSBZm/6bYlevxthHyOXuXcKCIKbq308gxPy3nPlM8OMWFdtqGqe4+Wj73yNlRHnyd7UjF3NY7l1WPogDA158CD8Fic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npwL267X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F488C116B1;
	Thu, 11 Jul 2024 23:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720739131;
	bh=eWSc1pj6MHWrSSQQMF0RuO15wKaEh58uBsgtWtZgIBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npwL267XH4aBIXmUF2aI75ujgRaWt2Q4fgVeWCdAZ5XoXiYBAVMc3G3d5AKpIZI5N
	 03Iupu2ctmuoOEfyRPsEjdKuk0o0r1afxKIUp73r+atOPX693Y11S/1IlrZSNOsHpe
	 9VvXufitD/mBjRDlMd4qAzjGgNLUowIkWHeiAvNFJB8MubWlFNrj3YP9v7dlxnipvA
	 kZ0Oj854pcRaLlBXZgEyaS3qh4C2w8OG4m0VSrkjKcr5WQpwbR/W7vSWUcYlzZFCBV
	 wvdjG2oLgquvkUxVTm9V+Llsk3RI+qYRBlp+6vbKBuqWeo1wwAajDWDkeOShFaeUMK
	 UC077DIjH7q7w==
Date: Thu, 11 Jul 2024 16:05:29 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, tariqt@nvidia.com, rrameshbabu@nvidia.com,
	saeedm@nvidia.com, yuehaibing@huawei.com, horms@kernel.org,
	jacob.e.keller@intel.com, afaris@nvidia.com
Subject: Re: [PATCH net-next v2] eth: mlx5: expose NETIF_F_NTUPLE when ARFS
 is compiled out
Message-ID: <ZpBlOWzyihXUad_V@x130>
References: <20240711223722.297676-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240711223722.297676-1-kuba@kernel.org>

On 11 Jul 15:37, Jakub Kicinski wrote:
>ARFS depends on NTUPLE filters, but the inverse is not true.
>Drivers which don't support ARFS commonly still support NTUPLE
>filtering. mlx5 has a Kconfig option to disable ARFS (MLX5_EN_ARFS)
>and does not advertise NTUPLE filters as a feature at all when ARFS
>is compiled out. That's not correct, ntuple filters indeed still work
>just fine (as long as MLX5_EN_RXNFC is enabled).
>
>This is needed to make the RSS test not skip all RSS context
>related testing.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>v2:
> - hard wire to on (not propagating Simon's review because of this)
>v1: https://lore.kernel.org/20240710175502.760194-1-kuba@kernel.org
>
>CC: tariqt@nvidia.com
>CC: rrameshbabu@nvidia.com
>CC: saeedm@nvidia.com
>CC: yuehaibing@huawei.com
>CC: horms@kernel.org
>CC: jacob.e.keller@intel.com
>CC: afaris@nvidia.com
>---
> drivers/net/ethernet/mellanox/mlx5/core/en/fs.h     | 13 +++++++++++++
> .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    |  2 +-
> drivers/net/ethernet/mellanox/mlx5/core/en_fs.c     |  5 ++---
> drivers/net/ethernet/mellanox/mlx5/core/en_main.c   |  8 +++++---
> .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c   |  8 +++-----
> 5 files changed, 24 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
>index 4d6225e0eec7..1e8b7d330701 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
>@@ -154,6 +154,19 @@ struct mlx5e_tc_table *mlx5e_fs_get_tc(struct mlx5e_flow_steering *fs);
> struct mlx5e_l2_table *mlx5e_fs_get_l2(struct mlx5e_flow_steering *fs);
> struct mlx5_flow_namespace *mlx5e_fs_get_ns(struct mlx5e_flow_steering *fs, bool egress);
> void mlx5e_fs_set_ns(struct mlx5e_flow_steering *fs, struct mlx5_flow_namespace *ns, bool egress);
>+
>+static inline bool mlx5e_fs_has_arfs(struct net_device *netdev)
>+{
>+	return IS_ENABLED(CONFIG_MLX5_EN_ARFS) &&
>+		netdev->hw_features & NETIF_F_NTUPLE;
>+}
>+
>+static inline bool mlx5e_fs_want_arfs(struct net_device *netdev)
>+{
>+	return IS_ENABLED(CONFIG_MLX5_EN_ARFS) &&
>+		netdev->features & NETIF_F_NTUPLE;
>+}
>+
> #ifdef CONFIG_MLX5_EN_RXNFC
> struct mlx5e_ethtool_steering *mlx5e_fs_get_ethtool(struct mlx5e_flow_steering *fs);
> #endif
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>index 3320f12ba2db..5582c93a62f1 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>@@ -525,7 +525,7 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
>
> 	opened = test_bit(MLX5E_STATE_OPENED, &priv->state);
>
>-	arfs_enabled = opened && (priv->netdev->features & NETIF_F_NTUPLE);
>+	arfs_enabled = opened && mlx5e_fs_want_arfs(priv->netdev);
> 	if (arfs_enabled)
> 		mlx5e_arfs_disable(priv->fs);
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
>index 8c5b291a171f..05058710d2c7 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
>@@ -1307,8 +1307,7 @@ int mlx5e_create_flow_steering(struct mlx5e_flow_steering *fs,
> 		return -EOPNOTSUPP;
>
> 	mlx5e_fs_set_ns(fs, ns, false);
>-	err = mlx5e_arfs_create_tables(fs, rx_res,
>-				       !!(netdev->hw_features & NETIF_F_NTUPLE));
>+	err = mlx5e_arfs_create_tables(fs, rx_res, mlx5e_fs_has_arfs(netdev));
> 	if (err) {
> 		fs_err(fs, "Failed to create arfs tables, err=%d\n", err);
> 		netdev->hw_features &= ~NETIF_F_NTUPLE;
>@@ -1355,7 +1354,7 @@ int mlx5e_create_flow_steering(struct mlx5e_flow_steering *fs,
> err_destroy_inner_ttc_table:
> 	mlx5e_destroy_inner_ttc_table(fs);
> err_destroy_arfs_tables:
>-	mlx5e_arfs_destroy_tables(fs, !!(netdev->hw_features & NETIF_F_NTUPLE));
>+	mlx5e_arfs_destroy_tables(fs, mlx5e_fs_has_arfs(netdev));
>
> 	return err;
> }
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>index ff335527c10a..6f686fabed44 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>@@ -5556,8 +5556,10 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
> #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
> 		netdev->hw_features      |= NETIF_F_HW_TC;
> #endif
>-#ifdef CONFIG_MLX5_EN_ARFS
>+#if IS_ENABLED(CONFIG_MLX5_EN_ARFS)
> 		netdev->hw_features	 |= NETIF_F_NTUPLE;
>+#elif IS_ENABLED(CONFIG_MLX5_EN_RXNFC)
>+		netdev->features	 |= NETIF_F_NTUPLE;

Why default ON when RXNFC and OFF when ARFS ?
Default should be off always, and this needs to be advertised in 
hw_features in both cases.

I think this should be
#if IS_ENABLED(ARFS) || IS_ENABLED(RXFNC)
	netdev->hw_features |= NTUPLE;

Otherwise LGTM

Acked-by: Saeed Mahameed <saeedm@nvidia.com>



