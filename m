Return-Path: <netdev+bounces-168243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5CA3E3B6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EDB188E43A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53C1213E99;
	Thu, 20 Feb 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IPeycfyN"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A01FDA7B
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075763; cv=none; b=uU+gg0vWXbEbXALAT7lL+dfc6fNn6GD/ddZn3lq3mt1ydWBCEbaTl2sJAZqTOphYIaRwBIWRpBX5jJY9SAIsWJD5pYs4JH0xF2EY2y7SwbPM7RvA5NvMsFbSf8tZ9YclqqYbLSxFGurmUiLdNI4mftyGZrjHdd6vzHM0fO+T03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075763; c=relaxed/simple;
	bh=qBWK5kYZcd83GJD82fFReI1Usi4+F+PBe1mYXLo9kqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkxruWR//oVWUbbrm/EnWEq1u+wExHMTC7+BYIuPnBM1bQ/T2vzdEzVRDCJJrTEm6l3KkmSlnmUorLZ3d3dPTck8A7eGquRPeksa5aczsRg1UOoNf1CO6/w6YayFpGS0RMPySN9f5xDGoBBuKjpwSTu9CYRe6VPQQW4fNGIkgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IPeycfyN; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1510cd3c-b986-4da2-aaa3-0214e4f43fe6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740075759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+cbwT2gXo7O2mJ+N8Gq4z4dYJ/KyzDKGpgQuR2C/hA=;
	b=IPeycfyNg2BRNRaRL9arODJWPT7mWC9FrxCrUQcksmroP4mB9N0x8yTblkPpx+zBtO9lb0
	DKEMVWfQboWDYcZ5TXIlf8iv7pYP57Zzk7zTV3i7wT+L2jUMn4ghdi80tmy+3jBrdXk48/
	RM6BvKGvHouizaSwLR7tV4RsQO9Lve0=
Date: Thu, 20 Feb 2025 13:22:29 -0500
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
 <561bc925-d9ad-4fe3-8a4e-18489261e531@linux.dev>
 <20250220101823.20516a77@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250220101823.20516a77@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/20/25 13:18, Jakub Kicinski wrote:
> On Thu, 20 Feb 2025 12:25:09 -0500 Sean Anderson wrote:
>> >> I think this should be deferred until v2 of [1] is applied, to make
>> >> backporting the fix easier.  
>> > 
>> > ETOOLATE :) networking trees don't rebase  
>> 
>> Well, I was expecting a revert and then I would resend this series once
>> the linked patch was applied.
>> 
>> I guess I can send another patch adding locking?
> 
> Assuming the fix is applied to net:
> Will the trees conflict?

Yes.

> If no - will the code in net still work (just lacking lock protection)?
> 
> If there is a conflict you can share a resolution with me and I'll slap
> it on as part of the merge.

OK, what's the best way to create that? git rerere?

--Sean

