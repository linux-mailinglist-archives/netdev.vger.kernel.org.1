Return-Path: <netdev+bounces-303724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R7zIKcU0RWqk8goAu9opvQ
	(envelope-from <netdev+bounces-303724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:39:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEC6EF545
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=FltoVmhk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303724-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303724-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3AF6302AE0D
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4C548C402;
	Wed,  1 Jul 2026 15:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EAE48094D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:35:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920129; cv=pass; b=P9JXDmHzZ0eAMOPZe61IBjk2/7sba4+iZ+MiWoJMHuUb56ZjJxAD0OEjJc3h0OcM8DfW/qC6MKf7E1GioigxvngB4O5Kgj9SIJSkSvA7f0DKrMB7mfVGjdx6O+L8j4OyiVY9/z1I8aSd3GpwKW7aOWeFAoVeI7UJQwryZymYpkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920129; c=relaxed/simple;
	bh=Y2c6QTfFJtVu0RfirbPQ6iVT1Kw5wPu8BkJiRRYRdIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHIM+YnqsAx6byfgVdZLtVL5nbI0WK3qudUGGUJ4qtdH1TRcDd4c02YYDI8CYUNrwkLqjxgorQ+mIh7AhHe9Tx+SYDOr5tUCRMGJDtEnxT3yjO18gfbMWds4i4BhQ5nJAcyGqA0GoaerlrHgeBq657sy9ip8+SzjQrBv91ImsEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=FltoVmhk; arc=pass smtp.client-ip=74.125.224.47
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664ae993e4bso787461d50.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 08:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782920123; cv=none;
        d=google.com; s=arc-20260327;
        b=PEFLWzEEYjgrPJ0xQnb0/fHS7KvWmZroG85P7hwA23+oamwpkxY2mTjofaOEcjHKdb
         liflihO6oK/vhNPGVqzqiy1HPeQPHIo/xBcAFuWVdNCuxYtAXon0OFPYEZYyhKaLqLN5
         7ADsZLJ7caqYU5Nb2Zp83j0RzcV6CmrnVDDyCpG5UTB9B+d+K8OdAdTBQXxeDSOPccHv
         kbYzqj+Qbvrpm2t2cVeKLcq2B7+vf8hMSAOlKcYPiOHGUCTRfqmRS8aa2nUAo1PsFleR
         d7n9HbK6rB1yMHIiKOLM3x9MWCB5/in2tIQtgvO590aB5wTAnYEMwPP0dno/Zuy0yk9Q
         iNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndR8vhWFt9KSYRpwVTspSwgHXJD0hfWVRuMdjE0PPzc=;
        fh=o+Rx+VxnJxfBM4DYa7J0p4/KlM0kd7Y0629JqfyAkAs=;
        b=BblkyNxB5rUJyWi/Osn8I0sNRvTyWAfiyLY0AHEUgeEuZ8aujPFu8dzR9+oqGg9iY1
         Z0QqtK7rUva4rZ17WlgGB4kZPtcg6fWE/1PDloy/5/kKcvO0WdY34gJ/ez/2QzzL6Ttv
         fle5KiP8sgVRmw4NFlmMJ5+sF8L8ND27950jG43qwyOBVmtC5IthUamLvFHUUNspXBSD
         rW1jNgLNj/E3CzZgiNEPJn6y0bMw6JlV8QFYeEpMhYsg8kJQ4Fi3tSXbhk0zXhSJ5AVJ
         z9gR7+hi0SMOKFbFJKQwBKCRGnds32U/9gNPixK2m6ZWF9u33J9HEpuzmzLGhfDC/nxs
         vBUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782920123; x=1783524923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndR8vhWFt9KSYRpwVTspSwgHXJD0hfWVRuMdjE0PPzc=;
        b=FltoVmhkn3E9PCmMtx+l+2vCJp/LzSVHT2m5n/11+Y4/V/i4x0BCJkUuyye5rfzS+z
         /CWpTUrNhfhX1vv92m/WpZ6BxVMLbSVmZSZZeFF0KGY7krtJapuFfs3yW68wI0XHlM4H
         C+HIfr7hcfVS9fqN6tX/J6KBKC8KdYl21UsKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782920123; x=1783524923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndR8vhWFt9KSYRpwVTspSwgHXJD0hfWVRuMdjE0PPzc=;
        b=p198+az05E1DQqOiz8AEikPx8fgM+lv5XvioKNuTcPDeLPmP34kngwLvBtimYZWbXK
         PD7chiG7o4qRLfkNQTfQDaI4bEkNKlxduTKcL4AUQ7Uk+iKGbVUu52tF/xoAYRsTGvx/
         RFelphIaOELb/g3ql6l6uxzu24WYX3c9KXztyRURdo8l+I53MPb4R+O3SJt00atc1LrU
         R/BibauvZCV8+JvvmcP1mUBKOMisNLj7re9uR7qZju5mn2G581cs8QRWXP2YTzDGuqvJ
         uUOMLs9CIAZpBJyZ3qSqrYOVV1tBNPJlPVD1RKgdcE9Gq9DV/tXQNRFfrA5WAeiBWNis
         l6Lg==
X-Forwarded-Encrypted: i=1; AHgh+RpSYK4e0FD1odS9qfGF5O+C8aa/4s2k+kH4QQFDAwoJ+JVzAUly4bRobE4vQN8941kr6/ykcnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0jwna2/KCT8CUqZO2nQrkcn6PWJGeNtH/G45my1f+M9rzddb
	1rWrp70fn8DpdVhhBNeZzM1AJKPVUlf8NFZzZXxecCBu267761YQbSLTru4m/kl4dg5a8uBOxho
	5WowV3yLBD3jyXKWEJ7E7jajFTdEx83k9aAnumQF0
X-Gm-Gg: AfdE7cmDiyryKDeO6OmNn3e0IPQ7YboRMB5zw9GhyHBGItWwbsZgW5w72hwsgPRo5b+
	oyv0gO27N0ODvcaoq6yoT2hWgoy9sYI2He0IzRS2ZLwCaoedr8K1JKYvb8T4H8dCWTgkNlo72eL
	MxRgDH10UVb+t9FZYo3+NYswkK3bx3OkZQxlD4kGbMsCDggkT0V5xP4N5xUirerH6UH9PVhQmu/
	U3ap31Egw9Um4P3rDOAXVIpz059IQbja9GT33r2anXZ+TP8EnsDlRii+RllAL4y/USA1lx20Q==
X-Received: by 2002:a05:690e:1489:b0:664:e5c5:5b2b with SMTP id
 956f58d0204a3-66520e00800mr1930879d50.4.1782920123243; Wed, 01 Jul 2026
 08:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630123331.186840-1-daniel@iogearbox.net> <20260630123331.186840-3-daniel@iogearbox.net>
 <CAM0EoMn6H6cKCweHmt=8ve2i0JuK=E8W1Q89oqDD7vra_Uuk-w@mail.gmail.com> <d9fce17f-851e-4cb0-9d78-2ac2cadfda81@iogearbox.net>
In-Reply-To: <d9fce17f-851e-4cb0-9d78-2ac2cadfda81@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 1 Jul 2026 11:35:11 -0400
X-Gm-Features: AVVi8CfqeTgnacRGIOCuhvdFtORTR-T_CEfhc-_OdUiwNBANp03Tk1iSAhcfLDM
Message-ID: <CAM0EoMnZPbKG3GCndk2Xp44KxUfPJzSMGXYPDZeoa_-6JZ+Uuw@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:victor@mojatatu.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303724-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linutronix.de,gmail.com,vger.kernel.org,mojatatu.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DAEC6EF545

On Tue, Jun 30, 2026 at 11:23=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 6/30/26 5:16 PM, Jamal Hadi Salim wrote:
> > On Tue, Jun 30, 2026 at 8:33=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> From: Jamal Hadi Salim <jhs@mojatatu.com>
> >>
> >> When a TC filter attached to a qdisc filter chain returns
> >> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
> >> act_bpf action), the redirect was silently lost i.e no qdisc classify
> >> function handled TC_ACT_REDIRECT, so the packet fell through the
> >> switch and was enqueued normally instead of being redirected.
> >>
> >> This has been broken since bpf_redirect() was introduced for TC in
> >> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
> >> for a long time because bpf_net_context was a per-CPU variable that
> >> was always available.
> >>
> >> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
> >> on PREEMPT_RT.") turned bpf_net_context into a task_struct member that
> >> is only set up by explicit callers. Without a caller setting it up,
> >> bpf_redirect() itself crashes with a NULL pointer dereference in
> >> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
> >> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
> >> adding skb_do_redirect() calls to every qdisc classify function, which
> >> would require changes across net/sched/. Isolate it to ebpf core where
> >> it belongs.
> >>
> >> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
> >> wrapper around tcf_classify() for use by qdisc classify functions and
> >> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
> >> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
> >> than letting it continue silently. Dropping is preferred over
> >> letting the packet through because the user immediately sees packet
> >> loss. Silently passing the packet through would hide the problem and
> >> leave the user wondering why their redirect is not working.
> >>
> >> The clsact fast path, tc_run() continues to call tcf_classify() direct=
ly
> >> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
> >> sch_handle_egress/ingress() calling skb_do_redirect() as before.
> >>
> >> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> >> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct=
 on PREEMPT_RT.")
> >> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> ---
> >>   include/net/pkt_cls.h    | 14 +++++++++++++-
> >>   net/sched/cls_api.c      |  4 +---
> >>   net/sched/sch_cake.c     |  2 +-
> >>   net/sched/sch_drr.c      |  2 +-
> >>   net/sched/sch_dualpi2.c  |  2 +-
> >>   net/sched/sch_ets.c      |  2 +-
> >>   net/sched/sch_fq_codel.c |  2 +-
> >>   net/sched/sch_fq_pie.c   |  2 +-
> >>   net/sched/sch_hfsc.c     |  2 +-
> >>   net/sched/sch_htb.c      |  2 +-
> >>   net/sched/sch_multiq.c   |  2 +-
> >>   net/sched/sch_prio.c     |  2 +-
> >>   net/sched/sch_qfq.c      |  2 +-
> >>   net/sched/sch_sfb.c      |  2 +-
> >>   net/sched/sch_sfq.c      |  2 +-
> >>   15 files changed, 27 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> >> index 3bd08d7f39c1..5f5cb36439fe 100644
> >> --- a/include/net/pkt_cls.h
> >> +++ b/include/net/pkt_cls.h
> >> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *sk=
b,
> >>   {
> >>          return TC_ACT_UNSPEC;
> >>   }
> >> -
> >>   #endif
> >> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> >> +                                    const struct tcf_proto *tp,
> >> +                                    struct tcf_result *res, bool comp=
at_mode)
> >> +{
> >> +       int ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> >> +
> >> +       /* TC_ACT_REDIRECT from qdisc filter chains is not supported.
> >> +        * Use BPF via tcx or mirred redirect instead.
> >> +        */
> >> +       if (unlikely(ret =3D=3D TC_ACT_REDIRECT))
> >> +               ret =3D TC_ACT_SHOT;
> >> +       return ret;
> >> +}
> >
> > Why did you remove the warning?
> > A lesser issue is that you introduced a space above #endif
>
> I don't think we need to put out an extra warn to spam the log, this
> can be easily traced either via bpftrace or qdisc stats etc; plus the
> guidance to eBPF with clsact is also obsolete. Given noone has run
> into this the last 10y, I don't think it really matters tbh.

It's a bit entitled for you to change someone else's patch to fit your
philosophy without a mention.
It's only one message per qdisc. But fine, let's keep it that way.
Sashiko is hallucinating on TC_ACT_CONSUMED for patch 1. Let's ignore it.

cheers,
jamal
> Thanks,
> Daniel

