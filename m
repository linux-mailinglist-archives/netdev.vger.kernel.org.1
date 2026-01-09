Return-Path: <netdev+bounces-248412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D2D0841F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D51E3003187
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA86358D38;
	Fri,  9 Jan 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wMaJ5JcS"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02323590B9
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951526; cv=none; b=cshLK2gYmXcd6p2LApfqJNN2uirqkGFuM6O2J6Qn6VG4J8k5oVWOCidclKuf0iawFeLdkOczruoCYyjPSXD0QYB6LZZZaAHTVphJyyl98KW3nXo6q6GDnkKNNmrSascrxUpTOMBpSrn3lZV2hMtezKPN9Xpd6mc4MijxqwrLaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951526; c=relaxed/simple;
	bh=T4kWA/shHAgVSBpr8ogg2jejAMNpENBZ87rDBgVAvwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbwrfX3pDxgaD0rCN8Ov+aj64jdcldLNF19z70GfXd1dTQN8ivcY2BFlp+ZDVMkawGVi1e48bj2bpHbs5MCHCv6mo7QmDincDbTiHBUAnbAgdIgL4oh8eFfywl+mb9uTqGnd7ntz4DOR3KcPvihdN0eR9o/mcwwYkwnDTla+gtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wMaJ5JcS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 358FB1A273D;
	Fri,  9 Jan 2026 09:38:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 065EF60734;
	Fri,  9 Jan 2026 09:38:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3529103C87CC;
	Fri,  9 Jan 2026 10:38:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767951521; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JRAJH9fBOd961NcgKi+jmYxD8E+1gYZ7UQ1tbcQg+GY=;
	b=wMaJ5JcSagj3AqIWTTLy4J7dxcTi5IsBqHkOOvTasVGNFxUBD4SiXVZI2HmcxxwBv/kuUI
	BSGJRM9PewmgRHEVGRkvIBM35NmiKyUgvzOKc2uD9d3X/ykNySDf5CPmk+/zsXPxiIcMHV
	qoNcHKaPprGiQxYpVz+iSJtn6vkxcinKhTtjaRJJGV35EZmKwisNys51sjnfIlWTutnRHw
	yf9d9Xw9WjkzPkx5QO0JsTUlLTjOFJ5H9FHQEmu7303lFX/7664/YjGIXHAmvIVgTo0E4B
	SvjQTn574q8VxxYKIDE6QGXYNzVOTsG3FxksROn64h7QGSebxBDTeaYWd27B+Q==
Message-ID: <8f70bd9d-747f-4ffa-b0f2-1020071b5adc@bootlin.com>
Date: Fri, 9 Jan 2026 10:38:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac: Add a fixup for
 the Micrel KSZ9131 PHY
To: Stefan Eichenberger <eichest@gmail.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
 robh@kernel.org, Stefan Eichenberger <stefan.eichenberger@toradex.com>
References: <20260105100245.19317-1-eichest@gmail.com>
 <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
 <aVuxv3Pox-y5Dzln@eichest-laptop>
 <a597b9d6-2b32-461f-ac90-2db5bb20cdb2@lunn.ch>
 <aVvp70S2Lr3o_jyB@eichest-laptop> <aVvwOYce1CFOLiBk@shell.armlinux.org.uk>
 <aVv7wD2JFikGkt3F@eichest-laptop> <aWC_ZDu0HipuVhQS@eichest-laptop>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aWC_ZDu0HipuVhQS@eichest-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Stefan,

On 09/01/2026 09:42, Stefan Eichenberger wrote:
> Hi everyone,
> 
> On Mon, Jan 05, 2026 at 06:58:24PM +0100, Stefan Eichenberger wrote:
>> On Mon, Jan 05, 2026 at 05:09:13PM +0000, Russell King (Oracle) wrote:
>>> On Mon, Jan 05, 2026 at 05:42:23PM +0100, Stefan Eichenberger wrote:
>>>> Yes this is correct. ERR050694 from NXP states:
>>>> The IEEE 802.3 standard states that, in MII/GMII modes, the byte
>>>> preceding the SFD (0xD5), SMD-S (0xE6,0x4C, 0x7F, or 0xB3), or SMD-C
>>>> (0x61, 0x52, 0x9E, or 0x2A) byte can be a non-PREAMBLE byte or there can
>>>> be no preceding preamble byte. The MAC receiver must successfully
>>>> receive a packet without any preamble(0x55) byte preceding the SFD,
>>>> SMD-S, or SMD-C byte.
>>>> However due to the defect, in configurations where frame preemption is
>>>> enabled, when preamble byte does not precede the SFD, SMD-S, or SMD-C
>>>> byte, the received packet is discarded by the MAC receiver. This is
>>>> because, the start-of-packet detection logic of the MAC receiver
>>>> incorrectly checks for a preamble byte.
>>>>
>>>> NXP refers to IEEE 802.3 where in clause 35.2.3.2.2 Receive case (GMII)
>>>> they show two tables one where the preamble is preceding the SFD and one
>>>> where it is not. The text says:
>>>> The operation of 1000 Mb/s PHYs can result in shrinkage of the preamble
>>>> between transmission at the source GMII and reception at the destination
>>>> GMII. Table 35–3 depicts the case where no preamble bytes are conveyed
>>>> across the GMII. This case may not be possible with a specific PHY, but
>>>> illustrates the minimum preamble with which MAC shall be able to
>>>> operate. Table 35–4 depicts the case where the entire preamble is
>>>> conveyed across the GMII.
>>>>
>>>> We would change the behavior from "no preamble is preceding SFD" to "the
>>>> enitre preamble is preceding SFD". Both are listed in the standard and
>>>> shall be supported by the MAC.
>>>
>>> Thanks for providing the full explanation, it would be good to have
>>> that in the commit message.
>>
>> Okay thanks, I will provide the full explanation in the next commit
>> message.
>>
>>>
>>> The next question would be, is it just the NXP EQOS implementation
>>> that this breaks on, or are other EQOS implementations affected?
>>>
>>> In other words, if we choose to conditionally enable the preable at
>>> the PHY, should the generic parts of stmmac handle this rather than
>>> ending up with multiple platform specific glue having to code this.
>>> (This is something I really want to avoid - it doesn't scale.)
>>
>> From the errata from NXP it sounds to me like it is a configuration
>> issue by NXP. I checked the following ERRATAs from vendors where I have
>> access to:
>> - ST STM32MP1: not affected: https://www.st.com/resource/en/errata_sheet/es0438-stm32mp151x3x7x-device-errata-stmicroelectronics.pdf
>> - Renesas RZN1: not affected: https://www.renesas.com/en/document/tcu/ethernet-mac-gmac-function-issue-0?r=1054561
>> - Starvive JH7110: not affected: https://doc-en.rvspace.org/JH7110/PDF/JH7110_Errata.pdf
>> - NXP S32: affected: (ERR050706 under NDA)
>>
>> So from that I would conclude that it is an NXP specific issue and it's
>> not the full EQOS implementation that is broken.
> 
> I just wanted to check whether I should continue with the current
> approach or if I should instead enable the preamble in the PHY for all
> MACs. While I prefer the current approach, as the issue lies with the
> MAC rather than the PHY, I can also see the advantage of always enabling
> the feature.

My main concern was that we may end-up with a lot of different fixups
for the various KSZ-family PHY devices, especially since this feature is
sometimes undocumented.

I've gone through the micrel.c driver, and looked at the datasheet of
most PHYs in there, and so far I've found that to fix this issue, we
need to set :

KSZ9131 / KSZ8041: Register 0x14 bit 6
KSZ8061 / KSZ8051 : Register 0x18 bit 6

So in the end, the complexity appears to be a bit less exponential than
I originally thought, we may end-up with only a few fixups in this driver.

I'd say, I'm fine with you proceeding with this original approach as it
minimizes the impact and risk to break other setups.

I'm sorry for triggering this whole discussion only to get back to the
starting point :(

Maxime

