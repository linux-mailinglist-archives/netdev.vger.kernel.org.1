Return-Path: <netdev+bounces-229796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8EBE0E14
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 23:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9530A4E7D19
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCF304975;
	Wed, 15 Oct 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgFN27n8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462381BC3F;
	Wed, 15 Oct 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565404; cv=none; b=oCUw2uSoSgzZcawRY4erJJkOlEowhUMWGnAr/abcZMDnQZhJ8nJQLFxHuB4DUlcvghIxrGf+3CM9fAvMtWWBzXYhjVqXhkRGxGoVMWQQgU83whpcPkWp4CHHSYm0Lx+3EaaePnX+SFU7n7hI2ojHrywte9FCSHC6eXPMzhk14Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565404; c=relaxed/simple;
	bh=Kp0Iv++zsrADvxWS0araI63hW5WvxHZ8ddvo36MGl0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTh+oCCPFyFjK1xVUvGVrjJeTMTpgQa/gwoLMT0+MZYp/gM9Vp6ahebAZP0cYL7jJXwL/B06Gtds5RgWhmnJLda/JWLZQNnhNhlwlbAr+/4AqJ7EKBNzCTnYkZettjTrn8yt3LdRvukbeQapKbO12qZX1jZobpbQywGxs7FYdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgFN27n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A45C4CEF8;
	Wed, 15 Oct 2025 21:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760565403;
	bh=Kp0Iv++zsrADvxWS0araI63hW5WvxHZ8ddvo36MGl0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VgFN27n8KEZT1Aexm3NiOKMCpgxMK5/iNB/6gyxMh42xozmYKs2CwNbMJd3VYddrk
	 nVF9I9zF4UM5xPWCHLHHUkUE5WFGw8trJ3y+zD1zsgflrgCmEF1NzGCI3il8D2p8vN
	 R0otY5WNbeZmdbPfibx0elo+Oz3Zs2N2fGVh8KiC63ddY4BJxY619ZNPsHrJuSIU4m
	 rivDVbx1Myql7IOe7+LkKKF4OhSsN9TLo4m/Fu9sSg5suVVLgKXeuagzqXvdIHzYhp
	 yrZWQBA8xAk3nbZd3GgBa3R5ybrdI91l9Tk3CJauYFNcpzjBkJmJtQR1mpNjBzWccw
	 5unwHv2a3Mszw==
Date: Wed, 15 Oct 2025 22:56:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251015-convent-handprint-8717277bbffd@spud>
References: <20251014-flattop-limping-46220a9eda46@spud>
 <20251014-projector-immovably-59a2a48857cc@spud>
 <20251014120213.002308f2@kernel.org>
 <20251014-unclothed-outsource-d0438fbf1b23@spud>
 <20251014204807.GA1075103-robh@kernel.org>
 <20251014181302.44537f00@kernel.org>
 <CAL_Jsq+SSiMCbGvbYcrS1mGUJOakqZF=gZOJ4iC=Y5LbcfTAUQ@mail.gmail.com>
 <20251015072547.40c38a2f@kernel.org>
 <CAL_Jsq+wHG_DW1D_=dR6Q_mwyqFAXKGx771PsqjvW+XCRKM3tw@mail.gmail.com>
 <20251015105323.7342652f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GRWFZBjSWdozFA2g"
Content-Disposition: inline
In-Reply-To: <20251015105323.7342652f@kernel.org>


--GRWFZBjSWdozFA2g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:53:23AM -0700, Jakub Kicinski wrote:
> On Wed, 15 Oct 2025 12:32:14 -0500 Rob Herring wrote:
> > On Wed, Oct 15, 2025 at 9:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Wed, 15 Oct 2025 06:53:01 -0500 Rob Herring wrote: =20
> > > > That's fine. Though it will be optional for you, but not us? We have
> > > > to ignore tags without the project if tags intended for netdev are
> > > > continued without the project. Or does no project mean I want to
> > > > update every project? =20
> > >
> > > Fair :( I imagine your workflow is that patches land in your pw, and
> > > once a DT maintainer reviewed them you don't care about them any more=
? =20
> >=20
> > Not exactly. Often I don't, but for example sometimes I need to apply
> > the patch (probably should setup a group tree, but it's enough of an
> > exception I haven't.).

I think myself and Krzysztof (well, I can only really speak for myself)
have some idea about what things are likely to be material for the dt
tree. I just don't set a status for them if I interact or I outright
leave them for Rob.

> > > So perhaps a better bot on your end would be a bot which listens to
> > > Ack/Review tags from DT maintainers. When tag is received the patch
> > > gets dropped from PW as "Handled Elsewhere", and patch id (or whatever
> > > that patch hash thing is called) gets recorded to automatically disca=
rd
> > > pure reposts. =20
> >=20
> > I already have that in place too. Well, kind of, it updates my
> > review/ack automatically on subsequent versions, but I currently do a
> > separate pass of what Conor and Krzysztof reviewed. Where the pw-bot
> > tags are useful is when there are changes requested. I suppose I could
> > look for replies from them without acks, but while that usually
> > indicates changes are needed, not always. So the pw-bot tag is useful
> > to say the other DT maintainers don't need to look at this patch at
> > all.

Yeah, I think it's better to leave it explicit. Often a non-tag reply is
looking for clarification before providing one. Both Krzysztof and I
maintain platforms and minor subsystems (very minor in my case) so
there's b4-ty or manual patch acceptance emails too that obviously are
not requesting changes!

> I don't think we need to do anything, then. Changes-requested will=20
> apply across all the patchwork instances. Only not-applicable /
> handled-elsewhere gets tricky with multiple instances.

I'm sort of unclear about what to do here. What would make sense to me
is that the bots disallow each other's maintainers to set the
not-applicable or handled-elsewhere states, since those are the ones
with unintended consequences if set in the wrong place, like I did here.

"I don't think we need to do anything" sounds like I can do
changes-requested when I feel like it, but need to be careful about
netdev when I do others, which is fine, I just need to know where I
stand.

Cheers,
Conor.

--GRWFZBjSWdozFA2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPAYkgAKCRB4tDGHoIJi
0haWAQDdsl/23JKRW6xnXbeGdTB7WLabxh/De7vIHVpZ2DOyBwEAxWNmQ3XOAI0t
zvf1Fn/Wx4usSz47ObgAJdGJ3PNlDwQ=
=fYM1
-----END PGP SIGNATURE-----

--GRWFZBjSWdozFA2g--

