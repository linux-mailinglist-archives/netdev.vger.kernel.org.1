Return-Path: <netdev+bounces-298580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FDzhOSvgK2puGwQAu9opvQ
	(envelope-from <netdev+bounces-298580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:32:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58073678B4F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QOrewn1z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298580-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298580-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E42A0301CDB7
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6712369996;
	Fri, 12 Jun 2026 10:31:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B83403F8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:31:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260298; cv=none; b=VNMZFn0E32PblB1fA7vFP6hqd58vI3IXWNBpjPmYps6v6FrvUEJl/X3zJnxEn9OIkqAYWGcFjLj9KPY97GsiLZhrHGULcvU33TbKM9YwEjvO4m3Uogkeh1faLPIBzOjRf/bkdpAdH0sfkJOi02AbjrlpSGc8kv5jFrj3hxqTycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260298; c=relaxed/simple;
	bh=nY+5f8bqio/TqyjHxkOdEcU4bVhaVnSoSddZXPMEZyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1ecFVtccsEX9rwVbWEz9OsgoX4lLGnZPLy79QOKwnF7gJCZvZZFC4onDhFVMvgIUS1He6MiuOxpvANP3aNwy8pgvg/sVM9McjDvyT8Phblp/3xI0dOPQvIsiLERHpvNT2FFuhthraqgdl7KIMK6tmDuVE+jknzfWPgKz1v8XKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOrewn1z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE151F000E9;
	Fri, 12 Jun 2026 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781260297;
	bh=8PuWke7FFlMDn+jfQevh0c+wzNk+yNVgTyF73m6eCa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QOrewn1zgoDVbtWoTJ7H9V3/Lft++X7cdFhtz1ZRHA3NtABIizDv0nVo2aFNiaFkQ
	 RxfCnxatoga9EG+Xwv2bph9r8rdaopdltlRSumcbX28ttWLmoe6vX1VOLRAuzjqXkK
	 9oes5eJtJybHPf3Fqdvn6hT+SLCIPX3QfpATq8HTkMmcI/XmrrrMWUkFbBOGVfC0TZ
	 woW5oHygaqQEMmF98R61yx9h1xoEhB11SJ/AvLx/GazUziXT0cHaOg6Y0VhBd6tTOl
	 R92r47GEpdfk4gIisreHyVdBXKcPxdhZz8ZckDiGuF2VsCHI9Glhg4+VVA97qMiZem
	 vt1o6rtekyCeA==
Date: Fri, 12 Jun 2026 12:31:35 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix debugfs new-tuple display for IPv4
 ROUTE entries
Message-ID: <aivgB2sduxGr8Do8@lore-desk>
References: <6a2b40ea.4dd82583.3a5c46.e5a2@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YhA8AKR1m+LaXGv3"
Content-Disposition: inline
In-Reply-To: <6a2b40ea.4dd82583.3a5c46.e5a2@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298580-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lore-desk:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58073678B4F


--YhA8AKR1m+LaXGv3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_ppe_debugfs_foe_show(), the second switch statement falls
> through from PPE_PKT_TYPE_IPV4_HNAPT/DSLITE to PPE_PKT_TYPE_IPV4_ROUTE,
> accessing hwe->ipv4.new_tuple for all three types. However, IPv4 ROUTE
> (3-tuple) entries do not contain a valid new_tuple =E2=80=94 this field i=
s only
> meaningful for NATted flows (HNAPT/DSLITE). For ROUTE entries, the
> memory at the new_tuple offset holds routing information, not NAT data,
> so displaying "new=3D" produces garbage output.
>=20
> Split the fallthrough: display new_tuple only for HNAPT and DSLITE, and
> add an explicit empty case for IPV4_ROUTE.
>=20
> Fixes: 3fe15c640f38 ("net: airoha: Introduce PPE debugfs support")
> Signed-off-by: Wayen.Yan <win847@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_ppe_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c b/drivers/n=
et/ethernet/airoha/airoha_ppe_debugfs.c
> index 0112c41..f9c12e7 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
> @@ -121,8 +121,6 @@ static int airoha_ppe_debugfs_foe_show(struct seq_fil=
e *m, void *private,
>  		case PPE_PKT_TYPE_IPV4_DSLITE:
>  			src_port =3D &hwe->ipv4.new_tuple.src_port;
>  			dest_port =3D &hwe->ipv4.new_tuple.dest_port;
> -			fallthrough;
> -		case PPE_PKT_TYPE_IPV4_ROUTE:
>  			src_addr =3D &hwe->ipv4.new_tuple.src_ip;
>  			dest_addr =3D &hwe->ipv4.new_tuple.dest_ip;
>  			seq_puts(m, " new=3D");
> @@ -130,6 +128,8 @@ static int airoha_ppe_debugfs_foe_show(struct seq_fil=
e *m, void *private,
>  						       src_port, dest_port,
>  						       ipv6);
>  			break;
> +		case PPE_PKT_TYPE_IPV4_ROUTE:

I guess you can just drop PPE_PKT_TYPE_IPV4_ROUTE and use the default case.
Fixing it:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> +			break;
>  		default:
>  			break;
>  		}
> --=20
> 2.51.0
>=20
>=20

--YhA8AKR1m+LaXGv3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaivgBwAKCRA6cBh0uS2t
rB8kAP9zFXxSniNRzojUZXHiJIIs6KwY7rp9mtncD+EW2WI5kgD+PmP/VkboWbVF
DEH8AVCe7Ogjr8qgZ7CbFTyNNK7ceAo=
=b1qZ
-----END PGP SIGNATURE-----

--YhA8AKR1m+LaXGv3--

