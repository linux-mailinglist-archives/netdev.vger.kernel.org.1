Return-Path: <netdev+bounces-288474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDi9ImKfB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:34:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E344A558EE0
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D18D5303282E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D33EFFBD;
	Fri, 15 May 2026 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="eFt6GKTe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AA3EF649
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884102; cv=none; b=IU2a+VxRpyf0AscG/poNsybwP9OZxRHngvszDHCp7PrOc1VsUe6OMEZ77stsCJK7H1JwCq7mWRXatK47kxBqoQukcFtIt/dn/kSVo+cvgYzdWwReM7uT1ko7DSUK34IGVei9z8adNup2ynZqCTVysm+JtVrF10+qOoJ9kOkRC48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884102; c=relaxed/simple;
	bh=xG9otyaUW/9jGHhnyfxANR5f4G+3kMWxjQ6UwK03pnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXHXx8kgKdERBpbq7AC2joOEEwwXOIotnpxuDUbh+aOet1wzWKCrXZ6g1atd812ppXQWakhyp3pSAJXo+k7aFEwegIQLb0nOCxvA9EPhls54dOcGqcV2XqtFsaBzPeNi9nSs4J9Q8L2s88yv8eX2d9tAusSHJLFybuTmsQ76KtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=eFt6GKTe; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-514ae601e01so4871981cf.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778884100; x=1779488900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCTr+sGh7mnBl2ouAu9BBad0r5l4i1qg7icIkQm3PmU=;
        b=eFt6GKTeR8ZuV7DbVwe3j7U+sS+1e8BwRi0pb0YNdImkqbLAGpWqVUfrYf4VUdlvO4
         tgQn4k6SpCR+naOvhr0y/9LOqwdpqosRqiheQqnll+xYaGobuEe0J1R75tpR+l1ZkXXk
         H/pY1QpDM/K0PAgm2iqJvF/meaqnSt6whDMbNibJ+RuQAQINBOhtbn8VhE7A7ON3KlOT
         OIi8TGqUHxVqP3AzfJ6Muox+H8QxyOjhxZI0R1QucZybL0s6V2diGnHidJe7TuacpiF6
         vKC5Cav0K4lHgWbAmZoQA0tn6voFtRT6YwcTjSqr49oLpl2kQAPz5WDchZC1zGTf/oE/
         w7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884100; x=1779488900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCTr+sGh7mnBl2ouAu9BBad0r5l4i1qg7icIkQm3PmU=;
        b=Y/409ai5aN3AjUUA86rYzoT6UvhtfXcfrXHOMS3bAmy43KU03sUpvrRP5YGrFY1IIx
         QTYDx0oGzEE21JQH0IhE2ub/nTjrdw2wT/cWdO+K+Cbq49LIfCVUswrmoWQcXcvQ1600
         s/qm6yTSMIRft4/U3WmXkNC7YD0wWaDpIKpTJBbbWuyTGyyw5E+qsCToieTpqyamqYSC
         euryCuudUdgiXlfNAKLacqsqJG2CYpdZ4nxRaOAtB2y0zfYmwMcJXcW/U1IK8UmTXiJc
         KRhsivYfLQCMVNeK5aepd9nbtPd9Dz5VNvsY/CVBwGCekmhUjd13mLRx5i7qTBhlXEF2
         Ys5A==
X-Forwarded-Encrypted: i=1; AFNElJ+jUcNsrd7sreFK20IHfVRzbVh9Wwbi0MJ5K4zOOqWulG8qYEQ43zZBdV6Ebn0rqGHR55GbCJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0MGPNh4gEgpxz2KCA0SvVicG1CSlbL19JR0xjqqutcR6OMx5F
	sjAd1IFEJ6dj8gaZPce4mmjTIPngjGWJNt6tSgRSiTg2hFXU/rHIMIWUOSvUqiP51A==
X-Gm-Gg: Acq92OEBVh8aUtAfuacIBteJ5MlfmbHHDLU3DK+qIL8TxprXNAKepmPomHwuj+slexb
	Nkh2K3x9SBPOpBv40n/YhAnwRO49RTAtfTbuvdrUt67WG8cqJhtHQHqhj8vFCm5E66+H60lmpFd
	+DfmKX8hE1JYk4R8gwljDFRGkJitkwt+VICGHMhvbhgJUKO+76ltn0vSulMGKJPfzoAHwcBue2+
	g6kozPV5l53vIqqmsfZ1IkdmxvF12LfXLGgZHhfn8CG1aaVTfHEEZPt+3z7VdOHVPcSlqRwkJkb
	MTgpm7wImcINvllrcerPEI7IdT8omhQoV0Tq58mV73uFTyArHaWkOpyJ58EAqQ8sGSob8hpiyyn
	kVVSjZaDZV9hmeI/y8yUEJi9pCpjT5ykkWDTXxRTatdc+7S8imkUxzM4/H3pblgDwVyDXp8EysF
	1APD6NrPJwsnjoKY81W+ncQ1VvtQkQWTY89LG28KPBZp56NCyT6K3W3uCcXVQftRqEMA==
X-Received: by 2002:ac8:7d94:0:b0:50f:b69a:f4b9 with SMTP id d75a77b69052e-5165a06900bmr79985021cf.27.1778884099862;
        Fri, 15 May 2026 15:28:19 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67:f17:d82a:d5b8:20a? ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645801211sm56389581cf.20.2026.05.15.15.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 15:28:19 -0700 (PDT)
Message-ID: <f05d20e6-c3c4-4069-92e3-0c87cddbf390@mojatatu.com>
Date: Fri, 15 May 2026 19:28:14 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/sched: fq_codel: local packets no longer
 count against memory limit
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 "David S . Miller" <davem@davemloft.net>
References: <20260512094859.3673997-1-edumazet@google.com>
 <20260512094859.3673997-3-edumazet@google.com>
 <ff0a041e-16c9-4e9c-b717-ff8a2bb85d84@redhat.com>
 <CANn89iJ=t=DPd5cw0YTdcj9dNv9BthW+=3jcHDXgtQYmp1nX1w@mail.gmail.com>
 <1b6d8eab-798b-4dce-be1b-adc93b0fd9fc@redhat.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <1b6d8eab-798b-4dce-be1b-adc93b0fd9fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E344A558EE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288474-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On 14/05/2026 07:06, Paolo Abeni wrote:
> On 5/14/26 10:49 AM, Eric Dumazet wrote:
>> On Thu, May 14, 2026 at 1:24 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>> On 5/12/26 11:48 AM, Eric Dumazet wrote:
>>>> Commit 95b58430abe7 ("fq_codel: add memory limitation per queue")
>>>> claimed that the 32Mb default was "reasonable even for heavy duty usages."
>>>>
>>>> In practice, this is not the case.
>>>>
>>>> Packets that are associated with local sockets sk_wmem_alloc
>>>> do not really need additional memory control.
>>>>
>>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>>> ---
>>>>   net/sched/sch_fq_codel.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
>>>> index 1b1de693d4c64a1f5f4e9e788371829dea91740e..71107dc52be799a14f370f2ad74d2eadd93992c1 100644
>>>> --- a/net/sched/sch_fq_codel.c
>>>> +++ b/net/sched/sch_fq_codel.c
>>>> @@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>>>>                q->new_flow_count++;
>>>>                WRITE_ONCE(flow->deficit, q->quantum);
>>>>        }
>>>> -     get_codel_cb(skb)->mem_usage = skb->truesize;
>>>> +     get_codel_cb(skb)->mem_usage = is_skb_wmem(skb) ? 0 : skb->truesize;
>>>>        q->memory_usage += get_codel_cb(skb)->mem_usage;
>>>>        memory_limited = q->memory_usage > q->memory_limit;
>>>>        qdisc_qlen_inc(sch);
>>>
>>> I *think* this patch is causing TDC self-tests failures:
>>>
>>> # not ok 704 a4bb - Test FQ_CODEL with HTB parent - force packet drop with empty queue
>>> # Could not match regex pattern. Verify command output:
>>> # qdisc fq_codel 10: parent 1:10 limit 10240p flows 1 quantum 1514 target 99us interval 999us memory_limit 1b ecn drop_batch 64
>>> #  Sent 490 bytes 5 pkt (dropped 0, overlimits 0 requeues 0)
>>> #  backlog 0b 0p requeues 0
>>> #   maxpacket 98 drop_overlimit 0 new_flow_count 1 ecn_mark 0
>>> #   new_flows_len 1 old_flows_len 0
>>>
>>> whole log at:
>>>
>>> https://github.com/p4tc-dev/tc-executor/tree/storage/artifacts/645644/1-tdc-sh
>>>
>>> Looking at the test code, I think the patch broke it, but the failures
>>> started a little afterward the patch merge, so I'm possibly
>>> misunderstanding something here.
>>>
>>> Thanks,
>>>
>>> Paolo
>>>
>>
>> It seems this test uses a memory limit of 1 byte.
>>
>> $TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit
>> 1 flows 1 target 0.1ms interval 1ms
>>
>> This might be a typo, I think they expected a limit of 0 packet.
> 
> FTR, I think/agree a change to the self-tests would be preferable.

Eric, do you have a tdc fix lined up for this one?
If not, I can work something out here and send.

cheers,
Victor

