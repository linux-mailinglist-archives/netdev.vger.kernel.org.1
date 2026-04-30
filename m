Return-Path: <netdev+bounces-282957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D+XLQyN82md4wEAu9opvQ
	(envelope-from <netdev+bounces-282957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:10:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1431B4A6386
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8188D3009166
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF7401498;
	Thu, 30 Apr 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mb3261Ln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AE2848BA
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569025; cv=pass; b=KUm6Jnr1zRiMoRpwbHy8M2RD1wAGKvF8wSHk8EMb89ISqxrsGvkyL710XwhOlkZVLrRVYZqHAfROBDGabgcxmOit3tzz50JMX5gc0288HEKxLEehNoZ5HQ2DxHv1h2DBskCkaIig9/K6oNEyfjO7GeT2jlREQA4KOS0QFaAir4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569025; c=relaxed/simple;
	bh=DNVlnakk13aUrg/hD2oRV2j1tPfuGQFYLjetu4lriIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbQhIvqaC+tHsbjX+Eb5N/IAerpz17OvHCHdAa1+SU8hEwHOi10OHs5vX/Z2K1V6pZdNVaiyFnE7rI/Nrm/XEYpLJgyhArDtLA8m5jCOU7tW0xE2HOrEeMeiIcZfNR46bfTjJaQwhnZYyjFqY+DTCtKzTNgYZxgDo2SIXVhlfoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mb3261Ln; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e63771d91so11033851cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777569022; cv=none;
        d=google.com; s=arc-20240605;
        b=jl6PIRPD95Stxh1L7/Tx7sPc3T2G3bXnGJiyHvUBq2BKPZHfTRPTMtTGq9mEjg4aFQ
         k2wREccOpgVaF5Rke1OTrrQ9zpI8BKe7Q28f9apfMDxSV3sGH/NaB2AvIl7MldD+kwW5
         3qDy/aTpFJtc0d9nDxVgjqlkL+NZ4owOB+C+r24rckPWBlfh6+1nkZpNiAt3DTpnjDnj
         Q9OP3J8y0B5SJsou0epZUcWCBlAy9IwsSByNU389rhGcRZGOorNb4bG+wZC9iOmhnx2w
         HG/PYdXHLEx6NaKxb280Y1NNNlFb5uP4eT+cT94RlZGKk4L+E+iQ+UdK2N7gYnJVcIdw
         8fCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yrzguIxjvs/dYwgMGJK74KZhhZt3RDq4c7p/kIBoyEs=;
        fh=3o/E/+j04ssj+bSQ0VVP71qyU+r/tSq7XymPkZupego=;
        b=ZvEvKpxAOo0dkYeXsuQqck6IvX38LYF7yMXJ9OwTtVyPRYJ27DGyfK2/CkU9+sGpDr
         /U++/FVxceelZ0MeY/IveYT19mS/XDLehrGdp7sr3s+h6fV2zCixqTy55x6n26hssb+j
         ZqqDwXKYXd5qkTA72akrREVOoVmEUdBo2GwOyVC8LCLo4bgCqB8dR8JXfJyYiIReegqf
         wGZHGK+VcXmAKvyxk6eLLfVA3rpl1oCdI8aToJPoxqpOk6Fx1uKfhkPtiNbS4eviVP5H
         kVa3tqjQA0EBFD/i7WxUEmizBo8BPhzL1soeNh4ePVwJPkRNdAjBLRNlRLrZs0Z9/OGs
         S9bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777569022; x=1778173822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrzguIxjvs/dYwgMGJK74KZhhZt3RDq4c7p/kIBoyEs=;
        b=mb3261LnUfIjnk1/RgFvOeGmRXrQtsjrUwy5xA+DN40KShKlHeAXgCz1rj7UzU7fik
         L5naJPvUX0629DXKOgEPO3c0QEVIdnHX5iyCxgn0ZVXyD+XnmlV6YHj2nii5VldpXR5k
         7w9D+4Xs8WttXOaLG7oFd+j5ztlKO2OfGoa2+JR7EIWKosObjAue/WYycV/mkWTAAhB6
         G+W9pZ/4rn2r6vFTfxsSEzAom/r3Dfqa7bKabqxLnkO26FbFu9t39zYscHlSvvCio+DA
         RzicNIFAPk32Aq22EcJJQkkmF4QEhQENZSeuQQyiDdNq3+scUTVgopNMm4t6rC9cKpUA
         ySWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569022; x=1778173822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrzguIxjvs/dYwgMGJK74KZhhZt3RDq4c7p/kIBoyEs=;
        b=YkxiZNGMP+nD6VobVm7pD4UIjT7wfMsT7UV4v+qLT9BIZK1Xc25Bhjf+bnEDEFZsBr
         GmtETeSV8X1SorHVjrBH0rVrbqArgparC08U468whGbGBRElNnM62656COGc91GuKgKr
         81vNBZ3ZUgsYhunq+J41HRJSOmLTQNHM9jw/enGZAzH50zYVg+5T89O0ACC7DIZ6LSpo
         q6V8xDmSCz0rKTym6b7kv8Eb/XT+6jhV/K0TVM/3CMvF6oDNdOkS8gaXnP4X/b8I6d3n
         RQ9kZEyyY/pNYTnY01NxtoXW3hD6Oa0rHA419F2J5bYSRUbQHLvDC3ysFhRFsau/hxJj
         wIyQ==
X-Gm-Message-State: AOJu0YwblPlX23yvMoyLta/Macg7JutdLDoDdqttvwHXd/gSktLEUeuo
	SQNRLXDqH5/jcyd2jygo0uie9v44MeSAolgLgyMjUjbWKXorLWoDB2GCuua3hMJglb+lWGskQF7
	GKmBwVuP3eZxfeK568GFT+x6F1nqOx6geZpJN4Sqf
X-Gm-Gg: AeBDievAGUq0QDX2jY7UEq6Ep7UAk9DQS/VQOKLixfAHfEFZGzN9xnOQFSJqu6istO6
	+i9TkwJmmTkLYvoHmYAd4qF2aYp1hA4clWmN+39eU0qkKUHWgZ5udcHIP1eml3yTxzdjw1qAi+Z
	kNmC8d3cfzM371WlrrO/Dz3wEms9A8ZyUgKO6yHuu8H4gVu1VUwSzZonNbXCDYXhs9eL9xqtXFn
	zv5I7Q3WVWRFB4ZG/z1waM65fYZvtVEX3AmhLNbWybLUgRHwzNbyYN1LAUmgl/DBQGXAaE+kY+J
	3q63kK8ZDxa/ZsMLnLZdOY5Cdq3HV/aDnauBw0ebvnO94Zi5DrThYeaTEmq2sjMXtBhHbkR8WH3
	K7pZnPMqRlMjWwbETE5NSewhNcAFewiSQGC/GOhe0
X-Received: by 2002:a05:622a:1f09:b0:50d:a1c4:e154 with SMTP id
 d75a77b69052e-5102ae1da7fmr52716511cf.36.1777569021888; Thu, 30 Apr 2026
 10:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430162604.1043756-1-idosch@nvidia.com>
In-Reply-To: <20260430162604.1043756-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 10:10:10 -0700
X-Gm-Features: AVHnY4Ji_7uVCqMoljL0LD076ahF-xWJc3AxPt1g7gzVMrU55PPMiMUJ5ew-Guo
Message-ID: <CANn89iJ5-rBLtsOZoAfbeF+X29VrpLCXQaLi2fio30_F81+9_Q@mail.gmail.com>
Subject: Re: [PATCH net v2] bridge: mcast: Fix a false positive lockdep splat
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, razor@blackwall.org, horms@kernel.org, 
	herbert@gondor.apana.org.au, linus.luessing@c0d3.blue, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1431B4A6386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282957-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,appspotmail.com:email]

On Thu, Apr 30, 2026 at 9:27=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Connecting two bridges on the same system [1] can result in a lockdep
> splat [2].
>
> The report is a false positive. Multicast queries are built and
> transmitted under the bridge multicast lock. When the outgoing port of
> one bridge is configured on top of another bridge, the transmit path
> re-enters bridge code and acquires the other bridge's multicast lock in
> order to snoop the query. Both lock instances share a single lockdep
> class, so lockdep flags the nested acquisition as an AA deadlock.
>
> Giving each bridge its own lock class will not solve the problem: the
> reverse topology would produce an ABBA splat with the same pair of
> classes. It also consumes a lockdep key per bridge.
>
> Instead, fix the problem by deferring the transmission of the queries to
> a workqueue. Build the skb and update querier state under the lock as
> before, then enqueue the skb on a per multicast context queue and
> schedule the work.
>
> Flush the work when the multicast context is de-initialized. At this
> stage the work cannot be requeued. There is no need to take a reference
> on skb->dev since the work cannot outlive the bridge or the bridge port.
>
> Use the high priority workqueue to reduce the delay between the enqueue
> time and the transmission time. With default settings (i.e., querier
> interval - 255 seconds, query interval - 125 seconds) the extra delay
> should not be a problem.
>
> Avoid the unlikely case of the queue growing endlessly by limiting it to
> 1,000 skbs. Use this number for the simple reason that this is the
> default Tx queue length.
>
> [1]
> ip link add name br1 up type bridge mcast_snooping 1 mcast_querier 1
> ip link add name br0 up type bridge mcast_snooping 1 mcast_querier 1
> ip link add link br0 name br0.10 up master br1 type vlan id 10
>
> [2]
> WARNING: possible recursive locking detected
> 7.0.0-virtme-gb50c64a58a90 #1 Not tainted
> [...]
> ip/339 is trying to acquire lock:
> ffff888104f0b480 (&br->multicast_lock){+.-.}-{3:3}, at: br_ip6_multicast_=
query (net/bridge/br_multicast.c:3584)
>
> but task is already holding lock:
> ffff888104f03480 (&br->multicast_lock){+.-.}-{3:3}, at: br_multicast_port=
_query_expired (net/bridge/br_multicast.c:1904)
>
> [...]
>
> Call Trace:
> [...]
> br_ip6_multicast_query (net/bridge/br_multicast.c:3584)
> br_multicast_ipv6_rcv (net/bridge/br_multicast.c:3988)
> br_dev_xmit (net/bridge/br_device.c:98 (discriminator 1))
> dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/net=
device.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
> __dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
> vlan_dev_hard_start_xmit (net/8021q/vlan_dev.c:131 (discriminator 1))
> dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/net=
device.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
> __dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
> br_dev_queue_push_xmit (net/bridge/br_forward.c:60)
> __br_multicast_send_query (net/bridge/br_multicast.c:1811 (discriminator =
1))
> br_multicast_send_query (net/bridge/br_multicast.c:1889)
> br_multicast_port_query_expired (./include/linux/spinlock.h:390 net/bridg=
e/br_multicast.c:1914)
> call_timer_fn (./arch/x86/include/asm/jump_label.h:37 ./include/trace/eve=
nts/timer.h:127 kernel/time/timer.c:1749)
> [...]
>
> Fixes: eb1d16414339 ("bridge: Add core IGMP snooping support")
> Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/000000000000c4c9d405f2643e01@googl=
e.com/
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> v2:
>   - Limit the queue to 1,000 skbs.
>   - Edit the trace to avoid checkpatch errors.
> v1: https://lore.kernel.org/netdev/20260426133435.207006-1-idosch@nvidia.=
com/
> ---
>  net/bridge/br_multicast.c | 47 +++++++++++++++++++++++++++++++++++----
>  net/bridge/br_private.h   |  4 ++++
>  2 files changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 881d866d687a..e9f5fe01ff95 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1776,6 +1776,30 @@ static void br_multicast_select_own_querier(struct=
 net_bridge_mcast *brmctx,
>  #endif
>  }
>
> +static void br_multicast_port_query_queue_work(struct work_struct *work)
> +{
> +       struct net_bridge_mcast_port *pmctx;
> +       struct sk_buff *skb;
> +
> +       pmctx =3D container_of(work, struct net_bridge_mcast_port,
> +                            query_queue_work);
> +       while ((skb =3D skb_dequeue(&pmctx->query_queue)))
> +               NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, dev_net(skb->dev=
),
> +                       NULL, skb, NULL, skb->dev, br_dev_queue_push_xmit=
);
> +}
> +
> +static void br_multicast_query_queue_work(struct work_struct *work)
> +{
> +       struct net_bridge_mcast *brmctx;
> +       struct sk_buff *skb;
> +
> +       brmctx =3D container_of(work, struct net_bridge_mcast, query_queu=
e_work);
> +       while ((skb =3D skb_dequeue(&brmctx->query_queue)))
> +               netif_rx(skb);
> +}

These two functions could loop forever under flood.

Perhaps use skb_queue_splice_init() to limit each round to the ~1,000
limit you have mentioned in the changelog.

And return after the spliced list has been processed.

Bonus: no more spinlock acquisition for each skb_dequeue()

