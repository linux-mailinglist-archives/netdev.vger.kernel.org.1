Return-Path: <netdev+bounces-103846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDB909DE0
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 16:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ABA1F21803
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F7D2FF;
	Sun, 16 Jun 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TvQyiG1m"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486E79F4;
	Sun, 16 Jun 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718546633; cv=none; b=Xw8YPoE3L/A911zAWmV61VPm2CqYI73O4fgsISi6jmIxtq8oxqkqYsYcvD9Qi5VJHIVxtMnNEhSzpmPCzBTOC7OSiMZCxADNTUhSWXVYVu8l77WT34c8RTp20Gwh91ILlZis9HCRvUSOVMMNSrCU8DNnmZRGL/oBF5vDOXe6Cc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718546633; c=relaxed/simple;
	bh=uLni8axn70nTeNSOM9zp1HoSjvEJQ+Je1pnxK6epS54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVVBxObPpq8L340lxJDkMIklzg2nGcX0q+my8G5HXFNdWlo/zWRNCPnkapnMN1H3vP2lSe+O47Ckava7OYFB9L/ZFBdypr+F2ZcHG5Oo5Pjy7KCCQsZ0NY9b+d633wg53QjP9ysbOGBONuGg1FRpFJcxYiGIymM1ereIu6cLyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TvQyiG1m; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8C0040005;
	Sun, 16 Jun 2024 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718546623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+UzjARY5QneLdidg3fAtVri5ykcOQxvdQ7I86EceL0=;
	b=TvQyiG1myWFoEx3lDRhv/zCFqFdKrEOvhBvc0GykO+vhEJo3rORGweBiL8xDodZNL+vNv7
	vxEubofWrwUW6yLrjmvjLSGadtmrujbw27y8b/V6pk11mkMa3JmObHyz09DWzipi1vQfMn
	IUYsHPR1oZuOWc/spHYXbdGy7r5EWG3OIw41rNklV7VmOteIrlF4jGCJ/323AHtGwImjPW
	ZLpvu39+3g733oZNA7M64lHO6xjJkxv5RZ1zRwgNstojulc19JODDXrAw1y5NlbCyIZI3p
	EM6/h6IbBdvmllgS5uzJpdUKHmc5oZPz0zJMR6wOlIpjt5s5elzL1CtMH2CQ/g==
Date: Sun, 16 Jun 2024 18:02:31 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <20240616180231.338c2e6c@fedora>
In-Reply-To: <20240613182613.5a11fca5@kernel.org>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240607071836.911403-6-maxime.chevallier@bootlin.com>
	<20240613182613.5a11fca5@kernel.org>
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

Hello Jakub,

On Thu, 13 Jun 2024 18:26:13 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri,  7 Jun 2024 09:18:18 +0200 Maxime Chevallier wrote:
> > +		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> > +			struct nlattr *phy_id;
> > +
> > +			phy_id = tb[ETHTOOL_A_HEADER_PHY_INDEX];
> > +			phydev = phy_link_topo_get_phy(dev,
> > +						       nla_get_u32(phy_id));  
> 
> Sorry for potentially repeating question (please put the answer in the
> commit message) - are phys guaranteed not to disappear, even if the
> netdev gets closed? this has no rtnl protection

I'll answer here so that people can correct me if I'm wrong, but I'll
also add it in the commit logs as well (and possibly with some fixes
depending on how this discussion goes)

While a PHY can be attached to/detached from a netdevice at open/close,
the phy_device itself will keep on living, as its lifetime is tied to
the underlying mdio_device (however phy_attach/detach take a ref on the
phy_device, preventing it from vanishing while it's attached to a
netdev)

I think the worst that could happen is that phy_detach() gets
called (at ndo_close() for example, but that's not the only possible
call site for that), and right after we manually unbind the PHY, which
will drop its last refcount, while we hold a pointer to it :

			phydev = phy_link_topo_get_phy()
 phy_detach(phydev)
 unbind on phydev
			/* access phydev */
			
PHY device lifetime is, from my understanding, not protected by
rtnl() so should a lock be added, I don't think rtnl_lock() would be
the one to use.

Maybe instead we should grab a reference to the phydev when we add it
to the topology ?

> 
> > +			if (!phydev) {
> > +				NL_SET_BAD_ATTR(extack, phy_id);
> > +				return -ENODEV;
> > +			}
> > +		} else {
> > +			/* If we need a PHY but no phy index is specified, fallback
> > +			 * to dev->phydev  
> 
> please double check the submission for going over 80 chars, this one
> appears to be particularly pointlessly over 80 chars...

Arg yes sorry about this one...
 
> > +			 */
> > +			phydev = dev->phydev;  

Thanks,

Maxime

