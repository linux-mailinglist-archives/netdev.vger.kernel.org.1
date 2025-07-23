Return-Path: <netdev+bounces-209367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656FDB0F66D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912467BB822
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60253301127;
	Wed, 23 Jul 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpwOIKvK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F232FEE3A;
	Wed, 23 Jul 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282461; cv=none; b=cjzn4OvRjQ124g4JngPO9MZ8L0EAWjU5EVNJH0lfRxt0TE95CRi5GvqOtXIZwd+Xs70d5HsYVVhwH0kCWjYjovtmw46W9P4OfNIfGbjvUxhQShCRTUlnpPhaptWyTwGcsTZ4pUKcURqxD+eJxe5I8fL5JkVGcqe7X4Dv1fnF4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282461; c=relaxed/simple;
	bh=TionPmrd2VrfHI4NgYA2/KWHwkD1LEDfhxeY2hPKkrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD8dnvKLd1dGofWBeBNQnyD6Dgc+HlUoVXoXIwGsm6UWhvgUOjyipxaZEAOZzPDriIy+E5Z+kMzswxHOsHx1JzHmYQN8tK5g2n0pN/WxpjH1iT0Osfvfs2qB2fcH/nJR0Nn59ENyg5BOwggwkwO6ZggDLCgkhtyOR68vZTVb3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpwOIKvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED63C4CEFA;
	Wed, 23 Jul 2025 14:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282455;
	bh=TionPmrd2VrfHI4NgYA2/KWHwkD1LEDfhxeY2hPKkrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpwOIKvK5DliUM7TmPe29jzWYrCqLfIlVEGxdG4XcEJxYPkJb4g/amL26BwbJuF0K
	 pv08T/OLPVHoE7/RqALutIGWGdMEvRR24bQZGZtmpRTt86F0cVI2TSFkbOnCsqwiiv
	 mnlqwDk8Pzh1+AABVZNLZoxpEx+EYrNQ5x3aidn7274r+n+OSXEzFv+6BvFzTvXMRC
	 wE+Vvwcg1YGTbsWtVXQPEPnMx1DrgxCarEaTHV3Q8hLa3Yk7MB4kbPXpgd6Q+zBTuo
	 yGR8OBMqZGITPugzjNe8J5jCfv1ryJv7w5OVSJMFIipr5eNfur97PpXs1CKBzWLSba
	 L40o1/LrPRFkw==
Date: Wed, 23 Jul 2025 15:54:11 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: add support for strings with
 new line in netpoll_parse_ip_addr
Message-ID: <20250723144933.GA1036606@horms.kernel.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
 <20250721-netconsole_ref-v2-3-b42f1833565a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-netconsole_ref-v2-3-b42f1833565a@debian.org>

On Mon, Jul 21, 2025 at 06:02:03AM -0700, Breno Leitao wrote:
> The current IP address parsing logic fails when the input string
> contains a trailing newline character. This can occur when IP
> addresses are provided through configfs, which contains newlines in
> a const buffer.
> 
> Teach netpoll_parse_ip_addr() how to ignore newlines at the end of the
> IPs. Also, simplify the code by:
> 
>  * No need to check for separators. Try to parse ipv4, if it fails try
>    ipv6 similarly to ceph_pton()
>  * If ipv6 is not supported, don't call in6_pton() at all.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

My suggestion below not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/netconsole.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 8d1b93264e0fd..f2c2b8852c603 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -303,20 +303,21 @@ static void netconsole_print_banner(struct netpoll *np)
>  static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
>  {
>  	const char *end;
> +	int len;
>  
> -	if (!strchr(str, ':') &&
> -	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
> -		if (!*end)
> -			return 0;
> -	}
> -	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
> -#if IS_ENABLED(CONFIG_IPV6)
> -		if (!*end)
> -			return 1;
> -#else
> +	len = strlen(str);
> +	if (!len)
>  		return -1;
> +
> +	if (str[len - 1] == '\n')
> +		len -= 1;
> +
> +	if (in4_pton(str, len, (void *)addr, -1, &end) > 0)
> +		return 0;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (in6_pton(str, len, addr->in6.s6_addr, -1, &end) > 0)
> +		return 1;
>  #endif

I don't think it needs to block progress.
But FWIIW, I think it would be nice to increase
build coverage and express this as:

	if (IS_ENABLED(CONFIG_IPV6) &&
	    in6_pton(str, len, addr->in6.s6_addr, -1, &end) > 0)
		return 1;


