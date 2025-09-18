Return-Path: <netdev+bounces-210563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C6B13F0E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7A41882A1F
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2452135D7;
	Mon, 28 Jul 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XQyJE2LK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04157269D18
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717572; cv=none; b=P/IuRp67YpBiKA8FSgofXqIlafgFg+U1IeBpwf/+EkCccFb5V09v1feECC5qiK0ApmTAxqkpvY9p1NiAUzW21PoPX7+29RCCacru5o3K/3dERSICAsx/Ulf8zzFnRPU0fCBgHttJsrnR+rP4u7P3NAbVvX9zUQgvpIDxMxOGD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717572; c=relaxed/simple;
	bh=lVgiUnf31fNV4/nzvOsIeFL7m9BWu7lhQaB1IbdHDsk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l9v8Y3nKf9IIEOFC5rXPCMyjmfbDLwwpAzaCdWs+bL132xHjvudf87uqtexQqJ9widVKObrki4E9/PCMuqL+TQMGy4/eAZymaKBtXqXlsJO3ds+KdZ+dnINV0vkcWD4ZhOBGIoD+REztoVCWduppbhO1QKRsPNN398HU/XVF13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XQyJE2LK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g7Dd/VCgHGXa1ZZy0kScT3IdI9bOz/Ax0ajFta3++S4=; b=XQyJE2LKFjRGg5l5bnJgrSVqLX
	Bo99l4IkvV3otCd4Jl/PKZPafnFD8qX9Kd4M2Yr3TMQP8BLeRQSoTzCn5joFr61IUQWs4Tl4SIS9c
	3NC+aWzHM3wRa1WNCeiP1t2QnQTUbhw7VdiizO1ULQJP83lx5kBABvzHWVrdNUyLrYtTimHzp1ZyS
	02MbuvCyzVa2r554wFRjFr5EZ3pj7lKAUvbfejxSqC1xve3jB7r2Dsi4lMfwR5U6cns7plcLLW7NK
	8q+MPgdTiCHmQOAQHR1M94RYki4cLzaNqu6wwz7E9hen1xgxITNHr883aiIvpwlZQGp+LnepJr3AU
	p6wT1ZUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ugQ32-0000TU-0S;
	Mon, 28 Jul 2025 16:45:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ugQ2y-0004sJ-1s;
	Mon, 28 Jul 2025 16:45:52 +0100
Date: Mon, 28 Jul 2025 16:45:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 0/7] net: stmmac: EEE and WoL cleanups
Message-ID: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
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

This series contains a series of cleanup patches for the EEE and WoL
code in stmmac, prompted by issues raised during the last three weeks.

 drivers/net/ethernet/stmicro/stmmac/common.h       |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       | 11 +++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 31 +---------------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 21 ++++++++-------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  4 +--
 5 files changed, 25 insertions(+), 43 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

