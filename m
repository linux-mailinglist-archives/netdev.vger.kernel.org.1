Return-Path: <netdev+bounces-127285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58A8974DC5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9042879BE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552EE153BE8;
	Wed, 11 Sep 2024 09:00:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97516EC1B
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045200; cv=none; b=BFAaiMb+qQe8OfkCprIxRv1ZX9jIqaEQZ1AzAajEMKh6VwN24DqTKaqmJq3ipcb1H346NVf4lWC6oQeE1ZSVrHNA9t2kmWEdXodgZI4aH/Y0hPRm0DVhS9m7RN33jW5wSoTTJM+GvsmythtDtQXNd0TDWzcZMA98FsUSzxtKABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045200; c=relaxed/simple;
	bh=VoH/z5zZCUpV+73SN7uB6Tby0WjoNb83prYqoOpBkuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWt8HKqm4g+rAAw+rq+br0DrVcOIcKxOTznEUApwoC++55LJR477W8Uhnce1V2/iMsWaImj+sTpxKtD9Kp6nSG/oJvuKQY05s6EkXe6xxBMCqcUxw0YHqDhcRispYahbn4dVHS+FiuprFyRw9BpwTj1+Iuo8wsiQwVyd+BTnPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soJCc-0000pv-2X; Wed, 11 Sep 2024 10:59:54 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soJCb-007687-6N; Wed, 11 Sep 2024 10:59:53 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DFD883381B7;
	Wed, 11 Sep 2024 08:59:52 +0000 (UTC)
Date: Wed, 11 Sep 2024 10:59:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] can: usb: Kconfig: Fix list of devices for esd_usb driver
Message-ID: <20240911-greedy-passionate-vulture-8de400-mkl@pengutronix.de>
References: <20240910170236.2287637-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kew5wn6prucpkfqy"
Content-Disposition: inline
In-Reply-To: <20240910170236.2287637-1-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--kew5wn6prucpkfqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.09.2024 19:02:36, Stefan M=C3=A4tje wrote:
> The CAN-USB/3-FD was missing on the list of supported devices.
>=20
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>

Applied to linux-can-testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kew5wn6prucpkfqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbhXAUACgkQKDiiPnot
vG/GWgf/dIFemA8P4T/OaztXyPAXL7oDQL0iHNSCrruSQO8A51NT2flRcLtq3WgW
+rG7QMWMooMo8tMBa+CJYMrKqo7Jz72ttJhDOeyUFcImVNPtd/HMI8lJcX6vOzLn
FzEX72tozZPkFWmnofEmgEUChiTJGX70CW8BR+y6tc58Lp94eyZN8kUOa1iMC0HC
SEZNfsZofBl1WOtxP3wu09BWqy0D74x1nDHVKV6lifkO15QI9qGQJpB9kev6NHWN
fuWk1VCTfYJEHiqYgRRS8bTI9D/lw7Ja+u+Njp+JA9pgTaPBBo09F/goe6H58io+
0Wr4+tSbEuISBUu62UzmhCsj/8fjuA==
=kVCE
-----END PGP SIGNATURE-----

--kew5wn6prucpkfqy--

