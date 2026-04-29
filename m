Return-Path: <netdev+bounces-282300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMtANiXC8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB849137C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB7683057C72
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC63B27FA;
	Wed, 29 Apr 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJI/M43M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032D3B19D7
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451365; cv=pass; b=YmIhlc2syaqnbHjjMvRl5cJIVAr5gHTjNwjlKEef/Dze0ucbjMzPc3xWG451KiTnYqbL4gKd/SJ5pvE35oDDi5zDRswo+YYob8ffQZea9bF/+KJ+Of6l+/M9Lyil4qJHqmAduxgvoaAwMclI/QNV0f49eDJQU/SLYXWdxmZjTAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451365; c=relaxed/simple;
	bh=/Gwm6v/TijAsffL2OxDtjOUdBTDbHCA9DZqpqs3v1rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loMqUtsIM399uz67A0pgsoNaoYX6wRnw8bvKzNO0IeZtMN0CwkluRgOg4tfrHGDCMCtjou5NGHtdRNzAMIQ2RQg0letpps2M+0efta+cvMNopXFlE3dWz+KDAgotF+sS6KbCOeQNG2CJYfYiuzceXx+wwUT0lXkPaBQRrQZ/86c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJI/M43M; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66ba9dfe83bso15335875a12.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777451362; cv=none;
        d=google.com; s=arc-20240605;
        b=M5vvNSPIaoi4HYh2Y6jORqX2Ia4vpsJgonf8arBfrq0lz9O568fITgZbDjX+LCMbE2
         imy0kguEv75y1YFJ7CXrCVaZoyIk9c5ic0CuwqbpIhWmb/JJ7HMhBEjNKnpHk6IL9czb
         MbyhbsI3WDpBxDA3gIzlmENGiOKt1KFJrYDe3YFKdwQnY1M2Zd3xi9oDIoUJWfTY+nI4
         tpe7itxQt7hLIq/Yah72hkVTzIEY4d2lmnRRKRu9Mxnorhn0lsVd0ihhr1dAzfcopjjm
         cfxvhj/4sYPp49CQZxyXPA4lGVue9A/+gnnP11qcxjxo4/0veMVpI1M8wSXSZN1Sf/Jp
         v/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zG15aGf0OE+kY43cX7iltj+gfDWHix1TD45tz4xvz3g=;
        fh=YM51lkGkELBPHe2P7CjRCMKDnkQ8LerNEGmeN/AJaS4=;
        b=SUnrgj6IzobY09uhtAdNLvfCIWB2zzZYkG2o7+UzDxmvd2bVAcuub5z2dVDuXVyHYK
         zCBJyAOhOVDXfxYeVq0sYcujEAKYTO0jXOo7GTlMxfxaRF5c780aDGhfoyS6YS0YILg2
         2CNxe39qRo7p947303svZmG5yEzCcQXxS0j7u1LjbwSDtz5hbRP+xSgdgHhyDvlTJXcd
         DK42MFNfzTFOQzr3i08ZbgrZ3vFMzZ0CMI1Rw+lk28eKZFpmb4ILndSNA1NyINtEzXqr
         p3AeUCHlFIKWIwfqyRtozAZV3BmsixEdKA6nAamAA+pOq0JaXPWGqxUztlwybtVNUdoF
         Sliw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777451362; x=1778056162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG15aGf0OE+kY43cX7iltj+gfDWHix1TD45tz4xvz3g=;
        b=eJI/M43MdSFA42iBw3LhW0gYxnPQYtaplpVyvffn8tOIZK0BGz1ijtv4tjStAM6E0A
         Iq7ceW9MSidfXv8sH/CnzQf4tPVmOcwYRoXtXEbWpamU9ehUk9lMsqtC+bKQymck1lEf
         Ng/Zh1ccvZ7U3hThAi1hKJ3sL3WNk8YdhHT54UTbcsihXcZi1ae7WZsa8k8hiDXe4dyN
         bW9oKv/gflJsi6eD32DUtWwTiuA1E3rDERXWNMqx2k3CsOfLV0jRT+lEbUJg6uTYJVax
         vxnUuyfwPKT3iitOEXXgeJo9e+2sz4d+dySsQnBH/3P5VhqegQHHpF6xItzjOSHaKwS0
         x8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777451362; x=1778056162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zG15aGf0OE+kY43cX7iltj+gfDWHix1TD45tz4xvz3g=;
        b=Zylsv9nDs6akIu3xKABH1zLG7t3tlTdfCsDAkTSrSNp3qidbMbjYNG73ULRYitMFTg
         QQrs4by1mlez803xENbK/9jEr6EGXWbgtzEesCJT0zVdcLFRccLwqcws+vIOzrNz/60x
         uz8o9IoyWwnYYAjtaCW2q6wVOKsl+irPYm9W7kTsGG7mcueaJzK0ge2E1OxgpYnAnc/o
         tZvfMb2hM49aJT0i4AX7vfZjjDV7P8WVsgLJLxlT6vDY8vEwmjESxOIox+Se+buIi+sY
         QxlEZLCtPsJLjA1w2/HKhOPZzXPtQk8xN/y7UV6RbcS2pxV0uGO21wJVhdClCGxFViJ7
         glfg==
X-Forwarded-Encrypted: i=1; AFNElJ+/O7MvHcnVRe7tLRb4EI2xAfqzFkxMbimB5/bQ7uRiO0BNV7OVpFPjG8e9SyUPqQVMTgUkGck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnlfnwPoAY+K4B9490MtdFJ/fQrbexXE+fRZ82d9vlfFZeLqV
	KvSotoeHBWaF/KYNQpLWeMszqA3SHmNllQ6w3vbKFv9mYcvd8xLRVG9FgH5Xo883FawnDtv36BX
	7tctgx8W1Ipa7jc2O5f+1IZwFDY9KDVA=
X-Gm-Gg: AeBDietBu1ct8AsaQpdvqlgbMCxOxZJluyDQHlPFoFzIHj+/AwfabLMhkrZbBbzN4X1
	u5zAV7yJUSa08FvIv0cnv65yr8QJ/9jsIcnkZp3T3RPzPc65alk7JzYwz6EOuZ5BytX10p9WQBS
	utx+yB8x1b696JgJx22WF3Jl6rHLFuh9hO+O7v/zbaJ+qfFsZVkN1PmxqAhomVYbQGOiP3566Rp
	ZW6xpevjvwAvKmfA3SgSzL3/7frPbJNxhY14nO9Ow8owS76ahLt+LY83R7G/UzGr6U9wGJQtRDG
	6qa/C71gMrBewVI/UMHZiA+SRb1/Um3XPcRI+/ogXWK0sVei8w==
X-Received: by 2002:a17:906:ef0c:b0:ba7:62f:9fa6 with SMTP id
 a640c23a62f3a-bb8018de3eemr369720766b.2.1777451361410; Wed, 29 Apr 2026
 01:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRy_Hg8O9smcwzWTdBn6j6NLwv+8vBXKtm2KTsOoG1CjxC2Dg@mail.gmail.com>
 <afGug2nzdfjEGHxO@secunet.com>
In-Reply-To: <afGug2nzdfjEGHxO@secunet.com>
From: Michal Kosiorek <mkosiorek121@gmail.com>
Date: Wed, 29 Apr 2026 10:29:10 +0200
X-Gm-Features: AVHnY4LqoTY5DkMiKXlxQ8n9WkREu7CVtiTGqR0WHoa-ov-VwakT5YntKk-n-_w
Message-ID: <CAFRy_HgkpfzxtJEJWRa=wfJ+m_++FbGsaezywRXQWt7uhkKoTQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm: protect __xfrm_state_delete against double-unhash
 of byseq/byspi
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, sd@queasysnail.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 75BB849137C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282300-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkosiorek121@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,secunet.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

v2 addresses your two points:
  - Added Fixes: tags (fe9f1d8779cb for byseq, 7b4dc3600e48 for byspi).
  - Rebased on ipsec.git master (HEAD fa90a3145c03), `git apply --check`
    clean. Same hunk applies to torvalds/master without changes.

Also added `Cc: stable@vger.kernel.org` per stable-kernel-rules.html
Option 1, since the Fixes: tags otherwise leave AUTOSEL doing the
disambiguation work alone.

Patch follows.

---

KASAN reproduces a slab-use-after-free in __xfrm_state_delete()'s
hlist_del_rcu calls under syzkaller load on linux-6.12.y stable
(reproduced on 6.12.47, also reachable via the same code path on
torvalds/master and on the ipsec tree). Nine unique signatures cluster
in the xfrm_state lifecycle, the load-bearing one being:

  BUG: KASAN: slab-use-after-free in __hlist_del
include/linux/list.h:990 [inline]
  BUG: KASAN: slab-use-after-free in hlist_del_rcu
include/linux/rculist.h:516 [inline]
  BUG: KASAN: slab-use-after-free in __xfrm_state_delete net/xfrm/xfrm_stat=
e.c
  Write of size 8 at addr ffff8881198bcb70 by task kworker/u8:9/435

  Workqueue: netns cleanup_net
  Call Trace:
   __hlist_del / hlist_del_rcu
   __xfrm_state_delete
   xfrm_state_delete
   xfrm_state_flush
   xfrm_state_fini
   ops_exit_list
   cleanup_net

The other observed signatures hit the same slab object from
__xfrm_state_lookup, xfrm_alloc_spi, __xfrm_state_insert and an OOB
write variant of __xfrm_state_delete, all on the byseq/byspi
hash chains.

__xfrm_state_delete() guards its byseq and byspi unhashes with
value-based predicates:

if (x->km.seq)
hlist_del_rcu(&x->byseq);
if (x->id.spi)
hlist_del_rcu(&x->byspi);

while everywhere else in the file (e.g. state_cache, state_cache_input)
the safer hlist_unhashed() check is used. xfrm_alloc_spi() sets
x->id.spi =3D newspi inside xfrm_state_lock and then immediately inserts
into byspi, but a path that observes x->id.spi !=3D 0 outside of
xfrm_state_lock can still skip-or-hit the byspi unhash inconsistently
with whether x is actually on the list. The same holds for x->km.seq
versus byseq, and the bydst/bysrc unhashes have no predicate at all,
so a second __xfrm_state_delete() on the same object writes through
LIST_POISON pprev.

The defensive change here:

  - Use hlist_del_init_rcu() instead of hlist_del_rcu() on bydst,
    bysrc, byseq and byspi so a second deletion is a no-op rather
    than a write through LIST_POISON pprev. The byseq/byspi nodes
    are already initialised in xfrm_state_alloc().
  - Test hlist_unhashed() rather than the value predicate for
    byseq/byspi, so the unhash decision tracks list state rather than
    mutable scalar fields.

Empirical verification: applied this patch on top of v6.12.47, rebuilt,
and re-ran the same syzkaller harness for 1h16m on a previously-crashy
configuration that produced ~100 hits each of slab-use-after-free
Read in xfrm_alloc_spi / Read in __xfrm_state_lookup / Write in
__xfrm_state_delete. After the patch, 7.1M execs across 32 VMs at
~1550 exec/sec produced zero xfrm_state UAF/OOB hits. /proc/slabinfo
confirms the xfrm_state slab is actively allocated and freed during
the run (~143 KiB resident), so the fuzzer is still exercising those
code paths -- they just no longer crash.

Reproduction:

  - Linux 6.12.47 x86_64 + KASAN_GENERIC + KASAN_INLINE + KCOV
  - syzkaller @ 746545b8b1e4c3a128db8652b340d3df90ce61db
  - 32 QEMU/KVM VMs x 2 vCPU on AWS c5.metal bare metal
  - 9 unique signatures collected in ~9h, all within xfrm_state
    lifecycle

Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
Fixes: 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI is zero to
the SPI hash.")
Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>
---
 net/xfrm/xfrm_state.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..686014d39429 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -818,17 +818,17 @@ int __xfrm_state_delete(struct xfrm_state *x)

  spin_lock(&net->xfrm.xfrm_state_lock);
  list_del(&x->km.all);
- hlist_del_rcu(&x->bydst);
- hlist_del_rcu(&x->bysrc);
- if (x->km.seq)
- hlist_del_rcu(&x->byseq);
+ hlist_del_init_rcu(&x->bydst);
+ hlist_del_init_rcu(&x->bysrc);
+ if (!hlist_unhashed(&x->byseq))
+ hlist_del_init_rcu(&x->byseq);
  if (!hlist_unhashed(&x->state_cache))
  hlist_del_rcu(&x->state_cache);
  if (!hlist_unhashed(&x->state_cache_input))
  hlist_del_rcu(&x->state_cache_input);

- if (x->id.spi)
- hlist_del_rcu(&x->byspi);
+ if (!hlist_unhashed(&x->byspi))
+ hlist_del_init_rcu(&x->byspi);
  net->xfrm.state_num--;
  xfrm_nat_keepalive_state_updated(x);
  spin_unlock(&net->xfrm.xfrm_state_lock);
--=20
2.54.0


=C5=9Br., 29 kwi 2026 o 09:08 Steffen Klassert
<steffen.klassert@secunet.com> napisa=C5=82(a):
>
> On Tue, Apr 28, 2026 at 09:53:45AM +0200, Michal Kosiorek wrote:
> ...
> >
> > Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
> > Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
> > Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>
>
> Please add a 'Fixes:' tag so the patch can be backported
> to the stable trees.
>
> > ---
> >  net/xfrm/xfrm_state.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -758,16 +758,16 @@ int __xfrm_state_delete(struct xfrm_state *x)
> >
> >   spin_lock(&net->xfrm.xfrm_state_lock);
> >   list_del(&x->km.all);
> > - hlist_del_rcu(&x->bydst);
> > - hlist_del_rcu(&x->bysrc);
> > - if (x->km.seq)
> > - hlist_del_rcu(&x->byseq);
> > + hlist_del_init_rcu(&x->bydst);
> > + hlist_del_init_rcu(&x->bysrc);
> > + if (!hlist_unhashed(&x->byseq))
> > + hlist_del_init_rcu(&x->byseq);
> >   if (!hlist_unhashed(&x->state_cache))
> >   hlist_del_rcu(&x->state_cache);
> >   if (!hlist_unhashed(&x->state_cache_input))
> >   hlist_del_rcu(&x->state_cache_input);
> >
> > - if (x->id.spi)
> > - hlist_del_rcu(&x->byspi);
> > + if (!hlist_unhashed(&x->byspi))
> > + hlist_del_init_rcu(&x->byspi);
> >   net->xfrm.state_num--;
> >   xfrm_nat_keepalive_state_updated(x);
> >   spin_unlock(&net->xfrm.xfrm_state_lock);
>
> This does not allpy to the ipsec tree. Please
> rebase on the ipsec tree and resend.
>
> Thanks!

