Return-Path: <netdev+bounces-181078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C355AA83A1A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5A6465486
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2109204F61;
	Thu, 10 Apr 2025 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="TTf7i5o3"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540120371A;
	Thu, 10 Apr 2025 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268501; cv=none; b=EHHL8gwT1N85lafzTY2vZ18WjbdzILw6+wKHsE+rhP/mFMkAa/r6Xu1uAjR8QhJmX2O16WSK5AtShXHU8ixunkjeHH6rAuxNnCA9rim1VjCNYLtKQLVaj8GO+IoFh1xFwWsh3yqu9tB6z23Mratpjd/kAwp06/Nrxdblfzf/nbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268501; c=relaxed/simple;
	bh=YSO0Dhb+/odTfDPyixREshvYmJlj3LFUO7B+8aPAo9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7+TANhvx9nD6Wisb/5N/48Fy2lCQ/2ypvIoj2iRXEQlPr/7udZnptBJJ742nC5W1gERxeikecie5iHGd9ruIZHt7Xfo2FT1Y/0F5CeGX9kh9ra7VAOcOZ4qPh7blWHs0uBaYz201kRH4qDJEJtVWa3wOtvdYUoNGwKszydCBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=TTf7i5o3; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF99C102E6212;
	Thu, 10 Apr 2025 09:01:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744268489; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ke4COQunqDR3lxUvY5aqlltkaiCg4JiggLABHSyx8V8=;
	b=TTf7i5o3D9L8Fas3kA9NFBG5bcQVMIfm+cwjppivUDOdsDYXFwipiJCcmihiM6qQTJZAdG
	zaNgrLyYHuYfoTJuaoTd6jIOqycU4JiBPEm42oyx3Ew0/4lVlHHem8vbjskenSQZH/no3L
	EN0A6J8N3n9CQ4uGtz9NEwzmc07hhHdQV6vFd/dtbsaSYpjooi2rvr4mFJ/ws+tH+9vXzu
	wjZTFpfXub4MEA3TcyKen+arfsHEfQZ/cqfVLkZFYCoupsy1RQmOhtZtsV4g80yAOcfBAw
	/qWGKoPDH9TKe9BxdJ3vbwbuqMDECubOO3PDSSOn1W2VCmJXhwWxgspuTb9aDQ==
Date: Thu, 10 Apr 2025 09:01:22 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next v4 5/5] ARM: mxs_defconfig: Enable
 CONFIG_FEC_MTIP_L2SW to support MTIP L2 switch
Message-ID: <20250410090122.0e4cadef@wsk>
In-Reply-To: <c67ad9fa-6255-48e8-9537-2fceb0510127@gmx.net>
References: <20250407145157.3626463-1-lukma@denx.de>
	<20250407145157.3626463-6-lukma@denx.de>
	<c67ad9fa-6255-48e8-9537-2fceb0510127@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/64h1Hw0ZQWwTItAXL0wqZ.X";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/64h1Hw0ZQWwTItAXL0wqZ.X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Hi Lukasz,
>=20
> Am 07.04.25 um 16:51 schrieb Lukasz Majewski:
> > This patch enables support for More Than IP switch available on some
> > imx28[7] devices.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
> thanks adding the driver to mxs_defconfig. Unfortunately it's not
> possible for reviewers to identify the relevant changes,

Could you be more specific here?
As fair as I see - there is only 14 LOCs changed for review.

Please also be aware that MTIP L2 switch driver has some dependencies -
on e.g. SWITCHDEV and BRIDGE, which had to be enabled to allow the
former one to be active.

> also the
> commit messages doesn't provide further information.
>=20

What kind of extra information shall I provide? IMHO the patch is
self-explaining.

> In general there are two approaches to solves this:
> 1) prepend an additional patch which synchronizes mxs_defconfig with
> current mainline
> 2) manually create the relevant changes against mxs_defconfig
>=20
> The decision about the approaches is up to the maintainer.

I took the linux-next's (or net-next) mxs defconfig (cp it to be
.config)

Then run CROSS_COMPILE=3D ... make ARCH=3Darm menuconfig
Enabled all the relevant Kconfig options and run

CROSS_COMPILE=3D ... make ARCH=3Darm savedefconfig
and copy defconfig to mxs_defconfig.
Then I used git to prepare the patch.

Isn't the above procedure correct?


>=20
> Btw driver review will follow ...
>=20
> Regards
> > ---
> > Changes for v4:
> > - New patch
> > ---
> >   arch/arm/configs/mxs_defconfig | 14 +++-----------
> >   1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/configs/mxs_defconfig
> > b/arch/arm/configs/mxs_defconfig index d8a6e43c401e..4dc4306c035f
> > 100644 --- a/arch/arm/configs/mxs_defconfig
> > +++ b/arch/arm/configs/mxs_defconfig
> > @@ -32,11 +32,10 @@ CONFIG_INET=3Dy
> >   CONFIG_IP_PNP=3Dy
> >   CONFIG_IP_PNP_DHCP=3Dy
> >   CONFIG_SYN_COOKIES=3Dy
> > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > -# CONFIG_INET_XFRM_MODE_BEET is not set
> >   # CONFIG_INET_DIAG is not set
> >   # CONFIG_IPV6 is not set
> > +CONFIG_BRIDGE=3Dy
> > +CONFIG_NET_SWITCHDEV=3Dy
> >   CONFIG_CAN=3Dm
> >   # CONFIG_WIRELESS is not set
> >   CONFIG_DEVTMPFS=3Dy
> > @@ -45,7 +44,6 @@ CONFIG_MTD=3Dy
> >   CONFIG_MTD_CMDLINE_PARTS=3Dy
> >   CONFIG_MTD_BLOCK=3Dy
> >   CONFIG_MTD_DATAFLASH=3Dy
> > -CONFIG_MTD_M25P80=3Dy
> >   CONFIG_MTD_SST25L=3Dy
> >   CONFIG_MTD_RAW_NAND=3Dy
> >   CONFIG_MTD_NAND_GPMI_NAND=3Dy
> > @@ -56,11 +54,11 @@ CONFIG_EEPROM_AT24=3Dy
> >   CONFIG_SCSI=3Dy
> >   CONFIG_BLK_DEV_SD=3Dy
> >   CONFIG_NETDEVICES=3Dy
> > +CONFIG_FEC_MTIP_L2SW=3Dy
> >   CONFIG_ENC28J60=3Dy
> >   CONFIG_ICPLUS_PHY=3Dy
> >   CONFIG_MICREL_PHY=3Dy
> >   CONFIG_REALTEK_PHY=3Dy
> > -CONFIG_SMSC_PHY=3Dy
> >   CONFIG_CAN_FLEXCAN=3Dm
> >   CONFIG_USB_USBNET=3Dy
> >   CONFIG_USB_NET_SMSC95XX=3Dy
> > @@ -77,13 +75,11 @@ CONFIG_SERIAL_AMBA_PL011=3Dy
> >   CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
> >   CONFIG_SERIAL_MXS_AUART=3Dy
> >   # CONFIG_HW_RANDOM is not set
> > -# CONFIG_I2C_COMPAT is not set
> >   CONFIG_I2C_CHARDEV=3Dy
> >   CONFIG_I2C_MXS=3Dy
> >   CONFIG_SPI=3Dy
> >   CONFIG_SPI_GPIO=3Dm
> >   CONFIG_SPI_MXS=3Dy
> > -CONFIG_GPIO_SYSFS=3Dy
> >   # CONFIG_HWMON is not set
> >   CONFIG_WATCHDOG=3Dy
> >   CONFIG_STMP3XXX_RTC_WATCHDOG=3Dy
> > @@ -138,10 +134,6 @@ CONFIG_PWM_MXS=3Dy
> >   CONFIG_NVMEM_MXS_OCOTP=3Dy
> >   CONFIG_EXT4_FS=3Dy
> >   # CONFIG_DNOTIFY is not set
> > -CONFIG_NETFS_SUPPORT=3Dm
> > -CONFIG_FSCACHE=3Dy
> > -CONFIG_FSCACHE_STATS=3Dy
> > -CONFIG_CACHEFILES=3Dm
> >   CONFIG_VFAT_FS=3Dy
> >   CONFIG_TMPFS=3Dy
> >   CONFIG_TMPFS_POSIX_ACL=3Dy =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/64h1Hw0ZQWwTItAXL0wqZ.X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmf3bMIACgkQAR8vZIA0
zr1Djgf+NAPPtq9pLf3qrKtXaDfV+UOsNC/46Iy4s1emMVq/Wo4voyPw1z0vAl8D
WaMFD9hff7d/fmvPVCpAARDaixQEbBh140fR31b8heDyNQ8oSYa/u3edJ6pCUUFF
mrLrpx0kgcIBAYNeB8nCfdmjd4sipiljHklYe9oKdfxkaFO2/1892nPmbbgwM6bU
T9I0nhQH3GVdLkxbWnwI9zUdzZOkEN2TcW4ZoGrnonF4ZWW//ZV0nmPpNNPN60Nm
/2gKJb6NIuXEKZ84YX4wZS4qJYRaarnaYuXifx4tgfjcu4V+4nbWP8NWJWe/Y2hm
jrXBNj+DcLFIvTAZSuSuCc1EGNRZ2g==
=PBZj
-----END PGP SIGNATURE-----

--Sig_/64h1Hw0ZQWwTItAXL0wqZ.X--

