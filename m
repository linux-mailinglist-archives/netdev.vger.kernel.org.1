Return-Path: <netdev+bounces-186403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3BFA9EF11
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F1D17470B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFEC263F24;
	Mon, 28 Apr 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eNNzABl8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NPvGMTUx"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6A1FE455;
	Mon, 28 Apr 2025 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839765; cv=none; b=eXta31SYnUy3+Mx50bqN4++qSHhCHldz+weSTp8fw0JVUk3R9lFKPTTfCFnQ1HA2QoaeGSvFIZ+KoCJWPF4C/2wl7FWaFiYDGOxupwAGdgk3eaQ5WPGvJpfF2VdESRs9iRUMRqWDcMQc2yFG8kv3mUMJNmfFICB4cjEElgQewd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839765; c=relaxed/simple;
	bh=EKKMrPej81KyZGZ10QxmC8NmDUprsyN5X1Rkw22KlT0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwqdcsJKJcqzeGy4fD1dpIWs5g8N9U/BB+CuM57w6YR1bAhIL6KYUZ90MOlDwqfc8leWe0iBjORNkr5vW7JULo1mjRVCpoklfa1sMIU/XXPt/SrfFSiE/viBxQgB1yGLzJW9nWqm5/umMu7AQfNVuMRdJBZz/oSNAOvjohih3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=eNNzABl8; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NPvGMTUx reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1745839761; x=1777375761;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Cq98/zkrJ+DPiahPHTvhxm5A2xb5KjEuYB0F+q9PQvU=;
  b=eNNzABl8Bn1SC97VcFbvE+JDuShuNTh3IVZ1JyWNqyJKwH2LUfl6tW+G
   eZGImIlzxdk1uN3lA7eYeqn0gJM0H30f8uil7N8NBCPThpTh3ixFZNTR4
   3l7HhSVv9tQfa+yBOwOPaLt29KHy7TSKmJ0W8/NPo4zuhJsVWwGErdO8E
   OTcqJI/MkG/KCIWXboGyWkujKtSE6kLDpSX0KovmM3T5D952P65KurIMv
   aGaaYvjaQ1IfclD0OFnYeLo+chSc/m20qvciGENfc4Q7mhWnGoJlnV3Uy
   6tfzJ77GfEW1/nfJzZySi8O/uye94z8XHIgGUElb0toUgIlb06zWdJR4x
   A==;
X-CSE-ConnectionGUID: wGLouyhaSEatsLIy1ZkH0g==
X-CSE-MsgGUID: xRx/UB5jRn+RqK4JZTNLEg==
X-IronPort-AV: E=Sophos;i="6.15,246,1739833200"; 
   d="scan'208";a="43755037"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Apr 2025 13:29:17 +0200
X-CheckPoint: {680F668D-37-DC4DC9A0-F4F29281}
X-MAIL-CPID: 92416D2BEC79E19CE8A8E41B1ECA48D1_0
X-Control-Analysis: str=0001.0A006371.680F6690.0071,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BE17160FA3;
	Mon, 28 Apr 2025 13:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1745839753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq98/zkrJ+DPiahPHTvhxm5A2xb5KjEuYB0F+q9PQvU=;
	b=NPvGMTUxtqvAJBxAqix3003M7QATS9Znq/TCO4knfN15huoSW3V5j2X4HAUThh+O9lvImv
	V1wmEYi66zjTLA18sas9L3bNQTlrOdTSC/g4j9rA0wCvk2KIvH1JPqgBF/xLdwlcDz4Pvu
	OBIzRlkvjL5cCF8c/sZukesxNTA3nBoEwkIMxVXAoaTin98wNnWiIIMnRWBVR+ldpkLwAE
	SX4mXI++KhickEdMsm+Gi6NigTSJZVcldFlGVk9F5+DdPO8/IZwYs/KvtThYRnK5622URq
	MItqRWIZGqNs0+7eD95Qasyw8jHSdRYDcBjPCUJv5CRbv1f4sHEMyO6Ff+AjKg==
Message-ID: <fdc02e46e4906ba92b562f8d2516901adc85659b.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
	 <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Whitcroft
 <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Jonathan Corbet
 <corbet@lwn.net>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Date: Mon, 28 Apr 2025 13:29:06 +0200
In-Reply-To: <aAe2NFFrcXDice2Z@shell.armlinux.org.uk>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
	 <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
	 <aAe2NFFrcXDice2Z@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 2025-04-22 at 16:31 +0100, Russell King (Oracle) wrote:
> ********************
> Achtung externe E-Mail: =C3=96ffnen Sie Anh=C3=A4nge und Links nur, wenn =
Sie wissen, dass diese aus einer sicheren Quelle stammen und sicher sind. L=
eiten Sie die E-Mail im Zweifelsfall zur Pr=C3=BCfung an den IT-Helpdesk we=
iter.
> Attention external email: Open attachments and links only if you know tha=
t they are from a secure source and are safe. In doubt forward the email to=
 the IT-Helpdesk to check it.
> ********************
>=20
> On Tue, Apr 22, 2025 at 05:00:37PM +0200, Andrew Lunn wrote:
> > On Mon, Apr 21, 2025 at 08:20:29PM +0100, Russell King (Oracle) wrote:
> > > On Tue, Apr 15, 2025 at 12:18:01PM +0200, Matthias Schiffer wrote:
> > > > diff --git a/Documentation/devicetree/bindings/net/ethernet-control=
ler.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > > > index 45819b2358002..2ddc1ce2439a6 100644
> > > > --- a/Documentation/devicetree/bindings/net/ethernet-controller.yam=
l
> > > > +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yam=
l
> > > > @@ -74,19 +74,21 @@ properties:
> > > >        - rev-rmii
> > > >        - moca
> > > > =20
> > > > -      # RX and TX delays are added by the MAC when required
> > > > +      # RX and TX delays are part of the board design (through PCB=
 traces). MAC
> > > > +      # and PHY must not add delays.
> > > >        - rgmii
> > > > =20
> > > > -      # RGMII with internal RX and TX delays provided by the PHY,
> > > > -      # the MAC should not add the RX or TX delays in this case
> > > > +      # RGMII with internal RX and TX delays provided by the MAC o=
r PHY. No
> > > > +      # delays are included in the board design; this is the most =
common case
> > > > +      # in modern designs.
> > > >        - rgmii-id
> > > > =20
> > > > -      # RGMII with internal RX delay provided by the PHY, the MAC
> > > > -      # should not add an RX delay in this case
> > > > +      # RGMII with internal RX delay provided by the MAC or PHY. T=
X delay is
> > > > +      # part of the board design.
> > > >        - rgmii-rxid
> > > > =20
> > > > -      # RGMII with internal TX delay provided by the PHY, the MAC
> > > > -      # should not add an TX delay in this case
> > > > +      # RGMII with internal TX delay provided by the MAC or PHY. R=
X delay is
> > > > +      # part of the board design.
> > > >        - rgmii-txid
> > > >        - rtbi
> > > >        - smii
> > >=20
> > > Sorry, but I don't think this wording improves the situation - in fac=
t,
> > > I think it makes the whole thing way more confusing.
> > >=20
> > > Scenario 1: I'm a network device driver author. I read the above, Oka=
y,
> > > I have a RGMII interface, but I need delays to be added. I'll detect
> > > when RGMII-ID is used, and cause the MAC driver to add the delays, bu=
t
> > > still pass PHY_INTERFACE_MODE_RGMII_ID to phylib.
> > >=20
> > > Scenario 2: I'm writing a DT file for a board. Hmm, so if I specify
> > > rgmii because the delays are implemented in the traces, but I need to
> > > fine-tune them. However, the documentation says that delays must not
> > > be added by the MAC or the PHY so how do I adjust them. I know, I'll
> > > use rgmii-id because that allows delays!
> > >=20
> > > I suspect neither of these two are really want you mean, but given
> > > this wording, that's exactly where it leads - which is more
> > > confusion and less proper understanding.
> >=20
> > These DT documents are supposed to be normative and OS agnostic. I
> > wounder what the DT Maintainers will say if we add an Informative
> > section afterwards giving a detailed description of how Linux actually
> > implements these normative statements? It will need to open with a
> > clear statement that it is describing Linux behaviour, and other OSes
> > can implement the normative part in other ways and still be compliant,
> > but that Linux has seen a lot of broken implementations and so wants
> > to add Informative information to guide Linux developers.
>=20
> Well, looking at ePAPR, the only thing that was defined back then was
> the presence of a property to describe the interface type between the
> ethernet device and PHY. The values were left to the implementation
> to decide upon, but with some recommendations.
>=20
> What that means is that the values to this property are not part of
> the DT standard, but are a matter for the implementation.
>=20
> However, with the yaml stuff, if that is basically becoming "DT
> specification" then it needs to be clearly defined what each value
> actually means for the system, and not this vague airy-fairy thing
> we have now.
>=20
> We've learnt the hard way in the kernel where that gets us with
> the number of back-compat breaking changes we've had to make where
> the RGMII delays have been totally wrongly interpreted and leaving
> it vague means that other implementations will suffer the same pain.

I agree with Russell that it seems preferable to make it unambiguous whethe=
r
delays are added on the MAC or PHY side, in particular for fine-tuning. If
anything is left to the implementation, we should make the range of accepta=
ble
driver behavior very clear in the documentation.

Historically, there appear to exist at least 4 different ways to handle the
RGMII modes in MAC drivers:

(I'm using the terms "id" and "noid" in the following to refer to modes wit=
h and
without delays independently of the direction; a single driver may fall int=
o
different categories for the RX and TX side)

1) MAC ignores the mode, does not add delays, passes the mode to the PHY
  - Mode "noid" is used when delays are added by the PCB
  - PHY sees the same interface mode that is specified in the DT
  - Does not match the old wording of the DT binding docs (as the MAC never=
 adds
    delays)

2) MAC adds delays in "noid" mode, passes the mode to the PHY unchanged
  - Delays added by the PCB can only be supported via driver-specific
    fine-tuning properties on the MAC or PHY side
  - Without driver-specific properties, none of the modes allow for delays =
on
    the PCB; every mode adds delays either on the MAC or the PHY side
  - PHY sees the same interface mode that is specified in the DT
  - Matches the old wording of the DT binding docs (which don't allow for d=
elays
    added by the PCB)

3) MAC has a fixed delay, but also passes the interface mode unchanged to t=
he
  PHY (example: TX delays in TI CPSW AM65)
  - No support for delays on the PCB due to hardware limitation
  - PHY sees the same interface mode that is specified in the DT
  - For the direction in which the delays are added by the MAC, you need to
    specify "noid" in the DT even though there is an internal delay

4) MAC adds delays in "id" mode and fixes it up so "noid" is passed to
  the PHY (example: TX delays in TI ICSSG)
  - No support for delays on the PCB due to hardware limitation
  - PHY does NOT see the same interface mode that is specified in the DT
  - Fine-tuning options may be confusing because of the fixup

Of all of these variants:
- 1 and 2 appear to be most common in existing MAC drivers
- 2 and maybe 3 match the old wording of the DT binding docs
- 1, 2 and 3 pass the interface mode unchanged to the PHY
- 1 and 4 match my proposed new wording of the DT binding docs based on And=
rew's
  input
- 1 allows for designs that have a delay on the PCB without driver-specific
  fine-tuning
- 2 and maybe 3 and 4 allow for designs where the PHY can't add delays and =
none
  exist on the PCB (or there is no PHY - could be two SoCs directly connect=
ed
  via RGMII, or a switch IC we can't control)

And of course, things become even more muddled when driver-specific propert=
ies
for fine-tuning etc. are involved.

Any change to existing drivers will need to be made in a backwards-compatib=
le
way, meaning that we can't break compatibility with old Device Trees. If we
somehow want to clean up this mess, and also support delays on the PCB, des=
igns
without (configurable) PHY, and unambiguously specify where delays are adde=
d, I
don't think the existing rgmii(-*id) modes are going to suffice. I think
something along the lines of the following might be a possible way forward:

- Introduce new DT properties to specify whether delays should be added on =
the
MAC or PHY side, for RX and TX independently. Could also replace some drive=
r-
specific fine-tuning properties.
- In the presence of the new properties, only "rgmii" can be specified as p=
hy-
mode, the delays are not part of the PHY mode property anymore
- MAC and PHY drivers must reject delay configurations they can't satisfy
- Not specifying the new properties results in a deprecation warning on exi=
sting
drivers. New drivers make the new properties mandatory.
- Not specifying the new properties causes drivers to interpret "rgmii(-*id=
)"
however they have done in the past to maintain backwards compatibility

Implementation of the new properties would need to be done in a way that al=
lows
MAC and PHY drivers to be converted one by one, and to only print deprecati=
on
warnings asking for the DT to be fixed once the conversion has been done.
Attempting to specify the new properties when not both MAC and PHY driver
support them must be rejected, so the drivers gaining support for them can'=
t
result in a breaking change.

I would be very happy to hear some feedback on these ideas - of course,
alternative ideas that are easier to implement would be even more welcome..=
.

Best,
Matthias


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

