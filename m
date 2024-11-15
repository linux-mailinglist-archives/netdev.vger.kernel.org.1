Return-Path: <netdev+bounces-145358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FCB9CF39D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AB8282CD0
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AE1D8A12;
	Fri, 15 Nov 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b9noSIjW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E21CF2B7;
	Fri, 15 Nov 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694109; cv=none; b=lRS1JTVGh+8D7Nroi1e52+zUOwGCoJWkkQO7lTsWqRZUzKGWBYBJ7nEKkm8hh5OP52IxiGfZ8X5cjTr5LXJKIP0opbh17W8Hkp2+6/uO0n40ufUHw68mzQFlgCEzg1WEOJm6ZNdZS7Ax2bERMS+vExXc8xl0uPc4EZ+cfuMxySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694109; c=relaxed/simple;
	bh=99hLPcPeLsA5xiPzzppHyxOy/Ma4LEzox1z7X9vCitE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTkNi4AXO1LYNZoX8i8V+eOkKyT3SvqoiFjIPJsNSD6Fh5b+0k3KNm0OiEeQAwm0IMhueJkAIsFC9raZsJdVnh9Ij0C9cniWwyBdhW76xzfF+iJwHL2yloOkcPUGnmyJytUAt/hdadCbrV40XGnfC9QwJH0z38DMtluHQRDHq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b9noSIjW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/xcDkzaN2dH1xIz2RpTRyZdvyIkC7Ao/QwEFYfCD5Zo=; b=b9noSIjWklcCrxO5+d5ZpCcDd5
	obe74/IiTyDco3kV+uSlRrb+GxsTji+GnX/+Q4m1A0EWQ1Dl5XwKDK0XIfhVQvX9OjdRTS0MGkOhr
	Bhfe65wdd07UO5C5llLvOvIZ7oNFdOqRnF8FZQRuzNsVodfoVVo6KoLFz/M9i3i+xo2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tC0jz-00DRwk-9L; Fri, 15 Nov 2024 19:08:19 +0100
Date: Fri, 15 Nov 2024 19:08:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, olteanv@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	marex@denx.de, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <f11b6e5d-380c-4f13-af91-3672e2c120d6@lunn.ch>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
 <DM3PR11MB87360F9E39097E535416838EEC592@DM3PR11MB8736.namprd11.prod.outlook.com>
 <700c326c-d154-4d21-b9d4-d8abf8f2bf33@lunn.ch>
 <DM3PR11MB873696176581059CF682F253EC5A2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <1fcb11da-e660-497b-a098-c00f94c737f5@lunn.ch>
 <DM3PR11MB87366C1AC27378BA32D9CD9FEC242@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87366C1AC27378BA32D9CD9FEC242@DM3PR11MB8736.namprd11.prod.outlook.com>

> That leaves the one situation where the SGMII port is connected directly
> to a MAC or each other.  A customer once tried to do that and the SGMII
> register write was changed to support that, but I do not know if that
> project became a real product.

This is often done to cascade switches. In this setup, going down to
100Mbps or 10Mbps makes no sense, so 1000BaseX is used, not
SGMII. Today, fixed-link is used in this situation, combined with
setting phy-mode to 1000basex. Russell King has said in the past that
phylink could probably support this without fixed-link.

> The SGMII port in another chip can use 2.5G.  The driver uses fixed PHY
> to get the MAC running.  But the fixed PHY driver can only support speed
> up to 1000.  There is no issue to adding higher speeds to that driver, but
> I think that is not advised?

Well, 2.5G is obviously not SGMII. It is 2500BaseX. There are also
many broken 2500BaseX implementations out there, which are SGMII cores
overclocked, and the signalling disabled, because SGMII signalling at
2.5G makes no sense, you want 2500BaseX signalling.

phylink fixed link also is not limited to 1G, it can do any speed.

	Andrew

