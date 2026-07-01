Return-Path: <netdev+bounces-303887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YjJ1CByYRWq9CgsAu9opvQ
	(envelope-from <netdev+bounces-303887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:43:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80B6F2234
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:43:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S6eGCbfu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303887-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303887-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56C613009E13
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDEC3ABDA4;
	Wed,  1 Jul 2026 22:43:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84524239085;
	Wed,  1 Jul 2026 22:43:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782945813; cv=none; b=eW1sOZqZ9aarJnIY+OoxR48GZyzj6xJR7Gx9+MrfLeNYuw0NlgvOkf/PS9tiKvyJ59m6QNwnuQq4v5ztzmv8MbCsU4mrZ6t17rFXXTK2eBajWSiIc/41dcaQsTf5uejYhB7OkWoDRphl4erQuWrI9G8W+CbaXt6aNwDpQHFIq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782945813; c=relaxed/simple;
	bh=SHiao2IBtC9KZ/uDMpRsEiST/OPYZRQIIOh33XGearI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGCjJjpHkthIHVLiDDAp05Q1qf2YUKxRR9t+bwkgdmw035LLan6oq7ur9fs5UZ1gVY73+n7dp1VREakzNsKrsWPeUycj8kX2E2VQxNmcqJGdxYV4jD242y4apPUJOVD5bgHCKrL1DXQpz+LfHFY1AlkUIGH39JETcqYFUF8cYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6eGCbfu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916711F000E9;
	Wed,  1 Jul 2026 22:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782945812;
	bh=wmf0yIErl+HxkobvYAzz7ozHbW2IIVmNhGXMLcFGe94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S6eGCbfuLq7coiGwPOBQ+CoM9l4p0roRt3RBFZsFi5yWHPyH7XIBstSio2/ezP/Dg
	 xatrM1i1Pt8E2FIKnnpzmS1Cz61vVqyTV946KGDKf7KXucgTOzcXW0Ny2+b1i7wWTm
	 yJxHG/12eRqWCWX0jUtsfmrDS5GxhZJPNoYrwL0bDdYR506pFmUSRZAUhiCM7k9n1L
	 iqGAyAAF0VGq8s44xDS06NIr+ezeXifRE7VDF9lcoV57hHjRr2jeYFphIry6bsXlc+
	 BOlwxHWOGOTDr0IuSHdD8P5svvWkq5Eh24/9RCsNx1xezychxYsBBnVWOxZVM9mIiU
	 CCn/+8jhsDAAQ==
Date: Thu, 2 Jul 2026 00:43:29 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Aniket Negi <aniket.negi03@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: fix MIB stats collection to be
 lossless
Message-ID: <akWYEf5wusTq9_ol@lore-desk>
References: <20260630111834.233643-1-aniket.negi03@gmail.com>
 <20260701173941.314795-1-aniket.negi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GwVceFzz02rhH5Cx"
Content-Disposition: inline
In-Reply-To: <20260701173941.314795-1-aniket.negi03@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303887-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:aniket.negi03@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:aniketnegi03@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A80B6F2234


--GwVceFzz02rhH5Cx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The current driver resets hardware MIB counters after every read via
> REG_FE_GDM_MIB_CLEAR. This creates a race window: packets arriving
> between the read and the clear are silently lost from statistics.
>=20
> Fix this by removing the MIB clear and switching to a delta-based
> software tracking approach:
>=20
> - 64-bit H+L registers (tx/rx ok pkts, ok bytes, E64..L1023):
>   read the absolute hardware total directly each poll.
>=20
> - 32-bit registers (drops, bc, mc, errors, runt, long, ...):
>   store the previous raw register value in mib_prev and accumulate
>   (u32)(curr - prev) into a 64-bit software counter. Unsigned
>   subtraction handles wrap-around transparently.
>=20
> - tx_len[0]/rx_len[0] ({0,64} RMON bucket) combines RUNT_CNT
>   (32-bit, delta-tracked via mib_prev.tx_runt_cnt) and E64_CNT
>   (64-bit, absolute). A u64 accumulator tx_runt_accum64 holds the
>   running RUNT delta sum so that each poll sets:
>     tx_len[0] =3D tx_runt_accum64 + E64_abs
>   without double-counting the E64 value.
>=20
> Merge airoha_dev_get_hw_stats() into airoha_update_hw_stats(),
> moving the port spin_lock inside so callers do not need a separate
> wrapper.
>=20
> Signed-off-by: Aniket Negi <aniket.negi03@gmail.com>

Hi Aniket,

just few nits inline. Fixing them:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>=20
> Changes in v2:
>   - Store _CNT_L register reads in val before adding to stats, improving
>     readability (suggested by Lorenzo Bianconi)
>   - Fix double-counting bug in the RUNT+E64 combined bucket: previously
>     "+=3D" for E64 re-added the full absolute counter each poll; now a
>     dedicated tx_runt_accum64/rx_runt_accum64 accumulator holds the
>     running RUNT delta, and tx_len[0] is assigned (not accumulated) each
>     poll as runt_accum64 + E64_abs
>   - Replace 7-element tx_len[]/rx_len[] shadow arrays in mib_prev with
>     focused tx_runt_cnt/tx_long_cnt and rx_runt_cnt/rx_long_cnt fields;
>     only RUNT and LONG are 32-bit and need wrap-around tracking
>   - Rename inner struct hw_prev_stats to mib_prev; rename accumulator
>     fields to tx_runt_accum64/rx_runt_accum64 for clarity
>   - Fix comment alignment in mib_prev struct block
>   - Rename airoha_dev_get_hw_stats() to airoha_update_hw_stats() and
>     move the port spin_lock inside, removing the separate wrapper
>=20
>  drivers/net/ethernet/airoha/airoha_eth.c | 115 +++++++++++++----------
>  drivers/net/ethernet/airoha/airoha_eth.h |  27 ++++++
>  2 files changed, 92 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 59001fd4b6f7..4b7c547de165 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1686,12 +1686,14 @@ static void airoha_qdma_stop_napi(struct airoha_q=
dma *qdma)
>  	}
>  }
> =20
> -static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
> +static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
>  {
>  	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_eth *eth =3D dev->eth;
>  	u32 val, i =3D 0;
> =20
> +	spin_lock(&port->stats_lock);
> +
>  	/* Read relevant MIB for GDM with multiple port attached */
>  	if (port->id =3D=3D AIROHA_GDM3_IDX || port->id =3D=3D AIROHA_GDM4_IDX)
>  		airoha_fe_rmw(eth, REG_FE_GDM_MIB_CFG(port->id),
> @@ -1701,152 +1703,165 @@ static void airoha_dev_get_hw_stats(struct airo=
ha_gdm_dev *dev)
> =20
>  	u64_stats_update_begin(&dev->stats.syncp);
> =20
> -	/* TX */
> +	/* TX - 64-bit H+L registers: hw accumulates the total, read directly. =
*/
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> -	dev->stats.tx_ok_pkts +=3D ((u64)val << 32);
> +	dev->stats.tx_ok_pkts =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
>  	dev->stats.tx_ok_pkts +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
> -	dev->stats.tx_ok_bytes +=3D ((u64)val << 32);
> +	dev->stats.tx_ok_bytes =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
>  	dev->stats.tx_ok_bytes +=3D val;
> =20
> +	/* TX - 32-bit registers: accumulate delta to handle wrap-around. */
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
> -	dev->stats.tx_drops +=3D val;
> +	dev->stats.tx_drops +=3D (u32)(val - dev->stats.mib_prev.tx_drops);
> +	dev->stats.mib_prev.tx_drops =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
> -	dev->stats.tx_broadcast +=3D val;
> +	dev->stats.tx_broadcast +=3D (u32)(val - dev->stats.mib_prev.tx_broadca=
st);
> +	dev->stats.mib_prev.tx_broadcast =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
> -	dev->stats.tx_multicast +=3D val;
> +	dev->stats.tx_multicast +=3D (u32)(val - dev->stats.mib_prev.tx_multica=
st);
> +	dev->stats.mib_prev.tx_multicast =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
> -	dev->stats.tx_len[i] +=3D val;
> +	dev->stats.mib_prev.tx_runt_accum64 +=3D

I guess dev->stats.mib_prev.tx_runt64

> +		(u32)(val - dev->stats.mib_prev.tx_runt_cnt);

	dev->stats.mib_prev.tx_runt64 +=3D (u32)(val -
					       dev->stats.mib_prev.tx_runt);

> +	dev->stats.mib_prev.tx_runt_cnt =3D val;
> +
> +	/* tx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute) =E2=86=92 {=
0, 64} bucket.
> +	 * Accumulate RUNT delta in tx_runt_accum64, then assign tx_len[0] as
> +	 * accum + E64_abs so each call gives the correct combined total.
> +	 */

no new-line here.

> +
> +	dev->stats.tx_len[i] =3D dev->stats.mib_prev.tx_runt_accum64;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.tx_len[i] +=3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
>  	dev->stats.tx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
>  	dev->stats.tx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
>  	dev->stats.tx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
>  	dev->stats.tx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
>  	dev->stats.tx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.tx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
>  	dev->stats.tx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	dev->stats.tx_len[i++] +=3D (u32)(val - dev->stats.mib_prev.tx_long_cnt=
);
> +	dev->stats.mib_prev.tx_long_cnt =3D val;
> =20
>  	/* RX */
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
> -	dev->stats.rx_ok_pkts +=3D ((u64)val << 32);
> +	dev->stats.rx_ok_pkts =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
>  	dev->stats.rx_ok_pkts +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
> -	dev->stats.rx_ok_bytes +=3D ((u64)val << 32);
> +	dev->stats.rx_ok_bytes =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
>  	dev->stats.rx_ok_bytes +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
> -	dev->stats.rx_drops +=3D val;
> +	dev->stats.rx_drops +=3D (u32)(val - dev->stats.mib_prev.rx_drops);
> +	dev->stats.mib_prev.rx_drops =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
> -	dev->stats.rx_broadcast +=3D val;
> +	dev->stats.rx_broadcast +=3D (u32)(val - dev->stats.mib_prev.rx_broadca=
st);
> +	dev->stats.mib_prev.rx_broadcast =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
> -	dev->stats.rx_multicast +=3D val;
> +	dev->stats.rx_multicast +=3D (u32)(val - dev->stats.mib_prev.rx_multica=
st);
> +	dev->stats.mib_prev.rx_multicast =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
> -	dev->stats.rx_errors +=3D val;
> +	dev->stats.rx_errors +=3D (u32)(val - dev->stats.mib_prev.rx_errors);
> +	dev->stats.mib_prev.rx_errors =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
> -	dev->stats.rx_crc_error +=3D val;
> +	dev->stats.rx_crc_error +=3D (u32)(val - dev->stats.mib_prev.rx_crc_err=
or);
> +	dev->stats.mib_prev.rx_crc_error =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
> -	dev->stats.rx_over_errors +=3D val;
> +	dev->stats.rx_over_errors +=3D (u32)(val - dev->stats.mib_prev.rx_over_=
errors);
> +	dev->stats.mib_prev.rx_over_errors =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
> -	dev->stats.rx_fragment +=3D val;
> +	dev->stats.rx_fragment +=3D (u32)(val - dev->stats.mib_prev.rx_fragment=
);
> +	dev->stats.mib_prev.rx_fragment =3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
> -	dev->stats.rx_jabber +=3D val;
> +	dev->stats.rx_jabber +=3D (u32)(val - dev->stats.mib_prev.rx_jabber);
> +	dev->stats.mib_prev.rx_jabber =3D val;
> =20
>  	i =3D 0;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
> -	dev->stats.rx_len[i] +=3D val;
> +	dev->stats.mib_prev.rx_runt_accum64 +=3D
> +		(u32)(val - dev->stats.mib_prev.rx_runt_cnt);

ditto.

> +	dev->stats.mib_prev.rx_runt_cnt =3D val;
> +
> +	/* rx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute) =E2=86=92 {=
0, 64} bucket.
> +	 * then assign rx_len[0] =3D rx_runt_accum64 + E64_abs.
> +	 */
> =20
ditto.

> +	dev->stats.rx_len[i] =3D dev->stats.mib_prev.rx_runt_accum64;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.rx_len[i] +=3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
>  	dev->stats.rx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
>  	dev->stats.rx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
>  	dev->stats.rx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
>  	dev->stats.rx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
>  	dev->stats.rx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	dev->stats.rx_len[i] =3D (u64)val << 32;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
>  	dev->stats.rx_len[i++] +=3D val;
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	dev->stats.rx_len[i] +=3D (u32)(val - dev->stats.mib_prev.rx_long_cnt);
> +	dev->stats.mib_prev.rx_long_cnt =3D val;
> =20
>  	u64_stats_update_end(&dev->stats.syncp);
> -}
> -
> -static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
> -{
> -	struct airoha_gdm_port *port =3D dev->port;
> -	int i;
> -
> -	spin_lock(&port->stats_lock);
> -
> -	for (i =3D 0; i < ARRAY_SIZE(port->devs); i++) {
> -		if (port->devs[i])
> -			airoha_dev_get_hw_stats(port->devs[i]);
> -	}
> -
> -	/* Reset MIB counters */
> -	airoha_fe_set(dev->eth, REG_FE_GDM_MIB_CLEAR(port->id),
> -		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
> =20
>  	spin_unlock(&port->stats_lock);
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index f6d01a8e8da1..3af1c49dd62d 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -245,6 +245,33 @@ struct airoha_hw_stats {
>  	u64 rx_fragment;
>  	u64 rx_jabber;
>  	u64 rx_len[7];
> +
> +	struct {
> +		/* Previous HW register values for 32-bit counter delta
> +		 * tracking. Storing the last seen value and accumulating
> +		 * (u32)(curr - prev) into the 64-bit software counter
> +		 * handles wrap-around transparently via unsigned arithmetic.
> +		 * tx_runt_accum64/rx_runt_accum64 hold the running sum of
> +		 * runt deltas. These fields are never reported to userspace.
> +		 */
> +		u32 tx_drops;
> +		u32 tx_broadcast;
> +		u32 tx_multicast;
> +		u32 tx_runt_cnt;

		u32 tx_runt;

> +		u32 tx_long_cnt;

		u32 tx_long;

> +		u64 tx_runt_accum64;

		64 tx_runt64;

> +		u32 rx_drops;
> +		u32 rx_broadcast;
> +		u32 rx_multicast;
> +		u32 rx_errors;
> +		u32 rx_crc_error;
> +		u32 rx_over_errors;
> +		u32 rx_fragment;
> +		u32 rx_jabber;
> +		u32 rx_runt_cnt;

		u32 rx_runt;

> +		u32 rx_long_cnt;

		u32 rx_long;

> +		u64 rx_runt_accum64;

		u64 rx_runt64;

> +	} mib_prev;
>  };
> =20
>  enum {
>=20
> base-commit: a225f8c20712713406ae47024b8df42deacddd4a
> --=20
> 2.43.0
>=20

--GwVceFzz02rhH5Cx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakWYEQAKCRA6cBh0uS2t
rI/KAQDj7HnMgKz2CDJF2bsStuvQ8Yx1Lkss7GR1FTF+TdsnqgD+OrfAJNP8iTFH
XOEipPlOOiEnjr1+U91ZWspbMkK5PQM=
=+eVZ
-----END PGP SIGNATURE-----

--GwVceFzz02rhH5Cx--

