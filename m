Return-Path: <netdev+bounces-230157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C48BE4B02
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6FB1A67ED2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B9342C82;
	Thu, 16 Oct 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBxxco9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813B32AAD0
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633398; cv=none; b=Hy+nJiIjjIEkJY4H/T9spxC4v/wj+2Y+x+W8kpwM5byoE6NvFkISjbyIJ2dTfX/jvVIySPQIpenB9rb0GWatmVzzi7hK0pKMshd0Jbs8D+NUyR1/W6gcMYvSI3EQwbvT38JgQ77T97/DIsZ/glhygVENesQPu45a4CngJHpvFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633398; c=relaxed/simple;
	bh=zz9Onj4d7fz9ephRZjwoe1tAcV73+b8APC+xpE3g010=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/afiWnNsH+CzU4pWHf1F3KJUQaMv8ZbS8dd9BFpy2hbuJITxVd+pMup/t2uU0y+qZ0XKknLhCi5zGpwiLDd6jWzuXRTZ9jye0Hy+dhpZpHJBw9rmPAcJg19UaCWBeKfLw5a/E87f7voDD9lglfpGdpVdIcz0BTDYUW+woQq1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBxxco9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BADC4CEF1;
	Thu, 16 Oct 2025 16:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760633398;
	bh=zz9Onj4d7fz9ephRZjwoe1tAcV73+b8APC+xpE3g010=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBxxco9z27NcsSg317fF3lrMguzSeFFzZYjzgHiyUoiUAj8ywQuhnTJXdCUNdZw4O
	 9+ap03YmZSc1v6R1fREuLyj2hJszt2qlJ+vhhtBENVej3Cw5msY0vZqeielQgmL4jP
	 1KwJ4NWOe6aufAp9dz+APv82vOnRHw1kCxnovU13m7mTUeazOUtBcfONTRfQTCizlG
	 UkC//Tj93JZKVurHFbHMN+++5W//GBDe3mLhGcmK4OsRCff/mNO2Wsi+HkrFRvrNsO
	 Ptsp1Z+iv4fQZNJxUFkGLbSOY0tHzcmyqfWXI3i6iI2gxj0XgE7V02dzc+8aBEG+jx
	 ISW5SE0SMUObg==
Date: Thu, 16 Oct 2025 17:49:54 +0100
From: Simon Horman <horms@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH] net :ethernet : replace cleanup_module with __exit()
Message-ID: <aPEiMgvd2QM59nvu@horms.kernel.org>
References: <20251016115113.43986-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016115113.43986-1-i.shihao.999@gmail.com>

On Thu, Oct 16, 2025 at 05:21:13PM +0530, Shi Hao wrote:
> update old legacy cleanup_module function from the file
> with __exit module as per kernel code practices.
> 
> The file had an old cleanup_module function still in use
> which could be updated with __exit function all though its
> init_module is indeed newer however the cleanup_module
> was still using the older version of exit.
> 
> To set proper exit module function replace cleanup_module
> with __exit() corkscrew_exit_module to align it to the
> kernel code consistency.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> ---
>  drivers/net/ethernet/3com/3c515.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/3com/3c515.c b/drivers/net/ethernet/3com/3c515.c
> index ecdea58e6a21..4f8cd5a6ee68 100644
> --- a/drivers/net/ethernet/3com/3c515.c
> +++ b/drivers/net/ethernet/3com/3c515.c
> @@ -1547,9 +1547,7 @@ static const struct ethtool_ops netdev_ethtool_ops = {
>  	.set_msglevel		= netdev_set_msglevel,
>  };
> 
> -
> -#ifdef MODULE
> -void cleanup_module(void)
> +static void __exit corkscrew_exit_module(void)
>  {
>  	while (!list_empty(&root_corkscrew_dev)) {
>  		struct net_device *dev;
> @@ -1563,4 +1561,4 @@ void cleanup_module(void)
>  		free_netdev(dev);
>  	}
>  }
> -#endif				/* MODULE */
> +module_exit(corkscrew_exit_module);

Hi Shi Hao,

Thanks for your patch.

Unfortunately this does not compile as a built-in because
is only defined (and initialised) when this driver is configured as a module.

I was able to verify this using a configuration generated like this:

ARCH=arm make footbridge_defconfig
echo "CONFIG_3C515=y" >> .config
ARCH=arm make oldconfig

And building using the GCC 15.2.0 toolchain available here
https://mirrors.edge.kernel.org/pub/tools/crosstool/


Also, looking at git history, I think that '3c515:' would be an
appropriate prefix for this patch.

Subject: [PATCH net-next v2] 3c515: ...


And if you do post an update, please be sure to observe the 24h rule.
https://docs.kernel.org/process/maintainer-netdev.html

Thanks!

-- 
pw-bot: changes-requested

