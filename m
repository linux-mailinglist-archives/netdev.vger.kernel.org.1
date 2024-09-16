Return-Path: <netdev+bounces-128594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE9897A7D4
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 21:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9931C21D57
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EE915ADB1;
	Mon, 16 Sep 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RF24L98P"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E064594D;
	Mon, 16 Sep 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515267; cv=none; b=fOjVwZ0wSUGQs8qOPjSuU1t9SiHa91ETNy2rirQ51/SvDdIPoIE0b0X1KgjiMcvqO8yLibSThQE+vxFzSFaZ26HtvI0XCmE6H1KK9sICFkxQ/IlZD5Li9XU479ncR/QECOImrDJr/gS4JyKCp6lTmw/IEhYbC+yNnR/G3iN/y38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515267; c=relaxed/simple;
	bh=rXTO3WC2/a8u1qL0m7CBVwOxWMG/9U7QmvpsaJj2OTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWY105dy35S6PhCP6kxS9qqXM+002Fuy8nkjjRK7FGPlcBAHOL3ZhlNGhiRnS8T9pupqcNdGbaSFKzF8weA8hAj8uYeHYeB0wBXhdTrlTh5UKq1vvGRXRWFpj5WmGTp9z41Qj93GCmfHyxS7zJfINH8MnYPH+DGccfZk/5Zagb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RF24L98P; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lShvfG7SF+kL8uPtxqv9BP0sgu8yJ2BkHSY1vNkIMMk=; b=RF24L98PrpGS0tG1P+RPi7nHyM
	SgUBXRYiLSQht9gvP4HHsH2iQCcm9W5D8z3jKD4BpBDg9j/HY15hR3cS7bPYQkiJ0iIb9wAIw2zeN
	f/wT/fqALNMIh9xFKTm+PlbmNkQz/UBoViftXVqIRIVu3ScZHLmfoDHIePqUYcNBF9I9uk7nHoM30
	1fpWMPvCSyPuCyh+ZWBM1uj5xX7Ed8Q/iobRSQqerOe+FFDW2eoNbBs/PmH1uFF1Q34GsZchOAdvn
	2dBtdZopbbRUs5eAsH/T7EIZyvyenJlq5QK8Us5KDziT6NftnURuzjdRecRDLykvZIBaa9aesy0xC
	sf2PESZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59186)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqHUM-0006KJ-2E;
	Mon, 16 Sep 2024 20:34:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqHUL-0007Dp-0J;
	Mon, 16 Sep 2024 20:34:21 +0100
Date: Mon, 16 Sep 2024 20:34:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, maxime.chevallier@bootlin.com,
	rdunlap@infradead.org, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 2/5] net: lan743x: Add support to
 software-nodes for sfp
Message-ID: <ZuiIPK4Wkmz3zYlT@shell.armlinux.org.uk>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
 <cb39041e-9b72-4b76-bfd7-03f825b20f23@lunn.ch>
 <ZuKMcMexEAqTLnSc@HYD-DK-UNGSW21.microchip.com>
 <016f93bc-3177-412c-9441-d1a6cd2b466e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016f93bc-3177-412c-9441-d1a6cd2b466e@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 12, 2024 at 05:19:37PM +0200, Andrew Lunn wrote:
> On Thu, Sep 12, 2024 at 12:08:40PM +0530, Raju Lakkaraju wrote:
> > Hi Andrew,
> > 
> > The 09/11/2024 19:17, Andrew Lunn wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > 
> > > > diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
> > > > index 2e3eb37a45cd..9c08a4af257a 100644
> > > > --- a/drivers/net/ethernet/microchip/Kconfig
> > > > +++ b/drivers/net/ethernet/microchip/Kconfig
> > > > @@ -50,6 +50,8 @@ config LAN743X
> > > >       select CRC16
> > > >       select CRC32
> > > >       select PHYLINK
> > > > +     select I2C_PCI1XXXX
> > > > +     select GP_PCI1XXXX
> > > 
> > > GP_ is odd. GPIO drivers usually use GPIO_. Saying that, GPIO_PCI1XXXX
> > > is not in 6.11-rc7. Is it in gpio-next?
> > > 
> > 
> > Yes. But GPIO driver developer use this.
> 
> And the GPIO Maintainer accepted this, despite it not being the same
> as every other GPIO driver?
> 
> Ah, there is no Acked-by: from anybody i recognise as a GPIO
> maintainer. Was it even reviewed by GPIO people? And why is it hiding
> in driver/misc? I don't see any reason it cannot be in drivers/gpio,
> which is where i looked for it. There are other auxiliary_driver in
> drivers/gpio.


What's worse is that the Link: in the commit adding it doesn't
work!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

