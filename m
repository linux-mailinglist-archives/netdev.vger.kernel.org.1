Return-Path: <netdev+bounces-234665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42FC25C01
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0722E40477E
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FEB2D978B;
	Fri, 31 Oct 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w+fo/ZN1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA431259CA0;
	Fri, 31 Oct 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922812; cv=none; b=E+JOpgIwgXMYMW6ydbd7uWnHeQ0ga0y/d7RvyxNFZYFwk4WsBKup77GJB2wYKCGAJ1c58HklSI6Rgtb4oWxq31Q+5X6V3SlTOLw0YjeuEImWlxVs9CB0Y+sTBjQQYE6m9Qd5y6SnWNYT36phhve03rbQy7iqTwppKzmT2n6BlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922812; c=relaxed/simple;
	bh=5JJUqE9Q8MCtCxiCImUZx5VT+wBmQBLXtq+olP+/1LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjbHy7NTSgwElUVUQc3nCHS+CIZlpDn0goLz368xgvM+nrGXE0GaNog4HGDaWTw3Z4tH1N/vtCf0YvSE83nilikIhWaCBQ/NLEs7k2sW6q8/C6YKdBmsJCVAnULxjBSc8BUTiIivOn7JcaXVmH0Qr7drShJuWF/aQ+gZYz2THHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w+fo/ZN1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6qKSobEU69BAnqLIcfo/zvc97NzO3H9n/t1gZuZHQ5I=; b=w+fo/ZN13bzqSt5KwxkF2AmKVx
	LxvV2QCFrgnVurPbX3RHME5wrKn8xBVIE9BAN1A0m8ZrYJ45Q7I3v7fis4dbIoHmPGfa1tE/tQ8VI
	E4MCGGal/r/Y/cmfaXsGZRUQW7s+enwbxn6wuB7geqZ3+qYnNddXzERS8wSOD9DCminJShRBHTOSO
	FSbZF9mEnjU5aCo5rqgFlTs3Srgn9VRLu8zjTr4Wm/R0rvMLnv4Qyg4UXRGfLD7wGWWocsxGhecBl
	ppOMMqCFOChSO4xOLtKBuIf+0cUFzEJJeUfrTsBnLxLrHUT6ftjTXtCZJjpcUT4dtVg0JujfOauSP
	RgVq8gUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33210)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vEqbh-0000000072S-168a;
	Fri, 31 Oct 2025 15:00:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vEqbe-0000000013S-3AmU;
	Fri, 31 Oct 2025 14:59:58 +0000
Date: Fri, 31 Oct 2025 14:59:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] net: phy: micrel: lan8842 errata
Message-ID: <aQTO7uEzDMrVrxbN@shell.armlinux.org.uk>
References: <20251031121629.814935-1-horatiu.vultur@microchip.com>
 <20251031121629.814935-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031121629.814935-2-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 31, 2025 at 01:16:28PM +0100, Horatiu Vultur wrote:
> Add errata for lan8842. The errata document can be found here [1].
> This is fixing the module 2 ("Analog front-end not optimized for
> PHY-side shorted center taps").
> 
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf
> 
> Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

As this has substantially changed, you shouldn't automatically keep the
reviewed-by's previously added unless you've asked those who have given
them.

Apart from that,

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

