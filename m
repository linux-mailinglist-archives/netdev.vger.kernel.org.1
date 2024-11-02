Return-Path: <netdev+bounces-141233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866589BA196
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 18:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A730281D03
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE51A00DF;
	Sat,  2 Nov 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Re5DHr0S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB333C3C;
	Sat,  2 Nov 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730567377; cv=none; b=MFvvq8LUYIBJhdqxeLEiAVuRTaj54uZqWCWhsQqc3snxpSf4trBA3DsP59AUKArmQgRFHpHPgbfCITKWpa4NniyTvohq96WDVgQuj1nlmJY2aTya3vp7/qL2XosI3rbNcuW5oxH4J3fFYcEHLrJ3wzmv4eQqIlnYZOcNP3YJCIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730567377; c=relaxed/simple;
	bh=X/poZeRXfv9KEdUEkcBRv4jU2dSdr8sqzGUSPiRdSqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ0WlPc0fUhAaYIlViFLO5+zXHjPw5AutPI9/9OfuNV9j5hRhERzKTSwK+QivJwOJ5kKZPPP8HPJ97hLAZ8+LKEefV0EmPraaWBYEY3FahRc4VyWLCdfu3g8B7flb7YURC5BWHcKzO0w+X6/ACfys0WV1J2nZRoPRNxzHlvDR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Re5DHr0S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z29jkdXj9YGOWoN2vvChzA1RVSL/Q7Uwqt222xRUrBw=; b=Re5DHr0SldTdmD9KhJIERrx+Vj
	+Bz2V+7ZvVNvRxT9nkYOKwuYlAZPcDIRnNAhotruZyod5fekZ2JJSDFmwigDo3p6Q/dhIJvBFS39B
	X1eGNtbplKRLOUrq1iCs4eZ7ak7XVKVYK/VjCLxxE1JmifPHSNWeioWXvqtRFqYQYquk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7Hcs-00ByZu-1W; Sat, 02 Nov 2024 18:09:26 +0100
Date: Sat, 2 Nov 2024 18:09:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: Remove deadcode
Message-ID: <fd699a8a-d595-4e7d-8d6d-fd5da1f8ce3b@lunn.ch>
References: <20241102143317.24745-1-linux@treblig.org>
 <ZyY_avQn4yuj6WC3@gallifrey>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyY_avQn4yuj6WC3@gallifrey>

On Sat, Nov 02, 2024 at 03:04:10PM +0000, Dr. David Alan Gilbert wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > ef4_farch_dimension_resources(), ef4_nic_fix_nodesc_drop_stat(),
> > ef4_ticks_to_usecs() and ef4_tx_get_copy_buffer_limited() were
> > copied over from efx_ equivalents in 2016 but never used by
> > commit 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new
> > sfc-falcon driver")
> > 
> > EF4_MAX_FLUSH_TIME is also unused.
> > 
> > Remove them.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Actually, NAK this copy; I'll resend it in a minute
> as part of a series with a whole load more.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#updating-patch-status

  pw-bot: changes-requested

  As a result the bot will set the entire series to Changes
  Requested. This may be useful when author discovers a bug in their
  own series and wants to prevent it from getting applied.

    Andrew

---
pw-bot: cr


