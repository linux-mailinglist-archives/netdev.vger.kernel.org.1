Return-Path: <netdev+bounces-146881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C49D66ED
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 02:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77633B21364
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 01:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7764C97;
	Sat, 23 Nov 2024 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tyIYsuMK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223A23BE;
	Sat, 23 Nov 2024 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732323800; cv=none; b=W3tCM1tObxmWbiSf3hNpjs56l7xVGqIGzigDqOcY33SwA/tVwgzLC1RvCkYLKPZjVs3WokWkW0thzNEyzBVuRMSRAf/i4JiJLiRknkurYLdiLP4IL5aczpg/QWwc31msGlGEYocEC9iNRYcPlNVoPu2ac81krzIqCyC0hF/bjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732323800; c=relaxed/simple;
	bh=8Qd/2RIKKlsOCErrjdY4EU2AkhvuqRMK8OWdf1rWTX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhOiaKqw7seSd+TmhxdfBlRtP6oblZmxgOPVy+4rPczecjxW+bdnXXGor/YkbDVPZK+7uQ4lpqOGJL6y2RLqcp0n9MAh+3u/OG7iW6NxJuACTI9PHHeHgeaNGM/gh0pfk+UCfPtaPjBH6J0OU1wHwgQwkwXFAWUB91/K0yeeqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tyIYsuMK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DKWouLdo+R/jNUeXYvuMi6LNx1L+DRk29BvI3BCGaDk=; b=tyIYsuMKCR3VAtniecPkhu+/Ys
	b5aRXe9RtiecBXCg20dyIvWSdOUD19oHv8auXBu/fSISxRu6Oo1R50WgUB1VuxLmCGmm1odVJ6HsE
	TIZuGnQisXYIWBXV7cqK+SZt91FY86jizpUi6ESc19Uy6S9aoHgOvjssbU6BO3t5BPjA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEeYG-00EBCF-JS; Sat, 23 Nov 2024 02:03:08 +0100
Date: Sat, 23 Nov 2024 02:03:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 09/21] motorcomm:yt6801: Implement some
 hw_ops function
Message-ID: <46206a81-e230-411c-8a78-d461d238b171@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-10-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105625.22508-10-Frank.Sae@motor-comm.com>

It took a lot of effort to find your MDIO code. And MDIO bus driver
makes a good patch on its own.

> +static int mdio_loop_wait(struct fxgmac_pdata *pdata, u32 max_cnt)
> +{
> +	u32 val, i;
> +
> +	for (i = 0; i < max_cnt; i++) {
> +		val = rd32_mac(pdata, MAC_MDIO_ADDRESS);
> +		if ((val & MAC_MDIO_ADDR_BUSY) == 0)
> +			break;
> +
> +		fsleep(10);
> +	}
> +
> +	if (i >= max_cnt) {
> +		WARN_ON(1);
> +		yt_err(pdata, "%s timeout. used cnt:%d, reg_val=%x.\n",
> +		       __func__, i + 1, val);
> +
> +		return -ETIMEDOUT;
> +	}

Please replace this using one of the helpers in
include/linux/iopoll.h.

> +#define PHY_WR_CONFIG(reg_offset)		(0x8000205 + ((reg_offset) * 0x10000))
> +static int fxgmac_phy_write_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 data)
> +{
> +	int ret;
> +
> +	wr32_mac(pdata, data, MAC_MDIO_DATA);
> +	wr32_mac(pdata, PHY_WR_CONFIG(reg_id), MAC_MDIO_ADDRESS);
> +	ret = mdio_loop_wait(pdata, PHY_MDIO_MAX_TRY);
> +	if (ret < 0)
> +		return ret;
> +
> +	yt_dbg(pdata, "%s, id:%x %s, ctrl:0x%08x, data:0x%08x\n", __func__,
> +	       reg_id, (ret == 0) ? "ok" : "err", PHY_WR_CONFIG(reg_id), data);
> +
> +	return ret;
> +}
> +
> +#define PHY_RD_CONFIG(reg_offset)		(0x800020d + ((reg_offset) * 0x10000))
> +static int fxgmac_phy_read_reg(struct fxgmac_pdata *pdata, u32 reg_id)
> +{
> +	u32 val;
> +	int ret;
> +
> +	wr32_mac(pdata, PHY_RD_CONFIG(reg_id), MAC_MDIO_ADDRESS);
> +	ret =  mdio_loop_wait(pdata, PHY_MDIO_MAX_TRY);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = rd32_mac(pdata, MAC_MDIO_DATA);  /* Read data */
> +	yt_dbg(pdata, "%s, id:%x ok, ctrl:0x%08x, val:0x%08x.\n", __func__,
> +	       reg_id, PHY_RD_CONFIG(reg_id), val);
> +
> +	return val;
> +}

And where is the rest of the MDIO bus driver?

> +static int fxgmac_config_flow_control(struct fxgmac_pdata *pdata)
> +{
> +	u32 val = 0;
> +	int ret;
> +
> +	fxgmac_config_tx_flow_control(pdata);
> +	fxgmac_config_rx_flow_control(pdata);
> +
> +	/* Set auto negotiation advertisement pause ability */
> +	if (pdata->tx_pause || pdata->rx_pause)
> +		val |= ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
> +
> +	ret = phy_modify(pdata->phydev, MII_ADVERTISE,
> +			 ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_modify(pdata->phydev, MII_BMCR, BMCR_RESET, BMCR_RESET);
> +}


Yet more code messing with the PHY. This all needs to go.

> +static int fxgmac_phy_clear_interrupt(struct fxgmac_pdata *pdata)
> +{
> +	u32 stats_pre, stats;
> +
> +	if (mutex_trylock(&pdata->phydev->mdio.bus->mdio_lock) == 0) {
> +		yt_dbg(pdata, "lock not ready!\n");
> +		return 0;
> +	}
> +
> +	stats_pre = fxgmac_phy_read_reg(pdata, PHY_INT_STATUS);
> +	if (stats_pre < 0)
> +		goto unlock;
> +
> +	stats = fxgmac_phy_read_reg(pdata, PHY_INT_STATUS);
> +	if (stats < 0)
> +		goto unlock;
> +
> +	phy_unlock_mdio_bus(pdata->phydev);
> +
> +#define LINK_DOWN	0x800
> +#define LINK_UP		0x400
> +#define LINK_CHANGE	(LINK_DOWN | LINK_UP)
> +	if ((stats_pre & LINK_CHANGE) != (stats & LINK_CHANGE)) {
> +		yt_dbg(pdata, "phy link change\n");
> +		return 1;
> +	}
> +
> +	return 0;
> +unlock:
> +	phy_unlock_mdio_bus(pdata->phydev);
> +	yt_err(pdata, "fxgmac_phy_read_reg err!\n");
> +	return  -ETIMEDOUT;
> +}

You need to rework your PHY interrupt handling. The PHY driver is
responsible for handing the interrupt registers in the PHY. Ideally
you just want to export an interrupt to phylib, so it can do all the
work.

	Andrew

