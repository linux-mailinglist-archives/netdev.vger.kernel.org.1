Return-Path: <netdev+bounces-289081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KlYFP8bC2o2DgUAu9opvQ
	(envelope-from <netdev+bounces-289081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:02:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF1D56E3FC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B871302A7F8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7546848B388;
	Mon, 18 May 2026 13:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A8480349
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112527; cv=none; b=fp5PxwN9dpZ4DC0RjLqARpXd2KFqsjNAwsx+XJTzcQ6mLnlr1Gums37VckIFapIoBlPgf8i5gu6E6Q5taWaiOkkC6eTuwtASsyjgVoJXdhci8WavdaxU61PuZhWlQW88zJnyFnvyY7AmlptjZZyViKIv4u3WxZTNAD0zQoRUKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112527; c=relaxed/simple;
	bh=VMOptizGQ70e+J7xxlCbq9mgAizi8a4WRjYduTd5ZK4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vDG7Iznj4Ru4BrGyF02ZFUHJhm1IEzn54PXow3STo4RAG6rFlBGluFyKrjUHYDHeiobzErcq+WZzwWYUdXnAhsqRzl43405goWUCgxKLqdWpi9VF+N7ssys4NB34IG0WFTtmItKaRtKueR/j9J8FZ2mAlvGlNxvFaUwA58LYOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso19597915e9.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112524; x=1779717324;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tizt3kVJ9HgwVYO0PwgdSdfIFIk0uWpRihhV5cyqjVQ=;
        b=GMeDCI764f/QKYJa+umQH5obDU21fn7T6tav7dF+KXi+27+YVcxw1nvM6N7SC5O4UJ
         ix1vtczvjbDYkBgL9dPg015HqW2gq/2SdGCVtI2HlADWl0SagQ4jbEEpNtaOzYuJg/JS
         QJ0edyUaVBeO8il26rGnDJTO0OCvmChRCvRCb70nItJtE9rxgICNDMF4obFyKaPfeWxd
         OtselVBpovkU/WZusE3JcYQqb5dSqM18Gzx3i4gWdPWJE/c5aZelXdIP+5vG8O1meb1m
         QbGGJGVC2y+5SqsRMG/hg5Jfo0AhLAmq3Wy58ro9jYiEJfofBK3p090Fr2YU08LcNR3j
         bLkA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ryq4MBJ4OtoRBkoIZhF+dc7cVORk7CUiWt3VgWE4eBoWpgN7ESo8BfuxeTeELr4nB/KmiyRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGB45FO5X9ysWaKponoLKwM5833x6OKpmK/XeE6PT9yOohecT
	o0ARsst/LE46CUu4yS1/GueA8lfXLkFR7ljm6CvoqKZuHsFsc2U+GCd3
X-Gm-Gg: Acq92OGAViA4f1uPrGg4SrTF+u7CRCWqTOG76Yo1OjusLRAxa7fNt+bat4BWzEPEEJC
	ERAwKK/A+qDB7D2856bJ3U7HBK/a+0zLXI1hIld9Fs8LoVooOI/xof3s+Db5zaM5svGebmrtUp/
	xpFL4P+N0ROCc3dB3k1eaQbkXD0nEDdxLx6bH6ZAhKoAP3fls01dMUcvYJsDVEtdBZrhPy88hJX
	X98eYfa5QFuxKQJWdKJKCAkGKwVjFxWNTsNrbz0pvCrT43qoThv9OTaWxI4UUB16hOUz4XpcfYF
	gksfwdPWk0lFYE6Jl9g2BPpbD34FedBMkBfnSSB6IDvf1W68ewYu0Kv/B2A3taKD9SMhNCKOtrJ
	e2jqnC7XcO4ydsaZV0RLy16GqvlTuVS8ptGsrQ/6Zg9uNXEa7JL6u37KfTlpjgS/CJJQ8pGIGdS
	zaJ4HPqF3hKTdJofsrzzVBmVDmfLWPv5Py2HuEoZYVH82kFjmU1gG787k=
X-Received: by 2002:a05:600c:3b12:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48fe61ed2cfmr223048385e9.22.1779112523670;
        Mon, 18 May 2026 06:55:23 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe79ce3sm85711065e9.31.2026.05.18.06.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:55:23 -0700 (PDT)
Message-ID: <30599c3d-66b5-4787-9ead-53ab716ba338@ovn.org>
Date: Mon, 18 May 2026 15:55:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Adrian Moreno <amorenoz@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
Subject: Re: [PATCH net 1/5] net: rtnetlink: fix link nsid reported when the
 link is local
To: nicolas.dichtel@6wind.com, Jiri Benc <jbenc@redhat.com>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-2-i.maximets@ovn.org>
 <20260518082138.37522db0@griffin>
 <8aa4e92d-0498-4335-b3b1-dabd7e507ed7@ovn.org>
 <5d4467d5-f081-4f7e-ac3c-9134ee8ddc6e@6wind.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <5d4467d5-f081-4f7e-ac3c-9134ee8ddc6e@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-289081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ovn.org:mid]
X-Rspamd-Queue-Id: DEF1D56E3FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 2:46 PM, Nicolas Dichtel wrote:
> Le 18/05/2026 à 14:11, Ilya Maximets a écrit :
>> On 5/18/26 8:21 AM, Jiri Benc wrote:
>>> Hi Ilya,
>>
>> Hi, Jiri.  Thanks for your thoughts on the matter!
>>
>>>
>>> IIRC this was added because Open vSwitch needed it. I'd expect most
>>> users that need to deal with cross-namespace detection to just switch
>>> to the given netns prior to issuing RTM_GETLINK; at least, that's what
>>> I'm doing in the tools I wrote.
>>
>> Yeah, that's also what other projects like FRR are doing.  It's a bit
>> of a hustle for multi-threaded applications, as AFAIK, there is no way
>> to just move one thread into a different namespace, so if many threads
>> are doing something with the network and you suddenly need to check
>> something in a different namespace, you can't really do that without
>> pausing all other threads first.  But that's a separate thing, unrelated
>> to the series.  I'm just ranting. :) 
> Hmm, not sure to understand. setns() is per thread (see man setns()).

Hmm, I got my wires crossed here with something else, I suppose.
Though CAP_SYS_ADMIN requirement may be an even higher barrier.

> 
>>
>>>
>>> On Fri, 15 May 2026 22:19:20 +0200, Ilya Maximets wrote:
>>>> But this doesn't work for link nsid in cross-namespace RTM_GETLINK
>>>> requests.  For some reason the code checks if the original device
>>>> and the link are in the same namespace and not if the querier's
>>>> namespace is the same as the link's.  So the logic becomes:
>>>>
>>>> - if NSID is not reported, then the link is in the same namespace
>>>>   as the queried device.
>>>> - if NSID is reported, then the link is not in the same namespace
>>>>   with the queried device.
>>>
>>> I'm not sure I would call this a bug; the original idea was to use
>>> IFLA_IF_NETNSID to switch to the point of view of that netns but
>>> without actually switching to that netns. Hence, the netnsid is
>>> relative to the caller's netns but otherwise, you get the same reply as
>>> you would if you switched to that netns. If you think about it that
>>> way, the current reply is consistent.
>>
>> It makes some sense, but the fact that all-nsid notification and the
>> cross-namespace RTM_GETLINK provide different IDs makes it inconsistent
>> in my brain.  We have:
>>
>> 1. nsenter(target) + getlink(local) = target-to-link nsid.
>> 2. getlink(target) = caller-to-target nsid  + caller-to-link nsid.
>> 3. all-nsid-notiication = cmsg(caller-to-target nsid) + target-to-link nsid.
> 
> all-nsid-notification appears before cross-getlink.
> The goal, for all-nsid-notification, was to be able to receive netlink messages
> of a subset of netns in one socket. So these messages are provided as-is, ie
> like if they were sent on a netlink socket opened in the corresponding netns.
> It's generic, there is no need to patch every subsystem.
> 
> cross-get*() have been added later. The chosen behavior is friendlier at the
> cost of patching every subsystem that is supported.

That's exactly my point.  If we're creating a special patch for a subsystem, we
don't need to adhere to the exact structure of the original message, since the
data reported changes anyway.

IMO, not reporting nsid that is the same as the caller's nsid is more friendlier.
But that's, again, just a difference in opinion at this point, I'll not insist.

Best regards, Ilya Maximets.

