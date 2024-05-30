Return-Path: <netdev+bounces-99460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C6A8D4FA4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73949286CF0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5120DD2;
	Thu, 30 May 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z5QDZsOS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3D208A9;
	Thu, 30 May 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085436; cv=none; b=CHOqu3OHhKhgQVI4OMnowTUHKXtH7jvJvbSquOiGhyvrM1YzqU/inXWhdMQM6KkBG4FyKIfvyu3kPa/NLrB2syrAMfZ0JbfkY8bk31A9O2KswG5G3e66rl2erCjXT5+vnZ/ESt+nt/Bugds9cQOJjznuxCJVR498Z1jojzsEj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085436; c=relaxed/simple;
	bh=pHKPGCPjt2uo37SjoY0KRiP4a1Nwp/AhknKMdpsA6w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pppIohFglAZAqm+vSuuvlw5yYYtpHkVwl/vs0HfhcqkljSUedlwr6j4RUeTIE462Kdx5gpTftou4FEUPcwctYwBkfVsXyXO4chSFiW3Wxuziuf2nbeO0apHsVKufe/i7qBQNKeQrn2/8mq5aUufQPaK33n28JXlWqMQi47dhc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z5QDZsOS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RCLB+9a+QfL2sb9yKKFj5QeAyOgyBI8+hlOoPiVSjrE=; b=Z5QDZsOS1ARFi6l5H5n04kuyHE
	4JdSXvF0ig2Ovj7RnQWzX5ZK2lzDG1+1tkWmA6GaMawx+vY1ca0J/RAPGgSmj3boER3hOwUcOVi0s
	ADcOfzQwM50O9x9NfTbkJKp6/AGIEnPoidataPzTNMP5TgNmmXTE2wQPHbz+7q0BsyXADX6l/1u/3
	dKpqtazhhMVcUss/iumrKrhjlE/Q8SVjlodLti4qjYGRcHgLVzrxeaQT/L6rJlY0zsaj2cis0/DUU
	ioPw9lGTA4JKiIW5SGuR6ewBygc+RHfAWx0+E9lr0UHvkPVYOmUKV5wafaIJIWGfExNcBxU1zzwoG
	zg9cONcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57056)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCiMB-0007Zb-1D;
	Thu, 30 May 2024 17:10:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCiM9-0005HH-L4; Thu, 30 May 2024 17:10:21 +0100
Date: Thu, 30 May 2024 17:10:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v5 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Message-ID: <Zlik7TfUsOanlBMV@shell.armlinux.org.uk>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
 <20240530034844.11176-5-SkyLake.Huang@mediatek.com>
 <ZlhTtSHRVrjWO0KD@shell.armlinux.org.uk>
 <a6280b885cf1cffa845310e7e565e1dd7421dc66.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6280b885cf1cffa845310e7e565e1dd7421dc66.camel@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 30, 2024 at 04:01:08PM +0000, SkyLake Huang (黃啟澤) wrote:
> I'm not going to handle timeout case here. If we can't detect
> MTK_PHY_FINAL_SPEED_1000 in 1 second, let it go and we'll detect it
> next round.

With this waiting up to one second for MTK_PHY_FINAL_SPEED_1000 to be
set...

> > > +int mtk_gphy_cl22_read_status(struct phy_device *phydev)
> > > +{
> > > +int ret;
> > > +
> > > +ret = genphy_read_status(phydev);
> > > +if (ret)
> > > +return ret;
> > > +
> > > +if (phydev->autoneg == AUTONEG_ENABLE && !phydev-
> > >autoneg_complete) {

Are you sure you want this condition like this? When the link is down,
and 1G speeds are being advertised, it means that you'll call
extend_an_new_lp_cnt_limit(). If MTK_PHY_FINAL_SPEED_1000 doesn't get
set, that'll take one second each and every time we poll the PHY for
its status - which will be done while holding phydev->lock.

This doesn't sound very good.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

