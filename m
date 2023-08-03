Return-Path: <netdev+bounces-23976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49BB76E66A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A6E282082
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692B917ACA;
	Thu,  3 Aug 2023 11:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC0B156FB
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:10:54 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C5430E4
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qOW7GrFhrwC0o9v7aS7a7ElAnXgu7SE9mIK1bF6Xn/A=; b=J0FCcU8qvNcS6NTddsC1KSl5Rv
	HaCNEBrCq9Hw5HS3nzPzb6/xdFHtlJKNwTzfzNoM08cKrsoeSsWSuvTghKvo1P0FJyaWfs3ZFt3rJ
	eemHq5rlbm8Ors6uLiGYVNcGD/zj+z5lweZ/nftddN6EUWzpnXxkETl452iMlMLv8yGeueosEEJPq
	tETVEGlyFQ1na0tmr3ZHCD1HitK6/p+0VSf3EOirgyblCTG7Iqx370NCGHqN8cTCNML3yBY6sSsTp
	WQPlrQ+VA9W2q/nBn18DlonNfIDTmkxl0g5owZm2yyKD6KU2HFR2ImHb1yRr8kBnpKpxNBxd2/b4i
	fenNer/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54432)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qRWE3-0006pA-20;
	Thu, 03 Aug 2023 12:10:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qRWDx-0002rw-MX; Thu, 03 Aug 2023 12:10:33 +0100
Date: Thu, 3 Aug 2023 12:10:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for
 SGMII mode
Message-ID: <ZMuLKa2HX9/LiCPn@shell.armlinux.org.uk>
References: <20230724102341.10401-5-jiawenwu@trustnetic.com>
 <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk>
 <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com>
 <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk>
 <03f101d9bedd$763b06d0$62b11470$@trustnetic.com>
 <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk>
 <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk>
 <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com>
 <ZMOZkzCqiUZP/uQ8@shell.armlinux.org.uk>
 <068501d9c5b1$0e263ad0$2a72b070$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <068501d9c5b1$0e263ad0$2a72b070$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 10:20:22AM +0800, Jiawen Wu wrote:
> > No there isn't, and it conforms with the above.
> > 
> > A read looks like this:
> > 
> >       Address  Data                   Address  Data     Data
> > Start 10101100 000yyyyy RepeatedStart 10101101 DDDDDDDD DDDDDDDD Stop
> >                       or Stop followed
> > 		          by Start
> > 
> > The terms "Address" and "Data" here are as per the I²C specification.
> > You will notice that the first part has one byte of address and *one*
> > byte of data to convey the register address. This is what the "1" you
> > are referring to above is for.
> > 
> > For completness, a write looks like this:
> > 
> >       Address  Data     Data     Data
> > Start 10101100 000yyyyy DDDDDDDD DDDDDDDD Stop
> > 
> > Essentially, in all cases, when 0x56 is addressed with the data
> > direction in write mode, the very first byte is _always_ the register
> > address and the remainder contain the data. When the data direction is
> > in read mode, the bytes are always data.
> > 
> > The description you quote above is poor because it doesn't make it
> > clear whether "read" and "write" apply to the bus transactions or to
> > the device operations. However, I can assure you that what is
> > implemented is correct, since this is the standard small 24xx memory
> > device protocol, and I've been programming that on various
> > microcontrollers and such like for the last 30 years.
> > 
> > Are you seeing a problem with the data read or written to the PHY?
> 
> Hi Russell,
> 
> I really don't know how to deal with "MAC side SGMII", could you please
> help me?
> 
> From the test results, when I config PCS in "PHY side SGMII", the link status
> of PHY in copper SFP is read by I2C after AN complete. Then PHY's link up
> status is informed to PHYLINK, then PCS will check its status. But when I just
> change PCS to "MAC side SGMII", I2C will keep reading timeouts since AN
> complete. I checked the register of PCS to confirm AN complete, but PHY's
> link status would never be updated in PHYLINK.

I don't understand what is going on here either - but what I do know
is that there is _zero_ difference as far as the network link is
concerned between an on-board PHY using SGMII to the MAC/PCS and a SFP
with a PHY using SGMII.

In both situations the PHY behaves the same - it presents a PHY-side
SGMII interface, so it sends to the MAC/PCS the speed and duplex
settings, and expects the MAC/PCS to acknowledge them.

The name "MAC side SGMII" suggests that this mode provides the
acknowledgement, whereas "PHY side SGMII" suggests that this mode
provides a speed and duplex.

Given all this, using "PHY side SGMII" with a SFP, and "MAC side
SGMII" for an on-board PHY just seems utterly wrong - and I can't
make head nor tail of it.

> It's kind of weird to me, how does the configuration of PCS relate to I2C?

I2C is just the access method for PHYs on SFPs - because there are
no MDIO bus pins on SFP modules, only I2C pins mainly for accessing
the identification EEPROM and diagnostics, but many copper SFPs have
a way to access the PHY.

I2C is transparent as far as phylib is concerned - the mdio-i2c
driver makes the PHY "appear" as if it is on a conventional MDIO
bus.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

