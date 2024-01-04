Return-Path: <netdev+bounces-61468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8179823EE6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7481E1F24ADE
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7F208CA;
	Thu,  4 Jan 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I5BQtLOH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11705208C5
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AmV2jJzb6bKRhUpoNV+iDK3B60yLo+oEdOIESY9WjrI=; b=I5BQtLOHh7GxUER3pfQAxdtQJC
	z4Yvf6wiB6Nvwj6OGoIYka6hWoIeLIgVKI5Hofie8LlLF0d6Q8207UGRr4iR1TVu5hrKEgnMYe6Wy
	bfDE4pFHa2DuHaEJ1zB8LJ1v4tn1QvzZi+B53QBOWMfMiOxB4a/jcuUUi07sr6g8w8y58Rc9d1NlB
	kFAjwlMoLKBHkFEPm599uzzKg1uuML3v7Iy3AQqilYEZCuXzskQLvcjKDmRYftDuYyYJMMectZzq1
	ts2KZG7HbZovDBF8n8DUmA5v8RXluKGfLlvzbJQpzzLjDqjiiXXkgKMqeqzrqChS3SE8KR6likOTl
	dNWpEXLw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56620)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rLKKn-0008KL-0q;
	Thu, 04 Jan 2024 09:48:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rLKKo-0007K3-Nv; Thu, 04 Jan 2024 09:48:18 +0000
Date: Thu, 4 Jan 2024 09:48:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phylink: move phylink_pcs_neg_mode()
 into phylink.c
Message-ID: <ZZZ+4pCBgQ7foB9L@shell.armlinux.org.uk>
References: <E1rLKK8-00EtVI-MV@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rLKK8-00EtVI-MV@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 04, 2024 at 09:47:36AM +0000, Russell King (Oracle) wrote:
> Move phylink_pcs_neg_mode() from the header file into the .c file since
> nothing should be using it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

There should've also been a:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

on that, sorry Andrew.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

