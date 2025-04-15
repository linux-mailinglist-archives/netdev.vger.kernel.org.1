Return-Path: <netdev+bounces-182818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350BBA89F93
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFAC3BB434
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C261F130E58;
	Tue, 15 Apr 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="nwnffdO/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dfyCBWDG"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C425771;
	Tue, 15 Apr 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724176; cv=none; b=Sol1q0A6Qu22HGDIJnFDt7V4JMGifc6Tsqb+KCFGfrha8fMjdZjBdBoohzs95LJ3UbNkGYcdpSCSb96S6/WUZ9fWPuAssNVDtufuQtnqotzyT2qj5b9pCGbss+YMkgAlMuxFcN4kMq3jwnO5H7oxCQnbQpN7caLK2DCOsUU6Ans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724176; c=relaxed/simple;
	bh=ShGv+0j38vk8ZczWlXDrMGA0v1GaH0PUgAgEC6HNtqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lEb5hcOC9lz7NOAuJPOI0H9OPK6GNxe2Gz2d9lmA6gFeLZekTRY653VacZqbEUlowcwu8y5XKKzFv+VtgNKSLsaFE45fT5JXAzHF476lv301xmJPSCG+fZxqOEt8WC36o39w4BXcKj/fHUjj0JFgJLxwW709P4o7UkVqqym0J/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=nwnffdO/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dfyCBWDG reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744724175; x=1776260175;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YlumGq7vM1zdawKPQ73srx7Hl+6/OZGTFw8mUGlSyF4=;
  b=nwnffdO/kl/zifIQ4FYjBH/tCCP7RDz+DVYWj5pL1E2WF3E17s99moQk
   nwYg85EXoUFPu6hrTYM7dqrADO3T09zIx+Feqnf4lCIyKBmgV27D3aY1v
   JUyywPC3CgWtrmBGrw25Ck2e3MVq9/1CDz2UN+6+vxFzoU1rjeB2vE3/n
   1uSYxnzD08VhVasISQ+uj5PCosD/3C3uuBHN0396mPsnXG7yVkm5FxbuX
   Il2Qgtgyap5fU7iBhABNY/pAeIwJm578zQ1wsTSMBf4QSUH/K+MrS6Uj9
   6iJQ5j6Y2RCiNvUsuR1K7/toQXTX+97ma351SVprLRaS1Y7tDHo/jqH95
   Q==;
X-CSE-ConnectionGUID: 4JmEHnumSiardRnLnoh2fQ==
X-CSE-MsgGUID: AIsZbzq8TESfdb/5qlUYdg==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43544164"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 15:36:12 +0200
X-CheckPoint: {67FE60CB-23-903EAEAC-E04C76C8}
X-MAIL-CPID: 5B0AF881536021B586ABAFFC070E78C9_5
X-Control-Analysis: str=0001.0A006378.67FE60CA.0079,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01FA216352A;
	Tue, 15 Apr 2025 15:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744724167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlumGq7vM1zdawKPQ73srx7Hl+6/OZGTFw8mUGlSyF4=;
	b=dfyCBWDGZHU3CnXVHIWtfbqqptMkOcHrAP4hRtPFve4aNIB65zWyJXZoPTtSIwPltsfF9B
	k8ny/K4t4jGaCVbVrVKh5NZBurAF+emH4wlwyKId8gly3C7sGPDBX7QjRJ9R6xBQXrZAQs
	/TJ+QpxUQMCz4vtnRcecHXTrUUhIF1hMxY/m2PjK22CK2MBSsNKzqJXbfwXcxVa0jDsRUg
	jTayiwh69jQGpMa8xAsK2yBins+6R0kixIglhxym1p6OYHarvIf75Ju1qvRef+oOxCDxpe
	klgtzcf9urXZaSPecMtKydMmyHNXI2xsfu5f0PEK3Bg6supf3wmpU2hm8+uwLw==
Message-ID: <659d6affd7c58474c4bca5c92fc762925591d0d9.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 4/4] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Date: Tue, 15 Apr 2025 15:36:01 +0200
In-Reply-To: <9d73f6ac-9fee-446b-b011-e664a7311eca@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <9d73f6ac-9fee-446b-b011-e664a7311eca@lunn.ch>
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

On Tue, 2025-04-15 at 15:20 +0200, Andrew Lunn wrote:
>=20
> > +  **UNCOMMENTED_RGMII_MODE**
> > +    Historially, the RGMII PHY modes specified in Device Trees have be=
en
> > +    used inconsistently, often referring to the usage of delays on the=
 PHY
> > +    side rather than describing the board.
> > +
> > +    PHY modes "rgmii", "rgmii-rxid" and "rgmii-txid" modes require the=
 clock
> > +    signal to be delayed on the PCB; this unusual configuration should=
 be
> > +    described in a comment. If they are not (meaning that the delay is=
 realized
> > +    internally in the MAC or PHY), "rgmii-id" is the correct PHY mode.
>=20
> It is unclear to me how much ctx_has_comment() will return. Maybe
> include an example here of how it should look. I'm assuming:
>=20
> /* RGMII delays added via PCB traces */
> &enet2 {
>     phy-mode =3D "rgmii";
>     status =3D "okay";
>=20
> fails, but
>=20
> &enet2 {
>     /* RGMII delays added via PCB traces */
>     phy-mode =3D "rgmii";
>     status =3D "okay";
>=20
> passes?

Yes, it works like that. I can't claim to fully understand the checkpatch c=
ode
handling comments, but I copied it from other similar checks and tested it =
on a
few test patches.

One thing to note is that I implemented it as a CHK() and not a WARN() beca=
use
that's what is used for other comment checks like DATA_RACE - meaning it wi=
ll
only trigger with --strict.


>=20
> > =20
> >  Commit message
> >  --------------
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 784912f570e9d..57fcbd4b63ede 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3735,6 +3735,17 @@ sub process {
> >  			}
> >  		}
> > =20
> > +# Check for RGMII phy-mode with delay on PCB
> > +		if ($realfile =3D~ /\.dtsi?$/ && $line =3D~ /^\+\s*(phy-mode|phy-con=
nection-type)\s*=3D\s*"/ &&
>=20
> I don't grok perl. Is this only looking a dtsi files? .dts files
> should also be checked.

It is a regular expression - the ? makes the previous character optional,
matching both .dts and .dtsi files.

Best,
Matthias


>=20
> Thanks for working on this, it will be very useful.
>=20
> 	Andrew

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

