Return-Path: <netdev+bounces-249566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E742FD1B094
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B1ED3005E96
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371123587CA;
	Tue, 13 Jan 2026 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fgod3tPV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7E2F60D1
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332306; cv=none; b=C0FeQejUmgCULxVJLUx8KQ/REoZrgw5JNps/s/y98zcylT7JVb+MPWeErU7qLEE22PfovSXwok/vbuAs14c9uOfUhz3Tgfu9eoceYOGT8e1X0JwwFMbBG20cvPjH3kmwOL2hyOL8IrmaUVY8G4JiMXcLstYBUKrRkLT6X588xUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332306; c=relaxed/simple;
	bh=VqZugDQRpDVf6uH1BEswu0OR8YitKy3g3wTkjA0L6qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBLChPEMGrHZ7qsbS1Jt71N1LnAHyjROhd9IuEUynRHGHYFf+W8rAbrU7QLwQwyiWp7iumoIhVDjQKCcde1Xj5fPDWfibfGF+lvrt25lsX7cx88QH3is+JwWxuo+ufZhlYfsZmq4Pf611MEh4Kwr0Lk8QfxZsRSgXTRkjsVxpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fgod3tPV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 417A81A2669;
	Tue, 13 Jan 2026 19:25:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 084C160701;
	Tue, 13 Jan 2026 19:25:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 614E9103C8516;
	Tue, 13 Jan 2026 20:24:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768332301; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RbkuFGzZ/qxkFM1i2QPzG5mu1vRK4w8zsIRNMINeoQk=;
	b=fgod3tPV+p1NxOdA3zr/s/ztTDol0auWhGDfnLz8DV+a36lyWFl5w/RL9Mk20DTSZSmeIm
	FYd6DGbVsUCDh9GIAbaxF1NSKpjgdZbo98lb1RRj6mPwjhtABFQKR5Y7G63FIngKmo8kiM
	TFtSWBZN9uXSmyDd7XKqFgPtW0JM38x1qqpX05IOkQC8/iNvliuPWpCqz8FbpUgRVQxSJx
	/UES1Lp5Wq/VHLRSW6XOQTsaIY3UmESF1ZAJ8Qu129MkxCdk6lzI5QRtHOEX9W6Krdscsc
	PgaR74V6SJ7DlCU6JPBLpQ5Rba+UuT//K23jY7FEU9q0R9q59D+b2futuEkOdg==
Message-ID: <6b8aebe7-495e-40e5-a99d-57f8f7b2e683@bootlin.com>
Date: Tue, 13 Jan 2026 20:24:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: freescale: ucc_geth: Return early when TBI found
 can't be found
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Pei Xiao <xiaopei01@kylinos.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Dan Carpenter <dan.carpenter@linaro.org>,
 kernel test robot <lkp@intel.com>
References: <20260113074316.145077-1-maxime.chevallier@bootlin.com>
 <d89cb3a7-3a55-4bdf-805a-b3386572b220@bootlin.com>
 <aWaSnRbINHoAerGo@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aWaSnRbINHoAerGo@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 13/01/2026 19:44, Russell King (Oracle) wrote:
> On Tue, Jan 13, 2026 at 09:16:29AM +0100, Maxime Chevallier wrote:
>> Hi,
>>
>> On 13/01/2026 08:43, Maxime Chevallier wrote:
>>> In ucc_geth's .mac_config(), we configure the TBI block represented by a
>>> struct phy_device that we get from firmware.
>>>
>>> While porting to phylink, a check was missed to make sure we don't try
>>> to access the TBI PHY if we can't get it. Let's add it and return early
>>> in case of error
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> Closes: https://lore.kernel.org/r/202601130843.rFGNXA5a-lkp@intel.com/
>>> Fixes: 53036aa8d031 ("net: freescale: ucc_geth: phylink conversion")
>>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>>
>> Heh that's what I get from sending patches while having mild fever, the
>> patch title is all wrong and should be :
>>
>> net: freescale: ucc_geth: Return early when TBI PHY can't be found
>>
>> I'll wait for the 24h cooldown, grab some honey + milk and resend after :)
> 
> A question - based on dwmac:
> 
> When implementing dwmac to support 1000base-X, the dwmac doesn't
> implement the _full_ 1000base-X, but only up to the PCS. The PCS
> provides a TBI interface to the SerDes PHY provided by the SoC
> designer which acts as the PMA layer.
> 
> The talk here of TBI makes me wonder whether the same thing is going
> on with ucc_geth. Is the "TBI PHY" in fact the SerDes ?

Yeah I think it is indeed.

> Traditionally, we've represented the SerDes using drivers/phy rather
> than the drivers/net/phy infrastructure, mainly because implementations
> hvaen't provided anything like an 802.3 PHY register set, but moreover
> because the SerDes tends to be generic across ethernet, PCIe, USB, SATA
> etc (basically, anything that is a high speed balanced pair serial
> communication) and thus the "struct phy" from drivers/phy can be used
> by any of these subsystems.
> 

True, and I completely agree with that. The reason I didn't touch that
when porting to phylink is that the device I'm using, that has a
Motorola/Freescale/NXP MPC832x, doesn't have that TBI/RTBI block, so I
can't test that at all should we move to a more modern SerDes driver
(modern w.r.t when this driver was written) :(

Maxime


