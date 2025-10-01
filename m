Return-Path: <netdev+bounces-227441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED01BAF7AD
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 09:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516B77A1878
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC862749F2;
	Wed,  1 Oct 2025 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N1RNaG89"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE7273D8D;
	Wed,  1 Oct 2025 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304850; cv=none; b=u8yay05Tt7vvJ1hZrWAAIGBFMWzi87i+rSeiIB0c54Qq1zUnPNtnNDaW7V5TEnp6zWDPTwZFut3p+NQRwsvKkPyHXjWsvyVLRn9eg2WfapY18CvAGPayuR47K2cwCIDl56yStxsPZvXeitHabY0os/+S7GW6p8ev4RUT3DskU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304850; c=relaxed/simple;
	bh=/TXXlcoWRO3uhx6NqU/tasfMOaR1DNWerhS82iCQ4Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFYCap3BIhAgMrBXGwNuxcO1RZVoP/0FVYyL+hp05DjfXI/PbDxXyu3skhUENwOai0JuySfstALAw8Tbaeq/JC6WvOT1ow7DCu6Z2et3gKe2lguOUqq57A0978lOmfkDeyItiqVKdmaNvCZaGS+D6OQdT+cNHjSIQaEZadS5taA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N1RNaG89; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GO9r6nTqLr2tVA0A8M90x9kRo7dOno/9gKwYAl3CwRk=; b=N1RNaG894XdDdK0mI83+kc5Ajm
	Z8NqCdllVlqLGkDMQ4dDaQxGkmyS7j5adsiRmA6gIj1QMjn7J/ytNoV7fDPBh5WNADhPrAOTgCT/N
	M9H/35Knojmj2po/LyBnnHKtacH0aLXS+dqXcG3j3MU7vieuRSkEu4P5yUAM/LEnW/tyV8N57ZyUm
	RtHk1ZzeirzYSdCxuqoP2Zq/oxa9oF6iJA8F/1ZFpv3ZJ88sgCF3+6YQSDDZZ49ewDy3OHSNn1kpd
	9GgIrVuGpCDeu2FFrlNo/4SQnQ6zEkk2yp5i9w0uCHiOx1Mc9Iq+sIONJ5VzBb1jsC9tRfLTJj6Zk
	SoCvxfdQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40816)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v3rYN-000000000Aj-0u3G;
	Wed, 01 Oct 2025 08:47:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v3rYJ-000000005J3-0T0K;
	Wed, 01 Oct 2025 08:47:07 +0100
Date: Wed, 1 Oct 2025 08:47:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH net-next v8 2/2] net: stmmac: Add support for Allwinner
 A523 GMAC200
Message-ID: <aNzcehZ7ALayP48B@shell.armlinux.org.uk>
References: <20250925191600.3306595-1-wens@kernel.org>
 <20250925191600.3306595-3-wens@kernel.org>
 <20250929180804.3bd18dd9@kernel.org>
 <20250930172022.3a6dd03e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930172022.3a6dd03e@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 30, 2025 at 05:20:22PM -0700, Jakub Kicinski wrote:
> On Mon, 29 Sep 2025 18:08:04 -0700 Jakub Kicinski wrote:
> > On Fri, 26 Sep 2025 03:15:59 +0800 Chen-Yu Tsai wrote:
> > > The Allwinner A523 SoC family has a second Ethernet controller, called
> > > the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> > > numbering. This controller, according to BSP sources, is fully
> > > compatible with a slightly newer version of the Synopsys DWMAC core.
> > > The glue layer around the controller is the same as found around older
> > > DWMAC cores on Allwinner SoCs. The only slight difference is that since
> > > this is the second controller on the SoC, the register for the clock
> > > delay controls is at a different offset. Last, the integration includes
> > > a dedicated clock gate for the memory bus and the whole thing is put in
> > > a separately controllable power domain.  
> > 
> > Hi Andrew, does this look good ?
> > 
> > thread: https://lore.kernel.org/20250925191600.3306595-3-wens@kernel.org
> 
> Adding Heiner and Russell, in case Andrew is AFK.

I believe it's fine. Applying the delays irrespective of the RGMII mode
is what I think needs to be done to allow the delays to be fine-tuned.

The author hsa confirmed that the delays don't apply to RMII, so that
isn't a concern. So,

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

