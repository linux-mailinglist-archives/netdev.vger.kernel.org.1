Return-Path: <netdev+bounces-180398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B0A81347
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE88E8A0F69
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670322FF4D;
	Tue,  8 Apr 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Thl8a6CF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14669191F79;
	Tue,  8 Apr 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132334; cv=none; b=WHSrdq5eTW33GI95FF5vFiA+oHVk+AyWLqCBiWmf2wp9ekc7Rvu+lFE7STxpHIPj/5CQ51vn0d7BWJmMlGwHsir1FAh0BJ5wKiZRTVTx1sNn5GNFpiTLmkRlfatH4Q2QYAfdkHWdq0n+wAxuNp5du4qIIZcRfwVKKwqlbcBfRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132334; c=relaxed/simple;
	bh=yKY5XLQEaqSJSV4gfh0aXW5Po1rHXUMEGztGRA/gdT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hg1G6GDclFXuHo+cGz26DMo8UW14WPWNaQ2WgExF4s2qcAmM405gFnCl+HPsBT1Wv5VqdN/xmePe/TqrUuEWj9Ykb/Ydcd5VECFFb6pNSF0e8t23lYvRFfCJ4ybLbCLD3I2tbwlTOoikszFOOoIgRTTgrCX28o4J5XPtu2BojDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Thl8a6CF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WgUBUMAXSrDiu5o1PcM1WV7OFPo/LLnKaP5zQX3z7uw=; b=Thl8a6CF3918v/aF9zFB5adZio
	Upx9kX6X2TGqbZOlrrEmkO6BbcUr7dWBRiNlWgiawdpfa923pKwRYHCSWWHEOXSnvQzq3WbQ6qSfD
	GbagT2QFnh+i6cS1cElBnPsHV+rxjX4co/eLCmZmiITUij6kOEb8tMF4A6KfDNjjCX3NHGe2wk9wV
	SuGf+tir2ovNEk+zEAdnPMc5joE/htmKH+7pzMEy/idMRyMuxfim2+bczBiG+JbFlpVC563IsYWT/
	yWyJuUgJa1xG0GJTiiW7BvtMLMJPLJZOIf/rHLH05LG3NwfsWYakW1RriNeVVjPEAXUOLgBNJbQOL
	jLkBJ4cg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36344)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2CUH-0007o5-37;
	Tue, 08 Apr 2025 18:11:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2CUB-0001bM-2D;
	Tue, 08 Apr 2025 18:11:43 +0100
Date: Tue, 8 Apr 2025 18:11:43 +0100
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
Subject: Re: [net-next PATCH 2/2] net: phy: mediatek: add Airoha PHY ID to
 SoC driver
Message-ID: <Z_VYz6InC1p4vwku@shell.armlinux.org.uk>
References: <20250408155321.613868-1-ansuelsmth@gmail.com>
 <20250408155321.613868-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408155321.613868-2-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 08, 2025 at 05:53:14PM +0200, Christian Marangi wrote:
>  config MEDIATEK_GE_SOC_PHY
>  	tristate "MediaTek SoC Ethernet PHYs"
> -	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> -	depends on NVMEM_MTK_EFUSE || COMPILE_TEST
> +	depends on (ARM64 && (ARCH_MEDIATEK || ARCH_AIROHA)) || COMPILE_TEST
> +	depends on (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || ARCH_AIROHA || COMPILE_TEST

So...
COMPILE_TEST	ARM64	ARCH_AIROHA	ARCH_MEDIATEK	NVMEM_MTK_EFUSE	result
N		N	x		x		x		N
N		Y	N		N		x		N
N		Y	N		Y		N		N
N		Y	N		Y		Y		Y
N		Y	Y		x		x		Y
Y		x	x		x		x		Y

Hence this simplifies to:

	depends on ARM64 || COMPILE_TEST
	depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
		   COMPILE_TEST

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

