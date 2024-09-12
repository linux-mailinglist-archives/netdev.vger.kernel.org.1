Return-Path: <netdev+bounces-127705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07011976222
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BBE1F23AD4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 07:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB218BC00;
	Thu, 12 Sep 2024 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oesJpYl1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6AC18D64F;
	Thu, 12 Sep 2024 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124756; cv=none; b=juEjg4XC3orLTm6rir+SJ8qSBTJktkX3MDrcXSYsqPynv5IDvXjRu/jpKED5HxJU7ALZJGcEQtKB6yuEvhp3dpKqo2UoG0giP80BeaXecCovX9tRNYBZzZxvEGqH8MG55bSNavr5OuEfnjJ8VGcCHBdQq9ECZp7gbMdwnFk1/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124756; c=relaxed/simple;
	bh=jfC1FvSAZQRxLqykAKguyf2O9rPCVwccAocswSihxcg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag0xUePw8t4i7bACptGyT/pwiZ/r4qPrbxFDYP9EKREmnbC5KNZwfVDmFSWpcMAwQI3FHo9nIyH777RhShrawTDsfaUXPnXoBD8eM7/8+XVcnbVUaj/ddfc3Qnopc6R0keYfSKuJ5CgXvVEOvMUng7FEjKO1wvis5yd3K1LqgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oesJpYl1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726124754; x=1757660754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jfC1FvSAZQRxLqykAKguyf2O9rPCVwccAocswSihxcg=;
  b=oesJpYl1E4Mtem3aFuBDQ3X8nQvqUyvpngqQ5bs/iErTX4gGW7kaSaBM
   ZGecM712JoaHXWPBqfdtRopBYu9mrjtXju7dFtNUse3Ctf0SEdE60SSxj
   cfkq3cGJCBPTzkNnY/KUibK5dk7h7LPSUIWq0dE1KDGqG1fCg/R5IKytb
   /KQq4BdwMujuO1S72hS3mvYFx9dxZ8414lsdzCBi7xEAH8hEh6UcjSnxe
   NOl/GuTMpG4nLhcfNsF3azJK30aaMn8qPQQ2BQUu0nxE1+GsTC0HV9Olv
   MaifhHCIkGp5o1A7966PEEwlhp9t64OhV38SUPtAwEA9FURT/aXzyEvKX
   g==;
X-CSE-ConnectionGUID: Zqffe1M+SWCcMURK/0Nsgw==
X-CSE-MsgGUID: vD6UNw6/TYSN8Trr5dGMBw==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="34836728"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2024 00:05:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 12 Sep 2024 00:05:22 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 12 Sep 2024 00:05:22 -0700
Date: Thu, 12 Sep 2024 12:31:33 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Andrew Lunn <andrew@lunn.ch>, Raju Lakkaraju
	<Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<rdunlap@infradead.org>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 5/5] net: lan743x: Add Support for 2.5G SFP
 with 2500Base-X Interface
Message-ID: <ZuKRzWTi2lIbBl0/@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-6-Raju.Lakkaraju@microchip.com>
 <82067738-f569-448b-b5d8-7111bef2a8e9@lunn.ch>
 <20240911220138.30575de5@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240911220138.30575de5@fedora.home>

The 09/11/2024 22:01, Maxime Chevallier wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Wed, 11 Sep 2024 19:31:01 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > @@ -3359,6 +3362,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
> > >     lan743x_phy_interface_select(adapter);
> > >
> > >     switch (adapter->phy_interface) {
> > > +   case PHY_INTERFACE_MODE_2500BASEX:
> > >     case PHY_INTERFACE_MODE_SGMII:
> > >             __set_bit(PHY_INTERFACE_MODE_SGMII,
> > >                       adapter->phylink_config.supported_interfaces);
> >
> > I _think_ you also need to set the PHY_INTERFACE_MODE_2500BASEX bit in
> > phylink_config.supported_interfaces if you actually support it.
> 
> It's actually being set a bit below. However that raises the
> question of why.
> 
> On the variant that don't have this newly-introduced SFP support but do
> have sgmii support (!is_sfp_support_en && is_sgmii_en), can this chip
> actually support 2500BaseX ?

Yes. 
PCI11010/PCI11414 chip's PCS support SGMII/2500Baxe-X I/F at 2.5Gpbs
We need to over clocking at a bit rate of 3.125 Gbps for 2.5Gbps event SGMII
I/F

From data sheet:
"The SGMII interface also supports over clocking at a bit rate of 3.125 Gbps for an effective 2.5 Gbps data rate. 10 and
100 Mbps modes are also scaled up by 2.5x but are most likely not useful."

> 
> If so, is there a point in getting a different default interface
> returned from lan743x_phy_interface_select() depending on wether or not
> there's SFP support ?

Yes.

This LAN743x driver support following chips
 1. LAN7430 - GMII I/F
 2. LAN7431 - MII I/F
 3. PCI11010/PCI11414 - RGMII or SGMII/1000Base-X/2500Base-X

> 
> Maxime
> 

-- 
Thanks,                                                                         
Raju

