Return-Path: <netdev+bounces-230893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A726FBF1591
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBB918A598C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E824DD17;
	Mon, 20 Oct 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oNz4QML5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B83FFD;
	Mon, 20 Oct 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964773; cv=none; b=AdCpOu4aJ1qFSp8jg1u0rpwryhg1UHbquFAJlwihspMsiC9KigwAWwHJ9zmbD/rMHJ7/9i4eLHRqLtUnqMVGYnH7DtuJGVR5KcSptCDZOZzAsmJd/shuSC+xNx86KWB+i+DxlrGa9SeRDWlaITfpnJrgsBXqft3NajPTwHuIq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964773; c=relaxed/simple;
	bh=J9APxNL5PwC3SXUAS1ytIgcn6UBgz/29jtLEKf2eyWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaKxBq1sktZk6KiPeVl+sTxaATjbdB6T6Etvw31pCGk4wcO++38v3uZ4a5QIPBOc8h3FCwT4AJT731jBG5Ncs8T+oxlNe67ALRKuoyCVQ/5Ifdf5cJ2KMg98wX+wSv/T18prtfWDkdHPYi8MJw4GEYh9FtU2/pZCZqak+H9vg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oNz4QML5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 192601A150D;
	Mon, 20 Oct 2025 12:52:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D688C606D5;
	Mon, 20 Oct 2025 12:52:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3CDA102F23B2;
	Mon, 20 Oct 2025 14:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760964764; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xm/J5aoiPYsZnMiN7LTPgkGX52KGGjizlIB4W3vhsvI=;
	b=oNz4QML52tT7x/9G0sWyWTxbCrAVkNvTv79vy7Dp5UIupPUNqYDHcEkldl79sy3TOslfCe
	/k81yvPVrU+6MkZTNFShUBBIspeDJirvh9+NrHDH5AFPfUZLg7gHYSeGFnkL8Aq82o2hfZ
	LJ7CT8ajJWywOKH7nYFIYQvtLol54IcTYgNeUgl62+YJb0H0dsSalA4yrSAqO7+BOwNCVM
	fK189keR7wQECoOZneEEzTCMsjbZO70i4AI96+MIQmA9M20NIW0rH47ptuYGHm9uoXifVl
	CfPl18lfYSdKcKBJyeI+hrd+XtRyjYso2ZTmPosoxLNot3FBGdbRbILiN78CKQ==
Date: Mon, 20 Oct 2025 14:52:14 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
Message-ID: <20251020145214.64186fc9@kmaincent-XPS-13-7390>
In-Reply-To: <b2c58580-d891-4d10-b3dd-572f7f98c6fe@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
	<20251015102725.1297985-3-maxime.chevallier@bootlin.com>
	<20251017182358.42f76387@kernel.org>
	<d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
	<20251020110040.18cf60c9@kmaincent-XPS-13-7390>
	<b2c58580-d891-4d10-b3dd-572f7f98c6fe@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 20 Oct 2025 11:32:37 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hi K=C3=B6ry,
>=20
> On 20/10/2025 11:00, Kory Maincent wrote:
> > On Sat, 18 Oct 2025 09:42:57 +0200
> > Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> >  =20
> >> Hi Jakub,
> >>
> >> On 18/10/2025 03:23, Jakub Kicinski wrote: =20
> >>> On Wed, 15 Oct 2025 12:27:22 +0200 Maxime Chevallier wrote:   =20
> >>>> The DWMAC1000 supports 2 timestamping configurations to configure how
> >>>> frequency adjustments are made to the ptp_clock, as well as the repo=
rted
> >>>> timestamp values.
> >>>>
> >>>> There was a previous attempt at upstreaming support for configuring =
this
> >>>> mode by Olivier Dautricourt and Julien Beraud a few years back [1]
> >>>>
> >>>> In a nutshell, the timestamping can be either set in fine mode or in
> >>>> coarse mode.
> >>>>
> >>>> In fine mode, which is the default, we use the overflow of an accumu=
lator
> >>>> to trigger frequency adjustments, but by doing so we lose precision =
on
> >>>> the timetamps that are produced by the timestamping unit. The main
> >>>> drawback is that the sub-second increment value, used to generate
> >>>> timestamps, can't be set to lower than (2 / ptp_clock_freq).
> >>>>
> >>>> The "fine" qualification comes from the frequent frequency adjustmen=
ts we
> >>>> are able to do, which is perfect for a PTP follower usecase.
> >>>>
> >>>> In Coarse mode, we don't do frequency adjustments based on an
> >>>> accumulator overflow. We can therefore have very fine subsecond
> >>>> increment values, allowing for better timestamping precision. However
> >>>> this mode works best when the ptp clock frequency is adjusted based =
on
> >>>> an external signal, such as a PPS input produced by a GPS clock. This
> >>>> mode is therefore perfect for a Grand-master usecase.
> >>>>
> >>>> We therefore attempt to map these 2 modes with the newly introduced
> >>>> hwtimestamp qualifiers (precise and approx).
> >>>>
> >>>> Precise mode is mapped to stmmac fine mode, and is the expected defa=
ult,
> >>>> suitable for all cases and perfect for follower mode
> >>>>
> >>>> Approx mode is mapped to coarse mode, suitable for Grand-master.   =
=20
> >>>
> >>> I failed to understand what this device does and what the problem is =
:(
> >>>
> >>> What is your ptp_clock_freq? Isn't it around 50MHz typically?=20
> >>> So 2 / ptp_freq is 40nsec (?), not too bad?   =20
> >>
> >> That's not too bad indeed, but it makes a difference when acting as
> >> Grand Master, especially in this case because you don't need to
> >> perform clock adjustments (it's sync'd through PPS in), so we might
> >> as well take this opportunity to improve the TS.
> >> =20
> >>>
> >>> My recollection of the idea behind that timestamping providers
> >>> was that you can configure different filters for different providers.
> >>> IOW that you'd be able to say:
> >>>  - [precise] Rx stamp PTP packets=20
> >>>  -  [approx] Rx stamp all packets
> >>> not that you'd configure precision of one piece of HW..   =20
> >>
> >> So far it looks like only one provider is enabled at a given time, my
> >> understanding was that the qualifier would be used in case there
> >> are multiple timestampers on the data path, to select the better one
> >> (e.g. a PHY that supports TS, a MAC that supports TS, we use the=20
> >> best out of the two). =20
> >=20
> > No, we do not support multiple timestampers at the same time.
> > For that IIUC we would have to add a an ID of the source in the packet.=
 I
> > remember people were talking about modifying cmsg.=20
> > This qualifier is indeed a first step to walk this path but I don't thi=
nk
> > people are currently working on adding this support for now.=20
> >  =20
> >> However I agree with your comments, that's exactly the kind of feedback
> >> I was looking for. This work has been tried several times now each
> >> time with a different uAPI path, I'm OK to consider that this is out
> >> of the scope of the hwprov feature.
> >> =20
> >>> If the HW really needs it, just lob a devlink param at it?   =20
> >>
> >> I'm totally OK with that. I'm not well versed into devlink, working mo=
stly
> >> with embedded devices with simple-ish NICs, most of them don't use dev=
link.
> >> Let me give it a try then :) =20
> >=20
> > meh, I kind of dislike using devlink here. As I said using timestamping
> > qualifier is a fist step for the multiple timestamping support. If one =
day
> > we will add this support, if there is other implementation it will add
> > burden on the development to track and change all the other implementat=
ion.
> > Why don't we always use this qualifier parameter even if it is not real=
ly
> > for simultaneous timestamping to avoid any future wrong development cho=
ice.
> > =20
>=20
> On my side I've implemented the devlink-based approach, and I have to say=
 i'm
> not so unhappy with it :) At least I don't have the feeling this is bendi=
ng
> the API to fit one specific case.

Indeed I don't think so, but my idea was to generalize the selection of
the timestamp provider source to one API even if it is only one clock for t=
wo
different qualifiers.
=20
> The thing is that the qualifier model doesn't fully map to the situation =
we
> have in stmmac.
>=20
> The stmmac coarse/fine adjustment doesn't only changes the timestamping
> behaviour, but also the ptp_clock adjustment mode.=20
>=20
> So changing the qualifier here will have a side effect on the PTP clock,
> do we accept that as part of the hwprov timestamping API ?

Yes, I see the timestamp source as a couple of a qualifier plus a PTP
clock index therefore if we change the timestamp source it is intended to h=
ave
side effect.

> Should we use this API for coarse/fine stmmac config, I agree with your
> previous comment of adding a dedicated qualifier that explicitely says
> that using this qualifier comes with side effects, with the risk of
> paving the way for lots of modes being added for driver-specific scenario=
s.

I am not really a PTP in the field user but maybe there is a limited number=
 of
generic qualifier possible. Here we could have a qualifier for better frequ=
ency
precision and one for better timestamping precision. I don't think we will =
end
with tons of different qualifiers.
Maybe PTP maintainers and users like Richard or Willem have pointers on the
number of possible qualifier?

> Another thing with the stmmac implem is that we don't truly have 2
> timestampers (1 approx and 1 precise), but rather only one whose precision
> can be adjusted. Does it really make sense here to have the qualifier
> writeable for the same timestamper ?

I do think so.

> Of course the netlink tsinfo/tsconfig is more appealing due to its generic
> nature, but OTHO I don't want to introduce ill-defined behaviours in that
> API with this series. The multiple timestamper work still makes a ton of
> sense for MAC+PHY timestamping setups :)

I think that is where it would be nice to have a review from Richard or
Willem on this to give us pointers on what is existing in the PTP world and=
 if
using a qualifier makes sense.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

