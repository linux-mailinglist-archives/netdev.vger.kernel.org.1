Return-Path: <netdev+bounces-201306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F962AE8D07
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9B3189F71E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCB2D6624;
	Wed, 25 Jun 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUyox+Np"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D92D6609;
	Wed, 25 Jun 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877535; cv=none; b=UKCkQ55GmHtIZZezT6x/uB1YkbkPQFXEuDbJh6AB1zL6tgPeF0WFZ+TsusIfe29sHjp4IL6KAVoCeYar2IAlQKibMJeAm4V34yueYIaAr/I3RLvM8xafDrYRJoXYVnXRVvd3HNjaaXC1d/focToBXGB8G8LP82i2nc5vtvOAmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877535; c=relaxed/simple;
	bh=GkVnlqVkAye4yXjauRBS/JeSr3LmYvqjN29JouZxFY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRwX8HdzGj4l8BswXrlwPptIxMqUJvIczcxjCbp6KKyTrKu4IaDqncxfgBkyoiOivVIOWxqiGYzQx/T0PNfVoHjvd67NH0MF20ecyd+YvMj+1qQup09zx0aISPIYkt32t9BQo7+0q0WJ+yfWNH3ShR1EOq0d9MncapBbTPN9LPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUyox+Np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFDEC4CEEA;
	Wed, 25 Jun 2025 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750877534;
	bh=GkVnlqVkAye4yXjauRBS/JeSr3LmYvqjN29JouZxFY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUyox+NpDmcHchhnGXShAdsGOCywLrLKQyXow2Vku7lnYd4ZOK/8Zcrun1jjnRTuu
	 ap5MIVKfqy5OT4jgmJLP0me3SG+iWGxiZLVbxl8kpSoR1oZtOYmre1t68unrftOx/S
	 rdxmQ78FYCg/Xzc4mKRkBPaa02n6NfORt+M30SOIkC56eNN4fUz+HkIn2g9hfubfYY
	 LNClS/UX1mZCh8ELACtIqFazqcT+er++KKwRLonWKUWjDGOYTjgzIgPUY1PyTa+dbo
	 Doq90eB46/FkbI8fnfMy+tPXP3GJitlHquYZelKNZ9aKzShqlcFFj0gTM9XonAuRbj
	 yv1KCy+esvTlA==
Date: Wed, 25 Jun 2025 19:52:11 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] lwtunnel: Add lwtunnel_encap_type_check() helper
Message-ID: <20250625185211.GN1562@horms.kernel.org>
References: <20250625102413.483743-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625102413.483743-1-yuehaibing@huawei.com>

On Wed, Jun 25, 2025 at 06:24:13PM +0800, Yue Haibing wrote:
> Consolidate encap_type check to dedicated helper for code clean.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/core/lwtunnel.c | 46 ++++++++++++++++++++++-----------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> index f9d76d85d04f..f9453f278715 100644
> --- a/net/core/lwtunnel.c
> +++ b/net/core/lwtunnel.c
> @@ -79,10 +79,18 @@ EXPORT_SYMBOL_GPL(lwtunnel_state_alloc);
>  static const struct lwtunnel_encap_ops __rcu *
>  		lwtun_encaps[LWTUNNEL_ENCAP_MAX + 1] __read_mostly;
>  
> +static inline int lwtunnel_encap_type_check(unsigned int encap_type)

Please don't use the inline keyword in .c files unless there
is a demonstratable - usually performance - reason to do so.
Which I don't think that is hte case here.

Rather, let the compiler inine functions as it sees fit.

> +{
> +	if (encap_type == LWTUNNEL_ENCAP_NONE ||
> +	    encap_type > LWTUNNEL_ENCAP_MAX)
> +		return -EINVAL;
> +	return 0;
> +}
> +

I'm not entirely sure if this change is worth the churn.
But if it is, perhaps a helper of the following form is simpler.

(Completely untested!)

static bool lwtunnel_encap_type_invalid(unsigned int encap_type)
{
	return encap_type == LWTUNNEL_ENCAP_NONE ||
	       encap_type > LWTUNNEL_ENCAP_MAX;
}


>  int lwtunnel_encap_add_ops(const struct lwtunnel_encap_ops *ops,
>  			   unsigned int num)
>  {
> -	if (num > LWTUNNEL_ENCAP_MAX)
> +	if (lwtunnel_encap_type_check(num) < 0)

Which can then be used like this:

	if (lwtunnel_encap_type_invalid(num))

>  		return -ERANGE;
>  
>  	return !cmpxchg((const struct lwtunnel_encap_ops **)

...

-- 
pw-bot: changes-requested

