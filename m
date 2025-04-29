Return-Path: <netdev+bounces-186670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0DAA0465
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BDA17A33F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5D1C6FFD;
	Tue, 29 Apr 2025 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LkCo0zvG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="UMBk4PSS"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00FF1C8629;
	Tue, 29 Apr 2025 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911515; cv=none; b=RApZ3d3+cvjlBKIO/NIRzsxaH6qQGcbTlLZdtNXWtLyYxt9sK97eKrhOPB32eOAE2Hob8NkBoXngzazwHLHGPNgRh7HNKBzfBr39ik5le+ofZaCOoJdJAaIrjss9sfusqAefIfDw7teRpsQXUx7yAo4ipU1nJxd2ILHL0eRkhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911515; c=relaxed/simple;
	bh=BTTld/avRyX9/xFUVdq/cjPb7ZmIdI1aSwabNE90ZT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FNRI0aiyPPKueXT3uDl1X6PumCn1nR60yv1mbSLg7/uxAnxnnz277MqjAz4QH2NFfAp4JRy/y3xPAYcyfgtOI2lxjKGBcAVb3P5rx2MTiEfY2k8SiAdAiY4REZi5+He4xdZ/ZSMRAbXS/GT99yifNq4NsfBjPP+xo9gy6KoMXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LkCo0zvG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=UMBk4PSS reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1745911511; x=1777447511;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0HTPHirUqJp7iM6IFbqXNuusghxBtTxmX3QXCCMPY0Q=;
  b=LkCo0zvG/pzwFIaSerwZ2FJLguAyhlcG5WuaIWH3llgNYsxVc67mcLXs
   yiyjuaWuRbyW3J8KAzF+D0ohli0eGrggnQJN9rujf13+/dbBepAfWJ8Y9
   MoK7vO1lONECwNkOjN9J6yF54nVFcXvZ7YbDAzA0MM+SMvQruUuuYLDjL
   qdEXUgTRfJLCeI+7/HviFVY+rldo0EBzYMDVaIzRpXd/t2H5Varw0Wzpj
   9bWIVjPE4CVnuGlDkfdNOnjCBb5fzwb9a8bjiPwq1UkWARvdUqNoo9HGk
   ldfOuTobUsBJQKgOSQYG+VycB+p2S3ZpXfYg3P7ymA06+MPTtEt4Djww7
   w==;
X-CSE-ConnectionGUID: mvncbzE7TwS02I9aCObShg==
X-CSE-MsgGUID: Oo+CuzYXSh2hT+Oi+La46Q==
X-IronPort-AV: E=Sophos;i="6.15,248,1739833200"; 
   d="scan'208";a="43772696"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 Apr 2025 09:25:01 +0200
X-CheckPoint: {68107ECD-32-F35B2447-E1635CDE}
X-MAIL-CPID: 4C6EC668F1D0F19820FBD4C1ED5AF527_1
X-Control-Analysis: str=0001.0A006376.68107EDB.007D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4E1E160F78;
	Tue, 29 Apr 2025 09:24:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1745911497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HTPHirUqJp7iM6IFbqXNuusghxBtTxmX3QXCCMPY0Q=;
	b=UMBk4PSSN3UPAEvH64wlD/DQG63n6qyz8Vno1RD6lID08HbYoSOsULofaTdR5GBIBR3dMC
	mFpdWkhtUDfnpSseGPOmYzTQTNSYRZ3DnFJZUo7mFx6/bijMtSUSx/fq3o1dVVYvhFNwBY
	VReTlz6llr68OZdahRTkt+Ae95QczLZHbR+tHmrSa3Ov+pgA5/xelkQS9xi2IR7JUhnW+z
	aBv77qSBW2cGa4CjsTUon7WSlGvklEDnBkpkK3Evpc+ilIBWeOkJZv2CEfoCLy1VBORQSo
	1uolbaIQbqdBZjmupkWsKjxAgm+OzCBGDvoZ6yDjacJyW4yCSNwmIFAxVhla2A==
Message-ID: <b75c6a2cf10e2acf878c38f8ca2ff46708a2c0a1.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Tero Kristo
 <kristo@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com
Date: Tue, 29 Apr 2025 09:24:49 +0200
In-Reply-To: <9b9fc5d0-e973-4f4f-8dd5-d3896bf29093@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
	 <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
	 <aAe2NFFrcXDice2Z@shell.armlinux.org.uk>
	 <fdc02e46e4906ba92b562f8d2516901adc85659b.camel@ew.tq-group.com>
	 <9b9fc5d0-e973-4f4f-8dd5-d3896bf29093@lunn.ch>
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

On Mon, 2025-04-28 at 16:08 +0200, Andrew Lunn wrote:
>=20
> > > However, with the yaml stuff, if that is basically becoming "DT
> > > specification" then it needs to be clearly defined what each value
> > > actually means for the system, and not this vague airy-fairy thing
> > > we have now.
>=20
> =20
> > I agree with Russell that it seems preferable to make it unambiguous wh=
ether
> > delays are added on the MAC or PHY side, in particular for fine-tuning.=
 If
> > anything is left to the implementation, we should make the range of acc=
eptable
> > driver behavior very clear in the documentation.
>=20
> I think we should try the "Informative" route first, see what the DT
> Maintainers think when we describe in detail how Linux interprets
> these values.

Oh, we should not be Linux-specific. We should describe in detail how *any =
OS*
must interpret values.


>=20
> I don't think a whole new set of properties will solve anything. I
> would say the core of the problem is that there are multiple ways of
> getting a working system, many of which don't fit the DT binding. But
> DT developers don't care about that, they are just happy when it
> works. Adding a different set of properties won't change that.
>=20
> 	Andrew

Hmm, considering that

- interpretation of existing properties is inconsistent
- we could like something with a consistent interpretation
- we can't change how existing drivers interpret the properties, as that wo=
uld
be a breaking change,

I don't think we really have any options but to introduce something new, or=
 keep
the inconsistent status quo.

Best,
Matthias



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

