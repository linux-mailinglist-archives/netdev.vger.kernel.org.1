Return-Path: <netdev+bounces-139723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100019B3E81
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C481C214FA
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43BA1F7579;
	Mon, 28 Oct 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOM+g88t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C021F4286;
	Mon, 28 Oct 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158492; cv=none; b=kR7pHDcMm1xHLZzt0hI541159YAY0+sOSCVOCtZK7Y9VnfOm5RF0oFPltXOLDJRYnmuBUCLH6EAO0menO8kv9FYcDCiz5elpeKBh2SFj882pvmc08GVFPeQ4LLaGjhMCgMuz903Ij6r8EaA+UcouNYqhd8ZvvRtkYMPMR+pdBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158492; c=relaxed/simple;
	bh=apQKOmGLkmBP82U+lwpCIEeDglE6lgUSIRXJWbRQD9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXaB7oYu1e3xj7Eqcr9heNq8IqmjOccsEOiblMj6femmnhs8SPLhoPZSUcfd6JStgpvMAW17REgpX6J6LL1KyYq1ifqwWvYE7TGYAcsZgaO9c2zeeEkCy/iAKHV1dPmgKdGJ7dKrg1zd1BtdSBI5doAWrOFhT8S8XFvFNaEogrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOM+g88t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E83C4CEC3;
	Mon, 28 Oct 2024 23:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158492;
	bh=apQKOmGLkmBP82U+lwpCIEeDglE6lgUSIRXJWbRQD9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOM+g88t8uOVqb69/ktqvuQhzWXjNm/qgWZEeE5Q/NVo0Lbbc3MUe05BwAkPedNeF
	 jKPzd2GuHMKQC5VilQvpE7yrLtDTTvvQwG9EeScAZH/Blx9Ghi4t5Zt6FJWufIDKPT
	 8v02lKBksWsmHP5pJjfNvaTpQIrUG8k046HMH3JKApJXyhF73+KdEbrrU/vIZsW0/y
	 vw1Xo1BncCt4QO7W5CLJkdtlrIxeKyug+pOFSOECBrMgxrNU9+SSI70uH+T+ysm9we
	 q8cjmFTj6tDfYmx3E5/lACI0u3DOE4NDavtAV6VvXX/9qC1yPC2D1THZjSteDIFfXt
	 DFEFDueBfLn2Q==
Date: Mon, 28 Oct 2024 16:34:48 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 1/4][next] uapi: socket: Introduce struct
 sockaddr_legacy
Message-ID: <202410281632.1AFBD73@keescook>
References: <cover.1729802213.git.gustavoars@kernel.org>
 <23bd38a4bf024d4a92a8a634ddf4d5689cd3a67e.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23bd38a4bf024d4a92a8a634ddf4d5689cd3a67e.1729802213.git.gustavoars@kernel.org>

On Thu, Oct 24, 2024 at 03:11:24PM -0600, Gustavo A. R. Silva wrote:
> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
> index d3fcd3b5ec53..2e179706bec4 100644
> --- a/include/uapi/linux/socket.h
> +++ b/include/uapi/linux/socket.h
> @@ -35,4 +35,32 @@ struct __kernel_sockaddr_storage {
>  #define SOCK_TXREHASH_DISABLED	0
>  #define SOCK_TXREHASH_ENABLED	1
>  
> +typedef __kernel_sa_family_t    sa_family_t;
> +
> +/*
> + * This is the legacy form of `struct sockaddr`. The original `struct sockaddr`
> + * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible
> + * array in struct sockaddr") due to the fact that "One of the worst offenders
> + * of "fake flexible arrays" is struct sockaddr". This means that the original
> + * `char sa_data[14]` behaved as a flexible array at runtime, so a proper
> + * flexible-array member was introduced.
> + *
> + * This caused several flexible-array-in-the-middle issues:
> + * https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wflex-array-member-not-at-end
> + *
> + * `struct sockaddr_legacy` replaces `struct sockaddr` in all instances where
> + * objects of this type do not appear at the end of composite structures.
> + */
> +struct sockaddr_legacy {
> +        sa_family_t     sa_family;      /* address family, AF_xxx       */
> +        char            sa_data[14];    /* 14 bytes of protocol address */
> +};
> +
> +#ifdef __KERNEL__
> +#	define __kernel_sockaddr_legacy		sockaddr_legacy
> +#else
> +#	define __kernel_sockaddr_legacy		sockaddr
> +#endif

Yeah, this matches what I'd expect.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

