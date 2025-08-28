Return-Path: <netdev+bounces-217751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE417B39BA3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78983467873
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096C2EA170;
	Thu, 28 Aug 2025 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GanswKx5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31B30CD9D
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380862; cv=none; b=eCaPi0BFDWe9n/zkrJSM9zoamPR3zQK+DB3AG9SrvRyl71UvAE9Ql2nX+h1uw/0Mq7WAhnNHqgVLRzROGv7HEjENhlzUxhfEw72RNPpLQtlM8LqYl51XrigMoIeM7tKXItEZuTJo7jhTUdb8TuaDE00yAUuG2NmRiSvCUjPTQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380862; c=relaxed/simple;
	bh=jX4WE57wwaL2SAlbrArIxPo6UIRjjAolboJfhOPr3JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8NesxUk4SJRwke1z5upWHmewzng1gPP5/jtOPKx+XS0cBwLgF+8vnm4WRxC066B3uyLLRrOJIYja/b2bwhRIdST9ltvKyZtPaVnB19+zjj/DXUPeNNgEIoQbQyIIkzIK+IL01KaUIPWs+k1Bn5oXu0/1YraiScwQVwguWJLPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GanswKx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B4FC4CEEB;
	Thu, 28 Aug 2025 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756380862;
	bh=jX4WE57wwaL2SAlbrArIxPo6UIRjjAolboJfhOPr3JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GanswKx5+PhAaCdhXmFXbU1ReowfnjJIImdtC/vrglA/xVGd2MJaQJevCnLZTFmuC
	 6aYEs2oY8w/QTLGWVCLIbqSw2eYbi6H1viZLnHXFvx4T3IsMm4oJo8fGKy9YFwVLZj
	 QYdw99kQhpmWNpH46rcn72jmE55vDSlJCc4zmJAllJRVdEMioSjCPO6C8E9NTzNoF0
	 tssO+pqeiE9CFQZUFxcXtA2pANKO9dipagxytPSGGZemU6JQAp/i9tp+tAijmvxqO9
	 UZOLikTJ9kTZqyq0Z8dtCXHNqoDChGLOxXKhJicnDWRxPAeLC2Tie2uke572l7eclf
	 mr5wBKMl0BlnQ==
Date: Thu, 28 Aug 2025 12:34:17 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next V2 3/7] net/mlx5: E-Switch, Add support for
 adjacent functions vports discovery
Message-ID: <20250828113417.GB10519@horms.kernel.org>
References: <20250827044516.275267-1-saeed@kernel.org>
 <20250827044516.275267-4-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827044516.275267-4-saeed@kernel.org>

On Tue, Aug 26, 2025 at 09:45:12PM -0700, Saeed Mahameed wrote:
> From: Adithya Jayachandran <ajayachandra@nvidia.com>
> 
> Adding driver support to query adjacent functions vports, AKA
> delegated vports.
> 
> Adjacent functions can delegate their sriov vfs to other sibling PF in
> the system, to be managed by the eswitch capable sibling PF.
> E.g, ECPF to Host PF, multi host PF between each other, etc.
> 
> Only supported in switchdev mode.
> 
> Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c

...

> +static int
> +mlx5_eswitch_load_adj_vf_vports(struct mlx5_eswitch *esw,
> +				enum mlx5_eswitch_vport_event enabled_events)
> +{
> +	struct mlx5_vport *vport;
> +	unsigned long i;
> +	int err;
> +
> +	mlx5_esw_for_each_vf_vport(esw, i, vport, U16_MAX) {
> +		if (!vport->adjacent)
> +			continue;
> +		err = mlx5_eswitch_load_pf_vf_vport(esw, vport->vport,
> +						    enabled_events);
> +		if (err)
> +			goto unload_adj_vf_vport;
> +	}
> +
> +	return 0;
> +
> +unload_adj_vf_vport:
> +	mlx5_eswitch_unload_adj_vf_vports(esw);
> +	return err;
> +}
> +
>  int mlx5_eswitch_load_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs,
>  				enum mlx5_eswitch_vport_event enabled_events)
>  {
> @@ -1345,7 +1382,15 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
>  					  enabled_events);
>  	if (ret)
>  		goto vf_err;
> +
> +	/* Enable adjacent VF vports */
> +	ret = mlx5_eswitch_load_adj_vf_vports(esw, enabled_events);
> +	if (ret)
> +		goto unload_adj_vf_vports;
> +
>  	return 0;
> +unload_adj_vf_vports:
> +	mlx5_eswitch_unload_adj_vf_vports(esw);
>  

Hi Adithya and Saeed,

mlx5_eswitch_load_adj_vf_vports() already unwinds on error,
calling mlx5_eswitch_unload_adj_vf_vports().

While resources allocated by the preceding call to
mlx5_eswitch_load_vf_vports() (just before this hunk) seem to be leaked.

So I wonder if the above two lines should be:

unload_vf_vports:
	mlx5_eswitch_unload_vf_vports(esw, num_vfs);

>  vf_err:
>  	if (mlx5_core_ec_sriov_enabled(esw->dev))

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index cfd6b1b8c6f4..9f8bb397eae5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -216,6 +216,7 @@ struct mlx5_vport {
>  	u32                     metadata;
>  	int                     vhca_id;
>  
> +	bool adjacent; /* delegated vhca from adjacent function */
>  	struct mlx5_vport_info  info;
>  
>  	/* Protected with the E-Switch qos domain lock. The Vport QoS can
> @@ -384,6 +385,7 @@ struct mlx5_eswitch {
>  
>  	struct mlx5_esw_bridge_offloads *br_offloads;
>  	struct mlx5_esw_offload offloads;
> +	u32 last_vport_idx; /* ++ every time a vport is created */

The comment above documents one operation that can occur
on this field. But the code also performs others: decrement and set.

So perhaps this is more appropriate?

	u32 last_vport_idx; /* Number of vports created */

Or dropping the comment entirely: it seems obvious enough.

>  	int                     mode;
>  	u16                     manager_vport;
>  	u16                     first_host_vport;

...

