Return-Path: <netdev+bounces-193381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 732F0AC3B83
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B68C1895150
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8211C5D61;
	Mon, 26 May 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vv6k3Obm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818B13BC3F;
	Mon, 26 May 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247607; cv=none; b=I+yb0IhGwhvsyE/NPOS0UteFfgGZinjgtulshkQqhhbiOCJyUOjZmPsfEXYXp+Rl+MuQtQqNE+dnHm/SYRa5dUnSj6qcK3hI+IoC5TNTYbGdPuz6K3MZslms27FXJ04v+gmA3Fg7pPJFgMmImTaSczaY1CTY+Ov7byTvjXCQUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247607; c=relaxed/simple;
	bh=1XBov8LKCCh3CXoBRsiUyshAPN3tdk9qVy0hUvJ1KyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE+Dn/yt/F+5qT0J10eEzxZh1/JCQKZERLrV5tcQ/tl5vp9S2FksmZDzuVkA/4LgFGfogFcQau0qJE3MdXBEXAUaV1e8teMbLsRgCavKSdq58K9HLHIQRSrhER+AtIlxySLeS/VBOMwDTIUxZvfG9iYuaejKlAqCowictta51k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vv6k3Obm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RbR8wNWzK8yk4bknHCAW6sX5XZ5jnzKaNd3Odaryp2c=; b=Vv6k3Obm93JVskdS9j3mndnvWB
	K9UTQyl2EuE2O6dFYef6+u9w4kJ3+H0AkTnRx4tmIT82OjHXqqOZdBNOzdIqUcu2zzXZoqFrU6tDb
	Sj10hrpXMsTyOBxrBXnbma3ZwOkRf+/lzfQQOin1texHcqz2wdxla/PQRxOTw01M8Quc+FWRd9UDk
	JW0tbQyzcB/WOM873gicAc2ozW5tf/cMGX7IPTzeOmIQJgQFHN9JhKZzp/4W7gMRHEsxSamXCHCSG
	+aI1jkdiRvAl0FvwyINr/b3+ERcmcq21gt88QqCQIcV6Y94VohRRPnvmtkMDwPmdUEVua3QYxrMSe
	ioOkDLfQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56448)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uJT3v-0006WT-1s;
	Mon, 26 May 2025 09:19:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uJT3t-0000HA-2U;
	Mon, 26 May 2025 09:19:57 +0100
Date: Mon, 26 May 2025 09:19:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Add c45_phy_ids sysfs entry
Message-ID: <aDQkLcfeu8zw8CJ_@shell.armlinux.org.uk>
References: <20250523132606.2814-1-yajun.deng@linux.dev>
 <2eec1d17-a6d1-4859-9cc9-43eeac23edbd@lunn.ch>
 <fad26dc95cbe08a87b30d98a55b7e3d987683589@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad26dc95cbe08a87b30d98a55b7e3d987683589@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 26, 2025 at 08:11:21AM +0000, Yajun Deng wrote:
> c45 device:
> $ ls /sys/class/net/eth0/phydev/
> attached_dev  driver  of_node         phy_id         power       subsystem
> c45_phy_ids   hwmon   phy_has_fixups  phy_interface  statistics  uevent
> 
> $ ls /sys/class/net/eth0/phydev/c45_phy_ids
> mmd10_device_id  mmd17_device_id  mmd23_device_id  mmd2_device_id   mmd7_device_id
> mmd11_device_id  mmd18_device_id  mmd24_device_id  mmd30_device_id  mmd8_device_id
> mmd12_device_id  mmd19_device_id  mmd25_device_id  mmd31_device_id  mmd9_device_id
> mmd13_device_id  mmd1_device_id   mmd26_device_id  mmd3_device_id
> mmd14_device_id  mmd20_device_id  mmd27_device_id  mmd4_device_id
> mmd15_device_id  mmd21_device_id  mmd28_device_id  mmd5_device_id
> mmd16_device_id  mmd22_device_id  mmd29_device_id  mmd6_device_id

I suspect you don't have a PHY that defines all these IDs. Are you sure
your .is_visible() is working properly?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

