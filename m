Return-Path: <netdev+bounces-210195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008EBB125BB
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3854017AE84
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA3425A352;
	Fri, 25 Jul 2025 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmazIgE/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B34501A;
	Fri, 25 Jul 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476146; cv=none; b=YekJ+uH6pSSFK12gJTaZCQqvhwMM7NMzRiCSGVDq0bSyVtWN6FrwwPzkdx4XXFH7+Hm3frurkOTbtXyrX31ZP+FhyG23KTVQyoZBrgFetiBYB8GGG1VzLcufk6oppDRlH8EgCwiuuvEdm2Fyp7hQfC0Xn4Awngfhtl7e3Jun9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476146; c=relaxed/simple;
	bh=fZBV4lqYU38UGMYRXZ6zg+bQ+0ziMRfZaHfcZtGIR5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvRG+gI87iBCQsjuo+NZS+f+TDjxdkGUmbt7kSbM2FBrt1VIZl5HNZW6Lt6uj22Q6b7yh9iwgSG63xp3+YhnPrf3KAMqIExsnEwuC6VkSDC8ElyzNaZpyRkcxcfhthXmLKn9Gk6wuVxJT199FYmWa/Ue/PGzb207odU247ebaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmazIgE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0872FC4CEE7;
	Fri, 25 Jul 2025 20:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753476145;
	bh=fZBV4lqYU38UGMYRXZ6zg+bQ+0ziMRfZaHfcZtGIR5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YmazIgE/oKWPCKoPTxj8Wt6E/SU3L/MsT36MEbgXjBG9pKgeAi94ulH0+jvPxDCg+
	 Cs35kvvPfqFeJhoZmv+aEQe2EYG5w4XNvIeUlBx9IvSWk8GYn0mwuetS131ge2ZJJx
	 amhRR34vrk6SIyyNCKpJZlvl7yfM3I99LkpC1M5q1tcN6PAgXZ5Qpp/gFtHYkLSTxG
	 nNuBMWz0k3BItJi9wbWT3v+oAWsKLH+6kAcQAUlQrHTTuNIuULWpRoZJ5Ju1u3QCwX
	 ozLS+MDsGG2CsNK7ALsUGNuthDRAj7BW0P/GxwV9ZVsKhM1+bW1NV5uFAOWAmSJ7/P
	 qpA+OVeFsfvfQ==
Date: Fri, 25 Jul 2025 13:42:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 3/5] netconsole: add support for strings
 with new line in netpoll_parse_ip_addr
Message-ID: <20250725134224.0a2da8e7@kernel.org>
In-Reply-To: <20250723-netconsole_ref-v3-3-8be9b24e4a99@debian.org>
References: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
	<20250723-netconsole_ref-v3-3-8be9b24e4a99@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 10:20:31 -0700 Breno Leitao wrote:
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
> -#endif
> -	}
> +
> +	if (str[len - 1] == '\n')
> +		len -= 1;
> +
> +	if (in4_pton(str, len, (void *)addr, -1, &end) > 0)
> +		return 0;
> +	if (IS_ENABLED(CONFIG_IPV6) &&
> +	    in6_pton(str, len, addr->in6.s6_addr, -1, &end) > 0)
> +		return 1;
>  	return -1;

Looks like we're removing the validation for reaching the end of 
the buffer? This should at least be explained in the commit message.
AFAICT for IPv4 for example 1.2.3.4:xyz would have been rejected,
now it's accepted. Personally I find the

	if (*end && *end != '\n')

removed by subsequent patch cleaner than modifying the input string.

I'll apply the first patch of the series..

