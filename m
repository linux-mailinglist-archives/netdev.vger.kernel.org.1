Return-Path: <netdev+bounces-180412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A98A81427
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D28C3A7AD4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF08235374;
	Tue,  8 Apr 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="02S55y8C"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914022F392;
	Tue,  8 Apr 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135082; cv=none; b=cZzWrRlTT7cTKSpwK1xqoYXUCOB2N9TnMV2TDf35z1SHU9CvLuFdSxAniDWBuZnaGnfFtDMVnf5LElHG5ljjEjWVW8wQq42Bv/drCmNErINBfUusbxSRjnP00h/zNVclx2iXXeD8j8kcQk1peWxqbYSJXfiwhzl2HmMNKRj57Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135082; c=relaxed/simple;
	bh=W76u3nFoua6vKbckOHw4MQewb3tXd9GfMkljz4/Hul8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJNQxAiJkoysRQAJf3TM2rUAj2ywAtsLet/cvtkT5x+vGt1fNNAmpKk5GWCFwU/VepEhdMCeqgRvctt9frfkmShkkawhDEmt1F4NM04xdLmzG14wOljhj4qVLXF1E0/BVK1aBvONi3jDLcAHPT3URK5DXS0jPmnQ8Y2sLxY4IJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=02S55y8C; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=chJQd/x3TDW3v8jq2xVO4tzD8MeEWuj7YPs7yTPdQh8=; b=02S55y8CW7SPGPnlOrMHC/7Ped
	uuuD5/vQiHyLAwkJHjIY55/FRxedXYGGT8HcmkhR+6jt3UxyodnnvyxwXy7Q10bKOYzIFIArAdwls
	J7/0ndNjdCXEKcBJflrMKYR++oiS2sKobOylmyscPc+pmjifLv3DxKEXlevsY7yWdRJvFF7q6cxJK
	g/+yW0q4jVIk25dgYQwqUFhOErzm1lGsZEx6nqmBxHZbD3hrs6w59yvq11bO7Bz/bbl0E8rB6zVq8
	PMtwjQtoXoO5jw3TjGKevV/CN0Q8i9XSjaflZlRgZZGV2RHtso9WkOVQZzQqK1aRKY5YoXFYyJ2nM
	DOIeLhfg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55812)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2DCj-0007sz-2W;
	Tue, 08 Apr 2025 18:57:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2DCg-0001cy-1T;
	Tue, 08 Apr 2025 18:57:42 +0100
Date: Tue, 8 Apr 2025 18:57:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.or
Subject: Re: [net-next PATCH 1/2] net: phy: mediatek: permit to compile test
 GE SOC PHY driver
Message-ID: <Z_VjljzFAa8gf5Cd@shell.armlinux.org.uk>
References: <20250408155321.613868-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408155321.613868-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 08, 2025 at 05:53:13PM +0200, Christian Marangi wrote:
>  config MEDIATEK_GE_SOC_PHY
>  	tristate "MediaTek SoC Ethernet PHYs"
>  	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> -	depends on NVMEM_MTK_EFUSE
> +	depends on NVMEM_MTK_EFUSE || COMPILE_TEST

Isn't this equivalent to:

	depends on (ARM64 && ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || COMPILE_TEST

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

