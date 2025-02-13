Return-Path: <netdev+bounces-166206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958CA34F1D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D003AC0A9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB024A07E;
	Thu, 13 Feb 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hobx4y4p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664928A2CB;
	Thu, 13 Feb 2025 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477594; cv=none; b=sOkLMPUMcZlOKOslvVQo2eQADmb7vFkC0cUcZAm59cW1sfqr7U4i2Qwg6aFcLWQ0odXSyPhPnmfz3dXzIfM2RzHz90ffy2v/w9Iib0t75WMLyE8RdVoLwQkoMCiQuc01E+mBX4+2P6YNCSLGQXEYG9qY0l8yhOpiWCgi6YREQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477594; c=relaxed/simple;
	bh=5ZipYuMPgrN9n9uPJIkYegGgMsGv/UZehGDUEqj4LLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU+rBmJjLdSHIYuuaym05ipYsgcGxAEA4j7ZTK88PfsbN02wo8yoLPHLPtEew/nk1ougjmyntU0jQv2VCyY+vZoyZFDX0sJQOZ0/He/CE+3P4FpcUJhYBS9HQRwotX1KC2vDBO/6dbOAEoiimGFFcizu1Sr/D1DB1APEKT1XCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hobx4y4p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0AvuaGU/cH1A/7IDZRhEkvHqA4F9A2Qjq+21qlNvMrk=; b=hobx4y4pjW4CvLaZgqgTHG/Ni2
	HlN2dGSn7BwnXb4spg0TCKfBpblIJSchznx0NAKY9PmedV+BAyaSmB983ppEOB0AO9P79wDqdjNzF
	JaiRJnUidqglZC/C6Ddi0LFGJNoxfld6pMusrW5UFSuL/i9hmYQPU35u6+1x8F672Fpg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tifa5-00DqgB-GW; Thu, 13 Feb 2025 21:13:05 +0100
Date: Thu, 13 Feb 2025 21:13:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 7/7] net: hibmcge: Add ioctl supported in this
 module
Message-ID: <c1d557b6-7f11-449e-aff7-dad974e1c7c9@lunn.ch>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213035529.2402283-8-shaojijie@huawei.com>

On Thu, Feb 13, 2025 at 11:55:29AM +0800, Jijie Shao wrote:
> This patch implements the ioctl interface to
> read and write the PHY register.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../net/ethernet/hisilicon/hibmcge/hbg_main.c  | 18 ++++++++++++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c  | 10 ++++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h  |  2 ++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> index 78999d41f41d..afd04ed65eee 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> @@ -273,6 +273,23 @@ static netdev_features_t hbg_net_fix_features(struct net_device *netdev,
>  	return features & HBG_SUPPORT_FEATURES;
>  }
>  
> +static int hbg_net_eth_ioctl(struct net_device *dev, struct ifreq *ifr, s32 cmd)
> +{
> +	struct hbg_priv *priv = netdev_priv(dev);
> +
> +	if (test_bit(HBG_NIC_STATE_RESETTING, &priv->state))
> +		return -EBUSY;
> +
> +	switch (cmd) {
> +	case SIOCGMIIPHY:
> +	case SIOCGMIIREG:
> +	case SIOCSMIIREG:
> +		return hbg_mdio_ioctl(priv, ifr, cmd);
> +	default:
> +		return -EOPNOTSUPP;
> +	}

No need for this switch statement. phy_mii_ioctl() will return
EOPNOTSUPP for any it does not support.

The general structure of an IOCTL handler is to have a switch
statements for any IOCTL which are handled at this level and the
default: case then calls into the next layer down.

> +int hbg_mdio_ioctl(struct hbg_priv *priv, struct ifreq *ifr, int cmd)
> +{
> +	struct hbg_mac *mac = &priv->mac;
> +
> +	if (!mac->phydev)
> +		return -ENODEV;
> +
> +	return phy_mii_ioctl(mac->phydev, ifr, cmd);

phy_do_ioctl(). This is assuming you follow the normal pattern of
keeping the phydev pointer in the net_device structure.

	Andrew

