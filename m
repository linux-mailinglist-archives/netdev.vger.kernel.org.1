Return-Path: <netdev+bounces-97575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAFF8CC2C5
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9041C2199A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B5A824A3;
	Wed, 22 May 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m+9eVfdI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088E6AB9
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386747; cv=none; b=eJOgYTaq6jw3ta9+r04trzrHP9MgiVVJy18/v4C+zGTXrm8DVDLs8q79YhtoQghD3INCD2jSFpnkrD42jCcjsOKPq/Mw4buUW2beRD/4qG1GZTHSIEEPJzVSU1MAESkxX/w2xomrNs4UmsRs9MAkWBIUomaOms6eYA4apQ62vEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386747; c=relaxed/simple;
	bh=+Q2vapI+agZF1askg8UO3kSouJKQMHwshWrhv8llhc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZD4N2XZNDxmnoZwv17aKPEV3uKIUKzFb8n33ZOpkj1EFYHeydVqhUXu9Qdkc4rNIUp7VPeoeauBnbHGQZWi1jMQVnfZCsTHjPuEwUO/FDaRRrvyPYzTax2xvgdc/PunqJqYJB2oQGW6qtUJ5fO+g+Ihi53fTJZmmwzU2dY838g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m+9eVfdI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Q1GALha2lAeU87RmdDjdb2PNypLOaHe21BtRJSqw5oQ=; b=m+
	9eVfdIxXfAwcq/LyCJj5ABTCaj9C7c4IVmfQfNT7gbmEWxH/P9M/InrQIVLOXyi/Uo0BOMBlDLCSO
	1DgcWI74Uzh9JcsmjZfKINWE0B6V+dA8bP3GTQs+mE9gjIqZfsZny47tGdE+tkqXQJG54CQ27McU1
	3SRwLZyxcvRwJWQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9may-00FpJT-1c; Wed, 22 May 2024 16:05:32 +0200
Date: Wed, 22 May 2024 16:05:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?B?SG9y4Wss?= 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Message-ID: <b5c6b65b-d4be-4ebc-a529-679d42e56c39@lunn.ch>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-2-kamilh@axis.com>
 <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
 <96a99806-624c-4fa4-aa08-0d5c306cff25@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96a99806-624c-4fa4-aa08-0d5c306cff25@axis.com>

On Wed, May 22, 2024 at 09:34:05AM +0200, Kamil Horák, 2N wrote:
> 
> On 5/6/24 21:14, Andrew Lunn wrote:
> > On Mon, May 06, 2024 at 04:40:13PM +0200, Kamil Horák - 2N wrote:
> > > Introduce new link modes necessary for the BroadR-Reach mode on
> > > bcm5481x PHY by Broadcom and new PHY tunable to choose between
> > > normal (IEEE) ethernet and BroadR-Reach modes of the PHY.
> > I would of split this into two patches. The reason being, we need the
> > new link mode. But do we need the tunable? Why don't i just use the
> > link mode to select it?
> > 
> > ethtool -s eth42 advertise 1BR10
> 
> Tried to find a way to do the link mode selection this way but the
> advertised modes are only applicable when there is auto-negotiation, which
> is only partially the case of BCM54811: it only has auto-negotiation in IEEE
> mode.
> Thus, to avoid choosing between BroadR-Reach and IEEE mode using the PHY
> Tunable, we would need something else and I am already running out of
> ideas...
> Is there any other possibility?
> 
> In addition, we would have to check for incompatible link modes selected to
> advertise (cannot choose one BRR and one IEEE mode to advertise), or perhaps
> the BRR modes would take precedence, if there is any BRR mode selected to
> advertise, IEEE modes would be ignored.

So it sounds like multiple problems.

1) Passing a specific link mode when not using auto-neg. The current
API is:

ethtool -s eth42 autoneg off speed 10 duplex full

Maybe we want to extend that with

ethtool -s eth42 autoneg off speed 10 duplex full linkmode 1BR10

or just

ethtool -s eth42 autoneg off linkmode 1BR10

You can probably add a new member to ethtool_link_ksettings to pass it
to phylib. From there, it probably needs putting into a phy_device
member, next to speed and duplex. The PHY driver can then use it to
configure the hardware.

2) Invalid combinations of link modes when auto-neg is
enabled. Probably the first question to answer is, is this specific to
this PHY, or generic across all PHYs which support BR and IEEE
modes. If it is generic, we can add tests in
phy_ethtool_ksettings_set() to return EINVAL. If this is specific to
this PHY, it gets messy. When phylib call phy_start_aneg() to
configure the hardware, it does not expect it to return an error. We
might need to add an additional op to phy_driver to allow the PHY
driver to validate settings when phy_ethtool_ksettings_set() is
called. This would help solve a similar problem with a new mediatek
PHY which is broken with forced modes.

    Andrew

