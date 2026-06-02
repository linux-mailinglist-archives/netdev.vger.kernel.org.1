Return-Path: <netdev+bounces-294383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q/xiNqwzH2qiigAAu9opvQ
	(envelope-from <netdev+bounces-294383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:49:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D857E631867
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:48:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="a9B/HKNE";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294383-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294383-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A89743021784
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348472DF717;
	Tue,  2 Jun 2026 19:47:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B082853E0
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:47:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429635; cv=pass; b=HSCA93sI+M9MwtYTKOOT8hv754Ju//Ix0FE4++LJhjf+IVOhikFkHcF0ayuXPNQ/wXZ70C//qC1nQM6b1BFqjPkF02S8XrZdC21RvoMte3F3UGE78+VnM97Ru/5ZtP4D8cyeab9npeKsFBrIPXLOQbiDYqvlWmN/KI9CIosnWDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429635; c=relaxed/simple;
	bh=j7DrF4qiOHeAod+S+KzBrUXFeCvhIooxpI4w1I2wRf0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Eo2/CMvgN4lE7JBfoMZsaTIIWfacV+um2Td8awaNfzvyz2NowfK1MF5UL8OCCAxIvgbahyljblK8xvDFffcGa+Q82ULaummCui0dpBzTYuc2ObC/tgdbnmhauI9xtfNDec8DO3KtLVO50VYHGrewaDNFjN2ubFsPMk7DsFKV7fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9B/HKNE; arc=pass smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-135e7f4a295so8668185c88.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780429633; cv=none;
        d=google.com; s=arc-20240605;
        b=LSVEoUZ/rPpX7gPtWIJ7QFS4+3pxyh0e20BDULLN+laTA5kCO+43NgkJqeNlrKLJ9Q
         sw4jb/xUr8uQhdAyvfZ5Afcgpk57OWrbk8OjAgbFue0E5rDpbxJ29vEZtEWfZoSM1vRD
         gekF2zBYlrvp0l8CX8uKTbG+dsT1MwJI6RbFLx0wwwfyrb3U3co9LI5bOkuyMIipEGKA
         25VFQZeIHyt0w0VroJYUU+l7eUWddiPd0jLA/Tb3y6WXNPuC7w8HFypw3KYUMNMVuGYX
         nPQuR2wALK57js0pmDhWZ2ntoMDQtFjgH8GuFaZdpiAOQv7nxYb1ScHCAJdDPyglDAko
         hOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nOtbyhi1gm0X5En8tTNeYwwzjOWqTgf9sx8XfgKEwkQ=;
        fh=2trUhOZ26mFpt1aGBlDzeCkxKgymhcaUbk0r+2y+7EM=;
        b=LlJyWpTpNY/mjHQZAJPT1loeeoKJzxsDU2PbgV3UynwbC65v9oqF7+UntfF8YSd7HW
         Jq1tDyunha81L9GJ9J6W4ijlW+vNzkw1UKlvMWfIgMxV5kE3ghmrHP/z6hFWtjFHa8KD
         3x0YpxlyCG9YErAz5ecY3OEWgbDTH/SPmvVX+C0FIKK08DxGrrwI4O4ViqLMLSKeZbeY
         DtI7QiDxzxZiiXc5Sjdj+AQOjalYP3VIyY+L2yo2a3cMQt7ptDc/0JCQrbYrA/Xy4C4T
         p85k6Fvyy6uKe8jf5O8fkdaFbUckbwvYn9ilf6LEQJkzIVK9qbW1BmorFvyGRAP7HjbV
         sJcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429633; x=1781034433; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nOtbyhi1gm0X5En8tTNeYwwzjOWqTgf9sx8XfgKEwkQ=;
        b=a9B/HKNExnUP4tHHkOu183m57BJShqrKWeIBUeHV7+OoXAhRU7QTUKFD8wYIAYpM7Z
         Czu5jgbEKlTd4pqb7dL6sFRZopBHRuyudz9gLK4W9R61Xu2a+ET8+Vin+1EQNnUMo3ht
         mKmDkeR1ewsqnDYWRGEP/YE8m4PmftqPpan+tjdl9dIOYw0yCWHJqYY3xgvXKqjoRRsk
         yLEj2hW5JkCqQJhCfL6UzbEe1iy8R7+eCv/97MDUMDwLEzEGa7pU4ZFBq0Rjo8HqL00K
         y4VhV9FqdNSE0fgC5/xbdyGd22eK24FbcfE1ccWEosAWmeBDiN1IVnF+jyDTPzzbIX3J
         DHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429633; x=1781034433;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOtbyhi1gm0X5En8tTNeYwwzjOWqTgf9sx8XfgKEwkQ=;
        b=E92/9AKDh1725W50rdaAtyNQUuhlyr/3olX8RHl8KFs7uO1JwTFM61t0sNlzM8T3Ep
         1aN1/oWqrmHv+GWQ6pNbqpIIb7VDusxckCRUbJF2O0pqamu+52030nf9iicQZ/Nd1/6p
         aZ+DUtTrHTw6b4odEzZW3/XyFRzcLAaqOwci4uSRLfntDsRdeZFBdIxDzzKLVSizbUyc
         QIyUpivMpJMKv7lcKQN6QvEYfteTD9iZ1xCjjSdOApi1/7GlkjjlmuDaGnMq18CbKG8f
         VQTcwHSHsG5ynu2xFjvB7iiZIaX48v4xFyAMziWqz8pXLblGQKxR/BXjo0Q31vJuOwHH
         cgdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2O1EfxqGL1mspwxyt3bwuWMnShv6pdB9zPq4+SB/Cy7xNw3TuwqjrZu51gy+AVt2xMarX7z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTAnI4LayB0Yf/p0ZKEewoN+6IUUfaM32hAY71rysoWIe4hE8
	n1W14TD7ZABQHBGwYe4yQDfRH+yII08bdXj1vnFGd8I2ZKuMOqNIZQMy3x1S2NM/hpi8/pn5vUP
	p8Smwrjiswawe8X19THEJBAReEyAo11Y=
X-Gm-Gg: Acq92OEU5uIVB2aUSaekNG3mevzkjLBB+9njcwOcWw0pmj4niZQHPw+w6ZAeuE3t1hK
	qpgNS4jvfWwQoNSy7apgO9s7chf4heJ9MOrDzv9ZY0b9l2nKQnFmChci0G18bAYvA1mARLjVM2L
	wG5Hj//eEc1Lnji++l8lGoFztOmeKvVLVJzpuUhO1yenRtmPD81VjZ2NgCAnnmqR9EMJbkVMgqW
	YitUHIFMuiFeqnSb0X2HDrpxYLQT+rXFBY8VaSA85nHyq6bYqhQgdDHpi7U3GPuEW5iGyZyJcE3
	UdXWbcw3+oJCZla64/Q108GcyrCN
X-Received: by 2002:a05:7022:419a:b0:12c:aae:7b43 with SMTP id
 a92af1059eb24-137f6bddfbbmr36650c88.24.1780429632609; Tue, 02 Jun 2026
 12:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: boz baba <bababoz943@gmail.com>
Date: Tue, 2 Jun 2026 22:47:01 +0300
X-Gm-Features: AVHnY4JLjHdL0UUWDVvSWKH7NjcfD0XPOprLQlsNrWjJgCv8yA7tMM7kTFKAab4
Message-ID: <CAAB7JC+WKtCUkTeJFhAR-d3A=DFa_31tK78-QoSu5-dXXypmnQ@mail.gmail.com>
Subject: KASAN: slab-out-of-bounds Write in mini_qdisc_pair_swap
 (net/sched/sch_generic.c) -- lifetime analysis and proposed fix
To: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294383-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bababoz943@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bababoz943@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D857E631867

Hello netdev maintainers,

I would like to report a slab-out-of-bounds write reachable through
mini_qdisc_pair_swap() during clsact/ingress qdisc teardown, and to
propose a fix grounded in an analysis of the actual object lifetimes
involved. A first cut at this report suggested a check of the form
"miniq_old == &miniqp->miniq1 || miniq_old == &miniqp->miniq2" inside
mini_qdisc_pair_swap(); on closer reading of the code that check is
incorrect, and the fix belongs in the teardown path instead. Details
below.

Bug
---
KASAN: slab-out-of-bounds Write in mini_qdisc_pair_swap

File:     net/sched/sch_generic.c
Function: mini_qdisc_pair_swap()

Affected versions
-----------------
- linux-6.1.133
- linux-6.12.91
- mainline (as of this report)

Faulting write
--------------
Inside mini_qdisc_pair_swap(), at the tail:

    if (miniq_old)
            miniq_old->rcu_state = start_poll_synchronize_rcu();

miniq_old is taken from rcu_dereference_protected(*miniqp->p_miniq, 1)
and, in a correct sequence, points at &miniqp->miniq1 or &miniqp->miniq2.

Object lifetimes (as the code stands today)
-------------------------------------------
- struct mini_Qdisc_pair is embedded by value inside the qdisc's
  private area. For clsact, clsact_sched_data carries miniqp_ingress
  and miniqp_egress; for ingress, ingress_sched_data carries miniqp.
  See net/sched/sch_ingress.c (clsact_sched_data, ingress_sched_data).
- &miniqp->miniq1 and &miniqp->miniq2 are therefore interior pointers
  into qdisc_priv(sch). They share fate with the Qdisc allocation.
- miniqp->p_miniq does NOT point into clsact_sched_data. It points
  into the device's per-direction tcx_entry->miniq slot, set up in
  *_init via mini_qdisc_pair_init(&q->miniqp_*, sch,
  &tcx_entry(entry)->miniq). That slot is what publishes the active
  miniq to the fast path.
- The only caller of mini_qdisc_pair_swap() is the chain_head_change
  callback (clsact_chain_head_change), wired into the tcf_block at
  init time with priv = &q->miniqp_*.
- Teardown calls tcf_block_put_ext() in clsact_destroy()/
  ingress_destroy(), which is intended to detach the callback under
  RTNL before the qdisc private area is released.

Why the naive fix is wrong
--------------------------
An earlier draft of this report proposed:

    if (miniq_old &&
        (miniq_old == &miniqp->miniq1 || miniq_old == &miniqp->miniq2))
            miniq_old->rcu_state = start_poll_synchronize_rcu();

This is not a real safety check:

1. miniq_old is always assigned from &this_miniqp->miniqN upstream in
   the same function (the "miniq = miniq_old != &miniqp->miniq1 ?
   &miniqp->miniq1 : &miniqp->miniq2" line), so the equality is true
   by construction on the non-buggy path. The check does nothing in
   the common case.

2. If clsact_sched_data has been freed, miniqp and miniq_old were
   freed together -- they live in the same allocation. The address
   comparison can still spuriously hold in stale memory, and the
   subsequent write to miniq_old->rcu_state is exactly the UAF /
   OOB write the check claims to prevent.

3. Even taking the equality at face value, the write still lands in
   miniqp's storage. Guarding the write with an equality test on
   miniqp itself proves nothing about miniqp's liveness; the two
   pointers share fate.

In short, the proposed check validates miniq_old against an oracle
(miniqp) that has the same lifetime as miniq_old, so it cannot
distinguish a live target from a dead one.

Where the fix belongs
---------------------
The invariant that needs to hold is:

  No chain_head_change callback may run after the owning qdisc's
  private area has been released.

That is a caller-side / teardown-ordering invariant. The right place
to enforce it is in ingress_destroy() / clsact_destroy(), not inside
mini_qdisc_pair_swap().

Proposed fix
------------
(a) Drain in-flight callbacks before releasing qdisc_priv() storage.
    After tcf_block_put_ext() returns, a chain_head_change dispatch
    that was already in flight on another CPU may still be executing
    against &q->miniqp_*. Add a synchronize_rcu() between
    tcf_block_put_ext() and the rest of destroy:

    --- a/net/sched/sch_ingress.c
    +++ b/net/sched/sch_ingress.c
    @@ ingress_destroy(struct Qdisc *sch)
            tcf_block_put_ext(q->block, sch, &q->block_info);
    +
    +       /* Ensure any chain_head_change callback already dispatched
    +        * before tcf_block_put_ext() returned has finished writing
    +        * into q->miniqp before qdisc_priv() storage is released.
    +        */
    +       synchronize_rcu();

            if (mini_qdisc_pair_inited(&q->miniqp)) {

    Apply the same drain in clsact_destroy() after both
    tcf_block_put_ext() calls.

(b) Skip the trailing rcu_state hand-off on the teardown path.
    On the tp_head == NULL branch the function already publishes
    NULL into *miniqp->p_miniq, so no future reader can observe
    miniq_old via that slot. The trailing
    "miniq_old->rcu_state = start_poll_synchronize_rcu()" exists to
    gate a *future* reuse of the same miniq slot; once the slot is
    NULLed and no further swaps will occur, the hand-off has no
    consumer. Skipping it removes the only write that can race
    teardown:

    --- a/net/sched/sch_generic.c
    +++ b/net/sched/sch_generic.c
    @@ mini_qdisc_pair_swap()
            if (!tp_head) {
                    RCU_INIT_POINTER(*miniqp->p_miniq, NULL);
    +               /* Teardown: *p_miniq is now NULL, no future swap
    +                * will read miniq_old->rcu_state, so the hand-off
    +                * write is unnecessary and would only widen the
    +                * window for a use-after-free against miniq_old.
    +                */
    +               return;
            } else {
                    miniq = miniq_old != &miniqp->miniq1 ?
                            &miniqp->miniq1 : &miniqp->miniq2;
                    ...
                    rcu_assign_pointer(*miniqp->p_miniq, miniq);
            }

            if (miniq_old)
                    miniq_old->rcu_state = start_poll_synchronize_rcu();

(a) is the structural fix; (b) is a narrower belt-and-suspenders
that also stands on its own and is, I believe, semantically a no-op
on the non-buggy path.

Alternative structural fix
--------------------------
If for some reason chain_head_change callbacks need to be allowed
to outlive tcf_block_put_ext(), the cleaner long-term fix is to
decouple mini_Qdisc_pair lifetime from qdisc_priv: allocate it with
kzalloc() in *_init, store a pointer in sched_data, and release it
via kfree_rcu() in destroy. The existing
start_poll_synchronize_rcu() hand-off then becomes safe because the
miniqp storage outlives one grace period by construction.

I'm happy to test patches or provide more information.

Thanks,
boz

