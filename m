Return-Path: <netdev+bounces-304753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nty5MBoHSmqg9gAAu9opvQ
	(envelope-from <netdev+bounces-304753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 09:26:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE2C70934F
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 09:26:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CH3+g0xW;
	dkim=pass header.d=redhat.com header.s=google header.b=fU28vimj;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304753-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304753-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48AB8300291C
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F9292B54;
	Sun,  5 Jul 2026 07:26:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431613C918
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 07:26:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783236372; cv=none; b=UHpJx6InAd4gEf2Yxf9uzoR5w2FN9xbQPhfN3PM1JcljwJGS1PK5BihEctBWDASVLtPTAxvFHXBTQ9cBhcCrtZPu1lGYTLRKlrZ+R4KR9/9A1tzV2hVF57fL6srv17fvhFbFt9AGo1QMCtR30+YmJeiKUg8k1tp/k9Kc57fmaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783236372; c=relaxed/simple;
	bh=j91LwwYa2oG0qyR23QjVJfczkQIvZ2o4Q805tY1RF6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skGx5MzYB9OlFc8QOCKcQtvsTeGk0MwBkfMrZXD1h73SXwrLYdpA6h3hUe7KcrQVVXmF7D8k1c4H20k8p9dRGsCbHL6GeX5CNz8nB3r15ENUwbCSLAMwAqd3DzgaPb7wGqSAW0pB2dmLpfD9iFxfKLR1CHVVZ32Rr2WtmBQLNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CH3+g0xW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fU28vimj; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783236369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xyvE7SpL2UEBqv++HhUO/APoRvzWHvcbsO0VDOVgq0=;
	b=CH3+g0xWh+144mPst5R8k1dVdWSmOPjw7d99y3x1YTEXmmZdQyFLAcp6PcuyCdRgZBXTO7
	5+v/lInns8ptubdadMQR7m3OiDiuW99FWhNijKZMfIh1IoYh455OIr0/pFywSUr5Cp5dFR
	cZi6Wen/77S8Cmtqeq9T+OQ09YK+JGc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-Kf_EeJW4MgKK567TnTfoYQ-1; Sun, 05 Jul 2026 03:26:06 -0400
X-MC-Unique: Kf_EeJW4MgKK567TnTfoYQ-1
X-Mimecast-MFC-AGG-ID: Kf_EeJW4MgKK567TnTfoYQ_1783236365
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bb6a4336so16356005e9.3
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 00:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783236365; x=1783841165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xyvE7SpL2UEBqv++HhUO/APoRvzWHvcbsO0VDOVgq0=;
        b=fU28vimj1gHOfQOiJkkhCUGOV4zMcCOT3rFe0JyX4EOMNn+RnFkVuXLOraSNmDnuYj
         6jXDMJrrpyxLg39lyadDqPF+yP/5IaFZSOK4ck8HpLUG5WyH/SaLtKd6yAqFH0QLwfc8
         XUawqiNzg9VLPIkszEbMMgxZ9vG/U7724XudOz0+RqEdM95K2zsP6NcuVcFIbbc1XYpw
         hSnTDc1S+GEkp150BUYy5gIPhOzhY0lWbql24nn+RxdKj6miW9GTHgKRIy9X26q85Bu/
         rZJe47Jf63B6uRaJ6lJSImEbPuINc3AK++UIaq44FAr8CaCrurkweYy0bmLscvtY3QLt
         0oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783236365; x=1783841165;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xyvE7SpL2UEBqv++HhUO/APoRvzWHvcbsO0VDOVgq0=;
        b=Gy1clhLSdCEmu83fcKZ3xVKRF9zRlfBooWcNiStzwfJC7d/mz/i7g2ASZu9eN8oL5k
         US+fHO9sVz2kx78X36iGTwB11IDkU846rNuE29i30mck8rknTm8NCN0vZCMtyeZ+tFFT
         gqjRtB1e87p1VRLubMMzd4449HZOVyrD7TUnMUHzuxSgZAk0fKwFzUfVeHoMdaxj8iZ7
         su7mEg7/FVt77GpeSZuyrM+jzeTrgFvd8yyCoWmL3u6zwNe7xLjIOX89M2Q0DjLyVk32
         jKGu/C9X1jBHVuDf4125mQhfKFV4UEBDNwuK3qN3yOhY/1Dvr2+Ukg24oOOTR3fn1fCG
         aZWg==
X-Forwarded-Encrypted: i=1; AFNElJ+DT+1QICjSZezPgxsRpBre1sOUUTRDp3ayPH5h8umoU29ToxQ5ERoNA+S80SRWOi/+nmVGG9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6wDMEv5jpzUR0ldOjBqyNTugPRkf+oTJ4Jm8zcOqDStjW3U6
	ZOoV56DkqsBo8s+HpuEv3wJXRBcmYbGrmDQFjBnkj9srCIyQmn+3dYKxz06x9v2dy3nQC9qdo14
	GRY3WgDfRden0ac0mATpZx5iW40ixFR0HnqEW9csSYpAzSFNLA6s9eODyB5kBmbRFcg==
X-Gm-Gg: AfdE7cmMcWZRFU7PDToXxb6oUtmRl64YXfSxRfdC7cN0l8sMwVDcOCn5y9xzrj9jTxI
	Ax9MfzCg4hPGD87pdO+L2SeIDQ4tiQM0N1UQD2VfGKp2Ey3hShgAz+Tku7gDU5qDvUqSPMhFzkz
	e3M7bQ3UpTpajJ5dJSswh7Xgj4aHCM/lYJ/c9Z0fNlgw1O9X6zOWZDvGCKoDvFdq869yWEDQuir
	5JsM2t71JBc1wGPQ3/QUIORMVAjwE5eXSjpj7uQQGC2dVw9aOf46dLiD5b1dPsf2oWHi2ClGBid
	BmyTpghKF4nByWlAb1XoOXfUT66UTytZRjBsr+TNwutnHsaoDjbsvQdSg5WL3j8boW1FBQ7wJFc
	ctC4kK3PxTvEUSAe8K7ynCh9BspC1qs4zlyas6aorftCTnVC4HeUbpMM3F0+AOoRksx1KB7c8Du
	heeedD
X-Received: by 2002:a05:600c:5306:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-493d11f37e9mr66351765e9.19.1783236365432;
        Sun, 05 Jul 2026 00:26:05 -0700 (PDT)
X-Received: by 2002:a05:600c:5306:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-493d11f37e9mr66351475e9.19.1783236365011;
        Sun, 05 Jul 2026 00:26:05 -0700 (PDT)
Received: from [192.168.0.115] (ip90-44-231-195.pool-bba.aruba.it. [195.231.44.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdabda3sm186697685e9.5.2026.07.05.00.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 00:26:04 -0700 (PDT)
Message-ID: <c526d9d9-db4c-45e8-96c5-52b2a9dca7e8@redhat.com>
Date: Sun, 5 Jul 2026 09:26:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Jamal Hadi Salim <jhs@mojatatu.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Victor Nogueira <victor@mojatatu.com>
References: <20260630123331.186840-1-daniel@iogearbox.net>
 <20260630123331.186840-3-daniel@iogearbox.net>
 <CAM0EoMn6H6cKCweHmt=8ve2i0JuK=E8W1Q89oqDD7vra_Uuk-w@mail.gmail.com>
 <d9fce17f-851e-4cb0-9d78-2ac2cadfda81@iogearbox.net>
 <CAM0EoMnZPbKG3GCndk2Xp44KxUfPJzSMGXYPDZeoa_-6JZ+Uuw@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAM0EoMnZPbKG3GCndk2Xp44KxUfPJzSMGXYPDZeoa_-6JZ+Uuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304753-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,gmail.com,vger.kernel.org,mojatatu.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:daniel@iogearbox.net,m:kuba@kernel.org,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:victor@mojatatu.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iogearbox.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABE2C70934F

Hi,

On 7/1/26 5:35 PM, Jamal Hadi Salim wrote:
> On Tue, Jun 30, 2026 at 11:23 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 6/30/26 5:16 PM, Jamal Hadi Salim wrote:
>>> On Tue, Jun 30, 2026 at 8:33 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> From: Jamal Hadi Salim <jhs@mojatatu.com>
>>>>
>>>> When a TC filter attached to a qdisc filter chain returns
>>>> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
>>>> act_bpf action), the redirect was silently lost i.e no qdisc classify
>>>> function handled TC_ACT_REDIRECT, so the packet fell through the
>>>> switch and was enqueued normally instead of being redirected.
>>>>
>>>> This has been broken since bpf_redirect() was introduced for TC in
>>>> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
>>>> for a long time because bpf_net_context was a per-CPU variable that
>>>> was always available.
>>>>
>>>> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
>>>> on PREEMPT_RT.") turned bpf_net_context into a task_struct member that
>>>> is only set up by explicit callers. Without a caller setting it up,
>>>> bpf_redirect() itself crashes with a NULL pointer dereference in
>>>> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
>>>> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
>>>> adding skb_do_redirect() calls to every qdisc classify function, which
>>>> would require changes across net/sched/. Isolate it to ebpf core where
>>>> it belongs.
>>>>
>>>> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
>>>> wrapper around tcf_classify() for use by qdisc classify functions and
>>>> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
>>>> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
>>>> than letting it continue silently. Dropping is preferred over
>>>> letting the packet through because the user immediately sees packet
>>>> loss. Silently passing the packet through would hide the problem and
>>>> leave the user wondering why their redirect is not working.
>>>>
>>>> The clsact fast path, tc_run() continues to call tcf_classify() directly
>>>> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
>>>> sch_handle_egress/ingress() calling skb_do_redirect() as before.
>>>>
>>>> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
>>>> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
>>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>>> ---
>>>>   include/net/pkt_cls.h    | 14 +++++++++++++-
>>>>   net/sched/cls_api.c      |  4 +---
>>>>   net/sched/sch_cake.c     |  2 +-
>>>>   net/sched/sch_drr.c      |  2 +-
>>>>   net/sched/sch_dualpi2.c  |  2 +-
>>>>   net/sched/sch_ets.c      |  2 +-
>>>>   net/sched/sch_fq_codel.c |  2 +-
>>>>   net/sched/sch_fq_pie.c   |  2 +-
>>>>   net/sched/sch_hfsc.c     |  2 +-
>>>>   net/sched/sch_htb.c      |  2 +-
>>>>   net/sched/sch_multiq.c   |  2 +-
>>>>   net/sched/sch_prio.c     |  2 +-
>>>>   net/sched/sch_qfq.c      |  2 +-
>>>>   net/sched/sch_sfb.c      |  2 +-
>>>>   net/sched/sch_sfq.c      |  2 +-
>>>>   15 files changed, 27 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
>>>> index 3bd08d7f39c1..5f5cb36439fe 100644
>>>> --- a/include/net/pkt_cls.h
>>>> +++ b/include/net/pkt_cls.h
>>>> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *skb,
>>>>   {
>>>>          return TC_ACT_UNSPEC;
>>>>   }
>>>> -
>>>>   #endif
>>>> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
>>>> +                                    const struct tcf_proto *tp,
>>>> +                                    struct tcf_result *res, bool compat_mode)
>>>> +{
>>>> +       int ret = tcf_classify(skb, NULL, tp, res, compat_mode);
>>>> +
>>>> +       /* TC_ACT_REDIRECT from qdisc filter chains is not supported.
>>>> +        * Use BPF via tcx or mirred redirect instead.
>>>> +        */
>>>> +       if (unlikely(ret == TC_ACT_REDIRECT))
>>>> +               ret = TC_ACT_SHOT;
>>>> +       return ret;
>>>> +}
>>>
>>> Why did you remove the warning?
>>> A lesser issue is that you introduced a space above #endif
>>
>> I don't think we need to put out an extra warn to spam the log, this
>> can be easily traced either via bpftrace or qdisc stats etc; plus the
>> guidance to eBPF with clsact is also obsolete. Given noone has run
>> into this the last 10y, I don't think it really matters tbh.
> 
> It's a bit entitled for you to change someone else's patch to fit your
> philosophy without a mention.
> It's only one message per qdisc. But fine, let's keep it that way.
> Sashiko is hallucinating on TC_ACT_CONSUMED for patch 1. Let's ignore it.

@Jamal: I read the above as if you are ok with the series in the current
form as a whole. Please LMK.

FTR, I have a slight preference towards the extra warn message in case
of misconfiguration, but big deal either way.

/P


