Return-Path: <netdev+bounces-271497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHu5JgfEw2kVuAQAu9opvQ
	(envelope-from <netdev+bounces-271497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:16:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E93323BF6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7369730E0EB8
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AF33CA483;
	Wed, 25 Mar 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WV9V5H7u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4bhP4dR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82783C873B
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436858; cv=none; b=UMKY1CP3nOdsyHzHbgsrxlqTwgYIG+gdtppDu53fvO9VEAfb/rnHaMGyk63l4bwthriIwer3GQA4U2otjU0txEA+GqBbIh46Y5iev7rcOK38AEkYjWz8OT71sfVZFUNRNAKABMwHP0YcDs7rSdtdJ0QjfW5Ny8S0KDW5y92+jGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436858; c=relaxed/simple;
	bh=wdjOyegWGwbGEnR5Sj1riJ99f84aSZ/D6IWzRhYLFug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyViPIhno/5ZpUWxcXrslqWltv/Og6pjI0rsGgceQNPFbg/rMh7iidumFPeMnQQp7yYWyvHjSpt4+JtplkHGES1SpWJxSK6TUHExgzwwxW0d1l4aZL2hwN96u5QZY5oGp+HoxQhvCEUqRiWR2mck1aHy413x5yv9ZHKD7JKYThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WV9V5H7u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4bhP4dR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774436855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN/ADuhxnh28suR2DDM7wX4SwbXqk6YE4yAWFV8iKMo=;
	b=WV9V5H7urcg33wRq3dyU2UwHSz5cMFpaHjLdccfWUcFE998npy/AbNrJcwVNaNUAsKDjHC
	W18UGmwTyKvNNEz1ipVf4UuzpoFGcOXAXhg9Z8kdWqSMquKeHhXyPjyQmyjD2zgIoGnGkM
	/pRpDDLacyh9QwTan2FtC0XTU5KMirs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-QPTUw1s-ONKnrQsFDUM-uA-1; Wed, 25 Mar 2026 07:07:34 -0400
X-MC-Unique: QPTUw1s-ONKnrQsFDUM-uA-1
X-Mimecast-MFC-AGG-ID: QPTUw1s-ONKnrQsFDUM-uA_1774436853
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486f830f4e4so24944885e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 04:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774436853; x=1775041653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MN/ADuhxnh28suR2DDM7wX4SwbXqk6YE4yAWFV8iKMo=;
        b=S4bhP4dRJS79h+nL2IGG4O7pjLB77FJyDGbCQaMfaWx0MdmyS2VhNmuvBHjN4vg3Xj
         vg94jDXfrll2fVtKm8zNz+CA6rMgvda+34Mj0D8z4Q/XMEAAdD9kPdkapZ2a94Tp02Av
         e43jXNqJY8BgNimFeJ/qvFVpl4pnutHUPYBNpgcoAIq58+rZeulWaByz9CKbBL4Z00GN
         hKGbQR65q4rZxMww6yHYmjC1djYMcq2l0Xbzv2fPaNvHxroUxqlskLO2MQdQ21Ks8hg3
         npjd2SKe/m2nmu7EgVJoGhRQEDRJdGDYRdAiw3hhDR3nkL9UPcmCpDl4GIM0PANBpJO1
         blmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774436853; x=1775041653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MN/ADuhxnh28suR2DDM7wX4SwbXqk6YE4yAWFV8iKMo=;
        b=Lhnxx9PdwLNkvutkSOxy4bdKK7hkwofR//e7QADQUIEpkQvTvPQ84KHYGAY71WEz+9
         rLBZ25L05scFkIHcpOn6uvRpmr5Tn8reiONRo4u0v2Izkqpz/SISmcs0tdbXmyxZsbM6
         Rzg3Ybi4pwzK8pVyMDSzLmi+5+o+tGeUtA48fZr5qaHRId0KOlFM0r9p3P+6XNHDEz8Z
         SBzQq3lFOJTqgS5bG5J16pBgQcPQD4DBL134dw2BkGLWPMWFyoMt7HqfQV+bvZ+tu1jq
         fyYYQhUozTH7fzIBudX1XvlWcp3/s8lhSTEzMVwts1B6cytRPzUvA8mMRrFeJXosEb1w
         D4wA==
X-Forwarded-Encrypted: i=1; AJvYcCURZdSYJRQ+5mgZrWw5is353xs8IcpnXnpianz6k7swTndSAXh7aGy2AkvZP3voqzCLVbwQk3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJxXYvUJVkCUpJfGHJfvoeRquh36xBhbaiU+81SewamnUQrIs
	sbNKSBUwbkSYp9BHQBd6kgi6/AogA79EFhztfDL/3no6WaJGWmI2UM7g2evC3GdmotJEcWo088J
	Y5Li2Ag/rmNJcUannenVNADpW91+r1jHu2iD+dB6hcxeZpH6LJlya4C42ww==
X-Gm-Gg: ATEYQzyhowcp1HzXJCgu9ODu0shHUxVd+bbrOtyQPKzA0foSl4nYXSrScKDvFqJuFZ4
	spYmO4W+YZVBJbpBrsVcN71dhiv/Cda8ZvA2MA9r4VBN7HpSkaMjqtXhjr8AB8RmdL3InrS6HWp
	I6xvsFD9auuBpG2F3AskADnSyjP+Zq6kXc+IF7RCow0UsqBbI3vLYDRoKK6E5raUi0V3CF7Euas
	RmpVv+gACZsz2rVnrJP4IUqlUt7dNds7OGAI8kEjavjs05vaPPDKsmmmWatPKGF3ja1sBEiWpiZ
	AItAlCLhm86Mran+u9JGN9omcrbyXZSOZoQVTt1g/fvftfkSHBePKkUUCReZCwGWQnHeJR9yu59
	YM4xJZSnkxvCQzxM6
X-Received: by 2002:a05:600c:8489:b0:485:4453:401d with SMTP id 5b1f17b1804b1-48715fc38b4mr44292095e9.2.1774436852787;
        Wed, 25 Mar 2026 04:07:32 -0700 (PDT)
X-Received: by 2002:a05:600c:8489:b0:485:4453:401d with SMTP id 5b1f17b1804b1-48715fc38b4mr44291515e9.2.1774436852202;
        Wed, 25 Mar 2026 04:07:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871a937bdfsm72635965e9.9.2026.03.25.04.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 04:07:31 -0700 (PDT)
Date: Wed, 25 Mar 2026 07:07:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 3/4] ptr_ring: move free-space check into
 separate helper
Message-ID: <20260325070252-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
 <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
 <20260312094447-mutt-send-email-mst@kernel.org>
 <CANn89iLHwZ4foPEL2TdQhYx3Ps3zXiwygb=Qr7OTKW2R7Ldixg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLHwZ4foPEL2TdQhYx3Ps3zXiwygb=Qr7OTKW2R7Ldixg@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271497-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[tu-dortmund.de,gmail.com,redhat.com,lunn.ch,davemloft.net,kernel.org,networkplumber.org,nutanix.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43E93323BF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 03:21:25PM +0100, Eric Dumazet wrote:
> On Thu, Mar 12, 2026 at 2:48 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Mar 12, 2026 at 02:17:16PM +0100, Eric Dumazet wrote:
> > > On Thu, Mar 12, 2026 at 2:06 PM Simon Schippers
> > > <simon.schippers@tu-dortmund.de> wrote:
> > > >
> > > > This patch moves the check for available free space for a new entry into
> > > > a separate function. As a result, __ptr_ring_produce() remains logically
> > > > unchanged, while the new helper allows callers to determine in advance
> > > > whether subsequent __ptr_ring_produce() calls will succeed. This
> > > > information can, for example, be used to temporarily stop producing until
> > > > __ptr_ring_peek() indicates that space is available again.
> > > >
> > > > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > > > ---
> > > >  include/linux/ptr_ring.h | 14 ++++++++++++--
> > > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > > > index 534531807d95..a5a3fa4916d3 100644
> > > > --- a/include/linux/ptr_ring.h
> > > > +++ b/include/linux/ptr_ring.h
> > > > @@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
> > > >         return ret;
> > > >  }
> > > >
> > > > +static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
> > > > +{
> > > > +       if (unlikely(!r->size) || r->queue[r->producer])
> > >
> > > I think this should be
> > >
> > >        if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))
> > >
> > > And of course:
> > >
> > > @@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring *r)
> > >  static inline bool __ptr_ring_empty(struct ptr_ring *r)
> > >  {
> > >         if (likely(r->size))
> > > -               return !r->queue[READ_ONCE(r->consumer_head)];
> > > +               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]);
> > >         return true;
> > >  }
> >
> >
> > I don't understand why it's necessary. consumer_head etc are
> > all lock protected.
> >
> > queue itself is not but we are only checking it for NULL -
> > it is fine if compiler reads it in many chunks and not all
> > at once.
> >
> > > @@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
> > > ptr_ring *r, int consumer_head)
> > >          * besides the first one until we write out all entries.
> > >          */
> > >         while (likely(head > r->consumer_tail))
> > > -               r->queue[--head] = NULL;
> > > +               WRITE_ONCE(r->queue[--head], NULL);
> > >
> > >         r->consumer_tail = consumer_head;
> > >  }
> > >
> > >
> > > Presumably we should fix this in net tree first.
> >
> >
> > Maybe this one yes but I am not sure at all - KCSAN is happy.
> >
> 
> Hmmm.. what about this trace ?
> 
> BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue
> 
> write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
> __ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
> __ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
> __ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
> __skb_array_consume include/linux/skb_array.h:98 [inline]
> pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
> dequeue_skb net/sched/sch_generic.c:297 [inline]
> qdisc_restart net/sched/sch_generic.c:402 [inline]
> __qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
> qdisc_run include/net/pkt_sched.h:120 [inline]
> net_tx_action+0x379/0x590 net/core/dev.c:5793
> handle_softirqs+0xb9/0x280 kernel/softirq.c:622
> do_softirq+0x45/0x60 kernel/softirq.c:523
> __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
> local_bh_enable include/linux/bottom_half.h:33 [inline]
> bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
> bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
> bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
> __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
> __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
> __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
> x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
> __ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
> ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
> skb_array_produce include/linux/skb_array.h:44 [inline]
> pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
> dev_qdisc_enqueue net/core/dev.c:4144 [inline]
> __dev_xmit_skb net/core/dev.c:4188 [inline]
> __dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
> dev_queue_xmit include/linux/netdevice.h:3384 [inline]
> __bpf_tx_skb net/core/filter.c:2153 [inline]
> __bpf_redirect_common net/core/filter.c:2197 [inline]
> __bpf_redirect+0x862/0x990 net/core/filter.c:2204
> ____bpf_clone_redirect net/core/filter.c:2487 [inline]
> bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
> bpf_prog_53f18857bc887b09+0x22/0x2a
> bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
> __bpf_prog_run include/linux/filter.h:723 [inline]
> bpf_prog_run include/linux/filter.h:730 [inline]
> bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
> bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
> bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
> __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
> __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
> __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
> x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0xffff888104a93a00 -> 0x0000000000000000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G W syzkaller #0
> PREEMPT(full)
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/24/2026


I'm a bit unhappy to demand "ONCE" when it's actually OK if it is
written in any order (e.g. I had some optimizations doing a memcpy
here in mind).

So I wanted to reproduce this, but couldn't. And I got this so
I know KCSAN was enabled:



[  333.381268] kworker/u8:2 (40) used greatest stack depth: 12600 bytes left
Thread 0 done
[  390.104354] ==================================================================
[  390.106378] BUG: KCSAN: data-race in enqueue_hrtimer / hrtimer_interrupt
[  390.108170] 
[  390.108656] write to 0xffff88807dd1c7cc of 1 bytes by interrupt on cpu 1:
[  390.110562]  hrtimer_interrupt+0x3d7/0x400
[  390.111697]  __sysvec_apic_timer_interrupt+0xaf/0x2c0
[  390.113130]  sysvec_apic_timer_interrupt+0x6b/0x80
[  390.114469]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  390.116319]  qdisc_pkt_len_segs_init+0x81/0x370
[  390.117840]  __dev_queue_xmit+0x13e/0x1fe0
[  390.119229]  __bpf_redirect+0x31b/0x5d0
[  390.120572]  bpf_clone_redirect+0x193/0x200
[  390.122127]  bpf_prog_5c0c01093e7cbf07+0x27/0x30
[  390.123762]  bpf_test_run+0x24a/0x520
[  390.125082]  bpf_prog_test_run_skb+0x7f0/0x14d0
[  390.126720]  __sys_bpf+0x1f34/0x3e60
[  390.128077]  __x64_sys_bpf+0x4c/0x70
[  390.129475]  x64_sys_call+0x12eb/0x2520
[  390.130900]  do_syscall_64+0x133/0x530
[  390.132270]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  390.134143] 
[  390.134744] read to 0xffff88807dd1c7cc of 1 bytes by interrupt on cpu 0:
[  390.137213]  enqueue_hrtimer+0x69/0x1c0
[  390.138630]  hrtimer_start_range_ns+0x54b/0x640
[  390.140363]  start_dl_timer+0xb2/0x1a0
[  390.141777]  update_curr_dl_se+0x29c/0x360
[  390.143410]  sched_tick+0xe3/0x2d0
[  390.144773]  update_process_times+0xa2/0x120
[  390.146440]  tick_nohz_handler+0x11a/0x350
[  390.148068]  __hrtimer_run_queues+0x11a/0x680
[  390.149710]  hrtimer_interrupt+0x1f7/0x400
[  390.151244]  __sysvec_apic_timer_interrupt+0xaf/0x2c0
[  390.153143]  sysvec_apic_timer_interrupt+0x6b/0x80
[  390.154604]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  390.156003]  pv_native_safe_halt+0xf/0x20
[  390.157216]  default_idle+0x9/0x10
[  390.158189]  default_idle_call+0x88/0x230
[  390.159369]  do_idle+0x1f9/0x280
[  390.160383]  cpu_startup_entry+0x24/0x30
[  390.161528]  rest_init+0x1be/0x1c0
[  390.162556]  start_kernel+0xa1b/0xa20
[  390.163658]  x86_64_start_reservations+0x24/0x30
[  390.164950]  x86_64_start_kernel+0xd1/0xe0
[  390.166094]  common_startup_64+0x13e/0x148
[  390.167242] 
[  390.167721] Reported by Kernel Concurrency Sanitizer on:
[  390.169462] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.0.0-rc2-dirty #352 PREEMPT(full) 
[  390.171946] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[  390.174471] ==================================================================


