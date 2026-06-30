Return-Path: <netdev+bounces-303234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EDOzOIzRQ2pIjQoAu9opvQ
	(envelope-from <netdev+bounces-303234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:24:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BA6E5643
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:24:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a+fkrxwE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303234-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 611413006F22
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E198425CD9;
	Tue, 30 Jun 2026 14:21:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6D2EBB84;
	Tue, 30 Jun 2026 14:21:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829301; cv=none; b=IE3E9c4vQSp66EL1axvmoTpBEde00kzJI/0tBILI92JhcvIf1oliBUZelwriv2DAE+50cl5cEGrATdQSJ3zB/3JVWPudOvEfex7hqnXiEWDk2+rD9s8Xg9wED41JYwHYqTOkQf+PylqbTdl+PeB5Kxypxs85XVxYPmc3GEs8Lik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829301; c=relaxed/simple;
	bh=QsREOLJFh57cHAq21t4e7UI47w1WViaoDe87CAIdT6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdVxAtnoRPAnsmRqupDlWw/tGAJSJ+pedSOf+f5PEXLBNXdUnPr6WkBRaerAynzCZG1or9fCdMwjXzsoKykL4FQ7GEOHJ9aYP0fiq5XEMTTwUoA2oHLzV4EX7It3oUf8X4V13EOws9FiANbF7snSi+jz4dZOZAtcYc90Jr1bzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+fkrxwE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92621F000E9;
	Tue, 30 Jun 2026 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829295;
	bh=uf3tZtSzNbehh4Nx6CrO/toFKRJaA2UElBa8z8KsYfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+fkrxwE2viVklnDIJaB2owP/yudzqZiTItfQ62ffCrrQ2XwRjm1UmnGuQJKwiw7u
	 MydEBg9SWU39wQrK+vJh0PuAukrp6wjhZhU2Am+o/Rb7zgXK5KX7yLm2avKtEndyKp
	 ERq2JFO2jAA+hUvREQN5fCGHZdSFm5RKL2YwkSJr9qWMbzHkVD7GfpYZtQjkmSvE5K
	 zOWo8SmLKNlHokaTnLv7di9cW3u9I2cU0c8dtzZDKDa7dvfQRTzXzXHY0Wvcnjw7AX
	 mtvmmEQmy8+nzgXpdYExsJROf8h5kva3QizjfZ0UxebUi4Tl6itRZGBso7XC6+RSTP
	 zMo8J5mUYSNKA==
Date: Tue, 30 Jun 2026 16:21:32 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Aniket Negi <aniket.negi03@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: airoha: fix MIB stats collection to be lossless
Message-ID: <akPQ7P1Dqb00oWa3@lore-desk>
References: <20260630111834.233643-1-aniket.negi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yOBFIEcluc84Gy5g"
Content-Disposition: inline
In-Reply-To: <20260630111834.233643-1-aniket.negi03@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aniket.negi03@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ansuelsmth@gmail.com,m:horms@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:aniketnegi03@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303234-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.103.45.18:received,100.90.174.1:received];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 585BA6E5643


--yOBFIEcluc84Gy5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The airoha_dev_get_hw_stats() function had two correctness issues in the
> way it collects hardware MIB counters.
>=20
> Bug 1: Read-clear race causes silent packet loss in statistics
>=20
> airoha_update_hw_stats() read all MIB registers and then cleared them
> via REG_FE_GDM_MIB_CLEAR. There is a time window between the last
> register read and the hardware clear. Any packet that the hardware
> counts during this window is lost: the register is incremented, then
> cleared, without the increment ever being read by software. Under
> sustained traffic this causes a permanent and growing undercount in all
> reported statistics.
>=20
> This is particularly misleading for tx_ok_pkts and tx_ok_bytes, which
> routers and traffic monitors use to detect packet forwarding loss
> between two points in a hardware-accelerated path (e.g., between two
> netdevs in the QDMA/PPE fast-path). An inaccurate count makes it
> impossible to reliably attribute drops in the forwarding pipeline
> without capturing traffic at both ends independently.
>=20
> Bug 2: 32-bit counter overflow causes stat corruption
>=20
> Several MIB registers are only 32 bits wide: tx_drops, tx_broadcast,
> tx_multicast, rx_drops, rx_broadcast, rx_multicast, rx_errors,
> rx_crc_error, rx_over_errors, rx_fragment, rx_jabber, and the runt and
> long buckets of the tx_len[]/rx_len[].
>=20
> The original code relied on MIB_CLEAR to keep register values small
> enough that a simple '+=3D val' per cycle did not lose data across a
> wrap. Once clearing is removed (to fix Bug 1), raw '+=3D val' silently
> corrupts the accumulated software counter on overflow.
>=20
> Fix both issues together:
>=20
> - 64-bit H+L register pairs (tx_ok_pkts, tx_ok_bytes, tx_len[1..5],
>   rx_ok_pkts, rx_ok_bytes, rx_len[1..5]): read directly from hardware
>   without clearing. Hardware accumulates the full running total; a
>   single direct assignment per poll is correct and lossless.
>=20
> - 32-bit registers (tx_drops, tx_broadcast, tx_multicast, rx_drops,
>   rx_broadcast, rx_multicast, rx_errors, rx_crc_error, rx_over_errors,
>   rx_fragment, rx_jabber, and the runt/long buckets in tx_len[0]/[6]
>   and rx_len[0]/[6]): track the previous hardware value in a new
>   hw_prev_stats sub-struct inside airoha_hw_stats and accumulate
>   (u32)(curr - prev) into the 64-bit software counter. Unsigned
>   subtraction handles wrap-around transparently:
>   prev=3D0xFFFFFF00, curr=3D0x00000010 -> delta=3D(u32)(0x10-0xFFFFFF00)=
=3D0x110
>=20
> Remove the REG_FE_GDM_MIB_CLEAR write from airoha_update_hw_stats()
> entirely. Because the driver no longer clears hardware counters, the
> read-clear race window is eliminated.
>=20
> The hw_prev_stats fields are zero-initialised by the existing
> devm_kzalloc() call in airoha_alloc_gdm_device().
>=20
> Fixes: 8f4695fb67b2 ("net: airoha: better handle MIBs for GDM ports with =
multiple devs attached")
> Signed-off-by: Aniket Negi <aniket.negi03@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 132 +++++++++++------------
>  drivers/net/ethernet/airoha/airoha_eth.h |  22 ++++
>  2 files changed, 86 insertions(+), 68 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 1caf6766f2c0..7ae4e294478e 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1696,133 +1696,133 @@ static void airoha_dev_get_hw_stats(struct airo=
ha_gdm_dev *dev)
> =20
>  	u64_stats_update_begin(&dev->stats.syncp);
> =20
> -	/* TX */
> +	/* TX - 64-bit H+L registers: hw accumulates the total, read directly. =
*/
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> -	dev->stats.tx_ok_pkts +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> -	dev->stats.tx_ok_pkts +=3D val;
> +	dev->stats.tx_ok_pkts =3D (u64)val << 32;

I guess it is more readable to store REG_FE_GDM_TX_OK_PKT_CNT_L() read in v=
al
here. Something like:

	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
	dev->stats.tx_ok_pkts +=3D val;

This apply even to occurrence below

> +	dev->stats.tx_ok_pkts +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L=
(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
> -	dev->stats.tx_ok_bytes +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
> -	dev->stats.tx_ok_bytes +=3D val;
> +	dev->stats.tx_ok_bytes =3D (u64)val << 32;
> +	dev->stats.tx_ok_bytes +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT=
_L(port->id));
> =20
> +	/* TX - 32-bit registers: accumulate delta to handle wrap-around. */
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
> -	dev->stats.tx_drops +=3D val;
> +	dev->stats.tx_drops +=3D (u32)(val - dev->stats.hw_prev_stats.tx_drops);
> +	dev->stats.hw_prev_stats.tx_drops =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
> -	dev->stats.tx_broadcast +=3D val;
> +	dev->stats.tx_broadcast +=3D (u32)(val - dev->stats.hw_prev_stats.tx_br=
oadcast);
> +	dev->stats.hw_prev_stats.tx_broadcast =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
> -	dev->stats.tx_multicast +=3D val;
> +	dev->stats.tx_multicast +=3D (u32)(val - dev->stats.hw_prev_stats.tx_mu=
lticast);
> +	dev->stats.hw_prev_stats.tx_multicast =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
> -	dev->stats.tx_len[i] +=3D val;
> +	dev->stats.tx_len[i] +=3D (u32)(val - dev->stats.hw_prev_stats.tx_len[i=
]);
> +	dev->stats.hw_prev_stats.tx_len[i] =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	dev->stats.tx_len[i] +=3D (u64)val << 32;

Since now we do not reset MIB counters, this is wrong, you can't use "+=3D"

> +	dev->stats.tx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT=
_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
> +	dev->stats.tx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT=
_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
> +	dev->stats.tx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CN=
T_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
> +	dev->stats.tx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CN=
T_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
> +	dev->stats.tx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CN=
T_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
> +	dev->stats.tx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_C=
NT_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	dev->stats.tx_len[i] +=3D (u32)(val - dev->stats.hw_prev_stats.tx_len[i=
]);
> +	dev->stats.hw_prev_stats.tx_len[i++] =3D val;
> =20
>  	/* RX */
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
> -	dev->stats.rx_ok_pkts +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
> -	dev->stats.rx_ok_pkts +=3D val;
> +	dev->stats.rx_ok_pkts =3D (u64)val << 32;
> +	dev->stats.rx_ok_pkts +=3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L=
(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
> -	dev->stats.rx_ok_bytes +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
> -	dev->stats.rx_ok_bytes +=3D val;
> +	dev->stats.rx_ok_bytes =3D (u64)val << 32;
> +	dev->stats.rx_ok_bytes +=3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT=
_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
> -	dev->stats.rx_drops +=3D val;
> +	dev->stats.rx_drops +=3D (u32)(val - dev->stats.hw_prev_stats.rx_drops);
> +	dev->stats.hw_prev_stats.rx_drops =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
> -	dev->stats.rx_broadcast +=3D val;
> +	dev->stats.rx_broadcast +=3D (u32)(val - dev->stats.hw_prev_stats.rx_br=
oadcast);
> +	dev->stats.hw_prev_stats.rx_broadcast =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
> -	dev->stats.rx_multicast +=3D val;
> +	dev->stats.rx_multicast +=3D (u32)(val - dev->stats.hw_prev_stats.rx_mu=
lticast);
> +	dev->stats.hw_prev_stats.rx_multicast =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
> -	dev->stats.rx_errors +=3D val;
> +	dev->stats.rx_errors +=3D (u32)(val - dev->stats.hw_prev_stats.rx_error=
s);
> +	dev->stats.hw_prev_stats.rx_errors =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
> -	dev->stats.rx_crc_error +=3D val;
> +	dev->stats.rx_crc_error +=3D (u32)(val - dev->stats.hw_prev_stats.rx_cr=
c_error);
> +	dev->stats.hw_prev_stats.rx_crc_error =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
> -	dev->stats.rx_over_errors +=3D val;
> +	dev->stats.rx_over_errors +=3D (u32)(val - dev->stats.hw_prev_stats.rx_=
over_errors);
> +	dev->stats.hw_prev_stats.rx_over_errors =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
> -	dev->stats.rx_fragment +=3D val;
> +	dev->stats.rx_fragment +=3D (u32)(val - dev->stats.hw_prev_stats.rx_fra=
gment);
> +	dev->stats.hw_prev_stats.rx_fragment =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
> -	dev->stats.rx_jabber +=3D val;
> +	dev->stats.rx_jabber +=3D (u32)(val - dev->stats.hw_prev_stats.rx_jabbe=
r);
> +	dev->stats.hw_prev_stats.rx_jabber =3D val;
> =20
>  	i =3D 0;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
> -	dev->stats.rx_len[i] +=3D val;
> +	dev->stats.rx_len[i] +=3D (u32)(val - dev->stats.hw_prev_stats.rx_len[i=
]);
> +	dev->stats.hw_prev_stats.rx_len[i] =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	dev->stats.rx_len[i] +=3D (u64)val << 32;

same here.

> +	dev->stats.rx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT=
_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
> +	dev->stats.rx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT=
_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
> +	dev->stats.rx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CN=
T_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
> +	dev->stats.rx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CN=
T_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
> +	dev->stats.rx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CN=
T_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> -	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
> +	dev->stats.rx_len[i++] +=3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_C=
NT_L(port->id));
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	dev->stats.rx_len[i] +=3D (u32)(val - dev->stats.hw_prev_stats.rx_len[i=
]);
> +	dev->stats.hw_prev_stats.rx_len[i++] =3D val;
> =20
>  	u64_stats_update_end(&dev->stats.syncp);
>  }
> @@ -1839,10 +1839,6 @@ static void airoha_update_hw_stats(struct airoha_g=
dm_dev *dev)
>  			airoha_dev_get_hw_stats(port->devs[i]);
>  	}
> =20
> -	/* Reset MIB counters */
> -	airoha_fe_set(dev->eth, REG_FE_GDM_MIB_CLEAR(port->id),
> -		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
> -
>  	spin_unlock(&port->stats_lock);
>  }
> =20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 2765244d937c..af12ad6eac17 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -244,6 +244,28 @@ struct airoha_hw_stats {
>  	u64 rx_fragment;
>  	u64 rx_jabber;
>  	u64 rx_len[7];
> +
> +	struct {
> +	/* Previous HW register values for 32-bit counter delta tracking.
> +	 * Storing the last seen value and accumulating (u32)(curr - prev)
> +	 * in 64-bit software counter & handles wrap-around transparently
> +	 * via unsigned arithmetic. These fields are never reported to
> +	 * userspace.
> +	 */

can you please align the comment here?

> +		u32 tx_drops;
> +		u32 tx_broadcast;
> +		u32 tx_multicast;
> +		u32 tx_len[7];
> +		u32 rx_drops;
> +		u32 rx_broadcast;
> +		u32 rx_multicast;
> +		u32 rx_errors;
> +		u32 rx_crc_error;
> +		u32 rx_over_errors;
> +		u32 rx_fragment;
> +		u32 rx_jabber;
> +		u32 rx_len[7];
> +	} hw_prev_stats;

Maybe something like "prev_val32" ?

Regards,
Lorenzo

>  };
> =20
>  enum {
> --=20
> 2.43.0
>=20

--yOBFIEcluc84Gy5g
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakPQ7AAKCRA6cBh0uS2t
rBF4AQDoGxth7iXv5nW/hFOnhPAxlu91TAoRUN+EWUN8W0qKcQD/Vqa2O4h9tDgX
7WNDy8zAOyP1AXvXVKK+bbdS0SQXLAQ=
=J9zf
-----END PGP SIGNATURE-----

--yOBFIEcluc84Gy5g--

