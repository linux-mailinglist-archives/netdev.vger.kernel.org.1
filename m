Return-Path: <netdev+bounces-215718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD0B2FFF0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58101BC7E20
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5526D2DCF64;
	Thu, 21 Aug 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GEdi2ijP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD51EB5FE;
	Thu, 21 Aug 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793257; cv=none; b=do2apqzz0x2hQSw+oHVVdPGCiOQlLytOCSJGBiId40w384gb57WJezkRz5fDErCBHIHbyYuxxoV0h2vZ2mOO9rsRw3E3uWNnYASZyBz4e9+bu9v7W4og5JWFiRlSO0ccFic8Xd4sdkvdzymzHsB6/fbqTm2hwyXYLXg94yhhXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793257; c=relaxed/simple;
	bh=SVYwBgrxF+fidYXx6MB+GC/1PI3+tc6tVk4REki5cYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4bHkLoQU4WBjbvgDTanmUbpMyc7EHPpFOppV2rXbHKEuk8a+FEchPCuomKgE7gyHItE7NuvGRWhKf/nthoP5uasALab7cVR+6xKsCoDbExGUv9knLynyHlR5ChQjH9GIenHmm561b2bETHJPNIcGDtV8a1spQlyhx1N9hvqKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GEdi2ijP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m7VDrV4gseJewWjqTqtmSwKWWM5SD7kbK2phRQT7nvc=; b=GEdi2ijP61fiZSHA03/ojnalrN
	pvheXNil2dDNacnh1emry1xQD/tcKAfwBagMhCPM9r7+fri1IRibjRhhXppH505BrRqMd2qU/m8JD
	iyPn9+MJxyypgzI6Puvfxa2rtcvZgpHSYgQ+jusRjpKrklx/0j7xa8qndpGk2mMACmzg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up81u-005TV9-1I; Thu, 21 Aug 2025 18:20:46 +0200
Date: Thu, 21 Aug 2025 18:20:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH net-next 02/15] net: phy: aquantia: merge
 aqr113c_fill_interface_modes() into aqr107_fill_interface_modes()
Message-ID: <e0e40c1f-26e3-41aa-8db3-5757c69f0310@lunn.ch>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
 <20250821152022.1065237-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821152022.1065237-3-vladimir.oltean@nxp.com>

On Thu, Aug 21, 2025 at 06:20:09PM +0300, Vladimir Oltean wrote:
> I'm unsure whether intentionate or not, but I think the (partially
> observed) naming convention in this driver is that function prefixes
> denote the earliest generation when a feature is available. In case of
> aqr107_fill_interface_modes(), that means that the GLOBAL_CFG registers
> are a Gen2 feature. Supporting evidence: the AQR105, a Gen1 PHY, does
> not have these registers, thus the function is not named aqr105_*.

That is reasonably common. The Marvell PHY and DSA driver use the
same.

The other option would be to use gen1_, gen2_, gen3_ prefixes.

The Broadcom PHY uses an odd naming scheme, 28nm_, 16nm_, which i
assume is the silicon gate size of the generation.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

