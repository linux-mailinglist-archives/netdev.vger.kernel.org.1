Return-Path: <netdev+bounces-302391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IOJYEZsTQWoskwkAu9opvQ
	(envelope-from <netdev+bounces-302391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 14:29:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 894426D3CB3
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 14:29:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=YSO11PSM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302391-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302391-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 235DE300ECB4
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191643290DE;
	Sun, 28 Jun 2026 12:29:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443138E8A9
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 12:28:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649741; cv=pass; b=cMszEF7Ujt+RB7LkJQxLxvVgHGms9LW6hg+tT7NjZPiuMO6smi1ljo3YyjoCjjIJZeCWdGpZiA+T2uCG0S2aM5Xv+nyNIlw+wH1jjUzFDRf+vijCyIiwDMhR+dd5dznIXg7Q2L6gSCMVMeYFDuss3SmRQa8QX00QVIu0eYMtocU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649741; c=relaxed/simple;
	bh=5ApnCwq5Hsy6OnK5R9dFY0h0QMvGDBvhMeGj0FhJ0Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+P1CDenCWN4Y34UrlgiAjcEMB7+WrUtrFPvzrG9JtUhcmcP25USsO21j48ZBYIPkqWbW6VAAjTUJF/FHFV1aVB7S4wNl1rs48P+pSOMdT386zFe5401b0wZhyDirwMpYc2sPnBL3DTsdf0R4EmzhodPiLcRABrlFROrAcdo2VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YSO11PSM; arc=pass smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-846970f0acaso371050b3a.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 05:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782649738; cv=none;
        d=google.com; s=arc-20260327;
        b=ao66JU0TWllKSDr2kepKM5wleXucse4GqxuFH7jRlfCQuZtJ2TTt7zw+gA5OTlkdaC
         vl6qRTXkCJN0fmD5nbQ3eFaacp6f7qxHx9pjk55L0Kc/mWvx17VAdAoeCZCHdZ3uFtWl
         BHcGjpkU8HQbB/Tnmlv5kEvvln8Llvr8awDY0IsHoCJG0+9Z/oJ16JMpxyNbVbA1q4A0
         rSXttLw3fAyui0nHQH+Tm8hDg5WDaMM7WeGi6Wi1NxnGsWlgawa3Jzste6Dz8Z5v8raY
         MaU5WscJtPLxhGDcUzidOsVvkSZ2+JWOGiBjm8fXlTkGkI2Q06NKI/e96m+cTkW13zFJ
         lNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sEdjbIGDqsoiW4GawsVBo2JW1gWoEIpSwHHzh69Rb4A=;
        fh=CoLOV4zoFQxbWl0hPNIEnzKHMeuw0o8X4jXizY1aT7s=;
        b=MZF5DTFatLwrE/rJ1nNDt2FRmzyGCHJdBc8+CvkhvE15BK9fNvrt51eADriJkQrGNM
         PM5rNJK7gdSwSs6I//JKEd0bYTBcSxMslwZarhhZ+o6NbYMFoaQKmln93r5bGXd+CGH1
         cZEJKrcBkev+FoRyNcDAAFLgZND69uaB5wEOXBATYiGW+gYc2QIU7PcsyKDZmeTz9BXK
         463CMrKT14zxpjuzY8Sc9u87hF8HdFd6N2vtqU6mkQSQvwolNTmHTNZLfreC4i2VvH7S
         OCGINGU6fkMiqAb2Q2v0LLJW6ltB9jT9oy4P+GDliZr42yFgiiq6CGPsS8/NN7Dtlb8e
         ASqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782649738; x=1783254538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEdjbIGDqsoiW4GawsVBo2JW1gWoEIpSwHHzh69Rb4A=;
        b=YSO11PSMSJL8ahHFpAaBEQseDtKAyGwXZIMJ2uymz5G8I2rwq1An9gnidiEaJ2EScj
         Dw8nAwQixfotAeu7MSOYe7iMpCqRiugzE5BSWTdc1EmHINI+/VrJSTNNUwC5ov+nnplA
         Q8wFaCUbhhGyRdbPgyQpfxcLXrPK+wlJyl1sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649738; x=1783254538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEdjbIGDqsoiW4GawsVBo2JW1gWoEIpSwHHzh69Rb4A=;
        b=MHGeEQl4E2yhlf0KRbSvoGDiRL8KYgHn1tOt73xY9HEHnI5l4tTDRlR5GV5f6I9qWD
         ch/BPAN75Nw7eXmbB6QW5C0kc9k2kiuNJGBo60LLUjcvT2oY6AKvuBzPV7pOWM8pG6E9
         rGvq6dxMwFkG+NQ2DeBgDuUprXBrQVdsYmZXWry/zFJLdsU8MaDWqCE/I/mVHEMxtnBP
         MCqX+B3I4krUO7fi5GiI2taTsTauLdenKAMxt6dzNCgqUq4AWrDNdmFW1aBBWjohaxpX
         mTCH1in36+oxVaHCFcHuzi5kS/ZnPAqIkfpW1OX5I2LmsprLMHeVFRpwQBnbFox+Zjd4
         390Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrwtc5qFDw031xiQgbvIrsNhzCk5WB79jFmKnYPmIRIzlqSJmV1Cc0vI8MnmTBbRuYXTTFuyLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9v+yHMxmj53Y2T2JVQBcJWFqJS7UvH51SV9VPc0C9QSSzzYo
	XofRKZUyjzCF7dhWcP2pKX7flhempr2HqFTNycEj/6cHlYfkO8cUHSIF1x+0Vb4IC5u5phcajlW
	OVg6zse9BCoMq6sjC9juYVAJHaIzHgLrKYM5Ao+TqsblXkPM8PYeEsQ==
X-Gm-Gg: AfdE7clOeOwukY+u3G8P3rHvu4in4PgZrhWaieLgkS5f+OzRsfuXeNV86dcRi55csYy
	ttqqqSuU0sIBvx18Ue6OJ7+06uDX0za+syeUf9KPGCL3rVxMTpVpmHwlOHVOueesCsTIPARTzNt
	xijG37X3L2A/6D/a1Mxe0m5aKF5mSMHoz253tQC3POl+di5I4PO1uNq/PlOvjOnqJDZRJyee40v
	Nd1VzD6UMMAnCQQ4Op/l5iU78i2M1QyT2PDJ7XYKOeYipISqskSQWygxAeMXCr4YJnCjLHvciXQ
	hQJ8hXup
X-Received: by 2002:a05:6a00:32ce:b0:845:4888:74c5 with SMTP id
 d2e1a72fcca58-845b3ab50a8mr14060519b3a.23.1782649738333; Sun, 28 Jun 2026
 05:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626165156.169012-1-jhs@mojatatu.com> <20260626165156.169012-3-jhs@mojatatu.com>
 <20260627165220.096B61F00A3A@smtp.kernel.org>
In-Reply-To: <20260627165220.096B61F00A3A@smtp.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 28 Jun 2026 08:28:46 -0400
X-Gm-Features: AVVi8CeUfCgYCrMiVLpafN92ArCYDophcwyfKGs-OnnxoG-o95tadQncfOA3DcM
Message-ID: <CAM0EoMkUeJYuPbg-qXxFLEtiLuntT+g4MeY-sHy5yBSVd7+j2Q@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:petrm@nvidia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302391-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 894426D3CB3

On Sat, Jun 27, 2026 at 12:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Removal of TC_ACT_REDIRECT support from qevents (tcf_qevent_hand=
le) breaks existing eBPF redirect functionality.
> - [Low] pr_warn_once() used inside a static inline function in a header f=
ile will print multiple times.
> --
>
> commit d96e142c03f9c1a1e9ac2e1d8c8fe26605053b10
> Author: Jamal Hadi Salim <jhs@mojatatu.com>
>
> net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains
>
> When a TC filter attached to a qdisc filter chain returns TC_ACT_REDIRECT=
,
> the redirect is silently lost. This patch adds a tcf_classify_qdisc()
> wrapper to convert TC_ACT_REDIRECT to TC_ACT_SHOT and drops the packet.
> It also removes the TC_ACT_REDIRECT case from tcf_qevent_handle() since
> it is handled by the wrapper.
>
> > diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> > index 3bd08d7f39c18..3a542a72e9a55 100644
> > --- a/include/net/pkt_cls.h
> > +++ b/include/net/pkt_cls.h
> [ ... ]
> > @@ -159,6 +159,19 @@ static inline int tcf_classify(struct sk_buff *skb=
,
> >
> >  #endif
> >
> > +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> > +                                  const struct tcf_proto *tp,
> > +                                  struct tcf_result *res, bool compat_=
mode)
> > +{
> > +     int ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> > +
> > +     if (unlikely(ret =3D=3D TC_ACT_REDIRECT)) {
> > +             pr_warn_once("TC_ACT_REDIRECT from qdisc filter chains is=
 not supported; use eBPF with clsact or mirred redirect instead\n");
>
> [Severity: Low]
> Is this going to print multiple times instead of strictly once globally?
>
> Because tcf_classify_qdisc() is a static inline function in a header file=
,
> each C file including it (like the various qdisc modules) will create its=
 own
> local instance of the static __already_done variable used by pr_warn_once=
().

This was intentional. I used WARN_ONCE() initially, but NIPA testing
may consider that as something "bad". In any case, this usage is
common, just ignore it.

> > +             ret =3D TC_ACT_SHOT;
> > +     }
> > +     return ret;
> > +}
> > +
> >  static inline unsigned long
> >  __cls_set_class(unsigned long *clp, unsigned long cl)
> >  {
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index 3e67600a4a1a1..3ca56d060e28f 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -4033,7 +4033,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qeve=
nt *qe, struct Qdisc *sch, stru
> >
> >       fl =3D rcu_dereference_bh(qe->filter_chain);
> >
> > -     switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
> > +     switch (tcf_classify_qdisc(skb, fl, &cl_res, false)) {
>
> [Severity: High]
> Does this break existing eBPF redirect functionality for qevents?
>

Again, design intent. I will update the commit message to state this
clearly with the following text:
---
Remove the TC_ACT_REDIRECT case from tcf_qevent_handle().
skb_do_redirect() belongs in the BPF plumbing layer (net/core/), not
in net/sched/. The case was never consistent with the rest of the
qdisc classification infrastructure, where no classify function
handles
TC_ACT_REDIRECT.
---

IMO, it appears to have been TheLinuxWay(tm) i.e a cut-and-paste from
existing code on day 1 of  the qevent introduction rather than a
deliberate design decision.
Ccing Petr to see if he thinks differently.

cheers,
jamal

> Prior to this patch, tcf_qevent_handle() correctly handled TC_ACT_REDIREC=
T
> by calling skb_do_redirect(skb). By using the tcf_classify_qdisc() wrappe=
r
> here, TC_ACT_REDIRECT is unconditionally converted to TC_ACT_SHOT. This
> inadvertently drops packets that were legitimately redirecting from qeven=
ts.
>
> >       case TC_ACT_SHOT:
> >               qdisc_qstats_drop(sch);
> >               __qdisc_drop(skb, to_free);
> > @@ -4045,10 +4045,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qev=
ent *qe, struct Qdisc *sch, stru
> >               __qdisc_drop(skb, to_free);
> >               *ret =3D __NET_XMIT_STOLEN;
> >               return NULL;
> > -     case TC_ACT_REDIRECT:
> > -             skb_do_redirect(skb);
> > -             *ret =3D __NET_XMIT_STOLEN;
> > -             return NULL;
> >       case TC_ACT_CONSUMED:
> >               *ret =3D __NET_XMIT_STOLEN;
> >               return NULL;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626165156.16=
9012-1-jhs@mojatatu.com?part=3D2

