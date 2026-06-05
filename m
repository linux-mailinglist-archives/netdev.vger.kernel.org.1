Return-Path: <netdev+bounces-295830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /1xFOdbOImq3dwEAu9opvQ
	(envelope-from <netdev+bounces-295830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 15:27:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48488648883
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 15:27:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=Ce3Oz8lB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295830-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295830-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B86301E6F2
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A340E8DE;
	Fri,  5 Jun 2026 13:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ED140E8DB
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 13:19:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665596; cv=none; b=EmtnIF3kMKhclZL2IY/bTTT1HmgThiLE0RqhzkcZR7mK+VFS3d7zL68LfV1tIMC4YIf/eupIA/Xp3s8AZFdB0XqY5ZLz1apBxE4vVQFXgqS0hncATIH2mhM1ziu79FgLbxzQafPVBh+VilJFXhBayW2WHzdUo8Ib0rt/Zgoo+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665596; c=relaxed/simple;
	bh=HAvidAC4WQ/doc7No9d2+72neZr21cTDtPLM0VRYOtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOZd2M6boUf1at2ATdOKIqgtB/OLJkmyreOWS84oRUC2GJUyqtJQ5iB/TOMyQRMG0xwz81APYQZVoacpsmS7XLjSXDJq+fATF8ubRd5No9LrvWt6DhA1U5V9zb9Su0kgJTcmrp8vDaFxP75wtmowFBNqEUuyJhSI3Pu4fGu4t+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ce3Oz8lB; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1A1171A092B;
	Fri,  5 Jun 2026 13:19:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E146B5FED1;
	Fri,  5 Jun 2026 13:19:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62AD5106A242D;
	Fri,  5 Jun 2026 15:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780665591; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+UaqPyxwWDlLGVWRcFEYcWV67M07/EalJkqJ/wGvOBs=;
	b=Ce3Oz8lBxM8dw1hkTJK7HLO7peGw/wV9BWZPiE3XNcKzHk3uLUJXagSE5UC7Gd2Egxjwtc
	2n3gdOk3h2Ibh5gBPmIKfpB1BkXykwozLCPOM+JWhj9+jSVa1g5OYaHzWA6ePcRKuNsjiI
	7UiNPyMq3AuqU2kn9JnWVANDRJEJgd8xHoScoyH0gk786gN1M+dF096G9At7Rfqy0v95M5
	DM3qCufeZMuiR4o3CHx6XwTxgUs+/MKg3FO8YBtvdCGnHrKqLq8UCLz38IOYjpVQ+1p5N8
	fMYKga1nTnyHFfHr1/J2UvOsKkpcOGxammhZHQxpr9x3HGlRwCqs48aHPlmK6w==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?B?w4FsdmFybyBHLiBNLg==?= <alvaro.gamez@hazent.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alvaro@linenoise.info
Subject: Re: [PATCH net-next v2 0/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Fri, 05 Jun 2026 15:19:41 +0200
Message-ID: <gxWtuDmcQ2CKH5ukA1tJRg@bootlin.com>
In-Reply-To: <92f5169580c0292ae666e20d52b891b45e0731ea.camel@hazent.com>
References:
 <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
 <92f5169580c0292ae666e20d52b891b45e0731ea.camel@hazent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartQvBnk1WYSsKfua1xTL8glw";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295830-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:alvaro.gamez@hazent.com,m:maxime.chevallier@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alvaro@linenoise.info,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,hazent.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:from_mime,bootlin.com:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48488648883

--nextPartQvBnk1WYSsKfua1xTL8glw
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v2 0/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Fri, 05 Jun 2026 15:19:41 +0200
Message-ID: <gxWtuDmcQ2CKH5ukA1tJRg@bootlin.com>
In-Reply-To: <92f5169580c0292ae666e20d52b891b45e0731ea.camel@hazent.com>
MIME-Version: 1.0

Hi =C3=81lvaro,

On Friday, 13 February 2026 13:31:17 CEST =C3=81lvaro G. M. wrote:
> On Mon, 10 Nov 2025 10:24:52 +0100
>=20
> Romain Gantois <romain.gantois@bootlin.com> wrote:
> > Hi everyone,
> >=20
> > This is version two of my series which adds support for using the
> > DP83869 PHY as a transceiver between an RGMII upper MAC and a
> > downstream 1000Base-X SFP module.
>=20
> Hi Romain,
>=20
> I am quite interested in this too, as we have a new version of a PCB in
> which we replaced a dp83848 (which only works with 100base-tx) with
> dp83869 with the intent of using 1000base-sx or similar SFPs.
>=20
> The are two different SFPs that I was able to use with dp83848 and
> would like to use them with the dp83869 as well:
>=20
> - RJ45 based:
>     - Robofiber SFP-5000-RJ45A: 10/100Base-Tx SFP RJ45
>     - H!Fiber ASF-GE-T1 1000Base-T SFP RJ-25
>=20
> Both of these already work with dp83869 with kernel 6.12, provided I
> set mode to DP83869_RGMII_100_BASE. If I try to make the 1000Base-T
> work at 1Gbps by setting op mode to DP83869_RGMII_1000_BASE it will
> still set speed to 100Mbps and will work just fine, but if I try to set
> speed to 1000, all data transfer stops.
>=20
> Personally, I could live with this, but I assume it should be possible
> for this SFP to work at 1Gbps.
>=20

I can't speak for this particular SFP module, but I've managed to make the=
=20
DP83869 work at near-1Gbps with my modules.


> - Fiber based:
>     - CISCO-FINISAR G155B3520KCD which I believe reports bit
>    =20
>       ETHTOOL_LINK_MODE_10000baseSR_Full_BIT
>    =20
>     - AVAGO AFBR-709SMZ which reports as 10gbase-r
>     - ATGBICS AFBR-5710ALZ-C 1000BASE-SX
>=20
> The first two, even if they report as 10Gbase, did work with dp83848 at
> 100Mbps out of the box, but do not seem to work in any case with
> dp83869. The last one, 1000base-sx, is the one that I expected to
> work either out of the box or by using this set of patches of yours.
> However, none of them do work.
>=20
> What I did next, as the 10gbase was simply refused, was to apply the
> following patch above your series, which is more or less based on one
> of your previous patches from 2025. The key here is that I try hard to
> fallback to 100Mbps on every instance of non working SFP. So, I need
> that if linkmode_empty(sfp_support) because the 10/100 SFPs simply do
> not have any bit active to signal that capability, and I also set mode
> to RGMII_100_BASE in every case. So, with this patch:
>=20
> sfp amba_pl:sfp: module AVAGO            AFBR-709SMZ      rev G4.1 sn
> AA17053045F      dc 170204
> TI DP83869 axienet-40c00000:01: dp83869_module_insert SFP compatible link
> mode: 10gbase-r
> TI DP83869 axienet-40c00000:01: incompatible PHY-to-SFP module link mode
> 10gbase-r! Try simply 10/100
> Configuring network: xilinx_axienet 40c00000.ethernet eth0: PHY [axienet-
> 40c00000:01] driver [TI DP83869] (irq=3DPOLL)
> xilinx_axienet 40c00000.ethernet eth0: configuring for phy/1000base-x link
> mode xilinx_axienet 40c00000.ethernet eth0: Link is Up - 100Mbps/Full -
> flow control off
>=20
> And finally I have my other device answer to ping! So it seems that the
> DP83869, as is, won't be able to run at 1Gbps no matter what.
>=20
> From the datasheet... wouldn't it be necessary to update OP_MODE_DECODE
> Register (Offset =3D 1DFh) [Reset =3D 0040h] CFG_OPMODE bits 2-0 to set v=
alue 1
> RGMII to 1000Base-X?
>=20

This is done by dp83869_configure_mode() when the relevant SFP module is=20
inserted.

Thanks,

=2D-=20
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPartQvBnk1WYSsKfua1xTL8glw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmoizO0ACgkQKCYAIARz
eA7WZQ//VAQuTK2lx62AhkDcp2YcgM4m5F2CVOT+hTOU2veGWxwHEF7gvkq6Z7On
pDzlk/ye+rIQ22hT6bgmdC1Y1+psXiHdonsQs8Vn6fSNZwv6vPpuzfM7UUUU8B3i
l8nPyDQpzmH9NpZTAKoY/1VowpRE6MTR7i0zpgDN51G14jqxLU/sQYSJBSDWqJfx
srxUYA4wVGCxgCuMTg6oy7qHn6N7gyuNxEyo7gU7hI2ZCnJLieYhkQ40vM5DI3vk
MbfZ+BnvmQSw2KxNFYL2PwBh1NBKiTuIl8MwH3GtJUC+jmjFxI9Cni4KcJUcO7eO
/jPPy91O3P7azRg+PwEp3wjdnwEM7G2x6SWtCcktAANfAdS0tjzTrWhknratkNoY
NcqnvTDoC83TpNeawEITZPRP9sWQahmFIL0xR7A0rMUiCmDxByTwX2Csk/hXspwr
rgmgxK3jx7hPSK9GNqkYlyYvwo0ErumK7NUL8fheQxmlxyuH0up8JupS08ca0+4y
V8AgAalXnLaQL+aoissex3T06HMnqBLhNZvQ4d4iBb0vWugdgYHAE8aDaAFWZ9Ft
n2dd4bdM94eFE4V1jJlRnf5ctQBwAbLTFRQU3r7hrS0dj5oh/omF1E6NDm5dLf4O
vw8zgEKYr/fjrpGdRDp5ZRboP1lLc/Z7qpa87ZrBoqlePjdC/ls=
=As7N
-----END PGP SIGNATURE-----

--nextPartQvBnk1WYSsKfua1xTL8glw--




