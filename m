Return-Path: <netdev+bounces-119105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8648B9540D6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B3C1C21088
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C047E0E9;
	Fri, 16 Aug 2024 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="beVfNyYv"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33C77105;
	Fri, 16 Aug 2024 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784638; cv=none; b=rcSVJRgDOzNLH/LTUEcXSj8B++SjmOStPXaMwrgAebTvBgj8tKAdIf5QJQTMyQDj1csHOJ8j8wqa1jhZPHfvJCHnuLeT1T8wxAIthOm0949xcuJfwAQOGlKGvJbknUOXIQ8CN9SVkWVQtuZ91h0tuctlDpAD///DpcycXEXbFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784638; c=relaxed/simple;
	bh=B5pKNxQq47mR1PSLdcFE+nJoBZ1+Ub4soJBgBS4ov9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJMOo7XGgN5LJdy4znc9ptWa76z2BGyI3fNu9JdptEsAMb3ikSFzNczF7gv9iguX9XrMAU8yKuN+3mLI5rJzpHJ9OqbRb794EWWcnmLZ14Y/MTH7EgVpDbika3jhGDPWRs8F8HwR82iGiHKIrfkSENv6axx+aoZIEyEUbSjl1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=beVfNyYv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=6amONoml4yC14YwrkWl2obGeotHupqEWZAFYL4LGlHQ=;
	t=1723784637; x=1724216637; b=beVfNyYvbamdSaMXvR0Ra+hNh5mWyHg+RCXT5X3uNA0s9kv
	JSfyGPoZmi1xIdil4m+VN4bFIN42T6fm6n7OyjssL1G9K6caZr2RWgebbi5hWBpGef8o4KACEec4l
	GE/JwOfVCo/MKz5v+kEWJm17/fy/0pGBw6Of/HgxaAerUx7jIKKFR5qf4r9GBSwPnNCAWLqy/0PZG
	O+gLI7Bgv/U643nZnFdyRXKVsfFtFNPgy61afkz1C5/NDTnt83zPCRbr+LvHJ/eCbSdOuRCs6AZh5
	EWwDp6KMMvAFuXitJSB18gNas4mwGCTMBRDbKd04LAOUmFel2fQ5ODYpMcpGbZqA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sep7u-0002Ah-Q9; Fri, 16 Aug 2024 07:03:50 +0200
Message-ID: <a3ba7028-b6c8-4d0d-b53a-8ecf9e69978c@leemhuis.info>
Date: Fri, 16 Aug 2024 07:03:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
To: Darren Kenny <darren.kenny@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Takero Funaki <flintglass@gmail.com>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
 <m2r0aqrsq6.fsf@oracle.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <m2r0aqrsq6.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723784637;33b23499;
X-HE-SMSGID: 1sep7u-0002Ah-Q9

On 15.08.24 12:22, Darren Kenny wrote:
> On Thursday, 2024-08-15 at 09:14:27 +02, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 14.08.24 08:59, Michael S. Tsirkin wrote:
>>> Note: Xuan Zhuo, if you have a better idea, pls post an alternative
>>> patch.
>>>
>>> Note2: untested, posting for Darren to help with testing.
>>>
>>> Turns out unconditionally enabling premapped 
>>> virtio-net leads to a regression on VM with no ACCESS_PLATFORM, and with
>>> sysctl net.core.high_order_alloc_disable=1
>>>
>>> where crashes and scp failures were reported (scp a file 100M in size to VM):
>>> [...]
>>
>> TWIMC, there is a regression report on lore

Obviously I meant bugzilla here, sorry.

>> and I wonder if this might
>> be related or the same problem, as it also mentioned a "get_swap_device:
>> Bad swap file entry" error:
>> https://bugzilla.kernel.org/show_bug.cgi?id=219154
> 
> I took a look at the stack traces, they don't look similar to what I was
> seeing, but I wasn't running with an ASAN enabled in the kernel.
> [...]

Yeah, but in the end it seems it is the same problem: The reporter,
Takero Funaki (now CCed) meanwhile performed a bisection that ended up
on f9dac92ba908 (virtio_ring: enable premapped mode regardless of
use_dma_api) -- and later confirmed in bugzilla that reverting the three
patches resolved the problem. Feel free to CC Takero on further mails
about this.

Ciao, Thorsten

#regzbot report:
https://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com/
#regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=219154

