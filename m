Return-Path: <netdev+bounces-135113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624A99C56A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33FA28B2B2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF0F1A256F;
	Mon, 14 Oct 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FybViEqO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372401A2545
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897462; cv=none; b=rDHNr7psQp5eI37B2Fgyiuy5mvN+2hMjyz3IN3KPZChrwc7+9ZPsxtaeax/+Zwm70ddMZpP/X0uUK1nRM0Qmqv14vktUW2WRURPOK0v3o3pzwXeqy72Nn77u2UjC0NfcpWDjM8koCuDkauGO/YXVq5MfGqrXmtyHls5lSxeLVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897462; c=relaxed/simple;
	bh=X9tVAxIBKX22qtH1w56dXRIVjc6wvJfam+RvxZKJOnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRFRsmokhFBQpmWFySuXdhM0eXgP9afcXca5DGSSaNEdnVRtLnTY2L5FaILyRGkccDHTMHot/ncuXMPHe1xXNeOB1E+x4tvSD9p7LgZKkMSr82OPIILy5xUxBRmpkncqfNOg7nEWChpvVS4yaQ3/qSefkp2cC2s/cCgBoNqmONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FybViEqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F3CC4CEC3;
	Mon, 14 Oct 2024 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728897461;
	bh=X9tVAxIBKX22qtH1w56dXRIVjc6wvJfam+RvxZKJOnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FybViEqOg6bZYWO8QvPiZztvl2c1rLIx1/O/ER/TUnwoQlKlBBH/FMYSmZ5rHPOwI
	 hWzXqb5+glpTnlUN0D5WkdhWw87fz03P6pPAEDI4VZgS/Wyl0+ialsdmBB+RHGDqaQ
	 BtS/NzTKrhu45fqgCSRkUM4nBtg4AWZVqdFh9I36kTLpC0SjH3RpkfxUJ0noi4++wD
	 OzDfWqXFOkDOq1S1/d6PqjZPSLOnDjhbM489fTcR/u08q5y0X5169FWBoj9VbdJK+b
	 hGT7b6Ene9AFyDnf28w9DT5SecbsFh/o5TA8Wv8pMdRHh8I6FV4UkzEZPpqGqyBRKG
	 0Q1PXbsv3XzFg==
Date: Mon, 14 Oct 2024 10:17:37 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, cjubran@nvidia.com,
	cratiu@nvidia.com
Subject: Re: [PATCH net-next 06/15] net/mlx5: Introduce node struct and
 rename group terminology to node
Message-ID: <20241014091737.GQ77519@kernel.org>
References: <20241013064540.170722-1-tariqt@nvidia.com>
 <20241013064540.170722-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013064540.170722-7-tariqt@nvidia.com>

On Sun, Oct 13, 2024 at 09:45:31AM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Introduce the `mlx5_esw_sched_node` struct, consolidating all rate
> hierarchy related details, including membership and scheduling
> parameters.
> 
> Since the group concept aligns with the `mlx5_esw_sched_node`, replace
> the `mlx5_esw_rate_group` struct with it and rename the "group"
> terminology to "node" throughout the rate hierarchy.
> 
> All relevant code paths and structures have been updated to use the
> "node" terminology accordingly, laying the groundwork for future
> patches that will unify the handling of different types of members
> within the rate hierarchy.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c

...

> -static struct mlx5_esw_rate_group *
> -__esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct mlx5_esw_rate_group *parent,
> -				   struct netlink_ext_ack *extack)
> +static struct mlx5_esw_sched_node *
> +__esw_qos_create_vports_rate_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
> +				  struct netlink_ext_ack *extack)
>  {
> -	struct mlx5_esw_rate_group *group;
> +	struct mlx5_esw_sched_node *node;
>  	u32 tsar_ix, err;
>  
> -	err = esw_qos_create_group_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
> +	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
>  	if (err) {
> -		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
> +		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
>  		return ERR_PTR(err);
>  	}
>  
> -	group = __esw_qos_alloc_rate_group(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
> -	if (!group) {
> -		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc group failed");
> +	node = __esw_qos_alloc_rate_node(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
> +	if (!node) {
> +		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
>  		err = -ENOMEM;
> -		goto err_alloc_group;
> +		goto err_alloc_node;

Hi Carolina and Tariq,

node is NULL here, but will be dereferenced after jumping to err_alloc_node.

Flagged by Smatch.

>  	}
>  
>  	err = esw_qos_normalize_min_rate(esw, extack);
>  	if (err) {
> -		NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
> +		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
>  		goto err_min_rate;
>  	}
> -	trace_mlx5_esw_group_qos_create(esw->dev, group, group->tsar_ix);
> +	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
>  
> -	return group;
> +	return node;
>  
>  err_min_rate:
> -	__esw_qos_free_rate_group(group);
> -err_alloc_group:
> +	__esw_qos_free_node(node);
> +err_alloc_node:
>  	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
>  						SCHEDULING_HIERARCHY_E_SWITCH,
> -						tsar_ix))
> -		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for group failed");
> +						node->ix))
> +		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for node failed");
>  	return ERR_PTR(err);
>  }

...

