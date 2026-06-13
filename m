Return-Path: <netdev+bounces-298926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CSUhB5IULWqrbAQAu9opvQ
	(envelope-from <netdev+bounces-298926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:28:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A629067E22E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:28:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VPUfJw2n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298926-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298926-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 239C63009CC4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41924374A04;
	Sat, 13 Jun 2026 08:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F7378811
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 08:27:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339278; cv=none; b=nHqnLdbQf5bNiIB5T6dlcjANzLfrplv68b4+/DE4sJ1Sx21SySqs/0Z9lxFCRUlkkqkCsvbWDlu19vcH+TqIXqsTNlJI6jVM6vldVEyq4dm7jeGat/jHEI3UNmRhQ7KuCkBYudBo4cNAhE0GJx608Ca19fjBFduxsFdpTI/BqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339278; c=relaxed/simple;
	bh=OvTtEVws/PfB5yNawbfKPabYTLkOEdbbM14biaFPXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH91KurNf79fCGOTtchGeY9Lx6WRRgLyPelC6g16mWkjRcP0fIg9MxUXr47mEekteIyuIT11EOZ8gi8/5ntBCWxw9tYHXx8v3b9r5HCd0bD5rN1hI5egUvFRLjPBcM6lQo76Et+al60Em192e8WyIO7kbsutbWfwqqnI9wE91Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPUfJw2n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAD21F000E9;
	Sat, 13 Jun 2026 08:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781339276;
	bh=B5AB2GnAjTYfAqDEhgce6z9wXEJuX9EVNcWGLGsHedI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VPUfJw2niWvJCDCYWoaFJyYlv9SaqAO9eWb2G60hRXV7i/b0tY/OuOQaRFGq41l/y
	 fWFuvnyreKsMzxa5M69Lmk+RobO1Zu5qX69c+zNcLs5vFuNQZKPN8Fdk/b/pvdd2fO
	 8FZLb9mnEthvfsYLByFXZU0dMPYDJA4a9Kj4C5UL4BHb4g8o6TinLZG8McJNxTqKfD
	 cYVYeI8yJ+0n2y1bK0Sx36ybpsh9cW4bh4sQZEfkDSqmDh7RYO2I6cUmmTVAn+m1MQ
	 TO0uTQv6bA2vj4FNHAMAS54kMWwphV1qiZrmfoSku+7Bsis4+nusXM+M5v+wHFcfPO
	 bee50gIjJ/Luw==
Date: Sat, 13 Jun 2026 10:27:52 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix non-standard return value in
 airoha_ppe_get_wdma_info()
Message-ID: <ai0UiG4epd96KVtZ@lore-rh-laptop>
References: <6a2ca3d9.ad59c0a6.147df9.2a62@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yzHzCNJj3DNq8pfX"
Content-Disposition: inline
In-Reply-To: <6a2ca3d9.ad59c0a6.147df9.2a62@mx.google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298926-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A629067E22E


--yzHzCNJj3DNq8pfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> airoha_ppe_get_wdma_info() returns -1 when the last path in the
> forwarding path stack is not of type DEV_PATH_MTK_WDMA. This is not
> a standard kernel error code. Replace it with -EINVAL since the
> input path type is invalid from the caller's perspective.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Wayen.Yan <win847@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 5c9dff6..7260177 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -264,7 +264,7 @@ static int airoha_ppe_get_wdma_info(struct net_device=
 *dev, const u8 *addr,
> =20
>  	path =3D &stack.path[stack.num_paths - 1];
>  	if (path->type !=3D DEV_PATH_MTK_WDMA)
> -		return -1;
> +		return -EINVAL;
> =20
>  	info->idx =3D path->mtk_wdma.wdma_idx;
>  	info->bss =3D path->mtk_wdma.bss;
> --=20
> 2.51.0
>=20
>=20

--yzHzCNJj3DNq8pfX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai0UhQAKCRA6cBh0uS2t
rKlAAP4lFZjCFbxB2FvByROyzvrQUQJJbLpoX3MKp329SHp0iQD+P6mXCtbkeoi9
sZmQ+rhyoeWSzKSJ1zr4GUWnEgXsGws=
=quVv
-----END PGP SIGNATURE-----

--yzHzCNJj3DNq8pfX--

