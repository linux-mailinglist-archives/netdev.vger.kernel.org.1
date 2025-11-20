Return-Path: <netdev+bounces-240213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9166CC718E4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 406894E1EC2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501CD1A294;
	Thu, 20 Nov 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3UPRbBN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D121862;
	Thu, 20 Nov 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763598755; cv=none; b=AVlo+zqj/idxksHQ+IJQpymKcA/YiBxI59it4DpaiBWYbp4J6FcoDVAftloRwfSjvU7pox2LkLOnai73fTbvNWxhBzk4b65gUj9+InrMHLDl4b7QcM5UpRO1i556FvIJ/6UbxRgMX/DZcjZhCQRvcO/q7XoMDfILdBuTOxNhJKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763598755; c=relaxed/simple;
	bh=1VFUXTf1H+UnGLtwStE54hDmLh6dZbbREG4rbaAFuV8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ag6h8tNp3zD4nlvByyUIIWZVNEr0VsH/e626ZAz4l6xT2GXTnM2mU6Wv5jfN97iIgIUY/cnkqYLs7Wz9eGTUY9+HvkSflDQe44dG9ghh1cYklT9SFKaoMm4Sq/aWv3WgbltFjp7TEMfoQHTIM7fcukZqbdPAKQD+9YzHKuyKKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3UPRbBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCB7C4CEF5;
	Thu, 20 Nov 2025 00:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763598754;
	bh=1VFUXTf1H+UnGLtwStE54hDmLh6dZbbREG4rbaAFuV8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=d3UPRbBN1KJSKGjiY55r8AtUta/Gk3YdTkVx1v4CxDAR8iNCeOnxgpFtOXABgfzcp
	 X5xSCMmA18ItvrRdgbClqhUIFtG8XS1o31aiLFhuWBQVqzCHZiV9Th8IuT2XgycnD6
	 aEAW4Mtm3pOVDeEcFLgkcDDpmSns9gaMB/hfhfgEAP3iaoCS9u9cxiz1WGUzWjFDT1
	 Kq8smtmhvyF4UK2GSCINu1KKfGW7GB6h5qcylnP9B+t3bvNr8E5oyfYE7k3rttc8FB
	 Z9yVGM4IvnYyB/8hOSVLfGjdEKa5JJhz3ZcIfvVzphlWFdnXugBNj+VHlEdrA3w0fk
	 Ra/3AbwIdWffw==
Content-Type: multipart/mixed; boundary="===============0628261362762456075=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ddcd920ff99e0f97ed2c92cf650872d76a4b7404ea87a104e6ab061ee3005cf9@mail.kernel.org>
In-Reply-To: <20251119224140.8616-10-david.laight.linux@gmail.com>
References: <20251119224140.8616-10-david.laight.linux@gmail.com>
Subject: Re: [PATCH 09/44] ipv6: __ip6_append_data() don't abuse max_t() casts
From: bot+bpf-ci@kernel.org
To: david.laight.linux@gmail.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org
Cc: dsahern@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,david.laight.linux@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Nov 2025 00:32:34 +0000 (UTC)

--===============0628261362762456075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index f904739e9..6fecf2f2c 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1440,7 +1440,7 @@ static int __ip6_append_data(struct sock *sk,
>  	struct sk_buff *skb, *skb_prev = NULL;
>  	struct inet_cork *cork = &cork_full->base;
>  	struct flowi6 *fl6 = &cork_full->fl.u.ip6;
> -	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, pmtu;
> +	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu;

[ ... ]

> @@ -1504,9 +1504,10 @@ static int __ip6_append_data(struct sock *sk,
>  		maxnonfragsize = mtu;
>
>  	if (cork->length + length > maxnonfragsize - headersize) {
> +		int pmtu;
>  emsgsize:
> -		pmtu = max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
> -		ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
> +		pmtu = mtu - headersize + (int)sizeof(struct ipv6hdr);
> +		ipv6_local_error(sk, EMSGSIZE, fl6, max(pmtu, 0));
>  		return -EMSGSIZE;
>  	}

Can the variable pmtu be used uninitialized here?

When reaching the emsgsize label via goto statements from earlier in
__ip6_append_data() (the checks at lines around mtu <= fragheaderlen,
headersize + transhdrlen > mtu, and the dontfrag check), the int pmtu
declaration is skipped. This leaves pmtu uninitialized when it's used
in the calculation that's passed to ipv6_local_error().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19519124312

--===============0628261362762456075==--

