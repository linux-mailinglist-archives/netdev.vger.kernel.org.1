Return-Path: <netdev+bounces-300341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ToS6M4ehM2rxEQYAu9opvQ
	(envelope-from <netdev+bounces-300341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:43:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C369E2D9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:43:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MKqsGEQK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300341-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300341-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3365330078CF
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C930C317158;
	Thu, 18 Jun 2026 07:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059D3603F6
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:42:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768555; cv=none; b=dJrgOF2OJyax0McWTe9sGXKuZE/5Os4tGg5HiZxFY/xinzmjHABc9ScHbn71OT9njKGlvZ3ddrG5FDItFnF7tiagEOzo5droDEH3PMLveE0yRBWvi1CBQurShHSWpQD+lap+abBPIsNJVKSzaY4qAH60dFJeaCzvkjNAHPrmaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768555; c=relaxed/simple;
	bh=L+d1UijNPUq/bBBzfOzLzZS6fLbgXTdXgrgJhIKt368=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAVkBF1wsz+yAleUmPI/AQgdQPVYryzR/dvgmzmsJsOvdsz8r19T+gxxG+oQ/649aFE8i5nVnrioJsYzgZuAeshgvHtBcTKNlDSITlHAduM/ZzPJKyl7WBnWaLKBlk8ci4UAB7ie5BwRLZbgA8ZigOrzdMGSQZDY2QRZV2TXBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKqsGEQK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3081F000E9;
	Thu, 18 Jun 2026 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781768554;
	bh=t5CVllVNQ9Kpe6VIQJvaemTaWq1GKJ+TKsP+tPxBgLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MKqsGEQKUK5K7dsHa/8kzs97kdGQK+WjgGGTlr42bFFbNpyT4qTN4AHkvyGZjltUO
	 IXFCVh9NDPcsHDVfn1j8xKj5zU0x3L8s2PeLiIaq95fM/CXPupzcP8OieHp4r2NhRl
	 SprnQpXTabYWW0SZMBpaP9IUKP3qLDglqgCyHz4jbL8E0ORkgr5W5woPPpzAlQjClh
	 hS7YTg6DnW9Y5JI/5mDGCYQUSTXMSMMnLnZJHt3ExSjzZWhanwZtWEv8y9awaw9x+B
	 hSS2TxTFwenOl3BdgI1fU9+RlDJFveJvxUlBMJONrgt5gNSfQgELMlqeWy5arHiOse
	 tC7j5Lw+jxNqw==
Date: Thu, 18 Jun 2026 09:42:31 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: Fix TX scheduler queue mask loop upper
 bound
Message-ID: <ajOhZ_P4c_mLcoaS@lore-desk>
References: <178166704952.2212140.11002626760717132754@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1OLx6VVIlAxSBQ6/"
Content-Disposition: inline
In-Reply-To: <178166704952.2212140.11002626760717132754@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300341-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lore-desk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 269C369E2D9


--1OLx6VVIlAxSBQ6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_qdma_set_chan_tx_sched(), the loop clearing queue mask was
> using AIROHA_NUM_TX_RING (32) instead of AIROHA_NUM_QOS_QUEUES (8).
>=20
> Each channel has 8 queues, and TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i)
> computes BIT(i + (channel * 8)). With i ranging 0..31, this causes:
> - channel 0: clears bit 0..31 (all 4 channels) instead of 0..7
> - channel 1: clears bit 8..31 (channels 1-3) instead of 8..15
> - channel 2: clears bit 16..31 (channels 2-3) instead of 16..23
> - channel 3: clears bit 24..31 (channel 3 only) - correct by accident
>=20
> While BIT(32+) on arm64 produces 64-bit values truncated to 0 in u32
> mask parameter, the loop still incorrectly clears queues within the
> same channel beyond queue 7.
>=20
> Fix by using AIROHA_NUM_QOS_QUEUES (8) as the loop upper bound.

I guess it is ok now if you respin this patch on top of net branch.
If so, please add my Acked-by.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Wayen Yan <win847@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11cd7..a1eda13400 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2217,7 +2217,7 @@ static int airoha_qdma_set_chan_tx_sched(struct net=
_device *dev,
>  	struct airoha_gdm_port *port =3D netdev_priv(dev);
>  	int i;
> =20
> -	for (i =3D 0; i < AIROHA_NUM_TX_RING; i++)
> +	for (i =3D 0; i < AIROHA_NUM_QOS_QUEUES; i++)
>  		airoha_qdma_clear(port->qdma, REG_QUEUE_CLOSE_CFG(channel),
>  				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
> =20
> --=20
> 2.51.0
>=20
>=20

--1OLx6VVIlAxSBQ6/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajOhZwAKCRA6cBh0uS2t
rKNXAQDq70GBO1/bcUwI+mKYqgc4/CHuyCeneYknDmgabdAhQwEA5jjxhGCW0z3u
aAHDMX3I1sawxuvQToD49B8x1TgELgE=
=a8ge
-----END PGP SIGNATURE-----

--1OLx6VVIlAxSBQ6/--

