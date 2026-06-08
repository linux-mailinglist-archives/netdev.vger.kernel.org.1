Return-Path: <netdev+bounces-296431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GPSoMLOMJmpcYgIAu9opvQ
	(envelope-from <netdev+bounces-296431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:34:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3A654A29
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:34:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j51Qiku0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296431-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296431-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0458300EFA0
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76B35295C;
	Mon,  8 Jun 2026 09:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10B2EC57C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:29:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910953; cv=none; b=GYsBCtORna6I7SNKWFocmiC5V4u5pib5VwXszK+54y35pqv5OuSRNOBErhbj3M4Fa2N/phWkIuTZqZQnbmH3no/IM/21zLqpRF4+nqEI0rwQXK9B/YtM2AmvgUIMJ5UDAeGp4mSXzGA1VJLSITRUpVITNR7I/SqJrOlhOMPatvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910953; c=relaxed/simple;
	bh=wDKFQMOG/eXGIXHuHGVAtY3FLXx2kteE6/OW5EcUKxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHESx3fjb08tEuxx9enazt2rJZamVV6IbY7VhIeuA8psjh2yOzglCxyg3fYGiqKAJNuOCLcM4NqHwTssYcOfehMhff4CnMk0pXY+CEayj2nmMYiVSNza9tvhpsCK123a6e/GvIHuyA95y/MwZARV9CfrSsQxRDMkDq1Al/S2f1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j51Qiku0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CB01F00893;
	Mon,  8 Jun 2026 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780910952;
	bh=fOAG6RO9IE4nsTI/RS9XCESeKjsw9dzfXz32mptaQog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j51Qiku0GklR6YKD+8NSuaIOjXBwv8dB96gffFhJ19vSdtctstN0LUdBBn1ovJzj8
	 rI/KOmk9Wz5Zdl0Nn1RA0KbKwXe2Sw5GqX8gikRsYI/01PYmdhFqAygt0u895iZRCA
	 hzqWFdCTbLAHUTsP/mpt5wUoqZJAhZ94j/BfmDZgnzOg1seKGA1CZe75bDxDLnhdqO
	 2lVPpCJ0zaNrEuUTlJZX9kSMLWBhRCrisiaqpc0mxv1BFIMM3EEVvb/gEBP+jK0Fnh
	 M2qILM6BArN0gG5obghgg0qdho1D+p3VX7T4Sk3SAxtc1BZa6eV0weNcc7Q2MM0AUl
	 s4JfELEaQy2cA==
Date: Mon, 8 Jun 2026 11:29:09 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Use int instead of atomic_t for
 qdma users counter
Message-ID: <aiaLZVvfsbj3zTgr@lore-desk>
References: <20260606-airoha_qdma_users-no-atomic-v1-1-86e2d6a1bfaf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6PvL9voaHHuHzEe"
Content-Disposition: inline
In-Reply-To: <20260606-airoha_qdma_users-no-atomic-v1-1-86e2d6a1bfaf@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296431-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28B3A654A29


--m6PvL9voaHHuHzEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> QDMA users counter is always accessed holding RTNL lock so we do not
> require atomic_t for it.

Please drop this patch since I need to modify it to address Andrew's request
about LAN/WAN configuration.

Regards,
Lorenzo

>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
>  drivers/net/ethernet/airoha/airoha_eth.h | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 5a8e84fa9918..a5fe08864fa3 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1809,7 +1809,7 @@ static int airoha_dev_open(struct net_device *netde=
v)
>  	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
>  			GLOBAL_CFG_TX_DMA_EN_MASK |
>  			GLOBAL_CFG_RX_DMA_EN_MASK);
> -	atomic_inc(&qdma->users);
> +	qdma->users++;
> =20
>  	if (!airoha_is_lan_gdm_dev(dev) &&
>  	    airoha_ppe_is_enabled(qdma->eth, 1))
> @@ -1863,7 +1863,7 @@ static int airoha_dev_stop(struct net_device *netde=
v)
>  					    REG_GDM_FWD_CFG(port->id),
>  					    FE_PSE_PORT_DROP);
> =20
> -	if (atomic_dec_and_test(&qdma->users)) {
> +	if (!--qdma->users) {
>  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
>  				  GLOBAL_CFG_TX_DMA_EN_MASK |
>  				  GLOBAL_CFG_RX_DMA_EN_MASK);
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 8f42973f9cf5..e89c2dff411f 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -525,8 +525,7 @@ struct airoha_irq_bank {
>  struct airoha_qdma {
>  	struct airoha_eth *eth;
>  	void __iomem *regs;
> -
> -	atomic_t users;
> +	int users;
> =20
>  	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
> =20
>=20
> ---
> base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
> change-id: 20260606-airoha_qdma_users-no-atomic-0750cc2b42f1
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--m6PvL9voaHHuHzEe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiaLZQAKCRA6cBh0uS2t
rO+6APwLDYmZI/JomfAanIi6AplM1iKDlhcwYtTDEJr1cs8BdgD/eLsP003LFzDw
Bpn+4cLIONPJvzfc5X7KJC8GwM94vQc=
=VKAi
-----END PGP SIGNATURE-----

--m6PvL9voaHHuHzEe--

