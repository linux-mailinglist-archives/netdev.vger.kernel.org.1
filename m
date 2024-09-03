Return-Path: <netdev+bounces-124628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F19A96A422
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38DC1C23F22
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DABC18BC0A;
	Tue,  3 Sep 2024 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2FQmt7k5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hf1iEXNB"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0B18BB99;
	Tue,  3 Sep 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380442; cv=none; b=HXmqDJD4Rq9iZM7Pkp/kZGvL9VWL5EifcMMgbw3ulPRME0giii+peXbYKS7mk6G7xWqgXqr7w9XVk7hZKBV0tgXXghoGvfl5kUJHWHcEWHCTLPaYaNKg4cWi699MsYqxFi9AiByMgDG4Foyh3ZKxl1/4F2jH2N+K5IZisLaq7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380442; c=relaxed/simple;
	bh=aWUmoICX5/bAUIkZyCSMYqmjqTN82UbWS0+fYRz8OI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAkcFaZ5qVTO4Uusir94H6xVrhN47upPoNQysZ7dOYXqlKhDqDiaCpsp8tDxDgUPoFNnPzkrxescdwUgnum/1SCfFs1f5PICuoN4G+opyuI+1BCyN3pcLCUcG6riYLohX/xEJ5rL9053uQSQ/VU8bH0ry1sc6RSQKvVfKGknbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2FQmt7k5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hf1iEXNB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <f9f124da-81f6-42d8-a59e-b57f2358ed2a@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725380437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WCC0e5eo3yNikJaPXA/YYZhAkYGprLjDl6IIFERnSUs=;
	b=2FQmt7k5tU0iieQMR7GA0Y5L1rbLoJPJVCsTz9gmZHh+phuqsE4U3F1deqBJAFmWf9dAtn
	Q3LXyIQWr4ZBFy2YXOLa+W5qFAtQUrV0gUS0h1I+QCydKD/rMXdwBS1O/wpqHj9Ky90kXR
	B8fBEvX/6JBu8Jijys+j/85nSX6Tun8eOS9YEkLjT3M3f6OCtdAXrGIYQNIfnZct0qFl7q
	OWbSIbYl/xGNrFz0p8sUcR+sHlTXZ0tJe09QEEeNsX+sGDxV+0zsZsoiVagQfWUdiYh+KQ
	lgRiWqPd/zlWXzXHx8QivUesjyjoTE6Nvl/yZn2mvZbxVxv4FbLNzAKXyzBKYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725380437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WCC0e5eo3yNikJaPXA/YYZhAkYGprLjDl6IIFERnSUs=;
	b=Hf1iEXNBfKB9/vo1PDwHas09kVeIs+GZ9byqt4yAyO1MwV2VJMKegTJ/V8DDgcmJKujMcr
	aeSm+mLTJLfAHbAA==
Date: Tue, 3 Sep 2024 18:20:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: CPU stuck due to the taprio hrtimer
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, luyun
 <luyun@kylinos.cn>, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627055338.2186255-1-luyun@kylinos.cn>
 <87sewy55gp.fsf@intel.com> <2df10720-1790-48bd-a50c-4816260543b0@kylinos.cn>
 <fcd41a5f-66b5-4ebe-9535-b75e14867444@linutronix.de>
 <87jzftpwo2.fsf@intel.com>
 <18cd9ee1-6d12-469c-bf3d-c8fa080b01c1@linutronix.de>
 <87bk14pw5o.fsf@intel.com>
Content-Language: en-US
From: Florian Kauer <florian.kauer@linutronix.de>
Autocrypt: addr=florian.kauer@linutronix.de; keydata=
 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
 ugsSqUGtSA==
In-Reply-To: <87bk14pw5o.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/24 17:57, Vinicius Costa Gomes wrote:
> Florian Kauer <florian.kauer@linutronix.de> writes:
> 
>> On 9/2/24 23:34, Vinicius Costa Gomes wrote:
>>> Florian Kauer <florian.kauer@linutronix.de> writes:
>>>
>>>> On 9/2/24 11:12, luyun wrote:
>>>>>
>>>>> 在 2024/6/28 07:30, Vinicius Costa Gomes 写道:
>>>>>> Yun Lu <luyun@kylinos.cn> writes:
>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> When I run a taprio test program on the latest kernel(v6.10-rc4), CPU stuck
>>>>>>> is detected immediately, and the stack shows that CPU is stuck on taprio
>>>>>>> hrtimer.
>>>>>>>
>>>>>>> The reproducer program link:
>>>>>>> https://github.com/xyyluyun/taprio_test/blob/main/taprio_test.c
>>>>>>> gcc taprio_test.c -static -o taprio_test
>>>>>>>
>>>>>>> In this program, start the taprio hrtimer which clockid is set to REALTIME, and
>>>>>>> then adjust the system time by a significant value backwards. Thus, CPU will enter
>>>>>>> an infinite loop in the__hrtimer_run_queues function, getting stuck and unable to
>>>>>>> exit or respond to any interrupts.
>>>>>>>
>>>>>>> I have tried to avoid this problem by apllying the following patch, and it does work.
>>>>>>> But I am not sure if this can be the final solution?
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>>>>>> ---
>>>>>>>   net/sched/sch_taprio.c | 24 ++++++++++++++++++++++++
>>>>>>>   1 file changed, 24 insertions(+)
>>>>>>>
>>>>>>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>>>>>>> index a0d54b422186..2ff8d34bdbac 100644
>>>>>>> --- a/net/sched/sch_taprio.c
>>>>>>> +++ b/net/sched/sch_taprio.c
>>>>>>> @@ -104,6 +104,7 @@ struct taprio_sched {
>>>>>>>       u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
>>>>>>>       u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
>>>>>>>       u32 txtime_delay;
>>>>>>> +    ktime_t offset;
>>>>>>>   };
>>>>>>>     struct __tc_taprio_qopt_offload {
>>>>>>> @@ -170,6 +171,19 @@ static ktime_t sched_base_time(const struct sched_gate_list *sched)
>>>>>>>       return ns_to_ktime(sched->base_time);
>>>>>>>   }
>>>>>>>   +static ktime_t taprio_get_offset(const struct taprio_sched *q)
>>>>>>> +{
>>>>>>> +    enum tk_offsets tk_offset = READ_ONCE(q->tk_offset);
>>>>>>> +    ktime_t time = ktime_get();
>>>>>>> +
>>>>>>> +    switch (tk_offset) {
>>>>>>> +    case TK_OFFS_MAX:
>>>>>>> +        return 0;
>>>>>>> +    default:
>>>>>>> +        return ktime_sub_ns(ktime_mono_to_any(time, tk_offset), time);
>>>>>>> +    }
>>>>>>> +}
>>>>>>> +
>>>>>>>   static ktime_t taprio_mono_to_any(const struct taprio_sched *q, ktime_t mono)
>>>>>>>   {
>>>>>>>       /* This pairs with WRITE_ONCE() in taprio_parse_clockid() */
>>>>>>> @@ -918,6 +932,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>>>>>>       int num_tc = netdev_get_num_tc(dev);
>>>>>>>       struct sched_entry *entry, *next;
>>>>>>>       struct Qdisc *sch = q->root;
>>>>>>> +    ktime_t now_offset = taprio_get_offset(q);
>>>>>>>       ktime_t end_time;
>>>>>>>       int tc;
>>>>>>>   @@ -957,6 +972,14 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>>>>>>       end_time = ktime_add_ns(entry->end_time, next->interval);
>>>>>>>       end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
>>>>>>>   +    if (q->offset != now_offset) {
>>>>>>> +        ktime_t diff = ktime_sub_ns(now_offset, q->offset);
>>>>>>> +
>>>>>>> +        end_time = ktime_add_ns(end_time, diff);
>>>>>>> +        oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time, diff);
>>>>>>> +        q->offset = now_offset;
>>>>>>> +    }
>>>>>>> +
>>>>>> I think what we should do here is a bit different. Let me try to explain
>>>>>> what I have in mind with some context.
>>>>>>
>>>>>> A bit of context: The idea of taprio is to enforce "TSN" traffic
>>>>>> schedules, these schedules require time synchronization, for example via
>>>>>> PTP, and in those cases, time jumps are not expected or a sign that
>>>>>> something is wrong.
>>>>>>
>>>>>> In my mind, a time jump, specially a big one, kind of invalidates the
>>>>>> schedule, as the schedule is based on an absolute time value (the
>>>>>> base_time), and when time jumps that reference in time is lost.
>>>>>>
>>>>>> BUT making the user's system unresponsive is a bug, a big one, as if
>>>>>> this happens in the real world, the user will be unable to investigate
>>>>>> what made the system have so big a time correction.
>>>>>>
>>>>>> So my idea is to warn the user that the time jumped, say that the user
>>>>>> needs to reconfigure the schedule, as it is now invalid, and disable the
>>>>>> schedule.
>>>>>>
>>>>>> Does this make sense?
>>>>>>
>>>>>> Ah, and thanks for the report.
>>>>>
>>>>> Hello Vinicius,
>>>>>
>>>>> May I ask is there a fix patch for this issue?
>>>>>
>>>>> I test it on the latest kernel version,  and it still seems to cause CPU stuck.
>>>>>
>>>>> As you mentioned, a better way would be to warn the user that the current time has jumped and cancel the hrtimer,
>>>>>
>>>>> but I'm not sure how to warn the user, or just through printk?
>>>>>
>>>>> Thanks and best regards.
>>>>
>>>> I am not sure if it is really the best solution to force the user to reconfigure the schedule
>>>> "just" because the clock jumped. Yes, time jumps are a big problem for TAPRIO, but stopping might
>>>> make it worse.
>>>>
>>>> Vinicius wrote that the base_time can no longer reference to the correct point in time,
>>>> so the schedule MUST be invalid after the time jump. It is true that the base_time does not longer
>>>> refer to the same point in time it referred to before the jump from the view of the local system (!).
>>>> But the base_time usually refers to the EXTERNAL time domain (i.e. the time the system SHOULD have
>>>> and not the one the system currently has) and is often configured by an external entity.
>>>>
>>>> So it is quite likely that the schedule was incorrectly phase-shifted BEFORE the time jump and after
>>>> the time jump the base_time refers to the CORRECT point in time viewed from the external time domain.
>>>>
>>>> If you now stop the schedule (and I assume you mean by this to let every queue transmit at any time
>>>> as before the schedule was configured) and the user has to reconfigure the schedule again,
>>>> it is quite likely that by this you actually increase the interference with the network and in
>>>> particular confuse the time synchronization via PTP, so once the schedule is set up again,
>>>> you might get a time jump AGAIN.
>>>>
>>>> So yes, a warning to the user is definitely appropriate in the case of a time jump, but apart
>>>> from that I would prefer the system to adapt itself instead of resigning.
>>>>
>>>
>>> The "warn the user, disable the schedule" is more or less clear in my
>>> mind how to implement. But while I was writing this, I was taking
>>> another look at the standard, and I think this approach is wrong.
>>>
>>> I think what we should do is something like this:
>>>
>>> 1. Jump into the past:
>>>    1.a. before base-time: Keep all queues open until base-time;
>>>    1.b. after base-time: "rewind" the schedule to the new current time;
>>> 2. Jump into the future: "fast forward" the schedule to the new current
>>>    time;
>>>
>>> But I think that for this to fit more neatly, we would need to change
>>> how advance_sched() works, right now, it doesn't look at the current
>>> time (it considers that the schedule will always advance one-by-one),
>>> instead what I am thinking is to consider that every time
>>> advance_sched() runs is a pontential "time jump". 
>>>
>>> Ideas? Too complicated for an uncommon case? (is it really uncommon?)
>>
>> I think that would be the correct solution.
>> And I don't think it is that uncommon. Especially when the device joins
>> the network for the first time and has not time synchronized itself properly yet.
>>
>> Do you know what the i225/i226 do for hardware offloaded Qbv in that case?
>>
> 
> In offloaded cases, in my understanding, i225/i226 re-uses most of how
> launchtime works for Qbv, so the scheduling is almost per frame, during
> transmission, the hw assigns each frame an offset into the gate open
> event. And that time is used to calculate when the packet should reach
> the wire.
> 
> So I would expect to see a few stuck packets (causing transmissions
> timeouts) or early transmissions, depending on the direction of the
> jump, but things should be able to recover eventually.


I think that is the important part, to recover eventually.
So I would expect this also for the software mode.


> 
>>>
>>>> Yun Lu, does this only happen for time jumps into the past or also for large jumps into the future?
>>>> And does this also happen for small time "jumps"?
>>>
>>> AFAIU this bug will only happen with large jumps into the past. For
>>> small jumps into the past, it will spin uselessly for a bit. For jumps
>>> into the future, the schedule will be stuck in a particular gate entry
>>> until the future becomes now.
>>
>> Does "it will spin uselessly for a bit" mean the CPU is stuck for that time
>> (even if it is short)? If that is the case, it might lead to very strange effects
>> in RT systems. And these small time jumps into the past (even if just a few us)
>> should actually be relatively common.
>>
> 
> Yes. The hrtimer will expire, advance_sched() will get the next entry
> and its expiration, set the hrtimer expiration to that, this will repeat
> until that expiration is after "current" time. As this is hrtimer
> function, this will block other things from running on that cpu.
> 
> My expectation for taprio in software mode was more something that
> people would use to validate new schedules, do some experiments, that
> kind of thing. What I was expecting to have in more serious cases was
> the offloaded mode.


Ok, sorry, my statement about "relatively common" was about time jumps, not so
much about the use of the software mode. I also fully switched to offloaded
mode now. 

Maybe I will eventually return to software mode when it comes to larger
(containerized) endstations with a lot more streams which cannot be handled
by the 4 queues of the i225/i226.

Nevertheless, I would expect the offloaded and non-offloaded mode to work
similar and this includes a similar reaction to time jumps which
does not include blocking the CPU.


> What I am trying to say is all I am hearing is that the software mode is
> being used more seriously than I thought. So this work is a bit more
> important. I will add this to my todo list, but I won't be sad at all if
> someone beats me to it ;-)


I have one other issue with software mode that I wanted to look into
(regarding setting the interface up and down), maybe it will fit into that
slot, but it is unfortunately very far down in my backlog. So you are likely
still faster :-)


> 
>> Greetings,
>> Florian
>>
>>>
>>>>
>>>> Thanks,
>>>> Florian
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>>       for (tc = 0; tc < num_tc; tc++) {
>>>>>>>           if (next->gate_duration[tc] == oper->cycle_time)
>>>>>>>               next->gate_close_time[tc] = KTIME_MAX;
>>>>>>> @@ -1210,6 +1233,7 @@ static int taprio_get_start_time(struct Qdisc *sch,
>>>>>>>         base = sched_base_time(sched);
>>>>>>>       now = taprio_get_time(q);
>>>>>>> +    q->offset = taprio_get_offset(q);
>>>>>>>         if (ktime_after(base, now)) {
>>>>>>>           *start = base;
>>>>>>> -- 
>>>>>>> 2.34.1
>>>>>>>
>>>>>>
>>>>>> Cheers,
>>>>>
>>>>
>>>
>>>
>>> Cheers,
> 
> 
> Cheers,

