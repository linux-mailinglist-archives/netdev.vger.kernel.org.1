Return-Path: <netdev+bounces-304279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kz1nNDjiRmpwfAsAu9opvQ
	(envelope-from <netdev+bounces-304279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:12:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8CE6FD26D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:12:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=HnBzeJa+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304279-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304279-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE96B3018D28
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 22:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1145237A833;
	Thu,  2 Jul 2026 22:12:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EEE22332E
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:12:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030326; cv=pass; b=OFsHZKRsOxM/zsV5xtuQlapWBFXHNdEWslzU71IdsH39qQRv3alvfs/kdrZ7lQcVYyExQOHx8nxdxgcOCJaOTBJDG4BYDR3f/uZS1FtkWmu7j3PYhhKAjNFxVYkXmCrRar7RFoRu4Gcm4OhSqNyOyS1jMTMrqjuIyou3oIY3024=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030326; c=relaxed/simple;
	bh=CX5YXwkzsxbjJBT2OIlUwG4oFTJrtyWYB/BkD/S8fhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afQHC08vE/gqW/NltqEQLOMZA/gvHRvdSDmpLSIai26xlJtwbfNy6mp5okc8KDI6bA3HNNSyu44RQOX80c3vbJTuaBP6q3bvE+rfYDRtmvSYAeZrRFrGHpx9jSpLXADNqgB/cwiCj7TrUXKxRnaurEu3lxPFRP7Em/QG5iVH05g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=HnBzeJa+; arc=pass smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1122827a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783030323; cv=none;
        d=google.com; s=arc-20260327;
        b=J2/W7MnEsrnbLObzdyPzKbcCw7oWduWwcBSr8riB+Hsuf7TAmZm2WCmW/4Kmbw1+FI
         Oa4nXAbrqh0bajJxtOO/aSmIsUUcSn2TELlTF10U4boDG7ZWJ6NJPlV5oMaj0yFF2IOh
         TMs0nM07/mwJ6WqAeZgG5+cR3Cm6xbACT90RZCaLtg0d65e292JFK+xQqiGlOr1aSnzL
         irkIfyuC+OcRzc5Chgsxlv/6kfqkUTBUczw9VxyePPtI1hJGABLNnFe2cHrLzfOTmI0N
         NggueBulRvT+XEwgftM/2NUYacLCb7ytMWQ+BdDOGfUT9g5m4Bz5GdBoK+O3rpt3nPTm
         alxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MRUmP52vY013mSbfIXwpgJp8jMWEcHcxvZP2AdpKO8Y=;
        fh=kLfW3wGLg1a+l8JjDVG3FtJIAVLqzOHOrm3lY1eEa/E=;
        b=gvT6wF7Iv9mdB6V8Fg3ip2RYS1uVGhU1uRnVsnFrESbx8KStZYxD/GUiugo8rbUWFA
         yHvpZpxUMMVv2gwsX4ECDginY2iMe31VYazlXD56irYZ/9U5bHgTO4oGiLQrknjPFQ/c
         x8GH9678R/Pvd3BYlu0nwJ+N+KTVqxQxLOm8iE5czFQUHT4O5LsJYikxPwmiXMUIoOr6
         IHLenztb5+ToVMLJHtTCxMsq78pjfey5R3k4OM7r7Z1cLMj0xMnGrs4ohsD/Vr6g6g1v
         GLQZlFIyEL2V3FAr6IeJrvC5yv/x8pxCznBFFavVk2ZdyYNDks79VMo63lxr9gDklOVY
         WFrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783030323; x=1783635123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRUmP52vY013mSbfIXwpgJp8jMWEcHcxvZP2AdpKO8Y=;
        b=HnBzeJa+7ByXjtu0FVuEhedqtxJn/a9Li6qe1Ybv24vUHEoUiu7IMPvWmECGaifF9d
         glCmQYlQk/0fY5j7tjKwA0crtEaV/xn9JXkSnv3X8OViFZi00NI3UaJ6AePC5nbeHJtI
         6ENWvn4pgbTJFSHUxf4o42yutWttEtEhFHrshil+/y+ehxcRnKjEJ0XCiEu4Ra5ssqQZ
         fEHxAXCaCtL/TqrLPb/zOWQR+RCauH/UGa8qBTh5A1nV/+0fDXIjDOFp0PBFfY3s4gu4
         0dJ7NGmb8//TfPyOsCqYK0QsdQmtvFltDOIUvmk2opO/oMqT9WEQi9BM3PdfsA09n9Y5
         NRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783030323; x=1783635123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRUmP52vY013mSbfIXwpgJp8jMWEcHcxvZP2AdpKO8Y=;
        b=P1LsWq99EKdO98MKpjWEp8eCNmHPNIdgjLfgnyL7ZAdturuYzXcfFAQNso5ocOpINq
         d6ZN9rlpu3zjT5j0EPejSVAu9yt8Q7+QmVIXqv23JitC6h0eci1s4BOzjLpeMfEpwaZe
         aIhjJrrLyMSZe0JMWhurhqMyIhuPrH/S+QKHlxa22BudP1klkvwY1CiKSyheABqU4zlW
         +IGKjH47OAHEXYcbnjLNpQQj2EtpBAJzmjAOkszA4QiCtdZg8BlYIykJpp/nSIuEcaYw
         uvUGxS0BN8BYcz/noyD2ITosZdeR0l22OdnnfogPqYYUrRrnIBOmEp8PnvbUiIMNjh2Y
         c3ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sfdR8zL+Xjue2GLEJG2v5XjHRWoykEgc55u7NuhWm/SBv/BvhBUnbsdiVtvVuTb/y/w+35iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUghB+wgh6gCYnd7T1rq5By9E4ZPpXHJ36jhs7WgCvP+ShBrGd
	NbtDtOZJfr/AxoHP8dHkwMarDNH4IaLgfob1vn0lH03y9bsMJYNbsPCTwwPtuav+nuf0tfm0lyD
	8yBBetOxFFqr91DVLjro5yJ06HBjc/+528pVpYLnp
X-Gm-Gg: AfdE7cmXOShkyrXKvG2wZh/NMQu72oaU9B/315fpGqV41I+xMxTYuFemkZhs1xzs/JX
	RhZ5gRyvuz2Ic+CYVoPaIE+sMeoEVpCYkGGlKDqZS6GKGvT/m2wP2zDh7/qmsxuFvVOEr0wQD5p
	ASyJ9Aa9BQWB6QoSVPEd1hjBzT2dMzVRQYvWH7f6/BJBu5Ude+sQPeObqQSJyPr0JXwuY1tBT+/
	hkxtBMjGWr17TsbZElF5musAjwqxWswuf8tA7KloIGkv88T0odf9gUEwm4MVVNjEVCa9ga4uMoF
	YbBYWxtQSolHkMv0IJnOZ5HRG78=
X-Received: by 2002:a05:6a20:6a09:b0:3bf:bde7:d671 with SMTP id
 adf61e73a8af0-3bff40ed566mr8240013637.20.1783030323272; Thu, 02 Jul 2026
 15:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702185805.615241-1-xmei5@asu.edu> <aka5pwAGGI56QrrS@strlen.de>
In-Reply-To: <aka5pwAGGI56QrrS@strlen.de>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 2 Jul 2026 15:11:52 -0700
X-Gm-Features: AVVi8CcGXAKI5XA8PqeMzxoh9pZd4KHMe8lq3zXn7qz1OYTUA3EyYNQ_TL4QT5g
Message-ID: <CAPpSM+RshE2OFZCJjM0mRumWt3cixu9QBNh+rmS0z=AKPR25LQ@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: policy: use hlist_del_init_rcu in
 xfrm_hash_rebuild to avoid bydst poison
To: Florian Westphal <fw@strlen.de>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-304279-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A8CE6FD26D

On Thu, Jul 2, 2026 at 12:19=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:
> > xfrm_hash_rebuild() unlinks each policy from its bydst chain with
> > hlist_del_rcu() and re-inserts it. For an inexact policy the re-insert =
goes
> > through xfrm_policy_inexact_insert(), which can fail on a GFP_ATOMIC
> > allocation; on failure the error path only WARN_ONCE()s and continues, =
so the
> > policy is left with a poisoned bydst node (LIST_POISON2). The next rebu=
ild
> > calls hlist_del_rcu() on that node again, dereferences the poison, and =
takes a
> > general protection fault.
> >
> > Use hlist_del_init_rcu() instead, so a failed-reinsert node is left unh=
ashed
> > (pprev =3D=3D NULL) rather than poisoned. The next rebuild's hlist_del_=
init_rcu()
> > is then a no-op for it, and the non-failing case is unchanged.
> >
> > The reinsert allocation is GFP_ATOMIC (it runs under xfrm_policy_lock),=
 so in
> > practice this is only reached under memory pressure; the crash below wa=
s
> > reproduced deterministically by forcing that allocation to fail with fa=
ult
> > injection (failslab).
> >
> > Crash:
> >   Oops: general protection fault, probably for non-canonical address
> >   0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead00=
0000000127]
> >   ...
> >   Workqueue: events xfrm_hash_rebuild
> >   RIP: 0010:xfrm_hash_rebuild+0x5b3/0x1190
> >   RAX: dead000000000122   (LIST_POISON2 + offset)
> >   ...
> >   Call Trace:
> >    hlist_del_rcu (include/linux/rculist.h:599)
> >    xfrm_hash_rebuild (net/xfrm/xfrm_policy.c:1365)
> >    process_one_work (kernel/workqueue.c:3322)
> >    worker_thread (kernel/workqueue.c:3486)
> >    kthread (kernel/kthread.c:436)
> >    ret_from_fork (arch/x86/kernel/process.c:158)
> >    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> >    ...
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype=
")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > ---
> >  net/xfrm/xfrm_policy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index 7ef861a0e823..2612a405542b 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -1362,7 +1362,7 @@ static void xfrm_hash_rebuild(struct work_struct =
*work)
> >               if (xfrm_policy_is_dead_or_sk(policy))
> >                       continue;
> >
> > -             hlist_del_rcu(&policy->bydst);
> > +             hlist_del_init_rcu(&policy->bydst);
>
> This patch is dubious.  I looks to me as if it papers over the
> actual bug.
>
> Why is there a memory allocation error?
>
> The first loop -- before unlink -- is supposed to preallocate the new
> bins and chain heads.
>
Agreed, and my patch hides it instead of avoiding it. The problem is
the prep loop's guard is inverted:

        if (policy->selector.prefixlen_d < dbits ||
            policy->selector.prefixlen_s < sbits)
                continue;

That skips exactly the policies reinserted via the tree (prefixlen <
threshold =3D> policy_hash_bysel() NULL =3D> xfrm_policy_inexact_insert()),=
 and
preallocates for the exact ones instead, which never allocate and get
pruned again at out_unlock. So the inexact bin/node is allocated GFP_ATOMIC
after the hlist_del_rcu(), and that's the failure the WARN catches.

The reproducer lowers then raises the threshold so those bins are pruned
and reallocated during reinsert; failslab just makes the failure
deterministic, OOM would do the same.

v2 inverts the guard so prep prepares the set that's actually reinserted:

        -       if (policy->selector.prefixlen_d < dbits ||
        -           policy->selector.prefixlen_s < sbits)
        +       if (policy->selector.prefixlen_d >=3D dbits &&
        +           policy->selector.prefixlen_s >=3D sbits)
                        continue;

Then inexact_insert() finds bin+node present and allocates nothing, so the
reinsert can't fail; a prep failure still hits goto out_unlock before any
unlink. hlist_del_rcu vs _init_ then no longer matters.

---
  net/xfrm/xfrm_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7ef861a0e823..932a313b9460 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1329,8 +1329,8 @@ static void xfrm_hash_rebuild(struct work_struct *wor=
k)
                        }
                }

-               if (policy->selector.prefixlen_d < dbits ||
-                   policy->selector.prefixlen_s < sbits)
+               if (policy->selector.prefixlen_d >=3D dbits &&
+                   policy->selector.prefixlen_s >=3D sbits)
                        continue;

                bin =3D xfrm_policy_inexact_alloc_bin(policy, dir);
---


I checked the new patch on the reproducer, and the crash can't be triggered=
.
If you agree with this new patch, I'll send this as v2. I can also share
the reproducer if you need that to do further checks.

Xiang


Xiang

> This is also why there is a WARN. No memory allocations are supposed to
> occur after the hlist_del_rcu(), there is supposed to be a guarantee
> that the insertion succeeds.
>

