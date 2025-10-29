Return-Path: <netdev+bounces-234037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E9C1BA16
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784F7583A5B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC822E62D0;
	Wed, 29 Oct 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D8FpEFXm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37B2DC76F
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750417; cv=none; b=Pb1LpivEp5VzU23apev0MNWYq6kOlbUpTAoFHvajv9US0rSiTDz7s1jBFCn0kGY7PCo4p5kUmeENNONQ+eGqcGOZdW7fM5aF7yE6O9JMvCFgaxpt7OkNLhfEwUhRkXs/56o0KhSCVGaU3G6RbhHxgP4Fp23LKrGyTrI2MahWCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750417; c=relaxed/simple;
	bh=sbP76ZccqYBcT5G3vhjCWTl19JAdNGbIi+mbAkqJuY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=socZNwES4KqQq/1/hN7/Z2KJY5fjQq5oeL/wpkb1rsBUUWeTS75PG0WApxZfwwOv8k7T+c6fk01IjClHbmYPVpp4ZFm1/iWRAJk4FL+b0QtxKe1SJdCmclRae96PLb3/E0rp71BdQhnl64nrLh+Kqn32Q6BhaCOfxq/Odf+8FpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D8FpEFXm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 846C74E413CE;
	Wed, 29 Oct 2025 15:06:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49CAA606E8;
	Wed, 29 Oct 2025 15:06:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 301DF117F8229;
	Wed, 29 Oct 2025 16:06:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761750411; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/Nw6Y6Sr0yR7McdjN8jB2CldXstC1tCci1tzXd/HAvg=;
	b=D8FpEFXmjMF4R+aWYMbORindagatYBKwV/YIrHsuRMZ8cek3j1pjCNLb9U2Sf67BGYvyJ6
	/EoLZqLjt2+v74Au2HsINS06LScrLZlo/dV/MblC1t1KCPQt8l6qQrdPPm+Mm1pU4fmDgs
	P3ibVon21ooaDqIxYi/vNhy+KdtvBMlxUybFEa9l3dKYojcO8g2wfPthhgGN2+8VcOWjYl
	VM83huEwodh6AgYJDFP870reTD9JKQ6dncAtSv/87ZF6LkjLvz/yeGfXdy11i5A337JEFY
	OEHl2e3gDtAfG1RYv/LMdJPw+qgZurNkvESt5wOlCl9lybM0srT8577QXB+QhQ==
Message-ID: <d4b1c65d-17d2-4f41-b559-9cae55993f6e@bootlin.com>
Date: Wed, 29 Oct 2025 16:06:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: stmmac: socfpga: Add hardware supported
 cross-timestamp
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
 <20251029-agilex5_ext-v1-4-1931132d77d6@altera.com>
 <07589613-8567-4e14-b17a-a8dd04f3098c@bootlin.com>
 <ed9e4ffb-3386-4a22-8d4c-38058885845a@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <ed9e4ffb-3386-4a22-8d4c-38058885845a@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Rohan,

On 29/10/2025 15:41, G Thomas, Rohan wrote:
> Hi Maxime,
> 
> On 10/29/2025 3:20 PM, Maxime Chevallier wrote:
>> Hi Rohan,
>>
>> On 29/10/2025 09:06, Rohan G Thomas via B4 Relay wrote:
>>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>>
>>> Cross timestamping is supported on Agilex5 platform with Synchronized
>>> Multidrop Timestamp Gathering(SMTG) IP. The hardware cross-timestamp
>>> result is made available the applications through the ioctl call
>>> PTP_SYS_OFFSET_PRECISE, which inturn calls stmmac_getcrosststamp().
>>>
>>> Device time is stored in the MAC Auxiliary register. The 64-bit System
>>> time (ARM_ARCH_COUNTER) is stored in SMTG IP. SMTG IP is an MDIO device
>>> with 0xC - 0xF MDIO register space holds 64-bit system time.
>>>
>>> This commit is similar to following commit for Intel platforms:
>>> Commit 341f67e424e5 ("net: stmmac: Add hardware supported cross-timestamp")
>>>
>>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>

[...]

>>> +	/* Time sync done Indication - Interrupt method */
>>> +	if (!wait_event_interruptible_timeout(priv->tstamp_busy_wait,
>>> +					      dwxgmac_cross_ts_isr(priv),
>>> +					      HZ / 100)) {
>>> +		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
>>> +		return -ETIMEDOUT;
>>
>> Don't you need to set priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN first?
>> Otherwise, timestamp_interrupt() in stmmac_hwtstamp() won't call wake_up()
>> on the wait_queue.
>>
> 
> Thanks for pointing this out. My intention was to use the polling
> method, but I accidentally left behind some code from experimenting with
> the interrupt method. While reverting those changes, I missed updating
> this part of the code. Will fix this in the next revision. Sorry for the
> error. Currently not seeing any timeout issues with polling method on
> XGMAC IP. Also some spurios interrupts causing stall when using
> the interrupt method in XGMAC.

So, if you use the polling method, this will likely bring this code
even closer to what's implemented in the intel dwmac wrapper. Is this
the same IP ?

To me it looks like the only difference will be a few
register offsets (XGMAC vs GMAC), some clock id and the mdio accesses,
maybe it could be worth considering re-using what's been done on the
Intel side and avoid duplication...

That could be all moved to stmmac_ptp for instance, using some flag
in the plat data to indicate if cross timestamping is supported, and
use the core type (xgmac, gmac, etc.) for the offsets ?

Of course with the risk of regressing dwmac-intel.c :(

Maxime

