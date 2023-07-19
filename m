Return-Path: <netdev+bounces-18902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691B07590A6
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CC81C20987
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97910784;
	Wed, 19 Jul 2023 08:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32610783
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 08:52:14 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23501723
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MmEKJfh6vwtIMdr0J8x8h7yQsrs/7bG+izBybwxF8T4=; b=RPkrrshhkY2GT5v2mRzMVbkp2p
	Kar3wokAqm0IOvEMsLVYVByjiR4bMccnulM5j5p8ZKxDsNMh46cv1p92U0fTTgHJb2QsaBvdQ6oCg
	hGX+wVRS4wUYfwQMHPhA4uUjLBcjjwMN265HEl0JnFSTSy+8Udj4N8WCtRYJy+4kZSXHOtA6NKqH0
	BDN3QrKvn2ixmOKTCCEwIBByExS+OMpQs8kVSB/Ynvqfwpu9HT94M7J3EgwBKME1XvnXy2NmAegRt
	O23mWJ8a8Kk/vcG6Avz/6IWtY0Y5Q4XXor0ArveYqOeZ4nMoXmupWaXfxPgFbJE9Rfzah9mJsWU33
	SN9RWVcA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44296)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qM2uh-0007Ds-1d;
	Wed, 19 Jul 2023 09:52:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qM2ug-0003wC-0K; Wed, 19 Jul 2023 09:52:02 +0100
Date: Wed, 19 Jul 2023 09:52:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Simon Horman' <simon.horman@corigine.com>, kabel@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZLekMZvMN0H8iCby@shell.armlinux.org.uk>
References: <ZLUymspsQlJL1k8n@shell.armlinux.org.uk>
 <013701d9b957$fc66f740$f534e5c0$@trustnetic.com>
 <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk>
 <013e01d9b95e$66c10350$344309f0$@trustnetic.com>
 <ZLZ70F74dPKCIdtK@shell.armlinux.org.uk>
 <017401d9b9e8$ddd1dd90$997598b0$@trustnetic.com>
 <ZLeHyzsRqxAj4ZGO@shell.armlinux.org.uk>
 <01b401d9ba16$aacf75f0$006e61d0$@trustnetic.com>
 <ZLeeZMU4HeiHthQ2@shell.armlinux.org.uk>
 <01b701d9ba1c$691d9fa0$3b58dee0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b701d9ba1c$691d9fa0$3b58dee0$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 04:38:36PM +0800, Jiawen Wu wrote:
> On Wednesday, July 19, 2023 4:27 PM, Russell King (Oracle) wrote:
> > On Wed, Jul 19, 2023 at 03:57:30PM +0800, Jiawen Wu wrote:
> > > > According to this read though (which is in get_mactype), the write
> > > > didn't take effect.
> > > >
> > > > If you place a delay of 1ms after phy_clear_bits_mmd() in
> > > > mv3310_power_up(), does it then work?
> > >
> > > Yes, I just experimented, it works well.
> > 
> > Please send a patch adding it, with a comment along the lines of:
> > 
> > 	/* Sometimes, the power down bit doesn't clear immediately, and
> > 	 * a read of this register causes the bit not to clear. Delay
> > 	 * 1ms to allow the PHY to come out of power down mode before
> > 	 * the next access.
> > 	 */
> 
> After multiple experiments, I determined that the minimum delay it required
> is 55us. Does the delay need to be reduced? But I'm not sure whether it is
> related to the system. I use udelay(55) in the test.

55us is slightly longer than one access-time to C45 registers with 32
bits of preamble on the bus before each mdio frame. I'd suggest we go
with 100us in that case.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

