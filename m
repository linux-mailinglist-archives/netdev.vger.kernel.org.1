Return-Path: <netdev+bounces-300188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bEl2EOOpMmqg3QUAu9opvQ
	(envelope-from <netdev+bounces-300188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:06:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 383DD69A685
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:06:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cbWLDWE9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300188-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300188-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D38713006081
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B5413235;
	Wed, 17 Jun 2026 14:06:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C1407CEF
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:05:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705160; cv=pass; b=XthCpLVAKIyQrZAlflw05tnsWPaZhsuMqiv1pefsYIi2/oZixIPbGuJT7DrpxIX45Xt5DvyVQRoH4YgmcNEfARThz/07r4+aL3e+8k41kqxbjY4hIDTLM20T51zJlx+BWZrldN3sGVQXOgDubA/l67GROB8Xfjdn298ZQzidQBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705160; c=relaxed/simple;
	bh=QPSJz6yVUwUC1Pb6WAtfAZDgopyNKfAk3M4AFDT90D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mClDY/hskxFKnvLS3k+EJWNmesppLXzszwvLBEm5b6NEuwgbBnxJMvZ9BTh2gJypSrVnslr7O3THyLEUIkaC/PtN9Z/gOIE63XJendKGynn3mUiVSHos/dIMThm+XToi3OFB9AOfOfcbxJQdvqPcN67Y/dfdfZhHhJ/YuFXrT24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbWLDWE9; arc=pass smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9159951f05aso636940385a.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 07:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781705158; cv=none;
        d=google.com; s=arc-20240605;
        b=jnvkv5I5ipWEWhmoEK6vZzW5kB7PdPnvBXPPIabZMYqTyZ+GgsPKjOk49hPktBdTVH
         t0IZk9cJGlD3THPOe/1PGq0pQ4kJJKBb2r/D65PjkLh9Bc3Ldk70XPFQHs8MPcgRotO1
         fhXELPt//rfUC77vmPjEKr4KSdRzWMOCe8nHOLRp9i0n8sv59lUdZ1ka5n+LGPAnoGQX
         jzdlJ47igVGfAjR9K0zdtwfm/XH9Nw+Gv5k44vnG2Ae8RWS8d0jvdt0J947NCaqlV0FT
         ED7+0Qmp+hKwyxFwL9Iu8kNVNVm5E1V65XU1bP5RrlPsVYLVseosZteAibPYo/EZWmEP
         4QaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H+v2CZNbB4tdwrJn77/mVXfgTe1oI147fw1mwWS61iQ=;
        fh=jGPp/+glYyZsjoMRvdsbaKo9CVjJ3GYVYbNTQgkpbqY=;
        b=kHBUdO4LN0sNqikR6o0ynCMtSnY/wLozOvDvOrpDlx0VcCl13JBxTL6FdeGjdbnr3W
         hYfTN3BnAEkZ9I21JaLkGp6khB4+Zhofh5HEQwUX2cyqeQs8t1by6wASjnQMKKmX1ygX
         rFW5rqX2wWnATUUk/P++mMRv4o1Z+n+IgjVl2l0znEEjrLEptSGdxH6Cw4RVsbPZp5xl
         JKp+4cLiQZq+BNzY08ywV0hyysqcAFkqOSXTYuHSMfUFElcqso8Iw8hTK7s11gltaY/D
         wgtK5LDT/WBm+0ZMFHdIEMgFgVmwVnS2fykipLgah70OS6V1fOhOnMrh4JlisrnHWnr1
         dJdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781705158; x=1782309958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+v2CZNbB4tdwrJn77/mVXfgTe1oI147fw1mwWS61iQ=;
        b=cbWLDWE9LwA/WrdK6/O+zBlNrwuJIzfvZNFfDWyCAEDaOuN5GSyTX5FSz3Jum0cf20
         LUEDm1UjCPdrUmbRpDr+acmRQqKJys/BT1K9+EOgsEBY7jt0DGmtbSEP/e0CVP1VN++T
         0j+aRrIftOTEHoOdVqowGQfq93RgWP0yq/E4hiVk85DL44s2PCCDjSw94QvYpND11YyN
         EXMMHqPuaRzxHf00W8EqbjIZH4KH6dKJlQsAj1bgpJs/IjklCR10Zh3Af+HfEDwqlFcl
         kA7ajuZR8I9PPgsNMWMdH8FwuBVIIVVRcx5se/h+as+DgkmNbp574Jins77p4fmHyk8C
         7Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705158; x=1782309958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+v2CZNbB4tdwrJn77/mVXfgTe1oI147fw1mwWS61iQ=;
        b=c5LJTmR3Z+UhnrWkQQgeL4ohZYETESHe313eQ/Z0SKZoypiWXQmjv/JenGpsIC3asE
         7YKKBqw2VeF+LgVn5BKIlz22ljEt4TMrUiDZnJl5KEtvDR05L/iYyTaP/baUxH7rQhSm
         3kiJocjeB/61ksKtXj6OP6QDB4XiGKqxzBeKX6xruooIfRSPOl9rKCXlCT9GFlbF/H7k
         o3IV/z3oMax3CZXJElq/kC58Ms6yDFi0d+6urvObcwhko3+xr70WUbaNnNiVLAp50j8b
         s4t1cMRjekJpLgnJG0+YLfb978Iz6VD1Dii1k3PPdMfmgNpc4PbQok1c0/C69MCsXO+E
         ziSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zbALF/vD/KFWJMLeagysdiBNy9cGGfBPD6gsXl/f7ydSWc63iZ1pdw0JeJADVOwHpSAntTEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhyVom1FFMeEhXpFjO3jKZiW7c2VIPWuRWJosJLotBt/mD+Rax
	xFXDS6+gkkMSg1NXDZA7MVr0qEQ3m2lpVL/w7AxyN2thhbhCO4g/xAgUzWuMVl4XJ8N2cKzWWuP
	7V/9ASuCTEqq8hZrHJ4bHsmKWQmUA56WtEfAYwNFi0Q==
X-Gm-Gg: Acq92OE7tFny7B4GdN2/uFs06jrrot8/rwiRQ2Gg9mxKHzWGSnKM1X6uX7LP0rD7KR2
	70bJJVAaBOjATUt5i4+0qxfqF+AnYB8hbRrQPP69lNS9vUcbQ2UJaNQy7AHNBljJBIdcrSGWCNh
	xI4cPoChhes4Qk68l4T80m+Y56ICpNAnOfA4XjD9ajLiG6IlYH6CdRzBQyXss9B3naASdFeyWos
	UnjlRf7HubGmrOtRgpiUGRyCqZ1g60Uo/d5vErM21wVeQJ8Br0EQM+WZaBuwI4MOYzXuS5G5P4W
	St3uB8AieUAF0xmfV547VHuld2IWGUZwMOTHGMtq
X-Received: by 2002:a05:620a:f0c:b0:914:bd3f:b6db with SMTP id
 af79cd13be357-91db94953damr555556485a.10.1781705158285; Wed, 17 Jun 2026
 07:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616122246.3136462-2-bestswngs@gmail.com> <GV1P189MB1988614C09148258A9844D0CC6E42@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988614C09148258A9844D0CC6E42@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 17 Jun 2026 22:05:19 +0800
X-Gm-Features: AVVi8Cc8qL3QsASNLi_Fl8twRg7ywlXpYrXPe7RM0PXMGQxFOZCEghhRMPkAA9o
Message-ID: <CANgPUi0FViehjC9WGZmZ724-QGGvG2MkybZaEPDU4v1VEa-r7w@mail.gmail.com>
Subject: Re: [PATCH net v2] tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "jmaloy@redhat.com" <jmaloy@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "xmei5@asu.edu" <xmei5@asu.edu>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:jmaloy@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:davem@davemloft.net,m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300188-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,est.tech:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 383DD69A685

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B46=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=B8=89 16:47=E5=86=99=E9=81=93=EF=BC=9A
>
> >Subject: [PATCH net v2] tipc: fix use-after-free of the discoverer in
> >tipc_disc_rcv()
> >
> >bearer_disable() frees b->disc with tipc_disc_delete()'s plain kfree(), =
but
> >tipc_disc_rcv() still dereferences b->disc in RX softirq under
> >rcu_read_lock() (tipc_udp_recv -> tipc_rcv -> tipc_disc_rcv).
> >
> >L2 bearers are safe thanks to the synchronize_net() in tipc_disable_l2_m=
edia(),
> >but the UDP bearer defers that call to the
> >cleanup_bearer() workqueue, so the discoverer is freed with no grace
> >period:
> >
> > BUG: KASAN: slab-use-after-free in tipc_disc_rcv (net/tipc/discover.c:1=
49)
> >Read of size 8 at addr ffff88802348b728 by task poc_tipc/184  <IRQ>
> >  tipc_disc_rcv (net/tipc/discover.c:149)
> >  tipc_rcv (net/tipc/node.c:2126)
> >  tipc_udp_recv (net/tipc/udp_media.c:391)
> >  udp_rcv (net/ipv4/udp.c:2643)
> >  ip_local_deliver_finish (net/ipv4/ip_input.c:241)  </IRQ>  Freed by ta=
sk 181:
> >  kfree (mm/slub.c:6565)
> >  bearer_disable (net/tipc/bearer.c:418)
> >  tipc_nl_bearer_disable (net/tipc/bearer.c:1001)
> >
> >The bearer is freed with kfree_rcu(); free the discoverer the same way.
> >Add an rcu_head to struct tipc_discoverer and free it and its skb from a=
n RCU
> >callback.
> >
> >Because the RCU callback (tipc_disc_free_rcu) lives in module text, a
> >call_rcu() that is still pending when the tipc module is unloaded would =
invoke a
> >freed function. Add an rcu_barrier() to tipc_exit() after the bearer sub=
system
> >has been torn down, so all pending discoverer callbacks have run before =
the
> >module text goes away.
> >
> >Reachable from an unprivileged user namespace: the TIPCv2 genl family is
> >netnsok and its bearer commands have no GENL_ADMIN_PERM. Needs
> >CONFIG_TIPC and CONFIG_TIPC_MEDIA_UDP.
> >
> >Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address has=
h
> >values")
> >Reported-by: Xiang Mei <xmei5@asu.edu>
> >Assisted-by: Claude:claude-opus-4-8
> >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >---
> >v2:
> > - split the over-80-column container_of() line (Tung Quang Nguyen)
> > - add rcu_barrier() to tipc_exit() so a pending call_rcu() cannot fire
> >   into freed module text after rmmod (Eric Dumazet)
> >
> > net/tipc/core.c     |  3 +++
> > net/tipc/discover.c | 14 ++++++++++++--
> > 2 files changed, 15 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/tipc/core.c b/net/tipc/core.c index
> >434e70eabe08..747328e58d30 100644
> >--- a/net/tipc/core.c
> >+++ b/net/tipc/core.c
> >@@ -218,6 +218,9 @@ static void __exit tipc_exit(void)
> >       unregister_pernet_device(&tipc_net_ops);
> >       tipc_unregister_sysctl();
> >
> >+      /* Wait for tipc_disc_free_rcu() callbacks queued from module tex=
t. */
>
> Please change above comment to: /* TODO: Wait for all timers that  called=
 call_rcu() to finish before calling rcu_barrier() */
>
> Note that call_rcu() are used in discover.c and node.c. So, the TODO comm=
ent helps we add more checking code later in another patch.
>
> >+      rcu_barrier();
> >+
> >       pr_info("Deactivated\n");
> > }
> >
> >diff --git a/net/tipc/discover.c b/net/tipc/discover.c index
> >3e54d2df5683..696b7a8ed54d 100644
> >--- a/net/tipc/discover.c
> >+++ b/net/tipc/discover.c
> >@@ -58,6 +58,7 @@
> >  * @skb: request message to be (repeatedly) sent
> >  * @timer: timer governing period between requests
> >  * @timer_intv: current interval between requests (in ms)
> >+ * @rcu: RCU head for deferred freeing
> >  */
> > struct tipc_discoverer {
> >       u32 bearer_id;
> >@@ -69,6 +70,7 @@ struct tipc_discoverer {
> >       struct sk_buff *skb;
> >       struct timer_list timer;
> >       unsigned long timer_intv;
> >+      struct rcu_head rcu;
> > };
> >
> > /**
> >@@ -382,6 +384,15 @@ int tipc_disc_create(struct net *net, struct tipc_b=
earer
> >*b,
> >       return 0;
> > }
> >
> >+static void tipc_disc_free_rcu(struct rcu_head *rp) {
> >+      struct tipc_discoverer *d =3D
> >+              container_of(rp, struct tipc_discoverer, rcu);
> >+
> >+      kfree_skb(d->skb);
> >+      kfree(d);
> >+}
> >+
> > /**
> >  * tipc_disc_delete - destroy object sending periodic link setup reques=
ts
> >  * @d: ptr to link dest structure
> >@@ -389,8 +400,7 @@ int tipc_disc_create(struct net *net, struct tipc_be=
arer
> >*b,  void tipc_disc_delete(struct tipc_discoverer *d)  {
> >       timer_shutdown_sync(&d->timer);
> >-      kfree_skb(d->skb);
> >-      kfree(d);
> >+      call_rcu(&d->rcu, tipc_disc_free_rcu);
> > }
> >
> > /**
> >--
> >2.43.0
>

Hi
Sent v3. Thanks for the review.

Best,
Weiming Shi

