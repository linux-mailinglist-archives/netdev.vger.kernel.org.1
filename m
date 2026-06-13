Return-Path: <netdev+bounces-298928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hqrXLYEWLWpEbQQAu9opvQ
	(envelope-from <netdev+bounces-298928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:36:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B34567E276
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:36:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dW3ZLxCx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298928-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298928-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 481F6303E8CA
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69B93A8752;
	Sat, 13 Jun 2026 08:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C73AB293
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 08:36:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339771; cv=none; b=oiVX5dqmGZ3wdwqh71+mPYBXN6KSLvS5SI6xydHuC+SXN13KPafcJg7+AqZIwibHK9yu6ZPTfHioUldM+QY6j+r/4qkDEwJ5tsQgvwwsMTm2aOJmCLHwlo3egFbb8Et5zMfgdkodFeoHxaSphIdp2c30W3IXFjpdGql7LUv2qTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339771; c=relaxed/simple;
	bh=lp+rwv/5cHI+h1iUnoNus7Q0S7VFmCVS7aGT1UuD6ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSAr7loifPjfjNbVqVQ3HBIw625KBz7a1IMRfywZF9fPXgh8/KHNrXz8Mb7DCeD9uH65W2/gCrwzZgHmkWkp0/CN0VQSCfe5+Lqa6YQTxyaBsj/HrLdfhAp8xuCNny5km/TALURTFfxfiNRnt1eQkJRIwPlHbvnBsbgeoAXzTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW3ZLxCx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16441F000E9;
	Sat, 13 Jun 2026 08:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781339769;
	bh=FA8Qkjbau8l6ahSUSntT4VYINgPbUIyT3mXo0SiPu8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dW3ZLxCxKWkp6dV+14xw66cXXHoGeXWWY/r4cIx3haGMztzrz6c+x5NWk3Rd+Fhl4
	 yGzOT9Eq3fe272TR8Jupukq6BzIgNoWhFdZULN4b4LpL7AT5eXLwk0FsGcq8xYeztl
	 +Q5CaoXRuimk7Vxl1gc4hyYIlVQ4dQqK3Ld6vymfNtAlrAxoeGZbnb6PS//aMPe1cl
	 yHO9fBhN81POwK6tEBri7BNdZBhaFW1hsXhD0FTUpgUuWefGYOSDx8TvwcSVyW6U9/
	 E62O8UmVJF0dYBJF2fVXLGbUWsyPCMdFWQsmjyUxKtGwU3Oi3zBtslRdYlyklccZw6
	 Fh/3mBbHNJlig==
Date: Sat, 13 Jun 2026 10:36:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix always-true condition in PPE1 queue
 reservation loop
Message-ID: <ai0Wdm6AYh5ZrRWa@lore-rh-laptop>
References: <6a2ca3de.ad59c0a6.147df9.2ac1@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H5AwCgcOCuAvnmQX"
Content-Disposition: inline
In-Reply-To: <6a2ca3de.ad59c0a6.147df9.2ac1@mx.google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298928-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B34567E276


--H5AwCgcOCuAvnmQX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_fe_pse_ports_init(), the inner condition for PPE1 queue
> reservation is identical to the for-loop bound, making it always true
> and the else branch dead code:
>=20
>   for (q =3D 0; q < pse_port_num_queues[FE_PSE_PORT_PPE1]; q++) {
>       if (q < pse_port_num_queues[FE_PSE_PORT_PPE1])  /* always true */
>           set RSV_PAGES;
>       else
>           set 0;  /* unreachable */
>   }
>=20
> The intended behavior is to reserve pages only for the first half of
> the queues, matching the PPE2 implementation on line 334 which
> correctly uses the /2 divisor. Fix the PPE1 condition accordingly.
>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Wayen.Yan <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11..999f517 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -311,7 +311,7 @@ static void airoha_fe_pse_ports_init(struct airoha_et=
h *eth)
>  					 PSE_QUEUE_RSV_PAGES);
>  	/* PPE1 */
>  	for (q =3D 0; q < pse_port_num_queues[FE_PSE_PORT_PPE1]; q++) {
> -		if (q < pse_port_num_queues[FE_PSE_PORT_PPE1])
> +		if (q < pse_port_num_queues[FE_PSE_PORT_PPE1] / 2)
>  			airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_PPE1, q,
>  						 PSE_QUEUE_RSV_PAGES);
>  		else
> --=20
> 2.51.0
>=20
>=20

--H5AwCgcOCuAvnmQX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai0WcgAKCRA6cBh0uS2t
rO7RAP9g7N1WhxG+uVhjrwSIALK1fOaWyiTfOWfqgjMFz2sJTgD/X/4yttNNe92V
RyqwwsP+NoHXVSlbjU6imIw7+hHDggM=
=AAmu
-----END PGP SIGNATURE-----

--H5AwCgcOCuAvnmQX--

