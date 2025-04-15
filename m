Return-Path: <netdev+bounces-182819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA673A89FA1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C73D3AF863
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2294C14B08C;
	Tue, 15 Apr 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QjK4O07T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="e7+PfyrZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EF33991;
	Tue, 15 Apr 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724291; cv=none; b=fMWpp+aGkGqYRKdkqQlQX/NNTo1j0y9DYfwkDH44dusD4Q2JPELhAsFxA00kWnWvM+JbFE+RAMIRQ8L3KI4M7FmfgmNmNK4db/5MMLtoHF5B3byUq0e+wdlb7n2P/y38YOYRKbtlzWyW4tULJjRyeMuXh3d+QSCEx4TZbSFdOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724291; c=relaxed/simple;
	bh=VJ3gEoMrY9GSmpMAxaxPj/YimtW7F3AAHn+QjvcDw2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KrxhMP6AjBc6hTycw2WcqoOajbC4PAswwOUaTY6xqoaY16Fv0taG5XI6+6eK8xcV5Z3IGRs215M4hePgtg1Vwugcfc/1XWfcdW/gE+yD37SyBMsO3TWsLgbS4sK8JaUFfi6VeeQ6zFPRW6jcHZUySCCGvW9GeVkAi27IG0wWGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QjK4O07T; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=e7+PfyrZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744724289; x=1776260289;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dd/5Px/F9IuikFlpnjP8bxiqM2ZSWPgSpxK2sGkLbZ8=;
  b=QjK4O07Tytno+dSz8Uiti/mMHKSbVXWBH32ZewsCmtGGno+aAXV3bg6e
   GL72xJFaTQhc0PZq0yllNpPsANq7j3CxO+PjeMmOwDNYup2WWtAV/NYub
   Cf5ejF5Curr2TgOk67kbvHQ5D4DDXKS1R+WRO/n/AheyeeMJaXrYqvpyN
   ypetDsGA1Nadg8u0Vvu5LpSdIyj9DVpKlK28ydPAEBZ7njawTNLAPpdP6
   PqbQiatQjvfMX4wWPInFzp/XUWmziKRXTPzddIFe/gBycOkwQV1BLd93S
   tqxBKNoQqlSKD2zvFjuZ+cuP+6nzPgTmRN2NP5eJMy9lhLcf1cXIhgxoS
   g==;
X-CSE-ConnectionGUID: 7CG+LNsBTBavByIdzUta9A==
X-CSE-MsgGUID: tHp09WNSSFWLPaU8u9Z0jQ==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43544216"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 15:38:06 +0200
X-CheckPoint: {67FE613D-31-2417938-F0170C2B}
X-MAIL-CPID: CB4D6A87F8E3381F1E4D34D623E7452D_2
X-Control-Analysis: str=0001.0A006370.67FE614B.000C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1AB21661B1;
	Tue, 15 Apr 2025 15:37:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744724281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dd/5Px/F9IuikFlpnjP8bxiqM2ZSWPgSpxK2sGkLbZ8=;
	b=e7+PfyrZ/AJ3fizvjDeYO41owEVjehzE44DjCMmbjQuHWldP5IfQhoBf/9Jw8Ks+ex1Ykw
	eW5KSMjdZTKSzEP2UzETo8inbTMFu4clfBW2Uwt7Mt9IDD9rmsDHIUtz+iG0r1EuOr9HrS
	Wj9DNc/wwwF+FRzfnpYD5wxVBwIwbxUR3advPXTXqHNRjjkeYXAFdJHzOjY57YOkl6sBYL
	upyvE7oROOy6MbhSQAdXhV5zNKMbOYbehKl02OKTNvA8rXKO80W2o/q+FDZnEX21ycGtXw
	l+wJA99dax0jjBVW5LBZgr4VQVkMMU7nKimucF6WtPmfbGkjMgYT6aOoYqNr8Q==
Message-ID: <9e0e6365a2c0151c819e442775ece37353468d91.camel@ew.tq-group.com>
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
Date: Tue, 15 Apr 2025 15:37:59 +0200
In-Reply-To: <659d6affd7c58474c4bca5c92fc762925591d0d9.camel@ew.tq-group.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <9d73f6ac-9fee-446b-b011-e664a7311eca@lunn.ch>
	 <659d6affd7c58474c4bca5c92fc762925591d0d9.camel@ew.tq-group.com>
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

On Tue, 2025-04-15 at 15:36 +0200, Matthias Schiffer wrote:
> On Tue, 2025-04-15 at 15:20 +0200, Andrew Lunn wrote:
> >=20
> > > +  **UNCOMMENTED_RGMII_MODE**
> > > +    Historially, the RGMII PHY modes specified in Device Trees have =
been
> > > +    used inconsistently, often referring to the usage of delays on t=
he PHY
> > > +    side rather than describing the board.
> > > +
> > > +    PHY modes "rgmii", "rgmii-rxid" and "rgmii-txid" modes require t=
he clock
> > > +    signal to be delayed on the PCB; this unusual configuration shou=
ld be
> > > +    described in a comment. If they are not (meaning that the delay =
is realized
> > > +    internally in the MAC or PHY), "rgmii-id" is the correct PHY mod=
e.
> >=20
> > It is unclear to me how much ctx_has_comment() will return. Maybe
> > include an example here of how it should look. I'm assuming:
> >=20
> > /* RGMII delays added via PCB traces */
> > &enet2 {
> >     phy-mode =3D "rgmii";
> >     status =3D "okay";
> >=20
> > fails, but
> >=20
> > &enet2 {
> >     /* RGMII delays added via PCB traces */
> >     phy-mode =3D "rgmii";
> >     status =3D "okay";
> >=20
> > passes?
>=20
> Yes, it works like that. I can't claim to fully understand the checkpatch=
 code
> handling comments, but I copied it from other similar checks and tested i=
t on a
> few test patches.
>=20
> One thing to note is that I implemented it as a CHK() and not a WARN() be=
cause
> that's what is used for other comment checks like DATA_RACE - meaning it =
will
> only trigger with --strict.

Oops, DATA_RACE is actually a WARN(). I must have copied it from some other
comment check that uses CHK(). Let me know which you want me to use.

>=20
>=20
> >=20
> > > =20
> > >  Commit message
> > >  --------------
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 784912f570e9d..57fcbd4b63ede 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3735,6 +3735,17 @@ sub process {
> > >  			}
> > >  		}
> > > =20
> > > +# Check for RGMII phy-mode with delay on PCB
> > > +		if ($realfile =3D~ /\.dtsi?$/ && $line =3D~ /^\+\s*(phy-mode|phy-c=
onnection-type)\s*=3D\s*"/ &&
> >=20
> > I don't grok perl. Is this only looking a dtsi files? .dts files
> > should also be checked.
>=20
> It is a regular expression - the ? makes the previous character optional,
> matching both .dts and .dtsi files.
>=20
> Best,
> Matthias
>=20
>=20
> >=20
> > Thanks for working on this, it will be very useful.
> >=20
> > 	Andrew
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

