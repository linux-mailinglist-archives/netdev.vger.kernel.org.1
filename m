Return-Path: <netdev+bounces-293054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFRbH5taGWqtvggAu9opvQ
	(envelope-from <netdev+bounces-293054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE45FFD74
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E11F73030B14
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9A3BA24E;
	Fri, 29 May 2026 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv74675g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB113BCD38
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046450; cv=none; b=l91Nmn1DSKPEzoDvDmVGXjrvhaFgtaazpo1drql5Bl8q1BgNXkBvkqXSp/Tmsh2DdQKxq/KKgz3mqa33oW9vFEUtrBDKX2KC7KFcJ9zJ+mjzOSbsqenx1MmK9xaW0r1Cfp+hXaxr3M5hiM/Nn0K7/WuJ2+HkTzHduFkNBxVEAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046450; c=relaxed/simple;
	bh=WUWMEF48Hm7yjHQAwuZROg2hGXZbz5Up9lkBxLDCYJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEq1FJYSWAMI1U8WYTRBoevjFQaNqcBthmOgzf00dyySSDAPnbj0kbleLwN4lXG/R09ut0uqnmcdnacTyqWPl8LfN+NR+gk/sppcoso1T2sA2FxEfb4q9kiss4C83X0q2UvpFQHB27i6CB2KRe4ArzLN/E7dX0VuW2H1IOFTnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv74675g; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so1435333a12.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780046444; x=1780651244; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nKgUlT1tOknFVnM1jNj+4pgKP0eWYtcm3Br6i4q+ckY=;
        b=Bv74675gAWmydSAxKxLy6tXmgUKRUHS7GlHfR3Kjj2XzD8Sy+RygpqXsZHP6S0UIBP
         NwcsD+rFvFN6wHX/l6Tv1A9ImvyZc7ezU5oIq6GGZi4Ir/X7OdXuDTKWo9/4yFUBi30L
         Q743O8qY1IX97cWLFfyoUgSggAbXtx23l8JpgqnX2GqbPiuugE43Nc3KQ+ahpNIPmMfz
         F07rMSYDp3x/F5VImciYDxZKPq+smZipS5APSZhECfbaLNCsKDPr2ejzU2sIesfX74pB
         yVq+ZubDnTFuFYZe5gxumlZm7swblFiQtorRLZroZjHKOepPDvjlXbb3bvF8r3iDf1ou
         kDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780046444; x=1780651244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKgUlT1tOknFVnM1jNj+4pgKP0eWYtcm3Br6i4q+ckY=;
        b=hqyrGzQu7yZIL59upJdp9uKTZyED49B1vHC1Y/KjfSeccMcc0Pvobt+RFboaeWjvtP
         RZTO51yN/8wIHuIraYy8ySGKnj5A5Vjgnr57XziFMXc0SdKu4yRqbILhrXWlzaR4wCCp
         EIRp6ZOz1eJxBH2qK88frbLt5uZEPEQk2kZw+hOS5TJYrPcDhYjQfc+CPXhU+E0BNSgQ
         cyR9DZFuq4GMVGSBdjuhXvBRbzX1MurbAz3i0u/sWhC9MaCUPvqPTfFa29NLGAuezJ4e
         ZFi7wQR/1ahr5qy9oaEhSU8Ed2hKKBs1Fd94pKfOGPuIX9smaNLx8Hy+GPfFQ4n5LvHN
         M+HA==
X-Forwarded-Encrypted: i=1; AFNElJ9FK0YJsa97W/ud40NL5p3xrMdFts3bFBzsdyAhwHNYVxN6/+245Ql1k2zotcaEzCPu0KgJH68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvEaaRwArEi4K6GRHWpk7ZPMqu3DkqUYMAngL6VAlCc0zjsBgU
	zQMcyJEkwmX8+WjSmoK2i0fQRCm7MGoDWRuqduR6KEx/ch8YutlEbqZl
X-Gm-Gg: Acq92OFq5V2d4VXYKeUYFq55OrkKzXoHq1IBd146H6/RPRzBEEEv7eGxBq8ZvRqtElC
	b8gf98/9wrcVHz40gZXb2ByWuiB3ChEvmNYnc/fI/RSzX7zd4T3OFCXoYR0TDyk14a2FQA+lue7
	sEGYmSK4PldFSIUhwsJ84Ehp1UwpAzmUxXULxbcqNLXTJRDcLAqGJdJmjFfQFIsMWzbZCZKzqSD
	MSaVO4Zn0XCm/tLktDZuK7yyOROfNXyAdcmkda7LIoYLLUCWhM7CEUvTP3nONf7YcTOooKVQlGX
	JfZKrAsdmcbJ++R9jtOnxHiX8iVAGVTUB7l/oQT5jnEFSa0eHKQOMHUMPcy3kSu5ji/UATcgRHm
	QRPfWhUcEtvsmNplZAwvrXoF+RlZNlHN7sFLvmW6EGUQ9J4bEYuzgAAxetO/FBDC5VvbB/H4mz5
	IcFrZ3SmT+mCQjII0aZIrVlgUbyWz5R/P5uQ==
X-Received: by 2002:a05:6402:11c7:b0:68b:d82b:fbd with SMTP id 4fb4d7f45d1cf-68c10e68dbfmr989394a12.24.1780046443463;
        Fri, 29 May 2026 02:20:43 -0700 (PDT)
Received: from nsa ([45.94.208.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68c16315cccsm381478a12.28.2026.05.29.02.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 02:20:43 -0700 (PDT)
Date: Fri, 29 May 2026 10:21:40 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/10] net: ethernet: adi: Add a driver for
 the ADIN1140 MACPHY
Message-ID: <ahlY8WSRO_HPmGtK@nsa>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-10-37e5c8d4e0a0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527-adin1140-driver-v2-10-37e5c8d4e0a0@analog.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293054-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DFFE45FFD74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:51:55AM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> Add a driver for ADIN1140. The device is a 10BASE-T1S MAC-PHY
> (integrated in the same package) that connects to a CPU over an SPI bus,
> and implements the Open Alliance TC6 protocol for control and frame
> transfers. As such, this driver relies on oa_tc6 for the communication
> with the device. The device has an alternative name (AD3306), so the
> driver can be probed using one of the two compatible strings.
> 
> For control transactions, ADIN1140 only implements the protected mode.
> The driver has a custom implementation for the mii_bus access methods as a
> workaround for hardware issues:
> 
> 1. The OA TC6 standard defines the direct and indirect access modes for
>    MDIO transactions. The ADIN1140 incorrectly advertises indirect mode
>    only (supported capabilities register - 0x2, bit 9), while actually
>    implementing just the direct mode. We cannot rely on the CAP register
>    to choose an access method (which oa_tc6 does by default, even though
>    it only implements the direct mode), so the driver has to use its
>    own.
> 2. The ADIN1140 cannot access the C22 register space of the internal
>    PHY, while the PHY is busy receiving frames. If that happens, the
>    CONFIG0 and CONFIG2 registers of the MAC will get corrupted and the
>    data transfer will stop. Those two registers configure settings for
>    the transfer protocol between the MAC and host, so the value for some
>    of their subfields shouldn't be changed while the netdev is up.
>    Since we know the PHY is internal, the MAC driver can implement a
>    custom mii_bus, which can intercept C22 accesses. Most of the
>    registers mapped in the 0x0 - 0x3 range (the only ones the PHY offers)
>    are read only, and their value can be read from somewhere else (e.g
>    the PHYID 1 & 2 have the same value as 0x1 in the MAC memory map).
>    For the fields that are R/W (loopback and AN/reset) in the control
>    register, the PHY driver already implements the set_loopback() and
>    config_aneg() functions. The C22 write function of the driver is a
>    no-op and is used to protect against the ioctl MDIO access path.
>    C45 accesses do not cause this issue, so we can properly implement
>    them.
> 
> Update the oa_tc6 header file to include definitions for the standard
> registers used by the adin1140 driver.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> 
> ---
> v2 changelog:
>  - Exported statistics that match the ethtool_stats entries as such and
>    kept the other ones custom, using ethtool strings.
>  - Used phy_do_ioctl_running() for ndo_eth_ioctl.
>  - Adapted the mii_bus and PHY handling to the newly added
>    OA_TC6_BROKEN_PHY flag for oa_tc6.
>  - Used the oa_tc6_mdiobus_read_c45/oa_tc6_mdiobus_write_c45 functions
>    for the C45 read/write mii_bus operations.
>  - Removed OA TC6 register definitions (e.g CONFIG2) from the adin1140
>    driver and instead used the ones exported from oa_tc6.h
>  - Used OA_TC6_MMS_REG to define MMS registers instead of
>    ADIN1140_MMS_REG.
>  - Returned default values for the MII_PHYSID1/MII_PHYSID2.
>  - Set the mii_bus->phy_mask, since the the same PHY will be registered
>    32 times otherwise.
>  - Updated the MAINTAINERS entry to include the dt-bindings.
> ---
>  MAINTAINERS                         |   8 +
>  drivers/net/ethernet/adi/Kconfig    |  12 +
>  drivers/net/ethernet/adi/Makefile   |   1 +
>  drivers/net/ethernet/adi/adin1140.c | 811 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 832 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eda74f3154dc..3d6da16c4312 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1857,6 +1857,14 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/dma/dma-axi-dmac.c
>  
> +ANALOG DEVICES INC ETHERNET DRIVERS
> +M:	Ciprian Regus <ciprian.regus@analog.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/net/adi,adin1140.yaml
> +F:	drivers/net/ethernet/adi/adin1140.c
> +
>  ANALOG DEVICES INC ETHERNET PHY DRIVERS
>  M:	Ciprian Regus <ciprian.regus@analog.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
> index 760a9a60bc15..bdb8ff7d15da 100644
> --- a/drivers/net/ethernet/adi/Kconfig
> +++ b/drivers/net/ethernet/adi/Kconfig
> @@ -26,4 +26,16 @@ config ADIN1110
>  	  Say yes here to build support for Analog Devices ADIN1110
>  	  Low Power 10BASE-T1L Ethernet MAC-PHY.
>  
> +config ADIN1140
> +	tristate "Analog Devices ADIN1140 MAC-PHY"
> +	depends on SPI
> +	select ADIN1140_PHY
> +	select OA_TC6
> +	help
> +	  Say yes here to build support for Analog Devices, Inc. ADIN1140
> +	  10BASE-T1S Ethernet MAC-PHY.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called adin1140.
> +
>  endif # NET_VENDOR_ADI
> diff --git a/drivers/net/ethernet/adi/Makefile b/drivers/net/ethernet/adi/Makefile
> index d0383d94303c..0390ca8ccc49 100644
> --- a/drivers/net/ethernet/adi/Makefile
> +++ b/drivers/net/ethernet/adi/Makefile
> @@ -4,3 +4,4 @@
>  #
>  
>  obj-$(CONFIG_ADIN1110) += adin1110.o
> +obj-$(CONFIG_ADIN1140) += adin1140.o
> diff --git a/drivers/net/ethernet/adi/adin1140.c b/drivers/net/ethernet/adi/adin1140.c
> new file mode 100644
> index 000000000000..671bfc08ce38
> --- /dev/null
> +++ b/drivers/net/ethernet/adi/adin1140.c
> @@ -0,0 +1,811 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for Analog Devices, Inc. ADIN1140 10BASE-T1S MAC-PHY
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/kernel.h>
> +#include <linux/mdio.h>
> +#include <linux/module.h>
> +#include <linux/oa_tc6.h>
> +#include <linux/phy.h>

...

> +}
> +
> +static void adin1140_rx_mode(struct net_device *netdev)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +
> +	schedule_work(&priv->rx_mode_work);
> +}
> +
> +static void adin1140_stats_work(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	u64 stat_buff[ADIN1140_STATS_CNT] = {};
> +	struct adin1140_priv *priv;
> +	u32 reg_val;
> +	int ret;
> +	u32 i;
> +
> +	priv = container_of(dwork, struct adin1140_priv, stats_work);
> +
> +	for (i = 0; i < ARRAY_SIZE(adin1140_stat_regs); i++) {
> +		ret = oa_tc6_read_register(priv->tc6, adin1140_stat_regs[i],
> +					   &reg_val);
> +		if (ret)
> +			break;
> +
> +		stat_buff[i] = reg_val;
> +	}
> +
> +	spin_lock(&priv->stat_lock);

Maybe consider using scoped_guard() and similar for other places?
Marginal win though so up to you.

> +	memcpy(&priv->stats, stat_buff, sizeof(priv->stats));
> +	spin_unlock(&priv->stat_lock);
> +
> +	schedule_delayed_work(dwork, ADIN1140_STATS_CHECK_DELAY);
> +}
> +
> +static int adin1140_configure(struct adin1140_priv *priv)
> +{
> +	int ret;
> +
> +	ret = oa_tc6_zero_align_receive_frame_enable(priv->tc6);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable MAC loopback */
> +	ret = oa_tc6_write_register(priv->tc6, ADIN1140_MAC_P1_LOOP_ADDR_REG,
> +				    0x0);
> +	if (ret)
> +		return ret;
> +
> +	return adin1140_default_filter_config(priv);
> +}
> +
> +static int adin1140_open(struct net_device *netdev)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +
> +	schedule_delayed_work(&priv->stats_work, ADIN1140_STATS_CHECK_DELAY);
> +
> +	phy_start(netdev->phydev);
> +	netif_start_queue(netdev);
> +
> +	return 0;
> +}
> +
> +static int adin1140_close(struct net_device *netdev)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +
> +	cancel_delayed_work_sync(&priv->stats_work);
> +
> +	netif_stop_queue(netdev);
> +	phy_stop(netdev->phydev);
> +
> +	return 0;
> +}
> +
> +static netdev_tx_t adin1140_start_xmit(struct sk_buff *skb,
> +				       struct net_device *netdev)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +
> +	/* Pad frames to minimum Ethernet frame size (60 bytes without FCS).
> +	 * The MAC will append the FCS, but we need to ensure the frame is
> +	 * at least ETH_ZLEN bytes.
> +	 */
> +	if (skb_put_padto(skb, ETH_ZLEN))
> +		return NETDEV_TX_OK;
> +
> +	return oa_tc6_start_xmit(priv->tc6, skb);
> +}
> +
> +static int adin1140_set_mac_address(struct net_device *netdev, void *addr)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +	struct sockaddr *address = addr;
> +	u8 mask[ETH_ALEN];
> +	int ret;
> +
> +	ret = eth_prepare_mac_addr_change(netdev, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ether_addr_equal(address->sa_data, netdev->dev_addr))
> +		return 0;
> +
> +	memset(mask, 0xFF, ETH_ALEN);
> +	ret = adin1140_mac_filter_set(priv, address->sa_data, mask,
> +				      ADIN1140_MAC_FILT_UC_SLOT);
> +	if (ret)
> +		return ret;
> +
> +	eth_commit_mac_addr_change(netdev, addr);
> +
> +	return 0;
> +}
> +
> +static void adin1140_ndo_get_stats64(struct net_device *dev,
> +				     struct rtnl_link_stats64 *storage)
> +{
> +	struct adin1140_priv *priv = netdev_priv(dev);
> +
> +	storage->rx_packets = priv->netdev->stats.rx_packets;
> +	storage->tx_packets = priv->netdev->stats.tx_packets;
> +
> +	storage->rx_bytes = priv->netdev->stats.rx_bytes;
> +	storage->tx_bytes = priv->netdev->stats.tx_bytes;
> +
> +	spin_lock(&priv->stat_lock);
> +
> +	storage->rx_errors = priv->stats[rx_crc_errors] +
> +			     priv->stats[rx_align_errors] +
> +			     priv->stats[rx_preamble_errors] +
> +			     priv->stats[rx_short_frame_errors] +
> +			     priv->stats[rx_long_frame_errors] +
> +			     priv->stats[rx_phy_errors] +
> +			     priv->stats[rx_ifg_errors];
> +
> +	storage->tx_errors = priv->stats[tx_excess_collision] +
> +			     priv->stats[tx_underrun];
> +
> +	storage->rx_dropped = priv->stats[rx_fifo_full_dropped] +
> +			      priv->stats[rx_addr_filter_dropped];
> +
> +	storage->multicast = priv->stats[rx_mc_frames];
> +
> +	storage->collisions = priv->stats[tx_single_collision] +
> +			      priv->stats[tx_multi_collision];
> +
> +	storage->rx_length_errors = priv->stats[rx_short_frame_errors] +
> +				    priv->stats[rx_long_frame_errors];
> +	storage->rx_over_errors = priv->stats[rx_fifo_full_dropped];
> +	storage->rx_crc_errors = priv->stats[rx_crc_errors];
> +	storage->rx_frame_errors = priv->stats[rx_align_errors];
> +	storage->rx_missed_errors = priv->stats[rx_fifo_full_dropped];
> +
> +	storage->tx_aborted_errors = priv->stats[tx_excess_collision];
> +	storage->tx_fifo_errors = priv->stats[tx_underrun];
> +	storage->tx_window_errors = priv->stats[tx_late_collision];
> +
> +	spin_unlock(&priv->stat_lock);
> +}
> +
> +static void adin1140_get_drvinfo(struct net_device *netdev,
> +				 struct ethtool_drvinfo *info)
> +{
> +	strscpy(info->driver, "ADIN1140", sizeof(info->driver));
> +	strscpy(info->bus_info, dev_name(netdev->dev.parent),
> +		sizeof(info->bus_info));
> +}
> +
> +static void adin1140_get_ethtool_stats(struct net_device *netdev,
> +				       struct ethtool_stats *stats, u64 *data)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +	u32 i;
> +
> +	spin_lock(&priv->stat_lock);
> +	for (i = 0; i < ARRAY_SIZE(adin1140_stats); i++)
> +		data[i] = priv->stats[adin1140_stats[i].idx];
> +	spin_unlock(&priv->stat_lock);
> +}
> +
> +static void adin1140_get_ethtool_strings(struct net_device *netdev, u32 sset,
> +					 u8 *p)
> +{
> +	u32 i;
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		for (i = 0; i < ARRAY_SIZE(adin1140_stats); i++)
> +			ethtool_puts(&p, adin1140_stats[i].name);
> +
> +		break;
> +	}
> +}
> +
> +static int adin1140_get_sset_count(struct net_device *netdev, int sset)
> +{
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		return ARRAY_SIZE(adin1140_stats);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static void adin1140_get_eth_mac_stats(struct net_device *netdev,
> +				       struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +
> +	spin_lock(&priv->stat_lock);
> +
> +	mac_stats->FramesReceivedOK = priv->stats[rx_frames];
> +	mac_stats->BroadcastFramesReceivedOK = priv->stats[rx_bc_frames];
> +	mac_stats->MulticastFramesReceivedOK = priv->stats[rx_mc_frames];
> +	mac_stats->FrameCheckSequenceErrors = priv->stats[rx_crc_errors];
> +	mac_stats->AlignmentErrors = priv->stats[rx_align_errors];
> +	mac_stats->FrameTooLongErrors = priv->stats[rx_long_frame_errors];
> +	mac_stats->FramesLostDueToIntMACRcvError =
> +					priv->stats[rx_fifo_full_dropped];
> +	mac_stats->FramesTransmittedOK = priv->stats[tx_frames];
> +	mac_stats->BroadcastFramesXmittedOK = priv->stats[tx_bc_frames];
> +	mac_stats->MulticastFramesXmittedOK = priv->stats[tx_mc_frames];
> +	mac_stats->SingleCollisionFrames = priv->stats[tx_single_collision];
> +	mac_stats->MultipleCollisionFrames = priv->stats[tx_multi_collision];
> +	mac_stats->FramesWithDeferredXmissions = priv->stats[tx_deferred];
> +	mac_stats->LateCollisions = priv->stats[tx_late_collision];
> +	mac_stats->FramesAbortedDueToXSColls = priv->stats[tx_excess_collision];
> +	mac_stats->FramesLostDueToIntMACXmitError = priv->stats[tx_underrun];
> +
> +	spin_unlock(&priv->stat_lock);
> +}
> +
> +static int adin1140_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
> +{
> +	/* The ADIN1140's standard PHY C22 register map (OA TC6 0xFF00 -
> +	 * 0xFF1F), of which only 0xFF00 - 0xFF03 are implemented) cannot be
> +	 * accessed while frames are being received by the PHY. In case this
> +	 * happens the CONFIG0 and CONFIG2 register values will get corrupted,
> +	 * getting a random value. Both reads and writes cause the same
> +	 * behavior. This is a workaround that avoids MDIO accesses all
> +	 * together. Since this is a 10BASE-T1S PHY, only the loopback and
> +	 * reset (AN) bits in the control register (0x0) can be written.
> +	 * These functionalities have custom implementations in the PHY
> +	 * driver. C45 accesses do not cause this issue.
> +	 */
> +
> +	switch (regnum) {
> +	case MII_BMCR:
> +		return ADIN1140_PHY_CTRL_DEFAULT;
> +	case MII_BMSR:
> +		return ADIN1140_PHY_STATUS_DEFAULT;
> +	case MII_PHYSID1:
> +		return ADIN1140_PHY_ID1;
> +	case MII_PHYSID2:
> +		return ADIN1140_PHY_ID2;
> +	default:
> +		return 0xFFFF;
> +	}
> +}
> +
> +static int adin1140_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
> +				  u16 val)
> +{
> +	return -EIO;
> +}
> +
> +static int adin1140_mdio_register(struct adin1140_priv *priv,
> +				  struct spi_device *spidev)
> +{
> +	int ret;
> +
> +	priv->mdiobus = mdiobus_alloc();
> +	if (!priv->mdiobus) {
> +		netdev_err(priv->netdev, "MDIO bus alloc failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv->mdiobus->name = "adin1140-mdiobus";
> +	priv->mdiobus->priv = priv->tc6;
> +	priv->mdiobus->parent = &spidev->dev;
> +	priv->mdiobus->phy_mask = ~BIT(0);
> +	priv->mdiobus->read = adin1140_mdiobus_read;
> +	priv->mdiobus->write = adin1140_mdiobus_write;
> +	priv->mdiobus->read_c45 = oa_tc6_mdiobus_read_c45;
> +	priv->mdiobus->write_c45 = oa_tc6_mdiobus_write_c45;
> +
> +	snprintf(priv->mdiobus->id, MII_BUS_ID_SIZE, "adin1140-%s.%u",
> +		 dev_name(&spidev->dev), spi_get_chipselect(spidev, 0));
> +
> +	ret = mdiobus_register(priv->mdiobus);
> +	if (ret) {
> +		netdev_err(priv->netdev, "Could not register MDIO bus\n");
> +		mdiobus_free(priv->mdiobus);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void adin1140_handle_link_change(struct net_device *netdev)
> +{
> +	phy_print_status(netdev->phydev);
> +}
> +
> +static int adin1140_phy_init(struct adin1140_priv *priv,
> +			     struct spi_device *spidev)
> +{
> +	int ret;
> +
> +	ret = adin1140_mdio_register(priv, spidev);
> +	if (ret)
> +		return ret;
> +
> +	priv->phydev = phy_find_first(priv->mdiobus);
> +	if (!priv->phydev) {
> +		netdev_err(priv->netdev, "No PHY found\n");
> +		ret = -ENODEV;
> +		goto free_mdio;
> +	}
> +
> +	priv->phydev->is_internal = true;
> +	ret = phy_connect_direct(priv->netdev, priv->phydev,
> +				 &adin1140_handle_link_change,
> +				 PHY_INTERFACE_MODE_INTERNAL);
> +	if (ret) {
> +		netdev_err(priv->netdev, "Can't attach PHY to %s\n",
> +			   priv->mdiobus->id);
> +		goto unregister_mdio;
> +	}
> +
> +	phy_attached_info(priv->phydev);
> +
> +	return 0;
> +
> +unregister_mdio:
> +	mdiobus_unregister(priv->mdiobus);
> +free_mdio:
> +	mdiobus_free(priv->mdiobus);
> +
> +	return ret;
> +}
> +
> +static void adin1140_phy_remove(struct adin1140_priv *priv)
> +{
> +	phy_disconnect(priv->phydev);
> +	mdiobus_unregister(priv->mdiobus);
> +	mdiobus_free(priv->mdiobus);
> +}
> +
> +static const struct ethtool_ops adin1140_ethtool_ops = {
> +	.get_drvinfo = adin1140_get_drvinfo,
> +	.get_link = ethtool_op_get_link,
> +	.get_ethtool_stats = adin1140_get_ethtool_stats,
> +	.get_sset_count = adin1140_get_sset_count,
> +	.get_strings = adin1140_get_ethtool_strings,
> +	.get_link_ksettings = phy_ethtool_get_link_ksettings,
> +	.set_link_ksettings = phy_ethtool_set_link_ksettings,
> +	.get_eth_mac_stats = adin1140_get_eth_mac_stats,
> +};
> +
> +static const struct net_device_ops adin1140_netdev_ops = {
> +	.ndo_open = adin1140_open,
> +	.ndo_stop = adin1140_close,
> +	.ndo_start_xmit	= adin1140_start_xmit,
> +	.ndo_set_mac_address = adin1140_set_mac_address,
> +	.ndo_validate_addr = eth_validate_addr,
> +	.ndo_set_rx_mode = adin1140_rx_mode,
> +	.ndo_eth_ioctl = phy_do_ioctl_running,
> +	.ndo_get_stats64 = adin1140_ndo_get_stats64,
> +};
> +
> +static int adin1140_probe(struct spi_device *spi)
> +{
> +	struct oa_tc6_config tc6_config = {};
> +	struct net_device *netdev;
> +	struct adin1140_priv *priv;
> +	int ret;
> +
> +	netdev = alloc_etherdev(sizeof(struct adin1140_priv));
> +	if (!netdev)
> +		return -ENOMEM;

devm_alloc_etherdev() and similar so that we can make error handling
easier? Any strong reason to not use device managed allocations?

> +
> +	priv = netdev_priv(netdev);
> +	priv->netdev = netdev;
> +	spi_set_drvdata(spi, priv);
> +	spin_lock_init(&priv->stat_lock);
> +
> +	tc6_config.spi = spi;
> +	tc6_config.netdev = netdev;
> +	tc6_config.quirk_flags = OA_TC6_BROKEN_PHY;
> +
> +	priv->tc6 = oa_tc6_init(&tc6_config);
> +	if (!priv->tc6) {
> +		ret = -ENODEV;
> +		goto netdev_free;
> +	}
> +
> +	ret = adin1140_phy_init(priv, spi);
> +	if (ret)
> +		goto oa_tc6_exit;
> +
> +	if (device_get_ethdev_address(&spi->dev, netdev))
> +		eth_hw_addr_random(netdev);
> +
> +	ret = adin1140_configure(priv);
> +	if (ret)
> +		goto phy_exit;
> +
> +	INIT_WORK(&priv->rx_mode_work, adin1140_rx_mode_work);
> +	INIT_DELAYED_WORK(&priv->stats_work, adin1140_stats_work);
> +
> +	netdev->if_port = IF_PORT_10BASET;
> +	netdev->irq = spi->irq;
> +	netdev->netdev_ops = &adin1140_netdev_ops;
> +	netdev->ethtool_ops = &adin1140_ethtool_ops;
> +	netdev->netns_immutable = true;
> +	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
> +			      IFF_UNICAST_FLT;
> +
> +	ret = register_netdev(netdev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to register netdev (%d)", ret);

If we go to devm, this could be return dev_err_probe().

- Nuno Sá


