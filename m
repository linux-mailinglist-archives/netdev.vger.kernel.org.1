Return-Path: <netdev+bounces-168218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142AA3E263
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A1B188FD0B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545A1FECD1;
	Thu, 20 Feb 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iRNg0YLh"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A431DF749
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072318; cv=none; b=CAEe0Gm1bzWtwuRRXhQEb4DoQZNyf+uGEONCHmPkoJo8HS3txRECzfCUA5pRjCDjQqzpEJcAPNzi5ESoqLwmM6pcxnnBGafz4n5ZvJDYStwoygIhK1HHb48uacJ1UzW5aYXigyujyObK56rWch6glAVLA+NfJuvtY8ItOvlOiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072318; c=relaxed/simple;
	bh=jbt1ZIdVSrtrn/KdgiB7VmvFDiGkcZBDX/JaQIuGa9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dny0nysK67SBtZagTRqBSG21OOzyKfVsWv/oNQLG6WCbah2t3Qv0CbABLEVJMnW5OcVwj5GLZRKYZO2rw1/B34dV7nbB9gKlDW2YZfMKWNZNclJMSRFLUWaBkLzOMToQpzz57Rshvk6gLOC1ASSneac6B/v3HZBJDtcntJ2ny1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iRNg0YLh; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <561bc925-d9ad-4fe3-8a4e-18489261e531@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740072313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thlQRcvUZl5hiFgXBeuEk61s7412QGqh37njY5u7smc=;
	b=iRNg0YLhXSzSxwy2ZC1oTYzoUWX/l1b3/jY4ZTg5DWg+K9KTr5/m3QUykFaRZ//CIT+15e
	DwWP7v3CKGMafCn1e8AKqkv3PBuc/InHEtgJ2qvPfuKE8P/WdcuNAPkMwMg/kdKvtGo7CF
	lb4OH+S3adWa9O4oCOMnB5wyNSf/O0M=
Date: Thu, 20 Feb 2025 12:25:09 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics
 reporting
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
 <173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
 <12896f89-e99c-4bbc-94c1-fac89883bd92@linux.dev>
 <20250220085945.14961e28@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250220085945.14961e28@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/20/25 11:59, Jakub Kicinski wrote:
> On Thu, 20 Feb 2025 11:01:10 -0500 Sean Anderson wrote:
>> > Here is the summary with links:
>> >   - [net-next,1/2] net: cadence: macb: Convert to get_stats64
>> >     https://git.kernel.org/netdev/net-next/c/75696dd0fd72
>> >   - [net-next,2/2] net: cadence: macb: Report standard stats
>> >     https://git.kernel.org/netdev/net-next/c/f6af690a295a
>> > 
>> > You are awesome, thank you!  
>> 
>> I think this should be deferred until v2 of [1] is applied, to make
>> backporting the fix easier.
> 
> ETOOLATE :) networking trees don't rebase

Well, I was expecting a revert and then I would resend this series once
the linked patch was applied.

I guess I can send another patch adding locking?

--Sean

