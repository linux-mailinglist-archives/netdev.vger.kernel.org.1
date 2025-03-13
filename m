Return-Path: <netdev+bounces-174604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4823CA5F764
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BC019C2933
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE51267AFF;
	Thu, 13 Mar 2025 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="THDjI0F/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7A267B1D
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875310; cv=none; b=OY6b5dKwNvGdUKaOZNtibh8RXvadfAUfa45cD7ni/kJAdVlTL0H+FSvsVCgS08+nnPKlh/6N2FiXOneRSXYgiJ5HlaP8QxdAUTMbYu3PbiOMaQ2lgvXORh7DpMbDtIX4DWkGr20D3nBma6MKQBHmSzZKVCKsqxBRUD49Wng/C9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875310; c=relaxed/simple;
	bh=Vv/8ofuuuidBtlvG6qVkvAhuC2vPSuGw7CFoPP6KKPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L20RQJJIRAvQ5U6x8KXro0xW7ffxdCIdIySifJFtTzX89Nfov7BvTKRJyl2tZt/vKd4s3Xjh7SF6P8mzzmx0HzNO4NwL9JKC+nCKsjhXGvAzsKwsdX6/MHalDDpnBsJMnkN5EuWUJaSvlqJ5fGaW77cz/+35HeeQeole3olgc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=THDjI0F/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4dZ4lVMFY++cOCuYzefY8VkNKoiiIOI5l8bWOsaY1aU=; b=THDjI0F/9sFZ2xLwBQNcWXDQ0m
	xNRlVcdtlm0niu4EhfjShLw7PcW4TMt/tjQApy7ndwDxTdxVFu5Fxi6lsWPEMml5QNrMA60+oAyd9
	OZNCtuI2I21j/HFQQgrp7af+BJAf+Pwe1XWKuLam5WmEBwUHMSY2jWl1doUF0E2Ft83QIyiPO0rtl
	NKgQVnnKx/wRQN+z1Fj3utCBRAexb2Q/UALza48dP39pccqlqkf13jT6Z1SA5iiLR/GEskzR/IvbR
	zYDLUj8sNJpBmPDCdEG6PMhX8LQjnSVZmU2fQ2dgTJp/qL0RLoqC3U7t3x3RUrIgN1fsQtRNZ3WFl
	XnzymIcA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34500)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tsjKu-00076U-24;
	Thu, 13 Mar 2025 14:15:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tsjKs-0005dN-1t;
	Thu, 13 Mar 2025 14:14:58 +0000
Date: Thu, 13 Mar 2025 14:14:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>
Subject: Re: [PATCH net 00/13] Fixes for mv88e6xxx (mainly 6320 family)
Message-ID: <Z9LoYsOCWT-YUPXZ@shell.armlinux.org.uk>
References: <20250313134146.27087-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313134146.27087-1-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Overall, your patch descriptions talk about "forgot to". Realistically,
it's probably "don't know about this switch because we don't have
access to the documentation so best leave it alone"

On Thu, Mar 13, 2025 at 02:41:33PM +0100, Marek Behún wrote:
> Hello Andrew et al.,
> 
> This is a series of fixes for the mv88e6xxx driver:
> - one change removes an unused method
> - one fix for 6341 family
> - eleven fixes for 6320 family
> 
> Marek
> 
> Marek Behún (13):
>   net: dsa: mv88e6xxx: remove unused .port_max_speed_mode()
>   net: dsa: mv88e6xxx: fix VTU methods for 6320 family
>   net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
>   net: dsa: mv88e6xxx: allow SPEED_200 for 6320 family on supported
>     ports
>   net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
>   net: dsa: mv88e6xxx: enable PVT for 6321 switch
>   net: dsa: mv88e6xxx: define .pot_clear() for 6321
>   net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family
>   net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
>   net: dsa: mv88e6xxx: enable devlink ATU hash param for 6320 family
>   net: dsa: mv88e6xxx: enable STU methods for 6320 family
>   net: dsa: mv88e6xxx: fix internal PHYs for 6320 family
>   net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320
>     family
> 
>  drivers/net/dsa/mv88e6xxx/chip.c | 68 ++++++++++++++++++++++----------
>  drivers/net/dsa/mv88e6xxx/chip.h |  4 --
>  drivers/net/dsa/mv88e6xxx/port.c | 55 +++++++-------------------
>  drivers/net/dsa/mv88e6xxx/port.h | 11 +-----
>  4 files changed, 64 insertions(+), 74 deletions(-)
> 
> -- 
> 2.48.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

