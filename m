Return-Path: <netdev+bounces-299834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WvVmGT1EMWrdfgUAu9opvQ
	(envelope-from <netdev+bounces-299834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:40:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C6468F6FB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:40:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QelHVbWC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299834-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299834-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FBAD3015A76
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357035677C;
	Tue, 16 Jun 2026 12:37:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00951FFC59
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:37:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613476; cv=none; b=uqjYS7pPOcLaPoMcI5L05COz6iL0JUAeDI2THmC7P2Zk0fUr/AchE0tf3ywN8wrYw30c1SQoOWTX5xwNn8gNakYIMLxPiK3VgaNGtmvD41/T029qqCnauKKC/UxNnb2K4V8eRGFrVWAJJjAO/WIqI/45604w6dU6ZMzFA6SbrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613476; c=relaxed/simple;
	bh=Kw6izY/k8F6Vki03UJpa0dp0Zb4oydVWokZik8wIm0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzZPL++AH84/l+EZH2p9d2/+gCexC2fiCk2URHTFcW0d3PXbXj2PTJmVoq3ZLcJWfTrLPs2sV1WyxUOZkH03yHRS8FjKmg6E+SRChzCM93AgERtFgJL65tuGAR2GOPtIFZZhcfXQYou698rrUFzWgkWOxXRPy8lqCSDU4c/sxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QelHVbWC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF36D1F000E9;
	Tue, 16 Jun 2026 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613475;
	bh=5Oy424Sj0LX7AKqPFqDzgHyunoDhCO/BF75OQEB7OE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QelHVbWCr3gEApPJyMPVPZfr1zOnxFa2AJ38+NGqlCgR2V2XcPtb6cuYKEIa26PCc
	 YPtodlNOGuV0fWlOQrBtV7KZEpWwBX9LNHqsXWxIvpjOqQaU6fkQ/GXfV9yVpB6eYo
	 ozX7XbOHntXIMQC/AEpMU0TTbVt4uRnmyeaZLayUwT4MIlIApH5DoO5lZ8L0WODEyU
	 qEPyHopNUm2cXxCVkDX4m1/SBG6fYLIgSCb4VA+rLWE3S61MBlRXkB9iT5MnYD6VH/
	 6nObY1y9JseWsEMB834jDL6D7Cg4pFGrIRnDVhBRwWGDtN/7FCgBoEjyDSSoQfouF6
	 3WkngWTFRTD/w==
Date: Tue, 16 Jun 2026 14:37:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] [net] net: airoha: Stop TX queues on error path in
 airoha_dev_open
Message-ID: <ajFDoTBg3dyB2GRI@lore-desk>
References: <178161146875.2165143.7400860261990016053@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KjNXxW/DJwe/iA3u"
Content-Disposition: inline
In-Reply-To: <178161146875.2165143.7400860261990016053@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299834-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0C6468F6FB


--KjNXxW/DJwe/iA3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_dev_open(), if airoha_set_vip_for_gdm_port() fails after
> netif_tx_start_all_queues() has been called, the TX queues remain
> started while the device configuration is incomplete. This leaves
> the device in an inconsistent state where packets could be
> transmitted before the VIP/IFC port configuration is complete.
>=20
> Add netif_tx_stop_all_queues() call on the error path to properly
> roll back the TX queue state.
>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Wayen Yan <win847@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11cd7..cf9c366907 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1715,8 +1715,10 @@ static int airoha_dev_open(struct net_device *dev)
> =20
>  	netif_tx_start_all_queues(dev);
>  	err =3D airoha_set_vip_for_gdm_port(port, true);
> -	if (err)
> +	if (err) {
> +		netif_tx_stop_all_queues(dev);

I do not think this is necessary since if ndo_open() callback fails, the
net_device is not marked as running.

Regards,
Lorenzo

>  		return err;
> +	}
> =20
>  	if (netdev_uses_dsa(dev))
>  		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
> --=20
> 2.51.0
>=20
>=20

--KjNXxW/DJwe/iA3u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajFDoQAKCRA6cBh0uS2t
rEAgAQDqk/81Cv2VNY0oTfDbvAQ5ag+hMIs4uuDX4yrwGwyhYQEApGYMF3uo83aZ
6wQByjRd9vAzTo8XFHg+hfIKjgRjggY=
=c3L7
-----END PGP SIGNATURE-----

--KjNXxW/DJwe/iA3u--

