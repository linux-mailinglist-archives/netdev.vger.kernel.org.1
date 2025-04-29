Return-Path: <netdev+bounces-186775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE59FAA1084
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E2F46761C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36801D54E2;
	Tue, 29 Apr 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clfhUb7U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62E6AD3
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940695; cv=none; b=TeOrfxgAeyuxdcIAzsoLpXgIu7u4H3KSHJz9VAE5pEnfZ1R6VWZa6cVV4XG8nUPIW91Qs1BhnBPGMmcX4W80Fstw71a7blZw8BUBM/cBTNx+dNR13Sxp/9wcvql6vPs05Wi78Sk4b76lJRQwmCcelppU0cQF85Wy15Enp7Zj/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940695; c=relaxed/simple;
	bh=WlupN3FmAoq3xKkX0aMTLQLON9A1SvzwmHll4O8Gg0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFoIE8MCwQuKdquPtzYzunmehBbMWdkZeQM0VeF5B6mZGh6F7pndHLs7O5NDqIS61SUdM9AtqTTaeQBDT+Yt/2gVWszbA7jsVeF/RhGnHYVy2LtOWDoDsnUat3OSJP5cXNoUEdQOYnDWMzTjCChA2bxon1Aug8PuQ77NfK/fXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clfhUb7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E47C4CEE3;
	Tue, 29 Apr 2025 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745940694;
	bh=WlupN3FmAoq3xKkX0aMTLQLON9A1SvzwmHll4O8Gg0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=clfhUb7UBrBsEEGbh34e33UA6Aaq2lJYSq5/G7/cbm/3Ehnrb21GRBxQjNLKx4EkL
	 xKNUFVurYqdBFynA95F56UHoEoJVxkJrVWPabTbzyVjeBNbA73NJ5EQ1PHRnU0rUZH
	 oa7dZCAic8rd1lvvNkfNBInmXfBvyuuqAZEJsMa8+Q8SVVLNhD9YHnlP4ZFPqOEXnm
	 LpP1PjkF/u12HFjBYb98dm9kcrKh+F4V7EGLN0Z6zxJHA9i7Nowk2YOwuGVZ1kHM/L
	 fIU71Ng8LO63E1vXIzmy+SNOaYB94PxsdkNH4nUJJ5QTOUazq73Xt8eOhJ6SmbzbXW
	 OR/SdCa0Wyh8g==
Message-ID: <86cf6035-c6d9-462c-9a9c-42a6d0368069@kernel.org>
Date: Tue, 29 Apr 2025 09:31:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next] ipv6: Restore fib6_config validation for
 SIOCADDRT.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
 Yi Lai <yi1.lai@linux.intel.com>
References: <20250429014624.61938-1-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250429014624.61938-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/25 6:46 PM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index d0351e95d916..4c1e86e968f8 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -4496,6 +4496,53 @@ void rt6_purge_dflt_routers(struct net *net)
>  	rcu_read_unlock();
>  }
>  
> +static int fib6_config_validate(struct fib6_config *cfg,
> +				struct netlink_ext_ack *extack)
> +{
> +	/* RTF_PCPU is an internal flag; can not be set by userspace */
> +	if (cfg->fc_flags & RTF_PCPU) {
> +		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
> +		goto errout;
> +	}
> +
> +	/* RTF_CACHE is an internal flag; can not be set by userspace */
> +	if (cfg->fc_flags & RTF_CACHE) {
> +		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
> +		goto errout;
> +	}
> +
> +	if (cfg->fc_type > RTN_MAX) {
> +		NL_SET_ERR_MSG(extack, "Invalid route type");
> +		goto errout;
> +	}
> +
> +	if (cfg->fc_dst_len > 128) {
> +		NL_SET_ERR_MSG(extack, "Invalid prefix length");
> +		goto errout;
> +	}
> +
> +#ifdef CONFIG_IPV6_SUBTREES
> +	if (cfg->fc_src_len > 128) {
> +		NL_SET_ERR_MSG(extack, "Invalid source address length");
> +		goto errout;
> +	}
> +
> +	if (cfg->fc_nh_id &&  cfg->fc_src_len) {

extra space after '&&'



Reviewed-by: David Ahern <dsahern@kernel.org>


