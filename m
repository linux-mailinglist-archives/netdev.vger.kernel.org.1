Return-Path: <netdev+bounces-213247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C407DB243D1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164E318837A1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3B2D5A13;
	Wed, 13 Aug 2025 08:12:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6375C2D1929
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072731; cv=none; b=ekC1q7YGntr0kOE+GALEXKtt1iZKpYV2u8BPd+9YTlXUWoXzHkbP7pipo1ARsPDLGU9/w4WXci9hAL/W32+ZkeLmkZGx34GUOQgiPOHCcrLCKukY+8BeXhYeWjtusz8Zcv/KKnvu5rG/Nrk8m2tvO80x80gTlGzD/RczZHnV49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072731; c=relaxed/simple;
	bh=0B6qV1B9+5tUu8+Y5Sbg4RQpVXyoRlr0I/SHb97S56A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNwwJh+UZv7DC+VJCw8DhgtPzyQ5H8TZ96gukq/ml3QrdcsTIBI2rQaujxONMDag/9NzmrdRRrDI0D5pSVz594LabTsqffBUw97p04BrSIcCKC64VgVGQSPvXVf7fBorqEE+0qFoU/f+dRYpzi/AATKA5H/gijtvtZ6ESQOD1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6aa-0001sN-4P; Wed, 13 Aug 2025 10:12:04 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6aZ-0003lE-2E;
	Wed, 13 Aug 2025 10:12:03 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6211745686C;
	Wed, 13 Aug 2025 08:12:03 +0000 (UTC)
Date: Wed, 13 Aug 2025 10:12:03 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Olivier Sobrie <olivier@sobrie.be>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 5/6] can: esd_usb: Rework display of error messages
Message-ID: <20250813-small-pampas-deer-ca14d9-mkl@pengutronix.de>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
 <20250811210611.3233202-6-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aarltglf5oyoqc6b"
Content-Disposition: inline
In-Reply-To: <20250811210611.3233202-6-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--aarltglf5oyoqc6b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] can: esd_usb: Rework display of error messages
MIME-Version: 1.0

On 11.08.2025 23:06:10, Stefan M=C3=A4tje wrote:
> - esd_usb_open(): Get rid of duplicate "couldn't start device: %d\n"
>   message already printed from esd_usb_start().
> - Added the printout of error codes together with the error messages
>   in esd_usb_close() and some in esd_usb_probe(). The additional error
>   codes should lead to a better understanding what is really going
>   wrong.
> - Fix duplicate printout of network device name when network device
>   is registered. Add an unregister message for the network device
>   as counterpart to the register message.

If you want to print errors, please use '"%pE", ERR_PTR(err)', that will
decode the error code into human readable form.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--aarltglf5oyoqc6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicSNAACgkQDHRl3/mQ
kZyXoggAjSBpS9KdE78b4xR5jwWwggECg1mVZjXVEJ80Zj1FyLoqEAuSPBUBXymF
BS1uwcwm0KP4IxeEsdxDoCVXVyOFFpskJfn6Dia30uZtZbKAyOIzDzv4KI2e14fh
2n6/FGdXih1JhrsTqCOFlp5zjC+EUJY3zRmDm7Ng0SkJkvwzc2wijvsMwhBEg1VX
UdnKSYSe3J9+C0O7gN3BlkWhxpV2f9WebbSgL47WcfMH/iiwLGXaYcT090mvaiFQ
eFcf/fLHgLFgaPxJhrq6JX/DFzYAbVjGMZ2HgqnzrcE/FccnANuufoNXdRylNm3b
Z8Pl9hcNpc6Ad6IoHkBIWW9IaJ9cHg==
=/Gie
-----END PGP SIGNATURE-----

--aarltglf5oyoqc6b--

