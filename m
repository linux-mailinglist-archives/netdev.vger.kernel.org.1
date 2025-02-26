Return-Path: <netdev+bounces-169777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F7FA45AD4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F941891540
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156726E165;
	Wed, 26 Feb 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OPGZ5Uw8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9552459E0;
	Wed, 26 Feb 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563588; cv=none; b=cwyTO1GJHGGy/vQnxLOWNgZU4LeNMeuBSF8cI/8beED/cHAV4GQRzqpRA4qjyG+E2Nddpk/pzws2id7/2jirBmjU1f1fWW1q9XqnfEAIpiEp+R0PEzDVTEeleaGy6Nfw599C/2YqXCRRUGZofozTHEXVVIw85KISTqGWbIV9erg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563588; c=relaxed/simple;
	bh=23AzTlA3i3e+EmS9Av59UpbDgrdMi/L7vS6N1uObpJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX5KoUhk6dMvuUiBQ1bGNSasjtB3lgIRkPpymQ6jkKvTwLz2K2lHYmGE1mzzmvNTCvgOlyGdkk+SrBZ390kirKRviFKNv5Nqj3IC3hU02bQCxh9TE0VtgOB6K9VrsGX+bmelteH48XA5n0BriAi4OV6aCcTtzcfRuXlg4U6szyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OPGZ5Uw8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AWAnLAcd4Ax9L2XjpW/XTk1Vc6xaPxRyyPPHRuN7d+0=; b=OPGZ5Uw8vm2+odS8tBnxh6bn5y
	bMKasJwtYxa0VWmFmqzAohjow9oPWH5b8OMTZQvCa9wo09JRu6bE/sDd73lDgAh47se8VFabVThHr
	ZEiE8aZTIDBA0m1Wve/02buldgj1FI8v2SRhJYXiIzAoIf97cT4DyazORIRNjwBOF5DDRK9WBnV6K
	Y4qMJE77GtOgbxK8usYH4b2LD27i8CGjtu97MKuJ0UoVx1PTybavKFR98wAiyQwrFulF1ibmMLeIc
	iMKwl7NTa38QBqSY5ibw8JS1Knpd3qKga8UVNrgiF8xTXt8mdyUx154pmR0LA3lBt6bYao0tocNRe
	ymF8xUhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51782)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnE63-0003om-0c;
	Wed, 26 Feb 2025 09:52:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnE5y-0006xe-26;
	Wed, 26 Feb 2025 09:52:50 +0000
Date: Wed, 26 Feb 2025 09:52:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Message-ID: <Z77kcqzmCqdT6lE0@shell.armlinux.org.uk>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
 <Z7WleP9v6Igx2MjC@shell.armlinux.org.uk>
 <5fae9c69a09320b0b24f25a178137bd0256a72d8.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fae9c69a09320b0b24f25a178137bd0256a72d8.camel@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 06:48:34AM +0000, SkyLake Huang (黃啟澤) wrote:
> On Wed, 2025-02-19 at 09:33 +0000, Russell King (Oracle) wrote:
> > 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > On Wed, Feb 19, 2025 at 04:39:10PM +0800, Sky Huang wrote:
> > > +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> > > +{
> > > +     struct pinctrl *pinctrl;
> > > +     int ret;
> > > +
> > > +     /* Check if PHY interface type is compatible */
> > > +     if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
> > > +             return -ENODEV;
> > > +
> > > +     ret = mt798x_2p5ge_phy_load_fw(phydev);
> > > +     if (ret < 0)
> > > +             return ret;
> > 
> > Firmware should not be loaded in the .config_init method. The above
> > call will block while holding the RTNL which will prevent all other
> > network configuration until the firmware has been loaded or the load
> > fails.
> > 
> > Thanks.
> > 
> > --
> > RMK's Patch system:
> > https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches/__;!!CTRNKA9wMg0ARbw!iV-1ViPFsUV-lLj7aIycan8nery6sQO3t6mkpdlb_GW8hswhxc4ejJozxqkU3s2WzxSizs4kfdC77yr7HGGRIuU$
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> Hi Russell,
> mt798x_p5ge_phy_load_fw() will only load firmware once after driver is
> probed through priv->fw_loaded. And actually, firmware loading
> procedure only takes about 11ms. This was discussed earlier in:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240520113456.21675-6-SkyLake.Huang@mediatek.com/#25856462
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240520113456.21675-6-SkyLake.Huang@mediatek.com/#25857174

1. Wouldn't it be a good idea to include the loading time in the patch
   description or a comment in the patch?

2. What about the time it takes for request_firmware() uses the sysfs
   fallback, which essentially passes the firmware request to userspace
   to deal with? That can block for an indeterminate amount of time.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

