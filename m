Return-Path: <netdev+bounces-181752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E434A865B0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8521E1BA0201
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940B2690F8;
	Fri, 11 Apr 2025 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kvyphb6q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50B269AFB
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397047; cv=none; b=de8ylcNhHmpxgi9N+QVTcjrGc/a+piHgP3BDcQUFSiD/+W0vI9G9aM35oEtwZMRWMTnz0KQzS8SOpggmIzLOkEN4cZAwqs4LxddFZeeLqY3qgRZM+zTZo0ksDHL6oP/wGWHONvlM3eFMMq6kCDXKCn1lmc+p60FvuxiGShqIfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397047; c=relaxed/simple;
	bh=TXV5PXPIvfyZFbDp5xfpSQQMTwc1Bcupjl/bnbleNWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6aXhOlOKY8TVwFr37my079FxOywt6OVTWHM43QLyffB2/t/b9iojyIeC46ulKjJrkLV2unyReTJ5gi2simcB25HdCABuW9VqiszUi5s650guEjU1swpOyYi1ry2bP21ACkoGfPDOuYKzbQjcP0bDYckkEw5Gd2vFXqFhG478XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kvyphb6q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=54JCjDezK1dUGA4BE79HjK51DxJBAgkEma15PQoujG8=; b=kvyphb6qBfl9oZ+RfxE3UKoDn0
	xNtHI3QJ58t3rsn4alobFvloGASDei6PAhFq6/OPZw24/AfASOp4rmOiWpNdNNMcjCDo2f94h9KR8
	VHVL8TJOj8WcDkgT4dyC2brkTojNBXpHChhsFfK9GK4yPwXTveQSMxV0Dlg79R08j01GyVnymJgwt
	bjyikySlrBE73SsT2cC68tqM8bN5WLoHRPmLFj5nbSrFo6hs1cC3WubRNRKgAKwFVuHjUBdQjXa8G
	8WLaRVKW8X+NAsMFE/OCpKvtFNLx8LzsoTnAN5nGPgMUZCcv3f1Bm+bZx08NigQYCiPO7X5aQnzWU
	VMGCiz/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3JM9-0003ke-1m;
	Fri, 11 Apr 2025 19:44:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3JM8-0004po-0v;
	Fri, 11 Apr 2025 19:44:00 +0100
Date: Fri, 11 Apr 2025 19:44:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [BUG] unbinding mv88e6xxx device spews
Message-ID: <Z_li8Bj8bD4-BYKQ@shell.armlinux.org.uk>
References: <Z_lRkMlTJ1KQ0kVX@shell.armlinux.org.uk>
 <20250411180159.ukhejcmuqd3ypewl@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411180159.ukhejcmuqd3ypewl@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 11, 2025 at 09:01:59PM +0300, Vladimir Oltean wrote:
> On Fri, Apr 11, 2025 at 06:29:52PM +0100, Russell King (Oracle) wrote:
> > Hi,
> > 
> > Unbinding a mv88e6xxx device spews thusly:
> 
> Odd. I never saw this on the 6190 and 6390 I've been testing on, and I
> think I know why. Could you please confirm that the attached patch fixes
> the issue?

What else can go wrong... well, the build PC can inexplicably lose
power just before it transfers the kernel to the TFTP server and
modules to the target... yep, it's one of those days that if something
can go wrong it will go wrong. I'm expecting a meteorite to destroy
the earth in the next few minutes.

Your patch seems to fix that issue, so:

Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

but... of course there's another issue buried beneath:

[   73.552305] WARNING: CPU: 0 PID: 398 at net/dsa/dsa.c:1486 dsa_switch_release_ports+0x114/0x118 [dsa_core]
[   73.562504] Modules linked in: caam_jr ofpart caamhash_desc caamalg_desc reset_gpio tag_dsa crypto_engine cmdlinepart authenc libdes i2c_mux_pca954x lm75 at24 mv88e6xxx spi_nor mtd dsa_core eeprom_93xx46 caam vf610_adc error industrialio_triggered_buffer fsl_edma kfifo_buf virt_dma spi_gpio sfp spi_bitbang iio_hwmon sff mdio_mux_gpio mdio_i2c industrialio mdio_mux rpcsec_gss_krb5 auth_rpcgss
[   73.597676] CPU: 0 UID: 0 PID: 398 Comm: bash Tainted: G        W          6.14.0+ #966
[   73.597716] Tainted: [W]=WARN
[   73.597724] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
[   73.597737] Call trace:
[   73.597758] [<c0009c44>] (unwind_backtrace) from [<c0022b78>] (show_stack+0x10/0x14)
[   73.597849] [<c0022b78>] (show_stack) from [<c0019b5c>] (dump_stack_lvl+0x50/0x64)
[   73.597921] [<c0019b5c>] (dump_stack_lvl) from [<c0043cd4>] (__warn+0x80/0x128)
[   73.597986] [<c0043cd4>] (__warn) from [<c0043ee4>] (warn_slowpath_fmt+0x168/0x16c)
[   73.598034] [<c0043ee4>] (warn_slowpath_fmt) from [<bf0b8764>] (dsa_switch_release_ports+0x114/0x118 [dsa_core])
[   73.598297] [<bf0b8764>] (dsa_switch_release_ports [dsa_core]) from [<bf0b929c>] (dsa_unregister_switch+0x28/0x184 [dsa_core])
[   73.598654] [<bf0b929c>] (dsa_unregister_switch [dsa_core]) from [<bf105b30>] (mv88e6xxx_remove+0x34/0xbc [mv88e6xxx])
[   73.599326] [<bf105b30>] (mv88e6xxx_remove [mv88e6xxx]) from [<c066f838>] (mdio_remove+0x1c/0x30)
[   73.599577] [<c066f838>] (mdio_remove) from [<c05e15f8>] (device_release_driver_internal+0x180/0x1f4)
[   73.599666] [<c05e15f8>] (device_release_driver_internal) from [<c05df3bc>] (unbind_store+0x54/0x90)
[   73.599726] [<c05df3bc>] (unbind_store) from [<c02f9388>] (kernfs_fop_write_iter+0x10c/0x1cc)
[   73.599790] [<c02f9388>] (kernfs_fop_write_iter) from [<c02608a4>] (vfs_write+0x2a4/0x3dc)
[   73.599839] [<c02608a4>] (vfs_write) from [<c0260adc>] (ksys_write+0x50/0xac)
[   73.599876] [<c0260adc>] (ksys_write) from [<c0008320>] (ret_fast_syscall+0x0/0x54)
[   73.599912] Exception stack(0xe0b25fa8 to 0xe0b25ff0)
[   73.599940] 5fa0:                   00000010 024dd820 00000001 024dd820 00000010 00000001
[   73.599964] 5fc0: 00000010 024dd820 b6bb5d50 00000004 00000010 0055db68 00000000 00000000
[   73.599982] 5fe0: 00000004 bea469a0 b6b4e3fb b6ac7656
[   73.767849] ---[ end trace 0000000000000000 ]---
bash-5.0# [   74.466821] fec 400d0000.ethernet eth0: Graceful transmit stop did not complete!
[   74.474953] fec 400d0000.ethernet eth0: Link is Down

which seems to be due to:

                WARN_ON(!list_empty(&dp->vlans));

This is probably due to the other issue I reported:

[   44.485597] br0: port 9(optical2) entered disabled state
[   44.498847] br0: port 9(optical2) failed to delete vlan 1: -ENOENT
[   44.505353] ------------[ cut here ]------------
[   44.510052] WARNING: CPU: 0 PID: 438 at net/bridge/br_vlan.c:433 nbp_vlan_flu
sh+0xc0/0xc4

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

