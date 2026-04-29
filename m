Return-Path: <netdev+bounces-282346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGWyA8/i8WlZlAEAu9opvQ
	(envelope-from <netdev+bounces-282346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:51:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281D4932BE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 669443003721
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C860B3D47AD;
	Wed, 29 Apr 2026 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiprtXmd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665321B9F6
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459908; cv=none; b=t1rXLX1Poa7pDG5Ux6bRQN/0ZO9qZ+SWvnMp80QxwQndSl9TOMChgvYxtPf9OvKwJm70Eo55mBLCjwMPfT3lMM2aJ5fUUGTM4xFYF17K5yH6ANYfXjkPOjb8E2b3ojr49QJtRC+Z3s33RKOOFOio5+7zDnz0h0BjWgU3QZ2xvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459908; c=relaxed/simple;
	bh=IEpJtV+tE48jfZ1d3ouiVAaVu5r4QSmmJlWBgtD8agg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNVIYOfBmkhAcymVTVFdNCVlFG3FvY0tQ85MYhz3ClHZxSdKtlkMEoEurCn+5v6pD4my7OVcuoJCWQm2FlxdAwcHULSm4OnsYG83INLnxeSd5aNOCZpJFy7iyEzzCGMHjt4mbJ4p14avFc77io88wxe04VST235ZwwZQDymHQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiprtXmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C21C19425;
	Wed, 29 Apr 2026 10:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459908;
	bh=IEpJtV+tE48jfZ1d3ouiVAaVu5r4QSmmJlWBgtD8agg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiprtXmdndHcJSdejaMEvKV0in2eRzc1+pRNt85QLE7SkWJe7ouxHVd7lZ9KnAxmO
	 Eh7sAfUr44un9XK5sY7203C1VDIleWvdAHmHQIFjrL6HyH/PZvVWbmnjqDmEnVNex3
	 cJoI3dKy0FZt3XYI2nHQFWYSRiwX1D+Yvp46PoxIh2pEumGKRUYgGrY+5ec7KZe30n
	 MF50mT4ALtujmNL6a2wSzy0AzkbG6XpPT1ARK68nuVsLhJ9ljKaJQCwyY96me5qSck
	 vuovF+h66qy4dY5MeuVJbIz7dYLdP/AMfcmsP5oaTF1kA8d9D9Gwj9iabkjPxdl57y
	 5xff0CYt/Mddw==
Date: Wed, 29 Apr 2026 12:51:45 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Introduce
 airoha_fe_get()/airoha_qdma_get() register read helpers
Message-ID: <afHiwU7QJGd3YPYT@lore-desk>
References: <20260428-airoha_fe_get-airoha_qdma_get-v1-1-6cfbdeb42743@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GpI9ZJHIC4pWk8Uc"
Content-Disposition: inline
In-Reply-To: <20260428-airoha_fe_get-airoha_qdma_get-v1-1-6cfbdeb42743@kernel.org>
X-Rspamd-Queue-Id: 4281D4932BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282346-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]


--GpI9ZJHIC4pWk8Uc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add airoha_fe_get() and airoha_qdma_get() as utility routines for reading
> a masked field from a specified register.
> This is a non-functional refactor, no logical changes are introduced to
> the existing codebase.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 13 ++++---------
>  drivers/net/ethernet/airoha/airoha_eth.h |  4 ++++
>  drivers/net/ethernet/airoha/airoha_ppe.c |  5 ++---
>  3 files changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 2bb0a3ff9810..40b7a00c7d95 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -201,15 +201,13 @@ static void airoha_fe_vip_setup(struct airoha_eth *=
eth)
>  static u32 airoha_fe_get_pse_queue_rsv_pages(struct airoha_eth *eth,
>  					     u32 port, u32 queue)
>  {
> -	u32 val;
> -
>  	airoha_fe_rmw(eth, REG_FE_PSE_QUEUE_CFG_WR,
>  		      PSE_CFG_PORT_ID_MASK | PSE_CFG_QUEUE_ID_MASK,
>  		      FIELD_PREP(PSE_CFG_PORT_ID_MASK, port) |
>  		      FIELD_PREP(PSE_CFG_QUEUE_ID_MASK, queue));
> -	val =3D airoha_fe_rr(eth, REG_FE_PSE_QUEUE_CFG_VAL);
> =20
> -	return FIELD_GET(PSE_CFG_OQ_RSV_MASK, val);
> +	return airoha_fe_get(eth, REG_FE_PSE_QUEUE_CFG_VAL,
> +			     PSE_CFG_OQ_RSV_MASK);
>  }
> =20
>  static void airoha_fe_set_pse_queue_rsv_pages(struct airoha_eth *eth,
> @@ -227,9 +225,7 @@ static void airoha_fe_set_pse_queue_rsv_pages(struct =
airoha_eth *eth,
> =20
>  static u32 airoha_fe_get_pse_all_rsv(struct airoha_eth *eth)
>  {
> -	u32 val =3D airoha_fe_rr(eth, REG_FE_PSE_BUF_SET);
> -
> -	return FIELD_GET(PSE_ALLRSV_MASK, val);
> +	return airoha_fe_get(eth, REG_FE_PSE_BUF_SET, PSE_ALLRSV_MASK);
>  }
> =20
>  static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
> @@ -247,8 +243,7 @@ static int airoha_fe_set_pse_oq_rsv(struct airoha_eth=
 *eth,
>  		      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));
> =20
>  	/* modify hthd */
> -	tmp =3D airoha_fe_rr(eth, PSE_FQ_CFG);
> -	fq_limit =3D FIELD_GET(PSE_FQ_LIMIT_MASK, tmp);
> +	fq_limit =3D airoha_fe_get(eth, PSE_FQ_CFG, PSE_FQ_LIMIT_MASK);
>  	tmp =3D fq_limit - all_rsv - 0x20;
>  	airoha_fe_rmw(eth, REG_PSE_SHARE_USED_THD,
>  		      PSE_SHARE_USED_HTHD_MASK,
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index e389d2fe3b86..c81433d44e3e 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -619,6 +619,8 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 ma=
sk, u32 val);
>  	airoha_rmw((eth)->fe_regs, (offset), 0, (val))
>  #define airoha_fe_clear(eth, offset, val)			\
>  	airoha_rmw((eth)->fe_regs, (offset), (val), 0)
> +#define airoha_fe_get(eth, offset, mask)			\
> +	FIELD_GET((mask), airoha_fe_rr((eth), (offset)))
> =20
>  #define airoha_qdma_rr(qdma, offset)				\
>  	airoha_rr((qdma)->regs, (offset))
> @@ -630,6 +632,8 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 ma=
sk, u32 val);
>  	airoha_rmw((qdma)->regs, (offset), 0, (val))
>  #define airoha_qdma_clear(qdma, offset, val)			\
>  	airoha_rmw((qdma)->regs, (offset), (val), 0)
> +#define airoha_qdma_get(eth, offset, mask)			\
> +	FIELD_GET((mask), airoha_qdma_rr((eth), (offset)))

commenting on Sashiko's report:
https://sashiko.dev/#/patchset/20260428-airoha_fe_get-airoha_qdma_get-v1-1-=
6cfbdeb42743%40kernel.org

- This isn't a bug, but is the first parameter of airoha_qdma_get() supposed
  to be named qdma instead of eth?
  This is correct, I will fix it in v2.

Regards,
Lorenzo


> =20
>  static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
>  {
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 5c9dff6bccd1..697af6fdd4c3 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -80,9 +80,8 @@ bool airoha_ppe_is_enabled(struct airoha_eth *eth, int =
index)
> =20
>  static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
>  {
> -	u16 timestamp =3D airoha_fe_rr(ppe->eth, REG_FE_FOE_TS);
> -
> -	return FIELD_GET(AIROHA_FOE_IB1_BIND_TIMESTAMP, timestamp);
> +	return airoha_fe_get(ppe->eth, REG_FE_FOE_TS,
> +			     AIROHA_FOE_IB1_BIND_TIMESTAMP);
>  }
> =20
>  void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id, u8=
 fport)
>=20
> ---
> base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
> change-id: 20260428-airoha_fe_get-airoha_qdma_get-7a087a23aef4
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--GpI9ZJHIC4pWk8Uc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCafHiwQAKCRA6cBh0uS2t
rGO1AQD9EhkXvmgjx5KZl7StlDhHzDJLBGQgiwWzDQjacOOVNQEAm2A5EKnJ6WOc
bRXSgX1qxX2zmE3c8lyer9r7jQv4gQY=
=oaxY
-----END PGP SIGNATURE-----

--GpI9ZJHIC4pWk8Uc--

