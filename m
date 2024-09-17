Return-Path: <netdev+bounces-128677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF897ADEA
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 11:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C051F226C7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19200136357;
	Tue, 17 Sep 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gu6Q2U2i"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BF1B85F2;
	Tue, 17 Sep 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565508; cv=none; b=k/bApyifWsZ19TkvL/uaU3vVNgTTArrzbm8Reo4LCIDuAv62Giqy8X8D/tiMQ7yHm+ZciKhfSEH76h9G1qe/8sJLuZUlHnTpEZxUKTb/L3IL0DeuK8nNffc/9oh0FHQHcLS2yNiQPdtPYjK7EX6w2o8GpmusQHk6mgVwSdymzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565508; c=relaxed/simple;
	bh=O2a+Oiznnfr39q1WHYvUi3bS5nR9VGGF80YmSNB1+p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knW0kKhFuVEYvIB/w10B58mI9L4LXfZbNJ4t/tiHB0+ztV+ABx+bvI/QuILrl9ilJVoFr+cmafVLE0glm2NCnRQ186ryDaQIvfWTn7d2dAB3xj81w2k3cqTj8He2kOzVjlMyFeL1GjSpEHGS/+lwWeAtSkeJZUN3AX+OUslAQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gu6Q2U2i; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D2nwWI3Emvau8l3vnQcwMeyeAoCsqAXmz1yCb+VyKQ8=; b=gu6Q2U2iaAmrEQDciENKJWXfU4
	BtMhUQnDKDVpsvFn1C60Hgak0+Gwdph0+DX1RjqRIdaH/IuSkqPb5xV6RFhw2x1v/R0hm0NcqJKsq
	fl3c0KqRBzVsbZHtHeO3imBREveu4lAHFNvoxVSnPrk4c9RiNiKUPwZigku+y3vPHVzSye6lFcm6u
	gFlU8WNeb/1g3ESsxg4Rfi98EUdoGwQMSptNFfhLrTlJ/ajP201XPIS0gZazYqEFVx/EZHekcXwoq
	pMfWFipASI3VRby9oLARAySC8RoMMYiViq9ehFwEqhWvrttu7M7kag5ugzqEHzpg9bk2NtySrjSmy
	NkMIkb9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36978)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqUYZ-0006ng-1I;
	Tue, 17 Sep 2024 10:31:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqUYU-0007rf-1e;
	Tue, 17 Sep 2024 10:31:30 +0100
Date: Tue, 17 Sep 2024 10:31:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Halaney <ahalaney@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>, kernel@quicinc.com
Subject: Re: [RFC PATCH net v1] net: phy: aquantia: Set phy speed to 2.5gbps
 for AQR115c
Message-ID: <ZulMct3UGzlfxV1T@shell.armlinux.org.uk>
References: <20240913011635.1286027-1-quic_abchauha@quicinc.com>
 <20240913100120.75f9d35c@fedora.home>
 <eb601920-c2ea-4ef6-939b-44aa18deed82@quicinc.com>
 <c6cc025a-ff13-46b8-97ac-3ad9df87c9ff@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6cc025a-ff13-46b8-97ac-3ad9df87c9ff@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 13, 2024 at 06:35:17PM +0200, Andrew Lunn wrote:
> On Fri, Sep 13, 2024 at 09:12:13AM -0700, Abhishek Chauhan (ABC) wrote:
> > On 9/13/2024 1:01 AM, Maxime Chevallier wrote:
> > > Hi,
> > > 
> > > On Thu, 12 Sep 2024 18:16:35 -0700
> > > Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
> > > 
> > >> Recently we observed that aquantia AQR115c always comes up in
> > >> 100Mbps mode. AQR115c aquantia chip supports max speed up to
> > >> 2.5Gbps. Today the AQR115c configuration is done through
> > >> aqr113c_config_init which internally calls aqr107_config_init.
> > >> aqr113c and aqr107 are both capable of 10Gbps. Whereas AQR115c
> > >> supprts max speed of 2.5Gbps only.
> > >>
> > >> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
> > >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> > >> ---
> > >>  drivers/net/phy/aquantia/aquantia_main.c | 7 +++++++
> > >>  1 file changed, 7 insertions(+)
> > >>
> > >> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> > >> index e982e9ce44a5..9afc041dbb64 100644
> > >> --- a/drivers/net/phy/aquantia/aquantia_main.c
> > >> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> > >> @@ -499,6 +499,12 @@ static int aqr107_config_init(struct phy_device *phydev)
> > >>  	if (!ret)
> > >>  		aqr107_chip_info(phydev);
> > >>  
> > >> +	/* AQR115c supports speed up to 2.5Gbps */
> > >> +	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX) {
> > >> +		phy_set_max_speed(phydev, SPEED_2500);
> > >> +		phydev->autoneg = AUTONEG_ENABLE;
> > >> +	}
> > >> +
> > > 
> > > If I get your commit log right, the code above will also apply for
> > > ASQR107, AQR113 and so on, don't you risk breaking these PHYs if they
> > > are in 2500BASEX mode at boot?
> > > 
> > 
> > I was thinking of the same. That this might break something here for other Phy chip. 
> > As every phy shares the same config init. Hence the reason for RFC. 
> > 
> > > Besides that, if the PHY switches between SGMII and 2500BASEX
> > > dynamically depending on the link speed, it could be that it's
> > > configured by default in SGMII, hence this check will be missed.
> > > 
> > > 
> > I think the better way is to have AQR115c its own config_init which sets 
> > the max speed to 2.5Gbps and then call aqr113c_config_init . 
> 
> phy_set_max_speed(phydev, SPEED_2500) is something a MAC does, not a
> PHY. It is a way for the MAC to say is supports less than the PHY. I
> would say the current aqcs109_config_init() is doing this wrong.

Agreed on two points:

1) phy_set_max_speed() is documented as a function that the MAC will
call.

2) calling phy_set_max_speed() in .config_init() is way too late for
phylink. .config_init() is called from phy_init_hw(), which happens
after the PHY has been attached. However, phylink needs to know what
the PHY supports _before_ that, especially for any PHY that is on a
SFP, so it can determine what interface to use for the PHY.

So, as Andrew says, the current aqcs109_config_init(), and it seems
aqr111_config_init() are both broken.

The PHY driver needs to indicate to phylib what is supported by the
PHY no later than the .get_features() method.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

