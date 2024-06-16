Return-Path: <netdev+bounces-103891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976A9909FF9
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 23:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FC5B20EB4
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FFA2575A;
	Sun, 16 Jun 2024 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A6HLMMjK"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1B36BFA6;
	Sun, 16 Jun 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718573527; cv=none; b=Xs6Gewj+/mmz5Fbd61yh1mH+wh8LLeKgd5OznmRfUjIQDELi8P4IGMPF+tWjlY/UOl0sPapVePvFZgMOfooR0fC7eJ1rt2JB35+nWRRt4VHs7Z+oH7l9sav02Zfa/XSGlOw8LHTYkXyDrVt+czm2cEDHCE3XTKMR2HdVulYWf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718573527; c=relaxed/simple;
	bh=e3mPHRNbPAI0RpRaRBYxdYiAyOtMA8BSTjFOQ/dqqno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfUnenVX4speILaDPltH4nLp305mZLOV89obsWR3dYoST3T39CaYdb4nrw8G6OfqyjQInVPWPIqnKDmEzPOVWFMR6cy9c8hD4geBxOC6GNckwOmrpEhawRoi1lfBWh99BM34kcj9CLH8BOXXtZnu/llmQWhZeTqnN/K4OO30v34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A6HLMMjK; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AC8B40003;
	Sun, 16 Jun 2024 21:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718573522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSk/4wckBenK2m2J+umiKHrWAQgsVWf7caDnp2mQsvo=;
	b=A6HLMMjKnO50sE190j6lsh0HdRCTuV0ZKE4L6bXHg0/AkdKbBNq+SO/fv88fq2M4WJ3lN/
	Y8JHa3BtHVFPM2u39juvHhaY5d9nfbmEGP8cdM291w2yWxjmYhfO/yKYER40Q1DtIOn6Zi
	JpSDKWlF6OEgJtwn3VKG8Jw7Q8D3csqJQC+nadTHLewCUy1AntBuTaFw8traq9oZrklljX
	LU/K/zbg68tMrwIJMm+8+cg4pQ8WGBHBtXVIew/HGOGtu6E2JCq6BWwrsODj4S6V2V1xY8
	ePPhcBeTW+VRqx5INuYsKUGtmlZH7P2c6mclEorwjTVNGx7KBiVkaU50QTGXvw==
Date: Sun, 16 Jun 2024 23:31:52 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <20240616233152.64f06133@fedora>
In-Reply-To: <Zm8NrEproHTPzo+O@shell.armlinux.org.uk>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240607071836.911403-6-maxime.chevallier@bootlin.com>
	<20240613182613.5a11fca5@kernel.org>
	<20240616180231.338c2e6c@fedora>
	<9dbd5b23-c59d-4200-ab9c-f8a9d736fea6@lunn.ch>
	<Zm8NrEproHTPzo+O@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

> > It gets interesting with copper SFP. They contain a PHY, and that PHY
> > can physically disappear at any time. What i don't know is when the
> > logical representation of the PHY will disappear after the hotunplug
> > event.

I'm replying to your mail to summarize what the topology code does,
which I think is correct according to these explanations.

> 
> On a SFP module unplug, the following upstream device methods will be
> called in order:
> 1. link_down
> 2. module_stop
> 3. disconnect_phy

Patch 03 adds a phy_sfp_connect_phy() / phy_sfp_disconnect_phy() set of
helpers that new PHY drivers supporting downstream SFP busses must
specify in their sfp_upstream_ops, which will add/remove the SFP phy
to/from the topology. I realize now that I need to add some clear
documentation so that new drivers get that right.

That is because in this situation, the SFP PHY won't be attached to the
netdev (as the media-converter PHY already is), so relying on the
phy_attach / phy_detach paths won't cover these cases.

> 
> At this point, the PHY device will be removed (phy_device_remove()) and
> freed (phy_device_free()), and shortly thereafter, the MDIO bus is
> unregistered and thus destroyed.
> 
> In response to the above, phylink will, respectively for each method:
> 
> 1. disable the netdev carrier and call mac_link_down()
> 2. call phy_stop() on the attached PHY
> 3. remove the PHY from phylink, and then call phy_disconnect(),
>    disconnecting it from the netdev.
> 
> Thus, when a SFP PHY is being removed, phylib will see in order the
> following calls:
> 
> 	phy_disconnect()
> 	phy_device_remove()
> 	phy_device_free()
> 
> Provided the topology linkage is removed on phy_disconnect() which
> disassociates the PHY from the netdev, SFP PHYs should be fine.
> 

And here in that case, there's a hook in phy_detach() to remove the phy
from the topology as well, which deals with the case where phylink
deals with the sfp_upstream_ops. I think this covers all cases :)

Thanks,

Maxime

