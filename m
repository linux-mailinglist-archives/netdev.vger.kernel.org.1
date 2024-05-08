Return-Path: <netdev+bounces-94668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5988C01DC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 18:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C061F2481C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21610129E93;
	Wed,  8 May 2024 16:21:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3C128396;
	Wed,  8 May 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185285; cv=none; b=tFc9I8R+Z3Bfc5YP55QApji9/ExtikdRgp+8evr+oFkfMk0eMa3XQ7YhyOsGpPY3qGj1IUMd4IM8WteVm+/GiFyF1tSCMLtr6mMd0lVSQfxL13gRVuWgWlBkYu8VRxKytFfJMZ5KT45EAZhIuatVgSOM/AvvDVI5V0Cj4azCJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185285; c=relaxed/simple;
	bh=5QNOGdMJ/e8elnH9GXwxtWVSpRGUAu8yyndSDA/XBGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsIan4kkYKHDkCjSSjlko5mPIZhBdvqRcnS7OjOp4BbB/WMbmmiLdO1SVP1E4yi9FO1gUs3PnXylSNPVDM2taqT7CQLgC1CT/VC4YJrq4FVN25M7enczaHoX27YSPkZ5BHt8HillHkrPzkyHZLEDezdG7xJVrCuexCB3Z7N/8Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s4k2e-000000003Ks-1aM4;
	Wed, 08 May 2024 16:21:16 +0000
Date: Wed, 8 May 2024 17:21:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 3/3] net: phy: mediatek: add support for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <Zjumd3bnZDu9LYGH@makrotopia.org>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
 <20240425023325.15586-4-SkyLake.Huang@mediatek.com>
 <ZiocBmBWiNnbeyGq@shell.armlinux.org.uk>
 <4ccd437ee744382a8483ffe71d06cd495dacec71.camel@mediatek.com>
 <577176af-9f6c-45f9-824f-2b4ca762b2f7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <577176af-9f6c-45f9-824f-2b4ca762b2f7@lunn.ch>

On Wed, May 08, 2024 at 02:30:21PM +0200, Andrew Lunn wrote:
> > I'm not sure I really get this. MT7988's internal 2.5Gphy is built
> > inside SoC. We won't have a number of these PHYs.
> 
> How long does firmware download take? If you are holding RTNL you are
> blocking all other network configuration. How many Ethernets does this
> device have? If it is just one, it is not too bad, but if there is a
> built in switch, you cannot be configuring that switch at the same
> time firmware download is happening...

The MT7988 SoC has a bunch of network interfaces:

 - GMAC0 is typically connected as conduit to a 4-port MT7530-like DSA
   switch offering 4 1GE user ports. PHY driver mediatek-ge-soc.c takes
   care of those, and yes, they do need some "care"...

 - GMAC1 can be used with the internal 2.5GE PHY (ie. with the driver
   discussed here) OR for to connect an external PHY or SFP via
   1000Base-X, 2500Base-X, SGMII, 5GBase-R, 10GBase-R or USXGMII.

 - GMAC2 is can only be used with an external PHY or SFP using
   1000Base-X, 2500Base-X, SGMII, 5GBase-R, 10GBase-R or USXGMII.

So while there is only exactly one of the internal 2.5GE PHY there are
many other network interfaces on that same SoC.

I hope that clarifies things a bit.

