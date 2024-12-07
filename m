Return-Path: <netdev+bounces-149890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743519E7F14
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 09:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E41280CDD
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BEB139CEF;
	Sat,  7 Dec 2024 08:44:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC3137742
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733561093; cv=none; b=Tk/dIeihp5dgMb2lO60Sh+jJnvxk3dJ1lsc7v9D0Y1BK7J048BDZOhSxxN57XkC95/cpHG32CSxwgbpd5UhUeCdpIJyVu9jdJzMpkQuNKn02NLA6WjlBUxD6EhcIrpjBrnpMd7siZ3tBnsZWsYqEs+/V1LhHf0PzCsmeoMTMHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733561093; c=relaxed/simple;
	bh=FAGwvwV2RNnyYTLRmILIZ0tK/g6VhGTVT1FpjdH2t40=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IzHmS2ESR+MmixpwzFFFApqpCnCDZdwVhQVaLUiIibSIwS/ThIIh+YfJIEvAXUTRrRxuHbKodBW3d8ZXOk1hZCENUNv3MOjQo1tK4HZhnxXRC3mVIHhTTDW5/uvdefP53EyxjuHraG6PlRIesbiXCeDtuod76Fmvo22tqUPoiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tJqQg-000ddJ-28
	for netdev@vger.kernel.org;
	Sat, 07 Dec 2024 09:44:46 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tJqQg-00000000t6V-0GAr
	for netdev@vger.kernel.org;
	Sat, 07 Dec 2024 09:44:46 +0100
Date: Sat, 7 Dec 2024 09:44:46 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: netdev@vger.kernel.org
Subject: KSZ8795 fixes for v5.15
Message-ID: <uz5k4wl4fka3rxoz2tkvpogiwblokbpo72p3sdjdbakwgfbwfi@bzxazuhkhbps>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="asvfvy3rqho223ha"
Content-Disposition: inline


--asvfvy3rqho223ha
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="kshmzgqoqt7iyoam"
Content-Disposition: inline
Subject: KSZ8795 fixes for v5.15
MIME-Version: 1.0


--kshmzgqoqt7iyoam
Content-Type: text/plain; charset=utf-8; protected-headers=v1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

it's me again with the KSZ8795 connected to TI_DAVINCI_EMAC. It works on
v5.10.227 and now, I try to get this working on v5.15 (and then later
versions). I found this patch [1] in the Microchip forum [2]. Someone put it
together to make this chip work with v5.15. I applies fine on v5.15.173 and
gets me to a point where the kernel detects the chip during boot. (It still
doesn't work, but it's better with this patch than without.)

[1] https://forum.microchip.com/sfc/servlet.shepherd/document/download/0693=
l00000XiIt9AAF
[2] https://forum.microchip.com/s/topic/a5C3l000000MfQkEAK/t388621

The driver code was restructured in 9f73e1 which contained some mistakes.
These were fixed later with 4bdf79 (which is part of the patch), but was not
backported to v5.15 as a grep shows:

$ git grep STATIC_MAC_TABLE_OVERRIDE'.*2[26]' v5.15.173
v5.15.173:drivers/net/dsa/microchip/ksz8795.c:55:       [STATIC_MAC_TABLE_O=
VERRIDE]     =3D BIT(26),
$ git grep STATIC_MAC_TABLE_OVERRIDE'.*2[26]' v6.6.62
v6.6.62:drivers/net/dsa/microchip/ksz_common.c:334:     [STATIC_MAC_TABLE_O=
VERRIDE]     =3D BIT(22),

Can someone review this patch and apply it to the v5.15 branch?


commit 9f73e11250fb3948a8599d72318951d5e93b1eaf
Author: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date:   Tue Apr 27 09:09:03 2021 +0200

    net: dsa: microchip: ksz8795: move register offsets and shifts to separ=
ate struct

    In order to get this driver used with other switches the functions need
    to use different offsets and register shifts. This patch changes the
    direct use of the register defines to register description structures,
    which can be set depending on the chips register layout.

    Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
    Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

commit 4bdf79d686b49ac49373b36466acfb93972c7d7c
Author: Tristram Ha <Tristram.Ha@microchip.com>
Date:   Thu Jul 13 17:46:22 2023 -0700

    net: dsa: microchip: correct KSZ8795 static MAC table access

    The KSZ8795 driver code was modified to use on KSZ8863/73, which has
    different register definitions.  Some of the new KSZ8795 register
    information are wrong compared to previous code.

    KSZ8795 also behaves differently in that the STATIC_MAC_TABLE_USE_FID
    and STATIC_MAC_TABLE_FID bits are off by 1 when doing MAC table reading
    than writing.  To compensate that a special code was added to shift the
    register value by 1 before applying those bits.  This is wrong when the
    code is running on KSZ8863, so this special code is only executed when
    KSZ8795 is detected.

    Fixes: 4b20a07e103f ("net: dsa: microchip: ksz8795: add support for ksz=
88xx chips")
    Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
    Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
    Reviewed-by: Simon Horman <simon.horman@corigine.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>


Kind regards, J=C3=B6rg

--=20
=E2=80=9CComputer games don't affect kids. If Pacman would have affected us=
 as
children, we would now run around in darkened rooms, munching yellow
pills and listening to repetetive music.=E2=80=9D

--kshmzgqoqt7iyoam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="1227121-0001-ksz8795-Fix-b...ss-table.patch.txt"
Content-Transfer-Encoding: quoted-printable

=46rom 177cc71eb0eec54a29b75e2e922e5fbc233fe68d Mon Sep 17 00:00:00 2001
=46rom: Craig McQueen <craig.mcqueen@innerrange.com>
Date: Tue, 10 Jan 2023 17:16:37 +1100
Subject: [PATCH] ksz8795: Fix bit offsets for static MAC address table

Refer to KSZ8795CLX data sheet, Microchip document DS00002112E, section
4.4 "Static MAC Address Table", table 4-16.

Unusually, the bit locations of the "FID" and "Use FID" fields are
different for reads and writes.

For KSZ8863 (not needed for T4000 Pro but done for completeness), refer
to KSZ8863 data sheet, Microchip document DS00002335C, section 4.6
"Static MAC Address Table", table 4-10.

This is for Inner Range YouTrack item:
T4000PRO-255 LAN2 was not working with the expected IP address range
---
 drivers/net/dsa/microchip/ksz8.h    |  9 +++++---
 drivers/net/dsa/microchip/ksz8795.c | 32 +++++++++++++++++------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/k=
sz8.h
index 9d611895d3cf..bb98cc3d89f6 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -34,8 +34,10 @@ enum ksz_masks {
 	VLAN_TABLE_MEMBERSHIP,
 	VLAN_TABLE_VALID,
 	STATIC_MAC_TABLE_VALID,
-	STATIC_MAC_TABLE_USE_FID,
-	STATIC_MAC_TABLE_FID,
+	STATIC_MAC_TABLE_USE_FID_R,
+	STATIC_MAC_TABLE_USE_FID_W,
+	STATIC_MAC_TABLE_FID_R,
+	STATIC_MAC_TABLE_FID_W,
 	STATIC_MAC_TABLE_OVERRIDE,
 	STATIC_MAC_TABLE_FWD_PORTS,
 	DYNAMIC_MAC_TABLE_ENTRIES_H,
@@ -51,7 +53,8 @@ enum ksz_shifts {
 	VLAN_TABLE_MEMBERSHIP_S,
 	VLAN_TABLE,
 	STATIC_MAC_FWD_PORTS,
-	STATIC_MAC_FID,
+	STATIC_MAC_FID_R,
+	STATIC_MAC_FID_W,
 	DYNAMIC_MAC_ENTRIES_H,
 	DYNAMIC_MAC_ENTRIES,
 	DYNAMIC_MAC_FID,
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchi=
p/ksz8795.c
index c9c682352ac3..3c6fee9db038 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -50,10 +50,12 @@ static const u32 ksz8795_masks[] =3D {
 	[VLAN_TABLE_MEMBERSHIP]		=3D GENMASK(11, 7),
 	[VLAN_TABLE_VALID]		=3D BIT(12),
 	[STATIC_MAC_TABLE_VALID]	=3D BIT(21),
-	[STATIC_MAC_TABLE_USE_FID]	=3D BIT(23),
-	[STATIC_MAC_TABLE_FID]		=3D GENMASK(30, 24),
-	[STATIC_MAC_TABLE_OVERRIDE]	=3D BIT(26),
-	[STATIC_MAC_TABLE_FWD_PORTS]	=3D GENMASK(24, 20),
+	[STATIC_MAC_TABLE_USE_FID_R]	=3D BIT(24),
+	[STATIC_MAC_TABLE_USE_FID_W]	=3D BIT(23),
+	[STATIC_MAC_TABLE_FID_R]	=3D GENMASK(31, 25),
+	[STATIC_MAC_TABLE_FID_W]	=3D GENMASK(30, 24),
+	[STATIC_MAC_TABLE_OVERRIDE]	=3D BIT(22),
+	[STATIC_MAC_TABLE_FWD_PORTS]	=3D GENMASK(20, 16),
 	[DYNAMIC_MAC_TABLE_ENTRIES_H]	=3D GENMASK(6, 0),
 	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	=3D BIT(8),
 	[DYNAMIC_MAC_TABLE_NOT_READY]	=3D BIT(7),
@@ -67,7 +69,8 @@ static const u8 ksz8795_shifts[] =3D {
 	[VLAN_TABLE_MEMBERSHIP_S]	=3D 7,
 	[VLAN_TABLE]			=3D 16,
 	[STATIC_MAC_FWD_PORTS]		=3D 16,
-	[STATIC_MAC_FID]		=3D 24,
+	[STATIC_MAC_FID_R]		=3D 25,
+	[STATIC_MAC_FID_W]		=3D 24,
 	[DYNAMIC_MAC_ENTRIES_H]		=3D 3,
 	[DYNAMIC_MAC_ENTRIES]		=3D 29,
 	[DYNAMIC_MAC_FID]		=3D 16,
@@ -100,8 +103,10 @@ static const u32 ksz8863_masks[] =3D {
 	[VLAN_TABLE_MEMBERSHIP]		=3D GENMASK(18, 16),
 	[VLAN_TABLE_VALID]		=3D BIT(19),
 	[STATIC_MAC_TABLE_VALID]	=3D BIT(19),
-	[STATIC_MAC_TABLE_USE_FID]	=3D BIT(21),
-	[STATIC_MAC_TABLE_FID]		=3D GENMASK(29, 26),
+	[STATIC_MAC_TABLE_USE_FID_R]	=3D BIT(21),
+	[STATIC_MAC_TABLE_USE_FID_W]	=3D BIT(21),
+	[STATIC_MAC_TABLE_FID_R]	=3D GENMASK(25, 22),
+	[STATIC_MAC_TABLE_FID_W]	=3D GENMASK(25, 22),
 	[STATIC_MAC_TABLE_OVERRIDE]	=3D BIT(20),
 	[STATIC_MAC_TABLE_FWD_PORTS]	=3D GENMASK(18, 16),
 	[DYNAMIC_MAC_TABLE_ENTRIES_H]	=3D GENMASK(5, 0),
@@ -116,7 +121,8 @@ static const u32 ksz8863_masks[] =3D {
 static u8 ksz8863_shifts[] =3D {
 	[VLAN_TABLE_MEMBERSHIP_S]	=3D 16,
 	[STATIC_MAC_FWD_PORTS]		=3D 16,
-	[STATIC_MAC_FID]		=3D 22,
+	[STATIC_MAC_FID_R]		=3D 22,
+	[STATIC_MAC_FID_W]		=3D 22,
 	[DYNAMIC_MAC_ENTRIES_H]		=3D 3,
 	[DYNAMIC_MAC_ENTRIES]		=3D 24,
 	[DYNAMIC_MAC_FID]		=3D 16,
@@ -604,9 +610,9 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev,=
 u16 addr,
 		data_hi >>=3D 1;
 		alu->is_static =3D true;
 		alu->is_use_fid =3D
-			(data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
-		alu->fid =3D (data_hi & masks[STATIC_MAC_TABLE_FID]) >>
-				shifts[STATIC_MAC_FID];
+			(data_hi & masks[STATIC_MAC_TABLE_USE_FID_R]) ? 1 : 0;
+		alu->fid =3D (data_hi & masks[STATIC_MAC_TABLE_FID_R]) >>
+				shifts[STATIC_MAC_FID_R];
 		return 0;
 	}
 	return -ENXIO;
@@ -633,8 +639,8 @@ static void ksz8_w_sta_mac_table(struct ksz_device *dev=
, u16 addr,
 	if (alu->is_override)
 		data_hi |=3D masks[STATIC_MAC_TABLE_OVERRIDE];
 	if (alu->is_use_fid) {
-		data_hi |=3D masks[STATIC_MAC_TABLE_USE_FID];
-		data_hi |=3D (u32)alu->fid << shifts[STATIC_MAC_FID];
+		data_hi |=3D masks[STATIC_MAC_TABLE_USE_FID_W];
+		data_hi |=3D ((u32)alu->fid << shifts[STATIC_MAC_FID_W]) & masks[STATIC_=
MAC_TABLE_FID_W];
 	}
 	if (alu->is_static)
 		data_hi |=3D masks[STATIC_MAC_TABLE_VALID];
--=20
2.39.2


--kshmzgqoqt7iyoam--

--asvfvy3rqho223ha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ1QK9QAKCRB9LJoj0a6j
da+9AP9Bfkyb6l3rEo18Iausutsn3GgkZ4I9+gaTd3Cq3bkATAD9FhLd66B1ovlj
lsyQYJnJUIwXX8RLpaEWxld+UPZX39E=
=wQEo
-----END PGP SIGNATURE-----

--asvfvy3rqho223ha--

