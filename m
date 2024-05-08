Return-Path: <netdev+bounces-94606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ACA8BFFB3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B724E1C2085B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5C8248D;
	Wed,  8 May 2024 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h+hXv/OL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B765228
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715177013; cv=none; b=ZqGJRVnEo0WpmVzf1ezFetEosUz9fo9tYg9iw3gQVJecrw3py/YXDMn9Sp3+3kr7eReAF1zpc3xayHJFkpisNC5Gwpf+vNXDrk5//Chd2Kdu/NFRQLHT6/OijSb3O9pPcfXWAguQCsTkhWTniaYcC4hdDeygrk7Op6ikxssN2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715177013; c=relaxed/simple;
	bh=AS5YdahZj0y3mN9jrb72F8dUBVCDtGCcMsKQINE//rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVW8EKEye+q6jzjnrsLwSh8ee1SoRaJQKJ5OZOQVy3HCExXITdGMYqwDGU6pMTRvKFFOpcaWFi1Lrel0cB5Zjg7QmJAkJaIQW6u+oHOxknsB2D4owiiXAjmi/Yr7q3ebL92HTWdm4Iuy1VVtYVhZACN7huWJxTEL4SK7Y1d4eRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h+hXv/OL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uTlFgVhoR5Ce3YTme9oiyj6mc4Y/y8I9uADASRshOMI=; b=h+hXv/OLXZHR9DLbIfSwrZpygS
	aEyqHmelo8wY8Vx7kBT3+Rm3kxJOK3dJJjk9y12gSGEM3Lmgmf1XoK7LEbIbFo9R1Ks7DshxEUgZJ
	7vwVYuN/cvPgtpgaqjemyOaM19hsvmtpLPgeTN5fQDGXs0XaFIXf6ezIGaR2yUMp09vE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4htI-00ExXT-2c; Wed, 08 May 2024 16:03:28 +0200
Date: Wed, 8 May 2024 16:03:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us,
	horms@kernel.org
Subject: Re: [PATCH net-next v4 6/6] net: tn40xx: add PHYLIB support
Message-ID: <d7089be7-dcbb-4934-9a78-48f9df52a2d4@lunn.ch>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
 <20240501230552.53185-7-fujita.tomonori@gmail.com>
 <7bd09ce5-5844-4836-a044-c507f65c051d@lunn.ch>
 <20240508.221851.1563324062182870165.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508.221851.1563324062182870165.fujita.tomonori@gmail.com>

On Wed, May 08, 2024 at 10:18:51PM +0900, FUJITA Tomonori wrote:
> Hi,
> 
> On Wed, 8 May 2024 14:21:29 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >> --- a/drivers/net/ethernet/tehuti/tn40.c
> >> +++ b/drivers/net/ethernet/tehuti/tn40.c
> >> @@ -7,6 +7,7 @@
> >>  #include <linux/if_vlan.h>
> >>  #include <linux/netdevice.h>
> >>  #include <linux/pci.h>
> >> +#include <linux/phylink.h>
> >>  
> >>  #include "tn40.h"
> >>  
> >> @@ -1185,21 +1186,25 @@ static void tn40_link_changed(struct tn40_priv *priv)
> >>  	u32 link = tn40_read_reg(priv,
> >>  				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
> >>  	if (!link) {
> >> -		if (netif_carrier_ok(priv->ndev) && priv->link)
> >> +		if (netif_carrier_ok(priv->ndev) && priv->link) {
> >>  			netif_stop_queue(priv->ndev);
> >> +			phylink_mac_change(priv->phylink, false);
> >> +		}
> > 
> > What exactly does link_changed mean?
> > 
> > The normal use case for calling phylink_mac_change() is that you have
> > received an interrupt from something like the PCS, or the PHY. The MAC
> > driver itself cannot fully evaluate if the link is up because there
> > can be multiple parts in that decision. Is the SFP reporting LOS? Does
> 
> The original driver receives an interrupt from an PHY (or something),
> then reads the register (TN40_REG_MAC_LNK_STAT) to evaluate the state
> of the link; doesn't use information from the PHY.

So i guess this is the PCS state. Call phylink_mac_change() with this
state. Don't do anything else here.

       Andrew

