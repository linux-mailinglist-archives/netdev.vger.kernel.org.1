Return-Path: <netdev+bounces-19767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E66075C264
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4831C21651
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC1D14F7A;
	Fri, 21 Jul 2023 09:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60814F65
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:04:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F630DA
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n2ya+3wv8jlczPXmlimqLrLH9/Ez775zVSF3ryo6ya8=; b=gZUK/sCwsgKLq6AaJihMcqTpV9
	jEkXpv8SPa8WmSKqPULOsh+M2WKsOBZn330nebkaapwqw9NMD6t0OJsYsAlOkeAUd/GBQzFxPq4hl
	0383KD06xfEOBDYQPUKFndWAVr56nTWSD6QG62q5WRnIvTXL/nJ55ZRzeniCPLyAHhMI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qMm3n-001rYH-Ru; Fri, 21 Jul 2023 11:04:27 +0200
Date: Fri, 21 Jul 2023 11:04:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
	dongbiao@loongson.cn, loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [RFC PATCH 01/10] net: phy: Add driver for Loongson PHY
Message-ID: <24d49ab1-c2e4-4878-a4f6-8d1f405f2407@lunn.ch>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
 <9e0b3466-10e1-4267-ab9b-d9f8149b6b6b@lunn.ch>
 <CACWXhKkX-syR01opOky=t-b8C3nhV5f_WNfCQ-kOE+4o0xh4tA@mail.gmail.com>
 <3cff46b0-5621-4881-8e70-362bb7a70ed1@lunn.ch>
 <CACWXhKk23muXROj6OrmeFna88ViJHA_7QpQZoWiFgzEPb4pLWQ@mail.gmail.com>
 <9568c4ad-e10f-4b76-8766-ec621f788c40@lunn.ch>
 <CACWXhKkoJHT8HNb-h_1PJTT1rE-TQxByd98qS0Zka5yg2_WsXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACWXhKkoJHT8HNb-h_1PJTT1rE-TQxByd98qS0Zka5yg2_WsXw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Hi, Andrew,
> 
> Sorry, I currently don't have an exact timeline for when the OUI will
> be available. The next hardware version will address these bugs, so
> we won't be going with this driver.

Not having an OUI breaks the standard. So i was actually thinking you
should trap the reads to the ID registers in the MDIO bus driver and
return valid values. Some Marvell Ethernet switch integrated PHYs have
a valid OUI, and no device part. We trap those and insert valid
values. So there is some president for doing this. Doing this would
also allow you to avoid the PHY driver poking around the MAC drivers
PCI bus.

> > So i would suggest .get_features() indicates normal 10/100/1000
> > operation. Have your .config_aneg function which is used for both
> > auto-neg and forced configuration check for phydev->autoneg ==
> > AUTONEG_DISABLE and phydev->speed == SPEED_1000 and return
> > -EOPNOTSUPP. Otherwise call genphy_config_aneg().
> >
> 
> Well, can I return -EINVAL in the .set_link_ksettings callback?

If the PHY is broken, the PHY should do it. If the MAC is broken, the
MAC should do it. We have clean separation here, even when the
hardware is integrated.

> Considering that our next hardware version will have the OUI
> allocated and these bugs fixed, I won't submit this driver in
> the next patch version. I believe we can just use the generic
> PHY for now.

The problem with the generic driver is you cannot have workarounds in
it. You don't want to put PHY workarounds in the MAC driver.

    Andrew


