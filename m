Return-Path: <netdev+bounces-114458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8B5942AA6
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02A01C2084A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB31AAE3F;
	Wed, 31 Jul 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyHUQIK1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C41AAE35;
	Wed, 31 Jul 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418520; cv=none; b=fE0Cygv2gbTqV0x2p9giTdiEuybqLVNBlEtJar8VYEalG1mCeh9yoSjTZOEfnvkIqMKyJaRho3dBMdVqHXPi8wFZB3FNSOVjqCFj9vcGrxpxEUiWrfqyRtX3FbwFQZFzkoxIMis9RQ0/6G/XEsgi8e1Q2vKtFhg0RpUcEgJxxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418520; c=relaxed/simple;
	bh=AmtVfHZDmiR2ybPvRkkSY/6FCf1yF5PpCzn/kf8sqeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZJfZrG4tB/Q+xXpwfAMPSRYqis6n1zs+ElNjmj+211VEN9XTcucSv4T4o77gJZkv92uymxWBjVRMwytittqceKpESwIMSxpBYgtrjGIGeAQ5wDo+G1cITxe/HXynOUKhZGJ2Ib5RMMP1Udzurk7QoYQMZ1wcw77cSnZdM75wV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyHUQIK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54537C116B1;
	Wed, 31 Jul 2024 09:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722418519;
	bh=AmtVfHZDmiR2ybPvRkkSY/6FCf1yF5PpCzn/kf8sqeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyHUQIK1Yr48049aXPDTDS7BwDk/UOsDxYUGSnwrKUSP1sqiFvYewVN7cD9SlvvHe
	 1Nz3ccDbmnFIEPS4CIUSumweNZ9UuN4k3CuGIDTwhlMLUSZKib7g/4OHBdWrOAGxFr
	 j6sFVfiru/nWUbYtWHjhVBTQ9bAXFXD5abX/XNjT6Oo7gf6WEm9povBLt29Ap9hMJb
	 wmFOgXwYFVl+r2ZzZGSqAnZUxeu/w5vDa8WHt6embjHC1tdfCZWxgOp9VrL+zgGW2R
	 2y11HQturAAieDC+3QqgWVIf+jfQ4blek3IQ3Fj6kE37fbDfmzbAotlOWpalk9F69T
	 XPP/N0TX64fkA==
Date: Wed, 31 Jul 2024 10:35:16 +0100
From: Simon Horman <horms@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net/chelsio/libcxgb: Add __percpu annotations to
 libcxgb_ppm.c
Message-ID: <20240731093516.GR1967603@kernel.org>
References: <20240730125856.7321-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730125856.7321-1-ubizjak@gmail.com>

On Tue, Jul 30, 2024 at 02:58:19PM +0200, Uros Bizjak wrote:
> Compiling libcxgb_ppm.c results in several sparse warnings:
> 
> libcxgb_ppm.c:368:15: warning: incorrect type in assignment (different address spaces)
> libcxgb_ppm.c:368:15:    expected struct cxgbi_ppm_pool *pools
> libcxgb_ppm.c:368:15:    got void [noderef] __percpu *_res
> libcxgb_ppm.c:374:48: warning: incorrect type in initializer (different address spaces)
> libcxgb_ppm.c:374:48:    expected void const [noderef] __percpu *__vpp_verify
> libcxgb_ppm.c:374:48:    got struct cxgbi_ppm_pool *
> libcxgb_ppm.c:484:19: warning: incorrect type in assignment (different address spaces)
> libcxgb_ppm.c:484:19:    expected struct cxgbi_ppm_pool [noderef] __percpu *pool
> libcxgb_ppm.c:484:19:    got struct cxgbi_ppm_pool *[assigned] pool
> libcxgb_ppm.c:511:21: warning: incorrect type in argument 1 (different address spaces)
> libcxgb_ppm.c:511:21:    expected void [noderef] __percpu *__pdata
> libcxgb_ppm.c:511:21:    got struct cxgbi_ppm_pool *[assigned] pool
> 
> Add __percpu annotation to *pools and *pool percpu pointers and to
> ppm_alloc_cpu_pool() function that returns percpu pointer to fix
> these warnings.
> 
> Compile tested only, but there is no difference in the resulting object file.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> index 854d87e1125c..01d776113500 100644
> --- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> +++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> @@ -342,10 +342,10 @@ int cxgbi_ppm_release(struct cxgbi_ppm *ppm)
>  }
>  EXPORT_SYMBOL(cxgbi_ppm_release);
>  
> -static struct cxgbi_ppm_pool *ppm_alloc_cpu_pool(unsigned int *total,
> -						 unsigned int *pcpu_ppmax)
> +static struct cxgbi_ppm_pool __percpu *ppm_alloc_cpu_pool(unsigned int *total,
> +							  unsigned int *pcpu_ppmax)

Let's keep to less than 80 columns wide, as is still preferred for
Networking code. Perhaps in this case:

static struct cxgbi_ppm_pool __percpu *
ppm_alloc_cpu_pool(unsigned int *total, unsigned int *pcpu_ppmax)

Also, I do observe that this is an old driver, so the value
of cleaning it is perhaps limited.

But the above aside, this looks good to me.

>  {
> -	struct cxgbi_ppm_pool *pools;
> +	struct cxgbi_ppm_pool __percpu *pools;
>  	unsigned int ppmax = (*total) / num_possible_cpus();
>  	unsigned int max = (PCPU_MIN_UNIT_SIZE - sizeof(*pools)) << 3;
>  	unsigned int bmap;

