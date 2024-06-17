Return-Path: <netdev+bounces-103953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C8690A82F
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 10:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EF41C25219
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCCB190042;
	Mon, 17 Jun 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiuxC+cZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAC18FDCB;
	Mon, 17 Jun 2024 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611960; cv=none; b=bEYsLD5I+Ja3tyjHzWoB9nvu+4mmr+VcWOuZKyAU5fkOnuaaVweXYS4i7f6g4GLihfegLmIw8dwoA0QhbpSk9n2WzofMU055YrBO/h+O3os/I58eHp+n0xx/+SylNINEMHR1cMIR502PmRjU/hoLxR29X2LdOjzB4cmF7CYX1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611960; c=relaxed/simple;
	bh=yhl2RzCdR+x+WW3ayanTXncY6o1XRzG9gKgwudGQbOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFr3pBMaQTlIbqqBbo7SGEcjcHskYpyDTaAUXhjTIuhFaes0/DKfKDC8enSrm2ti7tohIU+Wh/ZMi6AlNazXnWcy3LobZDJ/3fhyHFWYAtAEvAtCJ+eZIzcM3pLT6Y5Lf97TRqeVI0Iop6HAu1Y5OzOMoI2fOWD5792LcwZEXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiuxC+cZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46656C2BD10;
	Mon, 17 Jun 2024 08:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718611959;
	bh=yhl2RzCdR+x+WW3ayanTXncY6o1XRzG9gKgwudGQbOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZiuxC+cZmE0/Bx4NyAjIvtDtVVyRzbz9g8HeBBpSQyP7BQ+mY9FCX+Hl/Lv44nbRf
	 5AHg0aampFUBnNWXeGnzN+vvJIsKhT29R4xTfILvApL+tnvGlD1bfZvRxCtLzv8Rjr
	 7tTvc4m3dfpzOBDPfs2DGVeLr85bDRBwI1xp3LEesAqgslCmZC7/PBnxMbfAE59NAC
	 QhAbWkkWOGY4ERqfC/2QJLIZYBus3JyGx7y9JozuPuerzssUbhbK9hNM5e7GmUBg6f
	 nb8UVlDVDcw9oQ18fNgHlrMzQ7825PbX/FrIT+jt7+YZ0rx9gMksGVOxYl+Ux2Qciw
	 6sLfYsr+IXPAw==
Date: Mon, 17 Jun 2024 10:12:33 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Paolo Abeni <pabeni@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ericwouds@gmail.com" <ericwouds@gmail.com>
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Message-ID: <20240617101233.103eb0a3@dellmb>
In-Reply-To: <e9a2b30f-71a1-4e3d-9754-a5d505ca6705@alliedtelesis.co.nz>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
	<c3d699a1-2f24-41c5-b0a7-65db025eedbc@alliedtelesis.co.nz>
	<20240612090707.7da3fc01@dellmb>
	<fbf2be8d31579d1c9305fd961751fc6f0a4b4556.camel@redhat.com>
	<20240614102558.32dcba79@dellmb>
	<e9a2b30f-71a1-4e3d-9754-a5d505ca6705@alliedtelesis.co.nz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Jun 2024 21:24:53 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> On 14/06/24 20:25, Marek Beh=C3=BAn wrote:
> > On Fri, 14 Jun 2024 10:18:47 +0200
> > Paolo Abeni <pabeni@redhat.com> wrote:
> > =20
> >> On Wed, 2024-06-12 at 09:07 +0200, Marek Beh=C3=BAn wrote: =20
> >>> On Tue, 11 Jun 2024 20:42:43 +0000
> >>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
> >>>     =20
> >>>> +cc Eric W and Marek.
> >>>>
> >>>> On 11/06/24 17:34, Chris Packham wrote: =20
> >>>>> The Realtek RTL8224 PHY is a 2.5Gbps capable PHY. It only uses the
> >>>>> clause 45 MDIO interface and can leverage the support that has alre=
ady
> >>>>> been added for the other 822x PHYs.
> >>>>>
> >>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>>>> ---
> >>>>>
> >>>>> Notes:
> >>>>>       I'm currently testing this on an older kernel because the boa=
rd I'm
> >>>>>       using has a SOC/DSA switch that has a driver in openwrt for L=
inux 5.15.
> >>>>>       I have tried to selectively back port the bits I need from th=
e other
> >>>>>       rtl822x work so this should be all that is required for the r=
tl8224.
> >>>>>      =20
> >>>>>       There's quite a lot that would need forward porting get a wor=
king system
> >>>>>       against a current kernel so hopefully this is small enough th=
at it can
> >>>>>       land while I'm trying to figure out how to untangle all the o=
ther bits.
> >>>>>      =20
> >>>>>       One thing that may appear lacking is the lack of rate_matchin=
g support.
> >>>>>       According to the documentation I have know the interface used=
 on the
> >>>>>       RTL8224 is (q)uxsgmii so no rate matching is required. As I'm=
 still
> >>>>>       trying to get things completely working that may change if I =
get new
> >>>>>       information.
> >>>>>
> >>>>>    drivers/net/phy/realtek.c | 8 ++++++++
> >>>>>    1 file changed, 8 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> >>>>> index 7ab41f95dae5..2174893c974f 100644
> >>>>> --- a/drivers/net/phy/realtek.c
> >>>>> +++ b/drivers/net/phy/realtek.c
> >>>>> @@ -1317,6 +1317,14 @@ static struct phy_driver realtek_drvs[] =3D {
> >>>>>    		.resume         =3D rtlgen_resume,
> >>>>>    		.read_page      =3D rtl821x_read_page,
> >>>>>    		.write_page     =3D rtl821x_write_page,
> >>>>> +	}, {
> >>>>> +		PHY_ID_MATCH_EXACT(0x001ccad0),
> >>>>> +		.name		=3D "RTL8224 2.5Gbps PHY",
> >>>>> +		.get_features   =3D rtl822x_c45_get_features,
> >>>>> +		.config_aneg    =3D rtl822x_c45_config_aneg,
> >>>>> +		.read_status    =3D rtl822x_c45_read_status,
> >>>>> +		.suspend        =3D genphy_c45_pma_suspend,
> >>>>> +		.resume         =3D rtlgen_c45_resume,
> >>>>>    	}, {
> >>>>>    		PHY_ID_MATCH_EXACT(0x001cc961),
> >>>>>    		.name		=3D "RTL8366RB Gigabit Ethernet" =20
> >>> Don't you need rtl822xb_config_init for serdes configuration? =20
> >> Marek, I read the above as you would prefer to have such support
> >> included from the beginning, as such I'm looking forward a new version
> >> of this patch.
> >>
> >> Please raise a hand if I read too much in your reply. =20
> > I am raising my hand :) I just wanted to point it out.
> > If this code works for Chris' hardware, it is okay even without the
> > .config_init. =20
>=20
> I did look into this. The SERDES configuration seems to be different=20
> between the RTL8221 and RTL8224. I think that might be because the=20
> RTL8221 can do a few different host interfaces whereas the RTL8224 is=20
> really only USXGMII. There are some configurable parameters but they=20
> appear to be done differently.
>=20
> Having said that I definitely don't have a system working end to end. I=20
> know the line side stuff is working well (auto-negotiating speeds from=20
> 10M to 2.5B) but I'm not getting anything on the host side. I'm not sure=
=20
> if that's a problem with the switch driver or with the PHY.
>=20
> I'd like this to go in as it shouldn't regress anything but I can=20
> understand if the bar is "needs to be 100% working" I'll just have to=20
> carry this locally until I can be sure.

If it doesn't work, it can confuse people that it is working if it is
accepted...

Try to contact Realtek via the contact I sent you in the private
e-mail, maybe you'll be able to make this work.

Marek

