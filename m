Return-Path: <netdev+bounces-295135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mnggAnhGIWp9CQEAu9opvQ
	(envelope-from <netdev+bounces-295135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F863E918
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:33:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fZYTMnRF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295135-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295135-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE7E3009FB2
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388043AEF50;
	Thu,  4 Jun 2026 09:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54035BDCA;
	Thu,  4 Jun 2026 09:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564822; cv=none; b=W7aZZDB7UdSnFnaIL9h5txB88uA98aNfpG8sv+eg/OrRbpY2Z/Lqp+xOi5v/PERcSiD2+Ua5thU0zMy52dLd7BanqmTU4hrcMokdfA1kaA5mBCxaI5ZquL+TWFbF6AsBNphxKqttXaP8N49BcabNSnXMyPV5KOZpf8I5qX+wrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564822; c=relaxed/simple;
	bh=EScwtVtHVv7EXmUVim3RrrnEtQbK/uJ4Hrp1cA0YN4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohvq4saiFWSeI1wpz8JF+Po2prV047l9oJCGw7M8x5cy+wUCgDVwGS4QDg6j6EyvOorajwT6FkP37TLMwiN+r7yjooGHq5/J61ZU4Jlit7DQT+hMJaQh7DabLkmT/eKK/k+j5EJL2UsAjFtG+Q3MAhnE48DeBYGj+5/54YPoVe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZYTMnRF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A601F00893;
	Thu,  4 Jun 2026 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564820;
	bh=aXWX2X1IdSYuWmeJ4APMMdKu4ZoZ7LZ+WFh9+wZtPXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fZYTMnRFIH8WWQgBB2lEzzMzQy+hhuNR+MyMG6+e3Tlzf3roeq3kJR1MK+By5cR+z
	 n0ISfSyzY4DtK4ROq5VUTKP+xNd1wCU0awoLYdid9jlMZ+tYbPZR6c8GbgQVhel2ix
	 EhEo7b4XltVj6L9MX4d8BeU51tAvI7yqAcJ3Hnoq5JINf3iAB0Qs/wffYJMKeXtIUI
	 tGHqMJYcy8PoXDZKK9iJzkT3HiDJkCbC5qwV5qCvU+2IMinWU+439/VipnM912qlW9
	 pILQkFBeSZUG2Mkg9S3pczfhGKDWW8L6d8UB5lZb/EqCZdofYitmBVw6x4e3CDn9Ua
	 PQdWBa8YnyCWQ==
Date: Thu, 4 Jun 2026 11:20:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v9 6/6] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <aiFDUpMC1RHRkzZL@lore-desk>
References: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
 <20260603-airoha-eth-multi-serdes-v9-6-5d476bc2f426@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SFnAkeHUpYpN2nJa"
Content-Disposition: inline
In-Reply-To: <20260603-airoha-eth-multi-serdes-v9-6-5d476bc2f426@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ansuelsmth@gmail.com,m:benjamin.larsson@genexis.eu,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 679F863E918


--SFnAkeHUpYpN2nJa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 03, Lorenzo Bianconi wrote:
> The EN7581 and AN7583 SoCs provide registers to configure hardware LAN/WAN
> MAC addresses. These registers are used during FE hw acceleration to
> determine whether received traffic is destined to this host (L3 traffic)
> or should be switched to another device (L2 traffic).
> The SoC hardware design assumes all interfaces configured as LAN (or WAN)
> share the MAC address MSBs, which are programmed into the
> REG_FE_{LAN,WAN}_MAC_H register. The LSBs of 'local' mac addresses can be
> expressed as a range via the REG_FE_MAC_LMIN and REG_FE_MAC_LMAX
> registers. In order to properly accelerate the traffic, FE module requires
> the user to configure the REG_FE_{LAN,WAN}_MAC_H register respecting this
> limitation. Please note a misconfiguration in REG_FE_{LAN,WAN}_MAC_H
> will still allow the user to log into the device for debugging.
> Previously, only a single interface was considered when programming these
> registers. Extend the logic to derive the correct minimum and maximum
> values for REG_FE_MAC_LMIN/REG_FE_MAC_LMAX when two or more interfaces are
> configured as LAN or WAN. Since this functionality was not available
> before this series, no regression is introduced.

Commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603-airoha-eth-mul=
ti-serdes-v9-0-5d476bc2f426%40kernel.org

- How does this validation interact with the init path?=20
  In airoha_alloc_gdm_device(), interfaces lacking a DT MAC fall back to
  eth_hw_addr_random(), and airoha_dev_init() calls airoha_set_macaddr()
  but discards the int return, so a netdev whose initial MAC would fail
  the new MSB check still proceeds to register and reaches NETREG_REGISTERE=
D.
  - This is done on purpose to not block the device probe and allow the user
    to log into the system, and based on the syslog, fix the issue manually.

Regards,
Lorenzo

>=20
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 77 ++++++++++++++++++++++++++=
++----
>  drivers/net/ethernet/airoha/airoha_eth.h |  2 +-
>  drivers/net/ethernet/airoha/airoha_ppe.c |  4 +-
>  3 files changed, 71 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 64ee526da241..8f2608293bb7 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -71,20 +71,76 @@ static void airoha_qdma_irq_disable(struct airoha_irq=
_bank *irq_bank,
>  	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
>  }
> =20
> -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *add=
r)
> +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
>  {
> +	u8 ref_addr[ETH_ALEN] __aligned(2);
>  	struct airoha_eth *eth =3D dev->eth;
> -	u32 val, reg;
> +	u32 reg, val, lmin, lmax;
> +	int i;
> +
> +	eth_zero_addr(ref_addr);
> +	lmin =3D (addr[3] << 16) | (addr[4] << 8) | addr[5];
> +	lmax =3D lmin;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		struct airoha_gdm_port *port =3D eth->ports[i];
> +		int j;
> +
> +		if (!port)
> +			continue;
> +
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *iter_dev;
> +			struct net_device *netdev;
> +
> +			iter_dev =3D port->devs[j];
> +			if (!iter_dev || iter_dev =3D=3D dev)
> +				continue;
> +
> +			if (airoha_is_lan_gdm_dev(iter_dev) !=3D
> +			    airoha_is_lan_gdm_dev(dev))
> +				continue;
> +
> +			netdev =3D netdev_from_priv(iter_dev);
> +			if (netdev->reg_state !=3D NETREG_REGISTERED)
> +				continue;
> +
> +			ether_addr_copy(ref_addr, netdev->dev_addr);
> +			val =3D (netdev->dev_addr[3] << 16) |
> +			      (netdev->dev_addr[4] << 8) | netdev->dev_addr[5];
> +			if (val < lmin)
> +				lmin =3D val;
> +			if (val > lmax)
> +				lmax =3D val;
> +		}
> +	}
> +
> +	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
> +		/* According to the HW design, hw mac address MSBs must be
> +		 * the same for each net_device with the same LAN/WAN
> +		 * configuration.
> +		 */
> +		struct net_device *netdev =3D netdev_from_priv(dev);
> +
> +		dev_warn(eth->dev,
> +			 "%s: wrong mac addr, MSBs must be %02x:%02x:%02x\n",
> +			 netdev->name, ref_addr[0], ref_addr[1],
> +			 ref_addr[2]);
> +		dev_warn(eth->dev, "FE hw forwarding won't work properly\n");
> +
> +		return -EINVAL;
> +	}
> =20
>  	reg =3D airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H : REG_FE_WAN_MAC_=
H;
>  	val =3D (addr[0] << 16) | (addr[1] << 8) | addr[2];
>  	airoha_fe_wr(eth, reg, val);
> =20
> -	val =3D (addr[3] << 16) | (addr[4] << 8) | addr[5];
> -	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
> -	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
> +	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), lmin);
> +	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), lmax);
> =20
> -	airoha_ppe_init_upd_mem(dev);
> +	airoha_ppe_init_upd_mem(dev, addr);
> +
> +	return 0;
>  }
> =20
>  static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
> @@ -1826,13 +1882,18 @@ static int airoha_dev_stop(struct net_device *net=
dev)
>  static int airoha_dev_set_macaddr(struct net_device *netdev, void *p)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct sockaddr *addr =3D p;
>  	int err;
> =20
> -	err =3D eth_mac_addr(netdev, p);
> +	err =3D eth_prepare_mac_addr_change(netdev, p);
>  	if (err)
>  		return err;
> =20
> -	airoha_set_macaddr(dev, netdev->dev_addr);
> +	err =3D airoha_set_macaddr(dev, addr->sa_data);
> +	if (err)
> +		return err;
> +
> +	eth_commit_mac_addr_change(netdev, p);
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 3e8262f583a7..8f42973f9cf5 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -683,7 +683,7 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev,=
 struct sk_buff *skb,
>  int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_=
data);
>  int airoha_ppe_init(struct airoha_eth *eth);
>  void airoha_ppe_deinit(struct airoha_eth *eth);
> -void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev);
> +void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8 *addr);
>  u32 airoha_ppe_get_total_num_entries(struct airoha_ppe *ppe);
>  struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
>  						  u32 hash);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index f54622904733..91bcc55a6ac6 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -1487,12 +1487,10 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *=
dev, struct sk_buff *skb,
>  	airoha_ppe_foe_insert_entry(ppe, skb, hash, rx_wlan);
>  }
> =20
> -void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev)
> +void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8 *addr)
>  {
> -	struct net_device *netdev =3D netdev_from_priv(dev);
>  	struct airoha_gdm_port *port =3D dev->port;
>  	struct airoha_eth *eth =3D dev->eth;
> -	const u8 *addr =3D netdev->dev_addr;
>  	u32 val;
> =20
>  	val =3D (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];
>=20
> --=20
> 2.54.0
>=20

--SFnAkeHUpYpN2nJa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiFDUgAKCRA6cBh0uS2t
rKFZAPsFq8wtcGM5fSMmaXoN8r3ZJahwhyksHFbQVLSGqyPnpgEAonKxBLMX2x26
QDHe2K2ddF+pJgWY5jkwF5mFrWv1uQo=
=7aG6
-----END PGP SIGNATURE-----

--SFnAkeHUpYpN2nJa--

