Return-Path: <netdev+bounces-299831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0JFBCsBCMWp4fgUAu9opvQ
	(envelope-from <netdev+bounces-299831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:34:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4AE68F5D7
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:34:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ORbZDDXR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299831-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299831-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25DB0300AB36
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E935677C;
	Tue, 16 Jun 2026 12:34:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AE18EB0
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:34:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613244; cv=none; b=Uvbia1uOEWh7cqtS/mXRZldYd8+UVIa4onXFpI/gk5P8Mu+85sQOfGVAo0Kf5RbkRfudWYw4wcdxbseSRmcwqwWVnKog5trx6HJaBv7k62S+ulGCDEzQWAZKlH5O1IZpSL9OwndLWAPejBHjlrFc4KJkgMcHJqEZ6BTKdiNe730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613244; c=relaxed/simple;
	bh=H3vvThjdPLSfMorsR4Wldt2rgh9pNoyFI14XsuAPdwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkDKPs3PcBGtCoE8P5C4/EWka8OIl8+UcqImRu1QxtEBo2DuroQq7UqFo3TJ1VKzTSQRsEO/Ko3ILxT9b1NC7GLb+Ra6/vJFdOaYcRG+szf75SUcekEP1aHd23zb0a2bxKWjvcwIS3idsf2o0IG48gAr6Qf58wSU8rQZVhr3vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORbZDDXR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513B81F000E9;
	Tue, 16 Jun 2026 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613242;
	bh=AU0Gj7255AvQ5CwD1pZx8WKNH581mx4ihVIONMOZiTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ORbZDDXRXZDF5r27bqtCDyNWhYxW83M3PZV1M1XhHFzVDjuThzl/q2lyxnx6ZOHdB
	 W96WTV8hCRBbFpX/UEh0SJaYf05GYlJmmpmEHPbkGmD/nFqQSRVQzAvb4X90qrElQb
	 NFNztCewp7PGZ5DDafiMXFX9gmcDig48e5TK3fpvdD5B6DcVKK1L0jgDlr+HtfN0KI
	 rRl8vBqimk7bMiiOa29i5hVKTKfzz5VfZe0xzDxuQp1DA1cY3/WFZPeQCrlApOLQJj
	 9hqrRnv4pKQNGHQJZwjW7vBfET+jVp4gRwR5rUYAv74Tg6Z9sFCCgMd4tHJkMojTvZ
	 JRO000ngSqyRQ==
Date: Tue, 16 Jun 2026 14:34:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] [net] net: airoha: fix foe_check_time allocation size
Message-ID: <ajFCuOEGT0iJttOh@lore-desk>
References: <178161119471.2163752.14373384830691569758@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hWXa442R11LoZs39"
Content-Disposition: inline
In-Reply-To: <178161119471.2163752.14373384830691569758@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299831-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE4AE68F5D7


--hWXa442R11LoZs39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> foe_check_time is declared as u16 pointer but was allocated with
> only ppe_num_entries bytes instead of ppe_num_entries * sizeof(u16).
>=20
> When airoha_ppe_foe_verify_entry() is called with hash >=3D ppe_num_entri=
es/2,
> it writes beyond the allocated buffer, causing heap buffer overflow and
> potential kernel crash.
>=20
> Fixes: 6d5b601d52a2 ("net: airoha: ppe: Dynamically allocate foe_check_ti=
me array in airoha_ppe struct")
> Signed-off-by: Wayen Yan <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 5c9dff6bcc..8fb8ecf909 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -1578,7 +1578,8 @@ int airoha_ppe_init(struct airoha_eth *eth)
>  			return -ENOMEM;
>  	}
> =20
> -	ppe->foe_check_time =3D devm_kzalloc(eth->dev, ppe_num_entries,
> +	ppe->foe_check_time =3D devm_kzalloc(eth->dev,
> +					   ppe_num_entries * sizeof(*ppe->foe_check_time),
>  					   GFP_KERNEL);
>  	if (!ppe->foe_check_time)
>  		return -ENOMEM;
> --=20
> 2.51.0
>=20
>=20

--hWXa442R11LoZs39
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajFCuAAKCRA6cBh0uS2t
rJMyAP0XT8469xm0evPWy2tNpY3Hl1oAlHZBX0cU5FrHDnoG/QD+IdvSSfUcOGbL
7vS6dZq7Uv9cqvghkCSPUUQf1TxLUQE=
=AVaX
-----END PGP SIGNATURE-----

--hWXa442R11LoZs39--

