Return-Path: <netdev+bounces-243563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5720CA3BB3
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 743293093CF1
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5569337699;
	Thu,  4 Dec 2025 13:08:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90728273D66;
	Thu,  4 Dec 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853717; cv=none; b=niuxlD68p90d23SSA5EYUB8BKWzU3wNzmtsF82asmHAOOzU60mBVCIF2XSGT4fpxC1N9uvkoi5UvdJbeVLTPn2BUpKaLMa4ZiaYr95XHLXS+2/ueI4gwkaeeCVOAm0d2bhirP3urP8SJhFRO5j3nfKm6PiQMCy7hwD6vbTaYjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853717; c=relaxed/simple;
	bh=JJSrGbb/D5N2qxg9oGgl9lB0p+ZB79Uuhwh6U//Ny14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAoV/ICNXvyuYpQUY+/LpJsrJ3ryf3hxzm/bixDyW2aEygUY5HIDdzoIWymUz0Vkq6h8mBjbnSj11lebLe4vGPQnNi8hi59DpKjGtfx5M+hgE+7DehgMRVRo6uvA/KBI8JrgFOyKf/MEW9ykD0xQTQX2WyBMVpwZUBYbEPEW3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vR94N-00000000704-33CU;
	Thu, 04 Dec 2025 13:08:27 +0000
Date: Thu, 4 Dec 2025 13:08:24 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 0/3] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <aTGHyIdWL86qPUif@makrotopia.org>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <20251203202605.t4bwihwscc4vkdzz@skbuf>
 <aTDGX5sUjaXzqRRn@makrotopia.org>
 <aTDdlibA99YLVSKV@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTDdlibA99YLVSKV@shell.armlinux.org.uk>

On Thu, Dec 04, 2025 at 01:02:14AM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 03, 2025 at 11:23:11PM +0000, Daniel Golle wrote:
> > On Wed, Dec 03, 2025 at 10:26:05PM +0200, Vladimir Oltean wrote:
> > > Hi Daniel,
> > > 
> > > On Tue, Dec 02, 2025 at 11:37:13PM +0000, Daniel Golle wrote:
> > > > Hi,
> > > > 
> > > > This series adds very basic DSA support for the MaxLinear MxL86252
> > > > (5 PHY ports) and MxL86282 (8 PHY ports) switches. The intent is to
> > > > validate and get feedback on the overall approach and driver structure,
> > > > especially the firmware-mediated host interface.
> > > > 
> > > > MxL862xx integrates a firmware running on an embedded processor (Zephyr
> > > > RTOS). Host interaction uses a simple API transported over MDIO/MMD.
> > > > This series includes only what's needed to pass traffic between user
> > > > ports and the CPU port: relayed MDIO to internal PHYs, basic port
> > > > enable/disable, and CPU-port special tagging.
> > > > 
> > > > Thanks for taking a look.
> > > 
> > > I see no phylink_mac_ops in your patches.
> > 
> 
> As you didn't respond to Vladimir's statement here, I will also echo
> this. Why do you have no phylink_mac_ops ?
> 
> New DSA drivers are expected to always have phylink_mac_ops, and not
> rely on the legacy fallback in net/dsa/port.c

All three phylink_mac_ops functions are no-ops for the internal PHYs,
see also

https://github.com/frank-w/BPI-Router-Linux/blob/6.18-rc/drivers/net/dsa/mxl862xx/mxl862xx.c#L3242

The exception in the reference driver are the SerDes PCS ports, and for
those I'd rather use .pcs_config than setting the interface mode in
.phylink_mac_config.
Hence I was planing to introduce phylink_mac_ops together with support
for the SerDes ports, and it will only have a .mac_select_pcs op.

