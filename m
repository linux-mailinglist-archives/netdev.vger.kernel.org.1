Return-Path: <netdev+bounces-299178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U66+OYNjLmqVvAQAu9opvQ
	(envelope-from <netdev+bounces-299178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:17:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AABB680A22
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:17:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g3dJK+QQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299178-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299178-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09E0B30078AD
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850C36EA8F;
	Sun, 14 Jun 2026 08:17:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5CCA52
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 08:17:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781425023; cv=none; b=NYKKcE3E+Z8JxKvKr0a5BF+7Dy0oTyz+IHfVelDtTBS/crflq2TN4/byb5QZgTLMjx5AyX+ufYllAultxLX++PHGesK0mfKBDyxbS9CXNGLwwHVyM8SGoZWO5crs3SCwjDuAjQUSOfW2FLWnzIcYCbSeXFvh1sK8eXTI+Djz9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781425023; c=relaxed/simple;
	bh=kY/3oXQduTooELFurkmOdN1c9zeMFSHEPQp2PQBXjP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N29XgVdTUrvBk/xB2PIxCHR7DG2SM/KA8u9sVmLxlGqJaR85t2z+vLDpC7q9J4byLKSJB6PWrh6S0WlRNVw5t5c4/eBwvzC9Hgzjv4U2rTHMhlaYLEtylOdt4CM7HGcZUqpSfGw7aqlde20J6bJVDXjbjD6qoK1yK26q1919yl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3dJK+QQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9232E1F000E9;
	Sun, 14 Jun 2026 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781425020;
	bh=kuFCWVB426Kzg7aDhxtI+gq3b38s6oLNCDY46FNMzIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g3dJK+QQiIJ/R6pfAJSQShczhFQz1HRk4taNVoov5l1qOpsUQ9+v7335+qBVn8g+t
	 bgeELe2bcKj7U8Tdo1OdI7L/LqRm/KIlidjEd2Y9LtoJ79XQbqHPIY2QUI5g3JzSYN
	 vDJPDjoGI0G2Y6r/SIwAQz2IZasWKImutBDwAbVSyTBRnwMoBvKetqpXme7pMBSJFH
	 zg3RhqEfDM1nBxg9GDV8ofaXtLszPZSh8+PU+mmwvbeIIG3JUzoWdWuFFRLns+xznI
	 Z3/1Z3x09Lq1i9GuEF0FE1PU4XSpT2pk9KJvpxRnCvJ+YKVNV3xgxnfik/Oon6nPFl
	 rcf0+lAHg02hw==
Date: Sun, 14 Jun 2026 10:16:58 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Remove dead MT7996 NPU firmware declarations
Message-ID: <ai5jeubrGN1iMgHo@lore-desk>
References: <6a2dea77.01c4f138.336eeb.a256@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VFcFtyNt1TMkbinK"
Content-Disposition: inline
In-Reply-To: <6a2dea77.01c4f138.336eeb.a256@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lore-desk:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AABB680A22


--VFcFtyNt1TMkbinK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Remove the NPU_EN7581_7996_FIRMWARE_DATA/RV32 #define macros and
> their corresponding MODULE_FIRMWARE() declarations. Neither the
> en7581_npu_soc_data nor the an7583_npu_soc_data references these
> firmware names, and no firmware loading path in the driver ever
> requests them. The only references are the #define lines themselves
> and the MODULE_FIRMWARE() declarations below.
>=20
> Keeping dead MODULE_FIRMWARE entries causes modprobe/udev to attempt
> pre-loading non-existent firmware files, generating kernel log noise
> and misleading distributors about which firmware files to package.
>=20
> Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
> Signed-off-by: Wayen <win847@gmail.com>

Please drop this patch since EN7581_7996 firmware is defined via dts
for 7581:

commit 3847173525e307ebcd23bd4863da943ea78b0057
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Tue Jan 20 11:17:18 2026 +0100

    net: airoha: npu: Add the capability to read firmware names from dts
   =20
    Introduce the capability to read the firmware binary names from device-=
tree
    using the firmware-name property if available.
    This patch is needed because NPU firmware binaries are board specific s=
ince
    they depend on the MediaTek WiFi chip used on the board (e.g. MT7996 or
    MT7992) and the WiFi chip version info is not available in the NPU driv=
er.
    This is a preliminary patch to enable MT76 NPU offloading if the Airoha=
 SoC
    is equipped with MT7996 (Eagle) WiFi chipset.

https://github.com/openwrt/openwrt/blob/main/target/linux/airoha/dts/an7581=
-npu-mt7996.dtsi

and here these macros are used to notify userspace for firmware loading.

Regards,
Lorenzo

> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index 17dbdc8325..93095f3894 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -16,8 +16,6 @@
> =20
>  #define NPU_EN7581_FIRMWARE_DATA		"airoha/en7581_npu_data.bin"
>  #define NPU_EN7581_FIRMWARE_RV32		"airoha/en7581_npu_rv32.bin"
> -#define NPU_EN7581_7996_FIRMWARE_DATA		"airoha/en7581_MT7996_npu_data.bi=
n"
> -#define NPU_EN7581_7996_FIRMWARE_RV32		"airoha/en7581_MT7996_npu_rv32.bi=
n"
>  #define NPU_AN7583_FIRMWARE_DATA		"airoha/an7583_npu_data.bin"
>  #define NPU_AN7583_FIRMWARE_RV32		"airoha/an7583_npu_rv32.bin"
>  #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
> @@ -822,8 +820,6 @@ module_platform_driver(airoha_npu_driver);
> =20
>  MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_DATA);
>  MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_RV32);
> -MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_DATA);
> -MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_RV32);
>  MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_DATA);
>  MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_RV32);
>  MODULE_LICENSE("GPL");
> --=20
> 2.51.0
>=20
>=20

--VFcFtyNt1TMkbinK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai5jegAKCRA6cBh0uS2t
rCZWAQDu7IbS3lUX4tiezcJcZUn2Vmnen2mw6vP0GQWec0CDXwD/SwRxiFKqJ5om
MZ+MOgEjSVMNa8CZl2ZANR4iDqBVtwU=
=jB5j
-----END PGP SIGNATURE-----

--VFcFtyNt1TMkbinK--

