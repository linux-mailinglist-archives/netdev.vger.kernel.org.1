Return-Path: <netdev+bounces-201691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78223AEA8E5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50440188E9BF
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514BE25B305;
	Thu, 26 Jun 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gzmW01QK"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAF24503B
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973622; cv=none; b=GydWIG9LKW/XOotkL2KEBk03VtzpmMMIa3aKZJLDVdD4mJUk6WO/X0SEALrvgcoIj0jcq3LDLYnEewh/p+fa0ARh0xeloeGLsILqwPLURK5f7q4cfFazgTfOomqVoEIjbZeHQneZtDy5Bfys5JSc9yetLQbGOXJLfKE7LCk/DEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973622; c=relaxed/simple;
	bh=Cau8qO0XLB20gIDtIpOju5w3e6xjb2Kzsmv8M3YuK/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvoD7JpRAYtyCJ67i7VyT57Ypw6Mdsb4NUo2fWELKVgBViCzHXE9XSOqLcnadF6Qxur6WEDTsjoqOCftPfyebsxVW84Hn3J14/UteLInZMqhQQe/1y14ZlrC8pmhwd19lo/EPZLwKlS/MtEwV1ZkJ+iG+IhsgjoVdOviqgimetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gzmW01QK; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9726A10397285;
	Thu, 26 Jun 2025 23:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750973611; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aR+uqyd2Iq/1W93W2Yf1coSFFgKnKTdHG5Y4tUpaYsw=;
	b=gzmW01QKLKQNi7u5w0/1r6gcfJtj8noHpIckdO6NuxtjmuU0oWWtq15MfpbPOksonqVT3/
	dPU5aI98JSwkFgYxQP3ZYfb9DUBH5Fcb4eVfwziYRl7cXbOCsVfc5tGooV3o0Opon1pqto
	94/Ndv38gj7lSD+ZJ8r0pu2z8BblSdQFpsDf4M4JveNlm0MGPdX6Ai9Atzy6a+DIPZPZyZ
	1CGaZik5UoTHOLTV+mLBL2fVQXd1qnb3q/RZUeYfumnC1DRPFiDYYd14Layuedycad4dJU
	8XucBxbFfowpGX1U+RniZlWcLbJHkbz24QeTmfFVg0GZMCqvNStt7YbffRN4jA==
Date: Thu, 26 Jun 2025 23:33:25 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, Arun Ramadoss
 <arun.ramadoss@microchip.com>, Vladimir Oltean <olteanv@gmail.com>,
 Tristram.Ha@microchip.com, Christian Eggers <ceggers@arri.de>
Subject: Re: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
Message-ID: <20250626233325.559e48a6@wsk>
In-Reply-To: <aFJcP74s0xprhWLz@pengutronix.de>
References: <20250616172501.00ea80c4@wsk>
	<aFD8VDUgRaZ3OZZd@pengutronix.de>
	<b4f057ea-5e48-478d-999b-0b5faebc774c@linux.dev>
	<aFJJlGzu4DrmqH3P@hoboy.vegasvil.org>
	<aFJcP74s0xprhWLz@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4pkVMgoNJIyF/Ld1s3/fp+N";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/4pkVMgoNJIyF/Ld1s3/fp+N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

> On Tue, Jun 17, 2025 at 10:07:32PM -0700, Richard Cochran wrote:
> > On Tue, Jun 17, 2025 at 05:10:11PM +0100, Vadim Fedorenko wrote: =20
> > > On 17/06/2025 06:25, Oleksij Rempel wrote: =20
> > > > No, this will not work correctly. Both sides must use the same
> > > > timestamping mode: either both "one step" or both "two step". =20
> > >=20
> > > I'm not quite sure this statement is fully correct. I don't have a
> > > hardware on hands to make this setup, but reading through the
> > > code in linuxptp - the two-step fsm kicks off based on the
> > > message type bit. In case when linuxptp receives 1-step sync, it
> > > does all the calculations. =20
> >=20
> > Correct.
> >  =20
> > > For delay response packets on GM side it doesn't matter as GM
> > > doesn't do any calculations. I don't see any requirements here
> > > from the perspective of protocol itself. =20
> >=20
> > Running on a PTP client, ptp4l will happily use either one or two
> > step Sync messages from the server. =20
>=20
> Thank you for clarification! In this case, something else was wrong,
> and I made a wrong assumption. I had a non-working configuration, so
> I made the assumption without verifying the code.
>=20

Ok, I do have one issue to fix - the BBB with "two step" timestamping
mode (with recent ptp4l) shall communicate with the KSZ9477 based PTP
setup, which uses the "one step" timestamping.

The second problem which I've found after some debugging:
- One device is selected as grandmaster clock. Another one tries to
  synchronize (for the simpler setup I've used two the same boards with
  identical kernel and KSZ9477 setup).

- tshark from host on which we do have grandmaster running:
  IEEEI&MS_00:00:00 PTPv2 58 Sync Message
  LLDP_Multicast PTPv2 68 Peer_Delay_Req Message
  IEEEI&MS_00:00:00 PTPv2 58 Sync Message
  LLDP_Multicast PTPv2 68 Peer_Delay_Req Message

So the SYNC is send, then the "slave" responds correctly with
Peer_Delay_Req_Message.

But then the "grandmaster" is NOT replying with PER_DELAY_RESPONSE.

After some digging into the code it turned out that
dsa_skb_defer_rx_timestamp() (from net/dsa/tag.c) calls
ptp_classify_raw(skb), which is a bpf program.

Instead of returning 0x42 I do receive "PTP_CLASS_NONE" and the frame is
dropped.

That is why grandmaster cannot send reply and finish the PTP clock
adjustment process.

The CONFIG_NET_PTP_CLASSIFY=3Dy.

Any hints on how to proceed? If this would help - I'm using linux
kernel with PREEMPT_RT applied to it.

> Best Regards,
> Oleksij


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/4pkVMgoNJIyF/Ld1s3/fp+N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhdvKUACgkQAR8vZIA0
zr0enAgAgNjwvJtdpVWsE2JNkfbmNW4Nr1HFqB7ZtSMu0apuLd991+QdZrjIEj7d
sKDI6J2rE2V4v5rCn3cyLtyhT81gK+eo1HHE/OF0mPeXxMANQ83k7SnPf1XwXhF/
drlPUayeId951uRvzh0Jl6vooLvJtE7VF17JtO7JDVOcMD1raN7n6rLflVOLa79Y
K2SVLr5/g+lUOl7vksrpu5OvrQE+aMFXvJC+Czi8Grn3WU330iJLwHTz5suKNTyT
uP8y/EDrJj+oWY+x+Iqx0rV4Vxsjm5LHqtHBaXPTLwGklN6qm/ZAypayfcKtB9ch
hSnNVoquTrMkbgogHyMmLskDijiSZA==
=ME5U
-----END PGP SIGNATURE-----

--Sig_/4pkVMgoNJIyF/Ld1s3/fp+N--

