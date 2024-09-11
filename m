Return-Path: <netdev+bounces-127537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4423975B3D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F22B2493F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF41B7917;
	Wed, 11 Sep 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mBVlj++c"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1D1B9B3C;
	Wed, 11 Sep 2024 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084912; cv=none; b=Pc0p8eqWa3ILnVP0LPmMilM+nDPcKy9Khd2YvToTd57nURbA+oyzlXjwgOv6GuDVMpKj6bvi0kLTDqBcCYTS1jvIpCuTCZsM04L1t5txaTYWbxGohTQgossa3je0T58t4NEgk6TOPfZvhsfeECZAd7iYMkPOUJgWB1BWhpusySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084912; c=relaxed/simple;
	bh=FpdjClVoHHWR+ARep/LeXjnqMkyz2U2hSARxOlhlcRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVCDKd46b8tJxXfG1c6LVCRSa4C6GSfhHf1J01XajVvxxPHrvnTdoS7bKf0SHK/g21KQgTPGK6UKlEzb38lil+3c+IrsGzv/uiIixmU6I4u0HMqfGaxBXsbKFbtb6Oa9bzGu/O/VRUqZpYyihMq8Puk05P19ZVO51N8VsFFkz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mBVlj++c; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32DA660002;
	Wed, 11 Sep 2024 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726084902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSAkj6FfETG19IidX84HFz+nPwNTGpFQFTsmpZCoCiI=;
	b=mBVlj++caxwAdyH8L+HL0ENdkn6km3uNitSkyyzyfPg6PU0FE3r3/Wg2aPaQxWf1Fjd4RD
	XmcdwZPb7Z1pn0tGR8/jx/ASzNp344YYy29OjrjOox/WKIKhHGu2dD+KJre2LRiX8wOxlo
	v3mDbpil3tVE9alWm2GKiD+4TMxEz3BbCGhEbjkwG9YX8u/2f9ejEUbYzPxsnKBLMxXasA
	zvpNeUkXK1P62GY7vSThJeq53ydvEPLHVErSwCmpCRHKxFlR/GexkGKzGZ30sSGRcvjAYb
	BpuUSYqTPErvZVx1ttHDVyPITmXV8SRTNLEhM2vSHtybdPmha1k2JU9uqc1Mtg==
Date: Wed, 11 Sep 2024 22:01:38 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, linux@armlinux.org.uk, rdunlap@infradead.org,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 5/5] net: lan743x: Add Support for 2.5G SFP
 with 2500Base-X Interface
Message-ID: <20240911220138.30575de5@fedora.home>
In-Reply-To: <82067738-f569-448b-b5d8-7111bef2a8e9@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
	<20240911161054.4494-6-Raju.Lakkaraju@microchip.com>
	<82067738-f569-448b-b5d8-7111bef2a8e9@lunn.ch>
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

On Wed, 11 Sep 2024 19:31:01 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > @@ -3359,6 +3362,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
> >  	lan743x_phy_interface_select(adapter);
> >  
> >  	switch (adapter->phy_interface) {
> > +	case PHY_INTERFACE_MODE_2500BASEX:
> >  	case PHY_INTERFACE_MODE_SGMII:
> >  		__set_bit(PHY_INTERFACE_MODE_SGMII,
> >  			  adapter->phylink_config.supported_interfaces);  
> 
> I _think_ you also need to set the PHY_INTERFACE_MODE_2500BASEX bit in
> phylink_config.supported_interfaces if you actually support it.

It's actually being set a bit below. However that raises the
question of why.

On the variant that don't have this newly-introduced SFP support but do
have sgmii support (!is_sfp_support_en && is_sgmii_en), can this chip
actually support 2500BaseX ?

If so, is there a point in getting a different default interface
returned from lan743x_phy_interface_select() depending on wether or not
there's SFP support ?

Maxime


