Return-Path: <netdev+bounces-211348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B59EB181DE
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86664566FC1
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E0023F26B;
	Fri,  1 Aug 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VpN8hIX2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F522F757;
	Fri,  1 Aug 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051708; cv=none; b=dL2Mh42DmYbBwgkShD8xgye6tZCQot0ZURs0JH8cSGqUxVWUIUnMwafz6M9hw0de4KntKde3TFkQEwdsMRjfDfUYYqS18cM4EEYvIu3BEX7Q9b7+j1C1AmRwgq+u1hkNmB7+9htayez4UAKWaEbbtMj/RWggCiyjW1tstMQmXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051708; c=relaxed/simple;
	bh=jB1Vx2WL8qzCQ5++PQCPXvRjDSCfgrjYiYkZfI/7QaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS6vRqqaECKAb1/aYF6DPakmNEUeJeJvuTaiyzdHU/mJpkSHmdt/Y3JY45iZn7n3sVgpPifdbPrCPkaGqW1V6mJ5ltzQ49929rPKc4hQSYa5GbYoTrx89yai2NhIu7imeB/o6viPYUlwNBlCamhIXKlO7svUhwHu/cXmSYSAkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VpN8hIX2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1fuJBAjBUjwQeX0vysnbqS8rGM0e+eRddEy6DFpPWwg=; b=VpN8hIX21sSiiiW5Rq5wlrVTV3
	yM/3WQq+isxOP/xggGyGMu2xlPZXV0/OUFF+OHgacmRhNyeD5Erwq8vkjh512tM2HaHFUadeP24+M
	GuptjiK8nASLqc58uzJPjn3mm82STgtXGl33cmncliq9voSNkZZz5+2bhFcvkNm818ONeL0EISpkp
	QyLk9amLr/mnfKHd8JQ+C0E+OqgUEi//FMnugqcO1mtGV+FJcWNnGqlRO9IqRw2Lc8JY11SW6xRtQ
	KFC/2nvEuXEGaDYBTUE7ZJ1+9rVAf+wSMhnmm5JH43Epy8DX422RhmaUTdFdrqGjc4rxTBN/ZZbHK
	33b55XQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60270)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhoyR-0006V6-2S;
	Fri, 01 Aug 2025 13:34:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhoyQ-00024e-09;
	Fri, 01 Aug 2025 13:34:58 +0100
Date: Fri, 1 Aug 2025 13:34:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: patchwork-bot+netdevbpf@kernel.org
Cc: =?utf-8?b?QmVuY2UgQ3PDs2vDoXMgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org,
	geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com,
	davem@davemloft.net, robh@kernel.org, andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	buday.csaba@prolan.hu, hkallweit1@gmail.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
Message-ID: <aIy0cTjW1ETsY2NS@shell.armlinux.org.uk>
References: <20250728153455.47190-2-csokas.bence@prolan.hu>
 <175392840851.2582155.14607525521532592549.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175392840851.2582155.14607525521532592549.git-patchwork-notify@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 31, 2025 at 02:20:08AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Mon, 28 Jul 2025 17:34:55 +0200 you wrote:
> > Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
> > devm_gpiod_get_optional() in favor of the non-devres managed
> > fwnode_get_named_gpiod(). When it was kind-of reverted by commit
> > 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the devm
> > functionality was not reinstated. Nor was the GPIO unclaimed on device
> > remove. This leads to the GPIO being claimed indefinitely, even when the
> > device and/or the driver gets removed.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net] net: mdio_bus: Use devm for getting reset GPIO
>     https://git.kernel.org/netdev/net/c/3b98c9352511

This needs to be reverted, it's an abuse of devm on a device that is
not being probed. Sorry, I don't have time to generate a patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

