Return-Path: <netdev+bounces-168192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75167A3DFBE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC6270218E
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615D1FF1BA;
	Thu, 20 Feb 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JLURmxId"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F71CA84
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067280; cv=none; b=k/ltbdITlS0BlR+/4Kr52Kz9F5hd6xikOAWxke3acMip1v3tc56s5KueHVXqT7MTTEIJk0+0bkr8erKAv6yY0GAWUtJpN6FFjk5txfoVj6JMv1RXJ4D1incoHIHNzp5s4Cih/8kg0kMzXPnucvUUqpx6SPjYo/pyTCDYcyvxuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067280; c=relaxed/simple;
	bh=huwDF3uAX0KI8fq/a79jlQOWpzzQtcoSpfRxxgXD2G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N40RJ7pwJdx2ankt4lKRcRg9E0825NkUQ1OL/EebWRt/SfX8Hcu353/EEXjE+FItwJdMvB2yfchqIcsK+mLemghFAY1JKIqapy/EKc/8EGwkQgxjWUxgX8PFKkWfqXDL0LTv9YKQg/v6hC//A3DSa4SyvUhpagPTrT4bax8BPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JLURmxId; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <12896f89-e99c-4bbc-94c1-fac89883bd92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740067274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmO0ss3Ry5Ia25vcLoaRgESsskG8Cd8XasUtJ4JGgGI=;
	b=JLURmxIdIW4q1U4Pw8NO/i55W9hcPInymQfsKd90OBej7EngGTkb0v23+d5lVf3oX+DcaO
	HynCgnsReKgeweEFMV5OFQRVyJP2gOt37qqyep1lU66IBdHYF2+dsNP+H2eCB5F+zQzE7d
	PxbXb7lZByNk+LoNuhGeGC68voE1xqU=
Date: Thu, 20 Feb 2025 11:01:10 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics
 reporting
To: patchwork-bot+netdevbpf@kernel.org
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
 <173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/18/25 21:10, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Fri, 14 Feb 2025 16:27:01 -0500 you wrote:
>> Implement the modern interfaces for statistics reporting.
>> 
>> 
>> Sean Anderson (2):
>>   net: cadence: macb: Convert to get_stats64
>>   net: cadence: macb: Report standard stats
>> 
>> [...]
> 
> Here is the summary with links:
>   - [net-next,1/2] net: cadence: macb: Convert to get_stats64
>     https://git.kernel.org/netdev/net-next/c/75696dd0fd72
>   - [net-next,2/2] net: cadence: macb: Report standard stats
>     https://git.kernel.org/netdev/net-next/c/f6af690a295a
> 
> You are awesome, thank you!

I think this should be deferred until v2 of [1] is applied, to make
backporting the fix easier.

--Sean

[1] lore.kernel.org/netdev/20250218195036.37137-1-sean.anderson@linux.dev

