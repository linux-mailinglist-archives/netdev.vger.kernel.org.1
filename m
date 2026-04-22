Return-Path: <netdev+bounces-280472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBXvNSrz6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:11:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FFF4484C0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15CEF300E3AF
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC83264F7;
	Wed, 22 Apr 2026 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7e8pti7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B32FD665
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874169; cv=none; b=G0m9vusSld+8OCa8KALaV23OkWpEBHnSCZIWrFpBH+ymJMuoSX0txtUeiNu6/846n/lGnmXVhLO9ewxNzkxCqEgHo0+GhHoaU2i0C4Uz3kA5fGAezqGYKvjLKoJ6Uf6vCaOBquipMBk2Hr9Tx7J8ozmQVydXObrEhmG4sOd0RY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874169; c=relaxed/simple;
	bh=SBPYOB3ZXq1r3Di2k7yUx1oZXfbnIN5yGtjLEJy8hko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBzHDWjqzbcNpEZE1FCrpf/kWtRCrfzXif3zLhy5KR/Yj1+XpMTX9BssvaWJBqN9nzWrAQJjcotbKIyT/QmnXCEJvi9EtYHyWlVLU0bNLJrea5esCyecK5IZG6+VzyFmhgiN9ogcnW+3F1LzZEEeg8nW4NVzbYU61hDaHvFezYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7e8pti7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B0CC2BCAF;
	Wed, 22 Apr 2026 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874169;
	bh=SBPYOB3ZXq1r3Di2k7yUx1oZXfbnIN5yGtjLEJy8hko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7e8pti7lKvpIs1AkotuqIqFHzZdqo47cRmPEhe3/IYU0V2bRNpXpSjlkox//gteU
	 k4azoB6utVu+bjq0p19DnS9MhhEjWPzREcPm+HrHpvJBZmAOBJUR+9Yp+9VVs4aEoz
	 bJ79R5JTtCsBJnp6YEW+QcRRam29+dW5hUXWkUAjivG/SgvHCn0ewkKkXsS2P8Svon
	 Aqi2LG0zPzAVv1NchUws1iimiM2ja77at2rU0LeFi7WcxGKnMXcWaSrl+N/a7f8Wvg
	 4rFRNjM6deHxv3W5agmjB2Mb6Kyysafr6v+Efalb7aswbvvNF3uDMCOT3Fig2uWqdV
	 L97vpVYDCkoQw==
Date: Wed, 22 Apr 2026 18:09:26 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: airoha: Move ndesc initialization at end
 of airoha_qdma_init_rx_queue()
Message-ID: <aejyttYXyW_vzi8o@lore-desk>
References: <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
 <20260420-airoha_qdma_init_rx_queue-fix-v2-1-d99347e5c18d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kZko5lrIFyDnW20B"
Content-Disposition: inline
In-Reply-To: <20260420-airoha_qdma_init_rx_queue-fix-v2-1-d99347e5c18d@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 93FFF4484C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--kZko5lrIFyDnW20B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If queue entry or DMA descriptor list allocation fails in
> airoha_qdma_init_rx_queue routine, airoha_qdma_cleanup() will trigger a
> NULL pointer dereference running netif_napi_del() for RX queue NAPIs
> since netif_napi_add() has never been executed to this particular RX NAPI.
> The issue is due to the early ndesc initialization in
> airoha_qdma_init_rx_queue() since airoha_qdma_cleanup() relies on ndesc
> value to check if the queue is properly initialized. Fix the issue moving
> ndesc initialization at end of airoha_qdma_init_tx routine.
> Move page_pool allocation after descriptor list allocation in order to
> avoid memory leaks if desc allocation fails.
>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index e1ab15f1ee7d..fc79c456743c 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -745,14 +745,18 @@ static int airoha_qdma_init_rx_queue(struct airoha_=
queue *q,
>  	dma_addr_t dma_addr;
> =20
>  	q->buf_size =3D PAGE_SIZE / 2;
> -	q->ndesc =3D ndesc;
>  	q->qdma =3D qdma;
> =20
> -	q->entry =3D devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
> +	q->entry =3D devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
>  				GFP_KERNEL);
>  	if (!q->entry)
>  		return -ENOMEM;
> =20
> +	q->desc =3D dmam_alloc_coherent(eth->dev, ndesc * sizeof(*q->desc),
> +				      &dma_addr, GFP_KERNEL);
> +	if (!q->desc)
> +		return -ENOMEM;
> +
>  	q->page_pool =3D page_pool_create(&pp_params);
>  	if (IS_ERR(q->page_pool)) {
>  		int err =3D PTR_ERR(q->page_pool);
> @@ -761,11 +765,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_q=
ueue *q,
>  		return err;
>  	}
> =20
> -	q->desc =3D dmam_alloc_coherent(eth->dev, q->ndesc * sizeof(*q->desc),
> -				      &dma_addr, GFP_KERNEL);
> -	if (!q->desc)
> -		return -ENOMEM;
> -
> +	q->ndesc =3D ndesc;
>  	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
> =20
>  	airoha_qdma_wr(qdma, REG_RX_RING_BASE(qid), dma_addr);
>=20
> --=20
> 2.53.0
>=20

As requested, I am commenting the issue reported by Sashiko on this patch:
https://sashiko.dev/#/patchset/20260420-airoha_qdma_init_rx_queue-fix-v2-0-=
d99347e5c18d%40kernel.org

- Does this code leave a regression in the TX path by omitting the equivale=
nt fix?
  This issue is not related to this patch and already fixed here:
  https://patchwork.kernel.org/project/netdevbpf/patch/20260417-airoha_qdma=
_cleanup_tx_queue-fix-net-v4-1-e04bcc2c9642@kernel.org/

Regards,
Lorenzo

--kZko5lrIFyDnW20B
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaejytgAKCRA6cBh0uS2t
rNjYAPsE6vHRstqCNtY7VdsXgogfTMg3eIitwR4Cd7rx8vkc9wEAlT/aXD/pfWfU
I4HEEr6YV9z6AGOdd7AdPDauj/tIXww=
=6ghH
-----END PGP SIGNATURE-----

--kZko5lrIFyDnW20B--

