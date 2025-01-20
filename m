Return-Path: <netdev+bounces-159785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 473ABA16E63
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA6F3A40EE
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8011E0E0A;
	Mon, 20 Jan 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="NnjPjrjZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F71DEFD4;
	Mon, 20 Jan 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382992; cv=none; b=NRSAuAR6Lzwe1QgUSIuvD51sp8uC6dHMF8k83URWrY6qp4RNFyCQ4Q4MK5xLx/wxYJd6BH7uCDkqU/BBxxWnNPsKUH+2UrUz6R9iPZg1ZsUBiMnx2TWF0X06WN7VOBFWvbMELjOyPogaulQLFS8crb9rQ8HqPdfD6tX2YxRkSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382992; c=relaxed/simple;
	bh=AesDXrVBow2F+80GAvVShsFcaLr9SUV0R9n/HpToTKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZqne4RhNWiuPdk+psdQ8gKKmIgZ6jy7Rq34ZahmTZY0gw7w3CkmaJVbzVC0gUP1T4E2HQBQQvXtk4rVIRBg3SR3mREByUfRKeyUZiRQILYjka/XmwK8SghMI6l5xuj932udb5Bxv6HBnzhEau0F7cM+AsUAOEAtEFLhwDpAwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=NnjPjrjZ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87E131040DBF6;
	Mon, 20 Jan 2025 15:23:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737382987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9Rkky1y7To39aNMDd2svVkpqBnuTsV1oius/xd9Aio=;
	b=NnjPjrjZJN0BZ2XCvSE7bvm3saKJtGgdWN8acbGzRPH1fwFK1DCxP3EuW+scr1vtBSHtZH
	FGk9CtwIBlI1XuZU315slW1xTmBu4BoSYfKtJWUlskq27OY3yuWDHJ+EPLWgy7RclhfOUD
	U5sXve2oZQsg7PGphWVc4/Zg5cokjT/eBEbkA2l6r9NTMSAQ9/WC7nzGpXoqZ+hTjAjaCK
	OrYKiLmabD0OI0VI65Yz0iWzhVRdpyVgoemFqPiO7NMCc2NhZEC1/JeH7b37p8TH+nQ8WZ
	aZk1shopcGmlG1npzOhK1b3Z9miX0TnYAd6vkqtfK7z0vFNZl658/m652ngOGA==
Message-ID: <953ad608-8be7-42e6-9162-05a98a42eb21@denx.de>
Date: Mon, 20 Jan 2025 15:20:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 2/2] net: phy: micrel: Add KSZ87XX Switch LED
 control
To: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Tristram Ha <tristram.ha@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, linux-kernel@vger.kernel.org
References: <20250113001543.296510-1-marex@denx.de>
 <20250113001543.296510-2-marex@denx.de>
 <4d02f786-e87e-4588-87ed-b5fa414a4b5a@redhat.com>
 <ef933bd4-b9ae-4f78-8f05-abd1d2832bf8@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ef933bd4-b9ae-4f78-8f05-abd1d2832bf8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 1/16/25 2:23 PM, Andrew Lunn wrote:
> On Thu, Jan 16, 2025 at 10:58:38AM +0100, Paolo Abeni wrote:
>> On 1/13/25 1:15 AM, Marek Vasut wrote:
>>> The KSZ87xx switch contains LED control registers. There is one shared
>>> global control register bitfield which affects behavior of all LEDs on
>>> all ports, the Register 11 (0x0B): Global Control 9 bitfield [5:4].
>>> There is also one per-port Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3
>>> Control 10 bit 7 which controls enablement of both LEDs on each port
>>> separately.
>>>
>>> Expose LED brightness control and HW offload support for both of the two
>>> programmable LEDs on this KSZ87XX Switch. Note that on KSZ87xx there are
>>> three or more instances of simple KSZ87XX Switch PHY, one for each port,
>>> however, the registers which control the LED behavior are mostly shared.
>>>
>>> Introduce LED brightness control using Register 29/45/61 (0x1D/0x2D/0x3D):
>>> Port 1/2/3 Control 10 bit 7. This bit selects between LEDs disabled and
>>> LEDs set to Function mode. In case LED brightness is set to 0, both LEDs
>>> are turned off, otherwise both LEDs are configured to Function mode which
>>> follows the global Register 11 (0x0B): Global Control 9 bitfield [5:4]
>>> setting.
>>
>> @Andrew, @Russel: can the above problem be address with the current phy
>> API? or does phy device need to expose a new brightness_get op?

Sorry for the delayed reply.

> Coupled LEDs cause issues. Because vendors do all sorts of weird
> things with LEDs, i don't want to fully support everything every
> vendor has, or the code is just going to be unmaintanable. So we have
> the core support a subset, and some features of the hardware go
> unused.
> 
> In this case, i would say software control of the LEDs is
> impossible. You cannot individually turn an LED on/off. The core
> supports this, Heiner added support for a PHY with similar issues. I
> think it is as simple as not implementing led_brightness_set().
What about the LED functionality configuration ?

I think the main issue here is that multiple LEDs exposed in sysfs 
control the same bit(s) in hardware, and the sysfs attributes behind 
those LEDs can get out of sync.

One alternative that crossed my mind would be to register single LED in 
the KSZ87xx switch driver to control the LED functionality, and per-port 
LED to control the per-port LED enablement (=brightness). It does not 
model the hardware accurately, but it does avoid the complexity.

Otherwise, what is left would be custom sysfs attributes for this switch?

