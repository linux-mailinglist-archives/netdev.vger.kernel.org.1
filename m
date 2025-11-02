Return-Path: <netdev+bounces-234898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C66CDC28F6E
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 14:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FB704E17EB
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2AA26290;
	Sun,  2 Nov 2025 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="dtWCXxHM"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15180A48;
	Sun,  2 Nov 2025 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762089493; cv=none; b=iPSkDFliS8R1zAlyEyPCukCWeMRNRioS0z9TKaxm0M1iSeipT988l1O6koX5TDccub6iRVOYXYO0YPJKVRPk9DP+gYdodwVcRwxVq6HCLKtzkmMvPAuEfMauOVZa5Z/gy/inCLajy9No2McyRLk01tzetzRM+8px9+9YvG3ZPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762089493; c=relaxed/simple;
	bh=oEj27hV8sDLRqVeFudzep4sflcLR2vKeiDQrnPPvIiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rps8TvTjE+RYjbI1KEX+iUaygX0uVMO5T0qVt376tVPFpcQvDRuHgrtRTZRO6K8Uh9ZpxrLtp0lp2VVi5kzKnvCbtaf4/EZ6eHseLP+pNtbgEKMvmrnBw+gQYsNuOvx/HEPx5sVazs7pHevbMyrr1wtoYzBb2iqoxlAk4HUpdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=dtWCXxHM; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EBDF103371;
	Sun,  2 Nov 2025 14:18:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1762089488;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d+3XPH4Px7IGAB7ZLN1/Ts7/+liOZBJ5fa+oaD0eqHk=;
	b=dtWCXxHMT32D/Ep/1AYqJD/k5n6MIZkwjB8hXYmLNDk/k+/Opn/fnoGLJikRcAYJHngaWR
	GBCKiDKGrYj6nf08UERwS9JasM2HFgRVoXxq565HPzm3GSXcirLk/R8k3OaTA01xkO/2CP
	D5ZK/ZPtxrEjOFbY92GeNjBSDZlsT9oF0gSuD+UgfqolJYt74FjexqLMDruKR4p9pIGPZA
	TTWhqHfZvIsJ02cA61+HRaZ1cQDt4WfTgsOK5aTpp3ek9gAMl9Qhmbkn2ytxX/iGbpObdf
	iIE4+Jdbtx+WoA1SzkOdpZ9/izmxygncLaVYlt/bc4nbNsSUZLz5nKLIWFGMJQ==
Date: Sun, 2 Nov 2025 14:18:01 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: <Tristram.Ha@microchip.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, Oleksij Rempel <linux@rempel-privat.de>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: microchip: Fix reserved multicast address
 table programming
Message-ID: <20251102141801.63dc212c@wsk>
In-Reply-To: <20251101014803.49842-1-Tristram.Ha@microchip.com>
References: <20251101014803.49842-1-Tristram.Ha@microchip.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Tristram,

> From: Tristram Ha <tristram.ha@microchip.com>
>=20
> KSZ9477/KSZ9897 and LAN937X families of switches use a reserved
> multicast address table for some specific forwarding with some
> multicast addresses, like the one used in STP.  The hardware assumes
> the host port is the last port in KSZ9897 family and port 5 in
> LAN937X family.  Most of the time this assumption is correct but not
> in other cases like KSZ9477. Originally the function just setups the
> first entry, but the others still need update, especially for one
> common multicast address that is used by PTP operation.
>=20
> LAN937x also uses different register bits when accessing the reserved
> table.
>=20
> Fixes: 457c182af597 ("net: dsa: microchip: generic access to ksz9477
> static and reserved table") Signed-off-by: Tristram Ha
> <tristram.ha@microchip.com> ---
>  drivers/net/dsa/microchip/ksz9477.c     | 103
> ++++++++++++++++++++---- drivers/net/dsa/microchip/ksz9477_reg.h |
> 3 +- drivers/net/dsa/microchip/ksz_common.c  |   4 +
>  drivers/net/dsa/microchip/ksz_common.h  |   2 +
>  4 files changed, 96 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz9477.c
> b/drivers/net/dsa/microchip/ksz9477.c index
> d747ea1c41a7..9b6731de52a7 100644 ---
> a/drivers/net/dsa/microchip/ksz9477.c +++
> b/drivers/net/dsa/microchip/ksz9477.c @@ -1355,8 +1355,12 @@ void
> ksz9477_config_cpu_port(struct dsa_switch *ds) }
>  }
> =20
> +static u8 reserved_mcast_map[8] =3D { 0, 1, 3, 16, 32, 33, 2, 17 };
> +
>  int ksz9477_enable_stp_addr(struct ksz_device *dev)
>  {
> +	u8 all_ports =3D (1 << dev->info->port_cnt) - 1;
> +	u8 i, def_port, ports, update;
>  	const u32 *masks;
>  	u32 data;
>  	int ret;
> @@ -1366,23 +1370,94 @@ int ksz9477_enable_stp_addr(struct ksz_device
> *dev) /* Enable Reserved multicast table */
>  	ksz_cfg(dev, REG_SW_LUE_CTRL_0, SW_RESV_MCAST_ENABLE, true);
> =20
> -	/* Set the Override bit for forwarding BPDU packet to CPU */
> -	ret =3D ksz_write32(dev, REG_SW_ALU_VAL_B,
> -			  ALU_V_OVERRIDE | BIT(dev->cpu_port));
> -	if (ret < 0)
> -		return ret;
> +	/* The reserved multicast address table has 8 entries.  Each
> entry has
> +	 * a default value of which port to forward.  It is assumed
> the host
> +	 * port is the last port in most of the switches, but that
> is not the
> +	 * case for KSZ9477 or maybe KSZ9897.  For LAN937X family
> the default
> +	 * port is port 5, the first RGMII port.  It is okay for
> LAN9370, a
> +	 * 5-port switch, but may not be correct for the other 8-port
> +	 * versions.  It is necessary to update the whole table to
> forward to
> +	 * the right ports.
> +	 * Furthermore PTP messages can use a reserved multicast
> address and
> +	 * the host will not receive them if this table is not
> correct.
> +	 */
> +	def_port =3D BIT(dev->info->port_cnt - 1);
> +	if (is_lan937x(dev))
> +		def_port =3D BIT(4);
> +	for (i =3D 0; i < 8; i++) {
> +		data =3D reserved_mcast_map[i] <<
> +			dev->info->shifts[ALU_STAT_INDEX];
> +		data |=3D ALU_STAT_START |
> +			masks[ALU_STAT_DIRECT] |
> +			masks[ALU_RESV_MCAST_ADDR] |
> +			masks[ALU_STAT_READ];
> +		ret =3D ksz_write32(dev, REG_SW_ALU_STAT_CTRL__4,
> data);
> +		if (ret < 0)
> +			return ret;
> =20
> -	data =3D ALU_STAT_START | ALU_RESV_MCAST_ADDR |
> masks[ALU_STAT_WRITE];
> +		/* wait to be finished */
> +		ret =3D ksz9477_wait_alu_sta_ready(dev);
> +		if (ret < 0)
> +			return ret;
> =20
> -	ret =3D ksz_write32(dev, REG_SW_ALU_STAT_CTRL__4, data);
> -	if (ret < 0)
> -		return ret;
> +		ret =3D ksz_read32(dev, REG_SW_ALU_VAL_B, &data);
> +		if (ret < 0)
> +			return ret;
> =20
> -	/* wait to be finished */
> -	ret =3D ksz9477_wait_alu_sta_ready(dev);
> -	if (ret < 0) {
> -		dev_err(dev->dev, "Failed to update Reserved
> Multicast table\n");
> -		return ret;
> +		ports =3D data & dev->port_mask;
> +		if (ports =3D=3D def_port) {
> +			/* Change the host port. */
> +			update =3D BIT(dev->cpu_port);
> +
> +			/* The host port is correct so no need to
> update the
> +			 * the whole table but the first entry still
> needs to
> +			 * set the Override bit for STP.
> +			 */
> +			if (update =3D=3D def_port && i =3D=3D 0)
> +				ports =3D 0;
> +		} else if (ports =3D=3D 0) {
> +			/* No change to entry. */
> +			update =3D 0;
> +		} else if (ports =3D=3D (all_ports & ~def_port)) {
> +			/* This entry does not forward to host port.
>  But if
> +			 * the host needs to process protocols like
> MVRP and
> +			 * MMRP the host port needs to be set.
> +			 */
> +			update =3D ports & ~BIT(dev->cpu_port);
> +			update |=3D def_port;
> +		} else {
> +			/* No change to entry. */
> +			update =3D ports;
> +		}
> +		if (update !=3D ports) {
> +			data &=3D ~dev->port_mask;
> +			data |=3D update;
> +			/* Set Override bit for STP in the first
> entry. */
> +			if (i =3D=3D 0)
> +				data |=3D ALU_V_OVERRIDE;
> +			ret =3D ksz_write32(dev, REG_SW_ALU_VAL_B,
> data);
> +			if (ret < 0)
> +				return ret;
> +
> +			data =3D reserved_mcast_map[i] <<
> +			       dev->info->shifts[ALU_STAT_INDEX];
> +			data |=3D ALU_STAT_START |
> +				masks[ALU_STAT_DIRECT] |
> +				masks[ALU_RESV_MCAST_ADDR] |
> +				masks[ALU_STAT_WRITE];
> +			ret =3D ksz_write32(dev,
> REG_SW_ALU_STAT_CTRL__4, data);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* wait to be finished */
> +			ret =3D ksz9477_wait_alu_sta_ready(dev);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* No need to check the whole table. */
> +			if (i =3D=3D 0 && !ports)
> +				break;
> +		}
>  	}
> =20
>  	return 0;
> diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h
> b/drivers/net/dsa/microchip/ksz9477_reg.h index
> ff579920078e..61ea11e3338e 100644 ---
> a/drivers/net/dsa/microchip/ksz9477_reg.h +++
> b/drivers/net/dsa/microchip/ksz9477_reg.h @@ -2,7 +2,7 @@
>  /*
>   * Microchip KSZ9477 register definitions
>   *
> - * Copyright (C) 2017-2024 Microchip Technology Inc.
> + * Copyright (C) 2017-2025 Microchip Technology Inc.
>   */
> =20
>  #ifndef __KSZ9477_REGS_H
> @@ -397,7 +397,6 @@
> =20
>  #define ALU_RESV_MCAST_INDEX_M		(BIT(6) - 1)
>  #define ALU_STAT_START			BIT(7)
> -#define ALU_RESV_MCAST_ADDR		BIT(1)
> =20
>  #define REG_SW_ALU_VAL_A		0x0420
> =20
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c index
> a962055bfdbd..933ae8dc6337 100644 ---
> a/drivers/net/dsa/microchip/ksz_common.c +++
> b/drivers/net/dsa/microchip/ksz_common.c @@ -808,6 +808,8 @@ static
> const u16 ksz9477_regs[] =3D { static const u32 ksz9477_masks[] =3D {
>  	[ALU_STAT_WRITE]		=3D 0,
>  	[ALU_STAT_READ]			=3D 1,
> +	[ALU_STAT_DIRECT]		=3D 0,
> +	[ALU_RESV_MCAST_ADDR]		=3D BIT(1),
>  	[P_MII_TX_FLOW_CTRL]		=3D BIT(5),
>  	[P_MII_RX_FLOW_CTRL]		=3D BIT(3),
>  };
> @@ -835,6 +837,8 @@ static const u8 ksz9477_xmii_ctrl1[] =3D {
>  static const u32 lan937x_masks[] =3D {
>  	[ALU_STAT_WRITE]		=3D 1,
>  	[ALU_STAT_READ]			=3D 2,
> +	[ALU_STAT_DIRECT]		=3D BIT(3),
> +	[ALU_RESV_MCAST_ADDR]		=3D BIT(2),
>  	[P_MII_TX_FLOW_CTRL]		=3D BIT(5),
>  	[P_MII_RX_FLOW_CTRL]		=3D BIT(3),
>  };
> diff --git a/drivers/net/dsa/microchip/ksz_common.h
> b/drivers/net/dsa/microchip/ksz_common.h index
> a1eb39771bb9..c65188cd3c0a 100644 ---
> a/drivers/net/dsa/microchip/ksz_common.h +++
> b/drivers/net/dsa/microchip/ksz_common.h @@ -294,6 +294,8 @@ enum
> ksz_masks { DYNAMIC_MAC_TABLE_TIMESTAMP,
>  	ALU_STAT_WRITE,
>  	ALU_STAT_READ,
> +	ALU_STAT_DIRECT,
> +	ALU_RESV_MCAST_ADDR,
>  	P_MII_TX_FLOW_CTRL,
>  	P_MII_RX_FLOW_CTRL,
>  };

Thank you for the patch.

Now I'm able to synchronize device connected to KSZ9477 (port6 host
port).
I've applied and tested this patch on v6.6. LTS kernel (and hopefully
it can be backported to LTS kernels as well).

Tested-by: =C5=81ukasz Majewski <lukma@nabladev.com>

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic

