Return-Path: <netdev+bounces-18566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A753B757AD8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34B01C20C3C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41896C2F8;
	Tue, 18 Jul 2023 11:47:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E2C2D5
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:47:54 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414BD10F5
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FiBX+9HGM+Vscc5Lpi8amVqdo+0CxIP+ev2pq2U93h0=; b=y791cqPkLUdwvclHQuS1bXQLu6
	f40xBxzmr6ZZ+xKkaD89i1yDhCHpIHZS8MudNmdCYUjty95jLWhOmTXVM57fkPpFdJaY/TpwZYQdF
	Iz8zQWxaq5CGxmTCSkvnaADMyQsOcvl76O0VwFcaqvxRc6u7F1lkwHFOKYdL3jnRx8yr3pad1dlO6
	AfM/i7efg+dZgNFL1Y+Izq2DCr/5wPCIOcfLhcCAzpDXCVVH1HrRapaQFVTfG5bygzTfjNB5Z2IFA
	ScRCrb0/Szwz/JdAITjzJR2pLlDHCXkHPnVzEvrXoyN4SWQ8X3nx7MZ4HKWsNdCkorgqMzyCQOiDH
	PNtwZ1pw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36908)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qLjB3-0005ik-38;
	Tue, 18 Jul 2023 12:47:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qLjAu-00030y-RJ; Tue, 18 Jul 2023 12:47:28 +0100
Date: Tue, 18 Jul 2023 12:47:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Simon Horman' <simon.horman@corigine.com>, kabel@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZLZ70F74dPKCIdtK@shell.armlinux.org.uk>
References: <ZK/V57+pl36NhknG@corigine.com>
 <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk>
 <043401d9b57d$66441e60$32cc5b20$@trustnetic.com>
 <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk>
 <043501d9b580$31798870$946c9950$@trustnetic.com>
 <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com>
 <ZLUymspsQlJL1k8n@shell.armlinux.org.uk>
 <013701d9b957$fc66f740$f534e5c0$@trustnetic.com>
 <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk>
 <013e01d9b95e$66c10350$344309f0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013e01d9b95e$66c10350$344309f0$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 05:58:28PM +0800, Jiawen Wu wrote:
> On Tuesday, July 18, 2023 5:49 PM, Russell King (Oracle) wrote:
> > On Tue, Jul 18, 2023 at 05:12:33PM +0800, Jiawen Wu wrote:
> > > On Monday, July 17, 2023 8:23 PM, Russell King (Oracle) wrote:
> > > > On Mon, Jul 17, 2023 at 06:51:38PM +0800, Jiawen Wu wrote:
> > > > > > > > > There are two places that mv3310_reset() is called, mv3310_config_mdix()
> > > > > > > > > and mv3310_set_edpd(). One of them is in the probe function, after we
> > > > > > > > > have powered up the PHY.
> > > > > > > > >
> > > > > > > > > I think we need much more information from the reporter before we can
> > > > > > > > > guess which commit is a problem, if any.
> > > > > > > > >
> > > > > > > > > When does the reset time out?
> > > > > > > > > What is the code path that we see mv3310_reset() timing out?
> > > > > > > > > Does the problem happen while resuming or probing?
> > > > > > > > > How soon after clearing the power down bit is mv3310_reset() called?
> > > > > > > >
> > > > > > > > I need to test it more times for more information.
> > > > > > > >
> > > > > > > > As far as I know, reset timeout appears in mv3310_set_edpd(), after mv3310_power_up()
> > > > > > > > in mv3310_config_init().
> > > > > > > >
> > > > > > > > Now what I'm confused about is, sometimes there was weird values while probing, just
> > > > > > > > to read out a weird firmware version, that caused the test to fail.
> > > > > > > >
> > > > > > > > And for this phy_read_mmd_poll_timeout(), it only succeeds when sleep_before_read = true.
> > > > > > > > Otherwise, it would never succeed to clear the power down bit. Currently it looks like clearing
> > > > > > > > the bit takes about 1ms.
> > > > > > >
> > > > > > > So, reading the bit before the first delay period results in the bit not
> > > > > > > clearing, despite having written it to be zero?
> > > > > >
> > > > > > Yes. So in the original code, there is no delay to read the register again for
> > > > > > setting software reset bit. I think the power down bit is not actually cleared
> > > > > > in my test.
> > > > >
> > > > > Hi Russell,
> > > > >
> > > > > I confirmed last week that this change is valid to make mv3310_reset() success.
> > > > > But now reset fails again, only on port 0. Reset timeout still appears in
> > > > > mv3310_config_init() -> mv3310_set_edpd() -> mv3310_reset(). I deleted this
> > > > > change to test again, and the result shows that this change is valid for port 1.
> > > > >
> > > > > So I'm a little confused. Since I don't have programming guidelines for this PHY,
> > > > > but only a datasheet. Could you please help to check for any possible problems
> > > > > with it?
> > > >
> > > > I think the question that's missing is... why do other 88x3310 users not
> > > > see this problem - what is special about your port 0?
> > > >
> > > > Maybe there's a clue with the hardware schematics? Do you have access to
> > > > those?
> > >
> > > This problem never happened again after I poweroff and restart the machine.
> > > However, this patch is still required to successfully probe the PHY.
> > >
> > > One thing I've noticed is that there is restriction in mv3310_power_up(), software
> > > reset not performed when priv->firmware_ver < 0x00030000. And my 88x3310's
> > > firmware version happens to 0x20200. Will this restriction cause subsequent reset
> > > timeout(without this patch)?
> > 
> > We (Matteo and I) discovered the need for software reset by
> > experimentation on his Macchiatobin and trying different firmware
> > versions. Essentially, I had 0.2.1.0 which didn't need the software
> > reset, Matteo had 0.3.3.0 which did seem to need it.
> > 
> > I also upgraded my firmware to 0.3.3.0 and even 0.3.10.0 and confirmed
> > that the software reset works on the two PHYs on my boards.
> > 
> > What I don't understand is "this patch is still required to successfully
> > probe the PHY". The power-up path is not called during probe - nor is
> > the EDPD path. By "probe" I'm assuming we're talking about the driver
> > probe, in other words, mv3310_probe(), not the config_init - it may be
> > that you're terminology is not matching phylib's terminology. Please
> > can you clarify.
> 
> I'm sorry for the mistake in my description. I mean MAC driver probe, in fact
> it is in phy_connect_direct(), to call mv3310_config_init().

Okay, so how about this for an alternative theory.

The PHY is being probed, which places the PHY in power down mode.
Then your network driver (which?) gets probed, connects immediately
to the PHY, which attempts to power up the PHY - but maybe the PHY
hasn't finished powering down yet, and thus delays the powering up.

However, according to the functional spec, placing the device in
power-down mode as we do is immediate.

Please can you try experimenting with a delay in mv3310_config_init()
before the call to mv3310_power_up() to see whether that has any
beneficial effect?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

