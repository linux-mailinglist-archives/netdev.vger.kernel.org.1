Return-Path: <netdev+bounces-182731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BACA89C7D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88732167BD3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4D29117F;
	Tue, 15 Apr 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QzSY+1mk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pfGHhhh1"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1AD29117B;
	Tue, 15 Apr 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716542; cv=none; b=XtoRK7GrM6bgXXmrHOhyQSXrsXg5j6GF7QyoCPdtE+tlerPlzwl1WcJg6Ce0GX1+rSZCzCqsaa4xbIjS9ZOADGZuaB6aq9F7pTBGINuYJxcXLhkhH6G0FaayNPesJ88IEkT/MV/A334tyezNHzkCODRZAhTeF6vqMkmKaNUgA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716542; c=relaxed/simple;
	bh=HkGK4vKcs2199YO0fGdWUg9GcSJPiCpZOIr/Szy0PUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J4+isDeu26WOYAI1iv0q5uNBl5s/7UfLewFK2/FKjeVvReJBVpnVSQZss0Fyy1g8LVSK8Hav+hIOPqheS30Mqn/I+A02Dz9SFAmVjEl5uw1xJqZ9gizOOda86ousChPCY87e0PfZTOT+f9DMNitVZ4kM4OtoGC7eP0NsppMtxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QzSY+1mk; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pfGHhhh1 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744716539; x=1776252539;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mYfOX7V+RukALTVJ8Qi0exktDRQwn3ad8TOZoUSa2Qs=;
  b=QzSY+1mkLi0kFNWpIrh9ZQtkHDvaDnBA+IYAiY3ehV8wlc5CTFz2Q048
   odYXdZTQZFHgNssT9hh1mNq35ZHNLKffkwWlyVDd7Ufqe1sU2iZaWNTel
   RJTWwbYDYyhu7gtNoQZMWub6MjKBTcdevc6m5QvRF0yaCWZsv4RDfw9Wz
   Aix0K4AaZ8Q5NWYDskRsuS7QhRktFTn0hWZ3ktJVqcBXohFpUkuuSuKUC
   PThIERxSirTE969BBRfSTUVlpXNhKEziZxVyfCVR9RFsaQAyO2oiLp1vr
   E1KIA0h1FCZIkCRFeLKf5eoj+WnmfrD7eDWqWugq8QjUYu2XjWr1MrRZD
   A==;
X-CSE-ConnectionGUID: vXCahAz8Qt2JyThBws63mw==
X-CSE-MsgGUID: kYpqigZ5SqehRJK/H93HBA==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43539741"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 13:28:55 +0200
X-CheckPoint: {67FE42F7-22-B1D34AC3-DEA5B19F}
X-MAIL-CPID: 711BF174EC8067FD99CF9D8CB63779DE_4
X-Control-Analysis: str=0001.0A006374.67FE42EA.007C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DD8A165E7F;
	Tue, 15 Apr 2025 13:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744716530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYfOX7V+RukALTVJ8Qi0exktDRQwn3ad8TOZoUSa2Qs=;
	b=pfGHhhh1oTEs/xBWDSj8LUf9ShgiCi7VgdPYiuGvNXG5xphp+EBH09XLaali19JDQZxCET
	4gIOjjzMDHQZHiMpK8S9BpuJWqWsjhvdAWZcb/0ike2AGTJ/PmNLgtFwrmKyXuy4qNKdXw
	CRaH+/VtIpzD467WnNG43Q4gg1o3XMr/Ph7tIhKWplLHCS2ZplnPpS7FtM2BIurUgzzD/K
	wymqT2YbGckWBt3/5yJ3aVCix3azGs2ZprELQv61+z+kQH+0UehkQocQwbqDQ16aSKGXmf
	oVwZgl2CKMo1G1thmHXVb83n2a+hYrj9+3exhFUU5QyhngmG84KjYwlPFyd1RQ==
Message-ID: <cd483b43465d6e50b75f0b11d0fae57251cdc3db.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
 <nm@ti.com>,  Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Date: Tue, 15 Apr 2025 13:28:48 +0200
In-Reply-To: <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>
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

On Tue, 2025-04-15 at 16:06 +0530, Siddharth Vadapalli wrote:
>=20
> On Tue, Apr 15, 2025 at 12:18:01PM +0200, Matthias Schiffer wrote:
> > As discussed [1], the comments for the different rgmii(-*id) modes do n=
ot
> > accurately describe what these values mean.
> >=20
> > As the Device Tree is primarily supposed to describe the hardware and n=
ot
> > its configuration, the different modes need to distinguish board design=
s
>=20
> If the Ethernet-Controller (MAC) is integrated in an SoC (as is the case
> with CPSW Ethernet Switch), and, given that "phy-mode" is a property
> added within the device-tree node of the MAC, I fail to understand how
> the device-tree can continue "describing" hardware for different board
> designs using the same SoC (unchanged MAC HW).

The setting is part of the MAC node, but it is always set in the board DTS,
together with assigning a PHY to the MAC.

> How do we handle situations where a given MAC supports various
> "phy-modes" in HW? Shouldn't "phy-modes" then be a "list" to technically
> descibe the HW? Even if we set aside the "rgmii" variants that this
> series is attempting to address, the CPSW MAC supports "sgmii", "qsgmii"
> and "usxgmii/xfi" as well.

This is not about PHY mode support of the MAC, but the mode to be used on a
particular board. I would not expect a board to use multiple different
interfaces with a single PHY (and if such cases exist, I consider them out =
of
scope for this patch series).

>=20
> > (if a delay is built into the PCB using different trace lengths); wheth=
er
> > a delay is added on the MAC or the PHY side when needed should not matt=
er.
> >=20
> > Unfortunately, implementation in MAC drivers is somewhat inconsistent
> > where a delay is fixed or configurable on the MAC side. As a first step
> > towards sorting this out, improve the documentation.
> >=20
> > Link: https://lore.kernel.org/lkml/d25b1447-c28b-4998-b238-92672434dc28=
@lunn.ch/ [1]
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  .../bindings/net/ethernet-controller.yaml        | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.=
yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > index 45819b2358002..2ddc1ce2439a6 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > @@ -74,19 +74,21 @@ properties:
> >        - rev-rmii
> >        - moca
> > =20
> > -      # RX and TX delays are added by the MAC when required
> > +      # RX and TX delays are part of the board design (through PCB tra=
ces). MAC
> > +      # and PHY must not add delays.
> >        - rgmii
> > =20
> > -      # RGMII with internal RX and TX delays provided by the PHY,
> > -      # the MAC should not add the RX or TX delays in this case
> > +      # RGMII with internal RX and TX delays provided by the MAC or PH=
Y. No
> > +      # delays are included in the board design; this is the most comm=
on case
> > +      # in modern designs.
> >        - rgmii-id
> > =20
> > -      # RGMII with internal RX delay provided by the PHY, the MAC
> > -      # should not add an RX delay in this case
> > +      # RGMII with internal RX delay provided by the MAC or PHY. TX de=
lay is
> > +      # part of the board design.
> >        - rgmii-rxid
> > =20
> > -      # RGMII with internal TX delay provided by the PHY, the MAC
> > -      # should not add an TX delay in this case
> > +      # RGMII with internal TX delay provided by the MAC or PHY. RX de=
lay is
> > +      # part of the board design.
>=20
> Since all of the above is documented in "ethernet-controller.yaml" and
> not "ethernet-phy.yaml", describing what the "MAC" should or shouldn't
> do seems accurate, and modifying it to describe what the "PHY" should or
> shouldn't do seems wrong.

The settings describe the connection between MAC and PHY, thus their explan=
ation
must mention both to make sense. See the linked discussion with Andrew for
details.

Best,
Matthias



>=20
> >        - rgmii-txid
> >        - rtbi
> >        - smii
>=20
> Regards,
> Siddharth.

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

