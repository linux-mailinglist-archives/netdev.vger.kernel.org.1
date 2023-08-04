Return-Path: <netdev+bounces-24500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC800770642
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75E52827FF
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6101156E4;
	Fri,  4 Aug 2023 16:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB646C15C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:48:05 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322B2D5F;
	Fri,  4 Aug 2023 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RO4eJJfHRg8JOKGHnZzYhOFDDcQwqh/3jOnjYiqw8e0=; b=UbnbJ9890f1fQ9/fLFUZ28vKyU
	HAWNJQeq5/GgnN0yxRdgYFrGrXn9Hq2lH3mYRviTPvojAfw3EokKG38IypVaaMGofzK45jWxnvhDn
	AOYVOyyd+yWvROJdIb9tZF+/Kck9Jhgv+zDE/XgbMOzZPEkTyDdtbrAB614BS140Rg0S5LRB6hSJh
	IO7u5wHLpg8JF+bw6V+aEhueLmzI79pYNj/iH1kNWhw6qjzHRw3Y6EBaQI7SxDPIYsF5VSTWSn1QL
	Q3sCjqQCERdHixBetKi8/ZGIkXqe3+1MMNGkgh8Vr1n68IMPSFzR8b+evsShcm8JzDe075OLnCweY
	AoBDfZPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50246)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qRxy1-0000T8-1b;
	Fri, 04 Aug 2023 17:47:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qRxy1-000493-1S; Fri, 04 Aug 2023 17:47:57 +0100
Date: Fri, 4 Aug 2023 17:47:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nick Bowler <nbowler@draconx.ca>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18
 (regression)
Message-ID: <ZM0rvEkQ3XLlrbQC@shell.armlinux.org.uk>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 12:24:02PM -0400, Nick Bowler wrote:
> On 04/08/2023, Rob Herring <robh@kernel.org> wrote:
> > On Fri, Aug 4, 2023 at 9:27 AM Nick Bowler <nbowler@draconx.ca> wrote:
> >>   commit e461bd6f43f4e568f7436a8b6bc21c4ce6914c36
> >>   Author: Robert Hancock <robert.hancock@calian.com>
> >>   Date:   Thu Jan 27 10:37:36 2022 -0600
> >>
> >>       arm64: dts: zynqmp: Added GEM reset definitions
> >>
> >> Reverting this fixes the problem on 5.18.  Reverting this fixes the
> >> problem on 6.1.  Reverting this fixes the problem on 6.4.  In all of
> >> these versions, with this change reverted, the network device appears
> >> without delay.
> >
> > With the above change, the kernel is going to be waiting for the reset
> > driver which either didn't exist or wasn't enabled in your config
> > (maybe kconfig needs to be tweaked to enable it automatically).
> 
> The dts defines a reset-controller node with
> 
>   compatible = "xlnx,zynqmp-reset"
> 
> As far as I can see, this is supposed to be handled by the code in
> drivers/reset/zynqmp-reset.c driver, it is enabled by CONFIG_ARCH_ZYNQMP,
> and I have that set to "y", and it appears to be getting compiled in (that
> is, there is a drivers/reset/zynqmp-reset.o file in the build directory).

Isn't the driver called reset-zynqmp.c and reset-zynqmp.o ?

> However, unlike with the other firmware devices, I do not see this driver
> under /sys/bus/platform/drivers, and there is no "driver" symlink under
> /sys/bus/platform/devices/firmware:zynqmp-firmware:reset-controller

The driver name would be the kbuild modname, which would be
reset-zynqmp rather than zynqmp-reset - given how often you're typing
zynqmp-reset rather than zynqmp-reset, could you have missed it
through looking for the wrong name?

If the driver is built-in, there is no reason it should fail to show
up in /sys/bus/platform/drivers/reset-zynqmp.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

