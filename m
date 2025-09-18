Return-Path: <netdev+bounces-221616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC39CB5139F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B69E14E2A05
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA0830DEBC;
	Wed, 10 Sep 2025 10:14:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF19234984
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499246; cv=none; b=pQ6MVTlBLqTTbgbnlzP5RyNgbPxI9nQL7n74VV6BveGTDSNoaDyPongnirkxUnfBPoX3O6qJojlGatBHhpfPi2RlIUXMVsGSnSq8nAMu05BkkvyLi8oLUoSMkyvE5BbPAKoGCqM8SPmpeAgztBXdVW11Xvcsk8y/VAhN/rb1rvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499246; c=relaxed/simple;
	bh=GqYWyDv1x6IoCzQH5mrRff7z5fp/bH2Btzc6wytsFh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWOz4Tm+vX47S4pIwgaftYvQGhvwZigTGcPTbuoPEX1FAFuiJJAw4TOSQxhCbyTcDNdptUK2kvc7Bs3/MoncO84pbaQGfBFsfcjQrRqRo/UDIk9gp3Mr3iGvjxzHM0qe8L9SMe3GXsGaKbVKVWHMtjASzU2LLlMuqzt32bl+T3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwHpv-0004Fv-DW; Wed, 10 Sep 2025 12:13:59 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwHpu-000Zh9-1S;
	Wed, 10 Sep 2025 12:13:58 +0200
Received: from pengutronix.de (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 15D5A46AD3E;
	Wed, 10 Sep 2025 10:13:58 +0000 (UTC)
Date: Wed, 10 Sep 2025 12:13:57 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/7] pull-request: can 2025-09-09
Message-ID: <20250910-dainty-cockatoo-of-conversion-2b1f38-mkl@pengutronix.de>
References: <20250909134840.783785-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="duh7rqp3fmrea3lo"
Content-Disposition: inline
In-Reply-To: <20250909134840.783785-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--duh7rqp3fmrea3lo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/7] pull-request: can 2025-09-09
MIME-Version: 1.0

On 09.09.2025 15:34:53, Marc Kleine-Budde wrote:
> Hello netdev-team,

> Davide Caratti's patch enabled the VCAN driver as a module for the
> Linux self tests.

Please do not pull, as a network self-test will break.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--duh7rqp3fmrea3lo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjBT2IACgkQDHRl3/mQ
kZw+DAf7BQjYWrZVtmzpWJCUDAi5plE4sh9FgFNWCKXY4zqduRz1SOs1UjAkxZpu
Ho/GnKIwRjDNbL6pK5rXLyLyv8V9I6CoRugEbBXBJcCPOihyTeTAsnCk+ykg7vtR
tmYwc0qO6/FkFTOjtLYFYT1AU0V5F6ozWrW/aUXJ4XpBbKidJCive5psc1pg3WJT
bgrYmCS2nmyFkXyCT+k9EUvGfp27JCwkiD8710AdmcKZ+fvzGs0ALj4XA3jZsCoy
YjKU/b5+4nBk1SneW+MmnoakiHWn1xp+OALXkiKLPZQSv8FyBpCuw/wGpszOomjr
l99WZksaMobGrty0yDZ1lgYOZaDfOQ==
=B+wZ
-----END PGP SIGNATURE-----

--duh7rqp3fmrea3lo--

