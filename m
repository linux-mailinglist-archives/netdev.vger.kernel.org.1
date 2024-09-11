Return-Path: <netdev+bounces-127344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03F975206
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EC6286291
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBBC1885B8;
	Wed, 11 Sep 2024 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bsaJawAE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66851C4A;
	Wed, 11 Sep 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057605; cv=none; b=dUHZkR0KEZLPDAUS2TzWR8mVkPT1zjS7NOZ2X38QV3F8nT4uqnXGdMU3JAnRXRJl0Lt3y8jRvoW3G1iHsSRHRl1hEPnDmWBvEIC1K1CFsflje2Rb1qax2rBdfIl2s0rYIJz1BBMQl4crvpCJSzQrYb8IogohKiMK81/q8r38jYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057605; c=relaxed/simple;
	bh=XRkIE40xSb2ZY5B3sAc/TFs5gnmESTtqL/5Z7Yb1RDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToDKdWyFhx/TpMIklTGeoNpxr0AjB8qCjTAbFclcJviQAuTVUC05PHrXbGHnq7xn1cniRzznGpzRhX/cqrHX5QaoMqKVlB7cG525nHR3qdMCgKA5Fy0rB1xtiNQFxYj2+fU9CrR+EfR2JTHRBOYGnCkQegT5mZG3EpdnJdgnATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bsaJawAE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GdFKasybHTvynycQkUwxGxJRE01tCv0/kS2N0di+5uM=; b=bsaJawAEdNfRSCpbbJ7m5rICD9
	bNJcrfI7WqUbodrpwj9Q2FAzog8ps9AAnfxpLfKtFgnINWnGAy9U2+Sj8cyWZiPFC6HyFxqSVa8Wx
	36rEZ+tM0FcqqH9Mwu7l9NlUvZg0WTps+dObXox9iOyPt2aB5w07L426UPXNY9eUeSOk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soMQQ-007Cd5-1R; Wed, 11 Sep 2024 14:26:22 +0200
Date: Wed, 11 Sep 2024 14:26:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Message-ID: <cb9d0196-5b91-486b-932e-e73a391fa609@lunn.ch>
References: <20240910090217.3044324-1-danieller@nvidia.com>
 <20240910090217.3044324-3-danieller@nvidia.com>
 <20240911073234.GJ572255@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911073234.GJ572255@kernel.org>

On Wed, Sep 11, 2024 at 08:32:34AM +0100, Simon Horman wrote:
> + Andrew Lunn
> 
> On Tue, Sep 10, 2024 at 12:02:17PM +0300, Danielle Ratson wrote:
> > In the CMIS specification for pluggable modules, LPL (Local Payload) and
> > EPL (Extended Payload) are two types of data payloads used for managing
> > various functions and features of the module.
> > 
> > EPL payloads are used for more complex and extensive management
> > functions that require a larger amount of data, so writing firmware
> > blocks using EPL is much more efficient.
> > 
> > Currently, only LPL payload is supported for writing firmware blocks to
> > the module.
> > 
> > Add support for writing firmware block using EPL payload, both to
> > support modules that supports only EPL write mechanism, and to optimize
> > the flashing process of modules that support LPL and EPL.
> > 
> > Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > ---
> > 
> > Notes:
> >     v2:
> >     	* Initialize the variable 'bytes_written' before the first
> >     	  iteration.
> 
> Hi Danielle,
> 
> Thanks for the update. From a doing-what-it-says-on-the-wrapper
> perspective, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I do note that there were some questions from Andrew Lunn (CCed) in v1
> regarding the size of transfers over the bus. I see that you responded to
> that. Thanks! But I do wonder if he has any further comments.

I do wounder where the speedup comes from.

> The LPL contains ap to 128 bytes, and the EPL up to 2048

Are 128 consecutive 16 byte transfers per block really faster than 8
consecutive transfers per block? If you have an efficient I2C master,
both should be doing 400Kbp. If the master is inefficient, you end up
with the same amount of dead time on the wire.

And does the standard really say you can fragment the block at the I2C
layer?

I suspect in the end we will have an API between the core and the
driver to ask it what size of block it actually supports. But we can
probably add that when we need it.

	Andrew

