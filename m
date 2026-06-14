Return-Path: <netdev+bounces-299177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cnTIDNRhLmqvuwQAu9opvQ
	(envelope-from <netdev+bounces-299177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:09:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9326809F8
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:09:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PI+XcZBd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299177-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299177-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42DFF30039A6
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55CC3955EC;
	Sun, 14 Jun 2026 08:09:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1352F8E96
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 08:09:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424592; cv=none; b=cRueF6k++IcFg2Bc9lxQO+oStltgGqsLM8ty2SobtgY59wizikFV9HpFCGCgL08tT6HP/juPR4uOklk3XRZ1elHnJLCgGyukRpSwQu4C+E/ayyUkmaTLgMitRkkM35BuVgsv2PsDIoRoPCdDpCgJ+dgy/7jsHptKRhDzuty02FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424592; c=relaxed/simple;
	bh=Vu3m5Zo/U3lCH3aSOYeWgCi/FfocKpOyI9w7v+JMHI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfx5VISOtH0V3Vlo2r9+BVISgt5q2+slQeOKX4hB6SHwwwPxi9Uq9gE37qN/m+xlEMxrnuMFIj7EVxscUHEWKrbQtPaggQInBHT/9tV3J1ON2Zjj1EWpwQaoN67dWbEeQxirekuBjCHsGp+BeS1efw9hkmkn7hglMQ07/CapnLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI+XcZBd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53971F000E9;
	Sun, 14 Jun 2026 08:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781424591;
	bh=6BsbZwfZNV4qPPi4CXgdcpJbR4FJNEYIPAmx8W44Sls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PI+XcZBdThtyTLGvfKqWZH3YEgYuEwXy5bZ9WLjLhJx8chGn+7JmYa/JEpCnu6J8c
	 lR6gcaG4DCAMGf0JF5RcZv2juqNo5CR79HD2fdcf7OtA42j774Kxy2WzAqqmh2PvdQ
	 3LfwVsv954g/IWlsOT8ssC/6ReBy/wNb/jIGrxK9hE+lxyMldJ1FsQNFq4iQQ9SDzh
	 SutyimnvvXWeuks69R1W9wPZexFuTofaU2BOYusGMr0896BmVcrRBcOJr+v+98CEaO
	 t2ki9j6OC0PZU5Ca9bdvEwadD0yahF5EXsEj0MFpZYaHj3lu9oXWLf0NhsA16AV5tx
	 HGdGGUhUtZ8jQ==
Date: Sun, 14 Jun 2026 10:09:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix skb->priority underflow in
 airoha_dev_select_queue()
Message-ID: <ai5hzG8knT0xVEu6@lore-desk>
References: <6a2de8c5.2c570c9e.53b1a.0e1b@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gewW9LJ9Yc0z9m/c"
Content-Disposition: inline
In-Reply-To: <6a2de8c5.2c570c9e.53b1a.0e1b@mx.google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299177-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD9326809F8


--gewW9LJ9Yc0z9m/c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_dev_select_queue(), the expression:
>=20
>   queue =3D (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;
>=20
> implicitly converts to unsigned arithmetic: when skb->priority is 0
> (the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
> and UINT_MAX % 8 =3D 7, routing default best-effort packets to the
> highest-priority QoS queue. This causes QoS inversion where the
> majority of traffic on a PON gateway starves actual high-priority
> flows (VoIP, gaming, etc.).
>=20
> Fix by guarding the subtraction: when priority is 0, map to queue 0
> (lowest priority), otherwise apply the original (priority - 1) % 8
> mapping.
>=20
> Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
> Signed-off-by: Wayen <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11cd7..d476ef83c3 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1933,7 +1933,7 @@ static u16 airoha_dev_select_queue(struct net_devic=
e *dev, struct sk_buff *skb,
>  	 */
>  	channel =3D netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->i=
d;
>  	channel =3D channel % AIROHA_NUM_QOS_CHANNELS;
> -	queue =3D (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
> +	queue =3D skb->priority ? (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES :=
 0;
>  	queue =3D channel * AIROHA_NUM_QOS_QUEUES + queue;
> =20
>  	return queue < dev->num_tx_queues ? queue : 0;
> --=20
> 2.51.0
>=20
>=20

--gewW9LJ9Yc0z9m/c
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai5hzAAKCRA6cBh0uS2t
rEW4AQDgDl+fmWFCDiFdPQD/bxbm1gZCWL62t9HyYgsUbdaSngD8Cbcyxxum1E3r
ttz6ZZwzymUojIGQfi+SAmQN2pIR1QA=
=7neh
-----END PGP SIGNATURE-----

--gewW9LJ9Yc0z9m/c--

