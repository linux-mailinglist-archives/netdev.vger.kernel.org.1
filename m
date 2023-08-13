Return-Path: <netdev+bounces-27199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD277AE28
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 00:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA1280F8A
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26259469;
	Sun, 13 Aug 2023 22:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22118BF1
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 22:17:25 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1CE58
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 15:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZddnUEw1SPURD4HF9qBZmOAMuW0saejHBmlV/rXj/Lo=; b=z1oqai1/370S0PqUeQ5HKw2UBT
	Nhg8iq7KGpqHflu+4eU9ncuMgmXAHzJ99Elyfe9CBT9VQerv6ElSmwatBeM+h+RdxEic5eAiZRtjk
	vx+e35AtYTzDLosvM0nESUDcmE5y6JLpO0wnLjUnEixJTUnUXbGsEO6iU1VT2z4D8D9khst+0rOvQ
	nWzQmDfGc/ZTbxLLNSocHmlOPgFiHFKmpwDDjBVrla6SWA7HHfqTuBj0k/g9yfJwknkzBCjixHJzV
	XH2ffkJI4MTqiMXJJ++ZbhRJT3uCe3SUlkTsbkIJxEkIHv28uerHvmijnn6hTUSqWjAkYI/sJPEBD
	io/2S0bA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42310)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qVJOc-00084s-1N;
	Sun, 13 Aug 2023 23:17:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qVJOa-0005J1-Sd; Sun, 13 Aug 2023 23:17:12 +0100
Date: Sun, 13 Aug 2023 23:17:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <ZNlWaA2ZSSxKYDkA@shell.armlinux.org.uk>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <CACRpkdbN9Vbk+NzeLRNz9ZhSMnJEOF=Af52hjUAmnaTdK9ytvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbN9Vbk+NzeLRNz9ZhSMnJEOF=Af52hjUAmnaTdK9ytvw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 13, 2023 at 11:56:40PM +0200, Linus Walleij wrote:
> On Sat, Aug 12, 2023 at 2:16 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> 
> > That leaves the RTL836x driver, for which I've found:
> >
> > http://realtek.info/pdf/rtl8366_8369_datasheet_1-1.pdf
> >
> > and that indicates that the user ports use RSGMII which is SGMII with
> > a clock in one direction.
> 
> Sadly that datasheet has been pretty far off the RTL8366RB,
> the "RB" in the end means "revision B" and things changed a
> lot there.
> 
> What I mostly used was a DD-WRT vendor code drop, which is pretty
> terse, but can be used for guesswork:
> https://svn.dd-wrt.com//browser/src/linux/universal/linux-3.2/drivers/net/ethernet/raeth/rb
> 
> > The only dts I can find is:
> >
> > arch/arm/boot/dts/gemini-dlink-dir-685.dts
> >
> > which doesn't specify phy-mode for these, so that'll be using the
> > phylib default of GMII.
> 
> Hm. That file is my educated guesses and trial-and-error at times,
> due to lack of documentation. It shouldn't be trusted too much.
> 
> > So for realtek, I propose (completely untested):
> 
> I applied it and it all works fine afterwards on the DIR-685.
> Should I test some different configs in the DTS as well?

Note Vladimir's comment about the missing "return" - he's correct.

It would be good to test all combinations that we're aware of users
for, if that's somehow possible? I'm guessing the only one we know
about is yours above?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

