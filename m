Return-Path: <netdev+bounces-248722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA0D0DA68
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58D1C301B13A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C7528D850;
	Sat, 10 Jan 2026 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TBBkE6S2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E39220F2C;
	Sat, 10 Jan 2026 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768069578; cv=none; b=WEg6JB63Fc1aDG5bYdujD8FdLBDCRojOeEsrU6Fpr3NuqgYoonOqLsB7i5EbFf2dZTOb/157b+o4Q3/MDlWUx079rUBqDoRDQIq1cbdmcKaT3gtIILr3wZhsClIKSN5Pf6ZtobO1fxwGby3fRYC0Gz1sQOQvhmdvia5j775LeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768069578; c=relaxed/simple;
	bh=vb3HbPLvdOKDzl+M49x3RuXEN7RG+GiSw/mrMS92RTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0B8VSf8GWmV9G2IXBQ5cgpG1M1ngUcgznyYAdh8gWuS5XisC5HAa6D7qbEFqyPU4+7h7J0+++XVwFoSqKfIwGamYSW7tM91l7sAG+nKikzItjFWwAi2BSnlmc0lGkBnzmGZmrbxf83Qz/P5HO9NsPzQZyql8u0n5hXM7Wd3grs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TBBkE6S2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=afgUmo7FVA0UMa1pCZgDdfCcrRnZeK5e78tq9RhRkhg=; b=TBBkE6S2viMmModJ7gC/H2/pmC
	VyCBuAULdIlBeFeTHMiw1k0FI9FcdG6ZYI1BUln5cJKJ7zM3IO/0Yu/jwaGbWHXh3HRxNGi2rvjC0
	Hz0BCuDbZYud3yTnPz8zwu+7fJzcw/sRSA+e3NdIRcGs1gh00G9p+549BbloBiq8ABhDnCErrYaTQ
	XU9rKs5jr5RWGdDFmocUJ9eDG56euyzXR2k6wQsPSkbZPJO3RsBcoAUlpiNd4mxtrNGTiokRmhwCg
	WmrJJK+oGJstSjolh+TcadHGN2n34Haq7qdOFJIgfYLrosyn5nVPStr8/UkuueO07+wegHmnt049j
	ElqpB2aA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44118)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vedf7-000000004ui-3O08;
	Sat, 10 Jan 2026 18:26:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vedf3-000000004St-0Hpf;
	Sat, 10 Jan 2026 18:26:05 +0000
Date: Sat, 10 Jan 2026 18:26:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling
 control
Message-ID: <aWKZvEW7rKFFwZLG@shell.armlinux.org.uk>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 09, 2026 at 07:27:54PM +0100, Andrew Lunn wrote:
> >    rx-internal-delay-ps:
> > -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> > +    enum: [0, 20, 60, 100, 200, 400, 800, 1600, 2400]
> >  
> >    tx-internal-delay-ps:
> > -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> > +    enum: [0, 20, 60, 100, 200, 400, 800, 1600, 2400]
> 
> You need to add some text to the Changelog to indicate why this is
> safe to do, and will not cause any regressions for DT blobs already in
> use. Backwards compatibility is very important and needs to be
> addressed.
> 
> > +  eswin,rx-clk-invert:
> > +    description:
> > +      Invert the receive clock sampling polarity at the MAC input.
> > +      This property may be used to compensate for SoC-specific
> > +      receive clock to data skew and help ensure correct RX data
> > +      sampling at high speed.
> > +    type: boolean
> 
> This does not make too much sense to me. The RGMII standard indicates
> sampling happens on both edges of the clock. The rising edge is for
> the lower 4 bits, the falling edge for the upper 4 bits. Flipping the
> polarity would only swap the nibbles around.

I'm going to ask a rather pertinent question. Why do we have this
eswin stuff in the kernel tree?

I've just been looking to see whether I can understand more about this,
and although I've discovered the TRM is available for the EIC7700:

https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual/releases

that isn't particularly helpful on its own.

There doesn't appear to be any device tree source files that describe
the hardware. The DT bindings that I can find seem to describe only
ethernet and USB. describe the ethernet and USB, and maybe sdhci.

I was looking for something that would lead me to what this
eswin,hsp-sp-csr thing is, but that doesn't seem to exist in our
DT binding documentation, nor does greping for "hsp.sp.csr" in
arch/*/boot/dts find anything.

So, we can't know what this "hsp" thing is to even know where to look
in the 80MiB of PDF documentation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

