Return-Path: <netdev+bounces-299840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z6BNDIFGMWqufwUAu9opvQ
	(envelope-from <netdev+bounces-299840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:50:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8984068F985
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:50:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J5ySzhET;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299840-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299840-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB3E31CB359
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3D36655C;
	Tue, 16 Jun 2026 12:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E3364935
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:45:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613907; cv=none; b=b4l966f4BKaSlp1tjlSxylC+w8rOLyEGp9k0ntl5AlTDFHZJaZxMUlIHlaBK9QgTG7Qd2cACp08FxuHjyZOiEfhYifHffrYmnxcYzopwK2+wLBY3R/cquKuhIxPW5qHb+zjD0H21dGkuPBdnruQlcag8CHtc4IkHpGhQwG71hfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613907; c=relaxed/simple;
	bh=4LN9sWdkmxfEh2YuEURvyIL7JOPWqb0CqMEhBY9MkG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7mPTB+Zm88u4VOdIt+BiSHL3bYzGL/f6zu5jXDdTkLEY8Z8qrtGNc5Fp+gp994ToRIFOPx7K6j/+eEN2UuJpeCjVxVDMqBxt5oAbBUnRrXMbyiCNj54Vgc0eElcxMVBT4VKWhEITvb3dGdO4QqoBiAzsG7lQeFmyvpUyOedOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5ySzhET; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA611F00A3A;
	Tue, 16 Jun 2026 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613906;
	bh=RSxvpTbCusWvzxxh+O+6AIb5tE3WgMP54vCTbFP+AEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J5ySzhETylCMwlWJqWi2xiHpCYAbtxTalJzbQ1tiNxnXEXXmlpUF5s76yDrsFT+Th
	 un+UlxxuV43H3KlRjBS7KXnq2/Tfmq9E0BYvkJAFkT0O9Ox7j1qqiwdDFDV9Jw740T
	 knJ3VMAcrqOIDJj0JU1BgIGuVZ+Q0rnNwOuldLegv0CiqvLjQArC/1Yh0izAiP1296
	 uheO3IjE4eXUngi/GISPMiOliLxR+Wd4VDtTXIPkLwr5hMlTxX2e6c4O9wPnRdtEGN
	 +4oADLKrPsimhEzMF/FByaXU/7CqXjgwBEQXgqGFWUe5oBIcB+uyRmgC3OqTD0yAf8
	 XEfLMicbv1dFw==
Date: Tue, 16 Jun 2026 14:45:04 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] [net] net: airoha: Clean up RX queues in
 airoha_dev_stop
Message-ID: <ajFFUFgsd9KDvdGy@lore-desk>
References: <178161160256.2165161.14322392784449633554@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oUOTYG3fwkRvybn7"
Content-Disposition: inline
In-Reply-To: <178161160256.2165161.14322392784449633554@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-299840-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lore-desk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8984068F985


--oUOTYG3fwkRvybn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 16, Wayen Yan wrote:
> When the last port is stopped, airoha_dev_stop() clears TX queues
> but neglects to clean up RX queues. This can lead to:
> - RX ring buffer descriptors remaining valid after device close
> - Potential DMA synchronization issues on device reopen
> - Risk of use-after-free if pages are freed while DMA is still active
>=20
> Add cleanup loop for RX queues to mirror the TX queue cleanup,
> ensuring symmetric resource management.
>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Wayen Yan <win847@gmail.com>

when you send a new revision:
- please add a note of what you changed with respect to the previous one.
- please give some time to reviewers to take a look to the previous revisio=
n.

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11cd7..9ca5bbf64d 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1771,6 +1771,13 @@ static int airoha_dev_stop(struct net_device *dev)
> =20
>  			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
>  		}
> +
> +		for (i =3D 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> +			if (!qdma->q_rx[i].ndesc)
> +				continue;
> +
> +			airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
> +		}
>  	}

I do not think this patch is needed since there is no point to remove all t=
he
RX buffers from the hw RX queues stopping the device, this is necessary just
removing the module (I think we can avoid it for TX too, I have a patch for=
 it
I need to post).
Moreover, doing so, when the device is opened again, RX queues will be empt=
y.

Regards,
Lorenzo

> =20
>  	return 0;
> --=20
> 2.51.0
>=20
>=20

--oUOTYG3fwkRvybn7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajFFUAAKCRA6cBh0uS2t
rEYHAQCdVSubIzZ2cVft7kjoGjr/zu7URV9JU3sxY5jp8tVr4QEA7hR72xCrHK/G
RBtj7gTHqoSlUgRBVIgKNfP494jhvAU=
=a8N+
-----END PGP SIGNATURE-----

--oUOTYG3fwkRvybn7--

