Return-Path: <netdev+bounces-200554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06EAE6179
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6517E189ACB7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3028B7EC;
	Tue, 24 Jun 2025 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pqpWzMVg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="UW9BFEoj"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEFB28153C;
	Tue, 24 Jun 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758722; cv=none; b=bJ4+q89o8w0e2b+1jY88IJNjj1U/YOdc7nGx6QpZ6NzqBPRH7COpdkZD6hAl6b73Tt0/zkNzzoAvXF9nZY352+Y2+VDuJYw+bXnBzBz6kHsIO87+V6f3lMlpB0yuyixjzYHy96uXcTORMZbjbGwOQbzOMEKsyaRHGYE7UyMj5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758722; c=relaxed/simple;
	bh=DyTqvvC5w0LlJ53hj5jWsIBFTgWw9yuBsl7G33hvSfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VA/ThpJuPq+VRsbQkLC8ZE2WbchDDhfynDNUgO1a3SshRqEl5254S+XZZCV2AmD20mfxoVP7tJao1ksZfuLKXQrQJfWuytxBYn7McLPbKPnfcPfXxID+FbskeAuxwvVbvihHAXEDDDqMU/H2zBJBVu2ghVXCcsNoM/+hmSi7Wwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pqpWzMVg; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=UW9BFEoj reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1750758718; x=1782294718;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LMGvq5izqaCufxhRiVPujUUpUHBSgsiKUBqKnX7JNlQ=;
  b=pqpWzMVgr1KalmMaGBldwDi3deJLgANoMJ+w+NIxC18Ua3/n2io51Ku+
   f7moq1sPjEwQLXTxkMToc9DoE7fgxMIvkjQhCDWJNMICJfwXEPJOaOULP
   sSvEWApEa73my2dlJbytQOjFygHEJO031BvA5pctbX477vPLHvpOlWdUJ
   /S4kwal5SHX+ON0P07nhM4OkwFn9FGyH2ChEu6nvfHr3rMqxrPYRQ0Co+
   zRoF6mvHf+UPGI+2pkryR4SvQm0LPndZoPjos4QRJOGUalGodVpDWrWas
   gvRy1wxSiLpGX9WPApkuJzaga7oYaawXLbe18TLfmgSLZj2mr6g9zxiMy
   A==;
X-CSE-ConnectionGUID: KICRVeP3QlulX/kotH1+Xg==
X-CSE-MsgGUID: ezbuiKoOR1GHGp04JT8P3w==
X-IronPort-AV: E=Sophos;i="6.16,261,1744063200"; 
   d="scan'208";a="44815220"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jun 2025 11:50:44 +0200
X-CheckPoint: {685A74F4-1B-497D558D-EBA6F5A1}
X-MAIL-CPID: AC4B4CD97CD6F92F69E614E9AA2668BB_3
X-Control-Analysis: str=0001.0A006371.685A750A.0024,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01D4F160CB8;
	Tue, 24 Jun 2025 11:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1750758640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMGvq5izqaCufxhRiVPujUUpUHBSgsiKUBqKnX7JNlQ=;
	b=UW9BFEojEvhcAZFnETze/5ThQTbY1gX9IZ4v9Ih5NDKtzX864wBUtU+4nJceSZ2NEgOh66
	XTfqzpvZDNav3qidBA6Xpfb36ZDO49P5Oc5bYAn84Y+AJXD4rGLsf5ATUVIthkx5zz65WY
	KUqZVolQDhb5ve8iTSSkPTjX2VBklFgwm3Q6/djjDiJZAoVuW5Uyxna+qKebtMq2PqOD/f
	nF0ZgV9FvjQ0IIhJyPlVJGMcWIIAoQhRj7mQqYY8h1ovgJFoA9Ltsk95yNK0O4uJhY2zUP
	YBRvVWkDIVQ3+VJJPz0nPVP3r0uvANNQEdpiW4dX+9+WP90hKtCzHyic7VEeug==
Message-ID: <ba1fba45aef0264d1215c3abac1d74e3ad2c33f2.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 4/4] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy
 Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>,  Vignesh
 Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Date: Tue, 24 Jun 2025 11:50:35 +0200
In-Reply-To: <a0904f35-8f26-4278-9090-9bbeef905ef7@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <20250415131548.0ae3b66f@fedora.home>
	 <a0904f35-8f26-4278-9090-9bbeef905ef7@lunn.ch>
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

On Tue, 2025-04-15 at 15:12 +0200, Andrew Lunn wrote:
>=20
> > My Perl-fu isn't good enough for me to review this properly... I think
> > though that Andrew mentioned something along the lines of 'Comment
> > should include PCB somewhere', but I don't know if this is easily
> > doable with checkpatch though.
>=20
> Maybe make it into a patchset, and change a few DTS files to match the
> condition. e.g.
>=20
> arm/boot/dts/nxp/ls/ls1021a-tsn.dts:/* RGMII delays added via PCB traces =
*/
> arm/boot/dts/nxp/ls/ls1021a-tsn.dts-&enet2 {
> arm/boot/dts/nxp/ls/ls1021a-tsn.dts-    phy-mode =3D "rgmii";
> arm/boot/dts/nxp/ls/ls1021a-tsn.dts-    status =3D "okay";
>=20
> This example is not great, but...
> arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi-                         p=
hy-mode =3D "rgmii";
> arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi:                         /=
* 2ns RX delay is implemented on PCB */
> arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi-                         t=
x-internal-delay-ps =3D <2000>;
> arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi-                         r=
x-internal-delay-ps =3D <0>;
>=20
> There is one more i know of somewhere which i cannot find at the
> moment which uses rgmii-rxid or rgmii-txid, an has a comment about
> delay.
>=20
> 	Andrew

FWIW, I've decided against including the comment changes in this series for=
 now
(going to send a v2 in a moment), as non-functional changes just to improve
style or make checkpatch happy are often frowned upon as unnecessary churn.

Best,
Matthias



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

