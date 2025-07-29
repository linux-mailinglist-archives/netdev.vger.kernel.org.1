Return-Path: <netdev+bounces-210817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6046AB14F10
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3B2188C97D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49421A2872;
	Tue, 29 Jul 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JxI2ArVC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E411C5F2C
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798067; cv=none; b=sdPg0yjf/avk8DPFCWDIN7Hp+lRN/Zc8SiAMPH4xKVDvg9kzsHHoOjTenOnH1cS5Xfb3UlqIL4UcMNFkgOxFWeCkwYOzB+9A4+hpDwhjgtaR7A7ZHtk4EqAuon/g57KOu2kX5TeGNDojAGmG8GXiAFZX39lGwQpyAj8VxGrs5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798067; c=relaxed/simple;
	bh=b8pDGxgyQegA7MFTl/5kup/XGvmwb0FbNjwHR7tUD5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfXCwEuVDm2QXFDrjpFDQZQ/K7ocqgoMCsIRAQ1f9CUUMZpwMDjwiAHNTjypNkZMlymaDCnvl02pp3BWnTVCjujBeCzsSS2dWBzYDOyPnMEnKkFmpek1jjv5KeQJMGNeIbuQB23cRwetusOlJsb1DzmLSttLLaiQFYJatINnqvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JxI2ArVC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HxcCCT+DpV6mHtYl/0ThZTB92RM1TjmK0KzEYFsynx4=; b=JxI2ArVCfKf+C4vm2KuhgS3BUg
	N8TILxOut0FKmyW4Y1kjQzD3ylU9UKHohBTz+F5kAosAacNfliJwz0uiYNCasT2FGGPYDnvX5ICK6
	xsAMpE1A24CBLf8IEVe13EJli0dTXcA3eByWvHc+VmYovItm7mxmZxtR0znXa+D5MNqk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugkzX-003CSZ-Pg; Tue, 29 Jul 2025 16:07:43 +0200
Date: Tue, 29 Jul 2025 16:07:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: gwoodstccd <gwoodstccd@protonmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: xilinx xgmiitorgmii couldn't find phydev
Message-ID: <e7312a29-83cc-43b3-b1ab-ce2d0e5b58b5@lunn.ch>
References: <i9eEFizCsfRsZPSDz9HqVDN_YZuGmNadYIE44uhLWQJzUDE2qmO5P4Rco5MYwcipDQT-FsEchEvKUZsWIZhk8j9zQFIBri_yxNHFBgoKX2Y=@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i9eEFizCsfRsZPSDz9HqVDN_YZuGmNadYIE44uhLWQJzUDE2qmO5P4Rco5MYwcipDQT-FsEchEvKUZsWIZhk8j9zQFIBri_yxNHFBgoKX2Y=@protonmail.com>

On Tue, Jul 29, 2025 at 09:40:24AM +0000, gwoodstccd wrote:
> Hello,
> 
> I'm newbie for netdev.
> 
> Xilinx's ZynqMP GEM2 uses EMIO and gmii2rgmiii converter for PHY connections. Hardware guys confirmed it can work under bare metal mode.
> But GEM2 is reported 'xgmiitorgmii Couldn't find phydev' error during kernel boot, and ping command failed.
> 
> Could some nice guy help me to fix this issue? Thanks in advance.
> 
> the kerner version is 6.12, the kernel is from 
> https://github.com/Xilinx/linux-xlnx/releases/tag/xilinx-v2025.1
> 
> [    7.285666] xgmiitorgmii ff0d0000.ethernet-ffffffff:08: Couldn't find phydev
> [    7.292490] macb ff0d0000.ethernet eth2: Cadence GEM rev 0x50070106 at 0xff0d0000 irq 47 (00:0a:35:00:01:22)
> [   33.315143] macb ff0d0000.ethernet eth2: unable to generate target frequency: 25000000 Hz
> 
> device tree is 
> 
> &gem2 {
>     phy-handle = <&extphy0>;

I've never used this converter myself, but try having phy-handle point
to the converter, not the PHY.

>     xlnx,has-mdio = <0x1>;
>     local-mac-address = [00 0a 35 00 01 22];
>     status="okay";
>     phy-mode = "gmii";
>     fixed-link {
>         speed = <100>;
>         full-duplex;
>     };

I don't think you need a fixed-link. The converter should be able to
report the link speed of the PHY.

	Andrew

