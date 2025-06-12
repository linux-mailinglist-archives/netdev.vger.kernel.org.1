Return-Path: <netdev+bounces-197123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8913AD7906
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 19:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36EF188BD81
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056C29A9CB;
	Thu, 12 Jun 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmHaDVwd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FF19CC39
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749510; cv=none; b=XPlhLuskvB4Yz9cl9+srOqCRUvnpY4A2OTO3A+Xviz0ZGeoBlZ8DgUJ4pB4z5B9/36Fx3OUjZb2y3hTzXUFPNrHdZMMANXZelE7yp4uPqnq/arQyGc+bzyDAiMXXCJ0PeFTaIEKZN53zQ/HaBMw0vREaEBS9wT2BoOcADY7rWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749510; c=relaxed/simple;
	bh=T0+gRg7ohmAGujJCmyOAApXUBlV//W6g8HtWvYmk3eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDo0hQ0FjMqRvT5FsX41Ev1Vl4cRAzCIpdX+Gdyt9m3fkoYm4eQ+TdOEJl7zBAIQXqC/RU/U5okQ44n9OK1HYRlbIBHhUyolHogfUSR8Qw08ctyAltvJru/2mAtda5S2+u6/m1f/+IFgsBb8/nUFn6k5bwX6jkVakuMlphyMQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmHaDVwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF69C4CEEE;
	Thu, 12 Jun 2025 17:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749749510;
	bh=T0+gRg7ohmAGujJCmyOAApXUBlV//W6g8HtWvYmk3eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmHaDVwdRL1uxwc+e8KSt/7lQkhr5HuoOfifddRm9Bv+w9NrRh8Kgt4bzroYSDC6J
	 7WYy7MDCejRT96Fafm1ceB7DbZBXQ6Yh1idwev9MBQsSTic2e5eSHoWxfp4AkTSbPa
	 tj7WpHvrWxbTvh77m4ONUTzNbnlBlY5H6gGVYokMY8sQU37HwWRmY1iSlujJ6d7m8Y
	 FayCzArJjVUoXUeiKeXpVweKpl974qvGJ7axji+zxHpW8PHLoSxM0WirA8mic08wuy
	 ZwqiaJ7gkx+ivIFlr2UEOuQtG41TdiuA90nyLJHWOnlJBwXhXdn/VU3NU9tEoUcIEN
	 OTI2unVtqpefQ==
Date: Thu, 12 Jun 2025 20:31:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com, kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <20250612173145.GB436744@unreal>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal>
 <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>

On Thu, Jun 12, 2025 at 02:41:33PM +0200, Andrew Lunn wrote:
> On Thu, Jun 12, 2025 at 12:42:34PM +0300, Leon Romanovsky wrote:
> > On Tue, Jun 10, 2025 at 07:51:08AM -0700, Alexander Duyck wrote:
> > > The fbnic driver up till now had avoided actually reporting link as the
> > > phylink setup only supported up to 40G configurations. This changeset is
> > > meant to start addressing that by adding support for 50G and 100G interface
> > > types as well as the 200GBASE-CR4 media type which we can run them over.
> > > 
> > > With that basic support added fbnic can then set those types based on the
> > > EEPROM configuration provided by the firmware and then report those speeds
> > > out using the information provided via the phylink call for getting the
> > > link ksettings. This provides the basic MAC support and enables supporting
> > > the speeds as well as configuring flow control.
> > > 
> > > After this I plan to add support for a PHY that will represent the SerDes
> > > PHY being used to manage the link as we need a way to indicate link
> > > training into phylink to prevent link flaps on the PCS while the SerDes is
> > > in training, and then after that I will look at rolling support for our
> > > PCS/PMA into the XPCS driver.
> > 
> > <...>
> > 
> > > Alexander Duyck (6):
> > >       net: phy: Add interface types for 50G and 100G
> > 
> > <...>
> > 
> > >  drivers/net/phy/phy-core.c                    |   3 +
> > >  drivers/net/phy/phy_caps.c                    |   9 ++
> > >  drivers/net/phy/phylink.c                     |  13 ++
> > >  drivers/net/phy/sfp-bus.c                     |  22 +++
> > >  include/linux/phy.h                           |  12 ++
> > >  include/linux/sfp.h                           |   1 +
> > >  14 files changed, 257 insertions(+), 88 deletions(-)
> > 
> > when the fbnic was proposed for merge, the overall agreement was that
> > this driver is ok as long as no-core changes will be required for this
> > driver to work and now, year later, such changes are proposed here.
> 
> I would say these are natural extensions to support additional speeds
> in the 'core'. We always said fbnic would be pushing the edges of the
> linux core support for SFP, because all other vendors in this space
> reinvent the wheel and hide it away in firmware. fbnic is different
> and Linux is actually driving the hardware.

How exactly they can hide speed declarations in the FW and still support it?

In addition, it is unclear what the last sentence means. FBNIC has FW like
any other device. The main difference is that Meta doesn't need to support
gazillion customers and can use same FW across their fleet without need
to configure it, (According to open source information).
https://docs.kernel.org/networking/device_drivers/ethernet/meta/fbnic.html

> 
> There are no algorithmic changes here, no maintenance burden, it is
> following IEEE, and it will be useful for other devices in the
> future. So as one of the Maintainers of this code, i'm happy to accept
> this, with the usual proviso it compiles without warnings, checkpatch
> clean, Russell is also happy with it, etc.

I didn't expect anything different here. This is exactly how agreed
boundaries are pushed - salami slicing.

Thanks

> 
> 	Andrew
> 

