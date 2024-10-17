Return-Path: <netdev+bounces-136412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E49A1B0F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2441C20DF5
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086401925B2;
	Thu, 17 Oct 2024 06:53:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E82193424
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148022; cv=none; b=BQFItQTnhKQ9h6udyBitSb0/r6Q3djzU8bNzQ1vRJSbWt3tuJPTj1XNfMffvXYIBAhRC7MKehNUCwx52CzqcPYQNi1VSaJc8oZO4xZTJZHfW4aVG8PtHwLhDhTuWkOLVOmWB4mHO9knR9PHGCGbmf3WSptXYlcCyU/U8zyUOYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148022; c=relaxed/simple;
	bh=k1WvreGiKBv7Jos9jpm36eHR1fDCB/r8ocg0rSeL3o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJOE6r1rOp12t+6AkyOoSBZnZiiRiRb2r/eVhOC7oeBj7Zz9TymY5/aL46o5M7eAKpIsOxraWPpvioNdIqSLaKMiqg+DrKuaWYkdtHmPHlMddq8oDwM4L8O6LZEbV6YpwWhON/DE2TRj9do3l6S3y472RXkObT3D5BdL1VEHZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KNv-00082t-BV; Thu, 17 Oct 2024 08:53:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KNu-002U7P-40; Thu, 17 Oct 2024 08:53:22 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BE97D354D67;
	Thu, 17 Oct 2024 06:53:21 +0000 (UTC)
Date: Thu, 17 Oct 2024 08:53:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 02/13] net: fec: struct fec_enet_private: remove
 obsolete comment
Message-ID: <20241017-adept-quick-caiman-9970df-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-2-de783bd15e6a@pengutronix.de>
 <ZxBufV7xkX9gK0+m@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="parrzsfnfhjfhzyx"
Content-Disposition: inline
In-Reply-To: <ZxBufV7xkX9gK0+m@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--parrzsfnfhjfhzyx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 21:55:09, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:51:50PM +0200, Marc Kleine-Budde wrote:
> > In commit 4d494cdc92b3 ("net: fec: change data structure to support
> > multiqueue") the data structures were changed, so that the comment
> > about the sent-in-place skb doesn't apply any more. Remove it.
>=20
> nit: wrap at 75 char

fixed - my editor is set to auto-wrap at 70.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--parrzsfnfhjfhzyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQtF4ACgkQKDiiPnot
vG+cugf/SqGhWPB+PihEBSh8710+iHULwnBZswiDzTsjf29ij5Jga7XOD/0KSMYL
XlvDMFdG3riV6kWES0i2PespKfoaEPHFyJGAkAs2u/yMRMxO52gR3wDJq4pDGWKP
JrTP7an6YjZGoxe583f5K8zDymm9mmOlA3HloDyT/A/5QF9iPDurRsaywfObekHW
NhcExLglaWokk+kj7on0kN3AvoRjqylKo2tN/3Q/dr4wghSv+So9lMyiWQ3PdMpR
CR2YUWNenspz/myRxl4dCr4nVoVP13S10r/qRcX9FxuL7i/6N2T0h53nYdTnjeB/
xyMRL2ZNiOMD4YlWiuCfU7nap7e8ug==
=eoGx
-----END PGP SIGNATURE-----

--parrzsfnfhjfhzyx--

