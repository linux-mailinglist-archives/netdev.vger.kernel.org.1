Return-Path: <netdev+bounces-16241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D72E74C11D
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 07:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A6F1C2091E
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8D1FA9;
	Sun,  9 Jul 2023 05:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFE81C06
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 05:40:30 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93712A
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 22:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NzlhFI7PoXlPO6jOxGj7DoJ9XV65SQ+pNfIxRWsSDtE=; b=KHjmhclS/0TUwUpZAj8p2EHE6N
	sgntn6TUFLqdOJoBs2XDbi5k8MleCl7ZXOy8XVfDLLVeSEEmywSRebTKZbsMoe8Ixpp7BULt5dhQp
	Lnlv802VzoXPFxbqWEKS42Aw5ugmLYN9fbZg23ESg3GVs/fuIDu3SrNgE8LJYCjIBetKv3YabMIhl
	cJ+282Bq7Gf89TB1yqraX70ZlBG4Lfd+4G+8b4YiOIPK5PT3u6RwJctmSr14oQ4xrVmH0dISlUkr+
	lmYaUyN2uSKi+9SiiYNFzn26LJ3TXwrLQ1RoI/gK+wBGBiEdT9Sm9BcLC+f2W0Os6USTjWsPHxH2l
	erQ7FH2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54962)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qIN9j-0005Gr-1J;
	Sun, 09 Jul 2023 06:40:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qIN9i-0001cr-Ix; Sun, 09 Jul 2023 06:40:22 +0100
Date: Sun, 9 Jul 2023 06:40:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: alpha_one_x86@first-world.info, Andrew Lunn <andrew@lunn.ch>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: Re: Fw: [Bug 217640] New: 10G SFP+ and 1G Ethernet work at 100M on
 macchiatobin
Message-ID: <ZKpIRon2bjdFxcuK@shell.armlinux.org.uk>
References: <20230707075919.183e6abc@hermes.local>
 <1ae37aef-299c-400d-9287-ba5ab85637f7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ae37aef-299c-400d-9287-ba5ab85637f7@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 08, 2023 at 11:23:03PM +0200, Andrew Lunn wrote:
> Adding Russell King.
> 
>        Andrew
> 
> On Fri, Jul 07, 2023 at 07:59:19AM -0700, Stephen Hemminger wrote:
> > 
> > 
> > Begin forwarded message:
> > 
> > Date: Thu, 06 Jul 2023 23:23:02 +0000
> > From: bugzilla-daemon@kernel.org
> > To: stephen@networkplumber.org
> > Subject: [Bug 217640] New: 10G SFP+ and 1G Ethernet work at 100M on macchiatobin
> > 
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=217640
> > 
> >             Bug ID: 217640
> >            Summary: 10G SFP+ and 1G Ethernet work at 100M on macchiatobin
> >            Product: Networking
> >            Version: 2.5
> >           Hardware: All
> >                 OS: Linux
> >             Status: NEW
> >           Severity: normal
> >           Priority: P3
> >          Component: Other
> >           Assignee: stephen@networkplumber.org
> >           Reporter: alpha_one_x86@first-world.info
> >         Regression: No
> > 
> > Hi,
> > Since I upgrade linux kernel from 5.10.137 to 6.1.38 all my interface of
> > macchiatobin work at 100M (90 Mbits/sec detected by iperf)
> > ethtool detect the link at correct speed (10G for SFP+ and 1Gbps for ethernet)
> > What can be the regression?

I'm on holiday at the moment, so don't expect fast or full replies.

If ethtool is stating the correct link speed, then it's not a SFP layer
or phylink layer bug.

I don't see any problem with mvpp2 between Armada 8040 hardware running
6.3.0 and 6.1.0 kernels - according to iperf3:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1004 MBytes   842 Mbits/sec   46 sender
[  5]   0.00-10.00  sec  1001 MBytes   839 Mbits/sec      receiver

That's mcbin <-(copper)-> Clearfog Base <-(fibre)-> Clearfog gt-8k

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

