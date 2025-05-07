Return-Path: <netdev+bounces-188592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B803AADBE0
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C99171328
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE41DFE12;
	Wed,  7 May 2025 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="byrTMmjq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hrgzO0Cz"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79576410;
	Wed,  7 May 2025 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611502; cv=none; b=Zno64al5qw/GyHXyev6AWeOrdxhEcDGjHg9Un5MDlwQs0DfZjEfA9euSVo7nN2hoQ1rRevgOCcFDy/Tw9sCcoPCZYNtgm0Gci9V/z8VT3MwCFMmDFJjKgFzNjpVih4wXsnt5Ox9vV5Bllt94CHy0yeXjtkwURfWWVYT5sbZIIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611502; c=relaxed/simple;
	bh=lkDEAQnNpFikfSxH7maKRI098GHsz70sWCLPsBCkgdw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXlv/nCrooY/83gL5sczdHORWcCM4zCPQ/PwlR02Jcdee2at4eMDy+P4/USdUsgc4ID9dAFuwSrsSjqJplWgbEZkFBssU8BzDSfPP+6iBaLTeA1RK8yNqSX3d0lolFe/r5m5c0020QBd6EZyDm/Xe3jcwq+OVOU0lKo64r0jYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=byrTMmjq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hrgzO0Cz reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1746611499; x=1778147499;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=F/i9Jm7x0sU9sxHf9FawPOb71EGh2v9Y58NkBsYaux4=;
  b=byrTMmjqhGmhma5cs7iqeHPgRH/lbB6wJicVkPeZfZOFaF9enUB8mNQi
   GQRKsF/XmaBWg+ChFN5hcaXtBqbUiSIMJ8qSdNRYcXMlxcbUNrRG1pfe5
   uncR5d7xtlK1AoHb9q3Ed9nl/lgQzeln68W4+ARWq4F6jRU2Kvj6ODVyJ
   xcl8ndoEZWNxVuB9coO2+zgWGOON6okuWvV8g92VX3lijmW69hfaexF+b
   8K9RmGwGZlbgEfxqLdErT3ylceUnKlU9ZMabGwtCBu0iuLR00RC80APlW
   iMG6I1nc+/PaDjox9yEG47EWXVwH7mCtSkNgElQKrQ9YfeLbMTsyz1dmF
   g==;
X-CSE-ConnectionGUID: xQanc9akTUOCfAyriMNxVA==
X-CSE-MsgGUID: qB0IcNYRTKigede2IsGhTQ==
X-IronPort-AV: E=Sophos;i="6.15,269,1739833200"; 
   d="scan'208";a="43931540"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 May 2025 11:51:34 +0200
X-CheckPoint: {681B2D26-1B-45F3AE15-E90F7DFA}
X-MAIL-CPID: 2C825C19DDFDF09B778A43311167F0AF_5
X-Control-Analysis: str=0001.0A006396.681B2D27.00A1,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36290161474;
	Wed,  7 May 2025 11:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1746611490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/i9Jm7x0sU9sxHf9FawPOb71EGh2v9Y58NkBsYaux4=;
	b=hrgzO0Cz+7eH2reXwH2XD31ZpLjhmSq/x9ISo7PGeW52JetAaTh9qN7ZM1+YF/TqCxD87z
	QqwZegexR1DOExJowI7nqxEKLyR7ji9lI1AGa24Y+I54oYplOyrJroxr3b5/s+pKiWPt+c
	h4ZShjpGZYBY3KKmRJeluziCP+T6CkBDFMFNeXJsAmxY74iihCd1xidC18hFX02On9amw7
	FDd1vpvLpX5pB1ZA17G/2h/fUKxepZLUl26ZFsHryzqyAkinRovOqBxZgj/GdQn1lSW55E
	X+SHnmoQW7CilT7u+//OOu+/42Q6ugouqbaLD4U2sr/MmTl3XZVFEfJd+TGLfA==
Message-ID: <6e4d3127af2e2ace3fcec73eb8903c12ebcdda38.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: ti: k3-am654-cpsw-nuss:
 update phy-mode in example
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, "mike .."
 <wingman205@gmx.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Jonathan
 Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, Tero Kristo
 <kristo@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com
Date: Wed, 07 May 2025 11:51:25 +0200
In-Reply-To: <06268dcb-4a49-468e-8ebd-d9366a2cf0c2@kernel.org>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <4216050f7b33ce4e5ce54f32023ec6ce093bd83c.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <06268dcb-4a49-468e-8ebd-d9366a2cf0c2@kernel.org>
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

On Wed, 2025-04-30 at 17:22 +0300, Roger Quadros wrote:
>=20
> Hi Matthias,
>=20
> On 15/04/2025 13:18, Matthias Schiffer wrote:
> > k3-am65-cpsw-nuss controllers have a fixed internal TX delay, so RXID
> > mode is not actually possible and will result in a warning from the
> > driver going forward.
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml          | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nus=
s.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> > index b11894fbaec47..c8128b8ca74fb 100644
> > --- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> > +++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> > @@ -282,7 +282,7 @@ examples:
> >                      ti,syscon-efuse =3D <&mcu_conf 0x200>;
> >                      phys =3D <&phy_gmii_sel 1>;
> > =20
> > -                    phy-mode =3D "rgmii-rxid";
> > +                    phy-mode =3D "rgmii-id";
> >                      phy-handle =3D <&phy0>;
> >                  };
> >              };
>=20
> FYI the following TI boards using this driver are using "rgmii-rxid".
> Will you be sending fixes to the device trees files?


Hi Roger,

as written in the cover letter, I haven't fixed any DTS for now, so project=
s
consuming Linux's Device Tree sources (like U-Boot) have some time to updat=
e
their driver first (as fixing the Device Trees without updating the driver =
would
break Ethernet).

Once a fix has been accepted in U-Boot (and preferably after we've come to =
an
agreement on the open questions...) I can also send a patch to update these
files.

Best,
Matthias



>=20
> arch/arm64/boot/dts/ti
> k3-am625-beagleplay.dts:	phy-mode =3D "rgmii-rxid";
> k3-am625-sk.dts:	phy-mode =3D "rgmii-rxid";
> k3-am625-sk.dts.orig:	phy-mode =3D "rgmii-rxid";
> k3-am62a7-sk.dts:	phy-mode =3D "rgmii-rxid";
> k3-am62a-phycore-som.dtsi:	phy-mode =3D "rgmii-rxid";
> k3-am62p5-sk.dts:	phy-mode =3D "rgmii-rxid";
> k3-am62p5-sk.dts:	phy-mode =3D "rgmii-rxid";
> k3-am62-phycore-som.dtsi:	phy-mode =3D "rgmii-rxid";
> k3-am62-verdin-dev.dtsi:	phy-mode =3D "rgmii-rxid";
> k3-am62-verdin.dtsi:	phy-mode =3D "rgmii-rxid";
> k3-am62-verdin-ivy.dtsi:	phy-mode =3D "rgmii-rxid";
> k3-am62x-phyboard-lyra.dtsi:	phy-mode =3D "rgmii-rxid";
> k3-am62x-sk-common.dtsi:	phy-mode =3D "rgmii-rxid";
> k3-am642-evm.dts:	phy-mode =3D "rgmii-rxid";
> k3-am642-evm.dts:	phy-mode =3D "rgmii-rxid";
> k3-am642-sk.dts:	phy-mode =3D "rgmii-rxid";
> k3-am642-sk.dts:	phy-mode =3D "rgmii-rxid";
> k3-am642-tqma64xxl-mbax4xxl.dts:	phy-mode =3D "rgmii-rxid";
> k3-am642-tqma64xxl-mbax4xxl.dts:	/* phy-mode is fixed up to rgmii-rxid by=
 prueth driver to account for
> k3-am64-phycore-som.dtsi:	phy-mode =3D "rgmii-rxid";
> k3-am654-base-board.dts:	phy-mode =3D "rgmii-rxid";
> k3-am67a-beagley-ai.dts:	phy-mode =3D "rgmii-rxid";
> k3-am68-sk-base-board.dts:	phy-mode =3D "rgmii-rxid";
> k3-am69-sk.dts:	phy-mode =3D "rgmii-rxid";
> k3-j7200-common-proc-board.dts:	phy-mode =3D "rgmii-rxid";
> k3-j721e-beagleboneai64.dts:	phy-mode =3D "rgmii-rxid";
> k3-j721e-common-proc-board.dts:	phy-mode =3D "rgmii-rxid";
> k3-j721e-evm-gesi-exp-board.dtso:	phy-mode =3D "rgmii-rxid";
> k3-j721e-evm-gesi-exp-board.dtso:	phy-mode =3D "rgmii-rxid";
> k3-j721e-evm-gesi-exp-board.dtso:	phy-mode =3D "rgmii-rxid";
> k3-j721e-evm-gesi-exp-board.dtso:	phy-mode =3D "rgmii-rxid";
> k3-j721e-sk.dts:	phy-mode =3D "rgmii-rxid";
> k3-j721s2-common-proc-board.dts:	phy-mode =3D "rgmii-rxid";
> k3-j721s2-evm-gesi-exp-board.dtso:	phy-mode =3D "rgmii-rxid";
> k3-j722s-evm.dts:	phy-mode =3D "rgmii-rxid";
> k3-j784s4-j742s2-evm-common.dtsi:	phy-mode =3D "rgmii-rxid";
> k3-j784s4-j742s2-evm-common.dtsi:	phy-mode =3D "rgmii-rxid";
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

