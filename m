Return-Path: <netdev+bounces-173535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D730A59521
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C843B1E06
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7B226D1B;
	Mon, 10 Mar 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KOXorH2E"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9545224252;
	Mon, 10 Mar 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611076; cv=none; b=UmA1+DiYfKQA7sjgdv41tUtOmzgdYEvlY+Z2c1ASUhv8jN5Mf0TxoIFmviRRRW9pczTpc5iIY9rkihdSHJenRVuPGR/IhsU0cAa49X+VIReqGJvXP5U0pyocr36Fvt8BBthQYfHUVilcH8Crpfr4x+Xxd2OiXnzEOUkegSwjO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611076; c=relaxed/simple;
	bh=UjM8Ysu6ITSvttk3Hg0lMsBTnl6G5ZsqoiI8lIaMSfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R94VrfqwYY28QfNzdu+Yqnk61B+WRWjTcGhntSz7fHAzfKrSHFZHOnJiGvgsRHm79awL2nZHTimOcJJSCq9K9O4ldiwRImIhFUTBbIU7tNrxjJrzorWe1+mB/XwgUm3LEI/H3I190Y9YoZurk9VzJZmIdtASwDUCPAGW/+iyKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KOXorH2E; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79C3E4418C;
	Mon, 10 Mar 2025 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741611065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpwv+O/rfjVyEucu2QcSsIfXnrXMI0PIlcx95yddQ+Y=;
	b=KOXorH2EviOwBX90oHYpCRsMCj5LPdVecXFwNLwwVwj0tkggBUk9NnZmOXbFHYvcnqlght
	O7PjNZB4jiUBlpGnwp/tP/DFhgwD/y9k1Ts+6/kKGgMztyKC0YpelTXZTzIRlcIfgONt9c
	XADOnzvueAuVfDDnfLJHN5gLupxCBUS+VEyt4G8UtBQSiEypJoMB76sDusPvnJiHillDlH
	LuyNVlreD0iTJ9Cs5I1UFi4oKGR9vxzIpULWuQCludb3PRHIVP8Qkz8lN5S9if6lz55CO4
	6h0TbAjNfgRqyIAet1J+zopSykvBCRHFS0kUmHGZL8EmATS1+nv9/orTQL244g==
Date: Mon, 10 Mar 2025 13:50:12 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Leon Schuermann
 <leon@is.currently.online>, Jakub Kicinski <kuba@kernel.org>, Oliver Neukum
 <oliver@neukum.org>
Subject: Re: [PATCH] cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk
Message-ID: <20250310135012.0e5a0791@kmaincent-XPS-13-7390>
In-Reply-To: <484336aad52d14ccf061b535bc19ef6396ef5120.1741601523.git.p.hahn@avm.de>
References: <484336aad52d14ccf061b535bc19ef6396ef5120.1741601523.git.p.hahn@avm.de>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeetgeeghfduhefhleelueeuueejjeegueegffdviedtheejieekhedvveejteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhgvnhhovhhordgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppeegiedrudekkedrvdefledruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepgeeirddukeekrddvfeelrddutddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehphhgrhhhnqdhoshhssegrvhhmrdguvgdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepl
 hgvohhnsehishdrtghurhhrvghnthhlhidrohhnlhhinhgvpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeholhhivhgvrhesnhgvuhhkuhhmrdhorhhgpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 10 Mar 2025 11:17:35 +0100
Philipp Hahn <phahn-oss@avm.de> wrote:

> Lenovo ThinkPad Hybrid USB-C with USB-A Dock (17ef:a359) is affected by
> the same problem as the Lenovo Powered USB-C Travel Hub (17ef:721e):
> Both are based on the Realtek RTL8153B chip used to use the cdc_ether
> driver. However, using this driver, with the system suspended the device
> constantly sends pause-frames as soon as the receive buffer fills up.
> This causes issues with other devices, where some Ethernet switches stop
> forwarding packets altogether.
>=20
> Using the Realtek driver (r8152) fixes this issue. Pause frames are no
> longer sent while the host system is suspended.

Please add net-next prefix to your patch as it is not a fix.

Also several net maintainers are missing in the Cc. Please use the
get_maintainers scripts like the following to get list of maintainers:
./scripts/get_maintainer.pl --norolestats --nogit-fallback *.patch

With these changes:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> Cc: Leon Schuermann <leon@is.currently.online>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Oliver Neukum <oliver@neukum.org> (maintainer:USB CDC ETHERNET DRIVER)
> Cc: netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
> Link: https://git.kernel.org/netdev/net/c/cb82a54904a9
> Link: https://git.kernel.org/netdev/net/c/2284bbd0cf39
> Link:
> https://www.lenovo.com/de/de/p/accessories-and-software/docking/docking-u=
sb-docks/40af0135eu
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de> ---
>  drivers/net/usb/cdc_ether.c | 7 +++++++
>  drivers/net/usb/r8152.c     | 6 ++++++
>  drivers/net/usb/r8153_ecm.c | 6 ++++++
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
> index a6469235d904..a032c1ded406 100644
> --- a/drivers/net/usb/cdc_ether.c
> +++ b/drivers/net/usb/cdc_ether.c
> @@ -783,6 +783,13 @@ static const struct usb_device_id	products[] =3D {
>  	.driver_info =3D 0,
>  },
> =20
> +/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on
> Realtek RTL8153) */ +{
> +	USB_DEVICE_AND_INTERFACE_INFO(LENOVO_VENDOR_ID, 0xa359,
> USB_CLASS_COMM,
> +			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
> +	.driver_info =3D 0,
> +},
> +
>  /* Aquantia AQtion USB to 5GbE Controller (based on AQC111U) */
>  {
>  	USB_DEVICE_AND_INTERFACE_INFO(AQUANTIA_VENDOR_ID, 0xc101,
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 468c73974046..96fa3857d8e2 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -785,6 +785,7 @@ enum rtl8152_flags {
>  #define DEVICE_ID_THINKPAD_USB_C_DONGLE			0x720c
>  #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2		0xa387
>  #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3		0x3062
> +#define DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK		0xa359
> =20
>  struct tally_counter {
>  	__le64	tx_packets;
> @@ -9787,6 +9788,7 @@ static bool rtl8152_supports_lenovo_macpassthru(str=
uct
> usb_device *udev) case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2:
>  		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3:
>  		case DEVICE_ID_THINKPAD_USB_C_DONGLE:
> +		case DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK:
>  			return 1;
>  		}
>  	} else if (vendor_id =3D=3D VENDOR_ID_REALTEK && parent_vendor_id =3D=3D
> VENDOR_ID_LENOVO) { @@ -10064,6 +10066,8 @@ static const struct usb_devic=
e_id
> rtl8152_table[] =3D { { USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927) },
>  	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e) },
>  	{ USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101) },
> +
> +	/* Lenovo */
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x304f) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3054) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
> @@ -10074,7 +10078,9 @@ static const struct usb_device_id rtl8152_table[]=
 =3D {
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x721e) },
> +	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa359) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa387) },
> +
>  	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
>  	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
>  	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
> diff --git a/drivers/net/usb/r8153_ecm.c b/drivers/net/usb/r8153_ecm.c
> index 20b2df8d74ae..8d860dacdf49 100644
> --- a/drivers/net/usb/r8153_ecm.c
> +++ b/drivers/net/usb/r8153_ecm.c
> @@ -135,6 +135,12 @@ static const struct usb_device_id products[] =3D {
>  				      USB_CDC_SUBCLASS_ETHERNET,
> USB_CDC_PROTO_NONE), .driver_info =3D (unsigned long)&r8153_info,
>  },
> +/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on
> Realtek RTL8153) */ +{
> +	USB_DEVICE_AND_INTERFACE_INFO(VENDOR_ID_LENOVO, 0xa359,
> USB_CLASS_COMM,
> +				      USB_CDC_SUBCLASS_ETHERNET,
> USB_CDC_PROTO_NONE),
> +	.driver_info =3D (unsigned long)&r8153_info,
> +},
> =20
>  	{ },		/* END */
>  };



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

