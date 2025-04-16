Return-Path: <netdev+bounces-183147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4D9A8B296
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106A817E62F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 07:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9C22C35E;
	Wed, 16 Apr 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jtdo3bTQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Utg1IVm2"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6C189B9D;
	Wed, 16 Apr 2025 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789707; cv=none; b=WuGDo26QrRglT3tTP7LVS4uyDSPnLBlV185bCd8rkfG+v9Xcqysj2FzKPsXYhuHxWIwAsR/xK5ZIEqUv1n1jvX5CaCuOl0a4IbfI4jI0j6OLf2HZrXby8FT7Ozc4m3nJmZKuKVZJo9kJw2m6j8zG/Hp3u6FBF0Rc1z9tbFCZ9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789707; c=relaxed/simple;
	bh=7ojNLd35IL8BUl4r4U4KZaN3qMYHai0mzwkmUTNzQcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SrIzFRHwL3ChRSt5c/71rICnirvNe802s5BdOHSJubWlX71Rvik7syA49v1kn1cxaNz8NjqDm1tmhl58Bnc4crbW/7uQ0dSpYJJuca1go2T8401ROsNLQvCHkzvjXmGxYA1VURbT5idOpf3WP/cMcCd07vfMK2XcjhVzhR/u7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jtdo3bTQ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Utg1IVm2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744789704; x=1776325704;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7aW7Z4UKbxktPS4MaepHxqf+DbrSQTTsdz9FCAgfvEQ=;
  b=jtdo3bTQBowiOkDN60u8K9OjEHn7led25Oh1sxGRZS57JL58crpURSkv
   RJIQprEe0fvuUFCZoxr63o1G921tEUxqU1YhUoimilwNjwQ+7hSPjYt8N
   bUgTBnQqfVUmIDRmfZCpqw69ciDMfcw+wCUvssLQdgGRXlEtytcVFatql
   SHvbJ62NQzkPtY1uO0QBMqqQ2r8dDbU5SnOtp67+TknpddKTwU5XducXw
   ENFqfySUBPQiZbFdOLudaUZbV0p01mdyHzdjFLMvXaFqc5X5ncvr0loFj
   AxG/l7mgRCabwyggDiu5X4IITYJEIPCQcMioXPEN56x5bK64bkcijf3ev
   Q==;
X-CSE-ConnectionGUID: 40LsbEOEQRiOB0DgIF7Vtw==
X-CSE-MsgGUID: zhfq6v8tSkSbamkypAuoSA==
X-IronPort-AV: E=Sophos;i="6.15,215,1739833200"; 
   d="scan'208";a="43559241"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Apr 2025 09:48:19 +0200
X-CheckPoint: {67FF60C3-51-2417938-F0170C2B}
X-MAIL-CPID: C1F86517FBCAB0ED58083B4ED47BF749_2
X-Control-Analysis: str=0001.0A006396.67FF60C0.0053,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEFE7167BA8;
	Wed, 16 Apr 2025 09:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744789695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aW7Z4UKbxktPS4MaepHxqf+DbrSQTTsdz9FCAgfvEQ=;
	b=Utg1IVm2aLPjKEu3z8TbqZySUXUoHt++UW7xuELrTvjAmmm9tIhos26SKan/GalSkemTOL
	Fk9h5nsoD/wH6jMTzwCBPmqzpNExikWK2RnVW9kY6WXcvvZALAu7F+ptEo5JCMJsdiFGUO
	++Lfssy63Fl7cWgW8vnwmvJZzKjwYdcW9WwigXvLWmVeB+sdZXSdwZgMD4cpBN6L59xJEX
	ZbJ0ISdTOXsQwmCd4jKnVU1LdVA0qHUePTEHqY2UtJo352NuL7OrOGsnoCKmTtRw2rd7aT
	S3Jc6lbVm4iQjHSQYdOhg0RhSmEw/DwIsqKXtp2ePRx1Ez47eixZgLikWDKj8Q==
Message-ID: <800a61d80a2c6cfa4a5a64d904a2127e60eafc29.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 4/4] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Joe Perches <joe@perches.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,  Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, Andrew Lunn
 <andrew@lunn.ch>
Date: Wed, 16 Apr 2025 09:48:12 +0200
In-Reply-To: <f3acd53796a44576408a2a14aa5baaed@perches.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <f3acd53796a44576408a2a14aa5baaed@perches.com>
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

On Tue, 2025-04-15 at 09:11 -0700, Joe Perches wrote:
>=20
> On 2025-04-15 03:18, Matthias Schiffer wrote:
> > Historially, the RGMII PHY modes specified in Device Trees have been
> > used inconsistently, often referring to the usage of delays on the PHY
> > side rather than describing the board; many drivers still implement=20
> > this
> > incorrectly.
> >=20
> > Require a comment in Devices Trees using these modes (usually=20
> > mentioning
> > that the delay is relalized
>=20
> realized
>=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 784912f570e9d..57fcbd4b63ede 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3735,6 +3735,17 @@ sub process {
> >  			}
> >  		}
> >=20
> > +# Check for RGMII phy-mode with delay on PCB
> > +		if ($realfile =3D~ /\.dtsi?$/ && $line =3D~=20
> > /^\+\s*(phy-mode|phy-connection-type)\s*=3D\s*"/ &&
> > +		    !ctx_has_comment($first_line, $linenr)) {
>=20
> Not sure where $first_line comes from and unsure if this works on=20
> patches rather than complete files.
>=20
> Does it?

Yes, it works both with patches and full files. I'm using ctx_has_comment()=
 the
same way existing checks do - I think $first_line refers to the start of th=
e
current context for patch files. I have also verified that it only matches =
on
comments directly above the phy-mode line in question.

Best,
Matthias



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

