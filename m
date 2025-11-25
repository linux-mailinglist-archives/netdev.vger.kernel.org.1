Return-Path: <netdev+bounces-241587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19388C862AA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61AAF4EB6FB
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D40324B0A;
	Tue, 25 Nov 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k+TZPMCJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A420DD51;
	Tue, 25 Nov 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090942; cv=none; b=sh62WKBoJgcz6Qg5NcGVA/vWBF2+0obZrg/gham1EAsqYoH1q2/uVt+XNI5V1esfW90WDmMja6h46GPTtE10KLfebm+XP75SY7aca9mlu3mkiiJ/4uknsggZVY2SkSGzIgiPjwwA5tX/AHW5xGmkDTUrn4QzG9rGPqQ1xkTWzGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090942; c=relaxed/simple;
	bh=bK9G/d3tB0aorJ4ZiRm5bmH2vX/mHzTe46g+GmmhsnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQXc2XOOaVpYW+p2H04wK7Lgf2duYONLejZV5fqG2r6c6q+il5uAp3BjJ+TDT+iTSpPg+zGKruT2+GSrHIK0njmn6ZP7GGsIrm+OzRKUO2lNo4yN9GkEoGIuF+UHcAjv9GyHc0RUGXK23BFxkJ5xwA6+ZU1X/MKowsxN/hUEfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k+TZPMCJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jxg3H8Uql9nkiAIN0V2P2GB2R7A21jfWF/yVMoQl0yg=; b=k+TZPMCJYeDFEzBoJf+lQEgeGr
	vfKunkoRTG6PVGve6DJSlhusDL0PrvurgYTgm1xE1dosn9uremc2KLYO0ZW611rG6+C+6sS+GZHVW
	/2KVpcZnaT4Ji+8PQiI+2Auf//WPboeBwivPINEWtzbVe2bE2WgmH9cI+7+xTWpWkStUTCi+GWai+
	gMllxYrkIucL70/qujkOcBo9qfuBmhwALY2Z04/dQsNFrg3W35nuHLbn/uvSGF/ZgFdrPKOc0LCvl
	R9RE7Km+Ta1PiXPJWQCKLFoEbg7Z9nC22dKTsKKBwjLDob1RJkH2jNLzz/SykbyhkyPOqhYC1W9wq
	AlIT2hTg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50836)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vNwdE-0000000033N-0JG6;
	Tue, 25 Nov 2025 17:15:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vNwd7-000000000vi-3X4J;
	Tue, 25 Nov 2025 17:15:05 +0000
Date: Tue, 25 Nov 2025 17:15:05 +0000
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
	linux-kernel@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [PATCH net-next v5 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
Message-ID: <aSXkGffyTSTA09mB@shell.armlinux.org.uk>
References: <20251124160417.51514-1-ziyao@disroot.org>
 <20251124160417.51514-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124160417.51514-2-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 24, 2025 at 04:04:15PM +0000, Yao Zi wrote:
> Most glue driver for PCI-based DWMAC controllers utilize similar
> platform suspend/resume routines. Add a generic implementation to reduce
> duplicated code.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

