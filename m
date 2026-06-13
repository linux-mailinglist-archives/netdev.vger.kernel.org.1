Return-Path: <netdev+bounces-298933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KFFLEKwdLWo/bwQAu9opvQ
	(envelope-from <netdev+bounces-298933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:06:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B1167E333
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:06:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ntbb2Swl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298933-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298933-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400FC30557C6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766C3612EC;
	Sat, 13 Jun 2026 09:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9D13B58A
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 09:06:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781341609; cv=none; b=OmvN/3NRLwYsnLCAeDYr/WwNzAxjD2zdYnbHfAoOagnwI7vbWGyFxlHslvnvdZth8z3OHsu5opjNyHHD1smCpNQLlyCfvVSa5oMShDYtt1m7v+KhF52OsY1cxCEgOzXKLQyR9/007Sny+Fo/FcfxicWTvIVZvE2CsCUC4jX55gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781341609; c=relaxed/simple;
	bh=lomQ6odNXpyLaemENxjbc8Gj6/RcPXBr6fzgajh/rK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoJUDiJKnF9I8XKLo5RhmjhkIOtYYRwslFI2fucLKqXI44u/1oQiyzj1l8JzdZ+LludUdS9/cATRJPTENhIkzpU4g/DDJIoIOiRygnftpx6myzdNiKLbp8NVxn/etf1E7CjddQtHs6K7m/sPM7tBxwg+jxpng+JNxuUBqYX0eww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntbb2Swl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C991F000E9;
	Sat, 13 Jun 2026 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781341608;
	bh=2BYHyFh+bn92L40f3IlB5srPvcVEDDHxqJbwSSj9Lzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ntbb2Swl50vb/4sTsaNgb9GSoAARWW9umw8QUdf+um1aWWZ9JsmMMrQay0yBaXQFJ
	 IOGqW6FDpwqxpvWTUPLbrD9uau102X2efXqEnS7ryPS1qlzlR7Rt5WquHCXvHatkjR
	 r+TvPVL6VYJBAfT2qQgkiWfX6MiXr3ddm1Dvs+51ES/rurrZLwKfti1RyeZLCvehGU
	 SQ54bH2kenKyKDGS7A9pWJFpC8jn4qQSKLx9uCzYuYGRwTkGncG8eSPMoOK/Mz7J60
	 VVlSHjmTwzhhlv7WWPYkqJR4HztacrJvgXf+DSDFW+FER8LmTYxE4A+W1jXx9T71kf
	 pNB7692fqPHZQ==
Date: Sat, 13 Jun 2026 11:06:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/3] net: airoha: use int instead of atomic_t
 for qdma users counter
Message-ID: <ai0dpFhn2eFtvHCM@lore-rh-laptop>
References: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
 <20260611-airoha-ethtool-priv_flags-v5-1-c11de08486d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rA1nt1Ke2M6EpIQI"
Content-Disposition: inline
In-Reply-To: <20260611-airoha-ethtool-priv_flags-v5-1-c11de08486d1@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-298933-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89B1167E333


--rA1nt1Ke2M6EpIQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> QDMA users counter is always accessed holding RTNL lock so we do not
> require atomic_t for it.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
>  drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 504247c8bae9..9eb9b6a139b3 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1812,7 +1812,7 @@ static int airoha_dev_open(struct net_device *netde=
v)
>  	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
>  			GLOBAL_CFG_TX_DMA_EN_MASK |
>  			GLOBAL_CFG_RX_DMA_EN_MASK);
> -	atomic_inc(&qdma->users);
> +	qdma->users++;
> =20
>  	if (!airoha_is_lan_gdm_dev(dev) &&
>  	    airoha_ppe_is_enabled(qdma->eth, 1))
> @@ -1866,7 +1866,7 @@ static int airoha_dev_stop(struct net_device *netde=
v)
>  					    REG_GDM_FWD_CFG(port->id),
>  					    FE_PSE_PORT_DROP);
> =20
> -	if (atomic_dec_and_test(&qdma->users)) {
> +	if (!--qdma->users) {
>  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
>  				  GLOBAL_CFG_TX_DMA_EN_MASK |
>  				  GLOBAL_CFG_RX_DMA_EN_MASK);

commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260611-airoha-ethtool-priv_flags-v5-0-c11d=
e08486d1%40kernel.org

- This is a pre-existing issue, but by not cleaning the TX queues when
  qdma->users > 0, does this leave the stopped device's packets in flight?
  When airoha_dev_stop() is called, it resets the device's BQL counters via
  netdev_tx_reset_subqueue(). By skipping the cleanup when other devices are
  still sharing this QDMA ring, any pending skbs originating from the stopp=
ed
  device are left to linger in the hardware TX ring.
  Because the hardware continues to process the shared ring on behalf of the
  remaining interfaces, the active NAPI poll will process their completions=
 in
  airoha_qdma_tx_napi_poll():
  		if (skb) {
  			struct netdev_queue *txq;
  			txq =3D skb_get_tx_queue(skb->dev, skb);
  			netdev_tx_completed_queue(txq, 1, skb->len);
  			dev_kfree_skb_any(skb);
  		}
  Can this cause an unsigned underflow in dql->num_queued since the BQL
  state was already reset to 0 by ndo_stop?

  - This issue is valid, but as pointed out by sashiko, this problem has not
    been introduced by this patch. In particular, I think we should remove
    netdev_tx_reset_subqueue() in airoha_dev_stop() and run
    netdev_tx_completed_queue() in airoha_qdma_cleanup_tx_queue(). We need =
to
    pay attention to not loop over already unregistered net_devices in
    airoha_qdma_cleanup_tx_queue() run from airoha_remove().
    I will post a dedicated patch for this issue.

- Also, if the device was being unregistered, unregister_netdev() frees the
  netdev memory without waiting for TX skbs (which do not hold a reference =
to
  dev). Could this lead to a use-after-free when dereferencing skb->dev her=
e?
  Should the driver selectively purge skbs belonging to the stopping netdev
  from the shared TX ring before ndo_stop returns?

  - I do not think this is a problem in the current codebase since the
    net_devices are unregistered just during module unload running
    airoha_remove() where we run airoha_qdma_stop_napi() to stop TX/RX NAPI=
s.

Regards,
Lorenzo

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 8f42973f9cf5..24fd8dcf7fca 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -526,7 +526,7 @@ struct airoha_qdma {
>  	struct airoha_eth *eth;
>  	void __iomem *regs;
> =20
> -	atomic_t users;
> +	int users;
> =20
>  	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
> =20
>=20
> --=20
> 2.54.0
>=20

--rA1nt1Ke2M6EpIQI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai0doQAKCRA6cBh0uS2t
rPw5AP0bXzC7m8pFe/TXyW0mJDSJ7LlmW/F5vmCXEWRsXm0p5AD+NMxXjFQRiFMJ
Swma4hlhBm01IUg5g8UJHcXa4s3jfAI=
=7mo2
-----END PGP SIGNATURE-----

--rA1nt1Ke2M6EpIQI--

