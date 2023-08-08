Return-Path: <netdev+bounces-25522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA237746F8
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF691C20F5B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B94171A7;
	Tue,  8 Aug 2023 19:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE2168DE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:06:24 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7652815C44
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8wjxErWVFF/RxJ89j9d4EV46vK+ikUgj5wYQ7mDz39c=; b=NH0S6uTRZrQtBhkK/Rv1B9qmgA
	j6dUSDXnAVrDKxowfy5ICqpy3XddFIGL82RLI4rejgwz7zFfY39NRCghLrZz1phxQaw8nskzgL9Gk
	TqyGdUC1N6haCJKzH8UJyrJJPxhK5AoKOuHxq2wwSJtBQS35ccbc0wjDAVnt3aoCCioRfi2vjpYui
	4NGCsPRRYJa951aL8x1b9c0oaIOOkrU/9aOzKGpz57eniPcERxfGLrXctBb2CpuAYqm4Yik2fuJRE
	lGT0dv7Ohe7FpljB4Rsfh4zlUFbQ2trkLYHiEYEQw8HXnLmyEeqnZCUzrxKMzw+zDMguWkFgkVrFd
	sS+nc86w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41522)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTJXK-00075Q-1s;
	Tue, 08 Aug 2023 11:01:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTJXF-0007zI-RY; Tue, 08 Aug 2023 11:01:53 +0100
Date: Tue, 8 Aug 2023 11:01:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	hkallweit1@gmail.com, Jose.Abreu@synopsys.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 1/7] net: pcs: xpcs: add specific vendor
 supoprt for Wangxun 10Gb NICs
Message-ID: <ZNISkaXBNO5z6csw@shell.armlinux.org.uk>
References: <20230808021708.196160-1-jiawenwu@trustnetic.com>
 <20230808021708.196160-2-jiawenwu@trustnetic.com>
 <ZNIJDMwlBa/LRJ0C@shell.armlinux.org.uk>
 <082101d9c9dd$2595f400$70c1dc00$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <082101d9c9dd$2595f400$70c1dc00$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 05:46:03PM +0800, Jiawen Wu wrote:
> On Tuesday, August 8, 2023 5:21 PM, Russell King (Oracle) wrote:
> > On Tue, Aug 08, 2023 at 10:17:02AM +0800, Jiawen Wu wrote:
> > > Since Wangxun 10Gb NICs require some special configuration on the IP of
> > > Synopsys Designware XPCS, introduce dev_flag for different vendors. The
> > > vendor identification of wangxun devices is added by comparing the name
> > > of mii bus.
> > >
> > > And interrupt mode is used in Wangxun devices, so make it to be the first
> > > specific configuration.
> > >
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > 
> > Does the XPCS in Wangxun devices have the device identifiers (registers
> > 2 and 3) and the package identifiers (registers 14 and 15) implemented,
> > and would they be set to an implementation specific value that would
> > allow their integration into Wangxun devices to be detected?
> > 
> > If the answer to that is yes, it would be preferable to use that
> > rather than adding a bitarray of flags to indicate various "quirks".
> 
> It has not been implemented yet. We could implement it in flash if it's wanted.
> But it would require upgrading to the new firmware.

Andrew, do you any opinions? Do you think it would be a good idea to
use the device/package identifiers, rather than a bitfield of quirks?

> BTW, how do we make sure this value doesn't conflict with other device vendors?

PHY identifiers are based on the OUI (which is the same as what gets
used in the first three bytes of MAC addresses).

For example, Marvell is 00:50:43, which is in binary:

	0000 0000 0101 0000 0100 0011

Their PHY IDs are generally 0x01410c00-0x01410fff, which is in binary:

	0000 0001 0100 0001 0000 11xx

and if we shift the OUI by two bits to the right, we end up with the
number in the PHY.

802.3 22.2.4.3.1 says:

The PHY Identifier shall be composed of the third through 24th bits of
the Organizationally Unique Identifier (OUI) assigned to the PHY
manufacturer by the IEEE,1 plus a six-bit manufacturer’s model
number, plus a four-bit manufacturer’s revision number.

45.2.1.3 PMA/PMD device identifier (Registers 1.2 and 1.3)

...
The identifier shall be composed of the 3rd through 24th bits of the
Organizationally Unique Identifier (OUI) assigned to the device
manufacturer by the IEEE, plus a six-bit model number, plus a four-
bit revision number.

A PMA/PMD may return a value of zero in each of the 32 bits of the
PMA/PMD device identifier to indicate that a unique identifier as
described above is not provided.

The format of the PMA/PMD device identifier is specified in 22.2.4.3.1.

45.2.1.13 PMA/PMD package identifier (Registers 1.14 and 1.15)

...
The identifier shall be composed of the 3rd through 24th bits of the
Organizationally Unique Identifier (OUI) assigned to the package
manufacturer by the IEEE, plus a six-bit model number, plus a four-bit
revision number. A PMA/PMD may return a value of zero in each of the 32
bits of the package identifier.

A non-zero package identifier may be returned by one or more MMDs in
the same package. The package identifier may be the same as the device
identifier.

The format of the package identifier is specified in 22.2.4.3.1.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

