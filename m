Return-Path: <netdev+bounces-303276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3wdxH4LfQ2pLkwoAu9opvQ
	(envelope-from <netdev+bounces-303276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:23:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA796E5E5D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:23:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=lfQu91Pp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303276-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303276-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BE1630387B6
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD836D506;
	Tue, 30 Jun 2026 15:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353A331EC4;
	Tue, 30 Jun 2026 15:23:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833023; cv=none; b=DL4bqqtUT/jKi4zsOkQ5EwXeiQOvSxUgmI9dUBzfDwON2kr7+ayqBVVRWfl2DYI9ADwwK46DrZhD3cMggRT6BHNuPHxaFipzNpEXVQP7ICEGRUe7STJ+AvEfAO2xJ+P30TOFV7TfGznoELRvYgLfhGl0QLCMb2dRZFc1xBjF4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833023; c=relaxed/simple;
	bh=jTUcFUdqVXaryJJT5G6c3pRyMG8K6/CvBsvXR5TR3ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMYfTah9uEk9TzdbLdwNqjDsxhcyn5fdqJ+sAT2/JWhfZae5ZzkzG01uKdRsqSYqJO5mY8KJg2c3p967kEWs6OvlSOCHYYaiSlfYGhUzipV07cmQca0G6d8bcGaNxxpPV4073lee/qnDJ2sd0glnJrWgyQLFsu45oL8Q0NIJ2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lfQu91Pp; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nMee/uZbUMe58sUAmrz7UN0eTZdK+lUDrEcGLJFtnsQ=; b=lfQu91PpItXOIDI1dj5Llh0TqB
	d2EIJ+XDYTx3xFyAhEH3H5QgdopxkiSpLhUUDVy6XoHg2UFCdaWAdLZ5ubGqajWbjsvTXDBVCNpQe
	yJjSABniMb80AC+ehwh0XqfS3KhilcqL2NC34+2wSlI88Aa8V4dF4CJY6rvi/s0OuZ7jk1DIckcrB
	CuZ3CjSoFw6eBO23kduaFUG7cj0+kubgDdTVkVV85agE7hCq2L/35jMTnPQtr+XyFL7zKDwRz3PfS
	jvUYx1yowu9phjXDW3ZKTNVDsrc+U4A3a2TVC7rCBa86TzLIbJEQQnmja/XUj5IyGhUyW3n2dBNir
	PY8fgS2w==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1weaJH-000LzG-2I;
	Tue, 30 Jun 2026 17:23:39 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1weaJH-000Mpw-18;
	Tue, 30 Jun 2026 17:23:39 +0200
Message-ID: <d9fce17f-851e-4cb0-9d78-2ac2cadfda81@iogearbox.net>
Date: Tue, 30 Jun 2026 17:23:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de,
 andrii@kernel.org, memxor@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>
References: <20260630123331.186840-1-daniel@iogearbox.net>
 <20260630123331.186840-3-daniel@iogearbox.net>
 <CAM0EoMn6H6cKCweHmt=8ve2i0JuK=E8W1Q89oqDD7vra_Uuk-w@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAM0EoMn6H6cKCweHmt=8ve2i0JuK=E8W1Q89oqDD7vra_Uuk-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28046/Mon Jun 29 08:27:20 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linutronix.de,gmail.com,vger.kernel.org,mojatatu.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:victor@mojatatu.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mojatatu.com:email,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,iogearbox.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DA796E5E5D

On 6/30/26 5:16 PM, Jamal Hadi Salim wrote:
> On Tue, Jun 30, 2026 at 8:33 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> From: Jamal Hadi Salim <jhs@mojatatu.com>
>>
>> When a TC filter attached to a qdisc filter chain returns
>> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
>> act_bpf action), the redirect was silently lost i.e no qdisc classify
>> function handled TC_ACT_REDIRECT, so the packet fell through the
>> switch and was enqueued normally instead of being redirected.
>>
>> This has been broken since bpf_redirect() was introduced for TC in
>> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
>> for a long time because bpf_net_context was a per-CPU variable that
>> was always available.
>>
>> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
>> on PREEMPT_RT.") turned bpf_net_context into a task_struct member that
>> is only set up by explicit callers. Without a caller setting it up,
>> bpf_redirect() itself crashes with a NULL pointer dereference in
>> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
>> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
>> adding skb_do_redirect() calls to every qdisc classify function, which
>> would require changes across net/sched/. Isolate it to ebpf core where
>> it belongs.
>>
>> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
>> wrapper around tcf_classify() for use by qdisc classify functions and
>> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
>> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
>> than letting it continue silently. Dropping is preferred over
>> letting the packet through because the user immediately sees packet
>> loss. Silently passing the packet through would hide the problem and
>> leave the user wondering why their redirect is not working.
>>
>> The clsact fast path, tc_run() continues to call tcf_classify() directly
>> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
>> sch_handle_egress/ingress() calling skb_do_redirect() as before.
>>
>> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
>> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   include/net/pkt_cls.h    | 14 +++++++++++++-
>>   net/sched/cls_api.c      |  4 +---
>>   net/sched/sch_cake.c     |  2 +-
>>   net/sched/sch_drr.c      |  2 +-
>>   net/sched/sch_dualpi2.c  |  2 +-
>>   net/sched/sch_ets.c      |  2 +-
>>   net/sched/sch_fq_codel.c |  2 +-
>>   net/sched/sch_fq_pie.c   |  2 +-
>>   net/sched/sch_hfsc.c     |  2 +-
>>   net/sched/sch_htb.c      |  2 +-
>>   net/sched/sch_multiq.c   |  2 +-
>>   net/sched/sch_prio.c     |  2 +-
>>   net/sched/sch_qfq.c      |  2 +-
>>   net/sched/sch_sfb.c      |  2 +-
>>   net/sched/sch_sfq.c      |  2 +-
>>   15 files changed, 27 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
>> index 3bd08d7f39c1..5f5cb36439fe 100644
>> --- a/include/net/pkt_cls.h
>> +++ b/include/net/pkt_cls.h
>> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *skb,
>>   {
>>          return TC_ACT_UNSPEC;
>>   }
>> -
>>   #endif
>> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
>> +                                    const struct tcf_proto *tp,
>> +                                    struct tcf_result *res, bool compat_mode)
>> +{
>> +       int ret = tcf_classify(skb, NULL, tp, res, compat_mode);
>> +
>> +       /* TC_ACT_REDIRECT from qdisc filter chains is not supported.
>> +        * Use BPF via tcx or mirred redirect instead.
>> +        */
>> +       if (unlikely(ret == TC_ACT_REDIRECT))
>> +               ret = TC_ACT_SHOT;
>> +       return ret;
>> +}
> 
> Why did you remove the warning?
> A lesser issue is that you introduced a space above #endif

I don't think we need to put out an extra warn to spam the log, this
can be easily traced either via bpftrace or qdisc stats etc; plus the
guidance to eBPF with clsact is also obsolete. Given noone has run
into this the last 10y, I don't think it really matters tbh.

Thanks,
Daniel

