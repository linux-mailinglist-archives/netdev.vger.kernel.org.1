Return-Path: <netdev+bounces-209868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58828B111FF
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6450A1C247BD
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99CE2397BF;
	Thu, 24 Jul 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gooz7N4Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02461FC3;
	Thu, 24 Jul 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387903; cv=none; b=Irqfl5Gq+cNjQF+wdm8OKscRooIxeG1Cma7xPAzAi4qo10W2iNK7e6vESjo3c/iCq0BZ4WmAgOy6Z/dtNNk4NA96A6WyivTVlHG013MD+v90E0uclwYmxxOKREV0F4/+mj0Ec1K9qS8ESHdYr6UDbrsjZNPw3lB9FrCH9jVOXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387903; c=relaxed/simple;
	bh=n55rdmmVCWJWbQHisXGUtgNQuy13xsD2/PihXZ4GUus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1l9P1yahizqowRuoyL5CWf2UaiTv7pqTvcbQe03U1HpsZZV7D9RWD3PwpLOQlYHivi4cIOfYDctX4ceQn4nccELOUM1kROJmRw5dy618gEnudQLRy469xkMArlQ0pT/2Plg+BN7Qev8VN4pQ+HwZbHOG1MHmBWF6+WeOJAuYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gooz7N4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8F3C4CEED;
	Thu, 24 Jul 2025 20:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753387903;
	bh=n55rdmmVCWJWbQHisXGUtgNQuy13xsD2/PihXZ4GUus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gooz7N4QCAZnd031LjosSyE7gEgC3bZxWs8nHQdCKjlV8ABCdTcy8AcJlZ0mFuO3p
	 XCkwggRj4HbeYMSYgeupyAOPUAPygyPj2Y6JUmZy1nggdLD9bcJlWdeHN9O0CKKfEh
	 FQVS7Y7L+bAX1o36q49au9z8NecDTTsGPXMPfHI8jHeCAainHY6KviWXx8+xzvEQYS
	 PsVsqSwFyA/xTfaq1RkGZIbqBQXmqAbYzr5++iCPEJpUbPw3ZKGq+ABmwfP4YQ0F5O
	 JX4KEgvGw/kidUg4jZ4jhoH9OW9+Hb+rvBEN0qhIM1MXmOwY7v39DrAnjomyABLXzV
	 ZECqoRl8kxymw==
Date: Thu, 24 Jul 2025 21:11:39 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: add support for strings with
 new line in netpoll_parse_ip_addr
Message-ID: <20250724201139.GE1266901@horms.kernel.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
 <20250721-netconsole_ref-v2-3-b42f1833565a@debian.org>
 <20250723144933.GA1036606@horms.kernel.org>
 <ptspqvcgbwmyyyhtfhna3jsdzffvo2tffyl4mugkozvyen5oze@ek2i6q5kkgtq>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ptspqvcgbwmyyyhtfhna3jsdzffvo2tffyl4mugkozvyen5oze@ek2i6q5kkgtq>

On Wed, Jul 23, 2025 at 10:37:59AM -0700, Breno Leitao wrote:
> On Wed, Jul 23, 2025 at 03:54:11PM +0100, Simon Horman wrote:
> > On Mon, Jul 21, 2025 at 06:02:03AM -0700, Breno Leitao wrote:
> 
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -303,20 +303,21 @@ static void netconsole_print_banner(struct netpoll *np)
> > >  static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
> > >  {
> > >  	const char *end;
> > > +	int len;
> > >  
> > > -	if (!strchr(str, ':') &&
> > > -	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
> > > -		if (!*end)
> > > -			return 0;
> > > -	}
> > > -	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
> > > -#if IS_ENABLED(CONFIG_IPV6)
> > > -		if (!*end)
> > > -			return 1;
> > > -#else
> > > +	len = strlen(str);
> > > +	if (!len)
> > >  		return -1;
> > > +
> > > +	if (str[len - 1] == '\n')
> > > +		len -= 1;
> > > +
> > > +	if (in4_pton(str, len, (void *)addr, -1, &end) > 0)
> > > +		return 0;
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +	if (in6_pton(str, len, addr->in6.s6_addr, -1, &end) > 0)
> > > +		return 1;
> > >  #endif
> > 
> > I don't think it needs to block progress.
> > But FWIIW, I think it would be nice to increase
> > build coverage and express this as:
> 
> Agree. While testing with IPv6 disabled, the netcons selftest exploded,
> so, this explose a bug in the selftest. This is now fixed in:
> 
> 	https://lore.kernel.org/all/20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org/

Nice, good to find bugs.

