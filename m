Return-Path: <netdev+bounces-197375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AFAD8532
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 10:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649611889010
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD42DA76C;
	Fri, 13 Jun 2025 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="rGsB++Qe"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7522DA755;
	Fri, 13 Jun 2025 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749801741; cv=pass; b=jSY5hl+kJoE/zVvsOtbr9jGBiCcXTf8Yi1STu/s/Y9d0wl1T4xnaLwOpYOHSWL3cDvnJn8tGMbhwglntYJLp54GDvYK8ZWDhCiGw8EOsI6FcByueH3TXERyoQ1a72xjqHQSO6KGDflVFXGya5NYOCfHEsWjDZm/AyZJ+72422uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749801741; c=relaxed/simple;
	bh=IriJbLd3oW21fvlp51YbALvpgoBSDDPr2ACz05AwQb8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qb8w4d9+Iev0SOyJ9LyLV1EjcMjZd7FVeetdELaNJqAGGnYchdj4RebMWWxH/LhprS9Pj989cYfeLpvclNha0VoU6X8CbWOqaLczlkduBC2XfjhesP60APN7qMG4sNmF8HY5aTCVyeJqihCQWqGq+vB06TJKWBjsYSVMIX5RCW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=rGsB++Qe; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1749801707; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BeYh0vqVWvMsZH2jhwqNWP0o2xljKxT0qmmEyR8a3x1dXIjsO6mau0NqMB8fs9S/XFOMfAOBWntFIwRmNhPDW6xvBJ/uC/bDc6jhp4DSsmSixTOVEnJUr3qDhF6qXhRaFzILbLnNeKjSypKQ3ztP+X9r8z7e3/FK9Ay9JELE2GQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749801707; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IriJbLd3oW21fvlp51YbALvpgoBSDDPr2ACz05AwQb8=; 
	b=HPnZ1qGJ7DTdrwINps2F2lH8tIh2Vr+P59gp5y9Rmu4KewkXnvFyRdmc6X7K0bWaLtYqV+oB8O95rGVvihBiRinTvIzfD5/7SvFDglaiIeYrV6cIu44e78Y5ehLG08/x42zAJjUN8Wl1ned7T5LxXJsd6fqrWThYNSLf3xEaKpo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749801707;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=IriJbLd3oW21fvlp51YbALvpgoBSDDPr2ACz05AwQb8=;
	b=rGsB++Qe5OLSz6rEIGPzgSBLlPY4ps0FFHo3O2RKLHtaKsV85LeAOTh/twHZzFAo
	wrH9bLSteSUHmLWWXgff6MoGXTBdRNXRUknrOWJBvU4BLx/qONmIF1aJO4OtO/SfzuN
	P3JkEZrKMHG4Wzln0QSmYnk8qG3+2/56xTrJ4hHx2+ZBjrik/fNxcKaFknYG1xXcSoR
	Hy9Be8CiGu4ICxCpqLRQG8PpNHiMaOyqiRPpM8f8y/8CkhD+RuZQQTdGFtzybJ5JOsp
	saOrRj2LZLVndqi2kgs9GP82qfv29LD8vj1yZRZd00JALrvcpQY6vyCHkmlMP+NR4jw
	kOD6/J9SJg==
Received: by mx.zohomail.com with SMTPS id 1749801704443553.1069514426033;
	Fri, 13 Jun 2025 01:01:44 -0700 (PDT)
Message-ID: <40fc8f3fec4da0ed2b59e8d2612345fb42b1fdd3.camel@icenowy.me>
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
Date: Fri, 13 Jun 2025 16:01:37 +0800
In-Reply-To: <f82a86d3-6e06-4f24-beb5-68231383e635@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
	 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
	 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
	 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
	 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
	 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
	 <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
	 <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>
	 <aElArNHIwm1--GUn@shell.armlinux.org.uk>
	 <fc7ad44b922ec931e935adb96dcc33b89e9293b0.camel@icenowy.me>
	 <f82a86d3-6e06-4f24-beb5-68231383e635@lunn.ch>
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

=E5=9C=A8 2025-06-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 17:28 +0200=EF=BC=
=8CAndrew Lunn=E5=86=99=E9=81=93=EF=BC=9A
> > Well in fact I have an additional question: when the MAC has any
> > extra
> > [tr]x-internal-delay-ps property, what's the threshold of MAC
> > triggering patching phy mode? (The property might be only used for
> > a
> > slight a few hundred ps delay for tweak instead of the full 2ns
> > one)
>=20
> Maybe you should read the text.
>=20
> The text says:
>=20
> =C2=A0 In the MAC node, the Device Tree properties 'rx-internal-delay-ps'
> =C2=A0 and 'tx-internal-delay-ps' should be used to indicate fine tuning
> =C2=A0 performed by the MAC. The values expected here are small. A value
> of
> =C2=A0 2000ps, i.e 2ns, and a phy-mode of 'rgmii' will not be accepted by
> =C2=A0 Reviewers.
>=20
> So a few hundred ps delay is fine. The MAC is not providing the 2ns
> delay, the PHY needs to do that, so you don't mask the value.

Thus if the MAC delay is set to 1xxx ps (e.g. 1800ps), should the MAC
do the masking?

What should be the threshold? 1ns?

>=20
> > > > Well I can't find the reason of phy-mode being so designed
> > > > except
> > > > for
> > > > leaky abstraction from phylib.
> > >=20
> > > I have no idea what that sentence means, sorry.
> >=20
> > Well, I mean the existence of rgmii-* modes is coupled with the
> > internal of phylib, did I get it right?
>=20
> This is the external API of phylib, it has nothing to do with the
> internals of phylib.
>=20
> /**
> =C2=A0* phy_attach - attach a network device to a particular PHY device
> =C2=A0* @dev: network device to attach
> =C2=A0* @bus_id: Bus ID of PHY device to attach
> =C2=A0* @interface: PHY device's interface
> =C2=A0*
> =C2=A0* Description: Same as phy_attach_direct() except that a PHY bus_id
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0 string is passed instead of a pointer to =
a struct phy_device.
> =C2=A0*/
> struct phy_device *phy_attach(struct net_device *dev, const char
> *bus_id,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy_interface_t interface)
>=20
> interface tells the PHY how it should configure its interface.
>=20
> If you follow the guidelines, the PHY adds the delay if needed, you
> get interface =3D=3D phy-mode. However, interface and phy-mode are
> different things. phy-mode describes the hardware, the PCB. interface
> tells the PHY what to do. There are legitimate cases where
> interface !=3D phy-mode.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Andrew


