Return-Path: <netdev+bounces-77048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901086FF13
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2AE1C20A2D
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A218625756;
	Mon,  4 Mar 2024 10:31:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716E249F4
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548315; cv=none; b=Yc6UN4xnSe/h5wq9r24i2qqEygEeMpf272MBBr76ZyOYwz+Vq+8vIaye7wZuB7s/VRxvZllCmO2MW2wym0Wn9976Q6ybLuNZk8BFvESJKhflAbeoEUNZOV8hf1QKachV8n8Ukmk1z8A/b2onYgigu2nu1eFnmQEqnUwKA9fdEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548315; c=relaxed/simple;
	bh=FlayRBYu6A31qOHMHpZ5ejYBRbr7TX0lwoHUNTBNul8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL5l1yRf/iYmZHOkDttj7EZdwyf6BaWABWQ808UQ44jvDQGeb9xPHY0Lm1VLy7V7cnbWho4aZPntbxcZNrCy++Q6DKCyP7hvLdwMKheaYTDlajGnrOS3Sn375wqsJ3SQOchTByoPkq9bfP44I3a2y4Jsz+mPUD9K3Ap+qE6BLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rh5bO-00043R-0Y; Mon, 04 Mar 2024 11:31:22 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rh5bL-004Kfu-Eo; Mon, 04 Mar 2024 11:31:19 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rh5bL-001rP7-17;
	Mon, 04 Mar 2024 11:31:19 +0100
Date: Mon, 4 Mar 2024 11:31:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <ZeWi90H-B4XeSkFs@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
 <ZeObuKHkPN3tiWz_@pengutronix.de>
 <20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Mar 04, 2024 at 10:27:08AM +0100, Köry Maincent wrote:
> Hello Oleksij,

> > > +	psec = dev_find_pse_control(&phy->mdio.dev);
> > > +	if (IS_ERR(psec)) {
> > > +		rc = PTR_ERR(psec);
> > > +		goto unregister_phy;
> > > +	}
> > > +  
> > 
> > I do not think it is a good idea to make PSE controller depend on
> > phy->mdio.dev. The only reason why we have fwnode_find_pse_control()
> > here was the missing port abstraction.
> 
> I totally agree that having port abstraction would be more convenient.
> Maxime Chevallier is currently working on this and will post it after his
> multi-phy series get merged.
> Meanwhile, we still need a device pointer for getting the regulator. The
> phy->mdio.dev is the only one I can think of as a regulator consumer.
> Another idea?

I would say, in current code state, PSE controller is regulator provider and
consumer - both are same devices. Otherwise, it will be impossible to
unregistered PHY devices without shutting down PSE-PI. Mostly, we should
be able to continue to provide the power even if network interface is down. 

> > > +	rconfig.dev = pcdev->dev;
> > > +	rconfig.driver_data = pcdev;
> > > +	rconfig.init_data = &pse_pi_initdata;  
> > 
> > Please add input supply to track all dependencies:
> >         if (of_property_present(np, "vin-supply"))
> > config->input_supply = "vin";
> > 
> > May be better to make it not optional...
> 
> Does the "vin-supply" property be added at the pse-pi node level or the
> pse-controller node level or at the hardware port node level or the manager node
> level for the pd692x0?
> Maybe better at the pse-pi node level and each PIs of the manager will get the
> same regulator?
> What do you think?

Yes, I agree. PSE-PI should share same parent regulator. Different PSE
managers may have different power supplies. One port (PSE PI) - not.

>  
> > Should be tested, but if, instead of "vin-supply", we will use
> > "pse-supply" it will make most part of pse_regulator.c obsolete.
> 
> Don't know, if it is done at the pse-pi node level it may not break
> pse_regulator.c. Not sure about it.

me too. Before your patch set, the regulator topology for PoDL PSE was
following:
power-source
  fixed-regulator
     PoDL_PSE-consumer

Now it will be:
power-source
  fixed-regulator
     PoDL_PSE-consumer
       PSE-PI-provider
         PSE-PI-consumer

By porting porting PSE framework to regulator, probably it make sense to
remove two levels of regulators?
power-source
  fixed-regulator
     PSE-PI-consumer

> > ....  
> > > @@ -310,6 +452,20 @@ pse_control_get_internal(struct pse_controller_dev
> > > *pcdev, unsigned int index) return ERR_PTR(-ENODEV);
> > >  	}
> > >  
> > > +	psec->ps = devm_regulator_get_exclusive(dev,
> > > +
> > > rdev_get_name(pcdev->pi[index].rdev));
> > > +	if (IS_ERR(psec->ps)) {
> > > +		kfree(psec);
> > > +		return ERR_CAST(psec->ps);
> > > +	}
> > > +
> > > +	ret = regulator_is_enabled(psec->ps);
> > > +	if (ret < 0) {
> > > +		kfree(psec);
> > > +		return ERR_PTR(ret);
> > > +	}
> > > +	pcdev->pi[index].enabled = ret;  
> > 
> > If I see it correctly, it will prevent us to refcount a request from
> > user space. So, the runtime PM may suspend PI.
> 
> I don't think so as the regulator_get_exclusive() does the same and refcount it:
> https://elixir.bootlin.com/linux/v6.7.8/source/drivers/regulator/core.c#L2268

ok, thx.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

