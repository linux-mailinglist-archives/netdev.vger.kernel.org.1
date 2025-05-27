Return-Path: <netdev+bounces-193673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8FAAC50C4
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5443E1766F7
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E29527603C;
	Tue, 27 May 2025 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2KpXxov"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB6253F3D
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355780; cv=none; b=JAHkexySFKhORGva22qxajKWFsPPlUOsRvalzqvqhSIdk7lZlZQw0RAWMdj3wYFqZMOp8mr3+pCTFTm2MLz9oH5RxUWqcv6pz6D/1j6D7ToMO3B1y4g7GQ64lnALRLKRSvVKOeVtPCAPKsTaBrZUrb50DkkE9hfjVAHheCoE2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355780; c=relaxed/simple;
	bh=FTRjtFm93P0KQ7qrms/1aW3ZWlXiAEbfWfEaTo73AOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qznGE1PSTI4VKz8Z+y843RfEkMtxJq0pqmck0UcJ+vG5L76T2lEQ9LIVa8BucHY6C68crFN/go7N0p1blj6Kz0M+brOAiHQuA4PlJu8Crm7owPiN9SoHzhZHpQnMeH8orKJNxPIpRozyMxx2Foozy9PbxdaCGGVVTyqfiX8vXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2KpXxov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F6FC4CEE9;
	Tue, 27 May 2025 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748355780;
	bh=FTRjtFm93P0KQ7qrms/1aW3ZWlXiAEbfWfEaTo73AOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2KpXxovOHbdFffxTKk6y0JwaVTknk+0Vmb+U1wwwq//xVDXM6ob3T6ST9OBzn35c
	 abkZh2XGxN9Ev+Q5Md7hEbLnepZ8J39C6mSWGLLpiYlwfcZVdfT94eiBvisVKyZ/ln
	 Fj4bgoImmD3kxJ4ugp7S0ND9e5jUymrnnO1th57+/YgT1shyjTeuADrnSLEOlktgm2
	 AYhzoVsfnMWwehkxT1+A3CFsh+EBFf4cA8z+PmuZen0P+s1/7bmb4pVdN01h23QZLF
	 l/8fadcc6YO+13Nq8Af5KPX6G/mHuTvWOzh4ZA8SUeK0FerDVYgd5Vp9PHdgi9b6bA
	 zf3ggdY3kaoJA==
Date: Tue, 27 May 2025 16:22:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: airoha: Initialize PPE UPDMEM
 source-mac table
Message-ID: <aDXKwWzmE1YSg67u@lore-desk>
References: <20250523-b4-airoha-flowtable-pppoe-v1-0-8584401568e0@kernel.org>
 <20250523-b4-airoha-flowtable-pppoe-v1-1-8584401568e0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hGlac84VtnE2zXGM"
Content-Disposition: inline
In-Reply-To: <20250523-b4-airoha-flowtable-pppoe-v1-1-8584401568e0@kernel.org>


--hGlac84VtnE2zXGM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> UPDMEM source-mac table is a key-value map used to store devices mac
> addresses according to the port identifier. UPDMEM source mac table is
> used during IPv6 traffic hw acceleration since PPE entries, for space
> constraints, do not contain the full source mac address but just the
> identifier in the UPDMEM source-mac table.

This patch has now a conflict with the following commit:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3Dc683e378c0907e66cee939145edf936c254ff1e3

Since this is actually a fix, I can repost targeting net tree as soon as
it is aligned to net-next.

Regards,
Lorenzo

>=20
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  |  2 ++
>  drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
>  drivers/net/ethernet/airoha/airoha_ppe.c  | 25 ++++++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_regs.h | 10 ++++++++++
>  4 files changed, 37 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 0d627e511266d94e079e8a87d2f812fb14b4ad07..e4c67c7bbf215d448640f978c=
d0d9d50abd73644 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -92,6 +92,8 @@ static void airoha_set_macaddr(struct airoha_gdm_port *=
port, const u8 *addr)
>  	val =3D (addr[3] << 16) | (addr[4] << 8) | addr[5];
>  	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
>  	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
> +
> +	airoha_ppe_init_upd_mem(port);
>  }
> =20
>  static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 531a3c49c1562a986111a1ce1c215c8751c16e09..a951246c0171e14497b510d30=
29fc0a7f891efe6 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -611,6 +611,7 @@ void airoha_ppe_check_skb(struct airoha_ppe *ppe, str=
uct sk_buff *skb,
>  int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data=
);
>  int airoha_ppe_init(struct airoha_eth *eth);
>  void airoha_ppe_deinit(struct airoha_eth *eth);
> +void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port);
>  struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
>  						  u32 hash);
>  void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 2d273937f19cf304ab4b821241fdc3ea93604f0e..1d5a04eb82a6645e2b6a22ff4=
e694275ef1727d8 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -223,6 +223,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha=
_eth *eth,
>  	int dsa_port =3D airoha_get_dsa_port(&dev);
>  	struct airoha_foe_mac_info_common *l2;
>  	u32 qdata, ports_pad, val;
> +	u8 smac_id =3D 0xf;
> =20
>  	memset(hwe, 0, sizeof(*hwe));
> =20
> @@ -251,6 +252,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha=
_eth *eth,
>  		else
>  			pse_port =3D 2; /* uplink relies on GDM2 loopback */
>  		val |=3D FIELD_PREP(AIROHA_FOE_IB2_PSE_PORT, pse_port);
> +		smac_id =3D port->id;
>  	}
> =20
>  	if (is_multicast_ether_addr(data->eth.h_dest))
> @@ -285,7 +287,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha=
_eth *eth,
>  		hwe->ipv4.l2.src_mac_lo =3D
>  			get_unaligned_be16(data->eth.h_source + 4);
>  	} else {
> -		l2->src_mac_hi =3D FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, 0xf);
> +		l2->src_mac_hi =3D FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, smac_id);
>  	}
> =20
>  	if (data->vlan.num) {
> @@ -1232,6 +1234,27 @@ void airoha_ppe_check_skb(struct airoha_ppe *ppe, =
struct sk_buff *skb,
>  	airoha_ppe_foe_insert_entry(ppe, skb, hash);
>  }
> =20
> +void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port)
> +{
> +	struct airoha_eth *eth =3D port->qdma->eth;
> +	struct net_device *dev =3D port->dev;
> +	const u8 *addr =3D dev->dev_addr;
> +	u32 val;
> +
> +	val =3D (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];
> +	airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
> +	airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
> +		     FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
> +		     PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
> +
> +	val =3D (addr[0] << 8) | addr[1];
> +	airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
> +	airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
> +		     FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
> +		     FIELD_PREP(PPE_UPDMEM_OFFSET_MASK, 1) |
> +		     PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
> +}
> +
>  int airoha_ppe_init(struct airoha_eth *eth)
>  {
>  	struct airoha_ppe *ppe;
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index d931530fc96fb00ada36a6ad37fa295865a6f0a8..04187eb40ec674ec5a4ccfc96=
8bb4bd579a53095 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -313,6 +313,16 @@
>  #define REG_PPE_RAM_BASE(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x320)
>  #define REG_PPE_RAM_ENTRY(_m, _n)		(REG_PPE_RAM_BASE(_m) + ((_n) << 2))
> =20
> +#define REG_UPDMEM_CTRL(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x370)
> +#define PPE_UPDMEM_ACK_MASK			BIT(31)
> +#define PPE_UPDMEM_ADDR_MASK			GENMASK(11, 8)
> +#define PPE_UPDMEM_OFFSET_MASK			GENMASK(7, 4)
> +#define PPE_UPDMEM_SEL_MASK			GENMASK(3, 2)
> +#define PPE_UPDMEM_WR_MASK			BIT(1)
> +#define PPE_UPDMEM_REQ_MASK			BIT(0)
> +
> +#define REG_UPDMEM_DATA(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x374)
> +
>  #define REG_FE_GDM_TX_OK_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x280)
>  #define REG_FE_GDM_TX_OK_BYTE_CNT_H(_n)		(GDM_BASE(_n) + 0x284)
>  #define REG_FE_GDM_TX_ETH_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x288)
>=20
> --=20
> 2.49.0
>=20

--hGlac84VtnE2zXGM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaDXKwQAKCRA6cBh0uS2t
rAStAP9d6qm3yavT7uFyhvXqBsppqY4+mIOCmQftJeQnbv+ASAEA2sncemBOaV+m
rG6+clC+zzEMS1rmvqitt1wgxFMLfQs=
=Rkzf
-----END PGP SIGNATURE-----

--hGlac84VtnE2zXGM--

