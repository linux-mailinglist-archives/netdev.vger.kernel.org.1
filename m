Return-Path: <netdev+bounces-86414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED2289EB14
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A370D1F251D6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0291773D;
	Wed, 10 Apr 2024 06:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE784282F0
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731340; cv=none; b=GH+K5xz9M9db92ZD2gGiGsdOivCzthw83FCK/AEGN5a6vKjbzW+TqMAsmrOBylmDzrxvUZ0dZd1d/3zBkwOOtno3kdcROITLic7a/qOToq+vH3yqyfEsyu8GOdqnYvCa97e8Iv0PF9FguAUaDB1rlVMdLw+PH7CmYCpkZOKUcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731340; c=relaxed/simple;
	bh=Cs3AN10fbloFb5LwNxDZICKSsWcJTWJYVX+QSmCObYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMEPQmX8jCC2QncevYIK+k5SiWWznQPU2xRxJE2oqEKS65uPzMsunCp0xBxmtMbDk0YdIE/IzPbot1bsiD5DTB7MWUdCqUmBzml9C8n2NuvwgTA9H8r6aEuudxEx6Ydw7XHh56iZ+npDj7I5d8hc0oR6eM7Wyw6pVBCjLv3JRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruReq-0007RM-FZ; Wed, 10 Apr 2024 08:42:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruReo-00BRVQ-DH; Wed, 10 Apr 2024 08:42:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruReo-00HOKB-0z;
	Wed, 10 Apr 2024 08:42:06 +0200
Date: Wed, 10 Apr 2024 08:42:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>, 
	kernel@pengutronix.de, netdev@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Drop Li Yang as their email address stopped
 working
Message-ID: <u4bhjzjr4jjx26r3r4jupqd5u273xsvuyfzq5ecv6binoyoqzq@5zib23vgtlsx>
References: <20240405072042.697182-2-u.kleine-koenig@pengutronix.de>
 <20240409144204.00cc76ce@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qezoggtwtmgqqqvk"
Content-Disposition: inline
In-Reply-To: <20240409144204.00cc76ce@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--qezoggtwtmgqqqvk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 02:42:04PM -0700, Jakub Kicinski wrote:
> On Fri,  5 Apr 2024 09:20:41 +0200 Uwe Kleine-K=F6nig wrote:
> > When sending a patch to (among others) Li Yang the nxp MTA replied that
> > the address doesn't exist and so the mail couldn't be delivered. The
> > error code was 550, so at least technically that's not a temporal issue.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> FWIW it's eaac25d026a1 in net, thanks!

Greg also picked it up, it's fbdd90334a6205e8a99d0bc2dfc738ee438f00bc in
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-linus
=2E Both are included in next-20240410. I guess that's not a big problem.
(And please prevent that the patch is dropped from both trees as it's
already included in the other :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qezoggtwtmgqqqvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYWNL0ACgkQj4D7WH0S
/k5wNAf+MJDdbm33k3wubemVjjqKUK3f6FxXQe4t7lCMtz5sI0KpYVCrJhtHd0LK
Ml2eGbqb9oiNe5Uzf+DtMLAfrEGD0nKi4ILU18nmZwIGgqDslReXcKGZgbHZ0VMU
/HvqSZfEi+ePr+n7yZ4rF2bdpwzrUsJjRpqsUKqhB3OsZep3zgXjOeedd+g3vtXR
RBMcHTVhin3cVtMV3HoXfL7IDqL2S9tvRLxovSxZGHnCYbnZwS2jEuk6oyx9AwXh
ykjeo7C+PNBKzDUsLfwqk9GwKBzeMeRxsjCvhQpls8uzKJJEPUfEsmcuv8geHk4b
BEKAyo3PsJjIffwle960ADMQG+Xqig==
=bfVT
-----END PGP SIGNATURE-----

--qezoggtwtmgqqqvk--

