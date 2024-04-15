Return-Path: <netdev+bounces-88020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9828A5578
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF511C224A3
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E722071B32;
	Mon, 15 Apr 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mfi3Icp7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432F433C9
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192275; cv=none; b=RVRn47Q38uu6n9XJ0FG/6jfLAxj2XWzeGqB9vc+K+fhBI3ylfeZmQPINWSLeu6D3e7zyPw3/YMz74rWs8lv08M3qIURoMZ14cPepjjBPXK91B3KxBH/Txi8X8/ggoy8ePlVrhnXqG5ydwCOLd0khhvy3nqo1AnaPRFjJfKUDWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192275; c=relaxed/simple;
	bh=px+oR5opa0NE96Az9oykOVE/JDuE/xpVMeE4NRV3dM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC8PxW3xanKaL29oaZkgPS+HrDb72GRU+UYSOMk7mDD0S1d/S5/wYS1EYhNPtG3qlWDm15GT7kFbaoxiL65Pw4R8G8++0+KBWczPkk2/PcerdJdms5h6h9PSkXX5MR8kfw6geh/3YL1O3rpteP0Nl6gDaJ8/llQvl4iJDq/aAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mfi3Icp7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lox1M7KzM3D32ETAZKYxfhDA40PwMm/0xKMv1uwd2dg=; b=Mfi3Icp7VyqPqvpRI3sw1TWWtU
	iJP7gZPyb7XaSVPKN3/g6wZn8FCTG2iSk//9KfZoO+v6R896R0Y8VtoMTNBiqEmbCo3cHKOrHLn+g
	HrBMoYnm2X9dqp09Dn800KAnCO1VgiFcSfPr854B7n6PFovjakiju/tYk/s35YYBzjeM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwNZP-00D39m-UX; Mon, 15 Apr 2024 16:44:31 +0200
Date: Mon, 15 Apr 2024 16:44:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 5/5] net: tn40xx: add PHYLIB support
Message-ID: <7c20aefa-d93b-41e2-9a23-97782926369d@lunn.ch>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
 <20240415104352.4685-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104352.4685-6-fujita.tomonori@gmail.com>

On Mon, Apr 15, 2024 at 07:43:52PM +0900, FUJITA Tomonori wrote:
> This patch adds supports for multiple PHY hardware with PHYLIB. The
> adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
> TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.
> 
> For now, the PCI ID table of this driver enables adapters using only
> QT2025 PHY. I've tested this driver and the QT2025 PHY driver with
> Edimax EN-9320 10G adapter.

Please split this up. Add the MDIO bus master in one patch. Then add
support for phylib in a second patch. They are logically different
things.

Are there variants of this device using SFP? It might be you actually
want to use phylink, not phylib. That is a bit messy for a PCI device,
look at drivers/net/ethernet/wangxun.

> diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
> index 4198fd59e42e..71f22471f9a0 100644
> --- a/drivers/net/ethernet/tehuti/Kconfig
> +++ b/drivers/net/ethernet/tehuti/Kconfig
> @@ -27,6 +27,7 @@ config TEHUTI_TN40
>  	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
>  	depends on PCI
>  	select FW_LOADER
> +	select AMCC_QT2025_PHY

That is pretty unusual, especially when you say there are a few
different choices.

> +static u32 bdx_mdio_get(struct bdx_priv *priv)
> +{
> +	void __iomem *regs = priv->regs;
> +
> +#define BDX_MAX_MDIO_BUSY_LOOPS 1024
> +	int tries = 0;
> +
> +	while (++tries < BDX_MAX_MDIO_BUSY_LOOPS) {
> +		u32 mdio_cmd_stat = readl(regs + REG_MDIO_CMD_STAT);
> +
> +		if (GET_MDIO_BUSY(mdio_cmd_stat) == 0)
> +			return mdio_cmd_stat;
> +	}
> +	dev_err(&priv->pdev->dev, "MDIO busy!\n");

include/linux/iopoll.h

> +	return 0xFFFFFFFF;

It is always better to use standard error codes. In this case,
-ETIMEDOUT.

> +static u16 bdx_mdio_read(struct bdx_priv *priv, int device, int port, u16 addr)
> +{
> +	void __iomem *regs = priv->regs;
> +	u32 tmp_reg, i;
> +	/* wait until MDIO is not busy */
> +	if (bdx_mdio_get(priv) == 0xFFFFFFFF)
> +		return -1;
> +
> +	i = ((device & 0x1F) | ((port & 0x1F) << 5));
> +	writel(i, regs + REG_MDIO_CMD);
> +	writel((u32)addr, regs + REG_MDIO_ADDR);
> +	tmp_reg = bdx_mdio_get(priv);
> +	if (tmp_reg == 0xFFFFFFFF)
> +		return -1;

This function has a return type of u16. So returning -1 makes no sense.

> +static int mdio_read_reg(struct mii_bus *mii_bus, int addr, int devnum, int regnum)
> +{
> +	return bdx_mdio_read(mii_bus->priv, devnum, addr, regnum);

I would probably change bdx_mdio_read() so that it takes the
parameters in the same order as mdio_read_reg().

There is also a reasonably common convention that the functions
performing C45 bus protocol operations have c45 in their name. It
appears this hardware does not support C22 at all. That makes it
unusual, and little hits like this are useful.

	 Andrew

