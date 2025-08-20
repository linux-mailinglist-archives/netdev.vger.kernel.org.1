Return-Path: <netdev+bounces-215162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13FB2D47C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB251BC7BC3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 07:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216962D24A7;
	Wed, 20 Aug 2025 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qOANscv1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAD2741C9;
	Wed, 20 Aug 2025 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673644; cv=none; b=O+7I71+u4Ip+xIvUkObixmjQ0iYDXtnD9G16SA/hG+p1eg6Z1WT67f9StsE5TQDN/rw1S+JPCgDPtxnnulhGyfu+n0JA/QTec2KWPbFwuNV/kZnrSiC5rizGX0mkriA2ToWDaBB6oc+PFGfK97/RQaoREvNTEc8bIOISmFwqxOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673644; c=relaxed/simple;
	bh=TaxiWtPTfGrDpen8ZIb7nub1gevfpQeg6ZsLJqzRkGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He7ssd/R4FK4snTbtmvX/rLFI0kfU5hBUjnyvB86DkfX859v7OxVVvShCx38YXCMvXOOrFmoevI6juXVEv2S7LQmQGfjUDueqAq2qI8HEDkgzorYYw/E0XwOeBtfhjQaSFCIUpXyhhtn9E7aaeuW7xVLrgsETkYCVkzuqNLp4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qOANscv1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9gqSLsf7BauWawgwunyMy7IZ4Wk/6a60Zsc0No/utek=; b=qOANscv1FJSCGdxlMcXpamTMiZ
	l6KJfKE/btOiven+e+uzW0i7q7ZrfstLB+YcWjdR1YTbhF8NM85lx+qgTZFkXvL7q9smTvSD2hI7b
	XJGalGbRRvoXeJOhJQNTP9qjCeVeCSfPZ+XaP0xWDDanoaGr+Ix8nD04/B6/oqIrFsYjRN1ikreCt
	pJZW6zuOFdn+U416EI/im1W77WyBh0YlrUCS+of62h1pHyUZhv9Mx4s7wHMmCHzuPpALym6gZLBWi
	nOfbxl2kkWv85HN+szXLeZS8qE0kM1Qqv2/oL7W8ptwk/d0i/ClyMxT4FoOC9lFbji6zFeGRbuxnK
	fJsklpfQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59824)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uocuY-0004Kg-01;
	Wed, 20 Aug 2025 08:07:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uocuS-0004JX-2Z;
	Wed, 20 Aug 2025 08:07:00 +0100
Date: Wed, 20 Aug 2025 08:07:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v1 0/3] stmmac: stop silently dropping bad
 checksum packets
Message-ID: <aKV0FF4FFARJNvZu@shell.armlinux.org.uk>
References: <20250818090217.2789521-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818090217.2789521-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 18, 2025 at 11:02:14AM +0200, Oleksij Rempel wrote:
> Hi all,
> 
> this series reworks how stmmac handles receive checksum offload
> (CoE) errors on dwmac4.
> 
> At present, when CoE is enabled, the hardware silently discards any
> frame that fails checksum validation. These packets never reach the
> driver and are not accounted in the generic drop statistics. They are
> only visible in the stmmac-specific counters as "payload error" or
> "header error" packets, which makes it harder to debug or monitor
> network issues.

FYI, there are counters at 0x214 and 0x228 that indicate header
problems, including checksum failures. There are also counters
at 0x234, 0x23c, 0x244 that count udp, tcp and icmp checksum
errors.

So, the hardware does keep statistics. Maybe we should make use
of those rather than the approach in this series?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

