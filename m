Return-Path: <netdev+bounces-22241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126DA766AC1
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AD41C218C0
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3A7101FF;
	Fri, 28 Jul 2023 10:34:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32648C8CA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:34:15 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962705B98
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GE/GiJ/Wr4BDnRbyetCqlvLJDFtA4s5+ouGWfwAgb7g=; b=NSpiIFMRAIdpYhCY0kr6jLQ4S0
	hXJ6K9CJUD8pQJmG06KZx9rrtMx3RCUL2vwsQsRz1g69MjAB43cmgz5RzulKDJEKXNvG4NioSAfEC
	5EOrDS5L78jTqjxjgjtJvktOsGeoexATVTm40to4To5bgpjalqR3HKM8UfnSVhBkdMIWX+s4PgV7o
	fJ6dM3l3d2eIjnrHSk3O6ez6IRw5nnjNfL6Gxnx9nQdC5P3ho74KE00hm96eCu5JZULNzI7LvKZSB
	VgqXuSUYw8uZiiAiqkeOZ8xEM7MOQS7vKIOy+XJanB6v+r+/SBDWFznaBnpUGLwGgJ+R7geWbTLMd
	k/yAqcsg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44822)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qPKnG-00077Z-2K;
	Fri, 28 Jul 2023 11:33:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qPKnD-0004q7-Aw; Fri, 28 Jul 2023 11:33:55 +0100
Date: Fri, 28 Jul 2023 11:33:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for
 SGMII mode
Message-ID: <ZMOZkzCqiUZP/uQ8@shell.armlinux.org.uk>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-5-jiawenwu@trustnetic.com>
 <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk>
 <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com>
 <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk>
 <03f101d9bedd$763b06d0$62b11470$@trustnetic.com>
 <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk>
 <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk>
 <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 06:11:51PM +0800, Jiawen Wu wrote:
> On Tuesday, July 25, 2023 6:08 PM, Russell King (Oracle) wrote:
> > On Tue, Jul 25, 2023 at 10:58:25AM +0100, Russell King (Oracle) wrote:
> > > > The information obtained from the IC designer is that "PHY/MAC side SGMII"
> > > > is configured by experimentation. For these different kinds of NICs:
> > > > 1) fiber + SFP-RJ45 module: PHY side SGMII
> > > > 2) copper (pcs + external PHY): MAC side SGMII
> > >
> > > This makes no sense. a PHY on a RJ45 SFP module is just the same as a
> > > PHY integrated into a board with the MAC.
> > 
> > 
> > MAC ---- PCS <----- sgmii -----> PHY (whether on a board or SFP)
> > 
> > Control word flow:
> >              <------------------ link, speed, duplex
> > 	     ------------------> acknowledge (value = 0x4001)
> > 
> > Sometimes, it's possible to connect two MACs/PCSs together:
> > 
> > MAC ---- PCS <----- sgmii -----> PCS ---- MAC
> > 
> > and in this case, one PCS would need to be configured in "MAC" mode
> > and the other would need to be configured in "PHY" mode because SGMII
> > is fundamentally asymmetric.
> > 
> > Here is the definition of the control word sent by either end:
> > 
> > Bit	MAC->PHY	PHY->MAC
> > 15	0: Reserved	Link status, 1 = link up
> > 14	1: Acknowledge	Reserved for AN acknowledge
> > 13	0: Reserved	0: Reserved
> > 12	0: Reserved	Duplex mode 1 = full, 0 = half
> > 11:10	0: Reserved	Speed 11 = Reserved 10=1G, 01=100M, 00=10M
> > 9:1	0: Reserved	0: Reserved
> > 0	1		1
> > 
> > So my guess would be that "PHY side SGMII" means the device generates
> > the "PHY->MAC" format word whereas "MAC side SGMII" generates the
> > "MAC->PHY" format word - and it's the latter that you want to be using
> > both for Copper SFPs, which are no different from PHYs integrated onto
> > the board connected with SGMII.
> 
> There is a question about I2C MII read ops. I see that PHY in SFP-RJ45 module
> is read by i2c_mii_read_default_c22(), but it limits the msgs[0].len=1.
> 
> A description in  the SFP-RJ45 datasheet shows:
> The registers are accessible through the 2-wire serial CMOS EEPROM protocol
> of the ATMEL AT24C01A or equivalent. The address of the PHY is 1010110x,
> where x is the R/W bit. Each register's address is 000yyyyy, where yyyyy is the
> binary equivalent of the register number. Write and read operations must send
> or receive 16 bits of data, so the "multi-page" access protocol must be used.
> 
> So the PHY register address should be written twice: first high 8 bits, second low
> 8 bits. to read the register value.
> 
> Is there a problem with which driver?

No there isn't, and it conforms with the above.

A read looks like this:

      Address  Data                   Address  Data     Data
Start 10101100 000yyyyy RepeatedStart 10101101 DDDDDDDD DDDDDDDD Stop
                      or Stop followed
		          by Start

The terms "Address" and "Data" here are as per the I²C specification.
You will notice that the first part has one byte of address and *one*
byte of data to convey the register address. This is what the "1" you
are referring to above is for.

For completness, a write looks like this:

      Address  Data     Data     Data
Start 10101100 000yyyyy DDDDDDDD DDDDDDDD Stop

Essentially, in all cases, when 0x56 is addressed with the data
direction in write mode, the very first byte is _always_ the register
address and the remainder contain the data. When the data direction is
in read mode, the bytes are always data.

The description you quote above is poor because it doesn't make it
clear whether "read" and "write" apply to the bus transactions or to
the device operations. However, I can assure you that what is
implemented is correct, since this is the standard small 24xx memory
device protocol, and I've been programming that on various
microcontrollers and such like for the last 30 years.

Are you seeing a problem with the data read or written to the PHY?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

