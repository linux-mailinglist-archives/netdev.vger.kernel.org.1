Return-Path: <netdev+bounces-194616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37037ACB616
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D95D3BD6EE
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F29822DF96;
	Mon,  2 Jun 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ntQsgKkH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96522ACF3;
	Mon,  2 Jun 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875587; cv=none; b=dzchyPkD7iw/GczQ8lnTdHxwQMsGFhH8o+MOr0QyTrUPXxpB4GrqIG5Cvnii28PfsE9I4e24LiwrniFdCW31zq6FH1IQxGYXmwQqWsJcndU1gp3EYCR8SaLgJVrwKDHJou6hZO0bnm2n+UeEj3xNanw73/lZEYSJmhI/zrP5j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875587; c=relaxed/simple;
	bh=ENKRbfuoyvn12sUftAMLhVEk/Pw8g8eOE1/dsG5q7aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzmWAfJvtiRey8dhpR3lQqH4XUTTaiZSrgW7fIG/ybhC/6rCj7NDiZ5xMg5MuJESkOQIBmjOVpPTTbUZNhqqvrjIJwNip2WM8oae8aMOXyEemtL8+oi8wODe54I8lUn0dpg8z10OlreJQ3YQ4yYXpkgIvlyByErfuso3Y4A78KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ntQsgKkH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q4yO2eet2X9VIb1gOn1jru8yU6ZZQDkTdsovDmjK68Y=; b=ntQsgKkHBdjkn6m4DKJju+CRDW
	SAfsJsmmQgcuaoT+dVJIswbhK5OmKlWFf+QZpTV5zQW1O1UAomfigon+7+/4D7UNYVCCFxw4S6XRb
	+Vdm85Vw7t3/61amkdhU0yDO9cbWTG4ydhaCTC9clMW4GDEtX0i3C3S826zmAOR2XNtM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uM6QY-00EVfB-8J; Mon, 02 Jun 2025 16:46:14 +0200
Date: Mon, 2 Jun 2025 16:46:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	keescook@chromium.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net: randomize layout of struct net_device
Message-ID: <053507e4-14dc-48db-9464-f73f98c16b46@lunn.ch>
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602135932.464194-1-pranav.tyagi03@gmail.com>

On Mon, Jun 02, 2025 at 07:29:32PM +0530, Pranav Tyagi wrote:
> Add __randomize_layout to struct net_device to support structure layout
> randomization if CONFIG_RANDSTRUCT is enabled else the macro expands to
> do nothing. This enhances kernel protection by making it harder to
> predict the memory layout of this structure.
> 
> Link: https://github.com/KSPP/linux/issues/188
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  include/linux/netdevice.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7ea022750e4e..0caff664ef3a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2077,7 +2077,11 @@ enum netdev_reg_state {
>   *	moves out.
>   */
>  
> +#ifdef CONFIG_RANDSTRUCT
> +struct __randomize_layout net_device {
> +#else
>  struct net_device {
> +#endif
>  	/* Cacheline organization can be found documented in
>  	 * Documentation/networking/net_cachelines/net_device.rst.
>  	 * Please update the document when adding new fields.

A dumb question i hope.

As you can see from this comment, some time and effort has been put
into the order of members in this structure so that those which are
accessed on the TX fast path are in the same cache line, and those on
the RX fast path are in the same cache line, and RX and TX fast paths
are in different cache lines, etc.

Does CONFIG_RANDSTRUCT understand this? It is safe to move members
around within a cache line. And it is safe to move whole cache lines
around. But it would be bad if the randomisation moved members between
cache lines, mixing up RX and TX fast path members, or spreading fast
path members over more cache lines, etc.

Is there documentation somewhere about what __randomize_layout
actually does? Given you are posting to a networking mailing list, you
should not assume the developers here are deep into how the compiler
works, and want to include a link to documentation, so we can see this
is actually safe to do.

	 Andrew

