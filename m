Return-Path: <netdev+bounces-124125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7219682D5
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29301F21FD0
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCA3187861;
	Mon,  2 Sep 2024 09:12:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E689187547;
	Mon,  2 Sep 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268375; cv=none; b=Q9mB5N2wNRAT/jUlafl6MVh0y6UTIUdrfPemuZbsdvpW6LIErs2yy3JvJMxQGilQN7ncgzRdf2APDxfIUjGNW4B4H7mC/BoR38Tm+uUY1DWPfoeGmXDrX7BN3PjVAqYD1V1Lg3xncaBjDA2DXKYLIW9Fw7ZzpI4S0L3is/U5ibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268375; c=relaxed/simple;
	bh=zGgj5jyXVGaaxxCaLsxnwIBByIzH1s3DIKp7nMRUOMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSYKmWoc+RtHVebR4no/pU3jKtURKjaFEcG9EoY6f+WAi4rc1WMlJt1qPyRcIhJFmDdn45eS0uNCVEGTTXA1FqGOCV3RFlQQ+OUeC3RcQirjW+bbRCodHz7ENDXPYjqzi23BOwaVu5k7bGlGmplr5SHS8v7dWtLnGWzl87Gqj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7ebffe58690b11efa216b1d71e6e1362-20240902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:074946e5-9594-4ff7-9ef4-33885013dae6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:e1679a74f9659744bcce0c6f4470f2ac,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7ebffe58690b11efa216b1d71e6e1362-20240902
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 795379890; Mon, 02 Sep 2024 17:12:36 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 30BD7B80758A;
	Mon,  2 Sep 2024 17:12:36 +0800 (CST)
X-ns-mid: postfix-66D58184-1073891000
Received: from [10.42.20.151] (unknown [10.42.20.151])
	by node2.com.cn (NSMail) with ESMTPA id EDFB4B80758A;
	Mon,  2 Sep 2024 09:12:34 +0000 (UTC)
Message-ID: <2df10720-1790-48bd-a50c-4816260543b0@kylinos.cn>
Date: Mon, 2 Sep 2024 17:12:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CPU stuck due to the taprio hrtimer
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627055338.2186255-1-luyun@kylinos.cn>
 <87sewy55gp.fsf@intel.com>
Content-Language: en-US
From: luyun <luyun@kylinos.cn>
In-Reply-To: <87sewy55gp.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2024/6/28 07:30, Vinicius Costa Gomes =E5=86=99=E9=81=93:
> Yun Lu <luyun@kylinos.cn> writes:
>
>> Hello,
>>
>> When I run a taprio test program on the latest kernel(v6.10-rc4), CPU =
stuck
>> is detected immediately, and the stack shows that CPU is stuck on tapr=
io
>> hrtimer.
>>
>> The reproducer program link:
>> https://github.com/xyyluyun/taprio_test/blob/main/taprio_test.c
>> gcc taprio_test.c -static -o taprio_test
>>
>> In this program, start the taprio hrtimer which clockid is set to REAL=
TIME, and
>> then adjust the system time by a significant value backwards. Thus, CP=
U will enter
>> an infinite loop in the__hrtimer_run_queues function, getting stuck an=
d unable to
>> exit or respond to any interrupts.
>>
>> I have tried to avoid this problem by apllying the following patch, an=
d it does work.
>> But I am not sure if this can be the final solution?
>>
>> Thanks.
>>
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>> ---
>>   net/sched/sch_taprio.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index a0d54b422186..2ff8d34bdbac 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -104,6 +104,7 @@ struct taprio_sched {
>>   	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
>>   	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
>>   	u32 txtime_delay;
>> +	ktime_t offset;
>>   };
>>  =20
>>   struct __tc_taprio_qopt_offload {
>> @@ -170,6 +171,19 @@ static ktime_t sched_base_time(const struct sched=
_gate_list *sched)
>>   	return ns_to_ktime(sched->base_time);
>>   }
>>  =20
>> +static ktime_t taprio_get_offset(const struct taprio_sched *q)
>> +{
>> +	enum tk_offsets tk_offset =3D READ_ONCE(q->tk_offset);
>> +	ktime_t time =3D ktime_get();
>> +
>> +	switch (tk_offset) {
>> +	case TK_OFFS_MAX:
>> +		return 0;
>> +	default:
>> +		return ktime_sub_ns(ktime_mono_to_any(time, tk_offset), time);
>> +	}
>> +}
>> +
>>   static ktime_t taprio_mono_to_any(const struct taprio_sched *q, ktim=
e_t mono)
>>   {
>>   	/* This pairs with WRITE_ONCE() in taprio_parse_clockid() */
>> @@ -918,6 +932,7 @@ static enum hrtimer_restart advance_sched(struct h=
rtimer *timer)
>>   	int num_tc =3D netdev_get_num_tc(dev);
>>   	struct sched_entry *entry, *next;
>>   	struct Qdisc *sch =3D q->root;
>> +	ktime_t now_offset =3D taprio_get_offset(q);
>>   	ktime_t end_time;
>>   	int tc;
>>  =20
>> @@ -957,6 +972,14 @@ static enum hrtimer_restart advance_sched(struct =
hrtimer *timer)
>>   	end_time =3D ktime_add_ns(entry->end_time, next->interval);
>>   	end_time =3D min_t(ktime_t, end_time, oper->cycle_end_time);
>>  =20
>> +	if (q->offset !=3D now_offset) {
>> +		ktime_t diff =3D ktime_sub_ns(now_offset, q->offset);
>> +
>> +		end_time =3D ktime_add_ns(end_time, diff);
>> +		oper->cycle_end_time =3D ktime_add_ns(oper->cycle_end_time, diff);
>> +		q->offset =3D now_offset;
>> +	}
>> +
> I think what we should do here is a bit different. Let me try to explai=
n
> what I have in mind with some context.
>
> A bit of context: The idea of taprio is to enforce "TSN" traffic
> schedules, these schedules require time synchronization, for example vi=
a
> PTP, and in those cases, time jumps are not expected or a sign that
> something is wrong.
>
> In my mind, a time jump, specially a big one, kind of invalidates the
> schedule, as the schedule is based on an absolute time value (the
> base_time), and when time jumps that reference in time is lost.
>
> BUT making the user's system unresponsive is a bug, a big one, as if
> this happens in the real world, the user will be unable to investigate
> what made the system have so big a time correction.
>
> So my idea is to warn the user that the time jumped, say that the user
> needs to reconfigure the schedule, as it is now invalid, and disable th=
e
> schedule.
>
> Does this make sense?
>
> Ah, and thanks for the report.

Hello Vinicius,

May I ask is there a fix patch for this issue?

I test it on the latest kernel version,=C2=A0 and it still seems to cause=
 CPU=20
stuck.

As you mentioned, a better way would be to warn the user that the=20
current time has jumped and cancel the hrtimer,

but I'm not sure how to warn the user, or just through printk?

Thanks and best regards.


>
>>   	for (tc =3D 0; tc < num_tc; tc++) {
>>   		if (next->gate_duration[tc] =3D=3D oper->cycle_time)
>>   			next->gate_close_time[tc] =3D KTIME_MAX;
>> @@ -1210,6 +1233,7 @@ static int taprio_get_start_time(struct Qdisc *s=
ch,
>>  =20
>>   	base =3D sched_base_time(sched);
>>   	now =3D taprio_get_time(q);
>> +	q->offset =3D taprio_get_offset(q);
>>  =20
>>   	if (ktime_after(base, now)) {
>>   		*start =3D base;
>> --=20
>> 2.34.1
>>
>
> Cheers,

