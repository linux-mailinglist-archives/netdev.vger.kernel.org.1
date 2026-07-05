Return-Path: <netdev+bounces-304783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dw/yNuxkSmpxCQEAu9opvQ
	(envelope-from <netdev+bounces-304783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 16:06:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F084470A3CA
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 16:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=HZ2WXYLj;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304783-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304783-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE1E3003EC8
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 14:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB437EFE9;
	Sun,  5 Jul 2026 14:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C83803D1
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 14:04:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260248; cv=pass; b=MN7vKneaIEWiTZiC0JgpQgL0K8t4gtsjTZnfsOxbmTyUCl6kru3EMI1IivpK7UHRk9SQDae7QlDxA7YQ+nP5rte5LsmotPxRIqNc/kQ5xf1dqdHtexvGp6L5Gjy3P8FeyCDc0PliMIBtezIsDn4tFnNve72Fv9OHS4q3mCY01Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260248; c=relaxed/simple;
	bh=kakKne0EgDfucXuQ0PX+nfBbCLc7Urw3aYMCYO/CowU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRQD1GVsw4bRuvKeELtZ3CmYtA3lmYa3igEnJF9ZiIJmfZpq7FWTkqFQpggfADfqleZzJKjK5rPeupIOeF1+fiCMW9cvlDEOsXAiDiGt9EmCiTpyA6tPvWUjdKk5/VuN3LGFkULH4ubxHcTJonH4O6nw10vtbz7/QELrFkh2EL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=HZ2WXYLj; arc=pass smtp.client-ip=74.125.224.48
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664ce3000e6so1628725d50.0
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 07:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783260246; cv=none;
        d=google.com; s=arc-20260327;
        b=cc8EmvJaQRW9GXxav48YyYF92Gl8rhqWu2UbzQX0mkwpj1WN9SsIBFcNfItnOLjhRT
         PxTV1pNL5QVRlpTB3hg1FMaEkHuov+DbJSRM9nRmwwMBcmu71jC9A3MCHqI8giB3BiDo
         BjzbLPZI0frFfPNztu8qhAgAuM9l3DrHMqqDg+eDMwNElKfJCBAuc05f3Pd3Eu1FgXP5
         cFJca1O/JmRcOJ2BipmKrNwwlEh3adKxngVHkVduwuTJIqYURXD4y2ptHXcr1su6IgLh
         hsZGa1hhCK+g2kqyPn9vEdFDmvcPDAGFttdkzSjADmrLPCS/MdxvcscLnAesHM1ymSSD
         0fgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOeIHvaWNTRw9NcZ+F+Xnp1pzsZrL0QiN5VA73LV1XE=;
        fh=zcxlSlMQ+NODioSEDeR8vot8PGC4g1KKYjBACTP4Ro4=;
        b=LUka9D2AfWXhjYtjC//V+62Bco3GSS2tHrSg1X/Cv4OjJPc1N4kdOql/7ZJmXdcf1c
         lvcGRpKkNKNXQeHtebHiwRToTWXA5byExPzy/VhuRVAiV0Jb94YBT4si+OO3bgnBv8U8
         oafQoenogwa7uVokSVFyCHFJmvQRgM5uwt9wT/PW1A+ZxQ4iLatlqKkW3c/g/IiBIYvH
         JU+Rmxm+JLpHIfAIijKL6oWiJ6v1xvM8oupqe3jt/P2h0H6mgf2A2f1CYCY0DI9PFrg6
         x7d1wU+HSsFMKNtLPv0avAyRV7bAYXyH8Yr+F3EtaXGSN2zNHNk4lxX5b9Jj5n4WcYhS
         UN/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1783260246; x=1783865046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eOeIHvaWNTRw9NcZ+F+Xnp1pzsZrL0QiN5VA73LV1XE=;
        b=HZ2WXYLjOJbHTVJU1PTzn3VdsvmNDSD3ZDhz0lxXSLo45YHdmpQY+71VKLQLJXa2Dl
         mvJzOhZSuTntT8c+23ehzFMmLjA5A9WmiYRe/cm6agcfrsrrho/QkcjIGAKD0pgNm7Jd
         w6D/fbx0ohSWhfoNpe24foj9NGY9zZfp5JfbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783260246; x=1783865046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOeIHvaWNTRw9NcZ+F+Xnp1pzsZrL0QiN5VA73LV1XE=;
        b=qZtn/5rTTKobci5ngisLZRsfi/qS8Ysy5XLFx1SrNlWBP7aEjNDTCHUze+pGRyIcsZ
         QbLCecSiUVJA1aD6Pq3q9ZHtAbIs2Gx1A6jdadDd/Gsr9YHcpiATe0PhWsuud7ZkYsYP
         gQy+oMydy4haFaaXO6LBQ4S+cMYBlETl9kPRO+ws2509FYulO4mX/tHa9KzFZGEmGK/n
         +0kMZCJJZFenF0tgMeKNrc81CyA7tu3vLBmfWdU4TNRx2xubGAxs9QpqGDoQOUWth9ve
         G19L7rXQnmNeHp/D8OZjdOYAiSITJekwzTr3fdzAG8vYkknasWhP6rwR4EJKsBXjCZym
         /mlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rov8OKP2lrAoEcHXIK9FNFwuun9tSGg6kd/GM0xZ4LK1vn4gK3DtUwDamcOJ2drDzYMxWSuqXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4JkunGLqjSC+9SjbqBoSU6n5ad6a58o6ia2aBTEy/s74g2q84
	TDB911bj3ixH9IZCTvw+gqagvnitUetlsxC1yRK0tOhg66xg2bhqtqRxgthy57r9U2/cJB1AJ6W
	vg00QkV3Kx3gO9wm5BLlhv0g8IhNW5uHXjVAiilCo
X-Gm-Gg: AfdE7clt174lwra8WlXzUSBKP5lSnlF4maGSnIKpAVS5XlvSf5yZ8kKuvt8cKIIhSUl
	UskJBDkLZkgSqa03Om6qBhx4j7v3Hvc33gSiL6PPyXeRCIfpfUh9lehISlFwgynIm6s2jP+W4V8
	6vJgZ72T9U/SDrKEhkyBBq30sgzEutpNfC47ky7Q0YYC0Yo+5yiiIXP/Xvt5wqrnRDe8sZTyMbs
	4I3X4JWIjhmRbvmkxXpfDlXDKE/Y+iSgd8JhERKdthfsXr2eZX2Zy1dxDuUIhVzByFFhrkz1Sv8
	jd3S
X-Received: by 2002:a05:690e:11cc:b0:664:dbfc:e46a with SMTP id
 956f58d0204a3-66652e66e21mr6863949d50.19.1783260245720; Sun, 05 Jul 2026
 07:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630123331.186840-1-daniel@iogearbox.net> <20260630123331.186840-3-daniel@iogearbox.net>
 <CAM0EoMn6H6cKCweHmt=8ve2i0JuK=E8W1Q89oqDD7vra_Uuk-w@mail.gmail.com>
 <d9fce17f-851e-4cb0-9d78-2ac2cadfda81@iogearbox.net> <CAM0EoMnZPbKG3GCndk2Xp44KxUfPJzSMGXYPDZeoa_-6JZ+Uuw@mail.gmail.com>
 <c526d9d9-db4c-45e8-96c5-52b2a9dca7e8@redhat.com>
In-Reply-To: <c526d9d9-db4c-45e8-96c5-52b2a9dca7e8@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 5 Jul 2026 10:03:53 -0400
X-Gm-Features: AVVi8CeG9O3TK3HqjDcb3pIV075W7jf3weYjl-1a9FqDQYgpOGDfycAxpf-fEc8
Message-ID: <CAM0EoM=Ct36Dt7sgXF=qB_2B67L0JbBcf-R3FV=G5Y+DvQu5uw@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:daniel@iogearbox.net,m:kuba@kernel.org,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:victor@mojatatu.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304783-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,linutronix.de,gmail.com,vger.kernel.org,mojatatu.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F084470A3CA

On Sun, Jul 5, 2026 at 3:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi,
>
> On 7/1/26 5:35 PM, Jamal Hadi Salim wrote:
> > On Tue, Jun 30, 2026 at 11:23=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >>
> >> On 6/30/26 5:16 PM, Jamal Hadi Salim wrote:
> >>> On Tue, Jun 30, 2026 at 8:33=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >>>> From: Jamal Hadi Salim <jhs@mojatatu.com>
> >>>>
> >>>> When a TC filter attached to a qdisc filter chain returns
> >>>> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or a=
n
> >>>> act_bpf action), the redirect was silently lost i.e no qdisc classif=
y
> >>>> function handled TC_ACT_REDIRECT, so the packet fell through the
> >>>> switch and was enqueued normally instead of being redirected.
> >>>>
> >>>> This has been broken since bpf_redirect() was introduced for TC in
> >>>> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
> >>>> for a long time because bpf_net_context was a per-CPU variable that
> >>>> was always available.
> >>>>
> >>>> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_stru=
ct
> >>>> on PREEMPT_RT.") turned bpf_net_context into a task_struct member th=
at
> >>>> is only set up by explicit callers. Without a caller setting it up,
> >>>> bpf_redirect() itself crashes with a NULL pointer dereference in
> >>>> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
> >>>> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
> >>>> adding skb_do_redirect() calls to every qdisc classify function, whi=
ch
> >>>> would require changes across net/sched/. Isolate it to ebpf core whe=
re
> >>>> it belongs.
> >>>>
> >>>> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
> >>>> wrapper around tcf_classify() for use by qdisc classify functions an=
d
> >>>> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
> >>>> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
> >>>> than letting it continue silently. Dropping is preferred over
> >>>> letting the packet through because the user immediately sees packet
> >>>> loss. Silently passing the packet through would hide the problem and
> >>>> leave the user wondering why their redirect is not working.
> >>>>
> >>>> The clsact fast path, tc_run() continues to call tcf_classify() dire=
ctly
> >>>> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
> >>>> sch_handle_egress/ingress() calling skb_do_redirect() as before.
> >>>>
> >>>> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> >>>> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_stru=
ct on PREEMPT_RT.")
> >>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >>>> ---
> >>>>   include/net/pkt_cls.h    | 14 +++++++++++++-
> >>>>   net/sched/cls_api.c      |  4 +---
> >>>>   net/sched/sch_cake.c     |  2 +-
> >>>>   net/sched/sch_drr.c      |  2 +-
> >>>>   net/sched/sch_dualpi2.c  |  2 +-
> >>>>   net/sched/sch_ets.c      |  2 +-
> >>>>   net/sched/sch_fq_codel.c |  2 +-
> >>>>   net/sched/sch_fq_pie.c   |  2 +-
> >>>>   net/sched/sch_hfsc.c     |  2 +-
> >>>>   net/sched/sch_htb.c      |  2 +-
> >>>>   net/sched/sch_multiq.c   |  2 +-
> >>>>   net/sched/sch_prio.c     |  2 +-
> >>>>   net/sched/sch_qfq.c      |  2 +-
> >>>>   net/sched/sch_sfb.c      |  2 +-
> >>>>   net/sched/sch_sfq.c      |  2 +-
> >>>>   15 files changed, 27 insertions(+), 17 deletions(-)
> >>>>
> >>>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> >>>> index 3bd08d7f39c1..5f5cb36439fe 100644
> >>>> --- a/include/net/pkt_cls.h
> >>>> +++ b/include/net/pkt_cls.h
> >>>> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *=
skb,
> >>>>   {
> >>>>          return TC_ACT_UNSPEC;
> >>>>   }
> >>>> -
> >>>>   #endif
> >>>> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> >>>> +                                    const struct tcf_proto *tp,
> >>>> +                                    struct tcf_result *res, bool co=
mpat_mode)
> >>>> +{
> >>>> +       int ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> >>>> +
> >>>> +       /* TC_ACT_REDIRECT from qdisc filter chains is not supported=
.
> >>>> +        * Use BPF via tcx or mirred redirect instead.
> >>>> +        */
> >>>> +       if (unlikely(ret =3D=3D TC_ACT_REDIRECT))
> >>>> +               ret =3D TC_ACT_SHOT;
> >>>> +       return ret;
> >>>> +}
> >>>
> >>> Why did you remove the warning?
> >>> A lesser issue is that you introduced a space above #endif
> >>
> >> I don't think we need to put out an extra warn to spam the log, this
> >> can be easily traced either via bpftrace or qdisc stats etc; plus the
> >> guidance to eBPF with clsact is also obsolete. Given noone has run
> >> into this the last 10y, I don't think it really matters tbh.
> >
> > It's a bit entitled for you to change someone else's patch to fit your
> > philosophy without a mention.
> > It's only one message per qdisc. But fine, let's keep it that way.
> > Sashiko is hallucinating on TC_ACT_CONSUMED for patch 1. Let's ignore i=
t.
>
> @Jamal: I read the above as if you are ok with the series in the current
> form as a whole. Please LMK.
>

I am fine with series.

cheers,
jamal

> FTR, I have a slight preference towards the extra warn message in case
> of misconfiguration, but big deal either way.
>
> /P
>

