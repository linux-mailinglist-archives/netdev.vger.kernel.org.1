Return-Path: <netdev+bounces-126032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6722496FB2E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 20:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234D8282FAC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE01B85C8;
	Fri,  6 Sep 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxwZVrMS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625191B85C0
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647042; cv=none; b=DuqMii8kT8qcK1/lRWuzEEAgdZl3LH4nABFsxUB3F9nhwwpOfLXRSi6MukgdnvJlWZZT4BTAegvykqFBHwWuJirYeCjAcEzwH09V9CVY1wkHMiu6D8geJjaUsjNZSaNpQB+8SzV70/9z1WSiGHhhleargjWYVFvzq/mjQ+GciLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647042; c=relaxed/simple;
	bh=C/Xn+zCgvyQ8jubkOZokejE+4FYhDVkDKEzBRHorVrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOJ4z/9+EnUYyVLQH1o+bWfbOzmJADVynn1Ry3oZtlB/p426C7pY5TExKqUynZBzRMTnLfH2gRttg9oChdcAlpU0LvxA009z3NkldpX8bBWrOcMusJverQBqj4fmsTigPifxWvl/aRyusF66jSHf2xCi7BlmJ7SHXk02aC2ldR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxwZVrMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556F5C4CEC4;
	Fri,  6 Sep 2024 18:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725647041;
	bh=C/Xn+zCgvyQ8jubkOZokejE+4FYhDVkDKEzBRHorVrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxwZVrMSk0u4C15PopVGdmvBkIGMHOl3DxUfCtVg5CaUJ+GlMP9zF4O9yoGC4VcN7
	 B5CeVtXu2dqT234FUFDVCBZdBDOGfzf9a/OBiTnXo2G93y0dwoJ+pVQM9x9NzZfVrz
	 xW3KTdkO4gVyD47MYoaGWaQoxWLq22d0V8GfpJM1GTAE4kFcLrD6WcRSG5S1C8j1OO
	 I++l4HkLMpEnTf0bEPgZglxSDy2HGqO7o9dwiUjmHWWdYbT5dxeQ6xAbkfaTLxpMBF
	 9iTfa6SOc03FTXyIj0Q6mMmCZ/vVrEsKf4e9WaXgtiIg8R62Q0waHXYCV2x3UiFhEn
	 4mVnHjYxkOh2g==
Date: Fri, 6 Sep 2024 19:23:56 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [net-next V2 11/15] net/mlx5: HWS, added memory management
 handling
Message-ID: <20240906182356.GK2097826@kernel.org>
References: <20240905062752.10883-1-saeed@kernel.org>
 <20240905062752.10883-12-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905062752.10883-12-saeed@kernel.org>

On Wed, Sep 04, 2024 at 11:27:46PM -0700, Saeed Mahameed wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Added object pools and buddy allocator functionality.
> 
> Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.c

...

> +static struct mlx5hws_pool_resource *
> +hws_pool_create_one_resource(struct mlx5hws_pool *pool, u32 log_range,
> +			     u32 fw_ft_type)
> +{
> +	struct mlx5hws_cmd_ste_create_attr ste_attr;
> +	struct mlx5hws_cmd_stc_create_attr stc_attr;
> +	struct mlx5hws_pool_resource *resource;
> +	u32 obj_id;
> +	int ret;
> +
> +	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
> +	if (!resource)
> +		return NULL;
> +
> +	switch (pool->type) {
> +	case MLX5HWS_POOL_TYPE_STE:
> +		ste_attr.log_obj_range = log_range;
> +		ste_attr.table_type = fw_ft_type;
> +		ret = mlx5hws_cmd_ste_create(pool->ctx->mdev, &ste_attr, &obj_id);
> +		break;
> +	case MLX5HWS_POOL_TYPE_STC:
> +		stc_attr.log_obj_range = log_range;
> +		stc_attr.table_type = fw_ft_type;
> +		ret = mlx5hws_cmd_stc_create(pool->ctx->mdev, &stc_attr, &obj_id);
> +		break;
> +	default:

Hi Saeed and Yevgeny,

Another minor nit from my side (I think this is the last one).

If we get here, then ret will be used uninitialised by the if condition below.

Also flagged by Smatch.

> +		break;
> +	}
> +
> +	if (ret) {
> +		mlx5hws_err(pool->ctx, "Failed to allocate resource objects\n");
> +		goto free_resource;
> +	}
> +
> +	resource->pool = pool;
> +	resource->range = 1 << log_range;
> +	resource->base_id = obj_id;
> +
> +	return resource;
> +
> +free_resource:
> +	kfree(resource);
> +	return NULL;
> +}

