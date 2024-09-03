Return-Path: <netdev+bounces-124615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8DB96A36F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DBB285F2F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49B188A03;
	Tue,  3 Sep 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGsS9EmW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23763187325;
	Tue,  3 Sep 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379067; cv=none; b=oJcbCca4yElJXxHE5HuIban8oNbWdejX5371unukgilGN7NXDW5IxwgsSNfgeqrxG8RC1FRk7zS1RKljO8bZPiI8vK5+TSnsr2g7Fv52xYjkTADTi72uydS3TI5dqy1rNPoy3wtzidWCmahTrkN7oYvhL9efTURaMypEZAdRJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379067; c=relaxed/simple;
	bh=wAIftKZHmjENk2OO1vCfl+gwtu85AyNWPBUt1PmdjEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEB6BssI6zZyBZO3xFwNxsLHO5XV4v7kPj5TZjNrmsQ24T0a8oufaHHtWPTNWJdD7X7frV3zaagEFv23MaSm5+MTFxLixGKlsYlm8RqKKerwSNVDokaunphW4oKgpnXENmwUSYry2rqwfCQ/sDWm1eLbIyRCG5sfCDTN0Z3Mdk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGsS9EmW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725379065; x=1756915065;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=wAIftKZHmjENk2OO1vCfl+gwtu85AyNWPBUt1PmdjEY=;
  b=jGsS9EmW0cCoy37YSYy1wPZ/reI9GlOsznyAMA+3RgX+y+ogY+e52qHL
   kFRj3ZQdl1XxJDoB/NZ0kFGyTd4y2jF09Vghg0cvHUlie6b/nmIGdC/Ar
   /cbpAWM0pr/6sZcGLrpbo3QYPtgAe5FvUB9Pmkl39W2F4ya5tj47O2NtI
   uQoQSNfwmlXouw6kodS5fBp+Y0zvi13X8/5P/304uYk1sg0CBrSO99Did
   EpIdfTsYVN8xYulgtvidphTPcRavIQQApnojR8Nf+Hs4XySmzU2aVWwDN
   Eu9fcrB8pSKr+B51rfQL4Teaik3N2HqFFxL/2whX3EJ0FeqmDxTayyohT
   Q==;
X-CSE-ConnectionGUID: 98fL4YA1TMOYRRcMeyG2nQ==
X-CSE-MsgGUID: Wd2TEhmQR1q/YXPqs8jQxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="41460373"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="41460373"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:57:44 -0700
X-CSE-ConnectionGUID: xnwzwXpBSwCpdHupcuO0ww==
X-CSE-MsgGUID: PXWf8KksSVOSWX032IZmCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65016396"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.64])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:57:42 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Florian Kauer <florian.kauer@linutronix.de>, luyun <luyun@kylinos.cn>,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CPU stuck due to the taprio hrtimer
In-Reply-To: <18cd9ee1-6d12-469c-bf3d-c8fa080b01c1@linutronix.de>
References: <20240627055338.2186255-1-luyun@kylinos.cn>
 <87sewy55gp.fsf@intel.com>
 <2df10720-1790-48bd-a50c-4816260543b0@kylinos.cn>
 <fcd41a5f-66b5-4ebe-9535-b75e14867444@linutronix.de>
 <87jzftpwo2.fsf@intel.com>
 <18cd9ee1-6d12-469c-bf3d-c8fa080b01c1@linutronix.de>
Date: Tue, 03 Sep 2024 12:57:39 -0300
Message-ID: <87bk14pw5o.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Florian Kauer <florian.kauer@linutronix.de> writes:

> On 9/2/24 23:34, Vinicius Costa Gomes wrote:
>> Florian Kauer <florian.kauer@linutronix.de> writes:
>>=20
>>> On 9/2/24 11:12, luyun wrote:
>>>>
>>>> =E5=9C=A8 2024/6/28 07:30, Vinicius Costa Gomes =E5=86=99=E9=81=93:
>>>>> Yun Lu <luyun@kylinos.cn> writes:
>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> When I run a taprio test program on the latest kernel(v6.10-rc4), CP=
U stuck
>>>>>> is detected immediately, and the stack shows that CPU is stuck on ta=
prio
>>>>>> hrtimer.
>>>>>>
>>>>>> The reproducer program link:
>>>>>> https://github.com/xyyluyun/taprio_test/blob/main/taprio_test.c
>>>>>> gcc taprio_test.c -static -o taprio_test
>>>>>>
>>>>>> In this program, start the taprio hrtimer which clockid is set to RE=
ALTIME, and
>>>>>> then adjust the system time by a significant value backwards. Thus, =
CPU will enter
>>>>>> an infinite loop in the__hrtimer_run_queues function, getting stuck =
and unable to
>>>>>> exit or respond to any interrupts.
>>>>>>
>>>>>> I have tried to avoid this problem by apllying the following patch, =
and it does work.
>>>>>> But I am not sure if this can be the final solution?
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>>>>> ---
>>>>>> =C2=A0 net/sched/sch_taprio.c | 24 ++++++++++++++++++++++++
>>>>>> =C2=A0 1 file changed, 24 insertions(+)
>>>>>>
>>>>>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>>>>>> index a0d54b422186..2ff8d34bdbac 100644
>>>>>> --- a/net/sched/sch_taprio.c
>>>>>> +++ b/net/sched/sch_taprio.c
>>>>>> @@ -104,6 +104,7 @@ struct taprio_sched {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 max_sdu[TC_MAX_QUEUE]; /* save in=
fo from the user */
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 fp[TC_QOPT_MAX_QUEUE]; /* only fo=
r dump and offloading */
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 txtime_delay;
>>>>>> +=C2=A0=C2=A0=C2=A0 ktime_t offset;
>>>>>> =C2=A0 };
>>>>>> =C2=A0 =C2=A0 struct __tc_taprio_qopt_offload {
>>>>>> @@ -170,6 +171,19 @@ static ktime_t sched_base_time(const struct sch=
ed_gate_list *sched)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ns_to_ktime(sched->base_time);
>>>>>> =C2=A0 }
>>>>>> =C2=A0 +static ktime_t taprio_get_offset(const struct taprio_sched *=
q)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 enum tk_offsets tk_offset =3D READ_ONCE(q->tk_of=
fset);
>>>>>> +=C2=A0=C2=A0=C2=A0 ktime_t time =3D ktime_get();
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 switch (tk_offset) {
>>>>>> +=C2=A0=C2=A0=C2=A0 case TK_OFFS_MAX:
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ktime_sub_ns(ktim=
e_mono_to_any(time, tk_offset), time);
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>> +}
>>>>>> +
>>>>>> =C2=A0 static ktime_t taprio_mono_to_any(const struct taprio_sched *=
q, ktime_t mono)
>>>>>> =C2=A0 {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* This pairs with WRITE_ONCE() in ta=
prio_parse_clockid() */
>>>>>> @@ -918,6 +932,7 @@ static enum hrtimer_restart advance_sched(struct=
 hrtimer *timer)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_tc =3D netdev_get_num_tc(dev);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sched_entry *entry, *next;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct Qdisc *sch =3D q->root;
>>>>>> +=C2=A0=C2=A0=C2=A0 ktime_t now_offset =3D taprio_get_offset(q);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t end_time;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tc;
>>>>>> =C2=A0 @@ -957,6 +972,14 @@ static enum hrtimer_restart advance_sche=
d(struct hrtimer *timer)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_time =3D ktime_add_ns(entry->end_=
time, next->interval);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_time =3D min_t(ktime_t, end_time,=
 oper->cycle_end_time);
>>>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (q->offset !=3D now_offset) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t diff =3D ktime_s=
ub_ns(now_offset, q->offset);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_time =3D ktime_add_n=
s(end_time, diff);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oper->cycle_end_time =3D=
 ktime_add_ns(oper->cycle_end_time, diff);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->offset =3D now_offset;
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>> +
>>>>> I think what we should do here is a bit different. Let me try to expl=
ain
>>>>> what I have in mind with some context.
>>>>>
>>>>> A bit of context: The idea of taprio is to enforce "TSN" traffic
>>>>> schedules, these schedules require time synchronization, for example =
via
>>>>> PTP, and in those cases, time jumps are not expected or a sign that
>>>>> something is wrong.
>>>>>
>>>>> In my mind, a time jump, specially a big one, kind of invalidates the
>>>>> schedule, as the schedule is based on an absolute time value (the
>>>>> base_time), and when time jumps that reference in time is lost.
>>>>>
>>>>> BUT making the user's system unresponsive is a bug, a big one, as if
>>>>> this happens in the real world, the user will be unable to investigate
>>>>> what made the system have so big a time correction.
>>>>>
>>>>> So my idea is to warn the user that the time jumped, say that the user
>>>>> needs to reconfigure the schedule, as it is now invalid, and disable =
the
>>>>> schedule.
>>>>>
>>>>> Does this make sense?
>>>>>
>>>>> Ah, and thanks for the report.
>>>>
>>>> Hello Vinicius,
>>>>
>>>> May I ask is there a fix patch for this issue?
>>>>
>>>> I test it on the latest kernel version,=C2=A0 and it still seems to ca=
use CPU stuck.
>>>>
>>>> As you mentioned, a better way would be to warn the user that the curr=
ent time has jumped and cancel the hrtimer,
>>>>
>>>> but I'm not sure how to warn the user, or just through printk?
>>>>
>>>> Thanks and best regards.
>>>
>>> I am not sure if it is really the best solution to force the user to re=
configure the schedule
>>> "just" because the clock jumped. Yes, time jumps are a big problem for =
TAPRIO, but stopping might
>>> make it worse.
>>>
>>> Vinicius wrote that the base_time can no longer reference to the correc=
t point in time,
>>> so the schedule MUST be invalid after the time jump. It is true that th=
e base_time does not longer
>>> refer to the same point in time it referred to before the jump from the=
 view of the local system (!).
>>> But the base_time usually refers to the EXTERNAL time domain (i.e. the =
time the system SHOULD have
>>> and not the one the system currently has) and is often configured by an=
 external entity.
>>>
>>> So it is quite likely that the schedule was incorrectly phase-shifted B=
EFORE the time jump and after
>>> the time jump the base_time refers to the CORRECT point in time viewed =
from the external time domain.
>>>
>>> If you now stop the schedule (and I assume you mean by this to let ever=
y queue transmit at any time
>>> as before the schedule was configured) and the user has to reconfigure =
the schedule again,
>>> it is quite likely that by this you actually increase the interference =
with the network and in
>>> particular confuse the time synchronization via PTP, so once the schedu=
le is set up again,
>>> you might get a time jump AGAIN.
>>>
>>> So yes, a warning to the user is definitely appropriate in the case of =
a time jump, but apart
>>> from that I would prefer the system to adapt itself instead of resignin=
g.
>>>
>>=20
>> The "warn the user, disable the schedule" is more or less clear in my
>> mind how to implement. But while I was writing this, I was taking
>> another look at the standard, and I think this approach is wrong.
>>=20
>> I think what we should do is something like this:
>>=20
>> 1. Jump into the past:
>>    1.a. before base-time: Keep all queues open until base-time;
>>    1.b. after base-time: "rewind" the schedule to the new current time;
>> 2. Jump into the future: "fast forward" the schedule to the new current
>>    time;
>>=20
>> But I think that for this to fit more neatly, we would need to change
>> how advance_sched() works, right now, it doesn't look at the current
>> time (it considers that the schedule will always advance one-by-one),
>> instead what I am thinking is to consider that every time
>> advance_sched() runs is a pontential "time jump".=20
>>=20
>> Ideas? Too complicated for an uncommon case? (is it really uncommon?)
>
> I think that would be the correct solution.
> And I don't think it is that uncommon. Especially when the device joins
> the network for the first time and has not time synchronized itself prope=
rly yet.
>
> Do you know what the i225/i226 do for hardware offloaded Qbv in that case?
>

In offloaded cases, in my understanding, i225/i226 re-uses most of how
launchtime works for Qbv, so the scheduling is almost per frame, during
transmission, the hw assigns each frame an offset into the gate open
event. And that time is used to calculate when the packet should reach
the wire.

So I would expect to see a few stuck packets (causing transmissions
timeouts) or early transmissions, depending on the direction of the
jump, but things should be able to recover eventually.

>>=20
>>> Yun Lu, does this only happen for time jumps into the past or also for =
large jumps into the future?
>>> And does this also happen for small time "jumps"?
>>=20
>> AFAIU this bug will only happen with large jumps into the past. For
>> small jumps into the past, it will spin uselessly for a bit. For jumps
>> into the future, the schedule will be stuck in a particular gate entry
>> until the future becomes now.
>
> Does "it will spin uselessly for a bit" mean the CPU is stuck for that ti=
me
> (even if it is short)? If that is the case, it might lead to very strange=
 effects
> in RT systems. And these small time jumps into the past (even if just a f=
ew us)
> should actually be relatively common.
>

Yes. The hrtimer will expire, advance_sched() will get the next entry
and its expiration, set the hrtimer expiration to that, this will repeat
until that expiration is after "current" time. As this is hrtimer
function, this will block other things from running on that cpu.

My expectation for taprio in software mode was more something that
people would use to validate new schedules, do some experiments, that
kind of thing. What I was expecting to have in more serious cases was
the offloaded mode.

What I am trying to say is all I am hearing is that the software mode is
being used more seriously than I thought. So this work is a bit more
important. I will add this to my todo list, but I won't be sad at all if
someone beats me to it ;-)

> Greetings,
> Florian
>
>>=20
>>>
>>> Thanks,
>>> Florian
>>>
>>>>
>>>>
>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (tc =3D 0; tc < num_tc; tc++) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next->gat=
e_duration[tc] =3D=3D oper->cycle_time)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 next->gate_close_time[tc] =3D KTIME_MAX;
>>>>>> @@ -1210,6 +1233,7 @@ static int taprio_get_start_time(struct Qdisc =
*sch,
>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base =3D sched_base_time(sched=
);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 now =3D taprio_get_time(q);
>>>>>> +=C2=A0=C2=A0=C2=A0 q->offset =3D taprio_get_offset(q);
>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ktime_after(base, now)) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *start =3D ba=
se;
>>>>>> --=C2=A0
>>>>>> 2.34.1
>>>>>>
>>>>>
>>>>> Cheers,
>>>>
>>>
>>=20
>>=20
>> Cheers,


Cheers,
--=20
Vinicius

