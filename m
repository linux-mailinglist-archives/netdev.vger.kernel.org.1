Return-Path: <netdev+bounces-298567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r9jYEA3WK2oXGAQAu9opvQ
	(envelope-from <netdev+bounces-298567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:49:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBAE6786CA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:49:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IDoZx6CM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298567-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298567-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A22323022047
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC3386576;
	Fri, 12 Jun 2026 09:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B8366051
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:48:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257699; cv=none; b=GCuig/qk5SIchDEKZiziCqz/5Ph+AGQ6YizrbZp3mI/vjUo4LUDjomGvNqwNi8kK/xGEte1uOZXPXgy60BtE0UHSXhhx3N5PBlM9S03YRZHJK2ues9kPUEsxpLPt1BOt90+aXoFxCw/XxCuLvlN2nd6zxEhqlmCzO7raarL36sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257699; c=relaxed/simple;
	bh=cAaCF69c04jCqVYjuqqPNjyeU8jG1ajAK8czCYYeKWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHgAB1i/Q1Yc2a7CI0j7uRhQyOfEmri3h75NDulUwKq2ioU9/5GHBjgS3veaDuQUboI4gYc4Z+OPgZtphKsMYMW5iYDP9tiFWrvpqadkjX1sotin8YyO8gRHbYY2JfgaJp7TtEWoOcgBk3sDJOC6X2/ngBnHSV0fm6sxhbbXGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDoZx6CM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D6D1F000E9;
	Fri, 12 Jun 2026 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781257697;
	bh=6fXUbxNQMef3KW0BeIYSPmJZG+Y5jb6njF1/ZJj+fSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IDoZx6CMkmJysz3zmuz6DeQEus1tZDstIBNG9RO8Q3WKHebeBPofSrSQmBf9d1oEp
	 T5qTOQB01dlfZTo0IISNrO3VbH8eShKKjm1wAbcEErVKPhNhVNG/hN8LjLGhYa/WQW
	 5H7DdYGam4rlbYlnJrKN0T9NIiOLCRP/FtdjdTFWkG8/nWCF4bxLuxHFRiqH+Q2iT5
	 yHC616RGbmlh8V+DcboLU4CWAeyZITU7+kUbRPzmPC/pICG+ffobi8fTQuPtDsziJF
	 MT3fU4d0DnUEsyN0hq2y9nCb5HuxHNTPmRd0RrTMOXRfsOe+088qWr5i8Bj9OFd0MS
	 gzs2HQcNF1Pug==
Date: Fri, 12 Jun 2026 11:48:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] net: airoha: Fix error handling in
 airoha_ppe_flush_sram_entries()
Message-ID: <aivV3wr7zHQcENtI@lore-desk>
References: <6a2bd37a.4034e349.1b41bb.1caf@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EoeaF+jQtSFUc+T+"
Content-Disposition: inline
In-Reply-To: <6a2bd37a.4034e349.1b41bb.1caf@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-298567-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BBAE6786CA


--EoeaF+jQtSFUc+T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_ppe_flush_sram_entries(), the outer "err" variable was never
> updated when the inner loop variable shadowed it, causing the function
> to always return 0 even when airoha_ppe_foe_commit_sram_entry() fails.
>=20
> Drop the outer "err" variable and return directly on error, propagating
> the error code from airoha_ppe_foe_commit_sram_entry() correctly.
>=20
> Fixes: 620d7b91aadb ("net: airoha: ppe: Flush PPE SRAM table during PPE s=
etup")
> Link: https://lore.kernel.org/netdev/6a2b40e4.4dd82583.3a5c46.e52f@mx.goo=
gle.com/
> Signed-off-by: Wayen.Yan <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 5c9dff6..a124f15 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -1330,7 +1330,7 @@ static int airoha_ppe_flush_sram_entries(struct air=
oha_ppe *ppe)
>  {
>  	u32 sram_num_entries =3D airoha_ppe_get_total_sram_num_entries(ppe);
>  	struct airoha_foe_entry *hwe =3D ppe->foe;
> -	int i, err =3D 0;
> +	int i;
> =20
>  	for (i =3D 0; i < sram_num_entries; i++) {
>  		int err;
> @@ -1338,10 +1338,10 @@ static int airoha_ppe_flush_sram_entries(struct a=
iroha_ppe *ppe)
>  		memset(&hwe[i], 0, sizeof(*hwe));
>  		err =3D airoha_ppe_foe_commit_sram_entry(ppe, i);
>  		if (err)
> -			break;
> +			return err;
>  	}
> =20
> -	return err;
> +	return 0;
>  }
> =20
>  static struct airoha_npu *airoha_ppe_npu_get(struct airoha_eth *eth)
> --=20
> 2.51.0
>=20
>=20

--EoeaF+jQtSFUc+T+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaivV3wAKCRA6cBh0uS2t
rG1XAQCCuKkYI+tIMsjd+zKovSrzkgniTy4bU0wXXl1QiLXSFQD/SnwATkCTQzfe
Aa6qlJSWjvbDGHvmlP81Dcujo8NQZQs=
=7Aip
-----END PGP SIGNATURE-----

--EoeaF+jQtSFUc+T+--

