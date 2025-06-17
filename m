Return-Path: <netdev+bounces-198697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9083ADD106
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62FA1882B40
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D942E972A;
	Tue, 17 Jun 2025 15:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DB2E889A
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172890; cv=none; b=Q/crJpeKGB0xgF+XsBEhRpwDJwwVvIf7LK+IWN01Xp32XKyXCyGriOT46BZNGlc/MrTClnRhlpTWIUQiHEng/MmxC7UE0n9Bcq05lUc56LnjghuqoyQrleQypsH+FUe9Ob9NYht7GZffiJeC/VswhZS9NdH65DRWdGArv8DuIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172890; c=relaxed/simple;
	bh=MlST4HpCX/8lpMelJ6BJ1R2IsWPXG8rqsXFPnElrw7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQtfbri4yaHqx8hW4k3f01iN0P+/A6uVSf6pmWct6dzJjr5ZsVMi8zVIchcVY40qUVEJb+ICXnU9mRW7y5uXWUY2Jk7kTnWTQchKgDFberscTs15YWedK8AaHFffz4PJMA46SarYE5eNAM/uRafd1FWRRnoM3Ehbp5cjO/PY85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRXuZ-0003lG-6t; Tue, 17 Jun 2025 17:07:43 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRXuX-003zen-1k;
	Tue, 17 Jun 2025 17:07:41 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2A3B842AA50;
	Tue, 17 Jun 2025 15:07:41 +0000 (UTC)
Date: Tue, 17 Jun 2025 17:07:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>, 
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v3 03/10] net: fec: add missing header files
Message-ID: <20250617-funky-auspicious-stallion-25f396-mkl@pengutronix.de>
References: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
 <20250617-fec-cleanups-v3-3-a57bfb38993f@pengutronix.de>
 <b6687ad2-1fd9-4cb5-8f5d-8c203599f002@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vb7ad2zc4mjylvxd"
Content-Disposition: inline
In-Reply-To: <b6687ad2-1fd9-4cb5-8f5d-8c203599f002@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--vb7ad2zc4mjylvxd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v3 03/10] net: fec: add missing header files
MIME-Version: 1.0

On 17.06.2025 16:55:19, Alexander Lobakin wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Tue, 17 Jun 2025 15:24:53 +0200
>=20
> > The fec.h isn't self contained. Add missing header files, so that it ca=
n be
> > parsed by language servers without errors.
> >=20
> > Reviewed-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/net/ethernet/freescale/fec.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/etherne=
t/freescale/fec.h
> > index ce1e4fe4d492..4098d439a6ff 100644
> > --- a/drivers/net/ethernet/freescale/fec.h
> > +++ b/drivers/net/ethernet/freescale/fec.h
> > @@ -15,7 +15,9 @@
> >  /*********************************************************************=
*******/
> > =20
> >  #include <linux/clocksource.h>
> > +#include <linux/ethtool.h>
> >  #include <linux/net_tstamp.h>
> > +#include <linux/phy.h>
> >  #include <linux/pm_qos.h>
> >  #include <linux/bpf.h>
> >  #include <linux/ptp_clock_kernel.h>
>=20
> Sort alphabetically while at it? You'd only need to move bpf.h AFAICS.

After sorting, the incremental diff will look like this:

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/fr=
eescale/fec.h
index 15334a5cce0f..1fe5e92afeb3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -14,16 +14,16 @@
 #define FEC_H
 /*************************************************************************=
***/
=20
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/bpf.h>
 #include <linux/clocksource.h>
 #include <linux/ethtool.h>
+#include <linux/firmware/imx/sci.h>
 #include <linux/net_tstamp.h>
 #include <linux/phy.h>
 #include <linux/pm_qos.h>
-#include <linux/bpf.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
-#include <dt-bindings/firmware/imx/rsrc.h>
-#include <linux/firmware/imx/sci.h>
 #include <net/xdp.h>
=20
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x=
) || \

Is that okay? If so, I'll squash it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vb7ad2zc4mjylvxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhRhLkACgkQDHRl3/mQ
kZynRwf5AfBSqlvS6ZPaUDdzbaT4ChHehHLaV34f0P/3xHED8RIiw7WIX23Zui9c
JoTWQ6dr2L24g9pj0yaq6sxcuKCLnN5Cg0HXZ/p+ZhQr52HozhR+wT7BHAnNjkfn
P6rUERHpn/RikEUObpv6UVjfCKTR5IUlNF6ByYDhJeYJ/SVqc99NgnQj/g5FkHV4
4Fz2zVrwe8Szj0IscA+2BVYEPog5pYDnlRUx+X28G9hE0C9nmatzWnYLcTAn2ooV
UBPCqwpYHHQUWBwlG3CDUXhmB3ZANddW68zg1jX8lw6lA3cpRU1/tceo67puj9Pp
VSEwopzAQSPGlsU9RmGwLiZc4a6kqw==
=1zfJ
-----END PGP SIGNATURE-----

--vb7ad2zc4mjylvxd--

