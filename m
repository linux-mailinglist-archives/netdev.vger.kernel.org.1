Return-Path: <netdev+bounces-249583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DCDD1B467
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B4930E90D5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDFB30F95E;
	Tue, 13 Jan 2026 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mt8lscux"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D982FDC35
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336945; cv=none; b=oAFMRW/RUiRGh5M0mNJxkCntPnoWEvU/UgG6FzAbPwRnwGHTWk5rQa9HI3wn6XQbn1BmUoh9pmex43D2vJZJc5PhRJDXwKArqcHBrZFpN6xlrdaBaPHlqYdozZ8l7IAYc+jknag55jy339UWfcFc8wx974z2T0/NGwIhYEjrz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336945; c=relaxed/simple;
	bh=UXHnLhupGtqjRAzAntnkj9uxUYcrazS8cJ+io8NXQEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnmXcRFBv97wg2/mqqan5/rSn+CmB+9YDICVvwarL6birz4A6iH7iBEI4teChjlvM5wF5lSasm34HtJlUUe+rWNWmY23miXP/mP7ayub97Azzj9qW5T+JAdwV4ftnUCo0anruICyUH61fg57hLvkV1A37EOnMYjw3M2JKwvuwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mt8lscux; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 980C7C1ECB5;
	Tue, 13 Jan 2026 20:41:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 015F860701;
	Tue, 13 Jan 2026 20:42:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8B74103C8516;
	Tue, 13 Jan 2026 21:42:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768336939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fnkEvyTsfBoXP0YgwuOjsk3/Xv+b54KBkYtfEw+96xU=;
	b=mt8lscux4bYZ22tNIJoS1PHq+74DAfQZ11meqCpS6mTEyVR6N1GRRm5nsgyTBnVT6ayAsl
	jSXaAWVRBMgkKD4aH8cWZo+ooG0XUshTdPyEpKMXs7U3hTN/gVRW1OFMcmrD4MVqNORaLF
	hyIIvqbp0aZCkn7cab96M+pzBG0xitQR5OYzxtZdgY3OsgJ82tLpMoFhPYYASl66o2GksE
	ZbmV74zdCS3MsJkdDsaquH4UL3K/aAlF0nIQt52PSLDTV4/Mwqpe60obJpoVpdH8LwrvNy
	gHj8E3OfrYqWTP3kdUF6NqIw8Ii8gZJ2xPB5149vRr00x/TXgylo34VcqJx15g==
Message-ID: <0c321643-eb54-494e-901e-45829e57938d@bootlin.com>
Date: Tue, 13 Jan 2026 21:42:09 +0100
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
 <6b8aebe7-495e-40e5-a99d-57f8f7b2e683@bootlin.com>
 <aWalAMC2FWKlXK0E@shell.armlinux.org.uk>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <aWalAMC2FWKlXK0E@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 13/01/2026 21:03, Russell King (Oracle) wrote:
> On Tue, Jan 13, 2026 at 08:24:49PM +0100, Maxime Chevallier wrote:
>> Hi Russell,
>>> Traditionally, we've represented the SerDes using drivers/phy rather
>>> than the drivers/net/phy infrastructure, mainly because implementations
>>> hvaen't provided anything like an 802.3 PHY register set, but moreover
>>> because the SerDes tends to be generic across ethernet, PCIe, USB, SATA
>>> etc (basically, anything that is a high speed balanced pair serial
>>> communication) and thus the "struct phy" from drivers/phy can be used
>>> by any of these subsystems.
>>>
>>
>> True, and I completely agree with that. The reason I didn't touch that
>> when porting to phylink is that the device I'm using, that has a
>> Motorola/Freescale/NXP MPC832x, doesn't have that TBI/RTBI block, so I
>> can't test that at all should we move to a more modern SerDes driver
>> (modern w.r.t when this driver was written) :(
> 
> Over the last few days, I've been adding "generic" stmmac SerDes
> support (which basically means not in the platform glue) to replace
> the qcom-ethqos stuff, and while doing so, the thought did cross my
> mind whether I should be adding that to phylink rather than stmmac.

You mean controlling the generic PHY (phy_power_on / off,
phy_set_mode_ext and so on) from phylink instead of the MAC driver, like
we also do in mvneta / mvpp2 ?

That would also interest the Meta folks working on fbnic I guess :)

Maxime


