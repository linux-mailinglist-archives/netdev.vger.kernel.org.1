Return-Path: <netdev+bounces-235544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430DC324EB
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2237F349FA2
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81C33343E;
	Tue,  4 Nov 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NZU2jqni"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356013314B8;
	Tue,  4 Nov 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276995; cv=none; b=p5PCp1ROqvkmPudNVs03r6or6ISIdbuoQfczp+Bv/zCR+Yu3TfTIiK5HhbHTBpWYFSs20Brq7+j61ECBFV1NrJiJx5At2PF8BLXakcA927hqDZ4kWN+rIKgGvgynoqYuDiV3c84i1K3jH4RMAipcPLqikTWb8krYJFj+KCzH8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276995; c=relaxed/simple;
	bh=7xC9bNwLpibUkJxSmVmr7/bvvRh2GQnoAG6xFo/rxsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpNS8X5Nreo+3Oufqc9tD8S++04ySwgDTtfIQdh/87upYpf+PhOeE/j6wBRYry9jXTfQPV1BbvwFlg91rVaccnewbhcQKAHxzxA5XiUicuXQsepnymsR9dtrF7Pq4oIXtlaiFWuMWpD9VE6fwFAB1RzhYTwuWf8CYG/6RXjUzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NZU2jqni; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q3U1R5x06sN2pKWdRc4egagEUfY7xp6lzS8x+ow57Ss=; b=NZU2jqnilv5F5BzYqXAvi+1W7M
	YdtF5wgWkWdqNMrcR/cciCZtpm63DEwFegVJ3uo9F6mMfyNt6hR1GNyhMzGNTjKRz0pXl64f8uKuW
	KZ7UzuSa+4jQ0+2ZvnQgOWaNhxd5TUyLG2ROiIhhUux5Wn/Pwc/fZ0sRkGPFOxyqrvwSMV1cTtY3n
	D8CYXKtzRbw9SU4QCxzJu0C4D/mUJB2WVC2rBwQfV2BXpMl0UcOzjyZnseOxF45YIouxNjc5jv5l7
	K8YJecWzWUubQYre1rHSsDHmj5NFoUtj2XcwVOwe/m0MFNrR1i9QOzNaBVYX5rD3OUlROFgdJofJy
	AUYxb2pw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37654)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGKkC-000000002SL-0XPY;
	Tue, 04 Nov 2025 17:22:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGKk9-000000004vZ-3pQ1;
	Tue, 04 Nov 2025 17:22:53 +0000
Date: Tue, 4 Nov 2025 17:22:53 +0000
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
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: loongson: Use generic PCI
 suspend/resume routines
Message-ID: <aQo2bcdbtVzxXGbR@shell.armlinux.org.uk>
References: <20251104151647.3125-1-ziyao@disroot.org>
 <20251104151647.3125-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104151647.3125-3-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 04, 2025 at 03:16:46PM +0000, Yao Zi wrote:
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -367,6 +367,8 @@ config DWMAC_INTEL
>  	  This selects the Intel platform specific bus support for the
>  	  stmmac driver. This driver is used for Intel Quark/EHL/TGL.
>  
> +if STMMAC_LIBPCI
> +
>  config DWMAC_LOONGSON
>  	tristate "Loongson PCI DWMAC support"
>  	default MACH_LOONGSON64

As the next line is:

        depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI

where STMMAC_LIBPCI depends on PCI, and the whole lot is surrounded by
if STMMAC_ETH ... endif, shouldn't this become:

	depends on MACH_LOONGSON64 || COMPILE_TEST

?

Otherwise, looks good, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

