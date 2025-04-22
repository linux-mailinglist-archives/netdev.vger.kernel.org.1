Return-Path: <netdev+bounces-184736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5858A97118
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C18F3AFA95
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5A28FFCC;
	Tue, 22 Apr 2025 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ERX6sxyp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BD28FFC6;
	Tue, 22 Apr 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335958; cv=none; b=J2OFoORSZEjD7/mz4jKbdlNchx2lpNcsxbKnua7zTbDKJM2jIRCPPFF43t2fg+QaX3HpD8+W3PrvjFtLTOOYuhU948qGvJbmYilOOlmQ2PtUY35LQxPEM25FBOVrb9fgtw/xM2xLNjgUhAhuwzQtFKTqZKPCc6IKoH6MD7e0l9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335958; c=relaxed/simple;
	bh=22H4WnLIuzHHicBYeOrAb8HFdRvT8lTg3+LnSBWpFqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmPURJUtXraVrm8waSwo16mjbUllPCxM9THQRryFKGvFi+m598j62QF/Ja5hQY1Aoo4E+ON1RJ3D6Wx6fSphc1+YXEVIfGuIMELN++12LrdCJVFhrpBxyVIIJdnuvLC4CaxIz9Qfi1y75ybuhZRM9gLS7uzCbl7ahWUd3zBUD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ERX6sxyp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gt7L3h/h6JftjK7S6HBLGWArLASFLVo4SYarGabL1Sk=; b=ERX6sxypfDytXPK6JY1ybh0dep
	fWUaOf7LKQKP0oDx0asAHaPa1mlqj21OQAIm4wYUH4QL/pMZuI2fpI/jKmcizCooHta3UGi/ndYbz
	gdVAYVsdaH5pOB07HPPshfAC0mrMpf+I3EAi2VbUUpMNYkpardHsKFB+hh/sxfqgdA1x1+S5COQLV
	v6sxsZ0/Irb+3xGMzghdK3Y/Nesg6HcmLDneD7/o2wfJeJDE71P/Pnne/jIwFIxUX1M/IM9ZJm4dw
	WP2F+JbYlvNReGJvc4KSTff6qJK8LHjbFM1tzlsMjg+DN40gnlkZ2UccF5C78kyoubRzD4gLZDCzp
	dWDC+11w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52312)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7Fbo-0004e6-2Y;
	Tue, 22 Apr 2025 16:32:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7Fbl-0007a9-1U;
	Tue, 22 Apr 2025 16:32:25 +0100
Date: Tue, 22 Apr 2025 16:32:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: stmmac: fix multiplication overflow when
 reading timestamp
Message-ID: <aAe2iULNthghEEEt@shell.armlinux.org.uk>
References: <20250422-stmmac_ts-v1-0-b59c9f406041@bootlin.com>
 <20250422-stmmac_ts-v1-2-b59c9f406041@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422-stmmac_ts-v1-2-b59c9f406041@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 22, 2025 at 05:07:23PM +0200, Alexis Lothoré wrote:
>  	ns = readl(ptpaddr + GMAC_PTP_ATNR);
> -	ns += readl(ptpaddr + GMAC_PTP_ATSR) * NSEC_PER_SEC;
> +	ns += (u64)(readl(ptpaddr + GMAC_PTP_ATSR)) * NSEC_PER_SEC;

I'm not sure what the extra parens around readl() are actually trying to
do. Please drop them if they're not useful.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

