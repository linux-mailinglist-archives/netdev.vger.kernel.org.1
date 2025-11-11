Return-Path: <netdev+bounces-237552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89038C4D11F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591203A8A69
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4F2F999F;
	Tue, 11 Nov 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AZkAqpH/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FB3126D2;
	Tue, 11 Nov 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856658; cv=none; b=Ov1WuH4QhJ/n+1MLK3NkjyV8AbXNvIruDqLx83cn92+iXPxylehq5qoyL3ismmCKqtCGm15Ag2E39yUsxY5O7SDbFZGS4xiwFDGiGTIDtiOC32lQKK5sjQDIFE15hx87Bf4Wn36vYU0NfqtumLH4c+JptycU8bT4cakg0cPRbS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856658; c=relaxed/simple;
	bh=7nQYDojRnihToPaRBRm3srC1As3Y+eUW/hEuufa3VWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUwwM+Ae+RIuoPhMNhZTgPCQ4Tdxr18QF9iIPfzyV/fEE2N9O0OzTDqmjWbORPG/5l0D3fDcp4tt5yNNv5eVgBiTd9x+8Uhbhskgmogtyr2wIWxqzMw8QhCCzRmU50nfvrHH5UR1VZYUc+C+QU3/BbiULVE+jQtL9dLdDGpxnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AZkAqpH/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8vXI9zggnSXZv8yVER2SVGmnxSA/PKbAy3m0/V4Cgw0=; b=AZkAqpH/sgc2s12+67DoGBhzMY
	gq7VbOPeGGIU1foVgOVMMGg/VH1oDZE02h+4MvlVcVOpF/44hhxKnrWVG8pj8oF7YOW3ssjHyKP+f
	1MwFeRqpr+l/HX2Ut7l13DGkPrfaEMJqUvqFqXIo0aVztYxbWy1losujerQzY0CsnQvq5F7UtaSYF
	JdEn/+4fSc2q4bmVvMdisNHNp+DEB7GJtWK6KxHwBBPKaiTot9MKZYzt0znoY193qavoh5e5uaji1
	r1KFRmY6NFk8dLNqUZD2CgK8ORFVvGKc9tDnviPz9O4I+MbYJf5zx0ISIa6B6A3PcTxpqq6+vR+Va
	z624ZJHw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34588)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vIlXW-000000002Nq-0sTk;
	Tue, 11 Nov 2025 10:23:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vIlXR-000000002rm-1t6u;
	Tue, 11 Nov 2025 10:23:49 +0000
Date: Tue, 11 Nov 2025 10:23:49 +0000
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
Subject: Re: [PATCH net-next v4 2/3] net: stmmac: loongson: Use generic PCI
 suspend/resume routines
Message-ID: <aRMOtTqH65LAAP9y@shell.armlinux.org.uk>
References: <20251111100727.15560-2-ziyao@disroot.org>
 <20251111100727.15560-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111100727.15560-4-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 11, 2025 at 10:07:27AM +0000, Yao Zi wrote:
> Convert glue driver for Loongson DWMAC controller to use the generic
> platform suspend/resume routines for PCI controllers, instead of
> implementing its own one.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

