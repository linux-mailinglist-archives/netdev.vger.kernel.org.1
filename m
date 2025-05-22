Return-Path: <netdev+bounces-192756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557CDAC10E0
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C21C501DBF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA0170A23;
	Thu, 22 May 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QSiK299A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384C7DA73;
	Thu, 22 May 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930771; cv=none; b=NAaZaE+fScSAC/OXRVMwfBqF7zs6XOddsoYmlIILg5rZ/3k4yqVprqt1mPKj3nRgMMnRLiBW8FA6NMxkVyR9GzRnlN3D1snXTXHTrPK389SpzK6Iyi0Y7QP244f4VnldJfSM2m6UimWHRAR1rgiTJbxWRM9xqLEesktxE0UvmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930771; c=relaxed/simple;
	bh=iBE7Lob++OOfoLrW8v5UQ4fc6DSc6z/13VLQ6i+h49Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJ4vEijIG2SYI6w3fEyyQV98VbPkyYD3tdqguY4X6Mn1qQAABII5bn9WXtwrNDpSxRLsJD+SyikNetbRYEpmLt2Fc82UFD3jxQwEPrGuGXFWg6a/S4qO5LS711cO1OLW67dAWaJ4Sge4fuUciztmG8/KPhngBxXOLsbdtHkHJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QSiK299A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xW2yJXrDkikvHHO+re2mbxIzKOAy7tNs68ZEuANiRbo=; b=QSiK299AFsqBJlUww7GUw0Xbav
	DFIs2FP+PpruzGhrbynwbH4dpD8UNSvZZzuumJad5A4OK0SbjGSoNalO9pTsXp5Isa35noZ76C9UX
	7T2t8YnDsfzQIqH1KeC4XDSkOtQdpKmQWG9Sqa+O2VHaCAFSYSS1EPgNy+V+HTDSFmr4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uI8dV-00DVwB-N0; Thu, 22 May 2025 18:19:13 +0200
Date: Thu, 22 May 2025 18:19:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"xiaolei.wang@windriver.com" <xiaolei.wang@windriver.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net] net: phy: clear phydev->devlink when the link is
 deleted
Message-ID: <d8cb2a8f-af3d-4042-96a3-a762df1876a9@lunn.ch>
References: <20250522064253.3653521-1-wei.fang@nxp.com>
 <f19659d4-444c-4f44-9bff-4c83a8c5a7e9@lunn.ch>
 <PAXPR04MB851054C5E1049B5361A46C108899A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB851054C5E1049B5361A46C108899A@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Thu, May 22, 2025 at 01:57:20PM +0000, Wei Fang wrote:
> > On Thu, May 22, 2025 at 02:42:53PM +0800, Wei Fang wrote:
> > > The phydev->devlink is not cleared when the link is deleted, so calling
> > > phy_detach() again will cause a crash.
> > 
> > I would say crashing is correct. You have done something you should
> > not do, and the crash helped you find it. phy_attach() and
> > phy_detach() should always be in pairs.
> > 
> 
> phy_attach() and phy_detach() are called in pairs in my case. When
> re-enabling the network port, if an error occurs in the phy_attach_direct(),
> For example, if phy_init_hw() returns an error, it will jump to the error
> path and call phy_detach(). Because phy_detach() did not clear the
> phydev->devlink pointer when the network port was disabled,
> device_link_del() will access a NULL pointer and cause a crash. And this
> crash may cause the CPU to hang. I don't think it is reasonable to cause
> the CPU to hang.

Ah, now i get it...

phy_attach_direct() runs, but fails early, before the call to:

phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
						  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);

So it has its old value, from a previous attach/detach cycle. At the
error: label, it calls phy_detach(phydev), which does a
device_link_del(), using the old value...

Please improve your changelog message, add more details.

    Andrew

---
pw-bot: cr

