Return-Path: <netdev+bounces-123902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B79966C01
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 00:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D359F1C212EF
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9817ADFE;
	Fri, 30 Aug 2024 22:03:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647952AE84
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055434; cv=none; b=ruVbDR1pFmVE4K2jUqlfZ0aOtkHFTjOwHkHeuBOxC7s/W5Br+JfLYP+zjcHDONYU4wj3UfgY05DE0HJdwIEeiw2It072Xj9/uJBolV2qffVjgcQ5RpKRSHcxsEaHRPyIg27TVBt/FjR85Es2w/D+F8Pbsc/N9PIi7R689w3IGHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055434; c=relaxed/simple;
	bh=4bUqnW+G1QDzMf38UtJ5YT7+nBSIeuQ7oiAfyuD9ut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ/RCjMGF0MLXyKWQXU4AQfca8V9eABrqWKgSRHwnmoiS6J5BLLQo46slGHPQIn9hW10OkOnplRhXqFDiCoUpA+th+QBupjmHBSDuFs0YGckVSuNSXWz6s3lkYj8OZh5MbAMBlsSU1+kxgf5Qn4ZiXrhRthX4s59S2b71ucCzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9ib-00074Q-Se; Sat, 31 Aug 2024 00:03:45 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9ib-004Fq2-7F; Sat, 31 Aug 2024 00:03:45 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E464832E5B9;
	Fri, 30 Aug 2024 22:03:44 +0000 (UTC)
Date: Sat, 31 Aug 2024 00:03:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Martin Jocic <martin.jocic@kvaser.com>
Subject: Re: [PATCH net 13/13] can: kvaser_pciefd: Enable 64-bit DMA
 addressing
Message-ID: <20240830-cheerful-dinosaur-of-relaxation-a9905c-mkl@pengutronix.de>
References: <20240829192947.1186760-1-mkl@pengutronix.de>
 <20240829192947.1186760-14-mkl@pengutronix.de>
 <20240830131724.7c08eac4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mbdt5vzsemmzmus2"
Content-Disposition: inline
In-Reply-To: <20240830131724.7c08eac4@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--mbdt5vzsemmzmus2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.08.2024 13:17:24, Jakub Kicinski wrote:
> On Thu, 29 Aug 2024 21:20:46 +0200 Marc Kleine-Budde wrote:
> > +	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> > +		dma_set_mask_and_coherent(&pcie->pci->dev, DMA_BIT_MASK(64));
>=20
> This IS_ENABLED() is quite unusual. The driver just advertises its
> capability of using 64 addressing. If the platform doesn't support
> 64b DMA addressing and therefore dma_addr_t is narrower, everything
> will still work. I could be wrong, but that's how I understand it.

Ditch this PR.

I have sent out a new PR without this patch; however, it contains an
additional patch that has since arrived.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mbdt5vzsemmzmus2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbSQb0ACgkQKDiiPnot
vG9pTwf/TEq24XEJxOoMl3JP+t6jK8DsXYM/3PlJ/ifja291Nmx+wKh1NJ2thTjJ
WhkTdkK7EJcLSXE2Yu3BG4oSYFbdAIAdgzalvFoHXAsqkpI2yZr0LhukHsyS96wV
qW/nIYWSOi6q+PR39J9/Il6M1ZWPi8sSQ2bGsTpGuwNmvav1/jypQEUtBxJADiyr
KQgfa9PmoJ2mFjNjjEViQtGMimSum4Wz6exNXP6zFTUGOqEdWJl2cXlbFx9O/ctH
cfnZ6alNmlm6aEV3PXC7+3wB8rS6KBinn3MlhakgPc4+6RO5z3cgl617MTzn2vxh
f+iBDkBPpqGbMFdSYrrPJkr60T7Z1g==
=KxIG
-----END PGP SIGNATURE-----

--mbdt5vzsemmzmus2--

