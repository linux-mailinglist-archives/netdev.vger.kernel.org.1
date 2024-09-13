Return-Path: <netdev+bounces-128107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A899780C7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196231F24F9B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C111D9339;
	Fri, 13 Sep 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hj/JYQyF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F919F415
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233103; cv=none; b=ldgJcRLKbAsN8F9ULpe2FP/eK/9xoMRqUjQp0rid3UQn+7aIm+PUPo/I3Wuk7TYZfrb/j1ARnE2CUCCZL7XbzLApmukK9bVZwhludes+s5c5szV2YdGHYce0fs1w8GzzghoNLpdJcBfpEk/ozY+kFJS0lj0BB7uL0dP1jdcf3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233103; c=relaxed/simple;
	bh=cDPtjMuuk/qx6XqkUfSD6MX3nF2r4irS45wxJ72/W5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ51MHaxwzR4fadJHF4RATN7tvgq2TweBMvfA9+qKe9qF+TikN/VZGQEMMnc8P6SU6lmW6hfGOUJ6oUcYcdpDX6rUHtvnkWXUYKLJw9x5uYxSwC2TzQyZRS5M34awtsIqzNrvq3ENJaVGK84XNm8KV08zjD5ziC+1QZSDl/VPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hj/JYQyF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e7TYD6HUbF5KFXNcIX7a9VXGqGts0Zq5d+pIuD1FtaM=; b=hj/JYQyFuxhQVLokf8Q4GDp0LW
	SHX+mAAmGeqSttwMeBZvviKqrajwrL+0+fLC+Kr/VBM2UptU2btDdNNmTriarbda9b2Rz4SOa4wXm
	el991rff369YF8BmPt7JHocU4vFVgan2iUtH06OMdd1OKXeW/ybrD8fa7MNoWolXU/D0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sp5gc-007OJg-83; Fri, 13 Sep 2024 14:46:06 +0200
Date: Fri, 13 Sep 2024 14:46:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: hfdevel@gmx.net, netdev@vger.kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 5/5] net: tn40xx: register swnode and connect it
 to the mdiobus
Message-ID: <04d22526-205b-4a59-b344-5bafdb9ce37f@lunn.ch>
References: <trinity-e71bfb76-697e-4f08-a106-40cb6672054f-1726083287252@3c-app-gmx-bs04>
 <20240913.065543.2091600194424222387.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913.065543.2091600194424222387.fujita.tomonori@gmail.com>

> >  #define TN40_MDIO_CMD_READ BIT(15)
> > 
> > +#define AQR105_FIRMWARE "tehuti/aqr105-tn40xx.cld"
> 
> This firmware is for AQR PHY so aquantia directory is the better
> place?

I don't know the correct answer to this. One thing to consider is how
it gets packaged.

on my Debian system:

p   firmware-adi                                             - Binary firmware for Analog Devices Inc. DSL modem chips (dummmy pac
i   firmware-amd-graphics                                    - Binary firmware for AMD/ATI graphics chips                         
p   firmware-ast                                             - Binary firmware for ASpeed Technologies graphics chips             
p   firmware-ath9k-htc                                       - firmware for AR7010 and AR9271 USB wireless adapters               
p   firmware-ath9k-htc-dbgsym                                - QCA ath9k-htc Firmware ELF file                                    
p   firmware-atheros                                         - Binary firmware for Qualcomm Atheros wireless cards                
p   firmware-b43-installer                                   - firmware installer for the b43 driver                              
p   firmware-b43legacy-installer                             - firmware installer for the b43legacy driver                        
p   firmware-bnx2                                            - Binary firmware for Broadcom NetXtremeII                           
p   firmware-bnx2x                                           - Binary firmware for Broadcom NetXtreme II 10Gb                     
p   firmware-brcm80211                                       - Binary firmware for Broadcom/Cypress 802.11 wireless cards

It seems to get packaged by vendor. Given the mess aquantia firmware
is, we are going to end up with lots of firmwares in firmware-aquantia
which are never needed. If the firmware is placed into tehuti,
installing firmware-tehuti gives you just what you need.

So i can see the logic of tehuti/aqr105-tn40xx.cld

	Andrew

