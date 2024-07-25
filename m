Return-Path: <netdev+bounces-112915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24D893BCCE
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DE6282DC0
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 07:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F5716DC1B;
	Thu, 25 Jul 2024 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JEgKRmpx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F816B74C;
	Thu, 25 Jul 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890982; cv=none; b=XruEzY/eZh4uK2vEKEmvWjXgAGeMb7LtQQ5cQjXRnO9Sz6hfm+zu8J5pU2rp6SFeyfmO6NTYna274DhhSpHI8O4DMYK2HDp4jmQtHwPcPDSebSa4yYisdNb33HH/GARQnB8FoDsR13Cylm5dGu3SP3Wh+GcU7ch3ORp9AA4LXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890982; c=relaxed/simple;
	bh=J2il+KZYZrgQ7JcqCSftW22j0fsz8iUuTnrisaZaEhc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4KIcG1sdbOVLTdqOW/zw1CqliYgaTRw3k8k8DQ/SS/VTFFzN5ax3idD85B1R6EDE4Y/1Uo6CWnO86Vps4OKGkK4LbiEmFI/NQ1d3C8RYsfSKevYOQNUZ5ZkSU7YJ64DzLo71ru9XKUSInHfiMtSPoNwpyHOOdVTiix+yniwPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JEgKRmpx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721890980; x=1753426980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J2il+KZYZrgQ7JcqCSftW22j0fsz8iUuTnrisaZaEhc=;
  b=JEgKRmpxjns6jGJD+K04fGso6w4RCJGMs9Mf+xLJoxjbZ/kfw/VEUbFW
   uPEn89M4p2rT9KflEsE+G0kk36E//oHbYCqq9cjtGOn5MdiSntWYes6Oc
   SNn5869ZugUPsIbzLy1zYtLDPhXjvO1cXeya+oprrnO9qEMOorUto2sMF
   7pbJxFZRJyNgbBqqDQMwE/gqBdlph5abUZBO7CUhx+QH5xrz2RCfKKZIL
   E/MnahPEvUncrZXfoBdN7UcfFIX5vBOiJkhgDKaA0b6w06GiLNPagVukQ
   UKmm4fY8iMK8V+N6Gcah8T85EwvkZ/T2QrTe9ks03KDHGG/AVk86IGRet
   w==;
X-CSE-ConnectionGUID: qIuKJO/KRQ2cP2DSiCFpbg==
X-CSE-MsgGUID: bjjZey3YTJWpPOYTRmJExA==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="29639286"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 00:02:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 00:02:16 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Jul 2024 00:02:15 -0700
Date: Thu, 25 Jul 2024 12:29:05 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horatiu.vultur@microchip.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net] net: phy: micrel: Fix the KSZ9131 MDI-X status issue
Message-ID: <ZqH3uTvOrytNHp+9@HYD-DK-UNGSW21.microchip.com>
References: <20240712111648.282897-1-Raju.Lakkaraju@microchip.com>
 <fe873fde-7a41-4a4a-ba9f-41c2ba0ddc02@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <fe873fde-7a41-4a4a-ba9f-41c2ba0ddc02@lunn.ch>

Hi Andrew,

Thank you for review the patch.

The 07/18/2024 17:04, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, Jul 12, 2024 at 04:46:48PM +0530, Raju Lakkaraju wrote:
> > Access information about Auto mdix completion and pair selection from the
> > KSZ9131's Auto/MDI/MDI-X status register
> 
> Please explain what the broken behaviour is. How would i know i need
> this patch?
> 

Ok. I will add broken behaviour details.

> You have not included a Cc: stable tag. Does that mean this does not
> bother anybody and so does not need backporting?
> 

Ok. I will add "Cc: stable tag"

> > Fixes: b64e6a8794d9 ("net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131")
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > ---
> >  drivers/net/phy/micrel.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index ebafedde0ab7..fddc1b91ba7f 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -1438,6 +1438,9 @@ static int ksz9131_config_init(struct phy_device *phydev)
> >  #define MII_KSZ9131_AUTO_MDIX                0x1C
> >  #define MII_KSZ9131_AUTO_MDI_SET     BIT(7)
> >  #define MII_KSZ9131_AUTO_MDIX_SWAP_OFF       BIT(6)
> > +#define MII_KSZ9131_DIG_AXAN_STS     0x14
> > +#define MII_KSZ9131_DIG_AXAN_STS_LINK_DET    BIT(14)
> > +#define MII_KSZ9131_DIG_AXAN_STS_A_SELECT    BIT(12)
> >
> >  static int ksz9131_mdix_update(struct phy_device *phydev)
> >  {
> > @@ -1452,14 +1455,24 @@ static int ksz9131_mdix_update(struct phy_device *phydev)
> >                       phydev->mdix_ctrl = ETH_TP_MDI;
> >               else
> >                       phydev->mdix_ctrl = ETH_TP_MDI_X;
> > +
> > +             phydev->mdix = phydev->mdix_ctrl;
> 
> This seems a bit odd. phydev->mdix_ctrl is what the user wants to
> happen. This is generally ETH_TP_MDI_AUTO, meaning the PHY should
> figure it out. It can be ETH_TP_MDI_X, or ETH_TP_MDI which forces the
> configuration. phydev->mdix is what it has ended up using.
> 

I agree. I will fix it.

> So the code above first seems to change what the user asked for. This
> is likely to replace ETH_TP_MDI_AUTO with one of the fixed modes,
> which will then break when the user replaces a crossed cable with a
> straight cable, and the forced mode is then wrong.
> 
> Setting mdix to mdix_ctrl then seems wrong. In most cases, you are
> going to get ETH_TP_MDI_AUTO, when in fact you should be returning
> what the PHY has decided on, ETH_TP_MDI_X, ETH_TP_MDI, or
> ETH_TP_MDI_INVALID because the link is down.

Yes. I agree with you.
I will fix it in next version of patch.

> 
> Maybe genphy_c45_read_mdix() will help you. It simply reads a PHY
> status register, sets phydev->mdix and it is done.
> 
Ok

>        Andrew

-- 
Thanks,                                                                         
Raju

