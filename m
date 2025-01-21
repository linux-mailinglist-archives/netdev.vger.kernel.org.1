Return-Path: <netdev+bounces-160014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AC0A17B98
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55C316C47A
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17CC1B87C2;
	Tue, 21 Jan 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cyX/jYjG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054B139B;
	Tue, 21 Jan 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737455175; cv=none; b=kG4evf1UeqUokzE9/Zkk9X6iD4ZZNkte4Y1V1hLrygO9esXQbkUlQX8DepgkbyOmY7gzV1VGsg7OKiE6/QcyuxkplGYnldEsgqRukh83ChP9Nuol2G1Elx1He3NoD+iey4Dzfudf2EgEjRXwXg4cLqI8gQWbbrdeZcexVfuwZ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737455175; c=relaxed/simple;
	bh=PuK00rVoTjHH3wRUBER5/7SVIfpRsgG3KRdkqcIC8tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuWQfsMByGK52LgDCCy5wyk0eXckdZvPReewZ5sFvzMURlX1Xjv3EuqtELGCaEvclwguQsNd54jZ+l6DLys8SqxwpqAbzEm1vwlRWFOGkxR85RMZZwxsgbjAR6550I9l5GF6g+WR3J2Ls1CLsLZIPOWHZOz4mKbgSyJ52UirLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cyX/jYjG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w5SY3ixS2vGf5OsjUh3qWK0Ry9P1z8jaz5mDXOxz1ZU=; b=cyX/jYjGB1FPjJydxCZWUDLLHK
	7aeF842Hs7W4CSWW23q+pFVdtjVG3Y+tD7EoDzTrsqGUQdGlXBxsHxudB+7wFVSwNAKeqTE1KL7pi
	ZG/r4GCwhoIC1NlqIJsnnrxNncSn8sYcRSVRI1Ljh84zwwC1KYGXQQg0c21lcbBAxVOnJDXQxIilR
	lL3zwrwXu3fCXJ1S7FTG5kPUhL8FuvcpFI1vRI4XdWATP6R2X3y/mSaxAnK+CleT/hmIDVAaEsLSE
	P9DIWC5HUYObLadSYDH5UNhRgIcjX7BWeqInmGTlSAysGz1snRkohC0KLfb12dYHDk5GUdEvuspDR
	37QFTyrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42832)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1taBSI-000767-17;
	Tue, 21 Jan 2025 10:25:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1taBSE-0003pB-1H;
	Tue, 21 Jan 2025 10:25:54 +0000
Date: Tue, 21 Jan 2025 10:25:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Furong Xu <0x1207@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
	Vince Bridgers <vbridger@opensource.altera.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] Limit devicetree parameters to hardware
 capability
Message-ID: <Z492Mvw-BxLBR1eZ@shell.armlinux.org.uk>
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 21, 2025 at 01:41:35PM +0900, Kunihiko Hayashi wrote:
> This series includes patches that checks the devicetree properties,
> the number of MTL queues and FIFO size values, and if these specified
> values exceed the value contained in the hardware capabilities, limit to
> the values from the capabilities.
> 
> And this sets hardware capability values if FIFO sizes are not specified
> and removes redundant lines.

I think you also indeed to explain why (and possibly understand) - if
there are hardware capabilities that describe these parameters - it has
been necessary to have them in firmware as well.

There are two scenarios I can think of why these would be duplicated:

1. firmware/platform capabilities are there to correct wrong values
   provided by the hardware.
2. firmware/platform capabilities are there to reduce the parameters
   below hardware maximums.

Which it is affects whether your patch is correct or not, and thus needs
to be mentioned.

Finally, as you are submitting to the net tree, you really need to
describe what has regressed in the driver. To me, this looks like a new
"feature" to validate parameters against the hardware.

Please answer these points in this email thread. Please also include
the explanation in future postings.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

