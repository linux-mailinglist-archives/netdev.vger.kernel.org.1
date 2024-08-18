Return-Path: <netdev+bounces-119466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96157955C49
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 13:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCB41C209C6
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 11:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A019BA6;
	Sun, 18 Aug 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=shytyi.net header.i=dmytro@shytyi.net header.b="YwNx2Fk4"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B061C69A
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723980520; cv=pass; b=GImnudysqbeW4cAhAXPMPV8BAyn3ldUive4bHOK415ADLYmYB7TA4pwyY0lVNvYwN3oFI61NUmPTA8/Kr9PatBgh8Gpo8mgVLICm9gAfaQDdSp8KDbEZWQzI+upWCAx4pvTa9OCcUpdPrJmncx+8PwRsMmR9dYKEynDYpE/8CfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723980520; c=relaxed/simple;
	bh=ILHZRxKMmjXnk8EDXXasp0pmojzILDlf2BkgFmCHs94=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iMxTYId9G3Chr6y9u8U4tCd2ikqhUzqcK9BNqvADaHPamhz4KuQxSKz2aUYRLRmTNgP0A12Wqv3Ch/76tVBAf+cZgsHLtOwx00kJZaN0iR36VvtqPMFDFVng8KVtfz/nBoey69Tkv1AzloJQ9fvGXP4D3zIZ/MEACXKh04qkxls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shytyi.net; spf=none smtp.mailfrom=shytyi.net; dkim=fail (0-bit key) header.d=shytyi.net header.i=dmytro@shytyi.net header.b=YwNx2Fk4 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shytyi.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=shytyi.net
ARC-Seal: i=1; a=rsa-sha256; t=1723980482; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=B8OJvw2o2GsqQyef7piiBLFfqnG5jnuLmO27vUHh9rtQ96ZuoPuO/Sdn4BY7iBJ/b637H+h2gkr2bWNGSVpqQPzU6s3M76K/+G6vJjAOuFrGkAUCkY1xxWO3mQPMbFjhno5pLAZBWwIAlEDlARduTZ+xPCvxgasLAanePSNubT0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1723980482; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ltdx5XB8tBeiGhMsolQXLBa4hZskc8+MEOXkD8JVJv0=; 
	b=ScRTOEuKnUk4rF4WM33VmHbneeIUhbcWslLShVMSD5BfDSyeSsj9swiEfWrfXl3q0nANX62YUBMxm74Re6mTK1HtvYY1OgvIMkRCJnVO/qBD1CCrUNHd3aE4CeeSLyAgvXq82hUo7+Q4/IsTTLjG7g4ggxH1i654rF771Hb8xCk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723980482;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ltdx5XB8tBeiGhMsolQXLBa4hZskc8+MEOXkD8JVJv0=;
	b=YwNx2Fk4+Tdtr3AQzYV2e+IB/UMkkDYmJ7bDM1IvyQfhtl83ZrUGQZlnAzOcmDHg
	sCZMTZzLQka6rrUlAENwcWtApoBaHSipbu2WS0IP0iRpCXIKITCKvzL6S8Ro9Dd/7LB
	EuyIwlIXAFNlH1EqwBGU8XN6mpKWdAFNpanNPOuk=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1723980474373210.26609557715938; Sun, 18 Aug 2024 13:27:54 +0200 (CEST)
Date: Sun, 18 Aug 2024 13:27:54 +0200
From: Dmytro Shytyi <dmytro@shytyi.net>
To: "Erik Kline" <ek.ietf@gmail.com>
Cc: =?UTF-8?Q?=22=22Maciej_=C5=BBenczykowski=22=22?= <maze@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"yoshfuji" <yoshfuji@linux-ipv6.org>,
	"liuhangbin" <liuhangbin@gmail.com>, "davem" <davem@davemloft.net>,
	"netdev" <netdev@vger.kernel.org>, "David Ahern" <dsahern@gmail.com>,
	"Joel Scherpelz" <jscherpelz@google.com>,
	"Lorenzo Colitti" <lorenzo@google.com>
Message-ID: <191653e67be.fd251920614724.7255253647123886380@shytyi.net>
In-Reply-To: <CAMGpriVD6H4t9RSTBeVsLqPC5TGHoMkjOE1SE=MCMDgnxOK7ug@mail.gmail.com>
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
 <191421fdb45.105ccb455117398.7522619910466771280@shytyi.net>
 <1914270a012.d45a8060119038.8074454106507215168@shytyi.net>
 <CANP3RGdeFFjL0OY1H-v6wg-iejDjsvHwBGF-DS_mwG21-sNw4g@mail.gmail.com> <19147ac34b9.11eb4e51f218946.9156409800195270177@shytyi.net> <CAMGpriVD6H4t9RSTBeVsLqPC5TGHoMkjOE1SE=MCMDgnxOK7ug@mail.gmail.com>
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

Erik,

Thank you for bringing this issue into the kernel developers' discussion.

I=E2=80=99ve reviewed the discussions on the "race to the bottom" problem,=
=20
but I=E2=80=99m still not fully clear on its implications in the contextes =
[A].

To ensure that everyone who has access to this mailing list can clearly
understand the problem "race to the bottom" in contextes [A],
could you provide a brief and detailed explanation of what this fundamental=
 problem=20
"race to the bottom" involves in these contextes [A]?

This would help us address related concerns more effectively.

Thank you for your assistance, and I look forward to your clarification.

Best regards,
Dmytro Shytyi et al.

 > > The fundamental problem "race to the bottom" was=20
 > > brought up as a issue in the current topic,=20
 > > therefore, could Erik or you provide a more detailed explanation=20
 > > or point me to specific documents or discussions where this=20
 > > fundamental problem "race to the bottom" has been _clearly=20
 > > defined_ and _well contextualized_ regarding these two questions?=20
[A]
 > >  [1]. Would you be kind to send us the explanation of=20
 > >     "race to the bottom problem" in IP context with examples.=20
 > >  [2]. Would you be kind to explain how the possibility of configuratio=
n of=20
 > >      prefix lengths longer that 64, enables=20
 > >      fundamental problem "race to the bottom"?=20
 > >=20

---- On Sun, 18 Aug 2024 06:48:24 +0200 Erik Kline  wrote ---

 > Dmytro,=20
 > =20
 > Well, there are roughly 1,000,001 threads where this has been hashed=20
 > out.  It's not possible to point to a single document, nor should it=20
 > be necessary IMHO.=20
 > =20
 > Furthermore, changing this doesn't solve the non-deployability of it=20
 > in the general case.  A general purpose network has no idea whether=20
 > attached nodes support the non-default SLAAC configuration, and RAs so=
=20
 > configured will just leave legacy hosts without IPv6 connectivity.=20
 > =20
 > There is still more that can be said, but a troll through the 6MAN=20
 > working group archives will find numerous discussions.=20
 > =20
 > =20
 > On Mon, Aug 12, 2024 at 10:55=E2=80=AFAM Dmytro Shytyi dmytro@shytyi.net=
> wrote:=20
 > >=20
 > > Dear Maciej, Erik,=20
 > >=20
 > > Thank you for your response and for highlighting that this topic=20
 > > has been discussed multiple times within IETF and other forums.=20
 > >=20
 > > I understand that "race to the bottom" is a term that has been=20
 > > used in various discussions, but I=E2=80=99ve noticed that a concrete=
=20
 > > definition of "fundamental problem" (in ML, mail of EK, 2021-10-14 18:=
26:30)=20
 > > "race to the bottom", particularly in the=20
 > > context [2], has been somewhat elusive.=20
 > >=20
 > > The fundamental problem "race to the bottom" was=20
 > > brought up as a issue in the current topic,=20
 > > therefore, could Erik or you provide a more detailed explanation=20
 > > or point me to specific documents or discussions where this=20
 > > fundamental problem "race to the bottom" has been _clearly=20
 > > defined_ and _well contextualized_ regarding these two questions?=20
 > >  [1]. Would you be kind to send us the explanation of=20
 > >     "race to the bottom problem" in IP context with examples.=20
 > >  [2]. Would you be kind to explain how the possibility of configuratio=
n of=20
 > >      prefix lengths longer that 64, enables=20
 > >      fundamental problem "race to the bottom"?=20
 > >=20
 > > Understanding this more concretely would=20
 > > be very helpful as we continue to address the issues.=20
 > >=20
 > > Thank you for your guidance and support.=20
 > >=20
 > > Best regards,=20
 > > Dmytro Shytyi et al.=20
 > >=20
 > > ---- On Mon, 12 Aug 2024 18:34:56 +0200 Maciej =C5=BBenczykowski  wrot=
e ---=20
 > >=20
 > >  > On Sun, Aug 11, 2024 at 10:16=E2=80=AFAM Dmytro Shytyi dmytro@shyty=
i.net> wrote:=20
 > >  > >=20
 > >  > > Hello Erik Kline,=20
 > >  > >=20
 > >  > >   You stated that, VSLAAC should not be accepted in large part be=
cause=20
 > >  > >   it enables a race to the bottom problem for which there is no s=
olution=20
 > >  > >   in sight.=20
 > >  > >=20
 > >  > >   We would like to hear more on this subject:=20
 > >  > >   1. Would you be kind to send us the explanation of=20
 > >  > >   "race to the bottom problem" in IP context with examples.=20
 > >  > >=20
 > >  > >   2. Would you be kind to explain howt he possibility of configur=
ation of=20
 > >  > >   prefix lengths longer that 64, enables "race to the bottom prob=
lem"?=20
 > >  >=20
 > >  > This has been discussed multiple times in IETF (and not only), I do=
n't=20
 > >  > think this is the right spot for this sort of discussion.=20
 > >  >=20
 > >  > >=20
 > >  > >   We look forward for your reply.=20
 > >  >=20
 > >  > NAK: Maciej =C5=BBenczykowski maze@google.com>=20
 > >  > >=20
 > >  > > Best regards,=20
 > >  > > Dmytro SHYTYI, et Al.=20
 > >  > >=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >  > ---- On Mon, 12 Jul 2021 19:51:19 +0200 Erik Kline ek@google.c=
om> wrote ---=20
 > >  > >  >=20
 > >  > >  > VSLAAC is indeed quite contentious in the IETF, in large part =
because=20
 > >  > >  > it enables a race to the bottom problem for which there is no =
solution=20
 > >  > >  > in sight.=20
 > >  > >  >=20
 > >  > >  > I don't think this should be accepted.  It's not in the same c=
ategory=20
 > >  > >  > of some other Y/N/M things where there are issues of kernel si=
ze,=20
 > >  > >  > absence of some underlying physical support or not, etc.=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >  > On Mon, Jul 12, 2021 at 9:42 AM Dmytro Shytyi dmytro@shytyi.ne=
t> wrote:=20
 > >  > >  > >=20
 > >  > >  > > Hello Jakub, Maciej, Yoshfuji and others,=20
 > >  > >  > >=20
 > >  > >  > > After discussion with co-authors about this particular point=
 "Internet Draft/RFC" we think the following:=20
 > >  > >  > > Indeed RFC status shows large agreement among IETF members. =
And that is the best indicator of a maturity level.=20
 > >  > >  > > And that is the best to implement the feature in a stable ma=
inline kernel.=20
 > >  > >  > >=20
 > >  > >  > > At this time VSLAAC is an individual proposal Internet Draft=
 reflecting the opinion of all authors.=20
 > >  > >  > > It is not adopted by any IETF working group. At the same tim=
e we consider submission to 3GPP.=20
 > >  > >  > >=20
 > >  > >  > > The features in the kernel have optionally "Y/N/M" and statu=
s "EXPERIMENTAL/STABLE".=20
 > >  > >  > > One possibility could be VSLAAC as "N", "EXPERIMENTAL" on th=
e linux-next branch.=20
 > >  > >  > >=20
 > >  > >  > > Could you consider this possibility more?=20
 > >  > >  > >=20
 > >  > >  > > If you doubt VSLAAC introducing non-64 bits IID lengths, the=
n one might wonder whether linux supports IIDs of _arbitrary length_,=20
 > >  > >  > > as specified in the RFC 7217 with maturity level "Standards =
Track"?=20
 > >  > >  > >=20
 > >  > >  > > Best regards,=20
 > >  > >  > > Dmytro Shytyi et al.=20
 > >  > >  > >=20
 > >  > >  > > ---- On Mon, 12 Jul 2021 15:39:27 +0200 Dmytro Shytyi dmytro=
@shytyi.net> wrote ----=20
 > >  > >  > >=20
 > >  > >  > >  > Hello Maciej,=20
 > >  > >  > >  >=20
 > >  > >  > >  >=20
 > >  > >  > >  > ---- On Sat, 19 Dec 2020 03:40:50 +0100 Maciej =C5=BBencz=
ykowski maze@google.com> wrote ----=20
 > >  > >  > >  >=20
 > >  > >  > >  >  > On Fri, Dec 18, 2020 at 6:03 PM Jakub Kicinski kuba@ke=
rnel.org> wrote:=20
 > >  > >  > >  >  > >=20
 > >  > >  > >  >  > > It'd be great if someone more familiar with our IPv6=
 code could take a=20
 > >  > >  > >  >  > > look. Adding some folks to the CC.=20
 > >  > >  > >  >  > >=20
 > >  > >  > >  >  > > On Wed, 16 Dec 2020 23:01:29 +0100 Dmytro Shytyi wro=
te:=20
 > >  > >  > >  >  > > > Variable SLAAC [Can be activated via sysctl]:=20
 > >  > >  > >  >  > > > SLAAC with prefixes of arbitrary length in PIO (ra=
ndomly=20
 > >  > >  > >  >  > > > generated hostID or stable privacy + privacy exten=
sions).=20
 > >  > >  > >  >  > > > The main problem is that SLAAC RA or PD allocates =
a /64 by the Wireless=20
 > >  > >  > >  >  > > > carrier 4G, 5G to a mobile hotspot, however segmen=
tation of the /64 via=20
 > >  > >  > >  >  > > > SLAAC is required so that downstream interfaces ca=
n be further subnetted.=20
 > >  > >  > >  >  > > > Example: uCPE device (4G + WI-FI enabled) receives=
 /64 via Wireless, and=20
 > >  > >  > >  >  > > > assigns /72 to VNF-Firewall, /72 to WIFI, /72 to L=
oad-Balancer=20
 > >  > >  > >  >  > > > and /72 to wired connected devices.=20
 > >  > >  > >  >  > > > IETF document that defines problem statement:=20
 > >  > >  > >  >  > > > draft-mishra-v6ops-variable-slaac-problem-stmt=20
 > >  > >  > >  >  > > > IETF document that specifies variable slaac:=20
 > >  > >  > >  >  > > > draft-mishra-6man-variable-slaac=20
 > >  > >  > >  >  > > >=20
 > >  > >  > >  >  > > > Signed-off-by: Dmytro Shytyi dmytro@shytyi.net>=20
 > >  > >  > >  >  > >=20
 > >  > >  > >  >=20
 > >  > >  > >  >  > IMHO acceptance of this should *definitely* wait for t=
he RFC to be=20
 > >  > >  > >  >  > accepted/published/standardized (whatever is the right=
 term).=20
 > >  > >  > >  >=20
 > >  > >  > >  > [Dmytro]:=20
 > >  > >  > >  > There is an implementation of Variable SLAAC in the OpenB=
SD Operating System.=20
 > >  > >  > >  >=20
 > >  > >  > >  >  > I'm not at all convinced that will happen - this still=
 seems like a=20
 > >  > >  > >  >  > very fresh *draft* of an rfc,=20
 > >  > >  > >  >  > and I'm *sure* it will be argued about.=20
 > >  > >  > >  >=20
 > >  > >  > >  >  [Dmytro]=20
 > >  > >  > >  > By default, VSLAAC is disabled, so there are _*no*_ impac=
t on network behavior by default.=20
 > >  > >  > >  >=20
 > >  > >  > >  >  > This sort of functionality will not be particularly us=
eful without=20
 > >  > >  > >  >  > widespread industry=20
 > >  > >  > >  >=20
 > >  > >  > >  > [Dmytro]:=20
 > >  > >  > >  > There are use-cases that can profit from radvd-like softw=
are and VSLAAC directly.=20
 > >  > >  > >  >=20
 > >  > >  > >  >  > adoption across *all* major operating systems (Windows=
, Mac/iOS,=20
 > >  > >  > >  >  > Linux/Android, FreeBSD, etc.)=20
 > >  > >  > >  >=20
 > >  > >  > >  > [Dmytro]:=20
 > >  > >  > >  > It should be considered to provide users an _*opportunity=
*_ to get the required feature.=20
 > >  > >  > >  > Solution (as an option) present in linux is better, than =
_no solution_ in linux.=20
 > >  > >  > >  >=20
 > >  > >  > >  >  > An implementation that is incompatible with the publis=
hed RFC will=20
 > >  > >  > >  >  > hurt us more then help us.=20
 > >  > >  > >  >=20
 > >  > >  > >  >  [Dmytro]:=20
 > >  > >  > >  > Compatible implementation follows the recent version of d=
ocument: https://datatracker.ietf.org/doc/draft-mishra-6man-variable-slaac/=
 The sysctl usage described in the document is used in the implementation t=
o activate/deactivate VSLAAC. By default it is disabled, so there is _*no*_=
 impact on network behavior by default.=20
 > >  > >  > >  >=20
 > >  > >  > >  >  > Maciej =C5=BBenczykowski, Kernel Networking Developer =
@ Google=20
 > >  > >  > >  >  >=20
 > >  > >  > >  >=20
 > >  > >  > >  > Take care,=20
 > >  > >  > >  > Dmytro.=20
 > >  > >  > >  >=20
 > >  > >  > >=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >=20
 > >  >=20
 > >  > --=20
 > >  > Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google=20
 > >  >=20
 >=20

