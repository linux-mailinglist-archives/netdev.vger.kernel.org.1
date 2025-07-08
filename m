Return-Path: <netdev+bounces-205040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6C0AFCF57
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FB1481EC6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A172D231824;
	Tue,  8 Jul 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ifMKTzzZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A82E03FE
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988856; cv=none; b=B3dvjsk3mpEXK3NuRMpUUG82Juncn7j2B67Zmon2zf+cYHkTOor6Sr8Kmbdgsi3nqfsaefKMFMrpJDVOKt6tjXf0z6B8iTxBdanW02LFEctjzuB4hpfGrfs9kstv0W3nhbMiVBB9lx7DDkYCy4FHAeTXVT4Bp4fw914shIjXLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988856; c=relaxed/simple;
	bh=ZhQARY+dMy04cmVCG3gKjNrTT6k7l5XUjHxmQQ3Odws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DM8tcWuKW0SsxJWh7b0pDedi8E5tBrqYCKM4v7+6jd8CXEUAnYCWkioIJzYPuvpf1e0MGzBvJ3CM1CR1rbKXJQqUraabmtFniDwMyQcOx2AXOQsfRjSweH5FeM6IlWrgb9LMTO2hcUeZwmt2CEvx8QVrpdyVMOvPozuP52ZfgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ifMKTzzZ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06710fb3-fc55-479e-b029-134f41fb93eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751988841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UikPezaKOR74LDrxg8ACKqHsuH0yXZu32wrnQNh+phc=;
	b=ifMKTzzZSNehwnTaGTAuaeH7r7ho9nFO+uR7Cs37lBKqjZPjj77jNkxFpkPFxX6gRmTI0p
	GKXquz0dWmM+t4G/M4xfAwNee465VUQrrPcm7XPOsi3UDS26Sqk2c/OHj4fEU/e/weWkSB
	IDum6qt7B0ZFVjFI6ycbReQeQ8GDsj8=
Date: Tue, 8 Jul 2025 11:33:46 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Christian Marangi <ansuelsmth@gmail.com>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
 <aGzduaQp3hWA5V-i@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aGzduaQp3hWA5V-i@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/8/25 04:58, Russell King (Oracle) wrote:
> On Mon, Jul 07, 2025 at 03:58:03PM -0400, Sean Anderson wrote:
>> If a PHY has no driver, the genphy driver is probed/removed directly in
>> phy_attach/detach. If the PHY's ofnode has an "leds" subnode, then the
>> LEDs will be (un)registered when probing/removing the genphy driver.
> 
> Maybe checking whether the PHY driver supports LEDs would be more
> sensible than checking whether it's one of the genphy drivers?

The genphy driver is special, since it is probed synchronously from
phy_attach. All other drivers are probed asynchronously and don't have
this problem.

>> This could occur if the leds are for a non-generic driver that isn't
>> loaded for whatever reason. Synchronously removing the PHY device in
>> phy_detach leads to the following deadlock:
>> 
>> rtnl_lock()
>> ndo_close()
>>     ...
>>     phy_detach()
>>         phy_remove()
>>             phy_leds_unregister()
>>                 led_classdev_unregister()
>>                     led_trigger_set()
>>                         netdev_trigger_deactivate()
>>                             unregister_netdevice_notifier()
>>                                 rtnl_lock()
>> 
>> There is a corresponding deadlock on the open/register side of things
>> (and that one is reported by lockdep), but it requires a race while this
>> one is deterministic.
> 
> Doesn't this deadlock exist irrespective of whether the genphy driver(s)
> are being used, and whether or not the PHY driver supports LEDs?

Nope.

--Sean

