Return-Path: <netdev+bounces-130176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD0E988E9C
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 10:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED7A4B21532
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C134184532;
	Sat, 28 Sep 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hPwCbCM6"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BF14A96;
	Sat, 28 Sep 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727513577; cv=none; b=YbiDWni+AKBi+OjB6B9c9oRcDyrn7GdkqIZedKwLzES/V1EGFTMSSwqa5tjIj/UmY6cLO3VZvqli4bxoRXAmBxgKCf906spP/ds0BFeOvMrsFEpE9IVgkk5nNbeIM/gyi6PExwHBZ7pHnicTH5aCEax9DuYNn1M06JuFLb17tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727513577; c=relaxed/simple;
	bh=LNjMKyjVSfHxInOWlB47fxPqDwE/l+Ptv8He1D8GMHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cedANOggGty+IRHW06SpwXybKehaZyaEtMoI6ibvX5GMDKoge9Ol/QIN/SIvs1UqR+DIbcTL+OegAMnbsNx2wZFK0ZIkcOGuE+rgR5lCEQ8xc+h1CxQac9EBogTAO2tM2S/z/+4q6ndWaqBuUqIBjsEgiM4aAQ7EZtSNYWCrpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hPwCbCM6; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35F5CC0006;
	Sat, 28 Sep 2024 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727513566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxaHERXSPXpBstiT8Z7ypWFbQiGKhSYTsnQt5D7bf0o=;
	b=hPwCbCM6UTnPbRrYa3n2JsWBMp0fCnx++0udF/U66JGoK31ZaoiOKG7LGGSCEvUJOsE80G
	W1NxFRtiqkmXXpi/DqjL7SeU2z9nP/CTEc6Robm1Wbl5gBzwUs8LBLPidnxXZA32U9KUp2
	o6z+Q5JYmGDkAzsNxpqAKVFgPMqpqgXeuDqDwlj7CfHpYhsRrSCi22OCrJIavEgd2mubZN
	CKi4W1Mk0tDpD/66YDinzcXgDhq8pHEFXB4NGcWNGfzWYY/zS4FYkX9R4v6svKTZTjFSQP
	tgPnwbLbzFIVYeYz+gtYkd2l0Hr52lQ5xqximL9ioDWrYLu3JQCol4mfO2lUyg==
Date: Sat, 28 Sep 2024 10:52:42 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>, Brad Griffis <bgriffis@nvidia.com>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>, Jon Hunter
 <jonathanh@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 <kernel@quicinc.com>
Subject: Re: [PATCH net v4 2/2] net: phy: aquantia: remove usage of
 phy_set_max_speed
Message-ID: <20240928105242.5fe7f0e1@fedora.home>
In-Reply-To: <048bbc09-b7e1-4f49-8eff-a2c6cec28d05@quicinc.com>
References: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
	<20240927010553.3557571-3-quic_abchauha@quicinc.com>
	<20240927183756.16d3c6a3@fedora.home>
	<048bbc09-b7e1-4f49-8eff-a2c6cec28d05@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 27 Sep 2024 12:42:36 -0700
"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com> wrote:

> On 9/27/2024 9:37 AM, Maxime Chevallier wrote:
> > Hi,
> > 
> > On Thu, 26 Sep 2024 18:05:53 -0700
> > Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
> >   
> >> Remove the use of phy_set_max_speed in phy driver as the
> >> function is mainly used in MAC driver to set the max
> >> speed.
> >>
> >> Instead use get_features to fix up Phy PMA capabilities for
> >> AQR111, AQR111B0, AQR114C and AQCS109
> >>
> >> Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
> >> Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
> >> Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
> >> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
> >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>  
> > 
> > [...]
> >   
> >> +static int aqr111_get_features(struct phy_device *phydev)
> >> +{
> >> +	unsigned long *supported = phydev->supported;
> >> +	int ret;
> >> +
> >> +	/* Normal feature discovery */
> >> +	ret = genphy_c45_pma_read_abilities(phydev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* PHY FIXUP */
> >> +	/* Although the PHY sets bit 12.18.19, it does not support 10G modes */
> >> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
> >> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, supported);
> >> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, supported);
> >> +
> >> +	/* Phy supports Speeds up to 5G with Autoneg though the phy PMA says otherwise */
> >> +	linkmode_or(supported, supported, phy_gbit_features);
> >> +	/* Set the 5G speed if it wasn't set as part of the PMA feature discovery */
> >> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> >> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);  
> > 
> > As you are moving away from phy_set_max_speed(phydev, 5000), it should mean
> > that what used to be in the supported bits already contained the
> > 5GBaseT bit, as phy_set_max_speed simply clears the highest speeds.
> > 
> > In such case, calling the newly introduced function from
> > patch 1 should be enough ?
> >   
> 
> Well i am not sure about how other phy(AQR111, AQR111B0, AQR114C and AQCS109) behaved, 
> but based on my testing and observation with AQR115c, it was pretty clear that 
> the phy did not advertise Autoneg capabilities, did not set lower speed such as 10M/100M/1000BaseT
> ,it did set capabilities beyond what is recommended in the data book.
> 
> So the below mentioned phys such as 
> 
> AQR111, AQR111B0, AQR114C = supports speed up to 5Gbps which means i cannot use the function
> defined in the previous patch as that sets speeds up to 2.5Gbps and all lower speeds. 
> 
> AQCS109 = supports speed up to 2.5Gbps and hence i have reused the same function aqr115c_get_features
> as part of this patch.

I understand your point, and it's hard indeed to be sure that no
regression was introduced. It does feel like you're reading the PHY
features, then reconstructing them almost from scratch again, but given
that the PMA report looks totally incorrect, there not much choice
indeed. So that's fine for me then.

Maxime

