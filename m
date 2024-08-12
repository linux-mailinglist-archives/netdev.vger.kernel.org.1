Return-Path: <netdev+bounces-117853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B202494F8E0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E520D1C21335
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9818E022;
	Mon, 12 Aug 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Arn2BC/C"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C618E051
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497556; cv=none; b=bRiS85frTtXamHkd8CcAxFb083Me2JDdgorvz3muYqzhPMH192BTqKzprfNppnz+oNSbeVpJG3IZfLdTqB18z7o10TjtH/t1t2KWP4sAFYOxk1cbEx1d9/oMu+H8Wjyg9cuSL7I737XZp4ZCa2vAlFN15GeJwR5UHGGgNU0Y22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497556; c=relaxed/simple;
	bh=e53tvHdn5hPV9zQka4cToYxsHZwE3pUqPwvDKfFQcZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCUZJ5KPnQNHLrIZg4HXIdaecnNYdQ87cFN8lXeK2F3celejBaoJacjDAN5fglCy4j5+fC6qqbGnhfa+mz5o/5F2n69p57U8tSnouYSW+b/eu0D1Ysq+pC0tx30kjn49tykpZUp8tJ6Y3nHso2xLqp+owg4G19ETpr1Rk8zKrMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Arn2BC/C; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb2dfba8-5f90-40e0-b9e8-64f975bd7e7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723497551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7SLYzQGySu/90iA+kCTpNsQhViKxnnp2PeJDYY1lvw=;
	b=Arn2BC/ClhBP6vXsgPJPBKEt1MRwKhlGJ6v3ilzMSGfKaqKW0mpxHjW58d7xrGqtiETwl/
	Ot+28u1T3UQX0+C8HBzurB+hS0PJy4fLu3iquuAUJn6lx73/pwnJwsThHMZ220q9g93rlA
	3hvTcFnPwGAIZkQPDWE71jx3AzdFdx4=
Date: Mon, 12 Aug 2024 17:19:06 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/2] net: xilinx: axienet: Add statistics
 support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>,
 Michal Simek <michal.simek@amd.com>, Eric Dumazet <edumazet@google.com>
References: <20240812174118.3560730-1-sean.anderson@linux.dev>
 <20240812174118.3560730-3-sean.anderson@linux.dev>
 <e78256f2-9ad6-49e1-9cd5-02a28c92d2fc@lunn.ch>
 <f1837494-7411-463f-b9f6-fbdd09217423@linux.dev>
 <70d817a8-5ee4-4ce2-883a-9e95f15f2855@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <70d817a8-5ee4-4ce2-883a-9e95f15f2855@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/12/24 17:18, Andrew Lunn wrote:
> On Mon, Aug 12, 2024 at 04:25:16PM -0400, Sean Anderson wrote:
>> On 8/12/24 16:22, Andrew Lunn wrote:
>> >>  static int __axienet_device_reset(struct axienet_local *lp)
>> >>  {
>> >>  	u32 value;
>> >>  	int ret;
>> >>  
>> >> +	/* Save statistics counters in case they will be reset */
>> >> +	guard(mutex)(&lp->stats_lock);
>> >> +	if (lp->features & XAE_FEATURE_STATS)
>> >> +		axienet_stats_update(lp, true);
>> > 
>> > My understanding of guard() is that the mutex is held until the
>> > function completes. That is much longer than you need. A
>> > scoped_guard() would be better here, and it makes it clear when the
>> > mutex will be released.
>> 
>> We have to hold it until...
>> 
>> >> +
>> >>  	/* Reset Axi DMA. This would reset Axi Ethernet core as well. The reset
>> >>  	 * process of Axi DMA takes a while to complete as all pending
>> >>  	 * commands/transfers will be flushed or completed during this
>> >> @@ -551,6 +595,23 @@ static int __axienet_device_reset(struct axienet_local *lp)
>> >>  		return ret;
>> >>  	}
>> >>  
>> >> +	/* Update statistics counters with new values */
>> >> +	if (lp->features & XAE_FEATURE_STATS) {
>> >> +		enum temac_stat stat;
>> >> +
>> >> +		write_seqcount_begin(&lp->hw_stats_seqcount);
>> >> +		lp->reset_in_progress = false;
>> >> +		for (stat = 0; stat < STAT_COUNT; stat++) {
>> >> +			u32 counter =
>> >> +				axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
>> >> +
>> >> +			lp->hw_stat_base[stat] +=
>> >> +				lp->hw_last_counter[stat] - counter;
>> >> +			lp->hw_last_counter[stat] = counter;
>> >> +		}
>> >> +		write_seqcount_end(&lp->hw_stats_seqcount);
>> 
>> ...here
>> 
>> Which is effectively the whole function. The main reason why I used guard() was to
>> simplify the error return cases.
> 
> This is why i personally don't like guard. It is not clear you
> intended the mutex to be held so long, and that this code actually
> requires it. An explicit mutex_unlock() here would make your
> intentions clear, or a scoped_guard. I can see guard avoiding some
> error path bugs, but i suspect it will introduce other problems when
> refactoring code and having to make guesses about what actually needs
> the mutex.

OK, I will go back to explicit lock/unlock for v3.

--Sean


