Return-Path: <netdev+bounces-198504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FCAADC743
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666633ACA54
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3F829826D;
	Tue, 17 Jun 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XpIRC9SZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F012C030D
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154017; cv=none; b=ClySWbGok5T52WjLnp543H4OXEdRokpabRVRHMhBhUZ6L0cIjDvflRvQ5fS73hl+3sKUOSsDu6MD1t+DE0uuwRnQ2YW67qhrBW7KuW4zk3ccjpR7fk322EJlT0m9BnVDZi3OYAFsI/X1VLi64fS3EP+8vJ9AccsSaWLhfAti+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154017; c=relaxed/simple;
	bh=Yl1W4pPKKyOZKjKH2Ny19YuHMVIr2w1OUSbbM7Np6e4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tu7UGV6HSf5hGVeNIStPW1/vZCzOEd4aF4l4K9anqkruf/+yRnaTa9sFpGyNd2eVYDfDUoc5fN83a53BS63OXjBVNFRtL3erMCOcV+opXoBPsfrf8eF5pbjZcdzLGFvU1L6USx4AecYVVdiDR1+kLfZwwv1rof7iynTnDmVmrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XpIRC9SZ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AD5F103972B9;
	Tue, 17 Jun 2025 11:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750154006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Y3veyDwfFNwxDC76GbqBiyYm0yZJR+ptLwR954DrP3M=;
	b=XpIRC9SZJ3HWOpIHqBz9jwUWdHakMikh+5I4ijd1jgNd2FcawwtJWPnbczyzpfAlB1tD8Q
	yfKuRW6MaLiKko3k4xummApHRg9tIlt5ZTdSFQhxa5jmvs5IvMhuzpCRkUm0EXEiEk24/N
	0UF1aXqtVrwug0tSqrwYJFoZZ1DSomUN3L3Ba5bw1Ss3d+dfvnYToR0e/dmfGOJSWeKy6m
	w/C7rDeZ02hwE1yVq4evSQuffZ84djMUQlvUHYfCXIgQ15SvtN30VYkEWq0tIDmT6yRmXj
	69yok+sigHe2O/Hc3us55E34A0ypl8qaXxvFwsfFX3OXnTnw8OhWmDC+ZhsR4g==
Date: Tue, 17 Jun 2025 11:53:22 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, Arun Ramadoss <arun.ramadoss@microchip.com>,
 Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com, Richard
 Cochran <richardcochran@gmail.com>, Christian Eggers <ceggers@arri.de>
Subject: Re: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
Message-ID: <20250617115322.675ec851@wsk>
In-Reply-To: <aFD8VDUgRaZ3OZZd@pengutronix.de>
References: <20250616172501.00ea80c4@wsk>
	<aFD8VDUgRaZ3OZZd@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=hHZ3caoYqlURl//xTiVaAQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/=hHZ3caoYqlURl//xTiVaAQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

Big thanks for sharing your experience with KSZ9477 and PTP - now many
things got clear.

> On Mon, Jun 16, 2025 at 05:25:01PM +0200, Lukasz Majewski wrote:
> > Dear Community,
> >=20
> > As of [1] KSZ drivers support HW timestamping
> > HWTSTAMP_TX_ONESTEP_P2P. When used with ptp4l (config [2]) I'm able
> > to see that two boards with KSZ9477 can communicate and one of them
> > is a grandmaster device.
> >=20
> > This is OK (/dev/ptp0 is created and works properly).
> >=20
> > From what I have understood - the device which supports p2p1step
> > also supports "older" approaches, so communication with other HW
> > shall be possible. =20
>=20
> This is not fully correct. "One step" and "two step" need different
> things from hardware and driver.
>=20
> In "one step" mode, the switch modifies the PTP frame directly and
> inserts the timestamp during sending (start of frame). This works
> without host help.

In principle - timestamp is inserted to KSZ TAG and then the PTP
specific frame is "modified" by KSZ9477 internal HW to accommodate it.

And the timestamp counter is accessible via SPI with KSZ9477 registers.

>=20
> But for "two step" mode, the hardware only timestamps after the frame
> is sent.

Ok, so in this case the HW inserts to switch/NIC registers' the new
timestamp value when PTP frame is send. Then it needs to be read and
utilized by the driver.

> The host must then read this timestamp. For that, the switch
> must trigger an interrupt to the host. This requires:
> - board to wire the IRQ line from switch to host,
> - and driver to handle that interrupt and read the timestamp (like in
> ksz_ptp_msg_thread_fn()).
>=20

Now it is clear why PTP driver for KSZ creates some interrupts, but
those don't trigger.

> So it's not only about switch HW. It also depends on board design and
> driver support.

Ok.

>=20
> > Hence the questions:
> >=20
> > 1. Would it be possible to communicate with beaglebone black (BBB)
> > connected to the same network? =20
>=20
> No, this will not work correctly. Both sides must use the same
> timestamping mode: either both "one step" or both "two step".
> =20
> > root@BeagleBone:~# ethtool -T eth0
> > Hardware Transmit Timestamp Modes:
> >         off
> >         on
> > Hardware Receive Filter Modes:
> >         none
> >         ptpv2-event =20
>=20
> BBB supports only "two step" (mode "on").

Yes, correct. It can only properly communicate with other device (like
RPI4) supporting mode "on".

> =20
> > My board:
> > # ethtool -T lan3
> > Hardware Transmit Timestamp Modes:
> >         off
> >         onestep-p2p
> > Hardware Receive Filter Modes:
> >         none
> >         ptpv2-l4-event
> >         ptpv2-l2-event
> >         ptpv2-event =20
>=20
> Your board supports only "one step". So they cannot sync correctly.
>=20
> > (other fields are the same)
> >=20
> > As I've stated above - onestep-p2p shall also support the "on" mode
> > from BBB. =20
>=20
> No, onestep-p2p cannot talk to "on" mode. They use different
> timestamping logic. ptp4l cannot mix one-step and two-step.

Ok. Now it is clear.

>=20
> > The documentation of KSZ9477 states that:
> > - IEEE 1588v2 PTP and Clock Synchronization
> > - Transparent Clock (TC) with auto correction update
> > - Master and slave Ordinary Clock (OC) support
> > - End-to-end (E2E) or peer-to-peer (P2P)
> > - PTP multicast and unicast message support
> > - PTP message transport over IPv4/v6 and IEEE 802.3
> > - IEEE 1588v2 PTP packet filtering
> > - Synchronous Ethernet support via recovered clock
> >=20
> > which looks like all PTP use cases (and other boards) for HW shall
> > be supported.
> >=20
> > Is this a matter of not (yet) available in-driver support or do I
> > need to configure linuxptp in different way to have such support? =20
>=20
> Be careful - this list shows what the hardware could support, but not
> what actually works in all setups. Many features need specific driver
> or board support.
>=20
> For example, KSZ9477 has an erratum for 2-step mode:
> When 2-step is enabled, some PTP messages (like Sync, Follow-up,
> Announce) can get dropped if normal traffic is present. This makes
> 2-step mode unreliable.
>=20
> End-user impact: Protocols like gPTP or AVB, which require 2-step
> mode, will not work correctly. The device cannot keep time sync in
> 2-step mode with other devices.

And this information is crucial for me - i.e. the KSZ9477 has HW
limitation, which only allows it to be used with "onestep" PTP
synchronization scheme.

> =20
> > 2. The master clock synchronization and calibration
> >=20
> > On one board (grandmaster) (connected to lan3):
> > [1943.558]: port 0: INITIALIZING to LISTENING on INIT_COMPLETE
> > [1951.091]: port 1: LISTENING to MASTER on
> > ANNOUNCE_RECEIPT_TIMEOUT_EXPIRES
> > [1951.091]: selected local clock 824f12.fffe.110022 as best master
> > [1951.091]: port 1: assuming the grand master role
> >=20
> > The other board:
> > [890.003]: port 1 (lan3): new foreign master 824f12.fffe.110022-1
> > [894.003]: selected best master clock 824f12.fffe.110022
> > [894.005]: port 1 (lan3): LISTENING to UNCALIBRATED on RS_SLAVE =20
>=20
> At this point, I would expect to see output like:
>=20
> master offset ... path delay ...
> port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
>=20
> If these are missing, sync is not working. In this case, the likely
> reason is that the two devices use different timestamping modes =E2=80=94
> one-step vs two-step =E2=80=94 which are not compatible. Because of that,
> delay and offset cannot be calculated, and the state stays
> UNCALIBRATED.=20

This is not exactly the case - i.e. I'm using two boards with KSZ9477
ICs connected together (no bridging is used).

Both are the same HW, with the same Linux on each.

> > The phc2sys -m -s lan3 shows some calibration...
> >=20
> > CLOCK_REALTIME phc offset        65 s2 freq  -45509 delay 351557
> > CLOCK_REALTIME phc offset       591 s2 freq  -44964 delay 350475
> > CLOCK_REALTIME phc offset      -892 s2 freq  -46270 delay 350516
> > CLOCK_REALTIME phc offset    137456 s2 freq  +91811 delay 733784
> > CLOCK_REALTIME phc offset   -136987 s2 freq -141395 delay 350676
> > CLOCK_REALTIME phc offset    -41327 s2 freq  -86831 delay 350216
> > CLOCK_REALTIME phc offset        66 s2 freq  -57837 delay 350489
> > CLOCK_REALTIME phc offset     12037 s2 freq  -45846 delay 351854
> > CLOCK_REALTIME phc offset     12213 s2 freq  -42059 delay 350474
> > CLOCK_REALTIME phc offset      8984 s2 freq  -41624 delay 349682
> >=20
> >=20
> > but the "fluctuation" is too large to regard it as a "stable" and
> > precise source. =20
>=20
> This is not the right tool to check the current sync problem. The
> timestamp readings on KSZ are done over several SPI transactions,
> which adds jitter and delay.

Ok.

>=20
> For better accuracy, the driver should support gettimex64(), but this
> is not implemented in the KSZ driver. So the phc2sys output is not
> reliable here.

Ok. Thanks for the clarification.

>=20
> > And probably hence it is "UNCALIBRATED" master clock.
> >=20
> > Even more strange - the tshark -i lan3 -Y "ptp" -V
> >=20
> > .... 1011 =3D messageId: Announce Message (0xb)
> > correction: 0.000000 nanoseconds                    =20
> >     correction: Ns: 0 nanoseconds                  =20
> >     correctionSubNs: 0 nanoseconds            =20
> >=20
> > .... 0010 =3D messageId: Peer_Delay_Req Message (0x2)
> >     correction: 0.000000 nanoseconds
> >     correction: Ns: 0 nanoseconds
> >     correctionSubNs: 0 nanoseconds
> >=20
> > shows always the correction value of 0 ns.
> > I do guess that it shall have some (different) values.
> >=20
> > Any hints on fixing this problem? =20
>=20
> The correctionField is only set when Transparent Clock (TC) is
> active. But with KSZ switches, TC is disabled as soon as any port
> uses DSA CPU tagging.

Ok.

>=20
> So in your setup, TC is not active =E2=80=94 that=E2=80=99s why correctio=
nField stays
> 0. This is expected behavior with current driver and DSA integration

Ok. Thanks for the clarification.

> =20
> > 3. Just to mention - I've found rather old conversation regarding
> > PTP support [3] on KSZ devices (but for KSZ9563)
> >=20
> > And it looks like it has already been adopted to minline Linux.=20
> > Am I correct? Or is anything still missing (and hence I do see the
> > two described above issues)? =20
>=20
> Some support is in mainline, but what works depends on several things:
>=20
> - the exact KSZ switch variant (some have quirks, e.g. broken 2-step
> mode),
> - the required feature (OC, TC, 1-step or 2-step),
> - the board implementation (e.g. IRQ lines connected or not),
> - and driver support (e.g. timestamp reading, gettimex64).
>=20
> For example:
> - If your KSZ chip has broken 2-step mode (known issue), you can only
> use 1-step.
> - If the switch is used with DSA and CPU tagging is enabled,
> Transparent Clock cannot work.
>=20

Now it is clear.

So the TC can be only used when no 'master' port is connected (i.e. the
switch is working as a "standalone", non-CPU mode)?

> So yes, it=E2=80=99s upstream - but real support depends on your exact use
> case.

Ok.

I've looked into the tshark output and it looks like only:

Announce Message (0xb) 80:1f:12:3e:0a:22 -> 01:1b:19:00:00:00
Sync Message (0x0)     80:1f:12:3e:0a:22 -> 01:1b:19:00:00:00
Peer_Delay_Req Message (0x2)
	80:1f:12:3e:0a:42 -> 01:80:c2:00:00:0e (LLDP Multicast)

frames are present.

The DELAY-RESPONSE from (master to slave) is not present, so the slave
cannot calculate transmission delay and synchronize.

I'm now investigating why it is not present.

>=20
> Best Regards,
> Oleksij Rempel




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/=hHZ3caoYqlURl//xTiVaAQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhROxIACgkQAR8vZIA0
zr0zeAgAh0YIIYpzxexICmqfwuk342zk1PGdXyFvyfGQaIoO39N2JaHWaxc28DTm
o4ocf0kLmOfyuHAIPQT1RCFy9Bjs3QHAAPEj+iwKDbKxOZM69Aqu/puWCptU8sXN
dNo0ugiI2DvnJS+ei2LzRJb46G34hjo5xuL18fAxHLRzp4Jh2EvTZKPzXv2QmyLj
7Y63qYL1Q4e+U6kpjyJHSI/TVCfzupFuqeHHV4kBAHKEaYwszs6e44qmCWFFJxT/
yqATySh7bRXSF2sXYknJxO5K7TX9y8mWvXIDzKthWG0Rs1uaXz5n6zBpap/H+GpF
S/at9cm/6ybvMa1KVTQ2mOebcHAEYw==
=s/zv
-----END PGP SIGNATURE-----

--Sig_/=hHZ3caoYqlURl//xTiVaAQ--

