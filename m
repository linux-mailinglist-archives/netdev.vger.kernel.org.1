Return-Path: <netdev+bounces-131603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C698EFFC
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722C92825E9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E6199954;
	Thu,  3 Oct 2024 13:08:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FB410A1E
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960923; cv=none; b=YuDiSYPzYRrbTl0Th4yrhBHbBy3e3qUYCj9f3sDe9AbW0Tr0HHBJpN2LTUwShDwPSb9Lb/Nh5Y4K3qyjl3vY9eUiefHUxr/SKUc1b+dochXQBgBIfVYjhHlXKVszvMwIZuN9kyjT1lGvN+P5WQnNsUotUxWm4HlKr8m6mBCZHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960923; c=relaxed/simple;
	bh=SelwsqHaGZaURAnqjiIGoBucyH/dMkn416f0nfBim8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkAI/ck9Lky4fGm25G/zzEeex4hQiDlYKBsXRA6CFqL40VxlulKnhmgVqtY5cQpX6+AbOe0ozj+Majn9BOnGwXGMOlihWTqnFRvZ68wqRP13GTEj1zasrnEBPtOO+2aFtF/Ps0dPzqhMnHkJX+A6TqHWUwia0WY4D2V/UOUbzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1swLYx-0005pi-7l; Thu, 03 Oct 2024 15:08:11 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1swLYv-003LUY-Ga; Thu, 03 Oct 2024 15:08:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1swLYv-008kld-1I;
	Thu, 03 Oct 2024 15:08:09 +0200
Date: Thu, 3 Oct 2024 15:08:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Divya.Koppera@microchip.com, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	f.fainelli@gmail.com, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Message-ID: <Zv6XOXveg-dU_t8V@pengutronix.de>
References: <20241001073704.1389952-1-o.rempel@pengutronix.de>
 <20241001073704.1389952-2-o.rempel@pengutronix.de>
 <CO1PR11MB47715E80B4261E5BDF86153BE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
 <a11860cc-5804-4a15-9603-624406a29dba@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a11860cc-5804-4a15-9603-624406a29dba@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Oct 03, 2024 at 02:08:00PM +0200, Andrew Lunn wrote:
> > > +      - 'force-master': The PHY is forced to operate as a master.
> > > +      - 'force-slave': The PHY is forced to operate as a slave.
> > > +      - 'prefer-master': Prefer the PHY to be master but allow negotiation.
> > > +      - 'prefer-slave': Prefer the PHY to be slave but allow negotiation.
> > > +
> > 
> > I would suggest to use "preferred" instead of "prefer" to be in sync with existing phy library macros.
> 
> How does 802.3 name it?

802.3 use "Multiport device" for "preferred master" and "single-port device"
for "preferred slave". We decided to use other wording back in the past
to avoid confusing and align it with forced master/slave configurations. 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

