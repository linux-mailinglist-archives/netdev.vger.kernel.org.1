Return-Path: <netdev+bounces-99349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEDC8D499D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F781F2456E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093FD17C7A4;
	Thu, 30 May 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aWhB0q8F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD97176AAE;
	Thu, 30 May 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064655; cv=none; b=Btm+RTJwfkQrmanek3mQ5Ym+SLb9+Eeb4PSV9Zo6XAT3AI95EyVRRE8wJWTxnT0gxXSg3YXprspGXYR6mOabiEGStoFXxgxTEglZS/rcDEJjRMCe2ZAQb38EQLVctj3VL5txIySkId5z+hSBCB7UeqFZFWB0bjzz3VVIX5cSIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064655; c=relaxed/simple;
	bh=HeUGkiaEEtwv7kBlE3o/lEprM8J67nEM4mfW/LV/zzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM0cNrFK6NkodCW5C3PEOT3rgcJiBCnXGxpombFFkVJzad9DVj4d83S3/+62csUzQ7+x3KESMiTGWkLA6nI+CzZAUnn65K4j1q+3ppSM8nddzVb1hfo5lTpcONRkOgaHfnGh0lZ94xvS2TjSz1o23qsYP68fHQhzh20oa3YIQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aWhB0q8F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J8pf6YD6PYPOxhuxnDNwdGpGAeMHzezf+cUCwL+fh0o=; b=aWhB0q8FGQSlqKpGjJIcrnT3F7
	Zx/XgjYvWTYLMXoHUeY8mv0PKp85aDgd8vJDRO0Fk1T9t9mc409SY5JpH350Izgo+CFy8ePIF4yDU
	Vl0Dpi4nCJNm3K1qIk78HHqkPICKrFp9IHwh65eynTxZk1R6AoSxnaqUXmvEVehq4klMP7DZU6MWx
	N9iwij8balZT7Ly1MLxQq+TnRIYoXkQaQ9GjC9FyXA9pq9wVsXMotY8zUmMAfvR/1dj/zQ3udRX3q
	C5b2WwFnaS2DyuTgXgamN/N8sjbUnING7J9ih0sVJkqNhV5wsGy5UHGMG7gHU5852NdzAu7IQZXu2
	UmqcMNbg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40714)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCcwo-0007FG-2a;
	Thu, 30 May 2024 11:23:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCcwn-00054M-LC; Thu, 30 May 2024 11:23:49 +0100
Date: Thu, 30 May 2024 11:23:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v5 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Message-ID: <ZlhTtSHRVrjWO0KD@shell.armlinux.org.uk>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
 <20240530034844.11176-5-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530034844.11176-5-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

A few suggestions:

On Thu, May 30, 2024 at 11:48:43AM +0800, Sky Huang wrote:
> +static int extend_an_new_lp_cnt_limit(struct phy_device *phydev)
> +{
> +	int mmd_read_ret;
> +	u32 reg_val;
> +	int timeout;
> +
> +	timeout = read_poll_timeout(mmd_read_ret = phy_read_mmd, reg_val,
> +				    (mmd_read_ret < 0) || reg_val & MTK_PHY_FINAL_SPEED_1000,
> +				    10000, 1000000, false, phydev,
> +				    MDIO_MMD_VEND1, MTK_PHY_LINK_STATUS_MISC);

	timeout = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
					    MTK_PHY_LINK_STATUS_MISC,
					    reg_val,
					    reg_val & MTK_PHY_FINAL_SPEED_1000,
					    10000, 1000000, false);

> +	if (mmd_read_ret < 0)
> +		return mmd_read_ret;

So, what if the poll times out (timeout == -ETIMEDOUT) ? If you want to
ignore that, then:

	if (timeout < 0 && timeout != -ETIMEDOUT)
		return timeout;

> +int mtk_gphy_cl22_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret)
> +		return ret;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete) {
> +		ret = phy_read(phydev, MII_CTRL1000);
> +		if ((ret & ADVERTISE_1000FULL) || (ret & ADVERTISE_1000HALF)) {

This is equivalent to:

		if (ret & (ADVERTISE_1000FULL | ADVERTISE_1000HALF)) {

which is easier to read.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

