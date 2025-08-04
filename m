Return-Path: <netdev+bounces-211577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7AEB1A3BC
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E633B5A83
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B0D1E0B9C;
	Mon,  4 Aug 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lSXCp9gD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bkTiebyO"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859D19D092;
	Mon,  4 Aug 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315126; cv=none; b=ZvzvBMOczuKH1f+CYr2jAHvul6Alk9VeBYaULe8h8Tj5D8KcCvOBn3DObkYLjtJ8DhlViJvROYUtqS1XPHn8IkWIgkD9FneMuMsvRSj2ybObx/jkkXbmdDz86gxiA2JNFl2oQNiaSwoYI7FIKbzOom3M6PUCW8j5SNB+hVSeciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315126; c=relaxed/simple;
	bh=bO5Yv/qZWjLfBOl0OSPePlLX0AHdt7A6y8zKAJiRWq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=phRRRwU3+bP7k/vRbAKUPN/lwGUh6xwgyHY8sX47JiBjMwXCxxpZ6RNXktEQm3xfvRupXEjwvtXmtStOrUx2aruSYga1LticaTf9/n2b/O4y1Fz+vKNkIKMsTURII7UGPoJlUU1RKxzH5tR0TSjd3SXNdDVfKUo43qcR6phvAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lSXCp9gD; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=bkTiebyO reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1754315122; x=1785851122;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bO5Yv/qZWjLfBOl0OSPePlLX0AHdt7A6y8zKAJiRWq0=;
  b=lSXCp9gDuUXkGd2UkB+bOmJ7nvkffu5yzT5Ymvmp9vrtNW7d/VukTkKM
   Qqn5/44anZZWHTi+JPB0e9AavWfaepNc2ZRFKqGcKgcipWIBM8kTnPS8M
   Fb5I75tFwiwBTwFjMPTjCFH/ct+GbFOnUqQw2n48OXRuPdF00KSH1h0c4
   UJhFGDhA3pR36O/B3mcpKQ3XfcCIBgezq6zDSZ7F9KUfjwVXm6KEL7Bp+
   j/RerTVqYYo6TZSBTX0zr4dUUGI8AeZBPVZ8fVfmXAfh3RcfgY2Y8nO4z
   7cku1bc1y8yWovXMRdrbQSO53k3HhrjvK4XqbMpp4S1DUG8yPywDkbW1K
   g==;
X-CSE-ConnectionGUID: pOArFh0sRvmwPiTm7/VRZQ==
X-CSE-MsgGUID: IHIkEyhJSVG4PvEscKdsAw==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="45572437"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Aug 2025 15:45:16 +0200
X-CheckPoint: {6890B96B-22-9E907662-F3B2C93D}
X-MAIL-CPID: CF9F40FC763AD2705FDCAC7BFD3B162E_4
X-Control-Analysis: str=0001.0A002128.6890B912.0018,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B946160E0F;
	Mon,  4 Aug 2025 15:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1754315111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bO5Yv/qZWjLfBOl0OSPePlLX0AHdt7A6y8zKAJiRWq0=;
	b=bkTiebyO8Qc2feJx3D/UvaHR7ieYLXiDm3OUSTj+M5fzw8hhKfJ4/JP8ekBFfZtAjU7LB/
	fwr4FT6DVMxwnNAyQE+nrW3m049ba1PqIbv5XeMq4bRgMa7JvVw7mBxLnu4D6YLT3Wgyjm
	Hm+81ybxp05KW6OhAitsEo5z5kejw6Rrkbhi7uNOv127bBjFpyevroryRpoedx07JfConW
	QcSCw4tFPtz/1ByZ/FrLZJta0JE/KwQySnjRLMLsSYLO6/4sGpQZOykqbDG1EGCauj76Kq
	et8Ne99t01WXAc8cpJOyT/03o4ubQpGiXQdf/k5M+EVnEJvw1hUim8pd+IFgLw==
Message-ID: <804f394db1151f1fb1f19739d5347b38a3930e8a.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup
 PHY mode for fixed RGMII TX delay"
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Michael Walle <mwalle@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>,  Andrew Lunn <andrew@lunn.ch>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roger Quadros
 <rogerq@kernel.org>, Simon Horman <horms@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date: Mon, 04 Aug 2025 15:45:08 +0200
In-Reply-To: <DBTGZGPLGJBX.32VALG3IRURBQ@kernel.org>
References: <20250728064938.275304-1-mwalle@kernel.org>
	 <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
	 <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
	 <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
	 <DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
	 <2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com>
	 <88972e3aa99d7b9f4dd1967fbb445892829a9b47.camel@ew.tq-group.com>
	 <84588371-ddae-453e-8de9-2527c5e15740@lunn.ch>
	 <47b0406f-7980-422e-b63b-cc0f37d86b18@ti.com>
	 <DBTGZGPLGJBX.32VALG3IRURBQ@kernel.org>
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

On Mon, 2025-08-04 at 09:37 +0200, Michael Walle wrote:
> On Sat Aug 2, 2025 at 7:44 AM CEST, Siddharth Vadapalli wrote:
> > On Wed, Jul 30, 2025 at 04:27:52PM +0200, Andrew Lunn wrote:
> > > > I can confirm that the undocumented/reserved bit switches the MAC-s=
ide TX delay
> > > > on and off on the J722S/AM67A.
> > >=20
> > > Thanks.
> > >=20
> > > > I have not checked if there is anything wrong with the undelayed
> > > > mode that might explain why TI doesn't want to support it, but
> > > > traffic appears to flow through the interface without issue if I
> > > > disable the MAC-side and enable the PHY-side delay.
> > >=20
> > > I cannot say this is true for TI, but i've often had vendors say that
> > > they want the MAC to do the delay so you can use a PHY which does not
> > > implement delays. However, every single RGMII PHY driver in Linux
> > > supports all four RGMII modes. So it is a bit of a pointless argument=
.
> > >=20
> > > And MAC vendors want to make full use of the hardware they have, so
> > > naturally want to do the delay in the MAC because they can.
> > >=20
> > > TI is a bit unusual in this, in that they force the delay on. So that
> > > adds a little bit of weight towards maybe there being a design issue
> > > with it turned off.
> >=20
> > Based on internal discussions with the SoC and Documentation teams,
> > disabling TX delay in the MAC (CPSW) is not officially supported by
> > TI. The RGMII switching characteristics have been validated only with
> > the TX delay enabled - users are therefore expected not to disable it.
>=20
> Of all the myriad settings of the SoC, this was the one which was
> not validated? Anyway, TI should really get that communicated in a
> proper way because in the e2e forum you'll get the exact opposite
> answer, which is, it is a documentation issue. And also, the
> original document available to TI engineers apparently has that setting
> documented (judging by the screenshot in the e2e forum).
>=20
> > Disabling the TX delay may or may not result in an operational system.
> > This holds true for all SoCs with various CPSW instances that are
> > programmed by the am65-cpsw-nuss.c driver along with the phy-gmii-sel.c
> > driver.
>=20
> In that case u-boot shall be fixed, soon. And to workaround older
> u-boot versions, linux shall always enable that delay, like Andrew
> proposed.

I can submit my patch for U-Boot some time this week, probably tomorrow. Do=
 you
also want me to take care of the Linux side for enabling the MAC delay?

Best,
Matthias


>=20
> > In addition to the above, I would like to point out the source of
> > confusion. When the am65-cpsw-nuss.c driver was written(2020), the
> > documentation indicated that the internal delay could be disabled.
> > Later on, the documentation was updated to indicate that internal
> > delay cannot (should not) be disabled by marking the feature reserved.
>=20
> > This was done to be consistent with the hardware validation performed.
> > As a result, older documentation contains references to the possibility
> > of disabling the internal delay whereas newer documentation doesn't.
>=20
> See above, that seems to be still the case.
>=20
> -michael

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

