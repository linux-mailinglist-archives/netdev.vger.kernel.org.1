Return-Path: <netdev+bounces-224809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF11B8ACCF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D28C4E066B
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AFE31FEE7;
	Fri, 19 Sep 2025 17:45:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E9221544
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303955; cv=none; b=mEy259SuIQxUUpj4Brg0CWczKwpWEoUK0Zx7h1oWlI5Mmhs1r3UvCgf5pLwLDK7BXWmBj5VFYGne1l1t5WQOUgIKSSdLdKtny+RgL7nFmmkvATWVF9HFwqLNuqf1WOzVdrkDoffFVoyitFWwfFf7j81sFiUOxn5R2pYlOJAfkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303955; c=relaxed/simple;
	bh=/JudEsI7b2OQK8tF56WIc51qIDfXRiKNt5v/maHEzYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3n3A5SjdlM6t5cFqazCnjpXjYeHQtvyFk9sNZRH8PWeknK4ZzgCrdaUmWxYo2RFd3FOv55ydoHhgdJyRS6sTmDcJTUD/2C7lX0iB1IyeSmL3cl3rYjKOw6wf2pxj9IqMY3EMMjzYII3bttu19IWCtTxQUizYR18Ga10fMk3R6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzfAz-0006Ql-Ch; Fri, 19 Sep 2025 19:45:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzfAy-0028w5-0V;
	Fri, 19 Sep 2025 19:45:40 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E42414750FF;
	Fri, 19 Sep 2025 17:45:38 +0000 (UTC)
Date: Fri, 19 Sep 2025 19:45:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/5] can: esd_usb: Fixes and improvements
Message-ID: <20250919-esoteric-zebra-of-glamour-c6807f-mkl@pengutronix.de>
References: <20250821143422.3567029-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gppkr56zu5ek666e"
Content-Disposition: inline
In-Reply-To: <20250821143422.3567029-1-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--gppkr56zu5ek666e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/5] can: esd_usb: Fixes and improvements
MIME-Version: 1.0

On 21.08.2025 16:34:17, Stefan M=C3=A4tje wrote:
> The first patch fixes a condition where the esd_usb CAN driver
> may not detect connected CAN-USB devices correctly after a
> reboot. This patch was already presented on the list before
> starting this series and changes due to that feedback are
> integrated.
>=20
> References:
> https://lore.kernel.org/linux-can/d7fd564775351ea8a60a6ada83a0368a99ea6b1=
9.camel@esd.eu/
>=20
> The second patch fixes situations where the the handling of TX
> context objects for each sent CAN frame could go out of sync
> with the acknowledged or erroneous TX jobs and then lose free
> TX context objects. This could lead to the driver incapable of
> sending frames.
>=20
> The third patch adds TX FIFO watermark to eliminate occasional
> error messages and significantly reduce the number of calls to
> netif_start_queue() and netif_stop_queue().

Applied patches 1...3 to linux-can as these are fixes.

Thank you for the very detailed description of the patches, I really
appreciate this! While applying I've changed some sentences to more
imperative wording, e.g. "Moved the code" -> "Move the code".

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gppkr56zu5ek666e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNlr4ACgkQDHRl3/mQ
kZyFVwf/T9GnKtYPTwhsVoFyU3dxOtS2DMVEp6KBUxwuko7knSpB7zKJu6bdUUvm
uIXbFiNMq5z/Adw8794Tmty7AbWXkWH/joCnPtlXQo2AMzyMJQxE9a1kM5MeSCd4
H2wURfuXqrrL6OCFMzCEJxa5m7xPU7GVoGDnar3QTXCw5kERU3e9yQNFrKpnf3V6
pMUudHB+ESUxv/0Pi89BY47j7pWD//ScVPZkzADdbItxpOYVNrftyN5TGYNMcToC
v14tbCkI3DMjHLQ3ecY2zOGV5AqWQ2218+gjKunNZv0idD/+j1bo3jocswPeHFnn
lWzueKEtHY+felfnJNtZode6X1lZ3w==
=Kwdz
-----END PGP SIGNATURE-----

--gppkr56zu5ek666e--

