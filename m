Return-Path: <netdev+bounces-131578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B9B98EEC1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD06D283F14
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A315B0EE;
	Thu,  3 Oct 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yyys6nAo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DA13D245;
	Thu,  3 Oct 2024 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957296; cv=none; b=Z5g9kf/gGkbJ6TnlY5Q5R0rxsEfw3+RAj5yedeQPBawxoFx3Q/TygdGGDZsPwGeb28thDk/lownX0LYm0R9uGXQLUgGhTu5tSvFMTXb6s4go0so4AHW/5i9YtDRHmZVeLio4MQy/32Ph6exmI6Q7WdP1Ew11Jljy3NRiyX8D/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957296; c=relaxed/simple;
	bh=ZbTA98ccRSsqIpLNsj7JJNgUP2ihwZQcKfanPMoxxoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bddHiDwZclj1MF60gJugmo5DjwenvE5Q5tTOOGP033Gt8fPJyx373crTAqpKaJeyVDl4kEagorEafPfywLILggnkTQV9FWi2mo0Y+rpbFBux56cyKD7JhJSA1lOxtZgx3nmzAQeNLegjp/rr1UO1FaoUlxJusbtH0ISpGmNpTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yyys6nAo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iiNSjpwoeOobTP6nLAt2OjGKxNPY7BW/abKe2/5yE1o=; b=yyys6nAoK5bRqaJxWvtKqy1g+K
	nl/BEjyrkqAheraP09MpYSYIJCPqmIkKoGJ7nO8HAM0ZcH4pmrG+RGPsnGEZhgc1CueKGM4p6nd69
	d1nC9kTcKEz64BM1tV+fj0tYeTyHqEwxj3d84s0SYRs9iAXjdwecL7pbH8zxrlDzrfmM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swKci-008wXq-LG; Thu, 03 Oct 2024 14:08:00 +0200
Date: Thu, 3 Oct 2024 14:08:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Divya.Koppera@microchip.com
Cc: o.rempel@pengutronix.de, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	f.fainelli@gmail.com, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Message-ID: <a11860cc-5804-4a15-9603-624406a29dba@lunn.ch>
References: <20241001073704.1389952-1-o.rempel@pengutronix.de>
 <20241001073704.1389952-2-o.rempel@pengutronix.de>
 <CO1PR11MB47715E80B4261E5BDF86153BE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB47715E80B4261E5BDF86153BE2712@CO1PR11MB4771.namprd11.prod.outlook.com>

> > +      - 'force-master': The PHY is forced to operate as a master.
> > +      - 'force-slave': The PHY is forced to operate as a slave.
> > +      - 'prefer-master': Prefer the PHY to be master but allow negotiation.
> > +      - 'prefer-slave': Prefer the PHY to be slave but allow negotiation.
> > +
> 
> I would suggest to use "preferred" instead of "prefer" to be in sync with existing phy library macros.

How does 802.3 name it?

	Andrew

