Return-Path: <netdev+bounces-278557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKs+F1SI3mlXFgAAu9opvQ
	(envelope-from <netdev+bounces-278557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:32:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 937943FDB47
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCDAF3029276
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185031A576;
	Tue, 14 Apr 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmuFBM5s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2114E2F2;
	Tue, 14 Apr 2026 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776191212; cv=none; b=c2qYoM9+kt2afgxw1HLcZ6nnlGI8Zv+OCe+4to+Vo6atNC7LhD79K4F9lbvifb9S5lX7h+ynRr2l6TaRE3bSlCgofeGxlqjJhiUZB5xpoRyeAfuEGF6bWbzH8Re7Q9riNs4ZgFYEzo9/AyrVZ8TBx8A7S6KR6vnFaky8ojs/O9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776191212; c=relaxed/simple;
	bh=eVGklJJH6siyD03qip+Z4jYrrKdxcS+//VzEoL+ZBPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dOuxN/eRcc+IuEbLrF3X8ON0qo8djSvwJog892kLGepfELilG0Pv5Z3Dtkg4wclYwwU7rO8biIIEaBbyN5V9cJM1vY9kh2viPj50MwMT6bk9nf53YCuo2T/uBlr5/f2sxsbuZc2JMwK/KAiOs4vcNIS1psyrKfaQ8EteacNnj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmuFBM5s; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776191211; x=1807727211;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eVGklJJH6siyD03qip+Z4jYrrKdxcS+//VzEoL+ZBPs=;
  b=mmuFBM5shW9jyoX/hz3dEqavDUINufsibpUJBnIv1KyF5B8OywJIWC6o
   ++grvDrbv7hNgFdNJG/Bvu17tdJhuJDZTISRaBWPSBbaCC5iGS8+jcRIu
   dI4s0517iSrDvfr5UKpn1zqomwBbNe0jwsSZeEvVV5oR1r4dX262qAYxZ
   e5vCubv4oxKuC9MZ7rytz8fSk2SczHv625L6t4y4hCdTkufvig8CepI8O
   9BvFdvWSbbeDfXpzaGHx9wKktN0vKnS82ZALVEsY3SBrDGo1+gbR0h/Xr
   CVpAsnVJ2tgKAqWRkrazVTOvRZViD75yghw+o0F9tkzNaJ8abh4qPS6P7
   w==;
X-CSE-ConnectionGUID: KJjk3I5uQfKQL84e2apbnQ==
X-CSE-MsgGUID: jm4xuyf1S3SuB3+wNc53Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77130152"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77130152"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:26:50 -0700
X-CSE-ConnectionGUID: nEsWNEfrSk6cp4SL1LhHow==
X-CSE-MsgGUID: 5PrsYx1lTsy81z1nql4FtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225457468"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:26:49 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, vladimir.oltean@nxp.com,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 qjx1298677004@gmail.com
Subject: Re: [PATCH net] net/sched: taprio: fix use-after-free in
 advance_sched() on schedule switch
In-Reply-To: <20260413230106.3654555-1-kuba@kernel.org>
References: <20260410-taprio-user-after-free-fix-net-v1-1-0931b1579988@intel.com>
 <20260413230106.3654555-1-kuba@kernel.org>
Date: Tue, 14 Apr 2026 11:26:49 -0700
Message-ID: <87pl418kk6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278557-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 937943FDB47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> writes:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/sched: taprio: fix use-after-free in advance_sched() on schedule switch
>
> This commit updates advance_sched() to select the next entry from the new
> oper schedule immediately after switch_schedules() returns. It relies on the
> pre-calculated end_time of the new schedule's first entry instead of
> overwriting it with the admin schedule's base time.
>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index f721c03514f60..0316f2dee06ac 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>
> [ ... ]
>
>> @@ -972,11 +972,12 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>  	}
>>  
>>  	if (should_change_schedules(admin, oper, end_time)) {
>> -		/* Set things so the next time this runs, the new
>> -		 * schedule runs.
>> -		 */
>> -		end_time = sched_base_time(admin);
>
> Does removing this assignment introduce a regression where the new schedule
> activates prematurely?
>

should_change_schedules() checks if the previous 'end_time' is after the
start of the "new" admin schedule.

> Since the new schedule's first entry has its end_time pre-calculated
> as base_time + interval, if we activate it early (before its actual
> base_time), does it stretch the entry backwards in time?

If the hrtimer triggers early, that might be possible. But one fact is
that this is on the software implementation, and as its accuracy is the
hrtimer accuracy, second guessing what the hrtimer did/is doing here
seems wrong.

>
> Could this cause its gate mask to apply during the time gap, violating the
> strictly configured gate durations?

Yeah, if the hrtimer fires early, we might have some schedule entries
that are longer than they should be. But that is an intrinsic limitation
of the software mode (at least in its current implementation). 

So, in short, not really concerned about this "violation of strictness",
as long as we are not making it worse, to be clear.

>
>>  		switch_schedules(q, &admin, &oper);
>
> Can this sequence cause a use-after-free regression due to the RCU grace
> period starting too early?
>
> Inside switch_schedules(), call_rcu() is invoked on the old oper
> schedule. However, q->current_entry is not updated until later in
> advance_sched() at the first_run label:
>
> first_run:
> 	rcu_assign_pointer(q->current_entry, next);
>
> If a concurrent reader calls rcu_dereference(q->current_entry) between
> switch_schedules() and this assignment, can it acquire a pointer to the
> old schedule after call_rcu() has already started? This would mean the
> grace period will not wait for this new reader.

I had to sleep on this, yeah, this is possible, but the window is very
narrow. And not introduced by this fix. I guess this problem existed
since I added the concept of an "admin" schedule.

Will fix on a separate patch. Need to think more about this.

>
> As a separate pre-existing issue, can switch_schedules() be called
> concurrently by lockless readers?
>
> If advance_sched() calls it under q->current_entry_lock, but a concurrent
> reader like get_packet_txtime() evaluates the switch condition and calls
> switch_schedules() without holding locks, can they race?

At configuration time, txtime-assisted (which calls get_packet_txtime())
mode and the software mode (which "runs" advance_sched()) are blocked to
run at the same time. This should not be possible.

>
> Could this lead to call_rcu() being called twice on the same old oper
> object, potentially corrupting the RCU callback list?
>
>> +		/* After changing schedules, the next entry is the first one
>> +		 * in the new schedule, with a pre-calculated end_time.
>> +		 */
>> +		next = list_first_entry(&oper->entries, struct sched_entry, list);
>> +		end_time = next->end_time;
>>  	}
>>  
>>  	next->end_time = end_time;


Cheers,
-- 
Vinicius

