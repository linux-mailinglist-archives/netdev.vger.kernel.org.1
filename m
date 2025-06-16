Return-Path: <netdev+bounces-198123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE21BADB547
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B22C171742
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCFD2586DA;
	Mon, 16 Jun 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="R8RVU+Me"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D0213E94
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087511; cv=none; b=EVn1MXLlBgN8phpIezSNeEp0MXNKpPskhVznAd/1HdiR/1F4rOKqqH++mwo1+0CHnlsFr+an5WjxIIg6ZrvdwRo9fxP7ckaQEXUTDDRtevMPV2xaifr1RHuoJ412YU3XFGiAqaBCJdfB363PWO1lkyfJoS4Ghqv2JDgn375vOnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087511; c=relaxed/simple;
	bh=FlyZkFl7LpoVy3OKa2hgCDDFftvJIX054O6swPGQNnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OErf7dfs8/i9tpRJpkg3w+4+r6p8twjsAwKfmcgOGItwzweR85v6rZiinOGOjwDZjDW51kogujwgyvmzkzDHDhZLtHcPU8IlVWDisYkvNDtgMbfYp05SJN188nZ0VrOxgxLx0gysjbm35uT3HY+KNw83EtK392nmJxjIPhIs3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=R8RVU+Me; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C697D103972B9;
	Mon, 16 Jun 2025 17:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750087506; h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=2DIfhL9pfWm6lrcnVPZuybhVNZ7vu2uc2P0l3Gd6m60=;
	b=R8RVU+MeT/vM9ctqL0A/QRozQrggf4MtG5kDXHURjSpp/GUqYDiR3Zjf4zS3neY7LRho6X
	YNVfgll0oY3/jDBeF3TF07e6ABC8F71vCTx+oKQhORsAOVlqOm/jyd7r96PBcOBVJoiMAe
	YrGt1j3XqzqfNNlzcjZ96WWNlgJ/ShV5Jzjqi5WZD+laxwkSyfjPWPN2S1vDWCquP3biKq
	T5Z4Xrtyhp8y0qv/njxHcoXwP45OsYvnkcZd20ZPORBzi5V1pRQ8bOVx759qocBh2P+JU0
	4dRkJ9r1BrkVwdZFvDjtjmKxcqjvIVMvt3JljEe257yS1myOVF2Hh2GxI1w/eg==
Date: Mon, 16 Jun 2025 17:25:01 +0200
From: Lukasz Majewski <lukma@denx.de>
To: netdev@vger.kernel.org
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>, Vladimir Oltean
 <olteanv@gmail.com>, Oleksij Rempel  <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Richard Cochran <richardcochran@gmail.com>,
 Christian Eggers <ceggers@arri.de>
Subject: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
Message-ID: <20250616172501.00ea80c4@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.trCdUYcMVibQ9O9aIP1MQY";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/.trCdUYcMVibQ9O9aIP1MQY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

As of [1] KSZ drivers support HW timestamping HWTSTAMP_TX_ONESTEP_P2P.
When used with ptp4l (config [2]) I'm able to see that two boards with
KSZ9477 can communicate and one of them is a grandmaster device.

This is OK (/dev/ptp0 is created and works properly).

=46rom what I have understood - the device which supports p2p1step also
supports "older" approaches, so communication with other HW shall be
possible.

Hence the questions:

1. Would it be possible to communicate with beaglebone black (BBB)
connected to the same network?

root@BeagleBone:~# ethtool -T eth0
Hardware Transmit Timestamp Modes:
        off
        on
Hardware Receive Filter Modes:
        none
        ptpv2-event

My board:
# ethtool -T lan3
Hardware Transmit Timestamp Modes:
        off
        onestep-p2p
Hardware Receive Filter Modes:
        none
        ptpv2-l4-event
        ptpv2-l2-event
        ptpv2-event

(other fields are the same)

As I've stated above - onestep-p2p shall also support the "on" mode
from BBB.

The documentation of KSZ9477 states that:
- IEEE 1588v2 PTP and Clock Synchronization
- Transparent Clock (TC) with auto correction update
- Master and slave Ordinary Clock (OC) support
- End-to-end (E2E) or peer-to-peer (P2P)
- PTP multicast and unicast message support
- PTP message transport over IPv4/v6 and IEEE 802.3
- IEEE 1588v2 PTP packet filtering
- Synchronous Ethernet support via recovered clock

which looks like all PTP use cases (and other boards) for HW shall be
supported.

Is this a matter of not (yet) available in-driver support or do I need
to configure linuxptp in different way to have such support?



2. The master clock synchronization and calibration

On one board (grandmaster) (connected to lan3):
[1943.558]: port 0: INITIALIZING to LISTENING on INIT_COMPLETE
[1951.091]: port 1: LISTENING to MASTER on
ANNOUNCE_RECEIPT_TIMEOUT_EXPIRES
[1951.091]: selected local clock 824f12.fffe.110022 as best master
[1951.091]: port 1: assuming the grand master role

The other board:
[890.003]: port 1 (lan3): new foreign master 824f12.fffe.110022-1
[894.003]: selected best master clock 824f12.fffe.110022
[894.005]: port 1 (lan3): LISTENING to UNCALIBRATED on RS_SLAVE

The phc2sys -m -s lan3 shows some calibration...

CLOCK_REALTIME phc offset        65 s2 freq  -45509 delay 351557
CLOCK_REALTIME phc offset       591 s2 freq  -44964 delay 350475
CLOCK_REALTIME phc offset      -892 s2 freq  -46270 delay 350516
CLOCK_REALTIME phc offset    137456 s2 freq  +91811 delay 733784
CLOCK_REALTIME phc offset   -136987 s2 freq -141395 delay 350676
CLOCK_REALTIME phc offset    -41327 s2 freq  -86831 delay 350216
CLOCK_REALTIME phc offset        66 s2 freq  -57837 delay 350489
CLOCK_REALTIME phc offset     12037 s2 freq  -45846 delay 351854
CLOCK_REALTIME phc offset     12213 s2 freq  -42059 delay 350474
CLOCK_REALTIME phc offset      8984 s2 freq  -41624 delay 349682


but the "fluctuation" is too large to regard it as a "stable" and
precise source.

And probably hence it is "UNCALIBRATED" master clock.

Even more strange - the tshark -i lan3 -Y "ptp" -V

.... 1011 =3D messageId: Announce Message (0xb)
correction: 0.000000 nanoseconds                    =20
    correction: Ns: 0 nanoseconds                  =20
    correctionSubNs: 0 nanoseconds            =20

.... 0010 =3D messageId: Peer_Delay_Req Message (0x2)
    correction: 0.000000 nanoseconds
    correction: Ns: 0 nanoseconds
    correctionSubNs: 0 nanoseconds

shows always the correction value of 0 ns.
I do guess that it shall have some (different) values.

Any hints on fixing this problem?


3. Just to mention - I've found rather old conversation regarding PTP
support [3] on KSZ devices (but for KSZ9563)

And it looks like it has already been adopted to minline Linux.=20
Am I correct? Or is anything still missing (and hence I do see the two
described above issues)?

Thanks in advance for your help :-)

Links:

[1] -
https://elixir.bootlin.com/linux/v6.16-rc1/source/drivers/net/dsa/microchip=
/ksz_ptp.c#L293

[2] - config for PTP (/etc/ptp4l.conf):

cat /etc/ptp4l.conf    =20
[global]

#twoStepFlag 0   ->  set automatically in ptp4l
time_stamping p2p1step
slaveOnly 0/1
delay_mechanism P2P
delay_filter_length 100
tx_timestamp_timeout 100
network_transport L2

[3] -
https://patchwork.ozlabs.org/project/netdev/patch/20201019172435.4416-8-ceg=
gers@arri.de/#2570624

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/.trCdUYcMVibQ9O9aIP1MQY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhQN00ACgkQAR8vZIA0
zr37Mwf5AZNEprfXDeTnFKk2e27ER+vqEKxXAjtXOAh7clvIhM9W3pVB+A8e9BUM
wGzCw7Sky6O0ZRPaj/iREga5eQ4wbAeeHhsWUYfCKnFcf6jhrpI5GJNJrCajR6Fm
C+8uo3EAQunV9DPFL+Pf/prV0dz41N9lkjP9J1ejqlEM26JdMa6jYaKecvdV+oiS
MB5ib3fot88GMGAiPwfVaJV/23nAgm2/4+4xrF89WomzkYAOynNdwSbZCNr30i31
PSuNnH5ch2Efg9A7s3SLC62FhdZYcyPlEkT//rRNB3bU/+bYQoFNBqVanTAdyL1p
3earYm9Dyd8Q66Pv44Sluv7KdAvoXQ==
=Fi4q
-----END PGP SIGNATURE-----

--Sig_/.trCdUYcMVibQ9O9aIP1MQY--

