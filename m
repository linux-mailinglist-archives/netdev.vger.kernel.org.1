Return-Path: <netdev+bounces-17562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25524752042
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB84280E38
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3E611C9E;
	Thu, 13 Jul 2023 11:42:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1ED125A0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:42:01 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9672D78
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IGslatGqq0VM4Kw3vW4kXcYWEYbfs7xENw611xmgJ40=; b=KzjgnGWc4pGwPiReayqeOY76dY
	iHXX1fZxlviPKMvXIwTXiTQIiFkxU2ieKXwWHRbH0WyWcPDcrWLhiyAa1HIfZQPcMu8T7sqTiF0Dz
	fCB6cJCSIOuJpFAFCuBpYT7xrVA91wCi6GFXg2qziVkZYTdkhiDmXeiiKblLJsA4E9GUFvGLNvm/K
	pyPYUHf2vDZ4vqBjpuoyb5+MgaaZh9VfppYAs5+uy8b93BMrYrZLn2tA3d0UiUGyEvGNwOU+r4Mva
	OqcVDq/M0Xq6G7QYYpX4DlWNb0zxN/9GIxJH/zh5lg6gofvaxNYbe6f0UdSkyZmbeJhK9AoczLXSu
	1WTK67IA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44548)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJuhD-00074X-03;
	Thu, 13 Jul 2023 12:41:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJuhB-000686-KZ; Thu, 13 Jul 2023 12:41:17 +0100
Date: Thu, 13 Jul 2023 12:41:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Simon Horman' <simon.horman@corigine.com>, kabel@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk>
References: <20230712062634.21288-1-jiawenwu@trustnetic.com>
 <ZK/RYFBjI5OypfTB@corigine.com>
 <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk>
 <ZK/V57+pl36NhknG@corigine.com>
 <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk>
 <043401d9b57d$66441e60$32cc5b20$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043401d9b57d$66441e60$32cc5b20$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 07:30:17PM +0800, Jiawen Wu wrote:
> On Thursday, July 13, 2023 6:54 PM, Russell King (Oracle) wrote:
> > On Thu, Jul 13, 2023 at 11:45:59AM +0100, Simon Horman wrote:
> > > On Thu, Jul 13, 2023 at 11:35:05AM +0100, Russell King (Oracle) wrote:
> > > > On Thu, Jul 13, 2023 at 11:26:40AM +0100, Simon Horman wrote:
> > > > > On Wed, Jul 12, 2023 at 02:26:34PM +0800, Jiawen Wu wrote:
> > > > > > Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> > > > > > it sometimes does not take effect immediately. This will cause
> > > > > > mv3310_reset() to time out, which will fail the config initialization.
> > > > > > So add to poll PHY power up.
> > > > > >
> > > > > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > > >
> > > > > Hi Jiawen Wu,
> > > > >
> > > > > should this have the following?
> > > > >
> > > > > Fixes: 0a5550b1165c ("bpftool: Use "fallthrough;" keyword instead of comments")
> > > >
> > > > What is that commit? It doesn't appear to be in Linus' tree, it doesn't
> > > > appear to be in the net tree, nor the net-next tree.
> > >
> > > Hi Russell,
> > >
> > > Sorry, it is bogus. Some sort of cut and paste error on my side
> > > that pulled in the local commit of an unrelated patch.
> > >
> > > What I should have said is:
> > >
> > > Fixes: 8f48c2ac85ed ("net: marvell10g: soft-reset the PHY when coming out of low power")
> > 
> > Thanks, but I don't think that's appropriate either.
> > 
> > The commit adds a software reset after clearing the power down bit, but
> > that doesn't have anything to do with mv3310_reset().
> > 
> > There are two places that mv3310_reset() is called, mv3310_config_mdix()
> > and mv3310_set_edpd(). One of them is in the probe function, after we
> > have powered up the PHY.
> > 
> > I think we need much more information from the reporter before we can
> > guess which commit is a problem, if any.
> > 
> > When does the reset time out?
> > What is the code path that we see mv3310_reset() timing out?
> > Does the problem happen while resuming or probing?
> > How soon after clearing the power down bit is mv3310_reset() called?
> 
> I need to test it more times for more information.
> 
> As far as I know, reset timeout appears in mv3310_set_edpd(), after mv3310_power_up()
> in mv3310_config_init().
> 
> Now what I'm confused about is, sometimes there was weird values while probing, just
> to read out a weird firmware version, that caused the test to fail.
> 
> And for this phy_read_mmd_poll_timeout(), it only succeeds when sleep_before_read = true.
> Otherwise, it would never succeed to clear the power down bit. Currently it looks like clearing
> the bit takes about 1ms.

So, reading the bit before the first delay period results in the bit not
clearing, despite having written it to be zero?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

