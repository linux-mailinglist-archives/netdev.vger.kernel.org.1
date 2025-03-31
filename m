Return-Path: <netdev+bounces-178395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB57A76D5D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA153A80D6
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94226216E24;
	Mon, 31 Mar 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="TjOIfQnz"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7154211476;
	Mon, 31 Mar 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743448295; cv=none; b=OdRu9B3x1c3/34st3xLmS63S+58j5iMhmLac3ER6TVE+yLxNqtWny0uBslKwPwvWdwWm0nLpRKF0zMEqapcgYWiTgqdo5mZhGlcvJOpOXF4Y1AJIzbGXjczwMKM8M10yF2Z13GSaMFaem+WAVdC82tnX/131j/qI2n+Ja22wCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743448295; c=relaxed/simple;
	bh=qzMu4pyJugh7Xt+NsGRh1suefzq7xECSFtdMZ4p5Tcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5r7hBP8C2s1vXRERzM2nFrwVNrhVOTJdH88JHlFP5mk05b36CSDT1NAkAqDFY+FFsmL48Er/izfOl59989mXSbJFWUERXJxlWp4PvTAXXLjWBn7biZr5rh4MitPvWyP1i10Hu0Vh1cqseNRt2nkEMUcR+6IfE5xLngNHGc9Hmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=TjOIfQnz; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA35B10252BE4;
	Mon, 31 Mar 2025 21:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743448291; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oSSK2PTqlnUEJhKCvNW0crQEodWyOjfIifnHJ+xuMNM=;
	b=TjOIfQnzNullD7EcYq3OqdQ/ACfrulBbrkMI0okI3NNe354wkVyJrfMG2AanEL8a8f1SNP
	DRR0dL2B3ZMBUPCF4L6Jv7Rbj0cWvlOFk7PIQcThAiUpYyznBRuNhYeipNhohy9B9uDs+I
	OvktXLdkKiU9iPZef8aqAs+Y+O4zCZfbN0n8CQZxwFknh8YjHWKs81VOyjCg/3/0Vtbu2H
	SK2c4lxu+zNmb7B5ZxdbspGvSrRVEDlKStIz+qePJckU13bEsn3c4tkhjfVGZ1RBw9wfUh
	FP8/HZYT4Ks5xFNyHwvaxX63/CCP1Foz3PbMG+S0IBOQQnhWpvJIkc+1SRGd8w==
Date: Mon, 31 Mar 2025 21:11:25 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] net: mtip: Add support for MTIP imx287 L2 switch
 driver
Message-ID: <20250331211125.79badeaf@wsk>
In-Reply-To: <20250331101036.68afd26a@kernel.org>
References: <20250331103116.2223899-1-lukma@denx.de>
	<20250331101036.68afd26a@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IR1iYWtwzQdqHh5c+hN8Svc";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/IR1iYWtwzQdqHh5c+hN8Svc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Mon, 31 Mar 2025 12:31:12 +0200 Lukasz Majewski wrote:
> > This patch series adds support for More Than IP's L2 switch driver
> > embedded in some NXP's SoCs. This one has been tested on imx287,
> > but is also available in the vf610. =20
>=20
> Lukasz, please post with RFC in the subject tags during the merge
> window. As I already said net-next is closed.

Ach, Ok.

I hope, that we will finish all reviews till 07.04, so v4 would be the
final version.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/IR1iYWtwzQdqHh5c+hN8Svc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfq6N0ACgkQAR8vZIA0
zr1KaAf/aQYJaLVFceTv3YwD0fzfiVnP2cDfAM7j3J5NjW38UrFMOpqEm5HkQS06
xvDsBShC5fwDXj0VdvSEG84/ALMGqgNL2iwIcMXN13nc3K9mGPcSYVEpQQQ1IFzn
UJyHkEJ0NA88ultzLOXv9JOm+oPFIFbvuKvFjNlLH7cjxvy4N/4+MD22cXkz1N6D
UfXM49pE5ngKYWrKjp4zaa4PC8eD9NM2H2MHNhcbE1qq6B62TCDaCVhLYHmaufD4
VczPpX6VKRXBTLC60OqOuo9NLLZQ7l3Up8dkECviKEfXrgVuSxRTKukaqIp2pxAx
Jwmcnj7XAbwC2a8yRUktEfAAtC/dwQ==
=aORA
-----END PGP SIGNATURE-----

--Sig_/IR1iYWtwzQdqHh5c+hN8Svc--

