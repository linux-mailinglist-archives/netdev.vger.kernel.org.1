Return-Path: <netdev+bounces-47046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F07E7AED
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7885DB20FFF
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6E111CB7;
	Fri, 10 Nov 2023 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="psGwELNb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9B12E57
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:33:33 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B88A244A4;
	Fri, 10 Nov 2023 01:33:31 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF6CCC0010;
	Fri, 10 Nov 2023 09:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699608810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nC0pAlOXIGUdD+VbkSZGUyt+AICBgKUhgiU0tdd5070=;
	b=psGwELNbfHZ+a8j1bBxaVMw71b/wkWrnwxPY/Do7fG5XWdEyK0WagG8cyoVvrbsDHAI9xr
	0sCuonz2sXS20x2HDGI1tSEwSY7oFYfB5yIcPkhhBvLaaqUYX2iTLjwv4sAnrYlabel93t
	/88QQyQqhw4MaF1wePocA4xTb8cDK+VH9ur5H/rjsh5gLWFBP4J0QfBkLfutGCICt/LvAt
	X/vls4T4QRB9tOkeK5sxtn/LFIePkbwDye6Kbo0hUtNdVKR6Uw/ixu0xFNacAHB8vdoA8v
	J6+4gg4v2GmXtPgwJxRcFa2xvBnVHLXGx1aYfVdb8hXu3O7uV1noXURToMpdRQ==
Date: Fri, 10 Nov 2023 10:33:28 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <20231110103328.0bc3d28f@fedora>
In-Reply-To: <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
	<20231108113445.24825-2-quic_luoj@quicinc.com>
	<20231108131250.66d1c236@fedora>
	<423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
	<20231109101618.009efb45@fedora>
	<0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
	<46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 10 Nov 2023 17:17:58 +0800
Jie Luo <quic_luoj@quicinc.com> wrote:

> On 11/10/2023 4:53 PM, Jie Luo wrote:
> >=20
> >=20
> > On 11/9/2023 5:16 PM, Maxime Chevallier wrote: =20
> >> Hello,
> >>
> >> On Thu, 9 Nov 2023 16:32:36 +0800
> >> Jie Luo <quic_luoj@quicinc.com> wrote:
> >>
> >> [...]
> >> =20
> >>>> What I understand from this is that this PHY can be used either as a
> >>>> switch, in which case port 4 would be connected to the host interface
> >>>> at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
> >>>> speed would be limited to 1G per-port, is that correct ? =20
> >>>
> >>> When the PHY works on the interface mode QUSGMII for quad-phy, all 4
> >>> PHYs can support to the max link speed 2.5G, actually the PHY can
> >>> support to max link speed 2.5G for all supported interface modes
> >>> including qusgmii and sgmii. =20
> >>
> >> I'm a bit confused then, as the USGMII spec says that Quad USGMII real=
ly
> >> is for quad 10/100/1000 speeds, using 10b/8b encoding.
> >>
> >> Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
> >> =C2=A0 with 66b/64b encoding ?
> >>
> >> Thanks,
> >>
> >> Maxime =20
> >=20
> > Hi Maxime,
> > Yes, for quad PHY mode, it is using 66b/64 encoding.
> >=20
> > it seems that PHY_INTERFACE_MODE_USXGMII is for single port,
> > so i take the interface name PHY_INTERFACE_MODE_QUSGMII for
> > quad PHYs here.
> >=20
> > can we apply PHY_INTERFACE_MODE_USXGMII to quad PHYs in this
> > case(qca8084 quad PHY mode)?
> >=20
> > Thanks,
> > Jie. =20
>=20
> one more thing, if we use the PHY_INTERFACE_MODE_USXGMII for
> the quad PHY here, the MAC serdes can't distinguish the actual
> mode PHY_INTERFACE_MODE_USXGMII and 10G-QXGMII(qca8084 quad phy mode),
> the MAC serdes has the different configurations for usxgmii(10g single=20
> port) and qxsgmii(quad PHY).

Yes you do need a way to know which mode to use, what I'm wondering is
that the usxgmii spec actually defines something like 9 different modes
( 1/2/4/8 ports, with a total bandwidth ranging from 2.5Gbps to 20 Gbps
), should we define a phy mode for all of these variants, or should we
have another way of getting the mode variant (like, saying I want to
use usxgmii, in 4 ports mode, with the serdes at 10.3125Gbps).

That being said, QUSGMII already exists to define a specific variant of
USGMII, so maybe adding 10G-QXGMII is fine...

Also, net-next is still currently closed.

