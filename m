Return-Path: <netdev+bounces-238470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89472C5945E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF1B34F709C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981372DA75F;
	Thu, 13 Nov 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BQXc+IAT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A202877FA
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055992; cv=none; b=fkH0474kkH2VrEKkpSrrQwOOrM3dzjRnCRZluHuW9+hHBaVXERXBUPIR4iLLTttCW7h58DtpnH7eLamgHoyKv49m30cdaKarYWabl0l7A5pZP56uBi+7z/ihVllm9Oww2CJxe1nfgMfQ63CaeBg4A9X+7eRKeybJVAF//bI76sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055992; c=relaxed/simple;
	bh=bRcmrDnARBKiwkRfEr10C+tDyWnIu8OShnZNcdliIjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kfzEsAhdHtfKw6RF39jjvC1UN07FboilhESwz1qAeqbYdhRbIxqNhJbLSptOTcTSuWLQMdNvTPf3OBj52jkprJT9zDjwmIdlpJQL8cSn1+nWrgvbv9AE/pR3hYl3wv00mTOcvdSzqZJ8xZWFSVRIA9Zo5qXix6Qdk/NeVLmNMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BQXc+IAT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=53i6hc89+8JoHFGdA82pjuxn/jNjJDmBPopxlzzO+wk=; b=BQXc+IATtKi13BpTL1VZUnNd00
	IUzuiFdQYx4qHb8zBNfQNLj67X3MH9fiKJrtkNPxOFYFvsuycCvEs6fEnVglOXgG5IaOs2yDb4tps
	KvCdrjLgyqy5ZFVMWP29AeZNcwmthIYBTST/kIgZv+1K0lBLuZHUOcr9UdFM/5+FbK0xik8wKt67i
	vuPAv2hiuCozXVBtLNy2+1w4ETJCTiBh0seZcqqiWfY8TrZi63Ss0/mo9jWFGwR1Q2ukfqDrHoi8B
	d3ATVdcuYIq79P82rLC0Qud1oM/LdjIeaD4MlaDzanLR4YTwCZY09DyFZnN1CTNEjJfSs+P2r+xnF
	GXR5FMlg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40570)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJbOl-000000005nC-3xID;
	Thu, 13 Nov 2025 17:46:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJbOi-0000000053j-23CL;
	Thu, 13 Nov 2025 17:46:16 +0000
Date: Thu, 13 Nov 2025 17:46:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/4] net: stmmac: rk: use PHY_INTF_SEL_x
Message-ID: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This series is a minimal conversion of the dwmac-rk huge driver to use
PHY_INTF_SEL_x constants.

Patch 2 appears to reorder the output functions making diffing the
generated code impossible.

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 245 +++++++++++--------------
 1 file changed, 109 insertions(+), 136 deletions(-)
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

