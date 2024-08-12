Return-Path: <netdev+bounces-117803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABD094F61E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62924283F71
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D73018953D;
	Mon, 12 Aug 2024 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=shytyi.net header.i=dmytro@shytyi.net header.b="Jag0uYus"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59715188CB0
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485317; cv=pass; b=KlRa6GJUpUi8C7K7e7+vYvKAMPF0yvpK8N8wApuFkcN6pGXTUkIWvO7uDueiwbyQqX5whdqkucOBWqnopBT402ss4X/MUv79YcFJcTu8QujdE9CKbYn5umZAyjmGHRow1b8a4mJwpO2Bxwf9PkGF7hhbyizTSoLYMuxbuAMcJco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485317; c=relaxed/simple;
	bh=10ySCnzWw2oexm3o0Rogo/lBrf0lieN1Ikdo1A1ALSc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fb9Vfg5iqXAyyV13B1kZ+bx2908MQNI/2fUpem+7HLUqMaC9T4XdFQ3ZltCU4YLEW8gNTvI1CbojOyJ25xUEavT+dSeg6d2vsWpr2iBs53kb7pncrDc1dQ/rTOLARS/iI2I2HscYvNCW6qC+U5ApEOElLKGlQ7g8NRQk0brn2pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shytyi.net; spf=none smtp.mailfrom=shytyi.net; dkim=fail (0-bit key) header.d=shytyi.net header.i=dmytro@shytyi.net header.b=Jag0uYus reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shytyi.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=shytyi.net
ARC-Seal: i=1; a=rsa-sha256; t=1723484361; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=g+tSt17rN/S25ECHRE7CznWpAUR59CCMwPR+jKLAWc8EyZ24V2JBnFZ/5E0n2Yvap9d+NdCnJlNoiNyfjMQc6MPVAf0g8IWDNjuq7A3F0Fq+dP03pkeNheJoJyF9LwbGJfnk7ZzD98q1V8PLMgvdexLkLhC44QbsDGuRMFxEVG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1723484361; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wcA1Qabbc5pn64Xt3IXqjycRJCbTZrVAXaR4rJz1eGs=; 
	b=OCbfkM+Ntj0KyN5vSef8e6U7ZkVILFNHR9pK3w3/R1Jhmpz0/K6+XCXnOwbO3oK5M1dcXMZW0IQO5TLweSMEqswVfu+XVO3l91S8OAh5oGRmGv2qrWL6Dsym4HIfUErjUuJw0llGhlo3bm0H3whVB9iqvRz66fGKzBxfSG0Jmw8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723484361;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wcA1Qabbc5pn64Xt3IXqjycRJCbTZrVAXaR4rJz1eGs=;
	b=Jag0uYus5cb6HVo1W5339Ho+jwqWYYiGq1KOOMLNsbgQb7F59tobQncJlI8yszsh
	59XOwI9zqawkgZRvQyox2pFU+rVn+L3vMRMxxNBtZV55Izln2wW4uF2LJRYRseRxEwA
	NQ+eNxS0ndieI4JPoBiPNFrrxNvztZg1LVC3ozb0=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1723484353778317.19009281461445; Mon, 12 Aug 2024 19:39:13 +0200 (CEST)
Date: Mon, 12 Aug 2024 19:39:13 +0200
From: Dmytro Shytyi <dmytro@shytyi.net>
To: =?UTF-8?Q?=22=22Maciej_=C5=BBenczykowski=22=22?= <maze@google.com>
Cc: "ek" <ek@loon.com>, "ekietf" <ek.ietf@gmail.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"yoshfuji" <yoshfuji@linux-ipv6.org>,
	"liuhangbin" <liuhangbin@gmail.com>, "davem" <davem@davemloft.net>,
	"netdev" <netdev@vger.kernel.org>, "David Ahern" <dsahern@gmail.com>,
	"Joel Scherpelz" <jscherpelz@google.com>
Message-ID: <19147ac34b9.11eb4e51f218946.9156409800195270177@shytyi.net>
In-Reply-To: <CANP3RGdeFFjL0OY1H-v6wg-iejDjsvHwBGF-DS_mwG21-sNw4g@mail.gmail.com>
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
 <17a9af1ae30.d78790a8882744.2052315169455447705@shytyi.net>
 <17a9b993042.b90afa5f896079.1270339649529299106@shytyi.net>
 <CAAedzxr75CQTPCxf4uq0CcpiOpxQ_rS3-GQRxX=5ApPojSf2wQ@mail.gmail.com>
 <191421fdb45.105ccb455117398.7522619910466771280@shytyi.net> <1914270a012.d45a8060119038.8074454106507215168@shytyi.net> <CANP3RGdeFFjL0OY1H-v6wg-iejDjsvHwBGF-DS_mwG21-sNw4g@mail.gmail.com>
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

Dear Maciej, Erik,

Thank you for your response and for highlighting that this topic
has been discussed multiple times within IETF and other forums.

I understand that "race to the bottom" is a term that has been
used in various discussions, but I=E2=80=99ve noticed that a concrete
definition of "fundamental problem" (in ML, mail of EK, 2021-10-14 18:26:30=
)
"race to the bottom", particularly in the=20
context [2], has been somewhat elusive.

The fundamental problem "race to the bottom" was
brought up as a issue in the current topic,
therefore, could Erik or you provide a more detailed explanation
or point me to specific documents or discussions where this
fundamental problem "race to the bottom" has been _clearly
defined_ and _well contextualized_ regarding these two questions?
 [1]. Would you be kind to send us the explanation of=20
    "race to the bottom problem" in IP context with examples.=20
 [2]. Would you be kind to explain how the possibility of configuration of=
=20
     prefix lengths longer that 64, enables
     fundamental problem "race to the bottom"?=20

Understanding this more concretely would
be very helpful as we continue to address the issues.

Thank you for your guidance and support.

Best regards,
Dmytro Shytyi et al.

---- On Mon, 12 Aug 2024 18:34:56 +0200 Maciej =C5=BBenczykowski  wrote ---

 > On Sun, Aug 11, 2024 at 10:16=E2=80=AFAM Dmytro Shytyi dmytro@shytyi.net=
> wrote:=20
 > >=20
 > > Hello Erik Kline,=20
 > >=20
 > >   You stated that, VSLAAC should not be accepted in large part because=
=20
 > >   it enables a race to the bottom problem for which there is no soluti=
on=20
 > >   in sight.=20
 > >=20
 > >   We would like to hear more on this subject:=20
 > >   1. Would you be kind to send us the explanation of=20
 > >   "race to the bottom problem" in IP context with examples.=20
 > >=20
 > >   2. Would you be kind to explain howt he possibility of configuration=
 of=20
 > >   prefix lengths longer that 64, enables "race to the bottom problem"?=
=20
 > =20
 > This has been discussed multiple times in IETF (and not only), I don't=
=20
 > think this is the right spot for this sort of discussion.=20
 > =20
 > >=20
 > >   We look forward for your reply.=20
 > =20
 > NAK: Maciej =C5=BBenczykowski maze@google.com>=20
 > >=20
 > > Best regards,=20
 > > Dmytro SHYTYI, et Al.=20
 > >=20
 > >  >=20
 > >  >=20
 > >  >=20
 > >  > ---- On Mon, 12 Jul 2021 19:51:19 +0200 Erik Kline ek@google.com> w=
rote ---=20
 > >  >=20
 > >  > VSLAAC is indeed quite contentious in the IETF, in large part becau=
se=20
 > >  > it enables a race to the bottom problem for which there is no solut=
ion=20
 > >  > in sight.=20
 > >  >=20
 > >  > I don't think this should be accepted.  It's not in the same catego=
ry=20
 > >  > of some other Y/N/M things where there are issues of kernel size,=
=20
 > >  > absence of some underlying physical support or not, etc.=20
 > >  >=20
 > >  >=20
 > >  > On Mon, Jul 12, 2021 at 9:42 AM Dmytro Shytyi dmytro@shytyi.net> wr=
ote:=20
 > >  > >=20
 > >  > > Hello Jakub, Maciej, Yoshfuji and others,=20
 > >  > >=20
 > >  > > After discussion with co-authors about this particular point "Int=
ernet Draft/RFC" we think the following:=20
 > >  > > Indeed RFC status shows large agreement among IETF members. And t=
hat is the best indicator of a maturity level.=20
 > >  > > And that is the best to implement the feature in a stable mainlin=
e kernel.=20
 > >  > >=20
 > >  > > At this time VSLAAC is an individual proposal Internet Draft refl=
ecting the opinion of all authors.=20
 > >  > > It is not adopted by any IETF working group. At the same time we =
consider submission to 3GPP.=20
 > >  > >=20
 > >  > > The features in the kernel have optionally "Y/N/M" and status "EX=
PERIMENTAL/STABLE".=20
 > >  > > One possibility could be VSLAAC as "N", "EXPERIMENTAL" on the lin=
ux-next branch.=20
 > >  > >=20
 > >  > > Could you consider this possibility more?=20
 > >  > >=20
 > >  > > If you doubt VSLAAC introducing non-64 bits IID lengths, then one=
 might wonder whether linux supports IIDs of _arbitrary length_,=20
 > >  > > as specified in the RFC 7217 with maturity level "Standards Track=
"?=20
 > >  > >=20
 > >  > > Best regards,=20
 > >  > > Dmytro Shytyi et al.=20
 > >  > >=20
 > >  > > ---- On Mon, 12 Jul 2021 15:39:27 +0200 Dmytro Shytyi dmytro@shyt=
yi.net> wrote ----=20
 > >  > >=20
 > >  > >  > Hello Maciej,=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >  > ---- On Sat, 19 Dec 2020 03:40:50 +0100 Maciej =C5=BBenczykows=
ki maze@google.com> wrote ----=20
 > >  > >  >=20
 > >  > >  >  > On Fri, Dec 18, 2020 at 6:03 PM Jakub Kicinski kuba@kernel.=
org> wrote:=20
 > >  > >  >  > >=20
 > >  > >  >  > > It'd be great if someone more familiar with our IPv6 code=
 could take a=20
 > >  > >  >  > > look. Adding some folks to the CC.=20
 > >  > >  >  > >=20
 > >  > >  >  > > On Wed, 16 Dec 2020 23:01:29 +0100 Dmytro Shytyi wrote:=
=20
 > >  > >  >  > > > Variable SLAAC [Can be activated via sysctl]:=20
 > >  > >  >  > > > SLAAC with prefixes of arbitrary length in PIO (randoml=
y=20
 > >  > >  >  > > > generated hostID or stable privacy + privacy extensions=
).=20
 > >  > >  >  > > > The main problem is that SLAAC RA or PD allocates a /64=
 by the Wireless=20
 > >  > >  >  > > > carrier 4G, 5G to a mobile hotspot, however segmentatio=
n of the /64 via=20
 > >  > >  >  > > > SLAAC is required so that downstream interfaces can be =
further subnetted.=20
 > >  > >  >  > > > Example: uCPE device (4G + WI-FI enabled) receives /64 =
via Wireless, and=20
 > >  > >  >  > > > assigns /72 to VNF-Firewall, /72 to WIFI, /72 to Load-B=
alancer=20
 > >  > >  >  > > > and /72 to wired connected devices.=20
 > >  > >  >  > > > IETF document that defines problem statement:=20
 > >  > >  >  > > > draft-mishra-v6ops-variable-slaac-problem-stmt=20
 > >  > >  >  > > > IETF document that specifies variable slaac:=20
 > >  > >  >  > > > draft-mishra-6man-variable-slaac=20
 > >  > >  >  > > >=20
 > >  > >  >  > > > Signed-off-by: Dmytro Shytyi dmytro@shytyi.net>=20
 > >  > >  >  > >=20
 > >  > >  >=20
 > >  > >  >  > IMHO acceptance of this should *definitely* wait for the RF=
C to be=20
 > >  > >  >  > accepted/published/standardized (whatever is the right term=
).=20
 > >  > >  >=20
 > >  > >  > [Dmytro]:=20
 > >  > >  > There is an implementation of Variable SLAAC in the OpenBSD Op=
erating System.=20
 > >  > >  >=20
 > >  > >  >  > I'm not at all convinced that will happen - this still seem=
s like a=20
 > >  > >  >  > very fresh *draft* of an rfc,=20
 > >  > >  >  > and I'm *sure* it will be argued about.=20
 > >  > >  >=20
 > >  > >  >  [Dmytro]=20
 > >  > >  > By default, VSLAAC is disabled, so there are _*no*_ impact on =
network behavior by default.=20
 > >  > >  >=20
 > >  > >  >  > This sort of functionality will not be particularly useful =
without=20
 > >  > >  >  > widespread industry=20
 > >  > >  >=20
 > >  > >  > [Dmytro]:=20
 > >  > >  > There are use-cases that can profit from radvd-like software a=
nd VSLAAC directly.=20
 > >  > >  >=20
 > >  > >  >  > adoption across *all* major operating systems (Windows, Mac=
/iOS,=20
 > >  > >  >  > Linux/Android, FreeBSD, etc.)=20
 > >  > >  >=20
 > >  > >  > [Dmytro]:=20
 > >  > >  > It should be considered to provide users an _*opportunity*_ to=
 get the required feature.=20
 > >  > >  > Solution (as an option) present in linux is better, than _no s=
olution_ in linux.=20
 > >  > >  >=20
 > >  > >  >  > An implementation that is incompatible with the published R=
FC will=20
 > >  > >  >  > hurt us more then help us.=20
 > >  > >  >=20
 > >  > >  >  [Dmytro]:=20
 > >  > >  > Compatible implementation follows the recent version of docume=
nt: https://datatracker.ietf.org/doc/draft-mishra-6man-variable-slaac/ The =
sysctl usage described in the document is used in the implementation to act=
ivate/deactivate VSLAAC. By default it is disabled, so there is _*no*_ impa=
ct on network behavior by default.=20
 > >  > >  >=20
 > >  > >  >  > Maciej =C5=BBenczykowski, Kernel Networking Developer @ Goo=
gle=20
 > >  > >  >  >=20
 > >  > >  >=20
 > >  > >  > Take care,=20
 > >  > >  > Dmytro.=20
 > >  > >  >=20
 > >  > >=20
 > >  >=20
 > >  >=20
 > >  >=20
 > >=20
 > =20
 > --=20
 > Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google=20
 >=20

