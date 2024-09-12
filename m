Return-Path: <netdev+bounces-127695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832A79761BC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468E928907A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3750B18BB90;
	Thu, 12 Sep 2024 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="k18FcBsF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA341C6A;
	Thu, 12 Sep 2024 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123354; cv=none; b=DdY9GM65DXpFYfRlpdUFuBKunmaForkUhtFI+TZZM8XBfCinEmNRq6WUVELjvOuP+yM5bqPmddQs8PiSwLoIYjzG3S8VesDcoUv5u02759RZodnih7O4PIMZ6GYlZQPpwaAba4nMCPoNnGf/K1ciYd3u9vqCwZTB888L4EABoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123354; c=relaxed/simple;
	bh=6F7DQe+L3BREmGjEsaCKRr5QCmjZVBoGA1cXdrfxT1o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRcrAv/gWMZlG1bvRohEhEkVhah4t/8zr8t2S5c/m2qwIseF60ruDLJOUcKAAKkVQvJG/nfdCcauN6tOWopj3J+xmEQgWDNy05A7LawirE+B7LlkjvlFNw5/obIuD6+7G9332zkqGlOTB5zCzMnyutoqBLwMMKUcKDuuP8U7c8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=k18FcBsF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726123351; x=1757659351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6F7DQe+L3BREmGjEsaCKRr5QCmjZVBoGA1cXdrfxT1o=;
  b=k18FcBsFlIbbHZrMoRAoq3zxSwIBgyzU2+EAkTk2Gjz6Fx50kcJvx6PZ
   3ghIllz8NrBB1eTZoiVlqs3etUrPxxCZrcSEtYqm/12oE97riRmeFtKf0
   7RFdqL0f8yOQBeYVBFE9vF4GMrDKnPllKXRkZvtzC/SClTYQfxi5rYIoU
   /9cF42tKCxDbniuDj02PPkgy2UR723kSYNp29XhXQ/2GT22KNlHqsDAp6
   qOMs7ZTNQBQ003nYxMAlfknMX0VybS0AaQaaDv1ZI8FARxxzhC3ozVYoQ
   50j6pKRE59iu40WPP2atvnY+dKVs7Bzrt0xA+p3ikQWwmFP8BlJqhU/Og
   w==;
X-CSE-ConnectionGUID: Tmxvnl0DRNWu6pE3O8ITQg==
X-CSE-MsgGUID: 4X1WTZ2wRXmlJqeEAp2d6Q==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="199114384"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 23:42:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 23:42:29 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Sep 2024 23:42:29 -0700
Date: Thu, 12 Sep 2024 12:08:40 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 2/5] net: lan743x: Add support to
 software-nodes for sfp
Message-ID: <ZuKMcMexEAqTLnSc@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
 <cb39041e-9b72-4b76-bfd7-03f825b20f23@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <cb39041e-9b72-4b76-bfd7-03f825b20f23@lunn.ch>

Hi Andrew,

The 09/11/2024 19:17, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> > diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
> > index 2e3eb37a45cd..9c08a4af257a 100644
> > --- a/drivers/net/ethernet/microchip/Kconfig
> > +++ b/drivers/net/ethernet/microchip/Kconfig
> > @@ -50,6 +50,8 @@ config LAN743X
> >       select CRC16
> >       select CRC32
> >       select PHYLINK
> > +     select I2C_PCI1XXXX
> > +     select GP_PCI1XXXX
> 
> GP_ is odd. GPIO drivers usually use GPIO_. Saying that, GPIO_PCI1XXXX
> is not in 6.11-rc7. Is it in gpio-next?
> 

Yes. But GPIO driver developer use this.
I have to use the same here.

It's exist in 6.11-rc6
drivers/misc/mchp_pci1xxxx/Kconfig
This was defined along back.

>Is it in gpio-next? 
No. available in net-next

> > +static void *pci1xxxx_perif_drvdata_get(struct lan743x_adapter *adapter,
> > +                                     u16 perif_id)
> > +{
> > +     struct pci_dev *pdev = adapter->pdev;
> > +     struct pci_bus *perif_bus;
> > +     struct pci_dev *perif_dev;
> > +     struct pci_dev *br_dev;
> > +     struct pci_bus *br_bus;
> > +     struct pci_dev *dev;
> > +
> > +     /* PCI11x1x devices' PCIe topology consists of a top level pcie
> > +      * switch with up to four downstream ports, some of which have
> > +      * integrated endpoints connected to them. One of the downstream ports
> > +      * has an embedded single function pcie ethernet controller which is
> > +      * handled by this driver. Another downstream port has an
> > +      * embedded multifunction pcie endpoint, with four pcie functions
> > +      * (the "peripheral controllers": I2C controller, GPIO controller,
> > +      * UART controllers, SPIcontrollers)
> > +      * The code below navigates the PCI11x1x topology
> > +      * to find (by matching its PCI device ID) the peripheral controller
> > +      * that should be paired to the embedded ethernet controller.
> > +      */
> > +     br_dev = pci_upstream_bridge(pdev);
> > +     if (!br_dev) {
> > +             netif_err(adapter, drv, adapter->netdev,
> > +                       "upstream bridge not found\n");
> > +             return br_dev;
> > +     }
> > +
> > +     br_bus = br_dev->bus;
> > +     list_for_each_entry(dev, &br_bus->devices, bus_list) {
> > +             if (dev->vendor == PCI1XXXX_VENDOR_ID &&
> > +                 (dev->device & ~PCI1XXXX_DEV_MASK) ==
> > +                  PCI1XXXX_BR_PERIF_ID) {
> > +                     perif_bus = dev->subordinate;
> > +                     list_for_each_entry(perif_dev, &perif_bus->devices,
> > +                                         bus_list) {
> > +                             if (perif_dev->vendor == PCI1XXXX_VENDOR_ID &&
> > +                                 (perif_dev->device & ~PCI1XXXX_DEV_MASK) ==
> > +                                  perif_id)
> > +                                     return pci_get_drvdata(perif_dev);
> > +                     }
> > +             }
> > +     }
> 
> It would be good to have the PCI Maintainers review of this. Maybe
> pull this out into a patch of its own and Cc: Bjorn Helgaas
> <bhelgaas@google.com>

Sure. I will add Cc: Bjorn Helgaas.

> 
>         Andrew

-- 
Thanks,                                                                         
Raju

