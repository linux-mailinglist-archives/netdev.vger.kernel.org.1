Return-Path: <netdev+bounces-235546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189DC32509
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E913B2A8A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EEB33890D;
	Tue,  4 Nov 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ehA3ziy6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FA3314B8;
	Tue,  4 Nov 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277034; cv=none; b=SctrkF/QRrkMmXRunniW09aVYNFoZZHDM1enw3R6h7awS7x2tqiFfCj4Pxrl1vBfU7uA9h1Ix4hof9nqryzR7NujGd3v10jslKzXxnq+NOmWdZ2hpFCt8DR2CMpv7ekKYFurhhjj/8H8bAKIYXOXWfOU0aDWsaJvVdDSN4KMRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277034; c=relaxed/simple;
	bh=pD2MQW5E9wBLde0Da2d1YqABTFktIUAkDgBpg3i3akg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDFmF2Px/IixUH2wDe06S3ehMn2QsZb1exID0nfj2iiH3ZSDG2p4xUBxzA3UuTPovRPjvtV8nkAcoNU1u0460x9ZeArkZUqbcO3GnTHPw0v6KgzyM3KWfatGrAvKE9Qulwer02VS2COlHQ3uzBTVz6aCA7yss/cOryABOssGlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ehA3ziy6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uoB88gePyn7EykNE2T4YKlK7EtZuZ8kWw0N1UXqrqGY=; b=ehA3ziy6OlYUSzUiWgGRLKiB0E
	jH6vg56AYNS4IhQjblWh2RxaCW/QLTx4ARSYwhJzWZYSCe0RfYtu3Zf7Eo+8BzpeUCIZCchENpv7Y
	Z8UCP0o3CX49+ZvSlH3jBi5NQuq/17YafJGRQOwthLrnQSi7m0NR+98TbJEVpl2FRdfaxvz/a72Ln
	h7KkERJBIlkoDo6e6sYMthLPRELf6DpS46FV2gzEJosWPeAzm/0UkrprZ+XYxOWXABGyX+zV9RTZM
	gAZuO96Dk6lo/NdFA4w+lXE9xd1T60DXpTqE8mt3tWCPY8URi89z8OqaiVapLMsBvo9CwhdAdMgkC
	nqyVnJIg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47338)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGKkr-000000002Sk-22Em;
	Tue, 04 Nov 2025 17:23:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGKkp-000000004vh-2pAY;
	Tue, 04 Nov 2025 17:23:35 +0000
Date: Tue, 4 Nov 2025 17:23:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: pci: Use generic PCI
 suspend/resume routines
Message-ID: <aQo2l-E9Z0tTJKlb@shell.armlinux.org.uk>
References: <20251104151647.3125-1-ziyao@disroot.org>
 <20251104151647.3125-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104151647.3125-4-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 04, 2025 at 03:16:47PM +0000, Yao Zi wrote:
> Convert STMMAC PCI glue driver to use the generic platform
> suspend/resume routines for PCI controllers, instead of implementing its
> own one.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  5 +--
>  .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++-----------------
>  2 files changed, 6 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 7ec7c7630c41..59aa04e71aab 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -378,8 +378,6 @@ config DWMAC_LOONGSON
>  	  This selects the LOONGSON PCI bus support for the stmmac driver,
>  	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
>  
> -endif
> -
>  config STMMAC_PCI
>  	tristate "STMMAC PCI bus support"
>  	depends on STMMAC_ETH && PCI

As per patch 2, this line can be removed.

Otherwise, looks good, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

