Return-Path: <netdev+bounces-104796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 200AA90E691
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE41D1F21B1E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC03D7E56C;
	Wed, 19 Jun 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oX5LzuC2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8457EEFF;
	Wed, 19 Jun 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788212; cv=none; b=SbkOYmATvm48XoA5NYMpI2TLFTTcCLoaEqV70w65c4yxd+bPfSFJnqMxJw3P1MM5LKVZLDpuxXxnhenRQBYpPNwoSHiRGyyxv5TDXTgiGz17CSs7Bf3hUWEpeIxugL4NWzGF+uMniA216u/zteejEPEAxuG9HLLR/0VyqxuZfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788212; c=relaxed/simple;
	bh=j9QHuK1sZ1p2aIuDGVpmJ7JI6mmRW3HX761dvuCIG1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhnWwkaujn8eEvuwutjiF0t9ehIXl2RCugrudqhaj7tsUYNMGu/RlUgg0kDm5UxxPFvfrlVzjfCcpgtZ9xZZoVnLJn1liYUK2T88Dfuu7Qhlpd81rAp//wtz75qgPEkDKElwTIvMetjX29AiE3vvmz3T0eMo4KXCTnNAPFZqT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oX5LzuC2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XZPCE7bDbCBCJxvXyCnEG/PIPyH9SX836CQZUsB/9WE=; b=oX5LzuC2K6FLF5l89DJSwL40Iw
	qRtT/Ti0Co6QpZ/PmYuNy93+M0pKDqqNhn93L1vV/WFvbEHF0zRZ2Uop2JUkJmSHKJwU0zsV/9Wdn
	uZ+rIIwq4ob4+RhM0zLZqrGXu7ptaunWqZvePtiekwrIA8iS65EkpGc/xRB90Ezvjld+SA84W1r6v
	hOa3ekJlt9Qgaoqy8qaq/ztMyOeo/S7jiF/jdjRYLCZhI3gF35BdS2Oj9QCfiaZ3ceZZKUWBISHuS
	mPHk7G1G/oHlimw0qEkXW2MnCJW6GzTVDu/BGmCMwFCXt83iDNkiXSSp7AsPMgOyt8dyxEL/EThzt
	2Te6fj7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44894)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sJrKD-00083a-2i;
	Wed, 19 Jun 2024 10:09:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sJrKE-0006dv-7S; Wed, 19 Jun 2024 10:09:54 +0100
Date: Wed, 19 Jun 2024 10:09:53 +0100
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
Subject: Re: [PATCH net-next v7 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <ZnKgYSi81+JdAdhC@shell.armlinux.org.uk>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
 <20240613104023.13044-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613104023.13044-6-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 13, 2024 at 06:40:23PM +0800, Sky Huang wrote:
> +static const unsigned long supported_triggers =
> +	(BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> +	 BIT(TRIGGER_NETDEV_LINK)        |
> +	 BIT(TRIGGER_NETDEV_LINK_10)     |
> +	 BIT(TRIGGER_NETDEV_LINK_100)    |
> +	 BIT(TRIGGER_NETDEV_LINK_1000)   |
> +	 BIT(TRIGGER_NETDEV_LINK_2500)   |
> +	 BIT(TRIGGER_NETDEV_RX)          |
> +	 BIT(TRIGGER_NETDEV_TX));

Absolutely no need for the outer parens around this.

type foo assignment-operator expr;

There is no reason to ever put parens around expr in this kind of thing.
assignment-operator are things like =, |=, &=, <<=, >>=, and so forth.

Excessive parens detracts from readability, and leads to mistakes. If
operator precedence is a worry, then knowing the common C precedence
rules rather than littering code with extra parens would be good so
that code can remain readable.

> +static struct phy_driver mtk_gephy_driver[] = {
> +	{
> +		PHY_ID_MATCH_MODEL(MTK_2P5GPHY_ID_MT7988),
> +		.name		= "MediaTek MT7988 2.5GbE PHY",
> +		.probe		= mt798x_2p5ge_phy_probe,
> +		.config_init	= mt798x_2p5ge_phy_config_init,
> +		.config_aneg    = mt798x_2p5ge_phy_config_aneg,
> +		.get_features	= mt798x_2p5ge_phy_get_features,
> +		.read_status	= mt798x_2p5ge_phy_read_status,
> +		.get_rate_matching	= mt798x_2p5ge_phy_get_rate_matching,
> +		.suspend	= genphy_suspend,
> +		.resume		= genphy_resume,
> +		.read_page	= mtk_phy_read_page,
> +		.write_page	= mtk_phy_write_page,
> +		.led_blink_set	= mt798x_2p5ge_phy_led_blink_set,
> +		.led_brightness_set = mt798x_2p5ge_phy_led_brightness_set,
> +		.led_hw_is_supported = mt798x_2p5ge_phy_led_hw_is_supported,
> +		.led_hw_control_get = mt798x_2p5ge_phy_led_hw_control_get,
> +		.led_hw_control_set = mt798x_2p5ge_phy_led_hw_control_set,

I don't see the point of trying to align some of these method
declarators but not others. Consistency is important.

I know several PHY drivers do this, this will be because new methods
with longer names have been added over time, and to reformat the
tables of every driver would be noise. However, new implementations
should at least make an effort to have consistency.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

