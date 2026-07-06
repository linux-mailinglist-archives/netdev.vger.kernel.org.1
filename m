Return-Path: <netdev+bounces-305226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4oxLA9YcTGoHggEAu9opvQ
	(envelope-from <netdev+bounces-305226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B2715B11
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:23:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nVB9hw2I;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305226-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305226-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62F16302A4C7
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5632C3AE193;
	Mon,  6 Jul 2026 21:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BB3AB28F;
	Mon,  6 Jul 2026 21:23:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373010; cv=none; b=oqmb4YmyNN9sEJZ9tIBof7ExJl3s9JDG/BDkSfTRQhP2n9lWaekg93vEtzXGoPWbXMM6TBSwT/1Qn5Q3P46i7CaaWypFU1zifdlyPhIUQFEVb0LcHrPbx1+4YRlF7u1ZZhhVB+g7Wobeo0qydzK6Wdm9CR3SCS95dLJQC6bH7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373010; c=relaxed/simple;
	bh=xou3rA9vIVb3Ie+Xl76POZXX5OwU8TadjIHDche3MqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwFkPu/q1tp0qcEujULJSGGhRq6HhqpeoKPwXmJE4G+LELTvr9y8Tz48kox5i4rbgU459s1ER26LXQkIbLN/17qr9RODqSQ5FcUOGknJ4iFL71XDkWMVWOPalRqIur62hKM0PDhATKbXQjIqFK+wyi4CLeDLhgCeFRwCxV0AfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVB9hw2I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B341F000E9;
	Mon,  6 Jul 2026 21:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783373008;
	bh=27TFgIkJwi3EqtbH1wXpLiyy+tC4lD8wNt7kzzWLi+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nVB9hw2IFy/VhHo8e4wIoh65JSm5oMvDEsmkYxIhiCxoX2F+0i+JFyMuYohMD48og
	 mv8SmEGwyckIlhxaPxU8mpwLdIELEJgMTAaMQGTzun998n3SXPXqLyVGXTKqU8p+zX
	 OBSUDwJAFM6hIGH0TIeLNTBsnUZSvEsKM4/oPFQRtAMmsIG8aHKRbas6eg2iwqC14B
	 8aOAWq6DUzLi8HMjko1b/acnHduLgIUnLKGmd3xUS5uY39s5mfYE+EyPtul2he7owg
	 LIqPuXIB+8kgNSHWVn3hsjgBHRAzrpPZl6gbfhQsFkOvqKiIe+SfzU8kZlVpeSJ217
	 c58wwCLLUvx5A==
Date: Mon, 6 Jul 2026 23:23:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Aniket Negi <aniket.negi03@gmail.com>
Cc: netdev@vger.kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, aniket.negi@airoha.com,
	kuldeep.malik@airoha.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: airoha: fix MIB stats collection to be
 lossless
Message-ID: <akwczc23LOGbKfMl@lore-desk>
References: <20260706154730.36949-1-aniket.negi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WnHbkR8+FLUtLHFk"
Content-Disposition: inline
In-Reply-To: <20260706154730.36949-1-aniket.negi03@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:aniket.negi03@gmail.com,m:netdev@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:aniket.negi@airoha.com,m:kuldeep.malik@airoha.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ansuelsmth@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:aniketnegi03@gmail.com,m:matthiasbgg@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305226-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,collabora.com,airoha.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B8B2715B11


--WnHbkR8+FLUtLHFk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> REG_FE_GDM_MIB_CLEAR after every read creates a race window where
> packets arriving between read and clear are lost from statistics.
>=20
> Switch to a delta-based approach instead:
>=20
> - 64-bit H+L registers (ok pkts/bytes, E64..L1023): read absolute
>   hardware total directly; use a local variable and max(new, old)
>   clamping to prevent intermediate visibility and torn-read regression.
>=20
> - 32-bit registers (drops, bc, mc, errors, runt, long): accumulate
>   (u32)(curr - prev) into a 64-bit software counter; unsigned
>   subtraction handles wrap-around transparently.
>=20
> - tx/rx_len[0] ([0,64] bucket): combines RUNT_CNT (32-bit, delta via
>   tx_runt/rx_runt) and E64_CNT (64-bit, absolute) into a single
>   assignment using a local accumulator to avoid double-counting.
>=20
> Clear MIB counters once in airoha_fe_init() to establish a clean
> baseline, preventing spurious stats from pre-driver activity (kexec,
> driver rebind, warm reboot).
>=20
> Merge airoha_dev_get_hw_stats() into airoha_update_hw_stats() and
> move stats_lock inside. Plain spin_lock() is correct: the function
> is only called from ndo_get_stats64() in process context. Each dev
> refreshes only its own MIB counters; sibling devs on a shared GDM3/4
> port are polled when their own netdev is queried.
>=20
> Fixes: 8f4695fb67b2 ("net: airoha: better handle MIBs for GDM ports with =
multiple devs attached")
> Signed-off-by: Aniket Negi <aniket.negi03@gmail.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v4:
> - Add max(new, old) clamping for 64-bit H+L register pairs to ensure
>   monotonically non-decreasing stats despite torn reads between H and L
> - Use local variable (tmp) for all 64-bit H+L computations to prevent
>   lockless readers from seeing intermediate values during piecewise write
> - Add one-shot MIB counter clear in airoha_fe_init() to establish a
>   clean baseline (kexec, driver rebind, warm reboot)
> - Document sibling dev polling design in commit message
>=20
> Changes in v3:
> - Link to V2: https://lore.kernel.org/20260701173941.314795-1-aniket.negi=
03@gmail.com/
> - Add Acked-by tag from Lorenzo
> - Rename from tx_runt_cnt to tx_runt, tx_long_cnt to tx_long,
>   tx_runt_accum64 to tx_runt64
> - Rename from rx_runt_cnt to rx_runt, rx_long_cnt to rx_long,
>   rx_runt_accum64 to rx_runt64
> - Condense the marked comments in V2, remove new line after comment
>=20
> Changes in v2:
> - Store _CNT_L register reads in val before adding to stats, improving
>   readability (suggested by Lorenzo Bianconi)
> - Fix double-counting bug in the RUNT+E64 combined bucket: previously
>   "+=3D" for E64 re-added the full absolute counter each poll; now a
>   dedicated tx_runt_accum64/rx_runt_accum64 accumulator holds the
>   running RUNT delta, and tx_len[0] is assigned (not accumulated) each
>   poll as runt_accum64 + E64_abs
> - Replace 7-element tx_len[]/rx_len[] shadow arrays in mib_prev with
>   focused tx_runt_cnt/tx_long_cnt and rx_runt_cnt/rx_long_cnt fields;
>   only RUNT and LONG are 32-bit and need wrap-around tracking
> - Rename inner struct hw_prev_stats to mib_prev; rename accumulator
>   fields to tx_runt_accum64/rx_runt_accum64 for clarity
> - Fix comment alignment in mib_prev struct block
> - Rename airoha_dev_get_hw_stats() to airoha_update_hw_stats() and
>   move the port spin_lock inside, removing the separate wrapper
>=20
>  drivers/net/ethernet/airoha/airoha_eth.c | 183 +++++++++++++++--------
>  drivers/net/ethernet/airoha/airoha_eth.h |  27 ++++
>  2 files changed, 144 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 59001fd4b6f7..2d032cc6dfca 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -493,6 +493,8 @@ static void airoha_fe_crsn_qsel_init(struct airoha_et=
h *eth)
> =20
>  static int airoha_fe_init(struct airoha_eth *eth)
>  {
> +	int i;
> +
>  	airoha_fe_maccr_init(eth);
> =20
>  	/* PSE IQ reserve */
> @@ -586,6 +588,14 @@ static int airoha_fe_init(struct airoha_eth *eth)
>  	/* enable 1:N vlan action, init vlan table */
>  	airoha_fe_set(eth, REG_MC_VLAN_EN, MC_VLAN_EN_MASK);
> =20
> +	/* Clear MIB counters to establish clean baseline for delta tracking.
> +	 * This prevents spurious statistics from pre-driver activity (e.g.,
> +	 * kexec, driver rebind, warm reboot) on first poll.
> +	 */
> +	for (i =3D AIROHA_GDM1_IDX; i <=3D AIROHA_GDM4_IDX; i++)
> +		airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(i),
> +			      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);

This configuration is not needed since we reset FE at module load.

> +
>  	return airoha_fe_mc_vlan_clear(eth);
>  }
> =20
> @@ -1686,11 +1696,14 @@ static void airoha_qdma_stop_napi(struct airoha_q=
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
> +	u64 tmp, prev;

nit: tmp is not so meaningful, maybe better something like data?

> +
> +	spin_lock(&port->stats_lock);
> =20
>  	/* Read relevant MIB for GDM with multiple port attached */
>  	if (port->id =3D=3D AIROHA_GDM3_IDX || port->id =3D=3D AIROHA_GDM4_IDX)
> @@ -1701,152 +1714,190 @@ static void airoha_dev_get_hw_stats(struct airo=
ha_gdm_dev *dev)
> =20
>  	u64_stats_update_begin(&dev->stats.syncp);
> =20
> -	/* TX */
> +	/* TX - 64-bit H+L registers: hw accumulates the total, read directly.
> +	 * Use local variable to prevent readers from seeing intermediate value=
s.
> +	 * Clamp to prevent regression from torn reads between H and L.
> +	 */
> +	prev =3D dev->stats.tx_ok_pkts;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> -	dev->stats.tx_ok_pkts +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);

nit: data =3D (u64)val << 32;

>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> -	dev->stats.tx_ok_pkts +=3D val;
> +	tmp |=3D val;

nit: I would prefer "+" instead of "|"

> +	dev->stats.tx_ok_pkts =3D max(tmp, prev);

nit: please drop prev and just do:
	dev->stats.tx_ok_pkts =3D max(data, dev->stats.tx_ok_pkts);

please redo it for all the occurrences.

Regards,
Lorenzo

> =20
> +	prev =3D dev->stats.tx_ok_bytes;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
> -	dev->stats.tx_ok_bytes +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
> -	dev->stats.tx_ok_bytes +=3D val;
> +	tmp |=3D val;
> +	dev->stats.tx_ok_bytes =3D max(tmp, prev);
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
> +	dev->stats.mib_prev.tx_runt64 +=3D
> +		(u32)(val - dev->stats.mib_prev.tx_runt);
> +	dev->stats.mib_prev.tx_runt =3D val;
> =20
> +	/* tx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute). */
> +	tmp =3D dev->stats.mib_prev.tx_runt64;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	tmp +=3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	tmp +=3D val;
> +	dev->stats.tx_len[i++] =3D tmp;
> =20
> +	prev =3D dev->stats.tx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.tx_len[i++] =3D max(tmp, prev);
> =20
> +	prev =3D dev->stats.tx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.tx_len[i++] =3D max(tmp, prev);
> =20
> +	prev =3D dev->stats.tx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.tx_len[i++] =3D max(tmp, prev);
> =20
> +	prev =3D dev->stats.tx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.tx_len[i++] =3D max(tmp, prev);
> =20
> +	prev =3D dev->stats.tx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
> -	dev->stats.tx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.tx_len[i++] =3D max(tmp, prev);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
> -	dev->stats.tx_len[i++] +=3D val;
> +	dev->stats.tx_len[i++] +=3D (u32)(val - dev->stats.mib_prev.tx_long);
> +	dev->stats.mib_prev.tx_long =3D val;
> =20
>  	/* RX */
> +	prev =3D dev->stats.rx_ok_pkts;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
> -	dev->stats.rx_ok_pkts +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
> -	dev->stats.rx_ok_pkts +=3D val;
> +	tmp |=3D val;
> +	dev->stats.rx_ok_pkts =3D max(tmp, prev);
> =20
> +	prev =3D dev->stats.rx_ok_bytes;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
> -	dev->stats.rx_ok_bytes +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
> -	dev->stats.rx_ok_bytes +=3D val;
> +	tmp |=3D val;
> +	dev->stats.rx_ok_bytes =3D max(tmp, prev);
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
> +	dev->stats.mib_prev.rx_runt64 +=3D
> +		(u32)(val - dev->stats.mib_prev.rx_runt);
> +	dev->stats.mib_prev.rx_runt =3D val;
> =20
> +	/* rx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute). */
> +	tmp =3D dev->stats.mib_prev.rx_runt64;
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	tmp +=3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	tmp +=3D val;
> +	dev->stats.rx_len[i++] =3D tmp;
> =20
> +	prev =3D dev->stats.rx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.rx_len[i++] =3D max(tmp, prev);
> =20
> +	prev =3D dev->stats.rx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.rx_len[i++] =3D max(tmp, prev);
> =20
> +	prev =3D dev->stats.rx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.rx_len[i++] =3D max(tmp, prev);
> =20
> +	prev =3D dev->stats.rx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.rx_len[i++] =3D max(tmp, prev);
> =20
> +	prev =3D dev->stats.rx_len[i];
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
> -	dev->stats.rx_len[i] +=3D ((u64)val << 32);
> +	tmp =3D ((u64)val << 32);
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	tmp |=3D val;
> +	dev->stats.rx_len[i++] =3D max(tmp, prev);
> =20
>  	val =3D airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
> -	dev->stats.rx_len[i++] +=3D val;
> +	dev->stats.rx_len[i] +=3D (u32)(val - dev->stats.mib_prev.rx_long);
> +	dev->stats.mib_prev.rx_long =3D val;
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
> index f6d01a8e8da1..fe934f9ffe8a 100644
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
> +		 * tx_runt64/rx_runt64 hold the running sum of runt deltas.
> +		 * These fields are never reported to userspace.
> +		 */
> +		u32 tx_drops;
> +		u32 tx_broadcast;
> +		u32 tx_multicast;
> +		u32 tx_runt;
> +		u32 tx_long;
> +		u64 tx_runt64;
> +		u32 rx_drops;
> +		u32 rx_broadcast;
> +		u32 rx_multicast;
> +		u32 rx_errors;
> +		u32 rx_crc_error;
> +		u32 rx_over_errors;
> +		u32 rx_fragment;
> +		u32 rx_jabber;
> +		u32 rx_runt;
> +		u32 rx_long;
> +		u64 rx_runt64;
> +	} mib_prev;
>  };
> =20
>  enum {
>=20
> base-commit: a225f8c20712713406ae47024b8df42deacddd4a
> --=20
> 2.43.0
>=20

--WnHbkR8+FLUtLHFk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakwczQAKCRA6cBh0uS2t
rBCKAQC+t+Uk1YQUuW7zW8Xam5tO2kvAT2JkCmZ6g+zMs6KRiQD+NkCws3mXiPdf
mKF6Cmo1mB+XD+N4TKGFuJBRX/jq0QY=
=NZnX
-----END PGP SIGNATURE-----

--WnHbkR8+FLUtLHFk--

