Return-Path: <netdev+bounces-37373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9C27B50A7
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 49654282034
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A010940;
	Mon,  2 Oct 2023 10:54:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A8CA49
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:54:24 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F96CB3
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 03:54:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40537481094so167033955e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 03:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696244061; x=1696848861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=179QgaCDX6J9NACZqaeG1/YJfl8KtaKdP8gEObH2+ck=;
        b=GfOZn0Gaeo28qp/jtfGGYP31dC7LZgoH9FxLvMCH5ceapUecxXTeI//tHsQE10HITe
         gzdL+hgKbISPqVY8KMbNE63kxyGghtWRQZalBgkiqYGxTwXuzgSssuAIlIOpXkrO3ES5
         drBT19ZWAKZMelRI42xNWBT/irkpxU2DJbcv0OddGvDp9O6i+Kse5lw5qMy3yyEnbxNq
         gDyV82tax+TbF+GJZ8VFLRkCrKBg8XHh2RXRYIl0Rg507swhkYTtiv4gVTxnC+/1i1hh
         AM1nPrdwc3EvqWtoVuNRBMLFrRNynHXereUwwOdkLlxgKYiV6b03RItTOqIdbUC9HZiP
         FTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244061; x=1696848861;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=179QgaCDX6J9NACZqaeG1/YJfl8KtaKdP8gEObH2+ck=;
        b=D9SDWs9hhY5CiNYF8s1Pk011WB9uJX6npfEuGblCkgKdYXYkPC1xJ/vxYSDzJ5d9jV
         rRdMecxJpt2dZCGqWnaqkQKYmqgqJUdBvPCkRvzrQN5texaX+/cVQarF6FDG69lj+7Q7
         5sBkbb6/sY6TBlRaLOrjx3/V5Hk6M8xX+ppJy+9/OitCPoTT8ZjiNYsZgPYnkAaIHFeL
         2dDGMehUeWWF/tLPT/ZIb2Pk9IxRFI81vjk8pnNWA0A2maPENCsO5wRfcCCPqVWx1JWN
         T1VIvQIuw/ufILuwzHhnXrErkmA4g7IMDODiQzd3lkSsLVvydPd8yNs55XJYXwZStqUk
         Excw==
X-Gm-Message-State: AOJu0YyKPTe8ikYeB1FDE+dv/ZVNzIs4VVwBuk5YeNuDwvHGt3mdUGY9
	PR2aqomVIovl1alS3/wLLDI=
X-Google-Smtp-Source: AGHT+IGDramA4Aj8OyoMujgEeJiWu8eBQ+8bps01sHgJVvnJcB78wym//j1C3gGuOFRrXLnxOU52nw==
X-Received: by 2002:a05:600c:214c:b0:406:177e:5de8 with SMTP id v12-20020a05600c214c00b00406177e5de8mr9256065wml.35.1696244060540;
        Mon, 02 Oct 2023 03:54:20 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id m24-20020a7bca58000000b004063977eccesm6991020wml.42.2023.10.02.03.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 03:54:20 -0700 (PDT)
Date: Mon, 2 Oct 2023 11:54:18 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
	mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	saeedm@nvidia.com, leon@kernel.org
Subject: Re: [PATCH v4 net-next 4/7] net: ethtool: let the core choose RSS
 context IDs
Message-ID: <20231002105418.GD21694@gmail.com>
Mail-Followup-To: edward.cree@amd.com, linux-net-drivers@amd.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com,
	leon@kernel.org
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <692201a4fd89cdf8ead6517fe0166d47385767ec.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692201a4fd89cdf8ead6517fe0166d47385767ec.1695838185.git.ecree.xilinx@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 07:13:35PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Add a new API to create/modify/remove RSS contexts, that passes in the
>  newly-chosen context ID (not as a pointer) rather than leaving the
>  driver to choose it on create.  Also pass in the ctx, allowing drivers
>  to easily use its private data area to store their hardware-specific
>  state.
> Keep the existing .set_rxfh_context API for now as a fallback, but
>  deprecate it.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  include/linux/ethtool.h | 40 ++++++++++++++++++++++++---
>  net/core/dev.c          | 15 ++++++++---
>  net/ethtool/ioctl.c     | 60 ++++++++++++++++++++++++++++++-----------
>  3 files changed, 93 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 229a23571008..975fda7218f8 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -747,10 +747,33 @@ struct ethtool_mm_stats {
>   * @get_rxfh_context: Get the contents of the RX flow hash indirection table,
>   *	hash key, and/or hash function assiciated to the given rss context.
>   *	Returns a negative error code or zero.
> - * @set_rxfh_context: Create, remove and configure RSS contexts. Allows setting
> + * @create_rxfh_context: Create a new RSS context with the specified RX flow
> + *	hash indirection table, hash key, and hash function.
> + *	Arguments which are set to %NULL or zero will be populated to
> + *	appropriate defaults by the driver.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
> + *	note that the indir table, hkey and hfunc are not yet populated as
> + *	of this call.  The driver does not need to update these; the core
> + *	will do so if this op succeeds.
> + *	If the driver provides this method, it must also provide
> + *	@modify_rxfh_context and @remove_rxfh_context.
> + *	Returns a negative error code or zero.
> + * @modify_rxfh_context: Reconfigure the specified RSS context.  Allows setting
>   *	the contents of the RX flow hash indirection table, hash key, and/or
> - *	hash function associated to the given context. Arguments which are set
> - *	to %NULL or zero will remain unchanged.
> + *	hash function associated with the given context.
> + *	Arguments which are set to %NULL or zero will remain unchanged.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
> + *	note that it will still contain the *old* settings.  The driver does
> + *	not need to update these; the core will do so if this op succeeds.
> + *	Returns a negative error code or zero. An error code must be returned
> + *	if at least one unsupported change was requested.
> + * @remove_rxfh_context: Remove the specified RSS context.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx.
> + *	Returns a negative error code or zero.
> + * @set_rxfh_context: Deprecated API to create, remove and configure RSS
> + *	contexts. Allows setting the contents of the RX flow hash indirection
> + *	table, hash key, and/or hash function associated to the given context.
> + *	Arguments which are set to %NULL or zero will remain unchanged.
>   *	Returns a negative error code or zero. An error code must be returned
>   *	if at least one unsupported change was requested.
>   * @get_channels: Get number of channels.
> @@ -901,6 +924,17 @@ struct ethtool_ops {
>  			    const u8 *key, const u8 hfunc);
>  	int	(*get_rxfh_context)(struct net_device *, u32 *indir, u8 *key,
>  				    u8 *hfunc, u32 rss_context);
> +	int	(*create_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       const u32 *indir, const u8 *key,
> +				       const u8 hfunc, u32 rss_context);
> +	int	(*modify_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       const u32 *indir, const u8 *key,
> +				       const u8 hfunc, u32 rss_context);
> +	int	(*remove_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       u32 rss_context);
>  	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,
>  				    const u8 *key, const u8 hfunc,
>  				    u32 *rss_context, bool delete);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 05e95abdfd17..637218adca22 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10882,16 +10882,23 @@ static void netdev_rss_contexts_free(struct net_device *dev)
>  	struct ethtool_rxfh_context *ctx;
>  	unsigned long context;
>  
> -	if (dev->ethtool_ops->set_rxfh_context)
> +	if (dev->ethtool_ops->create_rxfh_context ||
> +	    dev->ethtool_ops->set_rxfh_context)
>  		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
>  			u32 *indir = ethtool_rxfh_context_indir(ctx);
>  			u8 *key = ethtool_rxfh_context_key(ctx);
>  			u32 concast = context;
>  
>  			xa_erase(&dev->ethtool->rss_ctx, context);
> -			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
> -							   ctx->hfunc, &concast,
> -							   true);
> +			if (dev->ethtool_ops->create_rxfh_context)
> +				dev->ethtool_ops->remove_rxfh_context(dev, ctx,
> +								      context);
> +			else
> +				dev->ethtool_ops->set_rxfh_context(dev, indir,
> +								   key,
> +								   ctx->hfunc,
> +								   &concast,
> +								   true);
>  			kfree(ctx);
>  		}
>  	xa_destroy(&dev->ethtool->rss_ctx);
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 1d13bc8fbb75..c23d2bd3cd2a 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1274,7 +1274,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
>  		return -EINVAL;
>  	/* Most drivers don't handle rss_context, check it's 0 as well */
> -	if (rxfh.rss_context && !ops->set_rxfh_context)
> +	if (rxfh.rss_context && !(ops->create_rxfh_context ||
> +				  ops->set_rxfh_context))
>  		return -EOPNOTSUPP;
>  	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
>  
> @@ -1349,8 +1350,24 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  		ctx->indir_size = dev_indir_size;
>  		ctx->key_size = dev_key_size;
> -		ctx->hfunc = rxfh.hfunc;
>  		ctx->priv_size = ops->rxfh_priv_size;
> +		/* Initialise to an empty context */
> +		ctx->indir_no_change = ctx->key_no_change = 1;
> +		ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
> +		if (ops->create_rxfh_context) {
> +			u32 limit = dev->ethtool->rss_ctx_max_id ?: U32_MAX;
> +			u32 ctx_id;
> +
> +			/* driver uses new API, core allocates ID */
> +			ret = xa_alloc(&dev->ethtool->rss_ctx, &ctx_id, ctx,
> +				       XA_LIMIT(1, limit), GFP_KERNEL_ACCOUNT);
> +			if (ret < 0) {
> +				kfree(ctx);
> +				goto out;
> +			}
> +			WARN_ON(!ctx_id); /* can't happen */
> +			rxfh.rss_context = ctx_id;
> +		}
>  	} else if (rxfh.rss_context) {
>  		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
>  		if (!ctx) {
> @@ -1359,15 +1376,34 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  	}
>  
> -	if (rxfh.rss_context)
> -		ret = ops->set_rxfh_context(dev, indir, hkey, rxfh.hfunc,
> -					    &rxfh.rss_context, delete);
> -	else
> +	if (rxfh.rss_context) {
> +		if (ops->create_rxfh_context) {
> +			if (create)
> +				ret = ops->create_rxfh_context(dev, ctx, indir,
> +							       hkey, rxfh.hfunc,
> +							       rxfh.rss_context);
> +			else if (delete)
> +				ret = ops->remove_rxfh_context(dev, ctx,
> +							       rxfh.rss_context);
> +			else
> +				ret = ops->modify_rxfh_context(dev, ctx, indir,
> +							       hkey, rxfh.hfunc,
> +							       rxfh.rss_context);
> +		} else {
> +			ret = ops->set_rxfh_context(dev, indir, hkey,
> +						    rxfh.hfunc,
> +						    &rxfh.rss_context, delete);
> +		}
> +	} else {
>  		ret = ops->set_rxfh(dev, indir, hkey, rxfh.hfunc);
> +	}
>  	if (ret) {
> -		if (create)
> +		if (create) {
>  			/* failed to create, free our new tracking entry */
> +			if (ops->create_rxfh_context)
> +				xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
>  			kfree(ctx);
> +		}
>  		goto out;
>  	}
>  
> @@ -1383,12 +1419,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  			dev->priv_flags |= IFF_RXFH_CONFIGURED;
>  	}
>  	/* Update rss_ctx tracking */
> -	if (create) {
> -		/* Ideally this should happen before calling the driver,
> -		 * so that we can fail more cleanly; but we don't have the
> -		 * context ID until the driver picks it, so we have to
> -		 * wait until after.
> -		 */
> +	if (create && !ops->create_rxfh_context) {
> +		/* driver uses old API, it chose context ID */
>  		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
>  			/* context ID reused, our tracking is screwed */
>  			kfree(ctx);
> @@ -1400,8 +1432,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  			kfree(ctx);
>  			goto out;
>  		}
> -		ctx->indir_no_change = rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE;
> -		ctx->key_no_change = !rxfh.key_size;
>  	}
>  	if (delete) {
>  		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);

