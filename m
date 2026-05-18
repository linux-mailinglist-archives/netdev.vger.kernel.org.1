Return-Path: <netdev+bounces-289026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AMFFMIEC2rd/QQAu9opvQ
	(envelope-from <netdev+bounces-289026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:23:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54356C8E1
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F95D316746C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283193FD95D;
	Mon, 18 May 2026 12:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2983FD95C
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106278; cv=none; b=oR2VlltktBQmaDO5n/rWajLm/Fw0XN3dbdPGzbPT9KWCa3A1D4QX98ayf3xhaVD42J9E8NZ4VfbuT8jazmIK5E/isHY6aIJLXMtb6yNprXMM0JwpCYh3wy5AK7hhp31Me1nWRiGCI6j7hRnfxg6vy2lFs+2luGpbC9YwQY67B2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106278; c=relaxed/simple;
	bh=stWDEXVrJb7nH9v5erBY7Q5HYITTVPev8X+sqri2Bp4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qt8oivp0MJXIjQnrWeiYPp3VmoJlbSFIPTp0NKliGrQIx0kkBNxw04jK8VGPPfonifaSOXWRxoH1boRorLEcHvp0CnUGwYrg5Oq5Et44CzuAN/A0L4/U3twCZBt/cgKGBgXOao1A+jUTGyUgXvCJuXq73sMDTZwzk14GhTtDKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso10534495e9.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106275; x=1779711075;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IQcGTrVxDuxORq2Q5c0LGjtsjAN1LSWBwIhHTUpfh0=;
        b=i2f09ovlB0i8U8QOuYjqeJUs7nL6vTKflZCdPytB6eaeJqfs/rpSoQmLG/BRCRp6b2
         ThhTED9lGv7RwIRsHYQFbi4kDF2FSsn6DMGsHWwN08pojSB9FmEmAsTqAa0I3siHLXcX
         DRp87Wl+7BR0H0wMzADBSr1PJkPhS1wiGuq8abaWqn5SwXf+Hc73FFat2yrbjHNDkJpZ
         vedVKgRzQ/qUTeC/IJAXoWaxXuBXvm36ITRu5Y3LTYCHZijKA4VwEXfhseL+Ocq6GIjE
         WgoXikWoQAJGlPOBMHtIEH84YjqMw3U6mrRd8nz3maWMETMTiqEBG8/2f9NUTYIW2o0m
         fcDA==
X-Forwarded-Encrypted: i=1; AFNElJ+HSDLrU0qvXVQApU70RLimoUUI8fD4Bw0Y1pcyUx0bNcw85GuIHkJWf2yLfYWps/ZXxI3BM0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcg1fuUQV7hoH0iHP1G3E2blAattj7iCFla8cR1s7fqHIO/kP+
	+dsdAHydn5m+KvV+FM58JsFyg3G03q5R8WYV+JqDYYllNKOyi04WRTVf
X-Gm-Gg: Acq92OEDF1Bl2OriMTgj1EaoZgaV0gwgvv/47Of/ZNExzNuERwek5XxSVv37gkXoatx
	CshX7ouJAG5NSigsM2751FMjVNkbamOZdAQlnKnT5Iu39RP1sbNeofYCdOALHv8L63EMt3FGDcm
	LKJ8MIHMpvevycFJ/t1UvdSDNTQvQxAM1tZJjgs8POglv5tU5NpfhqsclxkuXDKE2nbVq0Z0xpW
	d95tjbhhcpHZIjXoPYDPUodroS0SO/Q4uzznOeM4jSB5da7ztmc99MhgiZbM3DBRrjkctS3FLk2
	NQ9O7dyJHh021yDbJmBdtBhZKIQUcLnU8JWAPiH4YOM9sCRt7/9ppdVDowf4cMqJNRb3NdNbH3T
	0jO4BTbDXbp2sEpDutQ7N8zBNc3WFSpctDMXlk1BvbF0cBVnvsdbFwClL2t81XLLM3HSBjIE3Ci
	Nia07Nl6Uim9EGDH1oRfFfsWaUS3/8W/VsBYksMn/3rcLgO/u8ICfiabOJVlqFbMA+oBfJEzpwn
	Gl2
X-Received: by 2002:a05:600c:4fc9:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-48fe60e368amr196627695e9.6.1779106274418;
        Mon, 18 May 2026 05:11:14 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17a22sm37600967f8f.22.2026.05.18.05.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:11:13 -0700 (PDT)
Message-ID: <8aa4e92d-0498-4335-b3b1-dabd7e507ed7@ovn.org>
Date: Mon, 18 May 2026 14:11:12 +0200
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
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Matteo Perin <matteo.perin@canonical.com>
Subject: Re: [PATCH net 1/5] net: rtnetlink: fix link nsid reported when the
 link is local
To: Jiri Benc <jbenc@redhat.com>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-2-i.maximets@ovn.org>
 <20260518082138.37522db0@griffin>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260518082138.37522db0@griffin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AD54356C8E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,canonical.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	TAGGED_FROM(0.00)[bounces-289026-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 5/18/26 8:21 AM, Jiri Benc wrote:
> Hi Ilya,

Hi, Jiri.  Thanks for your thoughts on the matter!

> 
> IIRC this was added because Open vSwitch needed it. I'd expect most
> users that need to deal with cross-namespace detection to just switch
> to the given netns prior to issuing RTM_GETLINK; at least, that's what
> I'm doing in the tools I wrote.

Yeah, that's also what other projects like FRR are doing.  It's a bit
of a hustle for multi-threaded applications, as AFAIK, there is no way
to just move one thread into a different namespace, so if many threads
are doing something with the network and you suddenly need to check
something in a different namespace, you can't really do that without
pausing all other threads first.  But that's a separate thing, unrelated
to the series.  I'm just ranting. :) 

> 
> On Fri, 15 May 2026 22:19:20 +0200, Ilya Maximets wrote:
>> But this doesn't work for link nsid in cross-namespace RTM_GETLINK
>> requests.  For some reason the code checks if the original device
>> and the link are in the same namespace and not if the querier's
>> namespace is the same as the link's.  So the logic becomes:
>>
>> - if NSID is not reported, then the link is in the same namespace
>>   as the queried device.
>> - if NSID is reported, then the link is not in the same namespace
>>   with the queried device.
> 
> I'm not sure I would call this a bug; the original idea was to use
> IFLA_IF_NETNSID to switch to the point of view of that netns but
> without actually switching to that netns. Hence, the netnsid is
> relative to the caller's netns but otherwise, you get the same reply as
> you would if you switched to that netns. If you think about it that
> way, the current reply is consistent.

It makes some sense, but the fact that all-nsid notification and the
cross-namespace RTM_GETLINK provide different IDs makes it inconsistent
in my brain.  We have:

1. nsenter(target) + getlink(local) = target-to-link nsid.
2. getlink(target) = caller-to-target nsid  + caller-to-link nsid.
3. all-nsid-notiication = cmsg(caller-to-target nsid) + target-to-link nsid.

Where on the left side is what we do and on the right side is what we
get in the message.  The first case involves the caller-to-target id
to enter the namespace, so 1 and 3 work with caller-to-target nsid
and the target-to-link nsid, while the cross-namespace call (2) works
with the caller-to-target and the caller-to-link nsids.

If the cross-namespace call used target-to-link nsid, then the whole
thing would be much more consistent as all three types of requests would
work with / provide the same data.  But since the cross-namespace call
works with different data, I'm not sure why it needs to preserve the
structure as the other two (i.e. report self-referential id when the
link is in the caller's namespace).  Though I agree that it's more of a
point of view conversation rather than a technical discussion.  So we
may keep it as-is or add a flag that changes the behavior one way or
another, if necessary.

> 
> I agree the side effects of the self-referential netnsid are
> unfortunate. But that's an orthogonal problem merely uncovered by
> IFLA_IF_NETNSID, since, as you correctly note, such netnsid can be
> created also by other means. This is (AFAICS correctly) fixed by patch
> 3/5.
> 
> So, I would argue both the old and the proposed behavior are valid.
> I agree that from the point of view you're presenting the proposed
> behavior is easier to use. Double so since you're arguing from the Open
> vSwitch POV.
> 
>> 4. A seemingly read-only RTM_GETLINK request for a different namespace
>>    allocates a self-referential nsid for the current namespace, which
>>    is a little unexpected.
> 
> I, however, don't agree with this argument. RTM_GETLINK has always
> allocated netnsids, even long before the patch adding IFLA_IF_NETNSID.
> There's nothing special here. You might call the netnsid allocation
> unexpected but it's been part of this since the very beginning.

That's true, the allocation was always there.  My point was mostly about
allocation of the source-to-source nsid mapping when the request doesn't
seemingly require it.  But I agree that some allocation is expected.

> 
>> A research across open-source projects doesn't show any projects that
>> rely on the things that are being changed.  I couldn't find any
>> project that uses the reported LINK_NSID with cross-namespace requests.
>> And no projects that use cross-namespace requests seem to even parse
>> the reported LINK_NSID.
> 
> I trust your research. My main concern would be Open vSwitch breaking
> with the change; I haven't checked but obviously I trust you there even
> more.
> 
>> Of course, that doesn't mean there are no such applications, but the
>> current behavior feels like a logical bug that IMO should be fixed,
>> otherwise it's hard to use all-nsid sockets properly.
> 
> I don't think it's a bug. It's just a different way to look at the
> interface. I don't have a problem with saying it's more ergonomic and
> better. I don't have a problem with changing the behavior given your
> research. But please resend this patch without calling this a bug and
> without the Fixes: header. Otherwise, it gets a CVE and I don't think
> that's appropriate here. This is not a stable material, this is a
> feature adding a behavior change. You'll get my Acked-by then.
> 
> The real fix for the all-nsid problem is patch 3/5.

If we don't consider this behavior as a bug than I'd rather just document
it and solidify in tests, i.e. drop the code change and update the tests
I made in the patch 2/5 to make it clear what is the actual behavior.
If we change the logic in the next tree only, it will not be possible for
applications to understand what is the behavior without checking the
kernel version or introduction of extra flags, i.e. we'd have to make the
new behavior opt-in.  Which may be fine, I suppose, but will require
application changes to take advantage of.

For the problem we're facing in OVS, patch 3/5 is indeed enough.  I'll
split the set in two.  I'll send patches 3-5 for net tree  after a couple
days in case there will be some more comments (beside ones from sashiko).
And we can think what to do with the first half of the set in the meantime.

Best regards, Ilya Maximets.

