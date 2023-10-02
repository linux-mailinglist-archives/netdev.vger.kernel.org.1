Return-Path: <netdev+bounces-37366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793A7B507F
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EBA59282309
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76693612E;
	Mon,  2 Oct 2023 10:41:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFB1C02
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:41:38 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95DFAB
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 03:41:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32615eaa312so2646933f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696243295; x=1696848095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7quwRWs76L/z6Kn5iBcvr2vjzU4Ukun02KBPiWYsn8I=;
        b=iLvFoz8v91gmRd4njbEL+wBesCoTybJoIcbOG+1q3btbI1wx/VyjiJwZgcsc4XkETv
         6ldh9Ki91DdGPwA/QkTzGijqUbz9Rf7+a7z9J8nGRAjdbmZ4pAj+RsSRHuBbW3RvzjTD
         GojSE9PM5MVHulo1ylZsw3tFEXZO/WTSjyVs19YQDXYV7l/O6tmfkYzmlPW6aQEUs3/i
         ZY2uI7E7nhwCIjh1+Uh7zc3kFmjJ6dMVGi16pdmWLsXsvbW1vRwZdIGQxzxO97zXVl7P
         HSU689dbKLuPBzZRNevIYECNIFkkPgIfTPMbevxrYfwPVv8pVZVA4mts/8045MMo3RQH
         HbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696243295; x=1696848095;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7quwRWs76L/z6Kn5iBcvr2vjzU4Ukun02KBPiWYsn8I=;
        b=RUdljYA5kM//OZjl7uU08KEqTfyXE0QUO7gb5eagYEI1MDOWelGLRFipRL3cx8+VpP
         DZi6yPSkIMdpxlJsirCaJpZMiZ1DwfQu0gd9CUhgnLdreEdDuK34TnEdYi8Jo2JSJF6A
         oVZPSF1eDjU+Kj5GpsPy26B9gXHSOwXnJFqsMJ4nKqmlAPTK36xXg7VpSQfiGsup9+Fy
         IJF4uley/yknL0cNPaZnK2UqGnZmaMH46KDGEjOrK0ZQF0km093gfGTCnp/4zm6AGlEu
         anl//BQxOFGnq9d7yNovW5N+jD+ygELN2iAIT1zKWaOBO6HNq41M5/j1b1+bMLsVeXaX
         py2g==
X-Gm-Message-State: AOJu0Yx8Quw+IO+KSW4Wabauf79J3OuXCW3JrAfOj5TjCjzhsKtfTvqi
	8G5aQt9vTMMRB3EpK3s+BTc=
X-Google-Smtp-Source: AGHT+IGpxD5INSIUK+b8Lcg+/f9VVVEs/beGo1hB1aGQah4StdBfjPjmbIX7ZBvdqSyT746VtaC8bQ==
X-Received: by 2002:a05:6000:136b:b0:320:9fa:d928 with SMTP id q11-20020a056000136b00b0032009fad928mr8626083wrz.68.1696243294983;
        Mon, 02 Oct 2023 03:41:34 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id n16-20020a7bcbd0000000b0040531f5c51asm6996561wmi.5.2023.10.02.03.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 03:41:34 -0700 (PDT)
Date: Mon, 2 Oct 2023 11:41:32 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
	mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	saeedm@nvidia.com, leon@kernel.org
Subject: Re: [PATCH v4 net-next 3/7] net: ethtool: record custom RSS contexts
 in the XArray
Message-ID: <20231002104132.GC21694@gmail.com>
Mail-Followup-To: edward.cree@amd.com, linux-net-drivers@amd.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com,
	leon@kernel.org
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <97db46739ad095e0ed50f0dbd90e1b506c2991de.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97db46739ad095e0ed50f0dbd90e1b506c2991de.1695838185.git.ecree.xilinx@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 07:13:34PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Since drivers are still choosing the context IDs, we have to force the
>  XArray to use the ID they've chosen rather than picking one ourselves,
>  and handle the case where they give us an ID that's already in use.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  include/linux/ethtool.h | 14 ++++++++
>  net/ethtool/ioctl.c     | 73 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index bb11cb2f477d..229a23571008 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -194,6 +194,17 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
>  	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
>  }
>  
> +static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
> +					       u16 priv_size)
> +{
> +	size_t indir_bytes = array_size(indir_size, sizeof(u32));
> +	size_t flex_len;
> +
> +	flex_len = size_add(size_add(indir_bytes, key_size),
> +			    ALIGN(priv_size, sizeof(u32)));
> +	return struct_size((struct ethtool_rxfh_context *)0, data, flex_len);
> +}
> +
>  /* declare a link mode bitmap */
>  #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
>  	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
> @@ -731,6 +742,8 @@ struct ethtool_mm_stats {
>   *	will remain unchanged.
>   *	Returns a negative error code or zero. An error code must be returned
>   *	if at least one unsupported change was requested.
> + * @rxfh_priv_size: size of the driver private data area the core should
> + *	allocate for an RSS context.

An odd place to push the documentation. Please keep the ordering the same
as the struct has below.

Martin

>   * @get_rxfh_context: Get the contents of the RX flow hash indirection table,
>   *	hash key, and/or hash function assiciated to the given rss context.
>   *	Returns a negative error code or zero.
> @@ -824,6 +837,7 @@ struct ethtool_ops {
>  	u32     cap_link_lanes_supported:1;
>  	u32	supported_coalesce_params;
>  	u32	supported_ring_params;
> +	u16	rxfh_priv_size;
>  	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
>  	int	(*get_regs_len)(struct net_device *);
>  	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index de78b24fffc9..1d13bc8fbb75 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1249,6 +1249,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  {
>  	int ret;
>  	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct ethtool_rxfh_context *ctx = NULL;
>  	struct ethtool_rxnfc rx_rings;
>  	struct ethtool_rxfh rxfh;
>  	u32 dev_indir_size = 0, dev_key_size = 0, i;
> @@ -1256,7 +1257,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	u8 *hkey = NULL;
>  	u8 *rss_config;
>  	u32 rss_cfg_offset = offsetof(struct ethtool_rxfh, rss_config[0]);
> -	bool delete = false;
> +	bool create = false, delete = false;
>  
>  	if (!ops->get_rxnfc || !ops->set_rxfh)
>  		return -EOPNOTSUPP;
> @@ -1275,6 +1276,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	/* Most drivers don't handle rss_context, check it's 0 as well */
>  	if (rxfh.rss_context && !ops->set_rxfh_context)
>  		return -EOPNOTSUPP;
> +	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
>  
>  	/* If either indir, hash key or function is valid, proceed further.
>  	 * Must request at least one change: indir size, hash key or function.
> @@ -1332,13 +1334,42 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  	}
>  
> +	if (create) {
> +		if (delete) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		ctx = kzalloc(ethtool_rxfh_context_size(dev_indir_size,
> +							dev_key_size,
> +							ops->rxfh_priv_size),
> +			      GFP_KERNEL_ACCOUNT);
> +		if (!ctx) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		ctx->indir_size = dev_indir_size;
> +		ctx->key_size = dev_key_size;
> +		ctx->hfunc = rxfh.hfunc;
> +		ctx->priv_size = ops->rxfh_priv_size;
> +	} else if (rxfh.rss_context) {
> +		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
> +		if (!ctx) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +	}
> +
>  	if (rxfh.rss_context)
>  		ret = ops->set_rxfh_context(dev, indir, hkey, rxfh.hfunc,
>  					    &rxfh.rss_context, delete);
>  	else
>  		ret = ops->set_rxfh(dev, indir, hkey, rxfh.hfunc);
> -	if (ret)
> +	if (ret) {
> +		if (create)
> +			/* failed to create, free our new tracking entry */
> +			kfree(ctx);
>  		goto out;
> +	}
>  
>  	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, rss_context),
>  			 &rxfh.rss_context, sizeof(rxfh.rss_context)))
> @@ -1351,6 +1382,44 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
>  			dev->priv_flags |= IFF_RXFH_CONFIGURED;
>  	}
> +	/* Update rss_ctx tracking */
> +	if (create) {
> +		/* Ideally this should happen before calling the driver,
> +		 * so that we can fail more cleanly; but we don't have the
> +		 * context ID until the driver picks it, so we have to
> +		 * wait until after.
> +		 */
> +		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
> +			/* context ID reused, our tracking is screwed */
> +			kfree(ctx);
> +			goto out;
> +		}
> +		/* Allocate the exact ID the driver gave us */
> +		if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh.rss_context,
> +				       ctx, GFP_KERNEL))) {
> +			kfree(ctx);
> +			goto out;
> +		}
> +		ctx->indir_no_change = rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE;
> +		ctx->key_no_change = !rxfh.key_size;
> +	}
> +	if (delete) {
> +		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);
> +		kfree(ctx);
> +	} else if (ctx) {
> +		if (indir) {
> +			for (i = 0; i < dev_indir_size; i++)
> +				ethtool_rxfh_context_indir(ctx)[i] = indir[i];
> +			ctx->indir_no_change = 0;
> +		}
> +		if (hkey) {
> +			memcpy(ethtool_rxfh_context_key(ctx), hkey,
> +			       dev_key_size);
> +			ctx->key_no_change = 0;
> +		}
> +		if (rxfh.hfunc != ETH_RSS_HASH_NO_CHANGE)
> +			ctx->hfunc = rxfh.hfunc;
> +	}
>  
>  out:
>  	kfree(rss_config);

