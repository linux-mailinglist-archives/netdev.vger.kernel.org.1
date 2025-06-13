Return-Path: <netdev+bounces-197383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C0CAD85DC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 10:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED6317A689
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BAB2727EF;
	Fri, 13 Jun 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="W8P3e+jC"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC052DA740;
	Fri, 13 Jun 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804234; cv=pass; b=OeC4Bppq0CU1iCX/vZmGY+iRyoVBMwoxMrwx0nIjezWIUoNybHokdYnhAH2PMfjLqJOrK1OJkPdlNsr5rmlXR4B0rlWs1ywLnk+pdNGKnryLVFQjPXEcZCJFUB/Y6y5avv1nAqH81Vn8L7Gh4eSRqYfGXPqTn9jHijkm9aSqGLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804234; c=relaxed/simple;
	bh=OR/hPjmN0Ys4mjQUpexypW3uwSBPrm+kW5FAAGN94mY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUeo7fDj2Y5xflDC6cqv1hCfFbC7OUJsOdQPdAOERhUZ4SsLkmo1K2tgdUEyYc05vx0eN6fGrWfdK3DPw8wW+rwL602ZZlWPKh6NDnvjoPMduEavKDAuNqDQHTBc/7SAUBsa8KrCLBQqW9iHUT0dGPdpYBtBZO9U2apGOSiX758=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=W8P3e+jC; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1749804204; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZOWJtLM+GrjPSVMu7bHfGBqfS9LbaFHmkwnvA3HZ5XGkUDeKMbHvLmdSVJ73eoq/kpOnoWXJ7RxI/r6Bv+IUcX6ukeurLUKICpX+hlOk2ZYzalbprK7k5vBtHjyfr0pKVh+EvarVxLd6BvTjz81GLSpIDX4OLHM1487c/guL+dg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749804204; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OR/hPjmN0Ys4mjQUpexypW3uwSBPrm+kW5FAAGN94mY=; 
	b=NE7wJBvn5ofuxvXb66F5mpcTTZH975QQDsPXpTZRz/9on7tdRGWzaIGweg3ZoNqvcZ/wkh49x3e9+9hcQUtMvuYtUWoeQOoKs5nw3apIMhIrULMq23uA9Ob+n8MNUUpYdpjBFvdJLg8Xjqs4L9wRlTOBSx0htE2kIooZLQxwZ80=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749804204;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=OR/hPjmN0Ys4mjQUpexypW3uwSBPrm+kW5FAAGN94mY=;
	b=W8P3e+jCFRL+ZPrEd/jhER2tjTY98xHCvdHS9t6zUUzUKxpq5URA6vt2If8LiOxb
	F7O9in+VOz7XTjY7MhLkzIFiTGxOtWNFOFOVOMk3C96vHoGhHUEecwkx2QPGaVkZudT
	Ur0xfwx0liabFEVXCHoaQceMD90mKZC5lpHPxo5bm5zOjMh3in3xZAPT/KOtDNgyAAM
	mJ02p7HpEklNG3/NHRPNsJ+ZDmwPFJWzBI797y/7YVbjfb+2+nmHZoYihVaRNH20+Qz
	7DRH+nYhsttn2wb9kZ3nq3rBb1ak1+9fBgtKOI51PtBk8zzROl1stRz9eGuzcVZI6CB
	cXR0D04UGQ==
Received: by mx.zohomail.com with SMTPS id 1749804202336885.2970551790019;
	Fri, 13 Jun 2025 01:43:22 -0700 (PDT)
Message-ID: <9922727607de39da7ed75d1edaf1873147e26336.camel@icenowy.me>
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
Date: Fri, 13 Jun 2025 16:43:14 +0800
In-Reply-To: <aEvi5DTBj-cltE5w@shell.armlinux.org.uk>
References: <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
	 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
	 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
	 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
	 <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
	 <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>
	 <aElArNHIwm1--GUn@shell.armlinux.org.uk>
	 <fc7ad44b922ec931e935adb96dcc33b89e9293b0.camel@icenowy.me>
	 <f82a86d3-6e06-4f24-beb5-68231383e635@lunn.ch>
	 <40fc8f3fec4da0ed2b59e8d2612345fb42b1fdd3.camel@icenowy.me>
	 <aEvi5DTBj-cltE5w@shell.armlinux.org.uk>
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

=E5=9C=A8 2025-06-13=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 09:35 +0100=EF=BC=
=8CRussell King (Oracle)=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Jun 13, 2025 at 04:01:37PM +0800, Icenowy Zheng wrote:
> > =E5=9C=A8 2025-06-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 17:28 +0200=EF=
=BC=8CAndrew Lunn=E5=86=99=E9=81=93=EF=BC=9A
> > > > Well in fact I have an additional question: when the MAC has
> > > > any
> > > > extra
> > > > [tr]x-internal-delay-ps property, what's the threshold of MAC
> > > > triggering patching phy mode? (The property might be only used
> > > > for
> > > > a
> > > > slight a few hundred ps delay for tweak instead of the full 2ns
> > > > one)
> > >=20
> > > Maybe you should read the text.
> > >=20
> > > The text says:
> > >=20
> > > =C2=A0 In the MAC node, the Device Tree properties 'rx-internal-delay=
-
> > > ps'
> > > =C2=A0 and 'tx-internal-delay-ps' should be used to indicate fine
> > > tuning
> > > =C2=A0 performed by the MAC. The values expected here are small. A
> > > value
> > > of
> > > =C2=A0 2000ps, i.e 2ns, and a phy-mode of 'rgmii' will not be accepte=
d
> > > by
> > > =C2=A0 Reviewers.
> > >=20
> > > So a few hundred ps delay is fine. The MAC is not providing the
> > > 2ns
> > > delay, the PHY needs to do that, so you don't mask the value.
> >=20
> > Thus if the MAC delay is set to 1xxx ps (e.g. 1800ps), should the
> > MAC
> > do the masking?
> >=20
> > What should be the threshold? 1ns?
>=20
> Why should there be a "threshold" ? It's really a case by case issue
> where the capabilities of the hardware need to be provided and
> considered before a decision can be made.
>=20
> In order to first understand this, one needs to understand the
> requirements of RGMII. RGMII v1.3 states:
>=20
> Symbol=C2=A0=C2=A0Parameter=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Min=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Typ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Max=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Units
> TskewT=C2=A0=C2=A0Data to Clock output=C2=A0=C2=A0=C2=A0=C2=A0-500=C2=A0=
=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0500=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ps
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0skew at clock tx
> TskewR=C2=A0=C2=A0Data to Clock input=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A02.6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ns
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0skew at clock rx
>=20
> The RGMII specification is written based upon the clock transmitter
> and receiver having no built-in delays, and the delay is achieved
> purely by trace routing. So, where delays are provided by the
> transmitter or receiver (whether that's the MAC or the PHY depends
> on whether TXC or RXC is being examined) these figures need to be
> thought about.
>=20
> However, the range for the delay at the receiver is -1ns to +0.6ns.
>=20
> In your example, you're talking about needing a 1800ps delay. I
> would suggest that, *assuming the PCB tracks introduce a 200ps skew
> between the data and clock*, then using the PHY's built-in 2ns delay
> is perfectly within the requirements of the RGMII specification.
>=20
> That bit "assuming" is where the discussion needs to happen, and why
> it would be case by case. If the skew due to trace routing were
> 800ps, then enabling the PHY's built-in 2ns delay would take the
> delay out of spec.
>=20
> Thrown into this would also be temperature effects, so trying to get
> to as near as the 2ns delay as possible is probably a good idea.
>=20
> Lastly, there's the question whether the software engineer even
> knows what the skew provided by the hardware actually is.

Sigh, my experience is that the only thing I can get is some magic
numbers from HW vendor... *facepalm*

>=20


