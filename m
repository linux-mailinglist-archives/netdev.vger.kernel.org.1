Return-Path: <netdev+bounces-233573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 388DAC15AEA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A0E1C215B9
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B234574D;
	Tue, 28 Oct 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OPDon2gv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FAE34677C;
	Tue, 28 Oct 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667205; cv=none; b=aiHpCTqqet3aFqy8mLA4Jgsj22TaGNObamm4YnOfSX6wD3AyhvURcjyRbp/QaUN2XgPtoUNOHYFDRi777B0++6aGfX1QYC8r/8LwyoaTSjKETpKcPKxc3LdzzZe77sR9U1j3R+WVYXyBhu9wR1ChLevNXM/D4Du3agN00ZVi8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667205; c=relaxed/simple;
	bh=yXlxMO/+3Sk4qBm+Z8PuQp/W4TzaBS2RNM5DUrDCUnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBWICQ6ofMaXRvl8YKQqF8gBpjAXdHJ8W9u6QOelgbZnuJ96+NZ6VuvhRiV//zzpxSBq4fhMxLttcNE04mF3HVYirYnRtHl72dPU0ROx7PhyFpEhlXhJoFhKj5eesbosvYeK2H+zKv1OvHw7lBNpQBk9sccJ2AKR5O7gdmhM724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OPDon2gv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xoa1xaSBGIRNYvjXkuxXAOWroyvC55MnHi5S07DMY40=; b=OPDon2gvzdFncgUu6x8M4rYwN3
	EGjqnkUmiAFz5ZNFVaJNcg9cbOCTuTRnwWJJ9JRivJJR9/fDQApXePn2hgaMaHmeUFKD1i4mk5d/o
	cIoWBpiHr/m0oA4mJA+HjirohJywR7aBuRxHwJBbSififWJBHP/npPXqCO9hc6Iu3+UiVc6+9uZi/
	BJ6RItMAiBb8iUohS2hArpRy3V5jPBFCxxayYZjddpWB95lA/gC6KO1dwSQDVvr7pn1T6oGtrgrvo
	6XDn9ddBvOrz203YRkbXAGUiKx61hcF31PR5wb4atWScsziL3Y7oAoQcBsFzrWm+UhB1HNskXJ466
	IH1T2vmw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDm6m-000000003ME-1cN4;
	Tue, 28 Oct 2025 15:59:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDm6f-000000006fl-3nJW;
	Tue, 28 Oct 2025 15:59:34 +0000
Date: Tue, 28 Oct 2025 15:59:33 +0000
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
Subject: Re: [PATCH net-next 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
Message-ID: <aQDoZaET4D64KfQA@shell.armlinux.org.uk>
References: <20251028154332.59118-1-ziyao@disroot.org>
 <20251028154332.59118-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028154332.59118-2-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 28, 2025 at 03:43:30PM +0000, Yao Zi wrote:
> Most glue driver for PCI-based DWMAC controllers utilize similar
> platform suspend/resume routines. Add a generic implementation to reduce
> duplicated code.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++

I would prefer not to make stmmac_main.c even larger by including bus
specific helpers there. We already have stmmac_pltfm.c for those which
use struct platform_device. The logical name would be stmmac_pci.c, but
that's already taken by a driver.

One way around that would be to rename stmmac_pci.c to dwmac-pci.c
(glue drivers tend to be named dwmac-foo.c) and then re-use
stmmac_pci.c for PCI-related stuff in the same way that stmmac_pltfm.c
is used.

Another idea would be stmmac_libpci.c.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

