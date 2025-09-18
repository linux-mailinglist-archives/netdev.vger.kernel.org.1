Return-Path: <netdev+bounces-213251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3378DB243E6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DBB58040D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE52D6419;
	Wed, 13 Aug 2025 08:14:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB32C3770
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072878; cv=none; b=eZi/Yc2X7FlsNGum2WtMoKH96XoxQsxw68yySvvPyxarw6FcY0o18jtHxgsO24Vir/ZMbL/UP2EHXiA2BcWnDHbzqsUhnKU2HDEIEi06Ls4kCREQrFWsH2p7/3xKToMGf04jnrtJFvBl8DwmtZ3u4kAD6TUJ7rKoSZeuSrQ4cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072878; c=relaxed/simple;
	bh=ei/eQ26fEjzT+NtMiND/jOXKZ7w2D1SFMnkuZfYcbl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz2IbGOeDHY0TKklE8fbX2l77sTFxsAPd3wWkKyk8H8D99LX5Bq20ttdKPOrsttE9k44VyvIWwrpPXWhG5ME7TFmRLkrpiKTJEtTg1J7dWSpb1hsHfdwNzwmJ7Cbg5Ka3s7HhVZF9rauEMD+1dvZukajI8rlUGMMTZwON6NwGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6cv-0002FN-A2; Wed, 13 Aug 2025 10:14:29 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6cv-0003lf-06;
	Wed, 13 Aug 2025 10:14:29 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BD60845687D;
	Wed, 13 Aug 2025 08:14:28 +0000 (UTC)
Date: Wed, 13 Aug 2025 10:14:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Olivier Sobrie <olivier@sobrie.be>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 3/6] can: esd_usb: Fix handling of TX context objects
Message-ID: <20250813-translucent-turkey-of-force-96bb34-mkl@pengutronix.de>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
 <20250811210611.3233202-4-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rxn6fchz6q4l23vs"
Content-Disposition: inline
In-Reply-To: <20250811210611.3233202-4-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--rxn6fchz6q4l23vs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/6] can: esd_usb: Fix handling of TX context objects
MIME-Version: 1.0

On 11.08.2025 23:06:08, Stefan M=C3=A4tje wrote:
> For each TX CAN frame submitted to the USB device the driver saves the
> echo skb index in struct esd_tx_urb_context context objects. If the
> driver runs out of free context objects CAN transmission stops.
>=20
> This patch fixes some spots where such context objects are not freed
> correctly.
>=20
> In esd_usb_tx_done_msg() the check for netif_device_present() is moved
> after the identification and release of TX context and the release of
> the echo skb. This is allowed even if netif_device_present() would
> return false because the mentioned operations don't touch the device
> itself but only free local acquired resources. This keeps the context
> handling with the acknowledged TX jobs in sync.
>=20
> In esd_usb_start_xmit() a check is performed to see whether a context
> object could be allocated. Added a netif_stop_queue() there before the
> function is aborted. This makes sure the network queue is stopped and
> avoids getting tons of log messages in a situation without free TX
> objects. The adjacent log message now also prints the active jobs
> counter making a cross check between active jobs and "no free context"
> condition possible.
>=20
> In esd_usb_start_xmit() the error handling of usb_submit_urb() missed to
> free the context object together with the echo skb and decreasing the
> job count.
>=20
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>

Please add a Fixes tag.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rxn6fchz6q4l23vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicSWIACgkQDHRl3/mQ
kZxdyAf9FoePofooqOk+YI2l2Ih86wPeHW6geUxn3cLrjGYQkQhYG6X3WZUfgkVL
lVyYvUGxto7vHQzanLzmmYtjCruyhJcFNqpzQqdtnnFb1g3GUw26dBUTEp7S4EWU
+sWlNP0BjNNA0E9wDiDmOXDTDZ4q4jWf+iutcSXwpbCMu4hcVKyPVJ22YQeeLwN3
STaF+VrADo39Nc1vAYRW8fgvO+vnxUXakeVxPGdyBfH4KrGFBoYVthToAaNLKVMi
DcRkUJwIe2KRSO4tQF9nbor1GWeA3LBAALXXB+x/klym0ZTfrLOaKaJgY19utEDS
NuyQY9hY3IBFZJ5VnVGB/BqNDPI30A==
=82/A
-----END PGP SIGNATURE-----

--rxn6fchz6q4l23vs--

