Return-Path: <netdev+bounces-298062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xfxCDtmIKmqerwMAu9opvQ
	(envelope-from <netdev+bounces-298062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:07:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA93670AEA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:07:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UjRz1M0q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298062-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298062-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6057B3266073
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1247A3CAA31;
	Thu, 11 Jun 2026 10:01:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09723BE16F
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:01:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172100; cv=none; b=sOgWALRbrVpEa3UrRaZlr34jX950zPNcxi9Ry0wFY7Mk9+v4emt1QHl3sYCJs4A3hrmsvmLfbIIBLtTc+PzvkrgY8yvtPAdnZe3UEZo0ZfECqcrLhb5cw4r1L5bTpRyFFndGhYYGC4/Hgvnsp6DoStmwKMrX6zWLh5rypkVBmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172100; c=relaxed/simple;
	bh=tfAUroW6gJwnJjNvzh5/lml3nZgZ/uup735vuWoSPf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayf+L9BPyMa+2kvKto+knZjVV2J8GedFx9gfpuvzvWqqRnirX6UKj+fquZpKN3bj7yUNY+1J56oSCNv9L1sFaexJ8l5nE1YkbezBpPWyxsa5+DjYXnz5OMEQluvzwZMWuNM6osBQRitw0U6wCscaXyw+AjImyO6vmP/K11egDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjRz1M0q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018351F00898;
	Thu, 11 Jun 2026 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781172098;
	bh=gcHCZxJjnd2NbJe+vF8vVoiVeFGscr8raKdpJQPi65M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UjRz1M0qJTomOYzXKVoiKZpGS9MtDg+JTdxRbI7OSGggZlawjkxiPNaYgSRLH9uej
	 /EFORBduBvm/tIxZxbEy3VZQYyB3qYYlFWBdq2p6EtO7SGNMJjNZ0eynsrFSR/RAi5
	 FaMbcNHuRd3MbNISJrWYTKOF8RjqXFmuTO6spgu+irR0vZS2jztReOCY8Xlkxl19z8
	 mlbKVN61TdcveB4j+yZH7xFaZ4NiY5X8TsJov6woaEbutqkSYb+Wq9qGSEklL6PAcw
	 AkuYVDx0uoB0l+PXarBoe9ivvReSp32ee3NRfXsE50ny/42Xb2A+Aau+SJo3UdCVqj
	 snTxA7cyw+eZQ==
Date: Thu, 11 Jun 2026 12:01:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Brown Huang <brown.huang@airoha.com>,
	Leto Liu <Leto.Liu@airoha.com>
Subject: Re: [PATCH net] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Message-ID: <aiqHgJ6FiAMu5gmF@lore-desk>
References: <20260608-airoha_qdma_set_trtcm_param-retry-fix-v1-1-f07704f0d8c5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EQw5C5lY17IuMX0g"
Content-Disposition: inline
In-Reply-To: <20260608-airoha_qdma_set_trtcm_param-retry-fix-v1-1-f07704f0d8c5@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298062-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:brown.huang@airoha.com,m:Leto.Liu@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,airoha.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FA93670AEA


--EQw5C5lY17IuMX0g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Brown Huang <brown.huang@airoha.com>
>=20
> CPU accesses QDMA via the bus. When multiple modules are using the bus
> simultaneously, CPU access to QDMA may encounter bus timeouts and fails,
> resulting in QDMA configuration failures and potentially causing packet
> transmission issues. In order to mitigate the issue, introduce a retry
> mechanism to airoha_qdma_set_trtcm_param routine in order to ensure the
> configuration is correctly applied to the hardware.
>=20
> Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Brown Huang <brown.huang@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index eab6a98d62b9..aaf7d8c8ccd3 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2493,14 +2493,23 @@ static int airoha_qdma_set_trtcm_param(struct air=
oha_qdma *qdma, int channel,
>  		     FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
>  		     FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
>  		     FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
> +	int i;
> =20
> -	airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
> -	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
> +	for (i =3D 0; i < 100; i++) {
> +		u32 data;
> =20
> -	return read_poll_timeout(airoha_qdma_rr, val,
> -				 val & TRTCM_PARAM_RW_DONE_MASK,
> -				 USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
> -				 qdma, REG_TRTCM_CFG_PARAM(addr));
> +		airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
> +		wmb();
> +		airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
> +		if (airoha_qdma_get_trtcm_param(qdma, channel, addr, param,
> +						mode, &data, NULL))
> +			continue;
> +
> +		if (data =3D=3D val)
> +			break;
> +	}
> +
> +	return i =3D=3D 100 ? -EBUSY : 0;
>  }
> =20
>  static int airoha_qdma_set_trtcm_config(struct airoha_qdma *qdma, int ch=
annel,
>=20
> ---
> base-commit: 4aacf509e537a711fa71bca9f234e5eb6968850e
> change-id: 20260605-airoha_qdma_set_trtcm_param-retry-fix-a9d2956b9b2f
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>

I think the issue reported by sashiko in [0] is valid and it needs to be
addressed in v2, but since I am not the original author of the patch, I will
let Brown or Leto comment on it.

Regards,
Lorenzo

[0] https://sashiko.dev/#/patchset/20260608-airoha_qdma_set_trtcm_param-ret=
ry-fix-v1-1-f07704f0d8c5%40kernel.org

>=20

--EQw5C5lY17IuMX0g
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiqHgAAKCRA6cBh0uS2t
rF+rAQC5+Y/anvlgMyJQaTiGnt7sLIX58e6BVmfSU1Wj1RY8EgEAsHsD6b/QSjTQ
w5el1GDLGvLDhPi7PhOKD4bBFqIUjgA=
=HrEl
-----END PGP SIGNATURE-----

--EQw5C5lY17IuMX0g--

