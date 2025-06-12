Return-Path: <netdev+bounces-196949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C077AAD70A4
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731FC3A36E1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568BE1AA786;
	Thu, 12 Jun 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jtWYG8zv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A82222A6
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732101; cv=none; b=k1sRUuyYxiNjYjasR+JZxqg/+ifgZ182CRT5ih3gGC2qhlNs5Pe1cvPzL8Q9xXDzoMKFP40heomlVmttlzMWfBYgndMWPza6lrPNh3b0TCZn0cHju8cJNucNHt6YsxziUBbcZWiavGiIC8JZD5wCZqS/jkr1ev89nTi/Wo1Q6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732101; c=relaxed/simple;
	bh=q/JZ+NiWgM5w8qLtTARl/1jcygXCoafvHvccqzUgRiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsFSZ2fY21A/hgTnBYVkc93hV0dLAHqw7qHuM2X9i/t9MNF1mU1gpIoaq8AXJsUsav2Fn79v7uquw/JDCMHXP35JO15osPNZOII9AaGT8UZdZOPxGbN+OcTw8xXuF8owCTE6CCQmC7ZZDL+a6vltO1j9ev3YUmTXvpuBc8/HQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jtWYG8zv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=64KuHk83Q1eAOXcMsYAEbAuQSwL8H4J6Nke+iVwNk0s=; b=jtWYG8zv35CiZLRRtMuRGTMeeJ
	mjzcKqnhXcGea3aTl6Eyj+Z8qacnxx3x6V9xfzq8/3NT5NYGe4q5dcU6IQgtzvW8IIly/QBvOdPOr
	znaOhLD1mP6FRM4e07uaPITjq/fAEvFhc1PMdxm+A6ZWo2TaqQCa8E6gi3wjUYK6WLGA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPhFN-00FXTg-BQ; Thu, 12 Jun 2025 14:41:33 +0200
Date: Thu, 12 Jun 2025 14:41:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Leon Romanovsky <leon@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com, kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612094234.GA436744@unreal>

On Thu, Jun 12, 2025 at 12:42:34PM +0300, Leon Romanovsky wrote:
> On Tue, Jun 10, 2025 at 07:51:08AM -0700, Alexander Duyck wrote:
> > The fbnic driver up till now had avoided actually reporting link as the
> > phylink setup only supported up to 40G configurations. This changeset is
> > meant to start addressing that by adding support for 50G and 100G interface
> > types as well as the 200GBASE-CR4 media type which we can run them over.
> > 
> > With that basic support added fbnic can then set those types based on the
> > EEPROM configuration provided by the firmware and then report those speeds
> > out using the information provided via the phylink call for getting the
> > link ksettings. This provides the basic MAC support and enables supporting
> > the speeds as well as configuring flow control.
> > 
> > After this I plan to add support for a PHY that will represent the SerDes
> > PHY being used to manage the link as we need a way to indicate link
> > training into phylink to prevent link flaps on the PCS while the SerDes is
> > in training, and then after that I will look at rolling support for our
> > PCS/PMA into the XPCS driver.
> 
> <...>
> 
> > Alexander Duyck (6):
> >       net: phy: Add interface types for 50G and 100G
> 
> <...>
> 
> >  drivers/net/phy/phy-core.c                    |   3 +
> >  drivers/net/phy/phy_caps.c                    |   9 ++
> >  drivers/net/phy/phylink.c                     |  13 ++
> >  drivers/net/phy/sfp-bus.c                     |  22 +++
> >  include/linux/phy.h                           |  12 ++
> >  include/linux/sfp.h                           |   1 +
> >  14 files changed, 257 insertions(+), 88 deletions(-)
> 
> when the fbnic was proposed for merge, the overall agreement was that
> this driver is ok as long as no-core changes will be required for this
> driver to work and now, year later, such changes are proposed here.

I would say these are natural extensions to support additional speeds
in the 'core'. We always said fbnic would be pushing the edges of the
linux core support for SFP, because all other vendors in this space
reinvent the wheel and hide it away in firmware. fbnic is different
and Linux is actually driving the hardware.

There are no algorithmic changes here, no maintenance burden, it is
following IEEE, and it will be useful for other devices in the
future. So as one of the Maintainers of this code, i'm happy to accept
this, with the usual proviso it compiles without warnings, checkpatch
clean, Russell is also happy with it, etc.

	Andrew

