Return-Path: <netdev+bounces-196444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA9AD4DD1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38B0179039
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927923AB81;
	Wed, 11 Jun 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="aSI3qojW"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9C2397BE;
	Wed, 11 Jun 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629037; cv=pass; b=R4E3oyuvOHqwHDfMCv0YbwQBFLpO2MDGeHoDuQmwB+VkPBWhnnFC+U11ufth1sjdVGdYu+BZq4P2YogUoL/4ETC4UlvSQK9PaEfEUSjK4cafKV44eJFZLH9yX9ctqF6b67OL1YV9PNggDKhUCWXOy36EMID/1vpLo1V0yGXc3bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629037; c=relaxed/simple;
	bh=BDu5u8r6NxnLidcAlJTIjfUCAqMvyw4nnccApf0j0XQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSJco3S1/MjIrNba+pViBA0lyv1QiIuoHtYHTiLM5otShcCCQDzxOKcb/Iywz/VZo862cCGozR2X41VBfnXeYJvWiC3IzoBv63EHmjrql8vPRpaQb5Yn2TS5nW0nDR84h46JH7YJw1vQ7etLFs/V4dmlhABtnPKpdkSEOyrKQzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=aSI3qojW; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1749629000; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f/EysTF9raz2svykPFGdFJNU0IzTEjVdFxmGmeU/aQfU8CN1sy44rS09KtiWuglUxWnKMoiv+G/MmPYBj3T6dEDxK28jtMXgV3Yym3XqarO5uB5rwClzYXP2ddZDwfRslCO9W5FtmXeDDKW5ynkkKIqqpPLsbCGgq5Zfz9ORHVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749629000; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BDu5u8r6NxnLidcAlJTIjfUCAqMvyw4nnccApf0j0XQ=; 
	b=MBvDXU7kP1xSkKZ/AUpiQb5D1kxynNrJfyuLn0ogVB6MmL8ftgS+VLiEIF3r0Igse3RhK5FXab65Ngg6iGfuc5htvD8/y7UqxUINNSa8G/NPnMuDpBnfiATr2f3GVW9Te7uKwpz80bi2mcKNrRaTPj9i/6VM55rRbwUAydkwbAI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749629000;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=BDu5u8r6NxnLidcAlJTIjfUCAqMvyw4nnccApf0j0XQ=;
	b=aSI3qojW3+ygrOnzwqKDqEW4EykcF9gw4oGzptZ6aiZzD5aesD0pvK27g26NKROz
	D27mwcNpcKsruAJKQkQovyVBqVAdNxb7iRQcwp1ZJ3+BUzSu9nzHcDrUgNt8OLwspjq
	O59cvuKzQLikvCa7ZrA98RVG2nVUvozYqNScXJO1bwfwcJTJyTZu6ShK8G6Z/uvw6si
	p9om+r8WxOS3SNJNQyZAabXgWDuVVdpcIk89BoiJcwL1zPfzQduqHbyO+Yi4MrYEgey
	vmHbry7zvmuD/LIAPsuY8sPVmipArDZvyM46uD/QmL+eB36UkywDAGOHRP4aJmoE5Al
	qqelW37hqw==
Received: by mx.zohomail.com with SMTPS id 1749628998705473.0702499938236;
	Wed, 11 Jun 2025 01:03:18 -0700 (PDT)
Message-ID: <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
From: Icenowy Zheng <uwu@icenowy.me>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chaoyi Chen
 <chaoyi.chen@rock-chips.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Heiner Kallweit
 <hkallweit1@gmail.com>,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Jun 2025 16:03:11 +0800
In-Reply-To: <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
	 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
	 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
	 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
	 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
	 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
	 <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-06-05=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 15:48 +0200=EF=BC=
=8CAndrew Lunn=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Jun 05, 2025 at 06:51:43PM +0800, Icenowy Zheng wrote:
> > =E5=9C=A8 2025-06-05=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 10:41 +0100=EF=
=BC=8CRussell King (Oracle)=E5=86=99=E9=81=93=EF=BC=9A
> > > On Thu, Jun 05, 2025 at 05:06:43PM +0800, Icenowy Zheng wrote:
> > > > In addition, analyzing existing Ethernet drivers, I found two
> > > > drivers
> > > > with contradition: stmicro/stmmac/dwmac-qcom-ethqos.c and
> > > > ti/icssg/icssg_prueth.c .
> > > >=20
> > > > The QCOM ETHQOS driver enables the MAC's TX delay if the
> > > > phy_mode
> > > > is
> > > > rgmii or rgmii-rxid, and the PRU ETH driver, which works on
> > > > some
> > > > MAC
> > > > with hardcoded TX delay, rejects rgmii and rgmii-rxid, and
> > > > patches
> > > > rgmii-id or rgmii-txid to remove the txid part.
> > >=20
> > > No, this is wrong.
> > >=20
> > > First, it does not reject any RGMII mode. See qcom_ethqos_probe()
> > > and
> > > the switch() in there. All four RGMII modes are accepted.
> >=20
> > Well my sentence have its subject switched here. I mean the TI PRU
> > ETH
> > driver is rejecting modes.
>=20
> Which is theoretically fine. I've not looked at this driver in
> particular, but there are some MACs were you cannot disable the
> delay.
> The MAC always imposes 2ns delay. That would mean a PCB which also
> has
> extra long clock lines is simply FUBAR, cannot work, and 'rgmii' is
> invalid, so reject it.

BTW I found that in some case the assumption of PHY-side delay being
always better than MAC-side one is wrong -- modern MACs usually have
adjustable delay line, but Realtek 8211-series PHYs have only on/off
delay with a fixed 2ns value.

>=20
> > Well I am not sure, considering two examples I raised here (please
> > note
> > I am comparing QCOM ETHQOS and TI PRUETH two drivers, they have
> > contrary handling of RGMII modes, and one matches the old binding
> > document, one matches the new one).
>=20
> Nope, i fully agree with Russell, the binding has not changed, just
> the
> words to explain the binding.

Well I read about phy.rst, and I found my understanding of the old
binding matches my understanding of phy.rst, but does not match the new
binding.

>=20
> Just for a minute, consider your interpretation of the old text is
> wrong. Read the old text again and again, and see if you can find an
> interpretation which is the same as the new text. If you do:
>=20
> * It proves our point that describing what this means is hard, and
> =C2=A0 developers will get it wrong.
>=20
> * There is an interpretation of both the old and new where nothing
> =C2=A0 changed.
>=20
> * You have to be careful looking at drivers, because some percent of
> =C2=A0 developers also interpreted it wrongly, and have broken
> =C2=A0 implementations as a result.=C2=A0 You cannot say the binding mean=
s X,
> =C2=A0 not Y, because there is a driver using meaning X.
>=20
> My hope with the new text is that it focuses on hardware, which is
> what DT is about. You can look at the schematic, see if there is
> extra
> long clock lines or not, and then decided on 'rgmii-id' if there are
> not, and 'rgmii' is there are. The rest then follows from that.

Well I think "rgmii-*" shouldn't exist at all, if focusing on hardware.
I prefer only "rgmii" with properties describing the delay numbers.

>=20
> And if you look at the questions i've been asking for the last year
> or
> more, i always start with, "Does the PCB have extra long clock
> lines?".
>=20
> > > The RGMII modes have been documented in
> > > Documentation/networking/phy.rst
> > > (Documentation/networking/phy.txt predating) since:
> >=20
> > I checked the document here, and it seems that it's against the
> > changed
> > binding document (it matches the original one):
> >=20
> > The phy.rst document says:
> > ```
> > * PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for
> > inserting
> > any
> > =C2=A0 internal delay by itself, it assumes that either the Ethernet MA=
C
> > (if
> > capable)
> > =C2=A0 or the PCB traces insert the correct 1.5-2ns delay
> > ```
> >=20
> > The changed binding document says:
>=20
> You are not reading it carefully enough. The binding describes
> hardware, the board. phy.rst describes the phylib interface. They are
> different.

Well I can't find the reason of phy-mode being so designed except for
leaky abstraction from phylib.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Andrew


