Return-Path: <netdev+bounces-166423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB2A35F5C
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B966B1663DB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B6F264A9C;
	Fri, 14 Feb 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p5IeBaeg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B072641FA;
	Fri, 14 Feb 2025 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540036; cv=none; b=BDaOWEbJQWuWDB/jlFWOHKfXNkObf9518LjHw0Swk+I4EJZRT5vaI4Is/t3jeH+LmAsMXkFWlUyTkVkp2Uw/iO9U6GdXL6e7VcsBXJhGu9pi6O/dr6sLIREZOwPhIQR+EUb+39m0tx5iljEM/vJ30RKly+mZrcUXeR+Ps1RsFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540036; c=relaxed/simple;
	bh=FJGk+9rhaetDdk8WaF1XmUYKc3SAtIIHdodQDcsgra8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDz+iDvTMWp1XtZIB1SnuXOFElVN4soDWPRS1UowEZkTwrRZ3SHMEpRjblYEpALWSFQAmJzmszMcuE25Zi5xdo92wBpy6ylS41PQhIuGNV4B2my/y6gxvKwiHXazUA6YldNn+J1ohGR1Z5W0bWoGaSGDZEYloQFWrgj05dYBxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p5IeBaeg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Sjoc4mU2ZN2AZGuZYU9JfeoEcrjVetM2APyjqvflfVA=; b=p5IeBaeg+JnuCNdrC3CYppyFdc
	LNOeTd6vHsn386e/hOcESo7+QHPrBWVeFo8vLWmWou6Ky1Wgr0ijbUi3Fp6IukiLiOLSPismY4wZP
	5sCAwiQotFt9dauilYzYZoq0yASYk6DEMBWOGk6mMpwU6EhznVTmuRic+CAmoWTzkApY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tivpB-00E4sv-Qc; Fri, 14 Feb 2025 14:33:45 +0100
Date: Fri, 14 Feb 2025 14:33:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove redundant variable declaration in
 __dev_change_flags()
Message-ID: <1d7e3018-9c82-4a00-8e10-3451b4a19a0d@lunn.ch>
References: <20250214-old_flags-v1-1-29096b9399a9@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-old_flags-v1-1-29096b9399a9@debian.org>

On Fri, Feb 14, 2025 at 04:47:49AM -0800, Breno Leitao wrote:
> The old_flags variable is declared twice in __dev_change_flags(),
> causing a shadow variable warning. This patch fixes the issue by
> removing the redundant declaration, reusing the existing old_flags
> variable instead.
> 
> 	net/core/dev.c:9225:16: warning: declaration shadows a local variable [-Wshadow]
> 	9225 |                 unsigned int old_flags = dev->flags;
> 	|                              ^
> 	net/core/dev.c:9185:15: note: previous declaration is here
> 	9185 |         unsigned int old_flags = dev->flags;
> 	|                      ^
> 	1 warning generated.
> 
> This change has no functional impact on the code, as the inner variable
> does not affect the outer one. The fix simply eliminates the unnecessary
> declaration and resolves the warning.

I'm not a compiler person... but there might be some subtlety here:


int __dev_change_flags(struct net_device *dev, unsigned int flags,
		       struct netlink_ext_ack *extack)
{
	unsigned int old_flags = dev->flags;
	int ret;

This old_flags gets the value of flags at the time of entry into the
function.

...

	if ((old_flags ^ flags) & IFF_UP) {
		if (old_flags & IFF_UP)
			__dev_close(dev);
		else
			ret = __dev_open(dev, extack);
	}

If you dig down into __dev_close(dev) you find

		dev->flags &= ~IFF_UP;

then

...

	if ((flags ^ dev->gflags) & IFF_PROMISC) {
		int inc = (flags & IFF_PROMISC) ? 1 : -1;
		unsigned int old_flags = dev->flags;

This inner old_flags now has the IFF_UP removed, and so is different
to the outer old_flags.

The outer old_flags is not used after this point, so in the end it
might not matter, but that fact i felt i needed to look deeper at the
code suggests the commit message needs expanding to include more
analyses.

> Fixes: 991fb3f74c142e ("dev: always advertise rx_flags changes via netlink")

I suppose there is also a danger here this code has at some point in
the past has been refactored, such that the outer old_flags was used
at some point? Backporting this patch could then break something?  Did
you check for this? Again, a comment in the commit message that you
have checked this is safe to backport would be nice.

    Andrew

---
pw-bot: cr

