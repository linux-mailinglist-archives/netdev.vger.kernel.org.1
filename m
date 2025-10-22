Return-Path: <netdev+bounces-231573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392ABFAB8B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C2C18977FD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F432FE598;
	Wed, 22 Oct 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MOIaNm8d"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6F2FE59A;
	Wed, 22 Oct 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119908; cv=none; b=dEXZ7wg/tlXF2QPuyj46Auw6gtQ8osOJkhI69fPy5B0Q+2G5PO7XlWuaJn61W1xPOlPpXFxWqfmFygIEonhVgQ8iNthL5BqAtXjbacI8o7Hxufk9jJWwEnd5D+/XAnex7tsTszR90oisvD/NeqEc1LFiQFRc5iwKLvQgA6NsuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119908; c=relaxed/simple;
	bh=/dM6Iq8oa787huqymjEo36xu+0zARKREn4b1f8LhZjU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0IESjKVx2a6gtAJKjTUQq7y7wu9LHQZsX4LIQ6PVy4fGmnXF0JULdqfOBIGhbpKBuZzN24wQfIfFT5DpLhiFWLq+0kNR2O1AQUTyeCsmV/C8EUz8cvdsRQjPHdgrr0dDjRIEblsiRY316bfAbMEqrib4LztcwZIhdAvKf/ziuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MOIaNm8d; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761119906; x=1792655906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/dM6Iq8oa787huqymjEo36xu+0zARKREn4b1f8LhZjU=;
  b=MOIaNm8djzKwKjOCs/GpO5MY77hEOWNe+r8Ag26o0LhrYZXr0bWJm0hc
   JBptxBuQqZSTv9YNupJckZuY5BfP7OXlpY3A3bjDU/SqpIODuOWFrsljd
   +5/OkGzxzHDLiDrIfXlMZJZR/qGYi5bGwKybgZYYrpzzgYnN5BT++hbCH
   9DEOBcynMnHum0ArreSgMoZNs8e2gAbsBbwxVSxyfc/rxrAqczrNTsbGE
   6NJ1vX6BWeZsT2IHNeNsDWizQgoI0gGK8LAJZw+/OIxmfBn7qpZ9vxdFN
   XT/+6Ujyxpj866dtk7tqM8wCUvVujYHmmxA5QxwbWKorHOcIv6mzLny79
   g==;
X-CSE-ConnectionGUID: bXoNwrFvQ+2mZ7nz08/S7A==
X-CSE-MsgGUID: 9DWPnlUhQxavr9wRNALmBw==
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="54326722"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 00:58:25 -0700
Received: from chn-vm-ex2.mchp-main.com (10.10.87.31) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Oct 2025 00:58:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Wed, 22 Oct 2025 00:58:02 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 22 Oct 2025 00:58:01 -0700
Date: Wed, 22 Oct 2025 09:56:55 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <christophe.jaillet@wanadoo.fr>,
	<rosenp@gmail.com>, <steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4 1/2] phy: mscc: Use PHY_ID_MATCH_MODEL for
 VSC8584, VSC8582, VSC8575, VSC856X
Message-ID: <20251022075655.m42pxagwvqg3x3y6@DEN-DL-M31836.microchip.com>
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
 <20251017064819.3048793-2-horatiu.vultur@microchip.com>
 <aPdNrFe4JfCTNbAM@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aPdNrFe4JfCTNbAM@shell.armlinux.org.uk>

The 10/21/2025 10:09, Russell King (Oracle) wrote:

Hi,

> 
> On Fri, Oct 17, 2025 at 08:48:18AM +0200, Horatiu Vultur wrote:
> > As the PHYs VSC8584, VSC8582, VSC8575 and VSC856X exists only as rev B,
> > we can use PHY_ID_MATCH_MODEL to match exactly on revision B of the PHY.
> 
> I don't follow this. PHY_ID_MATCH_MODEL() uses a mask of bits 31:4,
> omitting the revision field. So that is equivalent to a .phy_id_mask
> of 0xfffffff0, which is what the code already uses.

I totally understand why you don't understand this as this is I made big
mistake!
I was supposed to use PHY_ID_MATCH_EXACT instead of PHY_ID_MATCH_MODEL.

> 
> > Because of this change then there is not need the check if it is a
> > different revision than rev B in the function vsc8584_probe() as we
> > already know that this will never happen.
> 
> Since bits 3:0 are masked out, this statement seems to be false.
> 
> > @@ -2587,9 +2576,8 @@ static struct phy_driver vsc85xx_driver[] = {
> >       .config_inband  = vsc85xx_config_inband,
> >  },
> >  {
> > -     .phy_id         = PHY_ID_VSC856X,
> > +     PHY_ID_MATCH_MODEL(PHY_ID_VSC856X),
> >       .name           = "Microsemi GE VSC856X SyncE",
> > -     .phy_id_mask    = 0xfffffff0,
> >       /* PHY_GBIT_FEATURES */
> >       .soft_reset     = &genphy_soft_reset,
> >       .config_init    = &vsc8584_config_init,
> > @@ -2667,9 +2655,8 @@ static struct phy_driver vsc85xx_driver[] = {
> >       .config_inband  = vsc85xx_config_inband,
> >  },
> >  {
> > -     .phy_id         = PHY_ID_VSC8575,
> > +     PHY_ID_MATCH_MODEL(PHY_ID_VSC8575),
> >       .name           = "Microsemi GE VSC8575 SyncE",
> > -     .phy_id_mask    = 0xfffffff0,
> >       /* PHY_GBIT_FEATURES */
> >       .soft_reset     = &genphy_soft_reset,
> >       .config_init    = &vsc8584_config_init,
> > @@ -2693,9 +2680,8 @@ static struct phy_driver vsc85xx_driver[] = {
> >       .config_inband  = vsc85xx_config_inband,
> >  },
> >  {
> > -     .phy_id         = PHY_ID_VSC8582,
> > +     PHY_ID_MATCH_MODEL(PHY_ID_VSC8582),
> >       .name           = "Microsemi GE VSC8582 SyncE",
> > -     .phy_id_mask    = 0xfffffff0,
> >       /* PHY_GBIT_FEATURES */
> >       .soft_reset     = &genphy_soft_reset,
> >       .config_init    = &vsc8584_config_init,
> > @@ -2719,9 +2705,8 @@ static struct phy_driver vsc85xx_driver[] = {
> >       .config_inband  = vsc85xx_config_inband,
> >  },
> >  {
> > -     .phy_id         = PHY_ID_VSC8584,
> > +     PHY_ID_MATCH_MODEL(PHY_ID_VSC8584),
> >       .name           = "Microsemi GE VSC8584 SyncE",
> > -     .phy_id_mask    = 0xfffffff0,
> >       /* PHY_GBIT_FEATURES */
> >       .soft_reset     = &genphy_soft_reset,
> >       .config_init    = &vsc8584_config_init,
> 
> Due to what I've said above, the above part of the patch is a cleanup,
> and functionally is a no-op.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

