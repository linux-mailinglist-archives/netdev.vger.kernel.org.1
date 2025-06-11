Return-Path: <netdev+bounces-196563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2C7AD5522
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957923A8BB6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF527BF95;
	Wed, 11 Jun 2025 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="KmYJVR/G"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26E27A12B;
	Wed, 11 Jun 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643931; cv=pass; b=XEe0EavM6ILXJmKu+DCdXvqkFgu6IvggmIRHPZab1sCOeT1ENRJQWyBxLUKt8r8oGwNdX2xav/M6z1Mv1A9z2OXrnfzx4zbCfJQsVfw9lhvCZV20iuHBvq/d3E+vAbd3ZgeUJdzhYniLj7otRmHCuUpWLg+9ROwksotV9dpfcqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643931; c=relaxed/simple;
	bh=MUQIuXRfDl4RcuDYVB8bOPsQcL3xPBAHH23OTMB03Dk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJPDncCxvc4sWV6gS8wZFp0w1/NI3ISzzUMAT5UBSnibrWrcDux7iJY3EpIy31PIXP48vG8u0RbywAAaISlY5tdz4JSVsyPqcM9CaulwkqWfFzFFUkXVEmciBBwLL4tgKa56i980M1asMNaBGYkQmZQzrqouDymwO5fbiYUsSX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=KmYJVR/G; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1749643898; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KAKS2d25mKM+c3gQJaSDpijQ6lBIC/PooR62+Nyt1sMtPknLcb8EpK69IMKmoxR7YGd3wyJpOhGYdy0RKTYakv3kVUfbYlz8RmHhFo8DKuN/xadwgBO1VFROvBrIc/IdyA7vtcnCtHnEkVm+MXr5LafKqPH/e3mpNf8Gw5mj+bQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749643898; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MUQIuXRfDl4RcuDYVB8bOPsQcL3xPBAHH23OTMB03Dk=; 
	b=S3aqBXL9IkTTac9qExicp1WjO4c1sMQgwqedC3bKe6vVfHX8rryNO3ECeauVsIhxwdAqteoqTojGhDmdkaDf6jBuWNnx4RqdQu7sclawXopZ8z9kTKX1H5Va1b+yl8bulqP/cA9bqV+cqkW3r8LGz0LHF27cYLkfGpAfO++Jr9c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749643898;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=MUQIuXRfDl4RcuDYVB8bOPsQcL3xPBAHH23OTMB03Dk=;
	b=KmYJVR/GJDNOAg3ysa/7iANuO/cg0bi2jebZA5pLshppm6DYT0igSpWfisx+iVaG
	mUZRCch8ytO11vC/MYGYP4/RrzpsVkTI0Ls1o5Jdsvy+UmERPX/NU0o5gLN6gSIFnhp
	B1/EMorJ8oZsOGh1PpuyvgCr+CEVkcAqSjpyeSCZT5/sTtVuAiYhYVq+kL8rpvIE15s
	do9FTzOPn38QwLecjqj5ZvMw6+TTUrmUF5Ny/U2wjtc6DXiKZlHDIV0lAkzhqgzCZwi
	Zbw87nZj7wE01xGJpjv1z6DLPA6xSw7C2EyDkwdGq8+x7PWBJ7xyUfmPsanUIN8vVou
	S39YO26cgw==
Received: by mx.zohomail.com with SMTPS id 1749643895949130.74543462284248;
	Wed, 11 Jun 2025 05:11:35 -0700 (PDT)
Message-ID: <fc7ad44b922ec931e935adb96dcc33b89e9293b0.camel@icenowy.me>
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
From: Icenowy Zheng <uwu@icenowy.me>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Heiner Kallweit
 <hkallweit1@gmail.com>,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Jun 2025 20:11:27 +0800
In-Reply-To: <aElArNHIwm1--GUn@shell.armlinux.org.uk>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
	 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
	 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
	 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
	 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
	 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
	 <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
	 <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>
	 <aElArNHIwm1--GUn@shell.armlinux.org.uk>
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

=E5=9C=A8 2025-06-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 09:39 +0100=EF=BC=
=8CRussell King (Oracle)=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Jun 11, 2025 at 04:03:11PM +0800, Icenowy Zheng wrote:
> > =E5=9C=A8 2025-06-05=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 15:48 +0200=EF=
=BC=8CAndrew Lunn=E5=86=99=E9=81=93=EF=BC=9A
> > > Which is theoretically fine. I've not looked at this driver in
> > > particular, but there are some MACs were you cannot disable the
> > > delay.
> > > The MAC always imposes 2ns delay. That would mean a PCB which
> > > also
> > > has
> > > extra long clock lines is simply FUBAR, cannot work, and 'rgmii'
> > > is
> > > invalid, so reject it.
> >=20
> > BTW I found that in some case the assumption of PHY-side delay
> > being
> > always better than MAC-side one is wrong -- modern MACs usually
> > have
> > adjustable delay line, but Realtek 8211-series PHYs have only
> > on/off
> > delay with a fixed 2ns value.
>=20
> The only time that MACs may implement delays based on the
> PHY_INTERFACE_MODE_RGMII* is if they also include code to pass
> PHY_INTERFACE_MODE_RGMII (no suffixes) to phylink / phylib to ensure
> that the PHY doesn't _also_ add delays. This isn't something we
> encourage because it's more code, more review, and a different way
> of implementing it - thus adding to maintainers workloads that are
> already high enough.

Well in fact I have an additional question: when the MAC has any extra
[tr]x-internal-delay-ps property, what's the threshold of MAC
triggering patching phy mode? (The property might be only used for a
slight a few hundred ps delay for tweak instead of the full 2ns one)

>=20
> > > Just for a minute, consider your interpretation of the old text
> > > is
> > > wrong. Read the old text again and again, and see if you can find
> > > an
> > > interpretation which is the same as the new text. If you do:
> > >=20
> > > * It proves our point that describing what this means is hard,
> > > and
> > > =C2=A0 developers will get it wrong.
> > >=20
> > > * There is an interpretation of both the old and new where
> > > nothing
> > > =C2=A0 changed.
> > >=20
> > > * You have to be careful looking at drivers, because some percent
> > > of
> > > =C2=A0 developers also interpreted it wrongly, and have broken
> > > =C2=A0 implementations as a result.=C2=A0 You cannot say the binding =
means
> > > X,
> > > =C2=A0 not Y, because there is a driver using meaning X.
> > >=20
> > > My hope with the new text is that it focuses on hardware, which
> > > is
> > > what DT is about. You can look at the schematic, see if there is
> > > extra
> > > long clock lines or not, and then decided on 'rgmii-id' if there
> > > are
> > > not, and 'rgmii' is there are. The rest then follows from that.
> >=20
> > Well I think "rgmii-*" shouldn't exist at all, if focusing on
> > hardware.
> > I prefer only "rgmii" with properties describing the delay numbers.
>=20
> Yes, I think we as phylib maintainers have also come to the same
> conclusion with all the hassle this causes, but we can't get rid
> of this without breaking the kernel and breaking device-tree
> compatibility. So, we're stuck with it.
>=20
> > > You are not reading it carefully enough. The binding describes
> > > hardware, the board. phy.rst describes the phylib interface. They
> > > are
> > > different.
> >=20
> > Well I can't find the reason of phy-mode being so designed except
> > for
> > leaky abstraction from phylib.
>=20
> I have no idea what that sentence means, sorry.

Well, I mean the existence of rgmii-* modes is coupled with the
internal of phylib, did I get it right?

>=20


