Return-Path: <netdev+bounces-294379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yLa9Cw0wH2oCigAAu9opvQ
	(envelope-from <netdev+bounces-294379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:33:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC86316E8
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:33:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZIPNy3qm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294379-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294379-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8198D3045B26
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4D2FFF89;
	Tue,  2 Jun 2026 19:33:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB32F0C74
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:33:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428809; cv=pass; b=MQ1JlJCcQa79MlWoldq9R2wpm+2HLMfB+Rht2yn9wznOP3tkJNVuT/XmZQp+zsh58JzhlM0cBnp+Iwlg2ObgNGInCRcL8mgEAnw+G05NPmRGHhxwa0o31LJmv/RzzBsGx9EECbzel/egjWFghw9sb3kFSjcddKVEoynwsJIo0Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428809; c=relaxed/simple;
	bh=j7DrF4qiOHeAod+S+KzBrUXFeCvhIooxpI4w1I2wRf0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=H6jUCRUayXRIYMsJLqcqjDk0h9q/Uo5fC6NNP4VQSEicYXB4Tgs6UPqdy2MgOH+48mtozEiIWfnSadFlvBBG95go57KzhpGZq8iw8xLI5oQhzthbHQy3IbTplTzy4znW+0p0BFUmeEuL+J+SA/4ru157jQQOw/CyNRhNHuEN6Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIPNy3qm; arc=pass smtp.client-ip=74.125.82.67
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-137ed2e66faso1469783c88.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780428807; cv=none;
        d=google.com; s=arc-20240605;
        b=iirwASTblFl2jEs6AGrOeYYonTHKkcUzTZM7wVs9+OHSzBzleEYpNi7zTEqMlV5+Z/
         bHukprNqqQzd9pyk36eI913dPYfFsUYdqpR/EEaVhd9mI0lOAc/yAWK+4HswIwf0i/VA
         6Uo2YCecwiGCrFgP4kRMnyz+rO4yFjaxWQtQMVnw8wF/aZohhPesGML2/bTkmHFO95Y/
         XVcSxc73S6XabT5NWz+0Bo9oh0PimVpAdFrCyCUQu+5rvvn6+VadqoZyScSqxT7s5Nqf
         psc7VoReGUoKQDNGYQdX89ssjqpXAwWzWYsoFgE2N3sc1avLYDOq700v4/zM2mJyDXQ9
         A1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nOtbyhi1gm0X5En8tTNeYwwzjOWqTgf9sx8XfgKEwkQ=;
        fh=0q9HmpF1XwROxMIUFB7y3rMKL4FdlkT5Q3/xBmVDctY=;
        b=O/dE7w5bY7LIyH623KsJs2f1qutBtFOE+qdwfr/7TKfs2mQ/DMLg2FmEQLv9UJ5sSK
         JBf2e4ptRWtKxn+d6zmhKUCp6Tyely6opNpmopid6UeQZNSYv4+liEfxd7T1vOltyml8
         TH3WBFaRJg4cdkf66BspX1r/Go95PVjYbg24YCbuPiLHyXmIJ5klg+NdVqPmyq5qltwc
         WFOks0zRSB+3zOlXQrG+I25bLz336zQoPPW2vVUcTq2QvKp+tV5KBuAO1abbI84ETkCl
         25BUN2UHv/vhlPHehSmzJ+MPU1leoB8VfhFd+oD7GBhSJs6H7jPXowK/InwD7D4XUOYb
         L8HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780428807; x=1781033607; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nOtbyhi1gm0X5En8tTNeYwwzjOWqTgf9sx8XfgKEwkQ=;
        b=ZIPNy3qmOEE85IlDzh38fc2hwPMR/AmslyOnshoiZ375gFJLPWn89LLJWPQJMXMYaJ
         KVGa/O20MwnKmmTVIovGTqcUmGkT5o6UD6B15TP+YGwBTQN6OMLWeyTGQxKxb0zQ0mQz
         8J6JHB8snZIGl7cBBEbaJbyoOEP/ofGRYUDK5D+yxo9Czik/UFD4z9+2T/fnYbh55gfu
         fYm2MdNyhOWZhJUuhGY4gYCdNlHoqEZ0wfvDUlIzyWuN8q9vLrTxQncJ+TcUwuxrxql8
         yZPNhlEnQAZn8TX2wqsMWUX2bbHOH4+KRr/4IDmQH8RGpVagWpopNr7U01HlIP5GvUBM
         G6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780428807; x=1781033607;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOtbyhi1gm0X5En8tTNeYwwzjOWqTgf9sx8XfgKEwkQ=;
        b=WRNuZxo4aZvyCzKpRWRdYK+05x5KxlqkyFv5Sr1fZBqRbd89ERgTMLyqECm+6dFA/s
         UnIEe3b8N+YVSax8rwvbSMoAs3JzY/x0hXyyqtN8E9KvRBpVfF1gYKMiw9lqr8jx0L90
         MUfkSKPdRfkQymXpD3pjezhcj6kdmn6BX6bNLaVdf49xoLAvMyZVgbiCh2u3z2Mc+Tcn
         kr/8ynVsD2vv4Airg7ya/JjgJV8StPU+YXpXeTzG7CZTRfSW5tNdnY3bYjp0x8/yCZQ0
         nmVhff978S1Vet6pL3f3u+3NOLlAQbuOuMNnSG10fyKIWrvfJNPTldAKO5FB40XuMqKt
         LeNg==
X-Gm-Message-State: AOJu0YzNwRwDuqaHPFIWQtwzQp2rJLkpVzkyG3MmfvXpr7IKHe0tHldN
	86829Q4HbwcPAeRCQjFTnWS9m6ClEbHex8bFVWML5HPupdGBDE4v88hAEPJvuarkiLIpzuoQAx9
	FsQrkG8T5DBS0K56MGLChuLZDUSQ6WX6b7LFDgjRCqf9/fBM=
X-Gm-Gg: Acq92OHSi5+7N3vo/XwEAKx/L1NNd5JJzcI1xeCJp2l6Xna8pL8L6D03BRTovMfFQTR
	ztq7eS5ctk65R9IFPnlnKYjNBnYxYjH9BPv1jkREBvUeD/p/onCD4sQt2T3OCXtP3TScC5qoLxM
	HTGtokBgITMzc738NHFKyYM/zSQa9X1yezr/B/Byvn13p+GBZVqoWTJaVmywpIZyqHtkuxvcjzs
	tGu8XlxjTS5kOyw88GCt2Iclw/UjsODCNpVc4+KR7f4Az1bUnNK03FzZXBM2AdbCjqMNoFayMDW
	Nkf8rlnMeBBmrcp8IZttj2S9I8MZ
X-Received: by 2002:a05:7022:6707:b0:136:d237:b426 with SMTP id
 a92af1059eb24-137f6939eb0mr31444c88.4.1780428806972; Tue, 02 Jun 2026
 12:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: boz baba <bababoz943@gmail.com>
Date: Tue, 2 Jun 2026 22:33:14 +0300
X-Gm-Features: AVHnY4LbLFrbzquSWhbA3jjeO0yq-Bwn6Emo2nEYxLZVd3rvW42xA7etTfbyFFQ
Message-ID: <CAAB7JC+Oc7b1nO=hBNCorU_HTkad6K7cUy32R8bHjkZqt43vkQ@mail.gmail.com>
Subject: Hello netdev maintainers, I would like to report a slab-out-of-bounds
 write reachable through mini_qdisc_pair_swap() during clsact/ingress qdisc
 teardown, and to propose a fix grounded in an analysis of the actual object
 lifetimes involved. A first cut at this report suggested a check of the form
 "miniq_old == &miniqp->miniq1 || miniq_old == &miniqp->miniq2" inside
 mini_qdisc_pair_swap(); on closer reading of the code that check is
 incorrect, and the fix belongs in the teardown path instead. Details below.
 Bug --- KASAN: slab-out-of-bounds Write in mini_qdisc_pair_swap File:
 net/sched/sch_generic.c Function: mini_qdisc_pair_swap() Affected versions
 ----------------- - linux-6.1.133 - linux-6.12.91 - mainline (as of this
 report) Faulting write -------------- Inside mini_qdisc_pair_swap(), at the
 tail: if (miniq_old) miniq_old->rcu_state = start_poll_synchronize_rcu();
 miniq_old is taken from rcu_dereference_protected(*miniqp->p_miniq, 1) and,
 in a correct...
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	LONG_SUBJ(3.00)[971];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294379-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bababoz943@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bababoz943@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83FC86316E8

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

