Return-Path: <netdev+bounces-121750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829D595E633
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4097B208FB
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084A7F9;
	Mon, 26 Aug 2024 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oMOxCCUU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315A7E6
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635053; cv=none; b=f0gPA9c2x2iwqoGkPTB2429VwZElQi9h6Z6IwrsTyIWcMI9BPvFI+Sz2AOs7W3HG2dS+Rg8YVHgCWnDwkbPVglele4ccR2wyOLzWWqIyYzgJ4fKl1OceUfCYVEvbsYGMa3hvik4lm3HcDw3PB54n+UbCJWPMGZLlf/aZr9Z6Nyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635053; c=relaxed/simple;
	bh=p7Tee/Ji5ijAKdKtrzAw1OUDlgCq2Ci4Ig5q/wbpdtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTLmLD+b7pHAl1qfHY0VeO5B+1llDWScHjws22m3AQHqxjyFgvEfjqpS6gnef0fVkcKwxIM/9h+V47A03CtnxZGrOjmHZ9A1u+2Y6sCoVy6hgmg4RLnIxClq1STtYzoMT2nRHh0oxDf8fvD+1Vbh/wXgwFkVkgyx2NZaYre1a1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oMOxCCUU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UVFoj9iWs2Nz14Ij9zLSbgrtVKStFKulZZW9jVhdQiE=; b=oMOxCCUU2Zk/wzQBLhUCgOzgau
	EoP+kvyP/DAy5W7F5gqhNmtXhYQW3yZLw3g5HhdaIoytMoiL+OyZh7KyA+/i8vfG+MhU8Yc9h6wGo
	P6LAreOIa7ezavJOlXrzQR5Nm/i7X3g+FQgdBR8fqrrYg/MBr0/0QNpvVvRFV15hqzNA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siOMF-005f6H-2c; Mon, 26 Aug 2024 03:17:23 +0200
Date: Mon, 26 Aug 2024 03:17:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH net-next 1/2] net: phy: aquantia: create firmware name
 for aqr PHYs at runtime
Message-ID: <d0a46a2a-af5c-4616-a092-a9b65a1e15e2@lunn.ch>
References: <trinity-916ed524-e8a5-4534-b059-3ed707ec3881-1724520847823@3c-app-gmx-bs42>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-916ed524-e8a5-4534-b059-3ed707ec3881-1724520847823@3c-app-gmx-bs42>

> +/* derive the filename of the firmware file from the PHY and the MDIO names
> + * Parts of filename:
> + *   mdio/phy-mdio_suffix
> + *    1    2   3    4
> + * allow name components 1 (= 3) and 2 to have same maximum length
> + */
> +static int aqr_firmware_name(struct phy_device *phydev, const char **name)
> +{
> +#define AQUANTIA_FW_SUFFIX "_fw.cld"
> +#define AQUANTIA_NAME "Aquantia "
> +/* including the trailing zero */
> +#define FIRMWARE_NAME_SIZE 64
> +/* length of the name components 1, 2, 3 without the trailing zero */
> +#define NAME_PART_SIZE ((FIRMWARE_NAME_SIZE - sizeof(AQUANTIA_FW_SUFFIX) - 2) / 3)
> +	ssize_t len, mac_len;
> +	char *fw_name;
> +	int i, j;
> +
> +	/* sanity check: the phydev drv name needs to start with AQUANTIA_NAME */
> +	if (strncmp(AQUANTIA_NAME, phydev->drv->name, strlen(AQUANTIA_NAME)))
> +		return -EINVAL;
> +
> +	/* sanity check: the phydev drv name may not be longer than NAME_PART_SIZE */
> +	if (strlen(phydev->drv->name) - strlen(AQUANTIA_NAME) > NAME_PART_SIZE)
> +		return -E2BIG;
> +
> +	/* sanity check: the MDIO name must not be empty */
> +	if (!phydev->mdio.bus->id[0])
> +		return -EINVAL;

I'm not sure how well that is going to work. It was never intended to
be used like this, so the names are not going to be as nice as your
example.

apm/xgene-v2/mdio.c:	snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(dev));
apm/xgene/xgene_enet_hw.c:	snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s-%s", "xgene-mii",
hisilicon/hix5hd2_gmac.c:	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(&pdev->dev));
intel/ixgbe/ixgbe_phy.c:	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mdio-%s", ixgbe_driver_name,

I expect some of these IDs contain more than the MAC, eg. include the
PCI slot information, or physical address of the device. Some might
indicate the name of the MDIO controller, not the MAC.

Aquantia PHYs firmware is not nice. It contains more than firmware. I
think it has SERDES eye information. It also contain a section which
sets the reset values of various registers. It could well be, if you
have a board with two MACs and two PHYs, each needs it own firmware,
because it needs different eye information. So what you propose works
for your limited use case, but i don't think it is a general solution.

Device tree works, because you can specific a specific filename per
PHY. I think you need a similar solution. Please look at how txgbe
uses swnodes. See if you can populate the firmware-name node from the
MAC driver. That should be a generic solution.

	Andrew

