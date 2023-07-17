Return-Path: <netdev+bounces-18270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55BC7562A3
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120601C20A40
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 12:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC34AD4A;
	Mon, 17 Jul 2023 12:23:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2BA959
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:23:09 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93018135
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C5zQT/dqrA4HFAHfa/NjK2kjRyKvjURipeA8gMHzopQ=; b=NWE60OYDQGk/HBuDLAL8bPfFr6
	5jm5afMKoffACpDF7rIhV6ym7HvkfSpN5ozhxnp05JSztfcpbpEENQCRrZIDfYaglnEK7eoaxz2lj
	wVHagsN5Vz8cybF0+YYR7Zwamy04rH57btjNBSVGkhmmVfBHv6/NF2HQU9YY/EVGwUE2bsSxsLO40
	6qwXbx+JEZ6VqEetRlC4VuyLhE+SBNNU7CucqPhvkfDkCogab984Rkhs2WqFm0Ey5MOhDFse124Fl
	eAnMNNSxwcqlyPyj4wOWUj51CaFB6+7flIiHxKOHZRzHP68eyXICU8Ymhv/nksVU2zywP38MAVYDb
	qNzQKmBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55708)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qLNFe-0003sK-1O;
	Mon, 17 Jul 2023 13:22:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qLNFa-0001uT-LL; Mon, 17 Jul 2023 13:22:50 +0100
Date: Mon, 17 Jul 2023 13:22:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Simon Horman' <simon.horman@corigine.com>, kabel@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZLUymspsQlJL1k8n@shell.armlinux.org.uk>
References: <20230712062634.21288-1-jiawenwu@trustnetic.com>
 <ZK/RYFBjI5OypfTB@corigine.com>
 <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk>
 <ZK/V57+pl36NhknG@corigine.com>
 <ZK/Xtg3df6n+Nj11@shell.armlinux.org.uk>
 <043401d9b57d$66441e60$32cc5b20$@trustnetic.com>
 <ZK/i3Ta2mcr7xVot@shell.armlinux.org.uk>
 <043501d9b580$31798870$946c9950$@trustnetic.com>
 <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 06:51:38PM +0800, Jiawen Wu wrote:
> > > > > There are two places that mv3310_reset() is called, mv3310_config_mdix()
> > > > > and mv3310_set_edpd(). One of them is in the probe function, after we
> > > > > have powered up the PHY.
> > > > >
> > > > > I think we need much more information from the reporter before we can
> > > > > guess which commit is a problem, if any.
> > > > >
> > > > > When does the reset time out?
> > > > > What is the code path that we see mv3310_reset() timing out?
> > > > > Does the problem happen while resuming or probing?
> > > > > How soon after clearing the power down bit is mv3310_reset() called?
> > > >
> > > > I need to test it more times for more information.
> > > >
> > > > As far as I know, reset timeout appears in mv3310_set_edpd(), after mv3310_power_up()
> > > > in mv3310_config_init().
> > > >
> > > > Now what I'm confused about is, sometimes there was weird values while probing, just
> > > > to read out a weird firmware version, that caused the test to fail.
> > > >
> > > > And for this phy_read_mmd_poll_timeout(), it only succeeds when sleep_before_read = true.
> > > > Otherwise, it would never succeed to clear the power down bit. Currently it looks like clearing
> > > > the bit takes about 1ms.
> > >
> > > So, reading the bit before the first delay period results in the bit not
> > > clearing, despite having written it to be zero?
> > 
> > Yes. So in the original code, there is no delay to read the register again for
> > setting software reset bit. I think the power down bit is not actually cleared
> > in my test.
> 
> Hi Russell,
> 
> I confirmed last week that this change is valid to make mv3310_reset() success.
> But now reset fails again, only on port 0. Reset timeout still appears in
> mv3310_config_init() -> mv3310_set_edpd() -> mv3310_reset(). I deleted this
> change to test again, and the result shows that this change is valid for port 1.
> 
> So I'm a little confused. Since I don't have programming guidelines for this PHY,
> but only a datasheet. Could you please help to check for any possible problems
> with it?

I think the question that's missing is... why do other 88x3310 users not
see this problem - what is special about your port 0?

Maybe there's a clue with the hardware schematics? Do you have access to
those?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

