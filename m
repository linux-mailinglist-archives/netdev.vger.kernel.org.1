Return-Path: <netdev+bounces-300690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cVkfLFwqNWo6nwYAu9opvQ
	(envelope-from <netdev+bounces-300690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:39:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 136456A574F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:39:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VVri5rZc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300690-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300690-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6450301465C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA36380FD6;
	Fri, 19 Jun 2026 11:39:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9F40D59E
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 11:39:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869146; cv=none; b=udIVF4LwI6qCFUU35cQp/Jzr/8/D6m6xY6n2qiLu8Kh9Mxe3OC4j4UMxOgQT8A72ocK5+/2k1HPyBLsxQleu10g9C7Gd88npY2BiwjmV39oGFZIk8Pk6aEUKadKMLq4ucVoqImRpoalJuHkAlsyHnTCNP4MoTFqgXbZcxjOlZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869146; c=relaxed/simple;
	bh=/At/aUE3doVEfljnJuE2qBKtSi2wRZ1sqKK6eQbUS4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlIKbur7XyVqOZiQZhX0QcyN/dBpbQ8y3y0rlqyXbPXpEjHKqEG13RP3yopNMQr7+5NakMv/KgeXICwAy5La0CInpmSdlP4+irummj0znIMadn4cLeidQRmjU7hIHW2NkZqlIpA5d/EZXn7dyYdyfmtidxW0CsD0o71oj7QxvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVri5rZc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714621F000E9;
	Fri, 19 Jun 2026 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781869145;
	bh=kpXWct/ksH4wphVNWjqFdoJ25adS8L/TJ0QkPKa90Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VVri5rZca1NYzdVF7Jk2qeqaI4yYUI0BXeAeXmut2STe8wqQJFkRnpLEf/EFNGJSm
	 LrgMwA0gJfyKyWzXk/12Xbfd9gQUOBNd/TxjUgJiWhIdkvVheTKEzTLe7eXFnjx8Zp
	 LmXli67akG+9oNCDvDyfJuay1MKL1Zy5xSQEagGa9c/sAjp3kCabCj7YqAgHZxb+jc
	 3nLKwiQtgmbYX8OdmAhjdqzhZ2RC3KSYcCp5hMhwBrOQquEMVB7wVOgtvoOumfeBXf
	 X9wsz+6xWKfvHgTEmw1v1/f/iREfnC1r+pWXxNlmgI7EYn6St5e1mwWnQmkPB7IKbT
	 euLgifYEyXk6A==
Date: Fri, 19 Jun 2026 13:39:02 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: airoha: Fix TX scheduler queue mask loop
 upper bound
Message-ID: <ajUqVknmRq-4GHkJ@lore-desk>
References: <178185574223.2378148.13454900445528174929@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wHUdDSUz+JkqUMMA"
Content-Disposition: inline
In-Reply-To: <178185574223.2378148.13454900445528174929@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-300690-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 136456A574F


--wHUdDSUz+JkqUMMA
Content-Type: text/plain; charset=utf-8
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
> Even though this is functionally harmless (the register resets to 0
> and is only ever cleared, never set =E2=80=94 so clearing extra bits is a
> no-op), the loop bound is semantically wrong and should be fixed for
> correctness and clarity.
>=20
> Fix by using AIROHA_NUM_QOS_QUEUES (8) as the loop upper bound.
>=20
> Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Wayen Yan <win847@gmail.com>
> ---
> Changes in v2:
> - Add Lorenzo's Acked-by tag.
> - Clarify in commit message that this is semantically wrong but
>   functionally harmless (register resets to 0, only cleared), as
>   Lorenzo pointed out in review.
> - Rebase on current net tree.
>=20
> Link: https://lore.kernel.org/netdev/ajJIWMs4dVbfkHZ5@lore-desk/
> Link: https://lore.kernel.org/netdev/CAL_ptrs6J3Ryw_4mVTq5VgzkB4RreF5S0hu=
HyLvd9YwWr1m6jAA@mail.gmail.com/
>=20
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index d0c0c0ec8a..ca77747b44 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2212,7 +2212,7 @@ static int airoha_qdma_set_chan_tx_sched(struct net=
_device *dev,
>  	struct airoha_gdm_port *port =3D netdev_priv(dev);

it seems you have not rebased on top of net tree.

Regards,
Lorenzo

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

--wHUdDSUz+JkqUMMA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajUqVgAKCRA6cBh0uS2t
rP/SAPoDG+CtUOFublyI3uoCmooVJ0WP3YmpXBkAY+jo5hzPLgEAh9y8M9BQpUwj
MfPZagIteB1QEb+rf7nFp8POMPVnEAc=
=Abaq
-----END PGP SIGNATURE-----

--wHUdDSUz+JkqUMMA--

