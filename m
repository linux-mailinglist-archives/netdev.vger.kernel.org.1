Return-Path: <netdev+bounces-139661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6220F9B3C00
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DB91F22EB1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E61E0B99;
	Mon, 28 Oct 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dC8/TwOH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4C1E0B7A;
	Mon, 28 Oct 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147934; cv=none; b=bHpusQkVitGE8apQdFyR5DmXexAiaH/HCVPdmMkxG9i1yof8kK7fRt2qMX1INjYyCSyYgaOqsVpi5ZYdLVkoVpoM2MnxKJjj1KBV6OSLMxLUV1HC24vE+w/5alCeI+AypURiG1krhmxsVH6+HqBfj9WDOxZWydO6nVfVrHsS1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147934; c=relaxed/simple;
	bh=0SHhwMvBQ0R/VwzQbIYNd7Gy0atuINm9sxnfjq3nmGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbWHh+jC9LN0nSvI6/3sBAiMPPOJmeau7htCIRSyCxicuQuKznu9wgYYhLwmCwIRJfEA3H1roCvZMEQsPmpNm+1/ELcd1CNUD440sCWRRTXC4WrBPpPIDH1cO6XmXYSqFSZnaahrCCi8KDC/1Y5DJqY+NO6OFuu693BZxW/if1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dC8/TwOH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0cyChLLmUWYrZilbG+gZNOZFe7OHGrSoufugVIJy4Og=; b=dC8/TwOHMmChIkwoaPwsvpOWwg
	n7VREjt24R6PPg8Ts918jTJqwKotUYuMH/bgWI03PrzGNq67+jWGDFi3Mei4ZSQqUpLRQmy2YmLB2
	5s5WxtnD0nR8NbUt70pmG7UltPqWOcrdW+bUssN1YekgV4FCpBucJ90ka+XWsX50k4+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5WVi-00BULE-L0; Mon, 28 Oct 2024 21:38:46 +0100
Date: Mon, 28 Oct 2024 21:38:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 1/4][next] uapi: socket: Introduce struct
 sockaddr_legacy
Message-ID: <66641c32-a9fb-4cd6-b910-52d2872fad3d@lunn.ch>
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

> As this new struct will live in UAPI, to avoid breaking user-space code
> that expects `struct sockaddr`, the `__kernel_sockaddr_legacy` macro is
> introduced. This macro allows us to use either `struct sockaddr` or
> `struct sockaddr_legacy` depending on the context in which the code is
> used: kernel-space or user-space.

Are there cases of userspace API structures where the flexiable array
appears in the middle? I assume this new compiler flag is not only for
use in the kernel? When it gets turned on in user space, will the
kernel headers will again produce warnings? Should we be considering
allowing user space to opt in to using sockaddr_legacy?

    Andrew

