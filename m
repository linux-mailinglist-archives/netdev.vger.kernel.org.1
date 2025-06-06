Return-Path: <netdev+bounces-195484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A321DAD0705
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3560A189AFCF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682062882A8;
	Fri,  6 Jun 2025 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f7nW335d"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442A27CB02
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228668; cv=none; b=Ey9RF3G0uS3wA6AOUNVs7NMPV6P0ogUoeSUvqgRiVNvTBQeehdFD2wZOb4qQEvFVfG+RVewk+AZhdUUFQYuHcGqWihvk+1odBUNDEY1ncZ61EpqLyJm0y+bQP5kSyhoRsOkHWbuZfbxGwl7bAxgCIZf+tfsY0e0Y8UzSjlh8oB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228668; c=relaxed/simple;
	bh=JP5WVbuwjUDUeJbWnjJjp5yhOySBGJwQSIVmMzCOTWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1q1rZKz5F+oVRSNgyO6mzXhI8Wjg0KXZ5GbRBf/HPMbhTY9JZvITft85x1tgrce5ngPpsNZINXkLc22QxS6FlnxiLQWKz/eS5FrOAjxJ65lvPTiFuqXT0AeHIluJQyblpw7VFI12Q0J28ObqAyEiijk1tUDMs+i2Ti+7GkDGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=f7nW335d; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nwHPR4Qv7KA7mCHqCORT3cZMl5wWKWh1yYzC8N/3lSc=; b=f7nW335dMvPiUNNgBoW+3yuiLi
	zw+MttZN13DzW1CNpGjy2zVOfzxuPmb8dwFRYRkfodMGEq/WnCIO5dCPGJ+KB2+R66DwapRk6GkrQ
	9UL0s8lKwzLVPM4JSY3Ykuhu0dFedbCw/kdQ8iLHoyjjwiJbTNVm2yCa64Yu5BcSDKqRsKmoZ/Tgi
	mcZtLYmnEMTL0a7DIYjkKMLjt6A3G/HyL2PTrwn2oOPYCsAcSCONbKx45VxMgs6IyJrjKu+jJTpBA
	fcXk00xxBTA/6T7v5vRX+asRsgpIo3CIUM6Ty/AoP/w4oBcAxa/beRaUVLzVGvKvBuJvGHAZLt5ly
	7enuoYCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49510)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uNaHX-00011E-0d;
	Fri, 06 Jun 2025 17:51:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uNaHV-0003N9-2w;
	Fri, 06 Jun 2025 17:51:01 +0100
Date: Fri, 6 Jun 2025 17:51:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chris Morgan <macroalpha82@gmail.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID: <aEMcdcnY6CwEvOBZ@shell.armlinux.org.uk>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
 <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 06, 2025 at 09:44:48AM -0500, Chris Morgan wrote:
> On Fri, Jun 06, 2025 at 02:53:46PM +0200, Andrew Lunn wrote:
> > On Thu, Jun 05, 2025 at 09:22:03PM -0500, Chris Morgan wrote:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add quirk for Potron SFP+ XGSPON ONU Stick (YV SFP+ONT-XGSPON).
> > > 
> > > This device uses pins 2 and 7 for UART communication, so disable
> > > TX_FAULT and LOS. Additionally as it is an embedded system in an
> > > SFP+ form factor provide it enough time to fully boot before we
> > > attempt to use it.
> > > 
> > > https://www.potrontec.com/index/index/list/cat_id/2.html#11-83
> > > https://pon.wiki/xgs-pon/ont/potron-technology/x-onu-sfpp/
> > > 
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > ---
> > > 
> > > Changes since V1:
> > >  - Call sfp_fixup_ignore_tx_fault() and sfp_fixup_ignore_los() instead
> > >    of setting the state_hw_mask.
> > 
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> > 
> > You are supposed to wait 24 hours before posting a new version. We are
> > also in the merge window at the moment, so please post patches as RFC.
> 
> Sorry, I'll make sure to slow down the commits moving forward.
> 
> > 
> > Russell asked the question, what does the SFP report about soft LOS in
> > its EEPROM? Does it correctly indicate it supports soft LOS? Does it
> > actually support soft LOS? Do we need to force on soft LOS? Maybe we
> > need a helper sfp_fixup_force_soft_los()?
> 
> So I'm a bit out of my element here and not sure how to check that. I
> bought this module and had a hell of a time getting it to work on my
> Banana Pi R4 because of the UART triggering repeated tx faults. After
> applying these updates I was able to get it to work, so I figured it
> would be a courtesy to upstream these for others not to suffer. I was
> going to get this upstreamed, then request OpenWRT backport the fix,
> then move this device to replace my current router (which might be why
> I am guilty of rushing, sorry again). That said, I'm not sure how to
> check if the module supports soft LOS or not. I did a dump with
> ethtool -m but didn't see any references to LOS. Is there a bit on the
> EEPROM I can check?

Please send me (privately) the binary of:

ethtool -m ethX raw on > ethX.eeprom.bin

so I can see fully what it's reporting - I should then be able to make
further suggestions.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

