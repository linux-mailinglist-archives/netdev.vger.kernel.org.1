Return-Path: <netdev+bounces-172171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C83BA507CA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 19:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC531893A44
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDF91C5D4E;
	Wed,  5 Mar 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ziP+c6Rh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3B14B075
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197635; cv=none; b=BLaVVOxAluDQ8PTQA72o+ZxYdLLyBV7/2u2MrGDXJSWbqCYgG+Zkk3E/DPRRap2XgnD2ME10ZpK1tGmW2CpQLhx1e8ZazKL7Ac0Fr12KZY58M/JFVE4+zAFJcQxf+DpU2Bl+zK4mOjMtbHsQXeDF+66+hD/v4PxdQC+zs3uT/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197635; c=relaxed/simple;
	bh=34IS2Ra3ZQYkYOLhiHmpeb9dNwq+KiAH/7esWeJ6zmY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t0qEUpnN44pUdNi5PqSrJtEqnwROEv8E3G3sw7c6S3KCkF6IYiOFtCrX0n8HEz9UdHrQj55cvQ/x81Cr2EEabQZ3m1ywFdG1Lgug7eKWixHSCNTefmo7KsRdbKyddtn4aFpz8NjELayt2Rm2BZOk1xtxNUBYOJtvJN5m1igOThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ziP+c6Rh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Px9Jz3Pd0I8Y7Fz858xKtuZ+TcOz0/7LpltAItOKKMQ=; b=ziP+c6Rhe1jcgsh/J48ZLSgYEr
	yXbif+ag+SrRv/jbcc4Eu41tem7vBX+R6ll6sS7LJkP6eexbhTu5TyukH9boDuRgi9IQEvC24Tl6c
	lIGK5UTFBuj5v0EFhz976kQrP9dxqfmLD0cpZS772/HBPuTXyATCznn2/KEnu7CWMec8i7N7eo8qv
	wam7BJlJkjZ3Wip4Otsc41ywrGel8goj9rnqO35I3WTufuIgE9vgJE7jeyMfwWiUXwJe+oRihnZvK
	0N7znjSUBZmUw5GXUf7FhFsscEosuT+H5hnKhe5gkyCB84M4quabjNadkyegPTC1CWsrusGWndnE/
	R2FO08/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39552)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tpt2d-0004gX-3D;
	Wed, 05 Mar 2025 18:00:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tpt2Z-0005xy-2E;
	Wed, 05 Mar 2025 18:00:19 +0000
Date: Wed, 5 Mar 2025 18:00:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] net: stmmac: approach 2 to solve EEE LPI reset
 issues
Message-ID: <Z8iRM8Q9Sb-y3fR_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This is a second approach to solving the STMMAC reset issues caused by
the lack of receive clock from the PHY where the media is in low power
mode with a PHY that supports receive clock-stop.

The first approach centred around only addressing the issue in the
resume path, but it seems to also happen when the platform glue module
is removed and re-inserted (Jon - can you check whether that's also
the case for you please?)

As this is more targetted, I've dropped the patches from this series
which move the call to phylink_resume(), so the link may still come
up too early on resume - but that's something I also intend to fix.

This is experimental - so I value test reports for this change.

As mentioned recently, the reset timeout will only occur if the PHY
receive clock is actually stopped at the moment that stmmac_reset()
is called and remains stopped for the duration of the timeout.
Network activity can wake up the link, causing the PHY to restart
its receive clock and allow reset to complete. So, careful testing
with and without these patches is necessary.

Change from RFC: drop unnecessary first patch.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  3 ++
 drivers/net/phy/phylink.c                         | 50 +++++++++++++++++++++++
 include/linux/phylink.h                           |  3 ++
 3 files changed, 56 insertions(+)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

