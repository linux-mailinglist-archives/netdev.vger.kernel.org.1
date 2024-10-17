Return-Path: <netdev+bounces-136414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E89A1B16
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133A41C20B61
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A551925B2;
	Thu, 17 Oct 2024 06:55:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA616F8F5
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148110; cv=none; b=otr8jmQe+W93SYWA5E1PXOQ3YPh1YCfEOw3LhUNl5Eemq+X5zppfXANGCCLQ5MR2UFXSClQ00R29rGfsN3+ZzD+pOvNcvr2Y8J6vLeCyCWJOql45AbIrMsbl7FdafJDzAwuWJd3MIYv4LyUtHC7yAedjFpHwLsYwndEYic7d6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148110; c=relaxed/simple;
	bh=bLzjUmSA5Vxlu5b9f5rbV9oI2tLW4z2gL4AbaT0kNRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhB6NU5JnajUQYZiUXGZLWMMWZencwB0SCCDZcmlt7Qn1Qr/oxIzrWsGpnUTSMyio+0Mc6JuckbzqNok9O+2ckI5EqJdif4UgUTMEUkMneCvnS77cXK8Kd4c7xI4ljrMi0EDoeBpvzK9LCHYQwzoUawo9viG3g2DQMcl+lsS+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KPO-0008GK-Id; Thu, 17 Oct 2024 08:54:54 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KPO-002U7p-3W; Thu, 17 Oct 2024 08:54:54 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C3BB0354D71;
	Thu, 17 Oct 2024 06:54:53 +0000 (UTC)
Date: Thu, 17 Oct 2024 08:54:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 04/13] net: fec: rename struct fec_devinfo
 fec_imx6x_info -> fec_imx6sx_info
Message-ID: <20241017-magnetic-divergent-chimpanzee-ea4e80-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-4-de783bd15e6a@pengutronix.de>
 <ZxBvn/r8YNqSVRcC@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3epkxxnnuoitszq"
Content-Disposition: inline
In-Reply-To: <ZxBvn/r8YNqSVRcC@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--j3epkxxnnuoitszq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 21:59:59, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:51:52PM +0200, Marc Kleine-Budde wrote:
> > In da722186f654 ("net: fec: set GPR bit on suspend by DT
> > configuration.") the platform_device_id fec_devtype::driver_data was
> > converted from holding the quirks to a pointing to struct fec_devinfo.
> >
> > The struct fec_devinfo holding the information for the i.MX6SX was
> > named fec_imx6x_info.
> >
> > To align the name of the struct with the SoC's name, rename struct
> > fec_devinfo fec_imx6x_info to struct fec_devinfo fec_imx6sx_info.
>=20
> Is it better
> "Rename fec_imx6x_info to fec_imx6sx_info to align SoC's name."

Fixed,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--j3epkxxnnuoitszq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQtLsACgkQKDiiPnot
vG9NWgf/VL15lV8XiEiNl/AaGYvm5EFL9aQ6RH1R4e7k3Z6C4UuwluuIUiG8486m
1dlKuzaYVHTq5pEtHl9inkm+/2SCu28oNN2ffvy3ZFVLoSkHtpfbsaoWjE8pdMLd
xNOdcUW+LgPv6+T20Tyd9dP9Mw0bkxoTb6YhB/YiScSkqLk+nY8ag71IO4V9HkR4
zGgoov0bfeLxAS4IByf0u8xhC707nbJJIlshD5iWMoBhzXKvM8cbG7qZDBtrFV9r
J6BSoOYyANl4T0GIVJnN5ZNeueb6ZALWEOdfs2myk9uir4TkMR3vg9iQTOrroxDv
mnp8SHHV0Rc9D7aY5guv4PraCXN6ww==
=qNne
-----END PGP SIGNATURE-----

--j3epkxxnnuoitszq--

