Return-Path: <netdev+bounces-139728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE99B3E93
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0521C216D1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907231FAC30;
	Mon, 28 Oct 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKHCl6rs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619111925B3;
	Mon, 28 Oct 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158820; cv=none; b=MvfFzVD0UJcW6doxPYtmAzfDrkwn5SH5TL3xSKCKOgR7KpczUAeGXFNizz+p3lRBx5JL+ZLBDxc4vde91OWXe4eaX6kT6Lj8eEseF7VNAhMwM2ljnr2MtCY+RaheKqWRF2hKVmV6z3yFqj6QAvFv9Un+VuoaCVB7gUF4JqQ6274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158820; c=relaxed/simple;
	bh=pQzl1y9h2xsU92uZtxx7jqh2VQjUzwEVlkfCH4GvCD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vhyu6Iu9T6Rm4NLOQ3Q/BrX/3mT8+81kaLcKfuRkvvekIGOAry3/OafRSq3FToqcSz54Ky4Y7YaEILMbb297+xTc5+1b8YNSRXoBBcwjI00hQKrof8+RPCOAyqxFWtqcDLo5psPKxQTmSD3JN2BTnWCXo3vsqJ3sEo8khIHthc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKHCl6rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3837C4CEC3;
	Mon, 28 Oct 2024 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158819;
	bh=pQzl1y9h2xsU92uZtxx7jqh2VQjUzwEVlkfCH4GvCD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKHCl6rs42Z1Ijgn7WEAnUb20e/btZs665SvomSIANBuBXzlHA1HjIBtgIEfLVUQq
	 nwPVOZWGKEwWueNFd3wzc6DFjIgvT/9/X7FTpB+fRcpLcTrvjywW/6AjZJBcD6Fwme
	 4QeUyVjjk+LbLu4aTpAS57AcEKNBSvtoagvkxoOk6c1RT2y8hqLicXf37HX+yEqSEy
	 B6wg7WTzGHH5UXSP+YGwEPC0BP0C32H78AKuawPmUUGbAmGpZMiT+q5GUIbr7TLapy
	 BkgZVzCtUyJYPzJptHCtzqIhTC/snZBuAa5zoLDHS8Uqag0uIG+DGpL//bPUp1XXgh
	 AdRmlfVQKTv1Q==
Date: Mon, 28 Oct 2024 16:40:16 -0700
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 1/4][next] uapi: socket: Introduce struct
 sockaddr_legacy
Message-ID: <202410281637.8CF1EA8AE7@keescook>
References: <cover.1729802213.git.gustavoars@kernel.org>
 <23bd38a4bf024d4a92a8a634ddf4d5689cd3a67e.1729802213.git.gustavoars@kernel.org>
 <66641c32-a9fb-4cd6-b910-52d2872fad3d@lunn.ch>
 <bc7d77fdbe97edc3481f9f73a438742651bd4b8b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc7d77fdbe97edc3481f9f73a438742651bd4b8b.camel@sipsolutions.net>

On Mon, Oct 28, 2024 at 09:47:08PM +0100, Johannes Berg wrote:
> On Mon, 2024-10-28 at 21:38 +0100, Andrew Lunn wrote:
> > > As this new struct will live in UAPI, to avoid breaking user-space code
> > > that expects `struct sockaddr`, the `__kernel_sockaddr_legacy` macro is
> > > introduced. This macro allows us to use either `struct sockaddr` or
> > > `struct sockaddr_legacy` depending on the context in which the code is
> > > used: kernel-space or user-space.
> > 
> > Are there cases of userspace API structures where the flexiable array
> > appears in the middle?
> 
> Clearly, it's the case for all the three other patches in this series.

The issue is that the kernel uses these structures, and the kernel's view
of sockaddr is that it (correctly) has a flexible array.  Userspace's view
of sockaddr is the old struct (which comes from the libc, not the kernel)
which ends with a fake flexible array. We need to correct the kernel's
view of these structures to use the introduced legacy struct to avoid
lying to the compiler about what's going on. :)

-- 
Kees Cook

