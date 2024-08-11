Return-Path: <netdev+bounces-117514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE394E26C
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 19:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9A5B20E39
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFC6168DA;
	Sun, 11 Aug 2024 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=shytyi.net header.i=dmytro@shytyi.net header.b="DkYRuzGu"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9D28FC
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723396598; cv=pass; b=UhD/DRatSFESv1QGrWcaHXJGTMpsm/I+3AFLqfj28cSN1Ju725U9cnrFuQMbIWveWaGT8+RN8HQalN/awxfZr2UihOwb10dyTtIvhNtvTZQZLGyaSVPQsUQ4FV1wVPNo1EguCwdfJaE4IzzueAoyXaZmPGi86lW4N3bWnacgZ7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723396598; c=relaxed/simple;
	bh=YOgT6xRJvJTd5OUtYNMl39Ku87kH7Ub+cCRfnVzmiaE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DidkkJl3ZL7f2VtYw/NOjJFeePbDG5lyr1R107WWASdZMgM1gOaT7qBDCdrRDv73PQGuV8Wz+fJtCph5Ef1jfG32E5RdTL3ZJzbAoiU1mQXd1+kFEPRiV5zWbWIjLRN7jbbt6P60WGF7Pld2HZ4dOcdlOmImMj7+W+E5u9uL5rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shytyi.net; spf=none smtp.mailfrom=shytyi.net; dkim=fail (0-bit key) header.d=shytyi.net header.i=dmytro@shytyi.net header.b=DkYRuzGu reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shytyi.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=shytyi.net
ARC-Seal: i=1; a=rsa-sha256; t=1723396570; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=SW6Lj3aZ6aFGfQGyvBIOEswS/V+fh8hopn6BR3f6y5NDMg5Ji0d6CsrFkodSFblvyjFK+wktFBJZGqYiPIJ411GdTRSqFPTioqFTv8C/H4aD+EkXsJ6VJnfW58S0wPZQVBrv7DUbC7/KWDmVYRcuHXGbJhSvxxn2/dSST6D+yq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1723396570; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GX8MECgvW0gk2zv0MTvCoFhx8w2GOhhvv6LjE/QYyT0=; 
	b=Bk/9/NvTgGAn9hdSvdE5DzmuTqKg9dNfXZKcN0yFXxcAp4TSHx7mz3Txo/FHuWD5TKtgTls199E5Sf4biyKFqIoFBrIoP1qrakp0eD5Y1paYnNf395E1bYx3FjsQe3I9QczUKe0eiImEoNKQAzjxqlL/jEZxF1/oPL4RkIWvCEA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723396570;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GX8MECgvW0gk2zv0MTvCoFhx8w2GOhhvv6LjE/QYyT0=;
	b=DkYRuzGuiWvI+bRrfxYJwqBsjrZMCKoewiBI4ye1ibtpDtICgsMZGRHhabUqWpOX
	Ze/lBarawvKQAs367xIpwA2ZIB/vlyt5ift2JQaUklWy5cGiEa1F7/+0Kzv1AnoKKUo
	m2sOYlfIy8aG+XjnQp5fYkFDgKheGY9KlPHxahFk=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 17233965629991006.8114889930274; Sun, 11 Aug 2024 19:16:02 +0200 (CEST)
Date: Sun, 11 Aug 2024 19:16:02 +0200
From: Dmytro Shytyi <dmytro@shytyi.net>
To: "ek" <ek@loon.com>, "ekietf" <ek.ietf@gmail.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>,
	=?UTF-8?Q?=22=22=22Maciej_=C5=BBenczykowski=22=22=22?= <maze@google.com>,
	"yoshfuji" <yoshfuji@linux-ipv6.org>,
	"liuhangbin" <liuhangbin@gmail.com>, "davem" <davem@davemloft.net>,
	"netdev" <netdev@vger.kernel.org>, "David Ahern" <dsahern@gmail.com>,
	"Joel Scherpelz" <jscherpelz@google.com>
Message-ID: <1914270a012.d45a8060119038.8074454106507215168@shytyi.net>
In-Reply-To: <191421fdb45.105ccb455117398.7522619910466771280@shytyi.net>
References: <175b3433a4c.aea7c06513321.4158329434310691736@shytyi.net>
 <202011110944.7zNVZmvB-lkp@intel.com> <175bd218cf4.103c639bc117278.4209371191555514829@shytyi.net>
 <175bf515624.c67e02e8130655.7824060160954233592@shytyi.net>
 <175c31c6260.10eef97f6180313.755036504412557273@shytyi.net>
 <20201117124348.132862b1@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <175e0b9826b.c3bb0aae425910.5834444036489233360@shytyi.net>
 <20201119104413.75ca9888@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <175e1fdb250.1207dca53446410.2492811916841931466@shytyi.net>
 <175e4f98e19.bcccf9b7450965.5991300381666674110@shytyi.net>
 <176458a838e.100a4c464143350.2864106687411861504@shytyi.net>
 <1766d928cc0.11201bffa212800.5586289102777886128@shytyi.net>
 <20201218180323.625dc293@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CANP3RGfG=7nLFdL0wMUCS3W2qnD5e-m3CbV5kNyg_X2go1=MzQ@mail.gmail.com>
 <17a9af1ae30.d78790a8882744.2052315169455447705@shytyi.net> <17a9b993042.b90afa5f896079.1270339649529299106@shytyi.net> <CAAedzxr75CQTPCxf4uq0CcpiOpxQ_rS3-GQRxX=5ApPojSf2wQ@mail.gmail.com> <191421fdb45.105ccb455117398.7522619910466771280@shytyi.net>
Subject: Re: [PATCH net-next V9] net: Variable SLAAC: SLAAC with prefixes of
 arbitrary length in PIO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

[I received the message, that ek@google.com=C2=A0is not reachable, so other=
 email addresses to reach Erik Kline were included in this message]

Hello Erik Kline,
=20
  You stated that, VSLAAC should not be accepted in large part because=20
  it enables a race to the bottom problem for which there is no solution=20
  in sight.
 =20
  We would like to hear more on this subject:
  1. Would you be kind to send us the explanation of
  "race to the bottom problem" in IP context with examples.=C2=A0
  2. Would you be kind to explain howt he possibility of configuration of
  prefix lengths longer that 64, enables "race to the bottom problem"?
 =20
  We look forward for your reply.

Best regards,
Dmytro SHYTYI, et Al.

 >=20
 >=20
 >=20
 > ---- On Mon, 12 Jul 2021 19:51:19 +0200 Erik Kline ek@google.com> wrote =
---
 >=20
 > VSLAAC is indeed quite contentious in the IETF, in large part because=20
 > it enables a race to the bottom problem for which there is no solution=
=20
 > in sight.=20
 > =20
 > I don't think this should be accepted.  It's not in the same category=20
 > of some other Y/N/M things where there are issues of kernel size,=20
 > absence of some underlying physical support or not, etc.=20
 > =20
 > =20
 > On Mon, Jul 12, 2021 at 9:42 AM Dmytro Shytyi dmytro@shytyi.net> wrote:=
=20
 > >=20
 > > Hello Jakub, Maciej, Yoshfuji and others,=20
 > >=20
 > > After discussion with co-authors about this particular point "Internet=
 Draft/RFC" we think the following:=20
 > > Indeed RFC status shows large agreement among IETF members. And that i=
s the best indicator of a maturity level.=20
 > > And that is the best to implement the feature in a stable mainline ker=
nel.=20
 > >=20
 > > At this time VSLAAC is an individual proposal Internet Draft reflectin=
g the opinion of all authors.=20
 > > It is not adopted by any IETF working group. At the same time we consi=
der submission to 3GPP.=20
 > >=20
 > > The features in the kernel have optionally "Y/N/M" and status "EXPERIM=
ENTAL/STABLE".=20
 > > One possibility could be VSLAAC as "N", "EXPERIMENTAL" on the linux-ne=
xt branch.=20
 > >=20
 > > Could you consider this possibility more?=20
 > >=20
 > > If you doubt VSLAAC introducing non-64 bits IID lengths, then one migh=
t wonder whether linux supports IIDs of _arbitrary length_,=20
 > > as specified in the RFC 7217 with maturity level "Standards Track"?=20
 > >=20
 > > Best regards,=20
 > > Dmytro Shytyi et al.=20
 > >=20
 > > ---- On Mon, 12 Jul 2021 15:39:27 +0200 Dmytro Shytyi dmytro@shytyi.ne=
t> wrote ----=20
 > >=20
 > >  > Hello Maciej,=20
 > >  >=20
 > >  >=20
 > >  > ---- On Sat, 19 Dec 2020 03:40:50 +0100 Maciej =C5=BBenczykowski ma=
ze@google.com> wrote ----=20
 > >  >=20
 > >  >  > On Fri, Dec 18, 2020 at 6:03 PM Jakub Kicinski kuba@kernel.org> =
wrote:=20
 > >  >  > >=20
 > >  >  > > It'd be great if someone more familiar with our IPv6 code coul=
d take a=20
 > >  >  > > look. Adding some folks to the CC.=20
 > >  >  > >=20
 > >  >  > > On Wed, 16 Dec 2020 23:01:29 +0100 Dmytro Shytyi wrote:=20
 > >  >  > > > Variable SLAAC [Can be activated via sysctl]:=20
 > >  >  > > > SLAAC with prefixes of arbitrary length in PIO (randomly=20
 > >  >  > > > generated hostID or stable privacy + privacy extensions).=20
 > >  >  > > > The main problem is that SLAAC RA or PD allocates a /64 by t=
he Wireless=20
 > >  >  > > > carrier 4G, 5G to a mobile hotspot, however segmentation of =
the /64 via=20
 > >  >  > > > SLAAC is required so that downstream interfaces can be furth=
er subnetted.=20
 > >  >  > > > Example: uCPE device (4G + WI-FI enabled) receives /64 via W=
ireless, and=20
 > >  >  > > > assigns /72 to VNF-Firewall, /72 to WIFI, /72 to Load-Balanc=
er=20
 > >  >  > > > and /72 to wired connected devices.=20
 > >  >  > > > IETF document that defines problem statement:=20
 > >  >  > > > draft-mishra-v6ops-variable-slaac-problem-stmt=20
 > >  >  > > > IETF document that specifies variable slaac:=20
 > >  >  > > > draft-mishra-6man-variable-slaac=20
 > >  >  > > >=20
 > >  >  > > > Signed-off-by: Dmytro Shytyi dmytro@shytyi.net>=20
 > >  >  > >=20
 > >  >=20
 > >  >  > IMHO acceptance of this should *definitely* wait for the RFC to =
be=20
 > >  >  > accepted/published/standardized (whatever is the right term).=20
 > >  >=20
 > >  > [Dmytro]:=20
 > >  > There is an implementation of Variable SLAAC in the OpenBSD Operati=
ng System.=20
 > >  >=20
 > >  >  > I'm not at all convinced that will happen - this still seems lik=
e a=20
 > >  >  > very fresh *draft* of an rfc,=20
 > >  >  > and I'm *sure* it will be argued about.=20
 > >  >=20
 > >  >  [Dmytro]=20
 > >  > By default, VSLAAC is disabled, so there are _*no*_ impact on netwo=
rk behavior by default.=20
 > >  >=20
 > >  >  > This sort of functionality will not be particularly useful witho=
ut=20
 > >  >  > widespread industry=20
 > >  >=20
 > >  > [Dmytro]:=20
 > >  > There are use-cases that can profit from radvd-like software and VS=
LAAC directly.=20
 > >  >=20
 > >  >  > adoption across *all* major operating systems (Windows, Mac/iOS,=
=20
 > >  >  > Linux/Android, FreeBSD, etc.)=20
 > >  >=20
 > >  > [Dmytro]:=20
 > >  > It should be considered to provide users an _*opportunity*_ to get =
the required feature.=20
 > >  > Solution (as an option) present in linux is better, than _no soluti=
on_ in linux.=20
 > >  >=20
 > >  >  > An implementation that is incompatible with the published RFC wi=
ll=20
 > >  >  > hurt us more then help us.=20
 > >  >=20
 > >  >  [Dmytro]:=20
 > >  > Compatible implementation follows the recent version of document: h=
ttps://datatracker.ietf.org/doc/draft-mishra-6man-variable-slaac/ The sysct=
l usage described in the document is used in the implementation to activate=
/deactivate VSLAAC. By default it is disabled, so there is _*no*_ impact on=
 network behavior by default.=20
 > >  >=20
 > >  >  > Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google=
=20
 > >  >  >=20
 > >  >=20
 > >  > Take care,=20
 > >  > Dmytro.=20
 > >  >=20
 > >=20
 >=20
 >=20
 >=20


