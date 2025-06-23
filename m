Return-Path: <netdev+bounces-200387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCAAAE4C33
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 19:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A362517DB89
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964DA2D23BF;
	Mon, 23 Jun 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gPeFGE0v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42082BE7AB;
	Mon, 23 Jun 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701313; cv=none; b=H5ZdZBMR6Er89hZB6Bp6dplu0KaXYx+ljh3G3r3jI3ZTftAVMZvUcMBHwwE8nSWjq3lvkHdl1mG9t0qt4jvHBOtF41nzzPBb8AWydrt8Wodpr5gKSAHTeQmx7f6ZbyMXuJcM9kOMBzv0kxAFfHwqbe01w4F0dmwtYVd7Debs2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701313; c=relaxed/simple;
	bh=d6lhGj9UBNETcXzHlUD8vxv5lhqBtc4tTPVXr033KoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is7f0EDpjga03bCtZggtysBUmA3c+o3Vtb9/zxH0EA2BpDNRvlnv6KDk+ASxBu97Vi3I1/gLPaVwBOqxGSlWl3MqdB1DaSgMV7vy+y4puGMpCK/HQMfzvCeeQlvsDuo4cDz4aMsc0XEXvaF6eAkfW09QtDIXp8fqpn0pwGCZJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gPeFGE0v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=n5ibyBZ3r+6S6Lb93lOhr2uIURv0laUJD2dC94DxPVc=; b=gP
	eFGE0vpiZKqqHx5Fl3IhdzcaS7i5OGsOyXpryU4kN2QIG/frJGuaz4DRNnkvHJATdup6gS9No1Yl/
	N4ozSgqpiVAItEymc+4KPytzKn73qg6k9HQ9+/RBzVMKjLZTiffiKHAuze9I0DPy770Urb9ITt5xq
	1qIRLFMbdrvWxlg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTlNn-00GiVJ-JH; Mon, 23 Jun 2025 19:55:03 +0200
Date: Mon, 23 Jun 2025 19:55:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: bcm5481x: Implement MII-Lite
 mode
Message-ID: <8735eb08-92de-4489-9e52-fee91c9ed23e@lunn.ch>
References: <20250623151048.2391730-1-kamilh@axis.com>
 <20250623151048.2391730-2-kamilh@axis.com>
 <20250623175135.5ddee2ea@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623175135.5ddee2ea@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>

On Mon, Jun 23, 2025 at 05:51:35PM +0200, Maxime Chevallier wrote:
> Hi Kamil,
> 
> On Mon, 23 Jun 2025 17:10:46 +0200
> Kamil Horák - 2N <kamilh@axis.com> wrote:
> 
> > From: Kamil Horák (2N) <kamilh@axis.com>
> > 
> > The Broadcom bcm54810 and bcm54811 PHYs are capable to operate in
> > simplified MII mode, without TXER, RXER, CRS and COL signals as defined
> > for the MII. While the PHY can be strapped for MII mode, the selection
> > between MII and MII-Lite must be done by software.
> > The MII-Lite mode can be used with some Ethernet controllers, usually
> > those used in automotive applications. The absence of COL signal
> > makes half-duplex link modes impossible but does not interfere with
> > BroadR-Reach link modes on Broadcom PHYs, because they are full-duplex
> > only. The MII-Lite mode can be also used on an Ethernet controller with
> > full MII interface by just leaving the input signals (RXER, CRS, COL)
> > inactive.
> 
> I'm following-up to Andrew's suggestion of making it a dedicated
> phy-mode. You say that this requires only phy-side configuration,
> however you also say that with MII-lite, you can't do half-duplex.
> 
> Looking at the way we configure the MAC to PHY link, how can the MAC
> driver know that HD isn't available if this is a phy-only property ?

One would hope that when the PHY is configured to -lite, it changes
its abilities register to indicate it does not support half duplex
modes? But without looking at the datasheet, i've no idea if it
actually does.

There is also an ordering issuer, it needs to be put into -lite mode
before phy_probe reads the abilities, which is after the probe()
method is called. However, at this point, we don't know the interface
mode, that only comes later.

So this gets interesting, and there is no indication in the commit
message this has been thought about.

    Andrew

---
pw-bot: cr

