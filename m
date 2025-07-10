Return-Path: <netdev+bounces-205906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B074CB00BBF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62031CA77B1
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1532FCFF8;
	Thu, 10 Jul 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uYgkoNgp"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5A2FCFCC
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173888; cv=none; b=oWxTwflh/YqoHK78WekXL7CvdGkPJSrkIAwiLZDPB19FICjfWDYAdi/aRqWBsa/DTClGC3cO6tLdPn6Mem/zYjrzdO40DLb8WFOvz7a4hnQ3f+DVCJLn+N0i0BjHFPIWD2v9IWMn4zZEbGziacHWwrlvAmX+d7LILnRWCyyhrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173888; c=relaxed/simple;
	bh=J0z41YcdNDhVPc+tQ5S6Lf7LTq+A2yBhKUx5z5lEi+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn+7hDj5p/ZzBI3HuShIeuU1d07Th6KCp1ryyWfyqwHR7bDwvFkWQR76QeoZjvvhVfS3LnWWSxg3mf7Uu5xCcMA9hgQkTvxKKPu22yPvBhsjDDnoMbSVgIkbrYkdZTVahq9gg+UmuN4AuhnfFkoZ7xUSlgwj0vTqxQkxaWtoag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uYgkoNgp; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <85f00716-4cd7-410c-a4c7-8efd52e04ec8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752173872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UGN69Aqip2Ei+wODLe/q5fPyeWewM2lkK4zpVKbxqX0=;
	b=uYgkoNgpaJ+NoFGgTAUxLPrD5UqRvwse3gJ3y6mIRX7bOZEjUZi4FvmZfx4R5tP6QaTxTY
	+B5g7VqdmJiih7IwQ39ApUJrzW0LjeShNJbsAn4ZL9knSp+ZxrCogtFCFvC34gwAWaZ//n
	3B/nCKt5OKpbtTU7l3bm0tGZgaAlupk=
Date: Thu, 10 Jul 2025 14:57:48 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
 <20250707163219.64c99f4d@kernel.org>
 <3aae1c17-2ce8-4229-a397-a8a25cc58fe9@linux.dev>
 <1019ee40-e7df-43a9-ae3f-ad3172e5bf3e@linux.dev>
 <20250710105254.071c2af4@kernel.org>
 <04583ed9-0997-4a54-a255-540837f1dff8@linux.dev>
 <20250710114926.7ec3a64f@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250710114926.7ec3a64f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/25 14:49, Jakub Kicinski wrote:
> On Thu, 10 Jul 2025 14:17:18 -0400 Sean Anderson wrote:
>> On 7/10/25 13:52, Jakub Kicinski wrote:
>> > On Thu, 10 Jul 2025 13:40:33 -0400 Sean Anderson wrote:  
>> >> I see this is marked "Changes Requested" in patchwork. However, I don't
>> >> believe that I need to change anything until the above commit is merged
>> >> into net/main. Will you be merging that commit? Or should I just resend
>> >> without changes?  
>> > 
>> > The patch must build when posted. If it didn't you need to repost.  
>> 
>> It builds on net/main. Which is what I posted for. The CI applied it to net-next/main.
> 
> Damn, I see your point now, sorry :/
> So in net-next we'll have to drop the phy_driver_is_genphy_10g() ?

Yes. I believe phy_driver_is_genphy() is sufficient in net-next.

> I think it may be best if we turn this into an explicit merge
> conflict, IOW if you could post both net and net-next version
> I will merge them at the same time. Upstream trees like CI or
> linux-next will have easier time handling a git conflict than
> a build failure. Does that make sense? For the net-next version
> describe it from the perspective of the net patch already being
> merged and you're writing the "-next" version of the patch.
> I'll edit in the git hash of the net commit when applying.

OK, so if A is this patch and B is the conflict above, you'd like me to
post an A' like:

     B---merge---A' net-next
    /   /
base---A            net

? Or did you have something in mind more like

     B---A' net-next
    /
base---A    net

--Sean

