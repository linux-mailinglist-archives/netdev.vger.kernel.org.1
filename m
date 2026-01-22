Return-Path: <netdev+bounces-252545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCLzF5+dcmkFnAAAu9opvQ
	(envelope-from <netdev+bounces-252545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:58:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1406DFED
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E767300CC05
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF803921E7;
	Thu, 22 Jan 2026 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlSTMKvg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12EA3C1FC5;
	Thu, 22 Jan 2026 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119130; cv=none; b=iucFhPSpa4jgIzVQC9/uTMaUG4mJ1AGlJ+fzdATMhRKT0jCsIzRlbztCgRXPqQvLqXG7vcq0J6AUBRku2QUWxd5dkiR2kCpZERxzcUU5gm6TgtUDzHXtAPzGWa7Ei6vClVRz/OIbhObXT87uQmCbM5parMlyCM2n/vURTx1xeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119130; c=relaxed/simple;
	bh=Mfr7mIDtrzBzLCBXMkoZgIUe7cfiZ3c8E1WWNlDsMMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyQcaK3d8YmlzpZ5jAP8CdEZ7IGTETzbvZVb1PSj34OhmKC0c/beUCAUFIWs0Won1gTUHbeaqJjfA0jBTVxM3LMP8EiFjyk/7qRyUwLnx8p8+if3SGAUhrPasbjE8UX7thmvRhc0ApvNZI9w3RRl38MkL0Ukoo5AlZmQjhrpSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlSTMKvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91A2C116C6;
	Thu, 22 Jan 2026 21:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119130;
	bh=Mfr7mIDtrzBzLCBXMkoZgIUe7cfiZ3c8E1WWNlDsMMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlSTMKvgK4NcWm0tAwyXT1wlKt6TiF9g91K8yfQhJbI3P/YJaKzWRRYXG0IicIB2w
	 r92M8GtL9dH1tEXH5MANaXQ2e0f27q/0LzBNcAeOcZZXE0YOG+L5maCDRSryLB7c74
	 e9CijWX3zDp6kC/54V2X+LPqLNodeaKIt5W8WyM9PnzyuxkX95Y/rAcas5+P5Ktp2n
	 S/ccB0imNTp4BL8bBNLj4vWxS3N+Bui+YiYmEAwiV62eqF8p+1qK7cgD2VrWRMpCwU
	 bzP6fhzxnslfzu67hx1fGMO/UOv9MhaeuWq2OCsKyySTWSk6ysAHEtMZgUSIf318Gi
	 AEISUhwRi4Hvw==
Date: Thu, 22 Jan 2026 22:58:47 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Use u64_stats_t with
 u64_stats_sync properly
Message-ID: <aXKdl8N7YPTbEtFZ@lore-desk>
References: <20260122185255.2761568-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ONLtqPOzoLLC9PQz"
Content-Disposition: inline
In-Reply-To: <20260122185255.2761568-1-mmyangfl@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252545-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF1406DFED
X-Rspamd-Action: no action


--ONLtqPOzoLLC9PQz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.

I guess we need a Fixes tag here.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 136 +++++++++++------------
>  drivers/net/ethernet/airoha/airoha_eth.h |  34 +++---
>  2 files changed, 85 insertions(+), 85 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 62bcbbbe2a95..6ed220e5a094 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1472,131 +1472,131 @@ static void airoha_update_hw_stats(struct airoh=
a_gdm_port *port)
> =20
>  	/* TX */
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> -	port->stats.tx_ok_pkts +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_ok_pkts, (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> -	port->stats.tx_ok_pkts +=3D val;
> +	u64_stats_add(&port->stats.tx_ok_pkts, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
> -	port->stats.tx_ok_bytes +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_ok_bytes, (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
> -	port->stats.tx_ok_bytes +=3D val;
> +	u64_stats_add(&port->stats.tx_ok_bytes, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
> -	port->stats.tx_drops +=3D val;
> +	u64_stats_add(&port->stats.tx_drops, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
> -	port->stats.tx_broadcast +=3D val;
> +	u64_stats_add(&port->stats.tx_broadcast, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
> -	port->stats.tx_multicast +=3D val;
> +	u64_stats_add(&port->stats.tx_multicast, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
> -	port->stats.tx_len[i] +=3D val;
> +	u64_stats_add(&port->stats.tx_len[i], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
> -	port->stats.tx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
> -	port->stats.tx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.tx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
> -	port->stats.tx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
> -	port->stats.tx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.tx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
> -	port->stats.tx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
> -	port->stats.tx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.tx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
> -	port->stats.tx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
> -	port->stats.tx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.tx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
> -	port->stats.tx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
> -	port->stats.tx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.tx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
> -	port->stats.tx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
> -	port->stats.tx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.tx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
> -	port->stats.tx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.tx_len[i++], val);
> =20
>  	/* RX */
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
> -	port->stats.rx_ok_pkts +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.rx_ok_pkts, (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
> -	port->stats.rx_ok_pkts +=3D val;
> +	u64_stats_add(&port->stats.rx_ok_pkts, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
> -	port->stats.rx_ok_bytes +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.rx_ok_bytes, (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
> -	port->stats.rx_ok_bytes +=3D val;
> +	u64_stats_add(&port->stats.rx_ok_bytes, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
> -	port->stats.rx_drops +=3D val;
> +	u64_stats_add(&port->stats.rx_drops, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
> -	port->stats.rx_broadcast +=3D val;
> +	u64_stats_add(&port->stats.rx_broadcast, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
> -	port->stats.rx_multicast +=3D val;
> +	u64_stats_add(&port->stats.rx_multicast, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
> -	port->stats.rx_errors +=3D val;
> +	u64_stats_add(&port->stats.rx_errors, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
> -	port->stats.rx_crc_error +=3D val;
> +	u64_stats_add(&port->stats.rx_crc_error, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
> -	port->stats.rx_over_errors +=3D val;
> +	u64_stats_add(&port->stats.rx_over_errors, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
> -	port->stats.rx_fragment +=3D val;
> +	u64_stats_add(&port->stats.rx_fragment, val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
> -	port->stats.rx_jabber +=3D val;
> +	u64_stats_add(&port->stats.rx_jabber, val);
> =20
>  	i =3D 0;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
> -	port->stats.rx_len[i] +=3D val;
> +	u64_stats_add(&port->stats.rx_len[i], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
> -	port->stats.rx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
> -	port->stats.rx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.rx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
> -	port->stats.rx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
> -	port->stats.rx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.rx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
> -	port->stats.rx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
> -	port->stats.rx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.rx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
> -	port->stats.rx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
> -	port->stats.rx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.rx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
> -	port->stats.rx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
> -	port->stats.rx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.rx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
> -	port->stats.rx_len[i] +=3D ((u64)val << 32);
> +	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
> -	port->stats.rx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.rx_len[i++], val);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
> -	port->stats.rx_len[i++] +=3D val;
> +	u64_stats_add(&port->stats.rx_len[i++], val);
> =20
>  	/* reset mib counters */
>  	airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(port->id),
> @@ -1795,16 +1795,16 @@ static void airoha_dev_get_stats64(struct net_dev=
ice *dev,
>  	airoha_update_hw_stats(port);
>  	do {
>  		start =3D u64_stats_fetch_begin(&port->stats.syncp);
> -		storage->rx_packets =3D port->stats.rx_ok_pkts;
> -		storage->tx_packets =3D port->stats.tx_ok_pkts;
> -		storage->rx_bytes =3D port->stats.rx_ok_bytes;
> -		storage->tx_bytes =3D port->stats.tx_ok_bytes;
> -		storage->multicast =3D port->stats.rx_multicast;
> -		storage->rx_errors =3D port->stats.rx_errors;
> -		storage->rx_dropped =3D port->stats.rx_drops;
> -		storage->tx_dropped =3D port->stats.tx_drops;
> -		storage->rx_crc_errors =3D port->stats.rx_crc_error;
> -		storage->rx_over_errors =3D port->stats.rx_over_errors;
> +		storage->rx_packets =3D u64_stats_read(&port->stats.rx_ok_pkts);
> +		storage->tx_packets =3D u64_stats_read(&port->stats.tx_ok_pkts);
> +		storage->rx_bytes =3D u64_stats_read(&port->stats.rx_ok_bytes);
> +		storage->tx_bytes =3D u64_stats_read(&port->stats.tx_ok_bytes);
> +		storage->multicast =3D u64_stats_read(&port->stats.rx_multicast);
> +		storage->rx_errors =3D u64_stats_read(&port->stats.rx_errors);
> +		storage->rx_dropped =3D u64_stats_read(&port->stats.rx_drops);
> +		storage->tx_dropped =3D u64_stats_read(&port->stats.tx_drops);
> +		storage->rx_crc_errors =3D u64_stats_read(&port->stats.rx_crc_error);
> +		storage->rx_over_errors =3D u64_stats_read(&port->stats.rx_over_errors=
);
>  	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
>  }
> =20
> @@ -2057,13 +2057,13 @@ static void airoha_ethtool_get_mac_stats(struct n=
et_device *dev,
>  	airoha_update_hw_stats(port);
>  	do {
>  		start =3D u64_stats_fetch_begin(&port->stats.syncp);
> -		stats->FramesTransmittedOK =3D port->stats.tx_ok_pkts;
> -		stats->OctetsTransmittedOK =3D port->stats.tx_ok_bytes;
> -		stats->MulticastFramesXmittedOK =3D port->stats.tx_multicast;
> -		stats->BroadcastFramesXmittedOK =3D port->stats.tx_broadcast;
> -		stats->FramesReceivedOK =3D port->stats.rx_ok_pkts;
> -		stats->OctetsReceivedOK =3D port->stats.rx_ok_bytes;
> -		stats->BroadcastFramesReceivedOK =3D port->stats.rx_broadcast;
> +		stats->FramesTransmittedOK =3D u64_stats_read(&port->stats.tx_ok_pkts);
> +		stats->OctetsTransmittedOK =3D u64_stats_read(&port->stats.tx_ok_bytes=
);
> +		stats->MulticastFramesXmittedOK =3D u64_stats_read(&port->stats.tx_mul=
ticast);
> +		stats->BroadcastFramesXmittedOK =3D u64_stats_read(&port->stats.tx_bro=
adcast);
> +		stats->FramesReceivedOK =3D u64_stats_read(&port->stats.rx_ok_pkts);
> +		stats->OctetsReceivedOK =3D u64_stats_read(&port->stats.rx_ok_bytes);
> +		stats->BroadcastFramesReceivedOK =3D u64_stats_read(&port->stats.rx_br=
oadcast);
>  	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
>  }
> =20
> @@ -2098,12 +2098,12 @@ airoha_ethtool_get_rmon_stats(struct net_device *=
dev,
>  		int i;
> =20
>  		start =3D u64_stats_fetch_begin(&port->stats.syncp);
> -		stats->fragments =3D hw_stats->rx_fragment;
> -		stats->jabbers =3D hw_stats->rx_jabber;
> +		stats->fragments =3D u64_stats_read(&hw_stats->rx_fragment);
> +		stats->jabbers =3D u64_stats_read(&hw_stats->rx_jabber);
>  		for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_rmon_ranges) - 1;
>  		     i++) {
> -			stats->hist[i] =3D hw_stats->rx_len[i];
> -			stats->hist_tx[i] =3D hw_stats->tx_len[i];
> +			stats->hist[i] =3D u64_stats_read(&hw_stats->rx_len[i]);
> +			stats->hist_tx[i] =3D u64_stats_read(&hw_stats->tx_len[i]);
>  		}
>  	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 20e602d61e61..b2e9bd849f8b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -215,24 +215,24 @@ struct airoha_hw_stats {
>  	struct u64_stats_sync syncp;
> =20
>  	/* get_stats64 */
> -	u64 rx_ok_pkts;
> -	u64 tx_ok_pkts;
> -	u64 rx_ok_bytes;
> -	u64 tx_ok_bytes;
> -	u64 rx_multicast;
> -	u64 rx_errors;
> -	u64 rx_drops;
> -	u64 tx_drops;
> -	u64 rx_crc_error;
> -	u64 rx_over_errors;
> +	u64_stats_t rx_ok_pkts;
> +	u64_stats_t tx_ok_pkts;
> +	u64_stats_t rx_ok_bytes;
> +	u64_stats_t tx_ok_bytes;
> +	u64_stats_t rx_multicast;
> +	u64_stats_t rx_errors;
> +	u64_stats_t rx_drops;
> +	u64_stats_t tx_drops;
> +	u64_stats_t rx_crc_error;
> +	u64_stats_t rx_over_errors;
>  	/* ethtool stats */
> -	u64 tx_broadcast;
> -	u64 tx_multicast;
> -	u64 tx_len[7];
> -	u64 rx_broadcast;
> -	u64 rx_fragment;
> -	u64 rx_jabber;
> -	u64 rx_len[7];
> +	u64_stats_t tx_broadcast;
> +	u64_stats_t tx_multicast;
> +	u64_stats_t tx_len[7];
> +	u64_stats_t rx_broadcast;
> +	u64_stats_t rx_fragment;
> +	u64_stats_t rx_jabber;
> +	u64_stats_t rx_len[7];
>  };
> =20
>  enum {
> --=20
> 2.51.0
>=20

--ONLtqPOzoLLC9PQz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaXKdlwAKCRA6cBh0uS2t
rB8qAP4i+/X9hpN9af9mEBX687u+dKpPq5MD8M5X4FtRR0VKXQEAnJujR6H52o/e
jpplETvS44lswKpFqQalJXJ1RTisqQY=
=slEj
-----END PGP SIGNATURE-----

--ONLtqPOzoLLC9PQz--

