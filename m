Return-Path: <netdev+bounces-115814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448CD947DDC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1F71F2355C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04A15B56E;
	Mon,  5 Aug 2024 15:18:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0A15B554
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871126; cv=none; b=LnJZ86d64rZcfdvp3tcEFtRuXXL4xvv75xBG84CnzzAOT6v2v43YWloSXukfVdgBi0ehOPumEz7W+iY5VCxifwQOLATuCUUhoxJeB5EPhdkJrlNwvJv1+4qF4Xu4RkbHkLhaHKsaSlN6RrCsFMNUa/WiierEXLEuXhZ3x/Ecfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871126; c=relaxed/simple;
	bh=lvYPe5JkM3Jsviw05x2n8vRfc/U+/nszrW8Yv9RWPpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv7bTQoUSgwHymzmJf3NGZH6FVKsEtWBkTx9e39iI12qas3ADloWCUJxMM09khykIFIGee7DijfOACo/JaHPdIPwr5KH6FODgQGHYu8bKUgJWlW4lnxrAb3m4wyt4VZt57s+XBcEjr8dnEhmBNdjS+qXIABr/oj4W4wWhB76wmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazTY-0000aP-8t; Mon, 05 Aug 2024 17:18:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazTW-004k74-RH; Mon, 05 Aug 2024 17:18:18 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4DF043172CF;
	Mon, 05 Aug 2024 14:48:16 +0000 (UTC)
Date: Mon, 5 Aug 2024 16:48:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com
Subject: Re: [PATCH v4 0/2] can: fsl,flexcan: add imx95 wakeup
Message-ID: <20240805-succinct-didactic-vicugna-e5449a-mkl@pengutronix.de>
References: <20240731-flexcan-v4-0-82ece66e5a76@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i3ptc3rbvj5qf52i"
Content-Disposition: inline
In-Reply-To: <20240731-flexcan-v4-0-82ece66e5a76@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--i3ptc3rbvj5qf52i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.07.2024 20:00:24, Frank Li wrote:
> To: Marc Kleine-Budde <mkl@pengutronix.de>
> To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-can@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: haibo.chen@nxp.com
> Cc: imx@lists.linux.dev
> Cc: han.xu@nxp.com
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Added to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--i3ptc3rbvj5qf52i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaw5i0ACgkQKDiiPnot
vG820Af/YitgSU5McIXL4Xj9VvsbaznGIpvqeB/FJPifibKVNOxtEWHQGdKmrE04
p/AaYxH+d9pegXTCh4swRkcr1Z2xehUTRhH0Y+LksJpUTxcQZ3bgXXXkw820NcEx
cEyLB6FsX51oV2twn5Grryb46dY3pmN+sYbyoisYIftJNV+uguNmG4f4fRyyOob2
/vypmstlC6dRFy/QMud9wC57iRFkT4wv7sq1ZMe1cdNeW9U9FTXjoQkVqtzoZi6c
R+iU6RuSolTdSK+rgiatlOs1JihcMqoxKGtJ4bkeCJ79anBWNrpwFgI5o4N8ksYg
TShdt8HLpYWPFdsir/zyCdnSF869og==
=3OT+
-----END PGP SIGNATURE-----

--i3ptc3rbvj5qf52i--

