Return-Path: <netdev+bounces-49159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5417F0F6A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C88EB20BAF
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055511707;
	Mon, 20 Nov 2023 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mWRKKubF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DBC8F;
	Mon, 20 Nov 2023 01:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GhKWm8A2BWOujxS2VA+boNZBF8/Ex9YH9TtbKdo0egc=; b=mWRKKubFdHTVqP+snfCHCV6owX
	9QfWgA5RVXvA4VSIfQPxyIskbBfrQEsWoDdi6yprvf9swQGPwxt4VkxiwSMeDqcttnjdmM2zV2QVM
	5JUHAephk1vbuI0O4K9sz6ZnNjVOyvyWWJDYS+KNOFNICMqpRHNUC0FQ1o7M5wiSCkJkZ3JGMcvrT
	R/uV3lr1BDk5dkDMSspLW42F0aKiggidrtTVkd3csn5kVSWr0vBJl4t9TQ5mymXIiJqj57u1sZCXp
	mt/+ZdTF/uM6APIiHI//zXImLdaJjR4ap/WTqEBQFEcJWnJhpQ4/imfOqJggqXQBCx8ewf7tsiId9
	+qb16UUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42320)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r50wI-0005GM-0o;
	Mon, 20 Nov 2023 09:51:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r50wI-00034i-ST; Mon, 20 Nov 2023 09:51:34 +0000
Date: Mon, 20 Nov 2023 09:51:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Lukas Funke <lukas.funke-oss@weidmueller.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukas Funke <lukas.funke@weidmueller.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Fix potential null pointer access
Message-ID: <ZVssJrplePACN3of@shell.armlinux.org.uk>
References: <20231120093256.3642327-1-lukas.funke-oss@weidmueller.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120093256.3642327-1-lukas.funke-oss@weidmueller.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 20, 2023 at 10:32:54AM +0100, Lukas Funke wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> When there is no driver associated with the phydev, there will be a
> nullptr access. The commit checks if the phydev driver is set before
> access.

What's the call path that we encounter a NULL drv pointer?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

