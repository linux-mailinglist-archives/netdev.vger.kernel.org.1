Return-Path: <netdev+bounces-305805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AT9vBWxKTmoiKQIAu9opvQ
	(envelope-from <netdev+bounces-305805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:02:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77372691E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:02:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TgoZy0kS;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305805-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305805-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA4F30478ED
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C98F4657D6;
	Wed,  8 Jul 2026 12:57:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8B426ECA
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:57:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515461; cv=none; b=hlOjyqY25W1JDp7CN5M1V/28Nk/qbiM6h6eepnPHMYDmLJM8PuW7/DfbnyLU5+/3EwUjqMa54sIgX/sGNiGvLQ9eWGF7WJSASMv8rBdxfrN82lfNcsfmuMhZBX1OI2fTXxCEtDLT66I1anlMduFACjHtVKVOkG9Ep2Fm37NT9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515461; c=relaxed/simple;
	bh=15UnY4fxkitLRe+qzCjT/HKM8t0y+iriTCIS1A+AqSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff23fmu7aj/KUb2J2cCImxgH9oitlK9z9tefdAIbpgbegpbGQhWEM8HA7z8LOz/jZAk1nFmUsXi2DcyXAjDodheWw5qgaX/RKFnAnNzeNh5Ad4EXJvQ3CegH32gCVX1Pq41uD97hxGGfJaW2+I+7pTyArsDPamSpvXHxMZ+RmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgoZy0kS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F481F000E9;
	Wed,  8 Jul 2026 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783515459;
	bh=qRWldEfKotFz0RFdvk3K7yQLwFVfCSqWSdZVW6pQ84g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TgoZy0kS3bz79fZjR9pb0xVWBZcQ38mOq5nUZTlP1W5U7hHHvwuUMWxW/RteOsLR6
	 vheU6GNS9szCoKdTolmTKXZy4MZr3JRDAt4bbyWMdIPFdR7Iq1/ubyLY6z6mymZ8cb
	 4sZelPFPMfAwghJQ1QNXlLKwPgKs3Q+Z8HFdXo1CkTrrtbCp5ieCmiPIieyQNTk9AQ
	 FCD2REueExEfHu0hgQ4uXjNRnKdYKJ6E8uY0pdxPkCRP+8K1M4DEVEIwGupeJEKf2y
	 OqzaHPxKmpCOi+hje6tEswt6x9HOHJCG+KJBPN1EzmotWRjqA4f6yasvNAUZxNFoSa
	 nJzuJJGTVhj9g==
Date: Wed, 8 Jul 2026 14:57:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: Fix DMA direction for NPU mailbox buffer
Message-ID: <ak5JQZwD2D4ogWw3@lore-desk>
References: <178351055214.98729.11403147818632027428@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqtiECgthKw6C3p6"
Content-Disposition: inline
In-Reply-To: <178351055214.98729.11403147818632027428@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305805-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A77372691E


--fqtiECgthKw6C3p6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> airoha_npu_send_msg() always maps the mailbox buffer with DMA_TO_DEVICE,
> but some callers expect the NPU to write response data back into the
> same buffer:
>=20
> - airoha_npu_wlan_msg_get() (NPU_OP_GET): NPU writes response into
>   the buffer, then the caller reads it via memcpy()
> - airoha_npu_ppe_stats_setup() (NPU_OP_SET): NPU writes back
>   npu_stats_addr field in the response
>=20
> On non-cache-coherent architectures like EN7581 (Cortex-A53 without
> hardware cache coherency for NPU DMA), DMA_TO_DEVICE unmap is a no-op
> =E2=80=94 it does not invalidate the CPU cache. If the NPU-written cache =
line
> is still present in the CPU cache when the caller reads the buffer,
> the CPU observes stale data instead of the NPU response.
>=20
> This is a timing-sensitive bug: small mailbox buffers (~24 bytes)
> typically fit in a single cache line and may survive in the cache
> until the caller reads them, producing silent data corruption rather
> than a crash. The bug is more likely to trigger when the caller reads
> the response immediately after dma_unmap_single() without intervening
> cache-evicting operations.
>=20
> Fix by using DMA_BIDIRECTIONAL for both map and unmap, which ensures
> dma_unmap_single() invalidates the CPU cache on non-coherent systems.
> The mailbox buffers are small so there is no performance concern.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: c52918744ee1e49cea86622a2633b9782446428f ("net: airoha: npu: Move =
memory allocation in airoha_npu_send_msg() caller")
> Signed-off-by: Wayen Yan <win847@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index 870d61fdd9c6..b679bed952de 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -168,7 +168,7 @@ static int airoha_npu_send_msg(struct airoha_npu *npu=
, int func_id,
>  	dma_addr_t dma_addr;
>  	int ret;
> =20
> -	dma_addr =3D dma_map_single(npu->dev, p, size, DMA_TO_DEVICE);
> +	dma_addr =3D dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
>  	ret =3D dma_mapping_error(npu->dev, dma_addr);
>  	if (ret)
>  		return ret;
> @@ -191,7 +191,7 @@ static int airoha_npu_send_msg(struct airoha_npu *npu=
, int func_id,
> =20
>  	spin_unlock_bh(&npu->cores[core].lock);
> =20
> -	dma_unmap_single(npu->dev, dma_addr, size, DMA_TO_DEVICE);
> +	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
> =20
>  	return ret;
>  }
> --=20
> 2.51.0
>=20
>=20

--fqtiECgthKw6C3p6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCak5JQQAKCRA6cBh0uS2t
rEkuAQDBR2AU7po/548CG9jgOQ4FrFUOWREXpwLycau0KwabmgEAoT0GbuBjIF0v
B0mV4hsyWdRr1ux3Q6bkcxszl+YIfwg=
=TO0g
-----END PGP SIGNATURE-----

--fqtiECgthKw6C3p6--

