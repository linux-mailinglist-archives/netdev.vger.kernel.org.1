Return-Path: <netdev+bounces-131701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9291898F4CF
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EDB3B208A1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0201A7065;
	Thu,  3 Oct 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RaF6r8TN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049019D081;
	Thu,  3 Oct 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975174; cv=none; b=YMgi/vx4gTzTkQAywTXkfovsF3cLpUFnQgFmx6o/0FPhs/6Wa06JSAEWbTI9ka7CJ1kT6eDIhomHIYD1FLJ/e1QN65dLxTl6HJR8nRvmtOmeU/F3fBzdAb7JQIKbkHreEB1koidOtOcjtWGchvCIggExxbRUe/Ry4mBIvPFQfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975174; c=relaxed/simple;
	bh=8xtl08LIfB+PcgXl6pTyRTIC2AIYH3M6YsJkFy4VQnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhDk6kdSJADkG2MvzU4H6b/HpoplYI4guLxWSMMtD4KIyaheHITPncAwqb+tlB4xVZ62uMiaGMB147YmkMGaGsWFdoBKBgd3stSuFy/uai9U2gesLX+u1ApqmsylXcjMUvFr91QPf7gOgRVv4hXaHAC1H8c4Drwn3amn7xuUL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RaF6r8TN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IZz+UidW/Gd8crcEeUt/a34aCAjHwfld1MoV/9qDFVQ=; b=RaF6r8TNzk1WcZ3sDYOrFtHWIj
	BlhCtOvsrkBR9D7eWePA3x+V6A2OeVbr+/D+dKhei2virOJgG7UREAiwuxZDsYwYbRYVXdGVT8E1z
	KrnCYxskSHcVDmmI0HJSsst0IfoQekGj/ga62QTH9pi501vVYFCNrZc1C3Nc/15C0qlU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swPH4-008xw9-8n; Thu, 03 Oct 2024 19:05:58 +0200
Date: Thu, 3 Oct 2024 19:05:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Divya.Koppera@microchip.com, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	f.fainelli@gmail.com, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Message-ID: <19207165-1708-4717-9883-19d914aea5c3@lunn.ch>
References: <20241001073704.1389952-1-o.rempel@pengutronix.de>
 <20241001073704.1389952-2-o.rempel@pengutronix.de>
 <CO1PR11MB47715E80B4261E5BDF86153BE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
 <a11860cc-5804-4a15-9603-624406a29dba@lunn.ch>
 <Zv6XOXveg-dU_t8V@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6XOXveg-dU_t8V@pengutronix.de>

On Thu, Oct 03, 2024 at 03:08:09PM +0200, Oleksij Rempel wrote:
> On Thu, Oct 03, 2024 at 02:08:00PM +0200, Andrew Lunn wrote:
> > > > +      - 'force-master': The PHY is forced to operate as a master.
> > > > +      - 'force-slave': The PHY is forced to operate as a slave.
> > > > +      - 'prefer-master': Prefer the PHY to be master but allow negotiation.
> > > > +      - 'prefer-slave': Prefer the PHY to be slave but allow negotiation.
> > > > +
> > > 
> > > I would suggest to use "preferred" instead of "prefer" to be in sync with existing phy library macros.
> > 
> > How does 802.3 name it?
> 
> 802.3 use "Multiport device" for "preferred master" and "single-port device"
> for "preferred slave". We decided to use other wording back in the past
> to avoid confusing and align it with forced master/slave configurations. 

ethtool is preferred, so it would be more consistent with preferred

[Shrug]

	Andrew

