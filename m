Return-Path: <netdev+bounces-146636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BAE9D4C99
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 13:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E31B23C2F
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08B1CDA18;
	Thu, 21 Nov 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iFgBnQ0v"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBC1A3BC8;
	Thu, 21 Nov 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191074; cv=none; b=uCFTPwGdndC+69evMiq5OU/JYumHepWdwFX3tpuQpuXPQeoc2/DitARHlAZSPtAuX29QPCcR/NMSvsqTScq6E/DofWEXkZu00KKKPMm1N0mnR2KQiCENx9O2nisx87zAYwrDqSB+8xjzTJSt4RiswCG1gFvnTFCB7cx4tV1Dvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191074; c=relaxed/simple;
	bh=UMPYmve7d2ZC3nE3ozdyoP2wMIe8R9hBXxVmfrWL+rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAvZ+mkW3JVQ3ATPNv+TGj9fW3OoxL1eq9h99m/gMpEoYvx+CTEulwBVW8PMFtIY9fK0I/LdkSnXv+SPND+OVsxfyCbOnnJh6WuyxFauWZ5YcyDnGl90VZ4xIddhMI48yJFKrIer5steXF53CNDMbfvydO0g3lK6PITneYuY9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iFgBnQ0v; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GysVpcCGGWGITDXTB3mUtg5c+hVY94+pYB53GjWWRO0=; b=iFgBnQ0vPrwYFofFH78TSkkq34
	Rw1zN4Xi7c6iTtevx2GM/KXg8Xh3aZ5joIEG7trhmchtRz/mW9AGOCpfr5f6VyMAMTWxR2I0YJiaw
	c6XQmuZ8DhYdwHQecoPTiqhtXTGz+yCWOIWLSGpwlXtgJ806SDC/WqTcczcu7A7kLqtcHbM3lM+zV
	y09S3IxDlDgeBUfa3LaqGbp8wxSpdAFLD08MgpiEUAnqRpW8MvQv6+0iFHky0ZCwsvQJ5pkTHwzSQ
	AF5RXSmSlNfrJb3WQlDOH/PpOsVJPJQ53aXgFa9/Eaj/55x8FDQrnhpDks3taJcGX791fd8u4++Ay
	1SYOdrdQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43548)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tE61Z-0007A2-1x;
	Thu, 21 Nov 2024 12:11:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tE61W-00082Y-25;
	Thu, 21 Nov 2024 12:11:02 +0000
Date: Thu, 21 Nov 2024 12:11:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Cong Yi <yicong.srfy@foxmail.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <Zz8jVmO82CHQe5jR@shell.armlinux.org.uk>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
 <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
 <20241121105044.rbjp2deo5orce3me@skbuf>
 <Zz8Xve4kmHgPx-od@shell.armlinux.org.uk>
 <20241121115230.u6s3frtwg25afdbg@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121115230.u6s3frtwg25afdbg@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 21, 2024 at 01:52:30PM +0200, Vladimir Oltean wrote:
> On Thu, Nov 21, 2024 at 11:21:33AM +0000, Russell King (Oracle) wrote:
> > On Thu, Nov 21, 2024 at 12:50:44PM +0200, Vladimir Oltean wrote:
> > > On Wed, Nov 20, 2024 at 05:46:14PM +0800, Cong Yi wrote:
> > > > Hi, Russell King:
> > > > 
> > > > Thank you for your reply!
> > > > Yes, as you say, there is no problem with the definitions themselves
> > > > being named. When I just read from Linux-5.4 to 6.6, I thought
> > > > that PCS_STATE_ and PHYLINK_DISABLE- were associated in some way.
> > > > After reading the code carefully, I found that there was no correlation。
> > > > In order to avoid similar confusion, I sent this patch.
> > > 
> > > For the record, I agree that tying together unrelated constants inside
> > > the same anonymous enum and resetting the counter is a confusing coding
> > > pattern, to which I don't see the benefit. Separating them and giving
> > > names to the enums also gives the opportunity for stronger typing, which
> > > was done here. I think the patch (or at least its idea) is ok.
> > 
> > See include/linux/ata.h, and include/linux/libata.h.
> > 
> > We also have many enums that either don't use the enum counter, or set
> > the counter to a specific value.
> > 
> > The typing argument is nonsense. This is a common misconception by C
> > programmers. You don't get any extra typechecking with enums. If you
> > define two enums, say fruit and colour, this produces no warning,
> > even with -Wall -pedantic:
> > 
> > enum fruit { APPLE, ORANGE };
> > enum colour { BLACK, WHITE };
> > enum fruit get_fruit(void);
> > enum colour test(void)
> > {
> > 	return get_fruit();
> > }
> > 
> > What one gets is more compiler specific variability in the type -
> > some compiler architectures may use storage sufficient to store the
> > range of values defined in the enum (e.g. it may select char vs int
> > vs long) which makes laying out structs with no holes harder.
> 
> Well, I mean...
> 
> $ cat test_enum.c
> #include <stdio.h>
> 
> enum fruit { APPLE, ORANGE };
> enum colour { BLACK, WHITE };
> 
> enum fruit get_fruit(void)
> {
> 	return APPLE;
> }
> 
> enum colour test(void)
> {
> 	return get_fruit();
> }
> 
> int main(void)
> {
> 	test();
> }
> $ make CFLAGS="-Wall -Wextra" test_enum
> cc -Wall -Wextra    test_enum.c   -o test_enum
> test_enum.c: In function ‘test’:
> test_enum.c:13:16: warning: implicit conversion from ‘enum fruit’ to ‘enum colour’ [-Wenum-conversion]
>    13 |         return get_fruit();
>       |                ^~~~~~~~~~~
> 
> I don't understand what's to defend about this, really.

It's not something I want to entertain right now. I have enough on my
plate without having patches like this to deal with. Maybe next year
I'll look at it, but not right now.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

