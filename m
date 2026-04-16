Return-Path: <netdev+bounces-279102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPA2LNgc4WmmpAAAu9opvQ
	(envelope-from <netdev+bounces-279102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A4412C05
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3E430CD17C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE21326923;
	Thu, 16 Apr 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcfJDNDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA043325495
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360259; cv=none; b=rWY2aEG9ZGOs/H3YNQRpsvbUi/ez289mup1buwalKrjxPIS44pcT0K2El9p8pXRUztA6/IFgu1LO1HUdMMlLkNlWVdmG3cVHaPlkiNu7A/y+zWgMD6iRTwXL5m4wseYfbDGE1ZNx9SIomCqo278Ld3MZQln9gkPjyTFf02D09PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360259; c=relaxed/simple;
	bh=xaWJoLVdWyQUmf47HsFVOYydFuRf7dh9+Qefm3ollg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+VMvijwEkGZZuh7Sw2NMxZbDYmfqMvB0wG8NxM9n41cZr4TmiEkE9NNeFn9chtvqwsgDltgct/r2uDr429sHI3c+xiZIRgJ/yNFQPU2v19DWQNcndDPOK7EWkRX7a9NDeUeRoh8cV4WgIvpK/++/tZx7CMWAZyu5lkkYh+1vAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcfJDNDd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c795a88e8acso804524a12.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776360257; x=1776965057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L/6+puzGxVVZQjYe8b0AG/fP2JQhjufipAH1BTfzJmc=;
        b=dcfJDNDdJPyHlyElmc78lfpdlim2nHH7ceAeMWUm50cCQygkICvpX9EX2j2/Ez6Hcg
         9CIh25qz6IHjSVedFzzMFjJKCa897ybF5uW3nxj337ZYmdTYvOw6StF9+vdyh0wtUzGG
         ASMO8K7toecssrRwT5XteMnWE4oCcL5GI9Y6ZOyxEbdGfcNluFGgtgzafzaCUEt8RVEy
         LOPRQw0yT98V5YlRxOr3cEIR2XNS13VP/NMgGuHR/udCMd7Rw89U30V9VhOa436wzQgW
         FI1kzsO/r8QrGpNLOWvmS56gpdySy4QvaDaGQP/q7Sz8VZo4QmgCA9i9xB1fSACAEaMa
         jiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776360257; x=1776965057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/6+puzGxVVZQjYe8b0AG/fP2JQhjufipAH1BTfzJmc=;
        b=flyDM2TCLqXdy/50tBSa1OPLftLexUpfarmc1weSR6BEVkL5bf2lLUebFDF2k1ggop
         KgHUyDgcEYWl3XgzynGy1hFiIf6Ql0/yja9AY50yKp69TwL1ak2Uwss1K2j1cD3focA/
         MRbjOjI7IV5EL0ZbB1j4/EAXI3jvlfzRFGYST+ovYhq+f78pXG6SzgtQmD9IjDAxQ+/J
         3/GdIWc/ipU/OEJmPTLl3AGhvPWJ6p071m0+Y1ySbbSfkUc2XyznsexwNYieToT8rWci
         mcilo0WQrXqK8ovmtiLeQwlvJSJK6hn9UJavz4UGrfAmHTuzhfDMDxm9EKigoctZLz3/
         SmoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9C5PoVUwOxxmJXDOrIu3i0gZ/hZErIjUMNjxTQ2OSGX/fCF8ceDG8mjaCAS/fBhYVF/9Sxl2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbCW70B0cKP2jGNEZrBxpTdfjXyhdMzFvzJAg6x0jvX73Nj6S
	jfNemYixPi2djqNcYXggvFCwy6fptSzErE1QyRMIn65WHSVYU8wPGvhK
X-Gm-Gg: AeBDiett6H08ML37U1yDrINERbps0S8iEighL5VkaZWyjD7tAUvHCh3TRnWucfppzw5
	9eLCrV3HmE8pow1guKxG70AxU5fan5Do0DLXbrAE1O6j6uXqo+Yf2TM6RRbZCa4/T3qNPsOrd8x
	1OORNCdVA/HfiLInn1Znw0p0ecK0glU6BT54ChqMtnf5Or4OHu8LvOTQyMnAINZVDjP1ZAst6pH
	ZP9DMnGyQgR6UXMLw+qR3V06qcgULFWWnFXNCHlpo7eytzVhLLR6SxqgaV4hKZ47Do4nm8ZHV0A
	JAWjoB1XCYQ3ZrVtPcmPhpT9bwBeHWejHnrhbutsbWAioGjoEO/JcUfVfE5O3TzmGlegicv3Vg0
	pDo90GA6VmVtHXybmw1qhWhr1TZ4/Ki2twBtsrJ1mCnQbx8nyDspuEEw4uL0wUmviXBamxP+h7K
	cHN7jEAVn6uBA3WRFzTRb+4GRYyAZUp+YvRhxx9Lth8AOMxeV6zBJ6cXsIYIDMpMa0l2aKPsA=
X-Received: by 2002:a17:903:32c5:b0:2b2:57df:264d with SMTP id d9443c01a7336-2b2d5a376bcmr276034915ad.33.1776360256932;
        Thu, 16 Apr 2026 10:24:16 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47810aea1sm60347125ad.22.2026.04.16.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 10:24:16 -0700 (PDT)
Date: Fri, 17 Apr 2026 01:24:11 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v3] net/sched: taprio: fix NULL pointer dereference
 in class dump
Message-ID: <aeEbO8aNgBZDMkoD@SLSGDTSWING002>
References: <20260414104311.74115-2-bestswngs@gmail.com>
 <CAM0EoMnhH+7NA6A-mg3rvQJLwN0Wvhd6tYeOYa_YMMdYkMPZHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnhH+7NA6A-mg3rvQJLwN0Wvhd6tYeOYa_YMMdYkMPZHQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-279102-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.3:email,0.0.0.6:email,0.0.0.0:email,0.0.0.1:email];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.4:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.2:email,0.0.0.5:email,0.0.0.7:email]
X-Rspamd-Queue-Id: 101A4412C05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-16 11:50, Jamal Hadi Salim wrote:
> On Tue, Apr 14, 2026 at 6:43 AM Weiming Shi <bestswngs@gmail.com> wrote:
> >
> > When a TAPRIO child qdisc is deleted via RTM_DELQDISC, taprio_graft()
> > is called with new == NULL and stores NULL into q->qdiscs[cl - 1].
> > Subsequent RTM_GETTCLASS dump operations walk all classes via
> > taprio_walk() and call taprio_dump_class(), which calls taprio_leaf()
> > returning the NULL pointer, then dereferences it to read child->handle,
> > causing a kernel NULL pointer dereference.
> >
> > The bug is reachable with namespace-scoped CAP_NET_ADMIN on any kernel
> > with CONFIG_NET_SCH_TAPRIO enabled. On systems with unprivileged user
> > namespaces enabled, an unprivileged local user can trigger a kernel
> > panic by creating a taprio qdisc inside a new network namespace,
> > grafting an explicit child qdisc, deleting it, and requesting a class
> > dump. The RTM_GETTCLASS dump itself requires no capability.
> >
> 
> While i would say this looks good to me, I hate to sound like a broken
> record but:
> 
> Do you have a reproducer?
> And it would be nice to get a tdc test from you.
> 
> Also, please use assisted-by: or even suggested-by if this patch was
> suggested by AI.
> 
> cheers,
> jamal

Hi Jamal,

Thanks for the review. Reproducer below -- tested on a KASAN kernel
under vng:

```
unshare -Urn
ip link add veth0 numtxqueues 8 numrxqueues 8 type veth \
    peer name veth1 numtxqueues 8 numrxqueues 8
ip link set veth0 up
tc qdisc replace dev veth0 root handle 100: taprio       \
    num_tc 8 map 0 1 2 3 4 5 6 7                         \
    queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7               \
    base-time 0 sched-entry S ff 20000000 clockid CLOCK_TAI
tc qdisc add dev veth0 parent 100:1 handle 200: pfifo
tc qdisc del dev veth0 parent 100:1 handle 200:
tc class show dev veth0
```
A C PoC is also available if needed.

I'll test and send a v4 with the tdc test case and an Assisted-by tag.

Thanks,
Weiming Shi
> 
> 
> >  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
> >  RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2475)
> >  Call Trace:
> >   <TASK>
> >   tc_fill_tclass (net/sched/sch_api.c:1966)
> >   qdisc_class_dump (net/sched/sch_api.c:2329)
> >   taprio_walk (net/sched/sch_taprio.c:2510)
> >   tc_dump_tclass_qdisc (net/sched/sch_api.c:2353)
> >   tc_dump_tclass_root (net/sched/sch_api.c:2370)
> >   tc_dump_tclass (net/sched/sch_api.c:2431)
> >   rtnl_dumpit (net/core/rtnetlink.c:6827)
> >   netlink_dump (net/netlink/af_netlink.c:2325)
> >   rtnetlink_rcv_msg (net/core/rtnetlink.c:6927)
> >   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
> >   </TASK>
> >
> > Fix this by substituting &noop_qdisc when new is NULL in
> > taprio_graft(), following the same pattern used by multiq_graft() and
> > prio_graft(). This ensures q->qdiscs[] slots are never NULL, making
> > control-plane dump paths safe without requiring individual NULL checks.
> >
> > Since the data-plane paths (taprio_enqueue and taprio_dequeue_from_txq)
> > previously had explicit NULL guards that would drop/skip the packet
> > cleanly, update those checks to test for &noop_qdisc instead. Without
> > this, packets would reach taprio_enqueue_one() which increments the root
> > qdisc's qlen and backlog before calling the child's enqueue; noop_qdisc
> > drops the packet but those counters are never rolled back, permanently
> > inflating the root qdisc's statistics.
> >
> > Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > v3: fix broken patch
> > v2: Also update NULL guards in taprio_enqueue() and
> >     taprio_dequeue_from_txq() to avoid qlen/backlog inflation (Paolo).
> > ---
> >  net/sched/sch_taprio.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index f721c03514f60..07723b156c5b3 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -634,7 +634,7 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> >         queue = skb_get_queue_mapping(skb);
> >
> >         child = q->qdiscs[queue];
> > -       if (unlikely(!child))
> > +       if (unlikely(child == &noop_qdisc))
> >                 return qdisc_drop(skb, sch, to_free);
> >
> >         if (taprio_skb_exceeds_queue_max_sdu(sch, skb)) {
> > @@ -717,7 +717,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
> >         int len;
> >         u8 tc;
> >
> > -       if (unlikely(!child))
> > +       if (unlikely(child == &noop_qdisc))
> >                 return NULL;
> >
> >         if (TXTIME_ASSIST_IS_ENABLED(q->flags))
> > @@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
> >         if (!dev_queue)
> >                 return -EINVAL;
> >
> > +       if (!new)
> > +               new = &noop_qdisc;
> > +
> >         if (dev->flags & IFF_UP)
> >                 dev_deactivate(dev);
> >
> > @@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
> >         *old = q->qdiscs[cl - 1];
> >         if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
> >                 WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) != *old);
> > -               if (new)
> > +               if (new != &noop_qdisc)
> >                         qdisc_refcount_inc(new);
> >                 if (*old)
> >                         qdisc_put(*old);
> >         }
> >
> >         q->qdiscs[cl - 1] = new;
> > -       if (new)
> > +       if (new != &noop_qdisc)
> >                 new->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
> >
> >         if (dev->flags & IFF_UP)
> > --
> > 2.43.0
> >

