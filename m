Return-Path: <netdev+bounces-247635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 859A6CFCA39
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F195930022DA
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8725C27F18F;
	Wed,  7 Jan 2026 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U7RPDc9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44A23EAAF
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775146; cv=none; b=c9bAczsbbM7Rga5M3kCgBXWw1gDufblxVrzN26VXn0W8fmNPm6CLoR3Q2Htz9OFy/kVNposAw18gdcoD3rug0ZlTbCF+yVCmx4/GcyaHXi5j288P+MD08LnYAEb+EPy4RqJnceo3ZG5jh9wFNdJa01AZLmoQC/DO5FaU3sJraH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775146; c=relaxed/simple;
	bh=KpJ/XXmTE+QQE78s/1T6gQG2ZHWOMqVxErJGg3yYvao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHqQ01G5aEEVfuJjAaSBnSDYOr3+C6w7qGkfNstIIh3zqLW8Orz+UwZzgNKotOY58jnQmqAJG99Wwn5D62cro7vst0cQLGDFIb6TGZvVH+dBUgTVkcJXc+uJfDqB7joXi7LgXY+qUiz4mFMaEWfTiMowSZSi9rrKcuGeF7s1Jzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U7RPDc9l; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BF1C81A26C8;
	Wed,  7 Jan 2026 08:39:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 912BD606F8;
	Wed,  7 Jan 2026 08:39:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED8FA103C86DC;
	Wed,  7 Jan 2026 09:38:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767775140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QYeONbMPZsohq9VBaUL+fOZtixRXDsqHxHYEMCv0KqU=;
	b=U7RPDc9lUGFV9EfgCe5xJCH8kkFydm4o1dDmMUTz43CE7s8pO7CHQE+V7r767Zl7uFlXz+
	KXD2ZNLnCwFvJmzT+jW2MwHFSRJtrahjDtN0lA95Sg+NTbL4HlEkF9dtRm2Im0Z+a8WhbA
	zbmaJygHIMjwWrCxES+2G8gNwDKprMMZ00mzfrSBryxc8kb3VVEGPUDg1qwvgNnTL+lBAy
	Jp0t7HHqP4LLtUGFYpA2RghAhSw8u4uYUXwBTGRZavw8ejwRI0MUTWu8pCsiwossi5ppUf
	HEXW8J5vZhaTsExGvaoCuqppPPP+j7vqFa7nb2bAACYM9WwBTge5SFh6Lx6wPQ==
Message-ID: <e439e649-ca9a-4245-80bf-9f1749c5af3e@bootlin.com>
Date: Wed, 7 Jan 2026 09:38:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/9] net: stmmac: dwmac4: fix RX FIFO fill
 statistics
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
 <E1vdDi5-00000002E1P-24pm@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <E1vdDi5-00000002E1P-24pm@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/01/2026 21:31, Russell King (Oracle) wrote:
> In dwmac4_debug(), the wrong shift is used with the RXFSTS mask:
> 
>  #define MTL_DEBUG_RXFSTS_MASK          GENMASK(5, 4)
>  #define MTL_DEBUG_RXFSTS_SHIFT         4
>  #define MTL_DEBUG_RRCSTS_SHIFT         1
> 
>                        u32 rxfsts = (value & MTL_DEBUG_RXFSTS_MASK)
>                                     >> MTL_DEBUG_RRCSTS_SHIFT;
> 
> where rxfsts is tested against small integers 1 .. 3. This results in
> the tests always failing, causing the "mtl_rx_fifo__fill_level_empty"
> statistic counter to always be incremented no matter what the fill
> level actually is.
> 
> Fix this by using FIELD_GET() and remove the unnecessary
> MTL_DEBUG_RXFSTS_SHIFT definition as FIELD_GET() will shift according
> to the least siginificant set bit in the supplied field mask.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


