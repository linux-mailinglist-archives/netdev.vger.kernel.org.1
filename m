Return-Path: <netdev+bounces-254671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLKhFwIke2nXBgIAu9opvQ
	(envelope-from <netdev+bounces-254671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:10:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B94ADF2C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6872F30039BA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3F376BD4;
	Thu, 29 Jan 2026 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xGP5rYpl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9525771
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677824; cv=none; b=qkLqEe5bDa6jCYnw7oDXeBGfNFKXiKIEQy4Ia4KAG8loV3Z8gHWnqJRVXs6SylBhXxI/pDBi/DJPUQrNIeiC1TKzIjWEkmTPfJM6fyWepekUUFfoYcuYL6CVOEOxGsg/ns5EJ7EzDxV/hPvwKYLicKV499WSAC6f4lZhn+rv9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677824; c=relaxed/simple;
	bh=Y8QjYEV2e+XLKh7ojdJJWgjzgGZijPNGPijAgdPuByE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t725+CoYUE8XPz/H0/FUJgm3QEupvew5Rga427XBnyBy45/NgdoUO7Fjr0m0MBKQY8vehPYNpsTAFScPpiK6vNSMICxI2dG8pHNPa9zkf16Z5JMP4zaPNXazQje69OwOPmYcSH1iJMSilsWhJ9kWKrgspCa95L13EVZIOGbr17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xGP5rYpl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 72D711A2AD3;
	Thu, 29 Jan 2026 09:10:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43A83606B6;
	Thu, 29 Jan 2026 09:10:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0ADE4119A868D;
	Thu, 29 Jan 2026 10:10:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769677819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8ubz8mQbuyDAcwX3mFPA+MVyZlmeRo18IJrG9xjq+pc=;
	b=xGP5rYplEB20A8KcokwjmQhMpvN5z57UzjpHWAyKzEPnTpNRFgpPsxzW8rmTs9xu2rpX4u
	8m1RssvjFUxZUIk/hmnPa4LtUuJkacfq358LWBCBrElNswu/K6faMrDsERDSQ/fLa+AD2u
	PTOoJr5PTtpnB18zobTMw+DaMTickoqljHj6FYfs+sUHfAwvoVu7gH2Eu8NmUobInF/kjv
	eMUObQ8d47Q+nTbEUnBaVaAO+SfiimJ/GJ1WxstGTMYzErmtIVwO585n3yV9worLQQvuXa
	yt02Ky0XQzbZCp5I/7omTEJIqAEmMv5TNGWurpnAYwxj0ijO1/ysqEXYmiMQAg==
Message-ID: <7df10272-a06b-4509-ab8a-519d43944424@bootlin.com>
Date: Thu, 29 Jan 2026 10:10:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: add device link between MAC device and MDIO
 device
To: Wei Fang <wei.fang@nxp.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, florian.fainelli@broadcom.com,
 xiaolei.wang@windriver.com, quic_abchauha@quicinc.com,
 quic_sarohasa@quicinc.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126104409.1070403-1-wei.fang@nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260126104409.1070403-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05B94ADF2C
X-Rspamd-Action: no action

Hi

[...]
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 81984d4ebb7c..d5ac7506fe39 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1768,12 +1768,21 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  	/**
>  	 * If the external phy used by current mac interface is managed by
> -	 * another mac interface, so we should create a device link between
> -	 * phy dev and mac dev.
> +	 * another MDIO controller, which means that the MAC and MDIO are
> +	 * separated devices, then we should create a device link between
> +	 * the MAC device and the MDIO device.
>  	 */

I was confused by the use of the "MDIO device" terminology here, which
refers to a device sitting on an mdio bus, such as a PHY. I think though
that what you actually refer to is the MDIO controller itself, right ?

> -	if (dev && phydev->mdio.bus->parent && dev->dev.parent != phydev->mdio.bus->parent)
> -		phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
> -						  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +	if (dev && phydev->mdio.bus->parent &&
> +	    dev->dev.parent != phydev->mdio.bus->parent) {
> +		if (!device_link_add(dev->dev.parent, phydev->mdio.bus->parent,
> +				     DL_FLAG_PM_RUNTIME |
> +				     DL_FLAG_AUTOREMOVE_SUPPLIER)) {

Don't we have the same problem with SFP ? The struct mii_bus for SFP
PHYs also completely disappears when you remove the module.

That being said, I ran some tests with SFP and this patch, and the
netdev actually didn't dissapear under my feet.

I'm a total noob with fw_devlink, but I can see there seems to already
be a link between MAC devices and the associated SFP bus :

on cyclone V :

# ls /sys/class/devlink
 [...]
platform:sfp--platform:ff702000.ethernet

on macchiatobin :

# ls /sys/class/devlink
 [...]
platform:sfp-eth3--platform:f4000000.ethernet

So I guess this is what's preventing the netdev from going away.

Now, these seems to be automagically populated based on DT, but I don't
know if it also works with non-DT platforms. If this is DT-specific,
then I guess we still can't use DL_FLAG_AUTOREMOVE_SUPPLIER.

Maxime


