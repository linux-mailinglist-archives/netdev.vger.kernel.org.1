Return-Path: <netdev+bounces-85601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260A189B8F6
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 09:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BB9283EBE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 07:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755703D54C;
	Mon,  8 Apr 2024 07:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F22C68C
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562196; cv=none; b=mBeGtmwyPcGiAMb4pXiMVEDFkZWAHOoySvHHDWPxR9KreGEFmMTOTfKzLE27xS97O5AneXM3aHJ3pMcZ9nYsQDVYvy3H44E3dcut+cqk/PLT/wss7lEKI77rfhGMJgoG/+xlSp1TkHWWkMZwZRNDoG52WEOvm04m30pyMdqlO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562196; c=relaxed/simple;
	bh=F9lZ5xpFdq7EGLEX91lMdfTvpLrwdTPZesguOV+jWqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQJHOmJa3Epnuvw0zXx67LbXFfJqVp1hD/8+l6QVHBuZ7GofAwHWYJyr/RZMiaWEklRORa2WVpri4bFtycttdjCPpNA0A/6M1g/qIvnldRDsHB2RgbzV+heSUrVFmdQJE5uTvtHbfeuX7fAbk5HEPqhXtXXCk9HhqrEASXXxwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rtjep-0003xj-Rt; Mon, 08 Apr 2024 09:43:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rtjep-00B4Ir-Aa; Mon, 08 Apr 2024 09:43:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rtjep-00G41v-0k;
	Mon, 08 Apr 2024 09:43:11 +0200
Date: Mon, 8 Apr 2024 09:43:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>, 
	kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Zhang Wei also unreachable working
Message-ID: <zj6uueuu4c2vpjgg23r2lmqlleg4o6uxn4b7xlegcios23ifx5@ttom2yzyke2h>
References: <20240405072042.697182-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mrcj7cuohzw5kahh"
Content-Disposition: inline
In-Reply-To: <20240405072042.697182-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--mrcj7cuohzw5kahh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 09:20:41AM +0200, Uwe Kleine-K=F6nig wrote:
> -M:	Li Yang <leoyang.li@nxp.com>
>  M:	Zhang Wei <zw@zh-kernel.org>

This address of Zhang Wei doesn't seem to work either.

zh-kernel.org doesn't have an MX in DNS, the host behind its A entry
doesn't react to pings and connection attempts to tcp port 25 time out.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mrcj7cuohzw5kahh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYToA4ACgkQj4D7WH0S
/k65PAgAlzOGcV34Muztc48A4sK3thMx4xmK2GT3dLVR5K1QiaydY2gSBO8onaei
iZPOJGypivVIWUqaBhsuuZmBAnqvSeQ2b1NvKlq/8APDmqPz6igTYdS9vTIxp26C
VcIFqbqkQXNp2KIXgpktaZfOvAAZpwIN3w23tGgHDgRgTh57KvvDssMuOlbu181v
G5flqP4+LXYZKkDWMmQbEpkwktRdZk1sfQxJaTTQYVuY1ByaNncw9hzCrMCqL8WO
bXGl7J+ClwXN0kLXZCkNlCRWvTrPMFrZAlvSnLY+H7STK3Zpmxh+LeAtAHxwYTFN
+GXJHCHxAemst04lXyi5pyCzibQ1Cg==
=XE4m
-----END PGP SIGNATURE-----

--mrcj7cuohzw5kahh--

