Return-Path: <netdev+bounces-303082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eH+pJSSdQ2qkdQoAu9opvQ
	(envelope-from <netdev+bounces-303082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F386E3054
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:40:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XuYRlDaW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303082-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303082-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7C403021CA4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5C1D86E4;
	Tue, 30 Jun 2026 10:38:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA963F44D0
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:38:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815923; cv=none; b=YmOa7eMf7Yx8NXEJYCAEaXpURLAZwpLze0Ad6Dau8QzyJIDN5JTyMit3lY51cB/bA4BtalgjZxFt2j5Bb/0ZITJbnmA3PDsby0MLkIzDNGSPq8Shv4ftfXi+IUITSRiZO5xdM6hmchijsIHox4Y9zKqS8VJxIwGh5Dd5+Hq5F9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815923; c=relaxed/simple;
	bh=kdWfl3Q/ZczDxcz5nRQPagdN7ORCD3ENMIu/cpLCZSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy0II0Bve/0/ADNFfGpBD6LF7S2nwPrsWi1mPmkmsR9Zh6uUNWvMzymaMtu4JDbMnP3F8BSfl+GGq5UT00Xr0SpJaRjfhm8C61boIRxEOOHfUbC4CpGXqiumW2he8yX+xolxJzCgfqgoC7omOuMtBo4sK78jLt1Rat5LN49ilsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuYRlDaW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA031F000E9;
	Tue, 30 Jun 2026 10:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782815921;
	bh=ZaxIk8kJJsUgVXlodNZiKkcmZUSFiI58aKp62i6m8rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XuYRlDaWRm5tMRTPRFvUvmH37CHjR0yfu+HvLqfArnQSlSZLQO36KT79VYmoVwt2q
	 mwG1vQJ8fY6EBQlX2K2KMR5JFRyyuSJNiFeivQO6oLONT1q1ECe+uhMpDmaG7vEsVi
	 g5erJUh93sezg2RvPgM16Rq/0udwU5YemJXUmQXmhTrhRQJKONh+mKyfoWFfHvqses
	 vI5zirZmR8QIP58gkCpC3+4zXwb7KRKh+NtSp5GXJPhP+pep09eU10eUL1VNRPBDJJ
	 m0oloR3aRBQUJSa8FIdOAZ7TuI0ggqNOV/dkT8UjfyLuAHRNGAFRyDcZg+SRDnpJgc
	 1+3+6gF+L99vQ==
Date: Tue, 30 Jun 2026 12:38:38 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lei Zhu <zhulei_szu@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND net-next] net: airoha: Make use of the helper
 function dev_err_probe()
Message-ID: <akOcrmDpfzNUTR2n@lore-desk>
References: <20260630015247.43322-1-zhulei_szu@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8+t8Nk181uj3Xf/i"
Content-Disposition: inline
In-Reply-To: <20260630015247.43322-1-zhulei_szu@163.com>
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
	TAGGED_FROM(0.00)[bounces-303082-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:zhulei_szu@163.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33F386E3054


--8+t8Nk181uj3Xf/i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lei Zhu <zhulei@kylinos.cn>
>=20
> Use dev_err_probe() to reduce code size and simplify the code.
>=20
> Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
> ---
> The last submission was when net-next is closed.Resending it.
>=20
>  drivers/net/ethernet/airoha/airoha_eth.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11cd78d..189f64e83a46 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -3071,10 +3071,9 @@ static int airoha_probe(struct platform_device *pd=
ev)
>  	eth->dev =3D &pdev->dev;
> =20
>  	err =3D dma_set_mask_and_coherent(eth->dev, DMA_BIT_MASK(32));

I do not think dma_set_mask_and_coherent() can return -EPROBE_DEFER, so the=
re
is no point adding dev_err_probe() here.

Regards,
Lorenzo

> -	if (err) {
> -		dev_err(eth->dev, "failed configuring DMA mask\n");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(eth->dev, err,
> +				     "failed configuring DMA mask\n");
> =20
>  	eth->fe_regs =3D devm_platform_ioremap_resource_byname(pdev, "fe");
>  	if (IS_ERR(eth->fe_regs))
> @@ -3087,10 +3086,9 @@ static int airoha_probe(struct platform_device *pd=
ev)
>  	err =3D devm_reset_control_bulk_get_exclusive(eth->dev,
>  						    ARRAY_SIZE(eth->rsts),
>  						    eth->rsts);
> -	if (err) {
> -		dev_err(eth->dev, "failed to get bulk reset lines\n");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(eth->dev, err,
> +				     "failed to get bulk reset lines\n");
> =20
>  	xsi_rsts =3D devm_kcalloc(eth->dev,
>  				eth->soc->num_xsi_rsts, sizeof(*xsi_rsts),
> @@ -3105,10 +3103,9 @@ static int airoha_probe(struct platform_device *pd=
ev)
>  	err =3D devm_reset_control_bulk_get_exclusive(eth->dev,
>  						    eth->soc->num_xsi_rsts,
>  						    eth->xsi_rsts);
> -	if (err) {
> -		dev_err(eth->dev, "failed to get bulk xsi reset lines\n");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(eth->dev, err,
> +				     "failed to get bulk xsi reset lines\n");
> =20
>  	eth->napi_dev =3D alloc_netdev_dummy(0);
>  	if (!eth->napi_dev)
> --=20
> 2.25.1
>=20

--8+t8Nk181uj3Xf/i
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakOcrgAKCRA6cBh0uS2t
rB+DAQCMFFKN9huJM9Vys4ZayoskK544nzi+2IIda5fqGTD0lgD/aRYXRvo5anxn
ukQVusDvd9VS5srwl5JjdE17RitWSgk=
=mJpf
-----END PGP SIGNATURE-----

--8+t8Nk181uj3Xf/i--

