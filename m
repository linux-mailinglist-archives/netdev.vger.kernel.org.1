Return-Path: <netdev+bounces-214682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D3B2ADFC
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105371968152
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9425B1CB;
	Mon, 18 Aug 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mPX/SMtE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A3320395
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534088; cv=none; b=u6ag+NFuTDQxWBLpQRANl2pDNeZ62MLo943zJ7tUmETpYQEKKVh65mgU8aXnOXTvkUrC0iJMsxINtK/e0QmEdH2SlHa6MazuILZjyUmVmmsJYEaX8a6mCMQruUtJXq9/GDI9/TNHe91nPkQ+0ujqJFS2XKhy750hCkqXJi3BpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534088; c=relaxed/simple;
	bh=+IfMyW77WhQ8SWv+mINY0EuhZOXPD3nKbwT3Z5Ai7v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZtYaBG5xJV4e43Twg6uiDlnTd2kPF1yAF8vWYv0u8wSJ0Tld9mO2xyLeuMi+a/aam/oesfX/s1bidhKCo96tSO1htwelE/iB2irpwaoKl2kXXjuBquhAe5CPNZKXrTceOY5Ozle0jl8RTMcEa/BGxKaM2QghZNQISni+CCPD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mPX/SMtE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bt1Fqm1rdkVSrisfYb3fZxCfvFp7T6Fl9NSbYHHdtRg=; b=mPX/SMtE3+VgF+L4AY/OkVOh/x
	ESHSx36J3pN9DPRqHMxXYoj104jLT2gIQIRUKmYjWJ1q+TJ92k03076DCD9Uzv/W1wvKX7TF7hfBF
	/UhoJhGwCyeuCu3pdKUzABlcW6C+S1J3gnULcfXS6SEsIMR9iPBKLtee5mdgWlFQixH11nzRp+Ht2
	DnF37cGVgfLD+BFzMk+km1YIMT60TozDBIZtAqV40ZREUC5mFlhEAppFftng0jYx1MZw9ReN8kJ3H
	lYIN2LscVxvA4BEmJZc7uQD4wwYjj4uffrHshMqP3W8egr6K0o0u8V8hvW2jxV82nz5KIFrQGyoZY
	Faup/orw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60482)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uo2bg-0001sK-1F;
	Mon, 18 Aug 2025 17:21:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uo2be-0002Zb-15;
	Mon, 18 Aug 2025 17:21:10 +0100
Date: Mon, 18 Aug 2025 17:21:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [RFC] mdio demux multiplexer driver
Message-ID: <aKNS9uPpyeQgWrBY@shell.armlinux.org.uk>
References: <aJvjHrDM1U5_r1gq@xhacker>
 <5e3c5d70-f4fd-46db-90a1-e8be0ae5f750@lunn.ch>
 <aKAWe27bDtjBIkp-@xhacker>
 <2391ae0e-bfb2-4370-aac3-563fc5e70cf9@lunn.ch>
 <aKNJN4sBfi_YAjrF@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKNJN4sBfi_YAjrF@xhacker>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 18, 2025 at 11:39:35PM +0800, Jisheng Zhang wrote:
> stmmac :(  And the MMIO reg doesn't sit together with MAC IP's.
> As can be seen, the stmmac mdio registers sit in the middle of the
> MAC regs. And current stmmac still tries to register a mdio driver for
> the MDIO bus master. And to be honest, it's not the stmmac make things
> messy, but the two MDIO masters sharing the single clk and data lines
> makes the mess. Modeling the mmio as a demux seems a just so so but
> not perfect solution.

So, let's say we have four devices, stmmac0, stmmac1, stmmac2 and
stmmac3. We decide that we will access the PHYs via stmmac0.

In DT, we describe the four PHYs under stmmac0's node, with labels
for each. We then reference the lables using phy-handle in each
of the stmmac device nodes.

One of the issues with stmmac is that the driver will successfully
probe without the PHYs being present, because the driver only looks
for PHYs when the netdev is adminsitratively brought up. The problem
here is that there is no "EPROBE_DEFER" mechanism available in this
path. Returning any error code goes straight back to e.g. userspace
and it's up to userspace to decide what to do.

Commands like "ip link" will just report the error and fail.

I don't know how programs like systemd's mega-suite of programs deal
would with any errors - would they retry or declare the interface to
have failed.

While I can see the advantage of a demux driver, this problem remains
whether we have a demux or not, unless somehow the probe of stmmac is
influenced by the presence or not of the demux driver.

Remember of course that the demux driver has to cope with locking to
ensure two transactions can't happen at the same time (it needs a
common lock somehow shared between each user).

If we can't solve these, then one might as well go with all PHYs on
one MDIO bus and keep it relatively simple.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

