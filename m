Return-Path: <netdev+bounces-247137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D0ACF4EB1
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 034D630E49D9
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9806031D38B;
	Mon,  5 Jan 2026 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lX1FW+Yg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA6329C5F;
	Mon,  5 Jan 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632072; cv=none; b=epRCsmJE3Y7pVsNi95hdmJUGfm/mQJNfZCe+tqeZfqJM9ciQ1Cu1wAPjSMpnd1gv0K+QjXEGG3KShdiOUcd2r0ZdehGvGvH0Vhbu0U3vTsAvtaxdfpmjC4AkWsFsvAXZJfRqlkPaV6PDHWv6wJfw3NRukkmntkFRS5xzxJop1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632072; c=relaxed/simple;
	bh=kgBOPx8X3O0tdg7z3K2K03zc42e9NiZ8Oa6G1WZ9OpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmBg2/EuvEultnsTVi2UYQhPhdLhrL9K8sY4hjPr7EQwQNAhCfa5AwSZ2KXTrOVOjzMfdqtg1VL3c/wp+R+DFld9/mUgMImXRmp6VSgBbMsoTLG3220n4zuxxIyaO/zYXvpQOt8PxW4fwIbU4ZxDlnr+560v4zjMHiqu/5g8IsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lX1FW+Yg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hlE/YpIwDNqax9z0PkzEpkmZoVeweYd1LfeBmSFqwL4=; b=lX1FW+Yg79iuHLRTfHfKSZiNF3
	g886BgR5O75BB6TRwqUrXDkWeOIBkTj7LUFNNfxSCfBzTwgX4aXK1dzreo0HnVs9eEbRlVHvhCemc
	1QUtmdjbP3A2YBo+MHevWB69be47dGBRkkfCFfBEoflBFAOKUh4E8H2098ItJ6k+hr1dIpmPD2TUi
	qqKdRYkjcUZlmaz+KjsmZxungXWSqq11wNjmTmEgpQsOHM/kZGo3D3/y8Zt2Y4ZVgXs1Hh03tXYzP
	UK5EyqnY9lqurBm/NGBDmu7GGcT6fV5p7gA3AMmaax0awly5CgZDeNF9HKU2MkwGxbS3ca5ttd80T
	T6o+DFdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49446)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vcnqM-00000000884-3i9V;
	Mon, 05 Jan 2026 16:54:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vcnqF-0000000080r-2Jwx;
	Mon, 05 Jan 2026 16:54:03 +0000
Date: Mon, 5 Jan 2026 16:54:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <me@ziyao.cc>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>, Runhua He <hua@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [RFC PATCH net-next v5 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aVvsq7HKOJ0RKwrA@shell.armlinux.org.uk>
References: <20251225071914.1903-1-me@ziyao.cc>
 <20251225071914.1903-3-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225071914.1903-3-me@ziyao.cc>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 25, 2025 at 07:19:13AM +0000, Yao Zi wrote:
> +struct dwmac_motorcomm_priv {
> +	void __iomem *base;
> +	struct device *dev;

This is only setup in the probe function, and then only used when
reading the MAC address to print error messages - which is called
from the probe function. Would it make more sense to pass the struct
device into motorcomm_efuse_read_mac(), especially as it uses
dev_err_probe() which suggests this function can only be called from
the probe path.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

