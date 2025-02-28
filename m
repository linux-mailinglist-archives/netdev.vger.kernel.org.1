Return-Path: <netdev+bounces-170721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443DAA49B30
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E86173EF7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECD25F984;
	Fri, 28 Feb 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C1/ugVwd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D857FBD6;
	Fri, 28 Feb 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751320; cv=none; b=PfHJ+6lG9HYlPCgP7WtLQSSrjIMbOt6c6U+vq55TcOX8jTodlSpyIcyqI5mRRi4IGK1w6mis4gt3VEBp0tmWyruXwWhZnwB5UpHAYpDfOEAyOSk5M925ZvejTALkdqIdU0nDTRggp0r10CXkLqwgTqpjqKtrjTwU/jQFtZxcY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751320; c=relaxed/simple;
	bh=rWHx8pt7zMD+g03RSGNkmfH1xhrl+bG43PL3JSa1Upk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWAK2d3wQcXlswAgy9P7Gb4dVczaibV29mHYIXWJRFeX54oV8An1v5JIRPKtcxESwh2TWV7Z3evexfHb+GUGvvvT5Szgdlt1aGj6FuGsqc9asM9LGiu+PusahkUTGVHCaVumIXPSb5qR+rMji5Pc5AgeEmTHbI9FiJnrwZspJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C1/ugVwd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cenWhbLBqcDvt3xtpjUzYCaDt3ydVGh8F+n6TXXgOhE=; b=C1/ugVwdQOaJDSTrNOViGMbjTA
	JeAAt9AMqzarMp6+aJ0pDka8o6zbbYTG1WTzXJyLsyJ3p0i0QM49r21yToGD9iDsu3MlfH6P8XKDu
	4QSqeVeIHf70XFuIRmf0WpB7LRixaE+xFOaabZgHmeEMsSQjrNJfZo/eQPmjZF0Ty8vc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1to0vq-000xZv-0y; Fri, 28 Feb 2025 15:01:38 +0100
Date: Fri, 28 Feb 2025 15:01:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v3 01/14] motorcomm:yt6801: Implement mdio
 register
Message-ID: <415610dc-3350-4b15-a189-3b3eafbfab99@lunn.ch>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
 <20250228100020.3944-2-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228100020.3944-2-Frank.Sae@motor-comm.com>

On Fri, Feb 28, 2025 at 06:01:04PM +0800, Frank Sae wrote:
> Implement the mdio bus read, write and register function.

> +++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801.h
> @@ -0,0 +1,379 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
> +
> +#ifndef YT6801_H
> +#define YT6801_H
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/timecounter.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/workqueue.h>
> +#include <linux/crc32poly.h>
> +#include <linux/if_vlan.h>
> +#include <linux/bitrev.h>
> +#include <linux/bitops.h>
> +#include <linux/mdio.h>
> +#include <linux/phy.h>
> +
> +#ifdef CONFIG_PCI_MSI
> +#include <linux/pci.h>
> +#endif
> +
> +#include "yt6801_type.h"
> +
> +#define FXGMAC_DRV_NAME		"yt6801"
> +#define FXGMAC_DRV_DESC		"Motorcomm Gigabit Ethernet Driver"
> +
> +#define FXGMAC_RX_BUF_ALIGN	64
> +#define FXGMAC_TX_MAX_BUF_SIZE	(0x3fff & ~(FXGMAC_RX_BUF_ALIGN - 1))
> +#define FXGMAC_RX_MIN_BUF_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN + VLAN_HLEN)
> +
> +/* Descriptors required for maximum contiguous TSO/GSO packet */
> +#define FXGMAC_TX_MAX_SPLIT	((GSO_MAX_SIZE / FXGMAC_TX_MAX_BUF_SIZE) + 1)
> +
> +/* Maximum possible descriptors needed for a SKB */
> +#define FXGMAC_TX_MAX_DESC_NR	(MAX_SKB_FRAGS + FXGMAC_TX_MAX_SPLIT + 2)
> +
> +#define FXGMAC_DMA_STOP_TIMEOUT		5
> +#define FXGMAC_JUMBO_PACKET_MTU		9014
> +#define FXGMAC_MAX_DMA_RX_CHANNELS	4
> +#define FXGMAC_MAX_DMA_TX_CHANNELS	1
> +#define FXGMAC_MAX_DMA_CHANNELS                                           \
> +	(FXGMAC_MAX_DMA_RX_CHANNELS + FXGMAC_MAX_DMA_TX_CHANNELS)
> +
> +struct fxgmac_ring_buf {
> +	struct sk_buff *skb;
> +	dma_addr_t skb_dma;
> +	unsigned int skb_len;
> +};

There is clearly a lot of stuff here which has nothing to do with
MDIO. Please only add things which are truly to do with MDIO, in a
patch which claims to add support for MDIO read/write/register.

> +++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
> +
> +#include <linux/inetdevice.h>
> +#include <linux/netdevice.h>
> +#include <linux/interrupt.h>
> +#include <net/addrconf.h>
> +#include <linux/inet.h>
> +#include <linux/tcp.h>
> +
> +#include "yt6801.h"
> +
> +#define PHY_WR_CONFIG(reg_offset)	(0x8000205 + ((reg_offset) * 0x10000))
> +static int fxgmac_phy_write_reg(struct fxgmac_pdata *priv, u32 reg_id, u32 data)
> +{
> +	u32 val;
> +	int ret;
> +
> +	FXGMAC_MAC_IO_WR(priv, MAC_MDIO_DATA, data);
> +	FXGMAC_MAC_IO_WR(priv, MAC_MDIO_ADDRESS, PHY_WR_CONFIG(reg_id));

The upper case suggest FXGMAC_MAC_IO_WR() is a macro. Why not use a
function? You then get type checking. There is nothing hot path here,
so it is better to have the compiler doing all the checks it can.

> +	ret = read_poll_timeout_atomic(FXGMAC_MAC_IO_RD, val,
> +				       !FXGMAC_GET_BITS(val, MAC_MDIO_ADDR, BUSY),
> +				       10, 250, false, priv, MAC_MDIO_ADDRESS);
> +	if (ret == -ETIMEDOUT) {
> +		yt_err(priv, "%s err, id:%x ctrl:0x%08x, data:0x%08x\n",
> +		       __func__, reg_id, PHY_WR_CONFIG(reg_id), data);

It would be much more usual to use netdev_err(priv->ndev, ....), or
dev_err(priv->dev, ....). Wrapping these functions is not really
liked.

The "err" should also be unnecessary since you call netdev_err().

> +		return ret;
> +	}
> +
> +	return ret;

You can consolidate the two return statements.

> +static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
> +{
> +	struct pci_dev *pdev = to_pci_dev(priv->dev);
> +	struct phy_device *phydev;
> +	struct mii_bus *new_bus;
> +	int ret;
> +
> +	new_bus = devm_mdiobus_alloc(&pdev->dev);
> +	if (!new_bus)
> +		return -ENOMEM;
> +
> +	new_bus->name = "yt6801";
> +	new_bus->priv = priv;
> +	new_bus->parent = &pdev->dev;
> +	new_bus->read = fxgmac_mdio_read_reg;
> +	new_bus->write = fxgmac_mdio_write_reg;
> +	snprintf(new_bus->id, MII_BUS_ID_SIZE, "yt6801-%x-%x",
> +		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
> +
> +	ret = devm_mdiobus_register(&pdev->dev, new_bus);
> +	if (ret < 0)
> +		return ret;
> +
> +	phydev = mdiobus_get_phy(new_bus, 0);
> +	if (!phydev)
> +		return -ENODEV;
> +
> +	priv->phydev = phydev;
> +	return 0;
> +}

> +/* Bit getting and setting macros
> + *  The get macro will extract the current bit field value from within
> + *  the variable
> + *
> + *  The set macro will clear the current bit field value within the
> + *  variable and then set the bit field of the variable to the
> + *  specified value
> + */
> +#define GET_BITS(_var, _index, _width) \
> +	(((_var) >> (_index)) & ((0x1U << (_width)) - 1))
> +
> +#define SET_BITS(_var, _index, _width, _val)                                  \
> +	do {                                                                  \
> +		(_var) &= ~(((0x1U << (_width)) - 1) << (_index));            \
> +		(_var) |= (((_val) & ((0x1U << (_width)) - 1)) << (_index));  \
> +	} while (0)
> +
> +#define GET_BITS_LE(_var, _index, _width) \
> +	((le32_to_cpu((_var)) >> (_index)) & ((0x1U << (_width)) - 1))
> +
> +#define SET_BITS_LE(_var, _index, _width, _val)                               \
> +	do {                                                                  \
> +		(_var) &=                                                     \
> +			cpu_to_le32(~(((0x1U << (_width)) - 1) << (_index))); \
> +		(_var) |= cpu_to_le32(                                        \
> +			(((_val) & ((0x1U << (_width)) - 1)) << (_index)));   \
> +	} while (0)

Please don't reinvent include/linux/bitfield.h.  We want all drivers
to look the same, use the same macros for bit manipulation, since it
makes maintenance easier. We know what the macros in bitfield.h do
because everybody uses them. When you do something different, you
loose out on that knowledge.

We also want endianness to be obvious, and use the correct markup, so
that tools like sparse can find missing conversions.

	Andrew

