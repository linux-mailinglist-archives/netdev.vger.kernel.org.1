Return-Path: <netdev+bounces-298578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JXqdJEzfK2ouGwQAu9opvQ
	(envelope-from <netdev+bounces-298578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:28:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2526F678AF6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:28:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DNlMkoPr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298578-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298578-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A249301D5B6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54A368D46;
	Fri, 12 Jun 2026 10:28:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995632C94A
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:28:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260104; cv=none; b=jd7ZIvVPOYmxAz5h+xmssgS7fJWUj8Rweh8LhA0nSxclkfYvyOBDsmXAu1CZFVA/D7pvbhV8m7/HFxrtfANBGyG4e6ZYACTvdGPgBSicpOnspPHrPrwp4qT35qCQjCmNmFQOOTb4p1EW+R93fOjrl6uNhBa+ygjl1MVoPrIOQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260104; c=relaxed/simple;
	bh=6loFun26Zuz9Jz4BO3V8hUdqnGtht86tTt2u9oY85qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbP/5Jc2CitVpkH5dop9JjboX2xnuBWCybtHo9NGfyGqYnOVuuFbtH4VKW7P7x/QdMbIDD1aDiIipXJzxGttY5jbw0m3Lfk8iOkOTCFRDVX8u6/R3s+Wl/AxyFcU/G+aJO79CqI5951OOifI+cHAbWOAL5vadI/LIVNqvQ1U6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNlMkoPr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FE81F000E9;
	Fri, 12 Jun 2026 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781260103;
	bh=f/ANQU5yElXq5/4kup7qDLTunMHTYjQhDPXNkYYLT8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DNlMkoPrCGAq+LCan0dVbwLbdh0MdMlr+wO+V2l7NTFUTsa2psI5Q/WYBRp1mNAvw
	 AhJL0A8M/aOoIZyDTeuFq57jMWDCfe492qHRSEOYeFRMFbPA3m10GputbpTJtvUHuX
	 9x+n+uDJaRLx6bp9cm3g9FiOt6Awod/NZYq9tWkO3Hdsr8f+gqqWSorNmROXASnj0+
	 yaEz93iw4p9oEROWp9JOhpfKvN4B+cbviewxLaQJ2esMsQ+BeC8bIfVH2zTgmt3PG7
	 4Pfj2o+VtsjlFeeuTMEbLZo05dDdlN1gxR6trhPrKAtsJZNJ651sMgRmg8uz9tt26i
	 qkLURpgeIUTgw==
Date: Fri, 12 Jun 2026 12:28:21 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix register index for Tx-fwd counter
 configuration
Message-ID: <aivfRSPzxRezTRta@lore-desk>
References: <6a2b40e7.4dd82583.3a5c46.e566@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LYLKlmUwV+uWKKpP"
Content-Disposition: inline
In-Reply-To: <6a2b40e7.4dd82583.3a5c46.e566@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298578-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2526F678AF6


--LYLKlmUwV+uWKKpP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_qdma_init_qos_stats(), the Tx-fwd counter configuration
> register uses the same index (i << 1) as the Tx-cpu counter, which
> overwrites the Tx-cpu configuration. The Tx-fwd counter value register
> correctly uses (i << 1) + 1, so the configuration register should use
> the same index.
>=20
> Fix the REG_CNTR_CFG index from (i << 1) to ((i << 1) + 1) so that
> the Tx-fwd counter is properly configured instead of clobbering the
> Tx-cpu counter config.
>=20
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Signed-off-by: Wayen.Yan <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11..329988a 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1256,7 +1256,7 @@ static void airoha_qdma_init_qos_stats(struct airoh=
a_qdma *qdma)
>  			       FIELD_PREP(CNTR_CHAN_MASK, i));
>  		/* Tx-fwd transferred count */
>  		airoha_qdma_wr(qdma, REG_CNTR_VAL((i << 1) + 1), 0);
> -		airoha_qdma_wr(qdma, REG_CNTR_CFG(i << 1),
> +		airoha_qdma_wr(qdma, REG_CNTR_CFG((i << 1) + 1),
>  			       CNTR_EN_MASK | CNTR_ALL_QUEUE_EN_MASK |
>  			       CNTR_ALL_DSCP_RING_EN_MASK |
>  			       FIELD_PREP(CNTR_SRC_MASK, 1) |
> --=20
> 2.51.0
>=20
>=20

--LYLKlmUwV+uWKKpP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaivfRQAKCRA6cBh0uS2t
rNYfAP0XdKGR6Aiasu0qGwgQ/9xP3GhgfMeX1v4XIsmZR6d1xAEAzrpOQRsPg2BJ
CZQkHbgBiT3lNpNkZhqrKyDk4zz+iQo=
=PnbT
-----END PGP SIGNATURE-----

--LYLKlmUwV+uWKKpP--

