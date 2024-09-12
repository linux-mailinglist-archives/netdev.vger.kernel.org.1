Return-Path: <netdev+bounces-127794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D30976848
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 13:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80CE1F2284D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1A1A3AAA;
	Thu, 12 Sep 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vqu1doXI"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946771A3ABE;
	Thu, 12 Sep 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141811; cv=none; b=sOeD+cluSyWdqd7nOotizJ4igNCBBqWZMYzpNbCdRsXeGSsqG/VlvchU35bMGoV/2gGb8P91ZmgiravZxqM8TyZJKXhT7EWO7ttNQ8ULTNlhpT9s7L2qN8LFJ8EMA/l0Tfjg55pWzx2vyTRHXTDZSuX1b+F3PFKijcKHyV6TDZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141811; c=relaxed/simple;
	bh=PM3KMX1b8ItBdUmCUzfcN2txmojhqZ2WTKlRJyp3FXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/SF6ASPSxRwh5nRckipT+H5ObJverHDFXiU7Niqqj/+G6qAScNIgOyGoDrUBfT4UEIkZ5l5ATtABnBO/3T9QZ78Xep4QlRumecTUFXzbQnt1uRdMC78lyAeNX70Hrgs05YvJjfsQmWgtfxAYOvf0NPKtYT3P14/Tv3tFjCdm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vqu1doXI; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F33220009;
	Thu, 12 Sep 2024 11:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726141800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9lFEdtubc+Tq5IhwOwbHyzwGuSufkKYfVp5GQixoCY=;
	b=Vqu1doXIHE+83bgc5UWD+qmupzcEeSXlIppq2gTBN0lKFlbi3PtlE1bHbRD4eZLiY8rImx
	1peP3+N6+dxrI5PDjXOFIMBD5TcqP+DLSnfLsDrT39Cp8/XIFxjNPNuVJXvdk1hKCR9eXS
	v4TeHItYXVp821aZAabTUAhwtCJSw3aR4QyUcmULLnkipQtb7WmAPJqzsoVus6/6Ckhcel
	7qoyS9X59ChfzQEMEVEUZs+OTi+e8Q2y+yUGcxYKmSWtZjGlCUaYTJdgXtx42NCmASgQEV
	M51GNuD5uHBN76aK+kDNg0bvVU/Z6AsdGh7A7cF4x9sRxQ0yFVP9rMBRFIsr8Q==
Date: Thu, 12 Sep 2024 13:49:57 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
 <rdunlap@infradead.org>, <Steen.Hegelund@microchip.com>,
 <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 5/5] net: lan743x: Add Support for 2.5G SFP
 with 2500Base-X Interface
Message-ID: <20240912134957.29998261@fedora.home>
In-Reply-To: <ZuKRzWTi2lIbBl0/@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
	<20240911161054.4494-6-Raju.Lakkaraju@microchip.com>
	<82067738-f569-448b-b5d8-7111bef2a8e9@lunn.ch>
	<20240911220138.30575de5@fedora.home>
	<ZuKRzWTi2lIbBl0/@HYD-DK-UNGSW21.microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Raju,

On Thu, 12 Sep 2024 12:31:33 +0530
Raju Lakkaraju <Raju.Lakkaraju@microchip.com> wrote:

> The 09/11/2024 22:01, Maxime Chevallier wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > On Wed, 11 Sep 2024 19:31:01 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >  =20
> > > > @@ -3359,6 +3362,7 @@ static int lan743x_phylink_create(struct lan7=
43x_adapter *adapter)
> > > >     lan743x_phy_interface_select(adapter);
> > > >
> > > >     switch (adapter->phy_interface) {
> > > > +   case PHY_INTERFACE_MODE_2500BASEX:
> > > >     case PHY_INTERFACE_MODE_SGMII:
> > > >             __set_bit(PHY_INTERFACE_MODE_SGMII,
> > > >                       adapter->phylink_config.supported_interfaces)=
; =20
> > >
> > > I _think_ you also need to set the PHY_INTERFACE_MODE_2500BASEX bit in
> > > phylink_config.supported_interfaces if you actually support it. =20
> >=20
> > It's actually being set a bit below. However that raises the
> > question of why.
> >=20
> > On the variant that don't have this newly-introduced SFP support but do
> > have sgmii support (!is_sfp_support_en && is_sgmii_en), can this chip
> > actually support 2500BaseX ? =20
>=20
> Yes.=20
> PCI11010/PCI11414 chip's PCS support SGMII/2500Baxe-X I/F at 2.5Gpbs
> We need to over clocking at a bit rate of 3.125 Gbps for 2.5Gbps event SG=
MII
> I/F
>=20
> From data sheet:
> "The SGMII interface also supports over clocking at a bit rate of 3.125 G=
bps for an effective 2.5 Gbps data rate. 10 and
> 100 Mbps modes are also scaled up by 2.5x but are most likely not useful."
>=20
> >=20
> > If so, is there a point in getting a different default interface
> > returned from lan743x_phy_interface_select() depending on wether or not
> > there's SFP support ? =20
>=20
> Yes.
>=20
> This LAN743x driver support following chips
>  1. LAN7430 - GMII I/F
>  2. LAN7431 - MII I/F
>  3. PCI11010/PCI11414 - RGMII or SGMII/1000Base-X/2500Base-X

In your patch there's the following change :

@@ -1495,7 +1495,10 @@ static void lan743x_phy_interface_select(struct lan7=
43x_adapter *adapter)
 	data =3D lan743x_csr_read(adapter, MAC_CR);
 	id_rev =3D adapter->csr.id_rev & ID_REV_ID_MASK_;
=20
-	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
+	if (adapter->is_pci11x1x && adapter->is_sgmii_en &&
+	    adapter->is_sfp_support_en)
+		adapter->phy_interface =3D PHY_INTERFACE_MODE_2500BASEX;
+	else if (adapter->is_pci11x1x && adapter->is_sgmii_en)
 		adapter->phy_interface =3D PHY_INTERFACE_MODE_SGMII;
 	else if (id_rev =3D=3D ID_REV_ID_LAN7430_)
 		adapter->phy_interface =3D PHY_INTERFACE_MODE_GMII;

=46rom what I get, if the chip is a pci11x1x and has sgmii_en, it doesn't
really matter wether or not the "is_sfp_support" it set, as you support
the same sets of interface modes.

The phy_interface will be re-configured the moment the SFP module is
plugged, so it shouldn't matter wether you set the default interface to
SGMII or 2500BaseX.

So, the change quoted above doesn't really bring anything, am I correct
?

Thanks,

Maxime


