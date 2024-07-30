Return-Path: <netdev+bounces-114079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECDF940DFE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3152281AB4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D869194C85;
	Tue, 30 Jul 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O32YBr3H"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07F18EFE0;
	Tue, 30 Jul 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332492; cv=none; b=FpDLLeCsTAWCidKRMue6R8u3RtPKzG6Nu6w8f9LqiJdFjgqxh8UTel+ILMIfb1lsJvR24lVYycQnjBIani19ZKsAiErS/PzWqGfQ8YU1gqQjwSTR2xZ5ErmX/tNP7h7JXDkD9ppnbpLWx5/E1kScpDpVrQ3LyM+j+L3qvWSCslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332492; c=relaxed/simple;
	bh=s3ANVzZF+5NGbOWvSBqbujKj3AgCyyycZRtEQ8h7dkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBMxstHqgSQiuf5sRDaJ7PAYT3xEbPs+WKVme1MAVaUvCp3t7rgTpRtgZLLKRD4WMa/kgBWLmkvSR00AjhauiA9JgumY7CO673v93DjKtf1OttUVSRy5QNidtRfZNloHX09+X6cggPgjHn8GGhSIjtsNDiwflRVoFQRY6zDSxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O32YBr3H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aNakhGI1s+LEKrlZKgYGYbobUN/9tk4gyC89XkEBTmY=; b=O32YBr3HiFm1qAFIN5qdLmqMSp
	a2Noh31PYjr4IeVL0Vf16qk36LXujwMfJsJ7DiPddi9o60MJ1OCbV3tiZFEjUbXXT+rvFXQdecStF
	Qq9rVFRoDsocmDZQlBy8eEj95C+YcaVkRX/ll3jeuHdbqH1+7D6iSLTUk/AaR8ml3q7++3i/6JDI5
	FA/9EH1B5OJyuSOX3WJwKHOXYPN5ZEArb1KwY6UX/leeRIlat46rHpL2B6g5nkcSxqbRoR3sk9j0G
	B9GlUg0/y3FRl61UygZfZxpU+etpMTeAMPBeX05BOumQRyLVPn7K9p/KuUttvVoHq06NTyg5pGWoU
	PtbUR10Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55442)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYjLz-0006DV-1O;
	Tue, 30 Jul 2024 10:41:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYjM3-0005B3-JW; Tue, 30 Jul 2024 10:41:15 +0100
Date: Tue, 30 Jul 2024 10:41:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Revanth Kumar Uppala <ruppala@nvidia.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
Message-ID: <Zqi1O88vXK3Uonr1@shell.armlinux.org.uk>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-3-ruppala@nvidia.com>
 <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
 <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
 <ZL5nQxCyj8x+5lWk@shell.armlinux.org.uk>
 <bb949d68-3229-45b8-964c-54ccf812f6f8@nvidia.com>
 <ZqdzOxYJiRyft1Nh@shell.armlinux.org.uk>
 <2aefce6d-5009-491b-b797-ca318e8bad4e@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aefce6d-5009-491b-b797-ca318e8bad4e@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 30, 2024 at 10:36:12AM +0100, Jon Hunter wrote:
> 
> On 29/07/2024 11:47, Russell King (Oracle) wrote:
> 
> ...
> 
> > > Apologies for not following up before on this and now that is has been a
> > > year I am not sure if it is even appropriate to dig this up as opposed to
> > > starting a new thread completely.
> > > 
> > > However, I want to resume this conversation because we have found that this
> > > change does resolve a long-standing issue where we occasionally see our
> > > ethernet controller fail to get an IP address.
> > > 
> > > I understand that your objection to the above change is that (per Revanth's
> > > feedback) this change assumes interface has the link. However, looking at
> > > the aqr107_read_status() function where this change is made the function has
> > > the following ...
> > > 
> > > static int aqr107_read_status(struct phy_device *phydev)
> > > {
> > >          int val, ret;
> > > 
> > >          ret = aqr_read_status(phydev);
> > >          if (ret)
> > >                  return ret;
> > > 
> > >          if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
> > >                  return 0;
> > > 
> > > 
> > > So my understanding is that if we don't have the link, then the above test
> > > will return before we attempt to poll the TX ready status. If that is the
> > > case, then would the change being proposed be OK?
> > 
> > Here, phydev->link will be the _media_ side link. This is fine - if the
> > media link is down, there's no point doing anything further. However,
> > if the link is up, then we need the PHY to update phydev->interface
> > _and_ report that the link was up (phydev->link is true).
> > 
> > When that happens, the layers above (e.g. phylib, phylink, MAC driver)
> > then know that the _media_ side interface has come up, and they also
> > know the parameters that were negotiated. They also know what interface
> > mode the PHY is wanting to use.
> > 
> > At that point, the MAC driver can then reconfigure its PHY facing
> > interface according to what the PHY is using. Until that point, there
> > is a very real chance that the PHY <--> MAC connection will remain
> > _down_.
> > 
> > The patch adds up to a _two_ _second_ wait for the PHY <--> MAC
> > connection to come up before aqr107_read_status() will return. This
> > is total nonsense - because waiting here means that the MAC won't
> > get the notification of which interface mode the PHY is expecting
> > to use, therefore the MAC won't configure its PHY facing hardware
> > for that interface mode, and therefore the PHY <--> MAC connection
> > will _not_ _come_ _up_.
> > 
> > You can not wait for the PHY <--> MAC connection to come up in the
> > phylib read_status method. Ever.
> > 
> > This is non-negotiable because it is just totally wrong to do this
> > and leads to pointless two second delays.
> 
> 
> Thanks for the feedback! We will go away, review this and see if we can
> figure out a good/correct way to resolve our ethernet issue.

Which ethernet driver is having a problem?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

