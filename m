Return-Path: <netdev+bounces-298927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LYHYG0EVLWribAQAu9opvQ
	(envelope-from <netdev+bounces-298927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:30:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA40C67E234
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:30:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K+vHJFpJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298927-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298927-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446163024128
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B332F748;
	Sat, 13 Jun 2026 08:30:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D22E06D2
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 08:30:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339454; cv=none; b=Yw+BKwiP9VDx72KKPoPFOhSrcvpVmQJhH0s1L+PJ8iSedK1LzQIxVCMu32sC7XzuBDTZN1bBAQJGwtz1qo8Ry63o144HDGo/4XZguki14l6ZiSF5dlK4PqG5+QW0NwyfapuEnXGnOe25qSFG9eEvAPU7lud3T/c3x8TXBSBo0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339454; c=relaxed/simple;
	bh=0JGOVxIztDJRHq3VFBPMEgYOXpt2p5QULU5sq4VIi74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMLHlDkIjCB/fYJA0pDrv2Z3FvkLvdI8x6vAyRkht3usxWbDybdGRmQj4id3rxjajRk2eoXOD/qilrvvCuIy3kdwlPVSWy601bGylrJvceyTVE5003TOzHpGpoDgMXjYWw0NeYhCD/BvbyqMYOcW84a5U0cCJry3AKt7lLiZI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+vHJFpJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB84A1F000E9;
	Sat, 13 Jun 2026 08:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781339453;
	bh=Q9/4BnN9TN80wFokR3YbL8LF+lakOjzWW/QdszOefXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K+vHJFpJo9392/GlxlYmiZUtWtf+Zvqk6mTgfrdUtLbpTxvGZSzKUA9GJ5iX9XdaX
	 VDHQk5CDgzr0gKWLv3p+H9VL9oE8+KeJM6blwyRTHIcqa53zxEof7ZterACOOp6Zf6
	 unRreNdCbbIIm7U8QKk00cT+8D4WsuZ1gHL0Mstqsa+3ikT4Zl73HpB/kvhW2IpLfG
	 rqKlsC9GTM3GPAAoe8qNJg7GagYvdVuR8HAaW3wxbVsy3W2aW4TqAFf4e4hmhXyVQo
	 Z7B8zOLBcvrwhG713qJAmaLJOY1S1DbfdGl3ceBLkKOjP4TMnefUlXfCSRrgWhnhH1
	 kL3/6d1FYIzIA==
Date: Sat, 13 Jun 2026 10:30:49 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix typos in comments and Kconfig
Message-ID: <ai0VOeMCZYIfuOzR@lore-rh-laptop>
References: <6a2ca74a.c5b1db4e.21a698.01e7@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="64HGhJxIkxmRP3EZ"
Content-Disposition: inline
In-Reply-To: <6a2ca74a.c5b1db4e.21a698.01e7@mx.google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298927-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA40C67E234


--64HGhJxIkxmRP3EZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix several typos found during code review:
> - Kconfig: "Aiorha" -> "Airoha" in NET_AIROHA_FLOW_STATS help text
> - Comment: "CMD1" -> "CDM1" (Central DMA, not Command)
> - Comments: "GMD1/2/3/4" -> "GDM1/2/3/4" (Gigabit DMA, not GMD)
>=20
> These are pure comment and documentation fixes with no functional impact.
>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Wayen.Yan <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/Kconfig      |  2 +-
>  drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/a=
iroha/Kconfig
> index ad3ce50..1f6640a 100644
> --- a/drivers/net/ethernet/airoha/Kconfig
> +++ b/drivers/net/ethernet/airoha/Kconfig
> @@ -29,6 +29,6 @@ config NET_AIROHA_FLOW_STATS
>  	bool "Airoha flow stats"
>  	depends on NET_AIROHA && NET_AIROHA_NPU
>  	help
> -	  Enable Aiorha flowtable statistic counters.
> +	  Enable Airoha flowtable statistic counters.
> =20
>  endif #NET_VENDOR_AIROHA
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11..9d9d34a 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -294,18 +294,18 @@ static void airoha_fe_pse_ports_init(struct airoha_=
eth *eth)
>  			      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));
>  	}
> =20
> -	/* CMD1 */
> +	/* CDM1 */
>  	for (q =3D 0; q < pse_port_num_queues[FE_PSE_PORT_CDM1]; q++)
>  		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_CDM1, q,
>  					 PSE_QUEUE_RSV_PAGES);
> -	/* GMD1 */
> +	/* GDM1 */
>  	for (q =3D 0; q < pse_port_num_queues[FE_PSE_PORT_GDM1]; q++)
>  		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_GDM1, q,
>  					 PSE_QUEUE_RSV_PAGES);
> -	/* GMD2 */
> +	/* GDM2 */
>  	for (q =3D 6; q < pse_port_num_queues[FE_PSE_PORT_GDM2]; q++)
>  		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_GDM2, q, 0);
> -	/* GMD3 */
> +	/* GDM3 */
>  	for (q =3D 0; q < pse_port_num_queues[FE_PSE_PORT_GDM3]; q++)
>  		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_GDM3, q,
>  					 PSE_QUEUE_RSV_PAGES);
> @@ -340,7 +340,7 @@ static void airoha_fe_pse_ports_init(struct airoha_et=
h *eth)
>  							 q, 0);
>  		}
>  	}
> -	/* GMD4 */
> +	/* GDM4 */
>  	for (q =3D 0; q < pse_port_num_queues[FE_PSE_PORT_GDM4]; q++)
>  		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_GDM4, q,
>  					 PSE_QUEUE_RSV_PAGES);
> --=20
> 2.51.0
>=20
>=20

--64HGhJxIkxmRP3EZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai0VNgAKCRA6cBh0uS2t
rOoLAP9zD8rCmgmRGAbQK8MKUzVK5T4AKJTzQ6alW/rcKF3UEgEA01SqILqOnJw2
YHcDXCB9lRE0KlGXXENOLuexByhf7AQ=
=vr8q
-----END PGP SIGNATURE-----

--64HGhJxIkxmRP3EZ--

