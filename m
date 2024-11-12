Return-Path: <netdev+bounces-144012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123539C51E5
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9AE2832D6
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73620C00C;
	Tue, 12 Nov 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MRZSNQ0m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77235207A14;
	Tue, 12 Nov 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403486; cv=none; b=Q8Z0JIFQRH9znncUYBy/bRCG6aojQ6PsWiOQ9EX4J8luYIolJMBRlSmrKyV2wKZ10iHU2cKtPqJcc9O8Fw0wKD3bWpxWQTNPoUj/XMIj7poObyfWBo3thDgdovOJlrN230UUTXQ9aj0Vn2QVabSoN0wRIC6bLkuOfYw9a9dj7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403486; c=relaxed/simple;
	bh=towKAoDTQC17k6IzuhrJZIMlxORTiE5iEYZ/nDEwrMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn+YAdpwcJRLVZ6Bf0YejRNCmqIro2dgN7RX69oxtsdxlQnbAM9PiL2K2aRIz5RE18i45ZjbwHquXJ8gA3HrsHQgpuKKUlD+666+hmeXqBI8LhO+e5emOxWg6q7iZZy0vuwzOCSrmvbjQSoixexi4z1tF6VNkl7OvdO0WUNrC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MRZSNQ0m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CFkA5vd3pbYzo9B6L/nOgdQXK7gAvR8Xqv+AnYPVXxM=; b=MRZSNQ0mF0X3fzA2xt2gd7wtP/
	mNYyJsjtiDgAWNpXI13dUaQTkuixDf8/RLbMsCVoWVfMHFtMCqZ+vFnMVuY/lWyGqznkPztKxjk+e
	rkCvaYOHKD1PrDceDINNIFg8w6RIFY9PBUdD0cJqL6teVijHnL6EcFl1ZKp8NF5+FN+AP1h8Y6dXG
	bsQ4gLlamHTsYTOpvBdxCmWBZHkKKlOss28f1nEC1x/2B4JZlgIKds2Aawt9g0ni1afzseINRd20c
	WT2XzVWHw1uEi+uJWd/AAdj+7uvdwlWYXxDA5rP/MhEOWm3v+eBSp8jM4IYqkkbuAYT0x3RHNbhhA
	Q/qOYAUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59136)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tAn8T-0003ok-1Y;
	Tue, 12 Nov 2024 09:24:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tAn8P-0007LO-1s;
	Tue, 12 Nov 2024 09:24:29 +0000
Date: Tue, 12 Nov 2024 09:24:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v1 0/2] Fix ethtool --show-eee for stmmac
Message-ID: <ZzMezSoY2BK1hjLv@shell.armlinux.org.uk>
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 12, 2024 at 03:24:45PM +0800, Choong Yong Liang wrote:
> This fix ensures that 'ethtool --show-eee' displays the correct
> status for stmmac.

What do you think is wrong? It seems stmmac is manipulating eee_enabled
depending on something. This is wrong. eee_enabled is a _user_
_configuration_ bit, not a status bit. If the user sets eee_enabled to
a particular state, then the user expects it to stay that way and not
be manipulated by the driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

