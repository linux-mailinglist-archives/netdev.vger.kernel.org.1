Return-Path: <netdev+bounces-163398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDCEA2A246
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0A41628B9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0600232377;
	Thu,  6 Feb 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="19RZhhDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA26231CB9;
	Thu,  6 Feb 2025 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826630; cv=none; b=ag8m0J+OKntddfOGTLLToegno4U7UkjgycmH2BSjeSgtuukg7g8mjqfBc64i0PqwC7Oyv5etxtanxHVPfh8KDLs2HT3e4Owjl5vsjdaeU6zRq8g4+AmErth87jLd6K/Y7oojoTHw/cf9MdICj7oxnMGjE9QaYnEokCkxYf2ioY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826630; c=relaxed/simple;
	bh=LRFakVhDc7VwaJzFuY4mPjdizVsMXjSw4ldRGJ9UyUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE24Bryb0t4xQoCwG60tGIXvkq5FRgNkISP0hhJENCdoxDFlvMjUjKmNG7fiYMOiB/WOlyl+2PzywHHUQ+zFHDUzdfJQLrblYzSJ7NWAAX1+5PyrBB0u0R4UxgtYiNpRRMZuNEzDtnpvHl1YLb1nexFWRoKUx+HPWv1EokW+a74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=19RZhhDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60248C2BCF7;
	Thu,  6 Feb 2025 07:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738826629;
	bh=LRFakVhDc7VwaJzFuY4mPjdizVsMXjSw4ldRGJ9UyUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=19RZhhDnL9k7vIM/NKnv+i/frUOdkpZTbwZ8fhy9nYII4ebjTyw2txlkKiiutXAeE
	 2A5ttbDs8d+mwsRRaf8tH2N95vj+eit8v5vJ+w/kHSsN6yI6ZA6lNdmn+U9ssmF49M
	 Jh2mPe2DETLxw65RQTQ4wAs54JPW/+nE+sqr267I=
Date: Thu, 6 Feb 2025 08:22:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next 1/2] usb: Add base USB MCTP definitions
Message-ID: <2025020634-statute-ribbon-90a8@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
 <20250206-dev-mctp-usb-v1-1-81453fe26a61@codeconstruct.com.au>
 <2025020633-antiquity-cavity-76e8@gregkh>
 <a927fbb40ce2f89c57b427d4dabe5f730a523d80.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a927fbb40ce2f89c57b427d4dabe5f730a523d80.camel@codeconstruct.com.au>

On Thu, Feb 06, 2025 at 03:11:25PM +0800, Jeremy Kerr wrote:
> Hi Greg,
> 
> Thanks for the review.
> 
> > > --- /dev/null
> > > +++ b/include/linux/usb/mctp-usb.h
> > > @@ -0,0 +1,28 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * mctp-usb.h - MCTP USB transport binding: common definitions.
> > > + *
> > > + * These are protocol-level definitions, that may be shared between host
> > > + * and gadget drivers.
> > 
> > Perhaps add a link to the spec?
> 
> Can do. I have one in the actual driver, but can replicate that here if
> it's helpful.

Isn't this a usb.org spec and not a vendor-specific one?

> > > + * Copyright (C) 2024 Code Construct Pty Ltd
> > 
> > It's 2025 now :)
> 
> WHAT?!
> 
> :D
> 
> (this was started in 2024, and I have some preliminary versions up since
> then, but I assume the last date is preferrable)

As per copyright norms, list the real dates, so that would be:
	Copyright (C) 2024-2025 ...

thanks,

greg k-h

