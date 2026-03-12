Return-Path: <netdev+bounces-267094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HY8MJMLMsmmPPwAAu9opvQ
	(envelope-from <netdev+bounces-267094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:25:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 320992734D2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 090C23042757
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD2366565;
	Thu, 12 Mar 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxAl0QEx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699AF35A388
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325299; cv=pass; b=kIyyrnJKVen6gVCb9f6Ets3iq2C4wJg2jnHJ1wt6L5rzhkNB5+MAfSF79cKU+z69sLJWLIVXOXjqi/V6A4sDZrIWDq1c7Wn4G75zW6iDmdOExjczUm1ir+dCv2JOPRbYFyfiyrvDwrgukrbkxHoXp2AJqkIYjDyVedpxZB1+twM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325299; c=relaxed/simple;
	bh=0MmwDt0N+cjGTBkLO+1REp2Kd6NP3k+zduo/AMzi+Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfLH0XkjRaPCiqGFnEg9kb0OwaqBepu7mlg22nBFejvfxF2Xyu4Ia5fVxpRdddDFRzO4N/on0D5Xt1KW7CSuoRYLYEKpLPk3Iz+msW2ttOR0b2w1XAupZaf7UKm32nUjdlf624+HXDIOAoVmxI3bsNtWAiOrkBm4b1xRwasKn6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxAl0QEx; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb3bae8d3eso103652185a.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 07:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773325297; cv=none;
        d=google.com; s=arc-20240605;
        b=kck0wSDzuev0vlG8g2S9VgfhDgyAT+V23qe7bk6x2X4qyK8eZPMQ0AWY7WVAqj/sb0
         XChhC6+iCKpQpz37S9QoSH/rS36vp9b3k5MhwDJsMqR2D6EaZndmPtjTQK6RLo7HBgRV
         NDM+1QRUOKALxkQsVTMskxnh6MGvmNiujnmFVgDCZvUrsrCt40eUhHXFRfniXKHECDuS
         WbDvzRAyBWQHyXCiQysGVa7nj4uo3gqhyJpre0eMXez+TtcJooeo/TclTbOwH+Bbmnd2
         XIPS5PNUEEKeBrHiAXBJM4Kru0aWt5fDbTyJ419PlKL2HyR49gPxSr6/v8YqNjMONhkQ
         Mu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niej5qkKc8N5xc0L2AmEIZoSaGSlXVWpm+rorTwVSs4=;
        fh=FqAcurx1ykFP0AMcXeuVG/xhYC+5XI9k02fdoHHpx3M=;
        b=C1Yy9qe1ZwGvFM/d7V6CELhX1rtu9hl3wMMaY6OXQF3+cdgEJje62VDV5acEvxO7kg
         3+Va4Bn2/ueeOfVm87j9P6bNclpUZPkONbOeZ4vEZrTW3AkaCQOyU93MXRm0vHcrI67S
         T5vWv8DBJvuU1ovOEWf76QvVV4G2mb1M6gtCuMQ103eiis9nqBL6JFvD2cBQIZWHf9VR
         flGElATqbSPmUajadjXvCbsb6ug60vUK/97rY48FK/7ZGwff7YKam0fCtp8IlRWOGWxt
         ipfkOwzqc+03j4mhib7P7WP4W2AYJj6E7whPyRR2SXnPU41WJXfh1N2gSjoG6t6Jph29
         B2tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773325297; x=1773930097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niej5qkKc8N5xc0L2AmEIZoSaGSlXVWpm+rorTwVSs4=;
        b=LxAl0QExn9LUKBvucDG/jDlOrRgvhigExOy82otyL/5thJUswRid+ZfqpUAltkM4zN
         gZySjaCVuNbpoKQ/2a7rswJ0BtPlQwkn6oARJl/5OTiR6x7AnRv4f5+VIKIhlZWLRKG8
         /emupPBV70zIh1oC5VlOBtLYcDeNwk3yOZqaz87jKZZ5WUyzaFPqOesHKaGwwZo+SAhC
         BnvicX3I92kjcnzwmr/71H+bdHjf6h+oRY97Iq//KHFixTCH/cePr/vLa8G7LdADNE10
         Y6FKZBmP33s4G7oMDHtk0iQ7ds1SZIkKuLbAaHv5RY/jHOvoDy9JvfFB740W1kSO2zWS
         56uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325297; x=1773930097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niej5qkKc8N5xc0L2AmEIZoSaGSlXVWpm+rorTwVSs4=;
        b=RqmNA79edUzejDQIh7OzPk25sNnRBak/wTMQoD7Wl0wF0+JQOC8OVpiDWWPIv+moK2
         vNTU/Ee6pUHJHI3FlSV0OuM4BSOzCUbZh+Y2fdhmwCI46n+dbvV0hVNl+WPTBEeNlBDx
         marG9b6dKKs9wv+vu6dqz9y5TyJ3ies4QFdgy2G9B7q4UQHCa4BMaeZaKVZweVj4x61E
         dCL7p1MKeZylTAmWZpFJ6mFCvApSGTucGsBK4Pw2vlJVs6EIQ3Y7bOnjSRcKn6FxgmYx
         YinIVP6thK56YQ0wDGxUX+c2lHtRmE1MCvD4/7zkiRpsSBUqZHxmNEP27hKdxBnDf0ui
         k3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtxHqxxD9yHhyjaDiz6VwUP/Nxbzvi51qxb8fHmdacqARiiSd9ZKbhYx7xeySqoH3+jTpXjBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3zEvv1Us7Lx+Lj4XRnLXMu+BAg+ntjNsnKHeiVyVbpVvXV7t
	0PFTc7TRGXHKriSJ7pugh5pLWriItOvlhge27qWkKgPcMDom8OYKh/qXwj4NlS6bUmjWcyNdD3e
	9AZR0PXRLIXA8hdzHDp63jkLJInOqR/jkZWB872TH
X-Gm-Gg: ATEYQzzjDrSo6exN63ToyP6TTNiHHTq4zjiVEt47EB7tM3vMqC02LpNhr1ogP8Z2pMA
	ROPoz8hNkyKUENKdz2m2h94r5i4OpFuYHkhPcLtQXR9/tQDtwOITV10/Ws+CQYkscJ+cGpifNLs
	GyDlHsPxuDMS6UJZhD0rbheZO/Sbc1yT8HlMhsnnvmQbmdOgeUPwLccC8xRFBkZAoMg63QDFhJa
	xMQXLoCAvpVEHam+EDTRtqyH8s49D3i3++rpvQv3R7mNjryad/kVgnYcXUEPJS3tx+fuoz8gIia
	EEGTHL2V
X-Received: by 2002:a05:622a:14c:b0:501:1795:9d52 with SMTP id
 d75a77b69052e-50939fc1863mr86449811cf.33.1773325296875; Thu, 12 Mar 2026
 07:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-4-simon.schippers@tu-dortmund.de> <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
 <20260312094447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260312094447-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 15:21:25 +0100
X-Gm-Features: AaiRm519R7QoAd18JWvrdvhH1ifA15H5AznmUpI-fEIpOmq2LTIYuzUlf4ZNyAg
Message-ID: <CANn89iLHwZ4foPEL2TdQhYx3Ps3zXiwygb=Qr7OTKW2R7Ldixg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/4] ptr_ring: move free-space check into
 separate helper
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267094-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[tu-dortmund.de,gmail.com,redhat.com,lunn.ch,davemloft.net,kernel.org,networkplumber.org,nutanix.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,tu-dortmund.de:email]
X-Rspamd-Queue-Id: 320992734D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 2:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Mar 12, 2026 at 02:17:16PM +0100, Eric Dumazet wrote:
> > On Thu, Mar 12, 2026 at 2:06=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> > >
> > > This patch moves the check for available free space for a new entry i=
nto
> > > a separate function. As a result, __ptr_ring_produce() remains logica=
lly
> > > unchanged, while the new helper allows callers to determine in advanc=
e
> > > whether subsequent __ptr_ring_produce() calls will succeed. This
> > > information can, for example, be used to temporarily stop producing u=
ntil
> > > __ptr_ring_peek() indicates that space is available again.
> > >
> > > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > > ---
> > >  include/linux/ptr_ring.h | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > > index 534531807d95..a5a3fa4916d3 100644
> > > --- a/include/linux/ptr_ring.h
> > > +++ b/include/linux/ptr_ring.h
> > > @@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_rin=
g *r)
> > >         return ret;
> > >  }
> > >
> > > +static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
> > > +{
> > > +       if (unlikely(!r->size) || r->queue[r->producer])
> >
> > I think this should be
> >
> >        if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))
> >
> > And of course:
> >
> > @@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring=
 *r)
> >  static inline bool __ptr_ring_empty(struct ptr_ring *r)
> >  {
> >         if (likely(r->size))
> > -               return !r->queue[READ_ONCE(r->consumer_head)];
> > +               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]=
);
> >         return true;
> >  }
>
>
> I don't understand why it's necessary. consumer_head etc are
> all lock protected.
>
> queue itself is not but we are only checking it for NULL -
> it is fine if compiler reads it in many chunks and not all
> at once.
>
> > @@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
> > ptr_ring *r, int consumer_head)
> >          * besides the first one until we write out all entries.
> >          */
> >         while (likely(head > r->consumer_tail))
> > -               r->queue[--head] =3D NULL;
> > +               WRITE_ONCE(r->queue[--head], NULL);
> >
> >         r->consumer_tail =3D consumer_head;
> >  }
> >
> >
> > Presumably we should fix this in net tree first.
>
>
> Maybe this one yes but I am not sure at all - KCSAN is happy.
>

Hmmm.. what about this trace ?

BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue

write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
__ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
__ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
__ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
__skb_array_consume include/linux/skb_array.h:98 [inline]
pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
dequeue_skb net/sched/sch_generic.c:297 [inline]
qdisc_restart net/sched/sch_generic.c:402 [inline]
__qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
qdisc_run include/net/pkt_sched.h:120 [inline]
net_tx_action+0x379/0x590 net/core/dev.c:5793
handle_softirqs+0xb9/0x280 kernel/softirq.c:622
do_softirq+0x45/0x60 kernel/softirq.c:523
__local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
local_bh_enable include/linux/bottom_half.h:33 [inline]
bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
__ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
skb_array_produce include/linux/skb_array.h:44 [inline]
pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
dev_qdisc_enqueue net/core/dev.c:4144 [inline]
__dev_xmit_skb net/core/dev.c:4188 [inline]
__dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
dev_queue_xmit include/linux/netdevice.h:3384 [inline]
__bpf_tx_skb net/core/filter.c:2153 [inline]
__bpf_redirect_common net/core/filter.c:2197 [inline]
__bpf_redirect+0x862/0x990 net/core/filter.c:2204
____bpf_clone_redirect net/core/filter.c:2487 [inline]
bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
bpf_prog_53f18857bc887b09+0x22/0x2a
bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
__bpf_prog_run include/linux/filter.h:723 [inline]
bpf_prog_run include/linux/filter.h:730 [inline]
bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888104a93a00 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G W syzkaller #0
PREEMPT(full)
Tainted: [W]=3DWARN
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/24/2026

