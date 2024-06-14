Return-Path: <netdev+bounces-103515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AF5908642
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171F01F215D4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CFF185087;
	Fri, 14 Jun 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBeWzj5h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC018413A;
	Fri, 14 Jun 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353564; cv=none; b=Cfo6joHXdFaT94feDMhs6hBngrnTPzgfwxSFbZeIAdT1e8pjOV3qpbeHvTqUyGD39plBnItpWP8Eq0n+0d35/Zy7DJPSTv4UU+GL1u5+5q0j4/+3ODEaU0HMfzJll48TjV1P5qZ1kRsgdo08I7d/t+eJD7fEYKS/57axW/H8sfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353564; c=relaxed/simple;
	bh=MnoDPn7esVk0izTPWWobr9ZqeVKg3ab/Yn7Gm5y+UBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGDrllbiki4i389Y6eYqjV4efzTyXeB3vIE4ZGoMGFC++DDsdBykoMBle2acsHscYU6g1/QVaKDY/PumzEwUqPpX8Nkt1MSatL69i4ElnN2j3DhJyVZf9Mvkoo99d3PBCTo/BNIFSqFvhWTP3CMwgbAmrshahXFY5o8/6cpsYBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBeWzj5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CD0C2BD10;
	Fri, 14 Jun 2024 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718353564;
	bh=MnoDPn7esVk0izTPWWobr9ZqeVKg3ab/Yn7Gm5y+UBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fBeWzj5hq3tKjt0bijmfdMota/lHKvhW0efUz66hSe2svOi0f6+vILbmBOo3SC+22
	 BgdjjhWBGuKeGPaSV8X4j6igyXFUomfxm8pmjohHLUkduGdDsWNbn9iMdI41B8nx5c
	 1p8JW8G0JSUgYzAiEEkngQfE1VjbtrDSFB+HJZslw81jXbSvYwcgfkD7fG4Ngjl4qP
	 h3u3wQPFgUcL9DWZGX/MBv4bTh7SQDgPs95EJ0W91i6lMYkmt5qFMCuBKmbBUHx3NJ
	 oFlgS+WwcDRHnQuTbjtVjRoOGMSEa9ULF50JRLiSP/kjZ9Bk44/xggVbDuY1iomnA6
	 WHrOyNS/1gfeA==
Date: Fri, 14 Jun 2024 10:25:58 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Chris Packham  <Chris.Packham@alliedtelesis.co.nz>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "ericwouds@gmail.com" <ericwouds@gmail.com>
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Message-ID: <20240614102558.32dcba79@dellmb>
In-Reply-To: <fbf2be8d31579d1c9305fd961751fc6f0a4b4556.camel@redhat.com>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
	<c3d699a1-2f24-41c5-b0a7-65db025eedbc@alliedtelesis.co.nz>
	<20240612090707.7da3fc01@dellmb>
	<fbf2be8d31579d1c9305fd961751fc6f0a4b4556.camel@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024 10:18:47 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On Wed, 2024-06-12 at 09:07 +0200, Marek Beh=C3=BAn wrote:
> > On Tue, 11 Jun 2024 20:42:43 +0000
> > Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
> >  =20
> > > +cc Eric W and Marek.
> > >=20
> > > On 11/06/24 17:34, Chris Packham wrote: =20
> > > > The Realtek RTL8224 PHY is a 2.5Gbps capable PHY. It only uses the
> > > > clause 45 MDIO interface and can leverage the support that has alre=
ady
> > > > been added for the other 822x PHYs.
> > > >=20
> > > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > > ---
> > > >=20
> > > > Notes:
> > > >      I'm currently testing this on an older kernel because the boar=
d I'm
> > > >      using has a SOC/DSA switch that has a driver in openwrt for Li=
nux 5.15.
> > > >      I have tried to selectively back port the bits I need from the=
 other
> > > >      rtl822x work so this should be all that is required for the rt=
l8224.
> > > >     =20
> > > >      There's quite a lot that would need forward porting get a work=
ing system
> > > >      against a current kernel so hopefully this is small enough tha=
t it can
> > > >      land while I'm trying to figure out how to untangle all the ot=
her bits.
> > > >     =20
> > > >      One thing that may appear lacking is the lack of rate_matching=
 support.
> > > >      According to the documentation I have know the interface used =
on the
> > > >      RTL8224 is (q)uxsgmii so no rate matching is required. As I'm =
still
> > > >      trying to get things completely working that may change if I g=
et new
> > > >      information.
> > > >=20
> > > >   drivers/net/phy/realtek.c | 8 ++++++++
> > > >   1 file changed, 8 insertions(+)
> > > >=20
> > > > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > > > index 7ab41f95dae5..2174893c974f 100644
> > > > --- a/drivers/net/phy/realtek.c
> > > > +++ b/drivers/net/phy/realtek.c
> > > > @@ -1317,6 +1317,14 @@ static struct phy_driver realtek_drvs[] =3D {
> > > >   		.resume         =3D rtlgen_resume,
> > > >   		.read_page      =3D rtl821x_read_page,
> > > >   		.write_page     =3D rtl821x_write_page,
> > > > +	}, {
> > > > +		PHY_ID_MATCH_EXACT(0x001ccad0),
> > > > +		.name		=3D "RTL8224 2.5Gbps PHY",
> > > > +		.get_features   =3D rtl822x_c45_get_features,
> > > > +		.config_aneg    =3D rtl822x_c45_config_aneg,
> > > > +		.read_status    =3D rtl822x_c45_read_status,
> > > > +		.suspend        =3D genphy_c45_pma_suspend,
> > > > +		.resume         =3D rtlgen_c45_resume,
> > > >   	}, {
> > > >   		PHY_ID_MATCH_EXACT(0x001cc961),
> > > >   		.name		=3D "RTL8366RB Gigabit Ethernet"   =20
> >=20
> > Don't you need rtl822xb_config_init for serdes configuration? =20
>=20
> Marek, I read the above as you would prefer to have such support
> included from the beginning, as such I'm looking forward a new version
> of this patch.
>=20
> Please raise a hand if I read too much in your reply.

I am raising my hand :) I just wanted to point it out.
If this code works for Chris' hardware, it is okay even without the
.config_init.

Marek

