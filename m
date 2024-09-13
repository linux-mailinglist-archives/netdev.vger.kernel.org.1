Return-Path: <netdev+bounces-128174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373CC9785E0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628FE1C226F5
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474AD78C76;
	Fri, 13 Sep 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X6kBPxs7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5A42042;
	Fri, 13 Sep 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245333; cv=none; b=Q8U8Z3a8VAgJSZMWeEx0TZPZFyNqy7WMdM8zhojX1wRui64vQtbaFO4a7COf77wA6qPB/FrrwAPRuqamvIQ4w3Szop0Y+1Z3K6NlgIjoQKV8PzqECyon3pLC0tox0omt+vag+aZvY8RmiYmpBegZ1CGbTvuqQXigSahM/hs5css=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245333; c=relaxed/simple;
	bh=T2pd9fU2uXhAhd/79ReNX8YL90EYw1Bh8Hxy1xPrjuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toIwgSgRy+WslUX5Q4tjRY91gwkIse2VJpkIzMrPkRaozXBDWdCpv7R4HuGFVrvv8UXBqDCCWztxlg/BzBHKCriONzjfAs5DL8uEFuT1/loKtw9/DUezGc9TzaKkGyUDqr5K/Q/aKOldYt1Obn+4rEeXSanI806ahQR0xvD3txc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X6kBPxs7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NvQeKqINDe9BGuZt2sVV/yzBJPL+/sx73RLk8FZnAxs=; b=X6kBPxs781s6RhYdKmpKavptU5
	ynqbtxTZN+YoNOpiiO6HxFGUoTJZFdbOOXMtIaH04XLVqI7k9sbYqy/b/B+cwBrc6sDVwcfpAjAii
	q3HgtF/iqDku/kBnEbWN//fq/khFoWUYts4o0bP2zlZ1SXrbCaHZb1oLAKNiWB/qRykM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sp9GP-007PKM-5J; Fri, 13 Sep 2024 18:35:17 +0200
Date: Fri, 13 Sep 2024 18:35:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Halaney <ahalaney@redhat.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>, kernel@quicinc.com
Subject: Re: [RFC PATCH net v1] net: phy: aquantia: Set phy speed to 2.5gbps
 for AQR115c
Message-ID: <c6cc025a-ff13-46b8-97ac-3ad9df87c9ff@lunn.ch>
References: <20240913011635.1286027-1-quic_abchauha@quicinc.com>
 <20240913100120.75f9d35c@fedora.home>
 <eb601920-c2ea-4ef6-939b-44aa18deed82@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb601920-c2ea-4ef6-939b-44aa18deed82@quicinc.com>

On Fri, Sep 13, 2024 at 09:12:13AM -0700, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 9/13/2024 1:01 AM, Maxime Chevallier wrote:
> > Hi,
> > 
> > On Thu, 12 Sep 2024 18:16:35 -0700
> > Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
> > 
> >> Recently we observed that aquantia AQR115c always comes up in
> >> 100Mbps mode. AQR115c aquantia chip supports max speed up to
> >> 2.5Gbps. Today the AQR115c configuration is done through
> >> aqr113c_config_init which internally calls aqr107_config_init.
> >> aqr113c and aqr107 are both capable of 10Gbps. Whereas AQR115c
> >> supprts max speed of 2.5Gbps only.
> >>
> >> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
> >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> >> ---
> >>  drivers/net/phy/aquantia/aquantia_main.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> >> index e982e9ce44a5..9afc041dbb64 100644
> >> --- a/drivers/net/phy/aquantia/aquantia_main.c
> >> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> >> @@ -499,6 +499,12 @@ static int aqr107_config_init(struct phy_device *phydev)
> >>  	if (!ret)
> >>  		aqr107_chip_info(phydev);
> >>  
> >> +	/* AQR115c supports speed up to 2.5Gbps */
> >> +	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX) {
> >> +		phy_set_max_speed(phydev, SPEED_2500);
> >> +		phydev->autoneg = AUTONEG_ENABLE;
> >> +	}
> >> +
> > 
> > If I get your commit log right, the code above will also apply for
> > ASQR107, AQR113 and so on, don't you risk breaking these PHYs if they
> > are in 2500BASEX mode at boot?
> > 
> 
> I was thinking of the same. That this might break something here for other Phy chip. 
> As every phy shares the same config init. Hence the reason for RFC. 
> 
> > Besides that, if the PHY switches between SGMII and 2500BASEX
> > dynamically depending on the link speed, it could be that it's
> > configured by default in SGMII, hence this check will be missed.
> > 
> > 
> I think the better way is to have AQR115c its own config_init which sets 
> the max speed to 2.5Gbps and then call aqr113c_config_init . 

phy_set_max_speed(phydev, SPEED_2500) is something a MAC does, not a
PHY. It is a way for the MAC to say is supports less than the PHY. I
would say the current aqcs109_config_init() is doing this wrong.

> > Is the AQR115c in the same situation as AQR111 for example, where the
> > PMA capabilities reported are incorrect ?

This is the approach to follow. The PHY registers should report what
it is actually capable of. But some aquantia PHYs get this
wrong. Please check if this is also true for your PHY. Look at what
genphy_c45_pma_read_abilities() is doing.

You might need to implement a .get_feature callback for this PHY which
first calls genphy_c45_pma_read_abilities() and then manually fixes up
what the PHY gets wrong.

	Andrew     	

