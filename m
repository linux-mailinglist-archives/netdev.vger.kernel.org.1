Return-Path: <netdev+bounces-60989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF4822186
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EC11C204DB
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CCA15ACB;
	Tue,  2 Jan 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jigvRpLJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319315E94
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mmVmQhZwktm1Hw+NZEEcN7EjqEI6Ht/JmaP7qk2BUmA=; b=jigvRpLJp6J1NXQLLq6neI68Jk
	qan3/55f9OsuZoKOksGycQovEIUXPeMTN9GiLx6UOtm2bCo0Cq6Qs0f/0QdxTE//L183ozpfAsIZj
	iDhIwAosAPW7fnte8lsahFEPVceUjWti+afNMzYv6oP62gOHe6DgATE+OJGHW/ltBjIltv6FsCOuB
	8lVqDQzvCs+B0GLjp9knwmZPZ9mE/IGy3zPQmmx+TsLOUVaBhvnAhoJZr6CvW/wHimcXmVOAba3T5
	aZQO4oecmPPxOwlk3HKHNA4QH+5yvSZuHmGAi/OxLAvLSxzCkUUhyD2TZHASO7XcawMtGiGBgFTfz
	rT1KmDXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45758)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKjxe-0006pC-1K;
	Tue, 02 Jan 2024 18:57:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKjxf-0005Yb-UJ; Tue, 02 Jan 2024 18:57:59 +0000
Date: Tue, 2 Jan 2024 18:57:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ezra Buehler <ezra@easyb.ch>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Michael Walle <michael@walle.cc>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Message-ID: <ZZRct1o21NIKbYX1@shell.armlinux.org.uk>
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
 <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
 <8eb06ee9-d02d-4113-ba1e-e8ee99acc2fd@gmail.com>
 <2013fa64-06a1-4b61-90dc-c5bd68d8efed@lunn.ch>
 <CAM1KZSn0+k4YKc2qy6DEafkL840ybjaun7FbD4OFwOwNZw_LEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM1KZSn0+k4YKc2qy6DEafkL840ybjaun7FbD4OFwOwNZw_LEg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 02, 2024 at 07:08:32PM +0100, Ezra Buehler wrote:
> Hi Andrew,
> 
> On Tue, Jan 2, 2024 at 4:50 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > I do however disagree with this statement in the original patch:
> >
> > > AFAICT all SMSC/Microchip PHYs are Clause 22 devices.
> 
> Excuse my ignorance, I am by no means an expert here. I guess what I
> wanted to say was:
> 
> By skimming over some datasheets for similar SMSC/Microchip PHYs, I
> could not find any evidence that they support Clause 45 scanning
> (other than not responding).
> 
> > drivers/net/phy/smsc.c has a number of phy_write_mmd()/phy_read_mmd()
> > in it. But that device has a different OUI.
> 
> I guess I am confused here, AFAICT all PHYs in smsc.c have the same OUI
> (phy_id >> 10).
> 
> > However, the commit message says:
> >
> > > Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
> > > least with our setup) considerably slow down kernel startup and
> > > ultimately result in a board reset.
> >
> > So we need to clarify the real issue here. Does the C45 scan work
> > correctly, but the board watchdog timer is too short and fires? We
> > should not be extended this workaround when its a bad watchdog
> > configuration issue...
> 
> Changing the watchdog configuration is not an option here. We are
> talking about a slowdown of several seconds here, that is not acceptable
> on its own.

Any ideas why the scan is taking so long?

For each PHY address (of which there are 32) we scan each MMD between
1 and 31 inclusive. We attempt to read the devices-in-package
registers. That means 32 * 32 * 2 calls to the mdiobus_c45_read(),
which is 2048 calls. Each is two MDIO transactions on the bus, so
that's 4096. Each is 64 bits long including preamble, and at 2.5MHz
(the "old" maximum) it should take about 100ms to scan the each
MMD on each PHY address to determine whether a device is present.

I'm guessing the MDIO driver you are using is probably using a software
timeout which is extending the latency of each bus frame considerably.
Maybe that is where one should be looking if the timing is not
acceptable?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

