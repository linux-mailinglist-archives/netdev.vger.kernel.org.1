Return-Path: <netdev+bounces-156208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD4A0585A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7076A1887C28
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB41F76CD;
	Wed,  8 Jan 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x384X12H"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C838F82
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332867; cv=none; b=Tw8pNh/DtihH9WaeLYRguGG53i4VAzjx0EGugkVnLQhhvv7kTv+xqoKGZhVkKpdwpYHRrlp9Iiq4tnPnGmr/kOcQNx57vbJ7112qfVgwPbj1eWaWnLf0xjhOp9ZvUrkUfWQTYsivm5sNU5ib5iKlvNA1rN5TzNPLAFk2uM32BUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332867; c=relaxed/simple;
	bh=JY1MGPAfFhOghaWRd0TgDBXRGWkHK65TLiZ/5qwVN7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnegaz44mm8tH5MdmQx3uvibM0NW16s7a041n0u+tWuiwc4D29Y8PBe4MxcVn+y946nX/UEXuIf7FivB3z1TGN22jrPFfkEPaJDYcDoBmiYepPJL4dWgoT0asMuHrr/4c/jzYEW5/1KKX+v17cWNOiBuskSCWSJR9oPGuPNRSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x384X12H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8YR6sefChmMCI3W3DFYxDLqp5TsMPa0xO2IcTo2b1+w=; b=x384X12HeI0q3E5tqTrjVvRoNg
	X64WIEcS89d47QITj3u/LON+Bg/9390WtUuzt9Cwiu8NjZrivtwto9/sozpwySdpHr/Jp54N1ID3d
	Amopwt5v8gHqfbcx69zNlrxlHHCsi+Ev7k83iODuv8XEgRx50aCR4f/cA1uEAGyFbdc6LEb+IifT4
	iIvt1oN6L/oumBR6K9Z2Q3sFiwr8IcWy4Xnp3RdpTn3IvS9WKRNqAFBVhM1YVE9hco0vDlyAYbZzc
	ULeqdH+OClsNO8YOJFLm65qUz90qQT0DfALOG/TrWokphBgDSPtuy21CIuOI9+QM+zoVNC0fLRrvy
	HN1MZUhw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34564)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVTUT-0000Pe-06;
	Wed, 08 Jan 2025 10:40:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVTUO-0006Dw-0t;
	Wed, 08 Jan 2025 10:40:40 +0000
Date: Wed, 8 Jan 2025 10:40:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 02/18] net: stmmac: move tx_lpi_timer
 tracking to phylib
Message-ID: <Z35WKDhVGMvPIi7d@shell.armlinux.org.uk>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
 <E1tVCRZ-007Y35-9N@rmk-PC.armlinux.org.uk>
 <66b95153-cb12-494d-851c-093a0006547f@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b95153-cb12-494d-851c-093a0006547f@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

On Wed, Jan 08, 2025 at 03:36:57PM +0800, Choong Yong Liang wrote:
> Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

Please let me know if this is for the entire series.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

