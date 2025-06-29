Return-Path: <netdev+bounces-202213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC9AECBF2
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 11:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDBD173568
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCF71F8725;
	Sun, 29 Jun 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="E+ohbllL"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB711C862C
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751189327; cv=none; b=ObDl/WDG2Fw/qFGfmR48mkYyWKMgU/WCfgy7l1ct34rw89ve+hZanJnr8rFUjdWplFdW8iPIy2YmPBTYs/5w14GtEQd/zabgFtDqQTfBeNHhzEJInIpeObk46FxgG3t2OQ6wzmZAXZyKRBiFiHxBDHeVtDG3lRRaz+TLL/ka86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751189327; c=relaxed/simple;
	bh=ItBj2nJLgw8h/vhJK7CphXVocbVKnddEEqYo0xyH2KA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHAu2bgbycJQbNyNbN5rA/sQxL94qHulYPf0o++ov3XoAVJNibsE6Xnp512AZU5063XBKTnbYqvsHZnqwJZDPDlAOcXuDwxJuoGnN1PT2IA+AhOqoGjUi67+132AWgV3q2Sl1UUEoXX3vGJZMKcU3o4q7krF37SCP4HXMsguaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=E+ohbllL; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33964103972A7;
	Sun, 29 Jun 2025 11:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751189315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bN2XdK2JtRKrax35HcE2dpvOfEKHL/3xM/Eu27Ki9xM=;
	b=E+ohbllL7ADAqSYQxA3PQGncZPoM5DwfLn/MAUlpblfB+K8tNSRm01g7eI5WOEUWHp7+ly
	qxNFUzUz1PG9Ck4UNBHdG/JJyxmSwVOUKS9UQfkUxo0kg+xFHazIyoo8geywQwJv9qrEGA
	ADUQ9/MCRTDjC+b9ValcYMI9gpMOVUHnTL0WJxYebatLz4/oP4rwFNtgjcpSSOEOh85+0h
	RZyKw5Kw+Vz9n4IxlJ55Mn7wZln5Klr4UX7x6ylrPPML/SQIWy1mesrHCSO9W3/C56HemR
	+aqMrbctBneE5w2NmLc1nlKSOstJD9s3cSheehrTeLgaN7ym0JNeaFa2d7T2xA==
Date: Sun, 29 Jun 2025 11:28:30 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Richard Cochran
 <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 netdev@vger.kernel.org, Arun Ramadoss <arun.ramadoss@microchip.com>,
 Tristram.Ha@microchip.com, Christian Eggers <ceggers@arri.de>
Subject: Re: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
Message-ID: <20250629112830.79975f4a@wsk>
In-Reply-To: <20250627215804.mcqsav2x6gbngkib@skbuf>
References: <20250616172501.00ea80c4@wsk>
	<aFD8VDUgRaZ3OZZd@pengutronix.de>
	<b4f057ea-5e48-478d-999b-0b5faebc774c@linux.dev>
	<aFJJlGzu4DrmqH3P@hoboy.vegasvil.org>
	<aFJcP74s0xprhWLz@pengutronix.de>
	<20250626233325.559e48a6@wsk>
	<20250627215804.mcqsav2x6gbngkib@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XFd5tjONOoZf=xt=2VCrVlT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/XFd5tjONOoZf=xt=2VCrVlT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Thu, Jun 26, 2025 at 11:33:25PM +0200, Lukasz Majewski wrote:
> > The second problem which I've found after some debugging:
> > - One device is selected as grandmaster clock. Another one tries to
> >   synchronize (for the simpler setup I've used two the same boards
> > with identical kernel and KSZ9477 setup).
> >=20
> > - tshark from host on which we do have grandmaster running:
> >   IEEEI&MS_00:00:00 PTPv2 58 Sync Message
> >   LLDP_Multicast PTPv2 68 Peer_Delay_Req Message
> >   IEEEI&MS_00:00:00 PTPv2 58 Sync Message
> >   LLDP_Multicast PTPv2 68 Peer_Delay_Req Message
> >=20
> > So the SYNC is send, then the "slave" responds correctly with
> > Peer_Delay_Req_Message. =20
>=20
> Peer delay measurement is an independent process, not a response to
> Sync messages.
>=20
> > But then the "grandmaster" is NOT replying with PER_DELAY_RESPONSE.
> >=20
> > After some digging into the code it turned out that
> > dsa_skb_defer_rx_timestamp() (from net/dsa/tag.c) calls
> > ptp_classify_raw(skb), which is a bpf program.
> >=20
> > Instead of returning 0x42 I do receive "PTP_CLASS_NONE" and the
> > frame is dropped.
> >=20
> > That is why grandmaster cannot send reply and finish the PTP clock
> > adjustment process.
> >=20
> > The CONFIG_NET_PTP_CLASSIFY=3Dy.
> >=20
> > Any hints on how to proceed? If this would help - I'm using linux
> > kernel with PREEMPT_RT applied to it. =20
>=20
> Which frame is classified as PTP_CLASS_NONE? The peer delay request?
> That doesn't sound convincing, can you place a call to skb_dump() and
> show the contents of the PTP packets that don't pass this BPF filter?
> Notably, the filter matches for event messages and doesn't match for
> general messages, maybe that confused your debugging process in some
> way.

It looks like PER_DELAY_REQ goes from one KSZ9477 device (with DA:
01:80:C2:00:00:0E) and then it is not visible (i.e. is dropped) in the
tshark output on the other KSZ9477 device.

=46rom what I've read on the Internet - those multicast frames are
dropped by default by switches, but I'm using KSZ9477 ports in
stand alone mode - i.e. bridge is not created).

On the other hand - the frames with DA: 01:16:19:00:00:00 (other
multicast "set" of address) are delivered correctly (so the grandmaster
clock is elected).

This is under further investigation.
(setting KSZ9477 lan3s as promisc doesn't help).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/XFd5tjONOoZf=xt=2VCrVlT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhhBz4ACgkQAR8vZIA0
zr1ZOQgAoNiDQqxj7aDNrm2SbIfv/muo/LP0cPWjX1HoLtFyjVmFnOityPabUCdj
+0otg2cpnHzjTmI+9CNuSXm6NPrWQ6b79XDe5alE727iggUW5aFl0Pmq2pbCPqWs
3hXKmCpNYiM8iAfaNc687XuKr8L/wxGQU+WcEYixX90DE5hYkiXcrC5id+cVKE4O
LFXo3z8fwNcCMmBTIz6oJUFWPD3TEc0qOWDhR2IUeP9c6hPwqPLd88039xRPuTA0
uxCCKvCnd79KlRwvoo888GPYJNEmNUUboXFrgV1fkj/Ytc+JyX331sI77kj8iplJ
ZEiXG6jFlcAMXQOKDKYumJEut49WAA==
=NSXe
-----END PGP SIGNATURE-----

--Sig_/XFd5tjONOoZf=xt=2VCrVlT--

