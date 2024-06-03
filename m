Return-Path: <netdev+bounces-100091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0878D7D12
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6DF280D65
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEF65477A;
	Mon,  3 Jun 2024 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k8EuRzzC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF7487BF;
	Mon,  3 Jun 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402431; cv=none; b=Es2dZBjQLmkabrEnIPRuuaZYKoDaykULPLgNqHN4LcfPFRMRsUHF+NXGJmqWT5UCgaqn0BZW5lqwyGFKWp6D5SmOgQ7wm9Eu4OSgPYhSudf8SNzwOS9OUqaW8VKnM4gvJBLodQq9MLtJ2GDhKwRoK5nOtrTlhhsI6+SbIB1XmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402431; c=relaxed/simple;
	bh=dw35w2HlX6uEnLlGNP7oEeKFfwVxxiVEbHS8HsSh6Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLmtzltzhsC9yqBv6wiGonsf4liBWvELcdn/v2eh9IKa7GR3RdKSoWDSrtMIy8E0kSjDxNKZTgrKfw6v4v052i6Oz0SW9Wci/he1KRN0c1tqAiOdqh6Rba768TqQOMQl3FJBOsu38mZLOyqqYnLHTuRre6WKa/TBxJas6Qon1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k8EuRzzC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=59CM1T4kNHLXN8iP2xZIPMYXtUjSOpZ37vbcWdKyQJY=; b=k8EuRzzCfKfASeTkUM2IU1ILOO
	wJkGORLCBY5HaUOijcxWfp3qDWtOYt2ghO1T3T8m6SHBTf4uYr5NlTmkwQG1F/QCnZH4l8aiw4jPP
	9Av/CfwaGZWtgawb95ZQt/1ExzH8/nCNWS4Z9AGRzpMQe4gvf7z/i6hqgp/PfZbtGcXStlSnU9EIE
	VfikzYJdeyrQzEuuVz6X0HL/rfP1aFGjcyvpHOow3m/Xdk+MqpeL03AAUYWNKiIsUPexZ6RY5deUb
	ybosb0beHgkpRMEIIGgU4EsSIt/Cmxp5Qk1tiImUk5AUp0ZnwzhaYKWAy96LRL/bVAkX8hTH0aqyT
	ye9H7dLA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50452)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sE2hz-0002PF-31;
	Mon, 03 Jun 2024 09:06:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sE2hy-0000Fn-FF; Mon, 03 Jun 2024 09:06:22 +0100
Date: Mon, 3 Jun 2024 09:06:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v5 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Message-ID: <Zl15fh7y2oZmFfd7@shell.armlinux.org.uk>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
 <20240530034844.11176-5-SkyLake.Huang@mediatek.com>
 <ZlhTtSHRVrjWO0KD@shell.armlinux.org.uk>
 <a6280b885cf1cffa845310e7e565e1dd7421dc66.camel@mediatek.com>
 <Zlik7TfUsOanlBMV@shell.armlinux.org.uk>
 <e25de8898d594d14ade148004fdddb1f2c5b47f7.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e25de8898d594d14ade148004fdddb1f2c5b47f7.camel@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 03, 2024 at 03:15:36AM +0000, SkyLake Huang (黃啟澤) wrote:
> On Thu, 2024-05-30 at 17:10 +0100, Russell King (Oracle) wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Thu, May 30, 2024 at 04:01:08PM +0000, SkyLake Huang (黃啟澤) wrote:
> > > I'm not going to handle timeout case here. If we can't detect
> > > MTK_PHY_FINAL_SPEED_1000 in 1 second, let it go and we'll detect it
> > > next round.
> > 
> > With this waiting up to one second for MTK_PHY_FINAL_SPEED_1000 to be
> > set...
> > 
> > > > > +int mtk_gphy_cl22_read_status(struct phy_device *phydev)
> > > > > +{
> > > > > +int ret;
> > > > > +
> > > > > +ret = genphy_read_status(phydev);
> > > > > +if (ret)
> > > > > +return ret;
> > > > > +
> > > > > +if (phydev->autoneg == AUTONEG_ENABLE && !phydev-
> > > > >autoneg_complete) {
> > 
> > Are you sure you want this condition like this? When the link is
> > down,
> > and 1G speeds are being advertised, it means that you'll call
> > extend_an_new_lp_cnt_limit(). If MTK_PHY_FINAL_SPEED_1000 doesn't get
> > set, that'll take one second each and every time we poll the PHY for
> > its status - which will be done while holding phydev->lock.
> > 
> > This doesn't sound very good.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> I add another condition to make sure we enter
> extend_an_new_lp_cnt_limit() only in first few seconds when we plug in
> cable.
> 
> It will look like this:
> ===============================================================
> #define MTK_PHY_AUX_CTRL_AND_STATUS		0x14
> #define   MTK_PHY_LP_DETECTED_MASK		GENMASK(7, 6)
> 
> if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete) {
> 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_1);
> 	ret = __phy_read(phydev, MTK_PHY_AUX_CTRL_AND_STATUS);
> 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);

We provide a helper for this:

	ret = phy_read_paged(phydev, MTK_PHY_PAGE_EXTENDED_1,
			     MTK_PHY_AUX_CTRL_AND_STATUS);

but please check "ret" for errors.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

