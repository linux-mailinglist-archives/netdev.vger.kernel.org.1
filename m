Return-Path: <netdev+bounces-279085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CaWKKcD4WmJoQAAu9opvQ
	(envelope-from <netdev+bounces-279085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:43:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D55411244
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6402430362D6
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6233E3E1210;
	Thu, 16 Apr 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="JfIyCbD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08AF3E277D
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354210; cv=pass; b=cYe1P52c0Jq985tSOX80fyOJmXqPPsBZQeNRcX/n1byvrcczmSmjlUxx0N1EDHfVQmQy2yef8DRptr/Eohd1EJgvXsBRV1hzgKWDlBJjB3wksGWyY7DPFSBl1ajya2mET7RObw7lgVJIiV1fIX+zQ34waVwoquugSmt8LmhgC0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354210; c=relaxed/simple;
	bh=0VCyFrzdlI8DAB9rJRvqOT1dzdyqklfkGuaVmllUeUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAT6PkSo+ahyGAVo+3eswqCQzlre8kITT2GLt12SQUmoOdkNMdvJrjJKyGZjvcmKa7+fkFhbXFfrqzjAALUbS4/KdiPtjG3LOBPrbg5AL4cRyGQt1RjRr9WUfITxU9EmyQaFdfbJo5hcCRCCByxoCy5K2mnwtSJPgL8vw/u24aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=JfIyCbD5; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f7c7ee9b8so416925b3a.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776354208; cv=none;
        d=google.com; s=arc-20240605;
        b=efJoNq+tlLGEFyDLwC3aTldxEviCPv+InpPG+3pD8rwv8STh2CBBx0+yD1OvaAJAdP
         HPHH7MHmrUghZU+rO7FulsTgomrL5q7WaMghAL4Mue+X6tCC0tJeovqGwXgior0YAaWI
         W3P6Id8tuEwH3btZiopT2V91g44MS4S0nUhJVrb1+xv6FO8TGKn+vNqKbMwQ187stMkK
         au/N7YuOv6ZwjD2gh2ZXdsZlQeYjhJXwqwqgkOcy7erECIH+oWhqX+MLcdXbsbF0AbTB
         quJmQJ6xM3yHfd/fndfP2TwvQtFAo9VTwLkTX1iwhaYf2G4fA0YUT4wHYW2iBL79EIVo
         NqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xILTL/bJwXqDhSjdlnz0vT3CFIMLB6bOGmZs24Ns6rM=;
        fh=3g3CmyZowwM4gdoaWVjxCV9mgfR8iYKMV/o9ewongrA=;
        b=CgMcaxfuAyj+csiJAKKninAMMJs92UjE6z619x4cYE0gAMWa2aLNQEMPzbT3ZF4ugv
         s1K6+jzJ/VKX2obu/MsPTgVZyEqQ7WZCrwFNDah6peVRKlRHqCcuuplJ3aCuFhFcdFxs
         KyVXDSD/LxO3Z40cLei8/y6ky/04ukLfN3qzwH4Hi1LLzRZI7Geoi9jHx7uTBMTeNZxp
         pAwgpSmcQt88VAiNNr8wCnQ7cBp4clYFjKOOQ3vlVHKMgKgkfTvGUKRrOXFsqNuNUrg7
         KKQACnuf22BxJ2dZ9MmbcPqcfQRrCEPOhcON/yZzzl5NLKKKRbrD5kpBywysT+YCVlIu
         VfhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1776354208; x=1776959008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xILTL/bJwXqDhSjdlnz0vT3CFIMLB6bOGmZs24Ns6rM=;
        b=JfIyCbD5CCdRbyaO4s1jcpEbTS6vbg8Qtn1EbImCoZJnx2jsA0+dk4ZqhfGTqGcoAk
         bdDtKAFQtP5OT1XEHdoJNYLFANbbLhEPAOEnWcHRsLWe/YLkZmxwqAhxkTLT3QdQ4zQd
         unZrAzdCQ7e88PGOobKFGAzSYaO3JnVrhNvVvt9cjZUSw/lnoAlejgLYkAheneMisl0Q
         Ch6ACaFOhXIYX/u5lU9+lVQXutj7iMETxmk9jItXMd9AgrQ9Z2FJ+OSPfYis3sdmIJVe
         byd0HstRMvqcX9FNtsjCKUkK77iPeBs0nuT//tgEqB0EnyZjeC9k05QfEZZ4jHxnPj9M
         64QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354208; x=1776959008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xILTL/bJwXqDhSjdlnz0vT3CFIMLB6bOGmZs24Ns6rM=;
        b=YH1tShaQS8mMuzZ4YZD8HpTSUIf8Nwyo74p5wuSUPdEYHER+XdXRxzHLKw7MeHyIZs
         /6RkxqwQNmaFWdGYXXJVGq4jglt9t6T+Bj1GHupNNIfEz8mU+EMprz+jJkO+7eqM1Y3h
         Zsv/llpGdZF9csCGz6fw8Tr36Sith6eRzfzKtjuL8AGFOWLd+7ElJ5U53/TWBL+Wa3oR
         ZANM5++6ZAbEWsBVy2E3dai8FFcCV+zI0tn6VI4tXmfR24sB/xco6gtFT2opKf+wWAHy
         ST9yVB6xr2lfEYleZnKqeDafgeGCP6fb5HKLtSqBhDnojyCYtkKapnLPtcfyp/tgeEwv
         3pRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9W7lEei4dVj6DZQGDmWqVtXRKoMJgUHmbmnMpCpxNCdeiXmWKk9SRCQ7AbJP8pRZCKF5jsrz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWDhrm1TssgXWee9qsrxc6H7DI8i+RvHRhIKA7yb+jjo7LyYRO
	Wscw0JfdG1WdU6oqSYPZDWWuCWHlgqxGaxGFONlS++I5XHGJ0us08bVZny/s1VCg4zuU8Buaeu9
	kFrtM9IQPtIfLt7AM5Mn03YosiUQ4uq19n8O2Uadg
X-Gm-Gg: AeBDieudlnO7etBrTJBYsQOgpIgE1I1sAM5v1U4OmZo7ZGwOMydSdmARSejZdLRaHVu
	86jZaIorhFgsgp1ulQOW7UcU9vqswC2WDyDG5tdqQSiUWHRlzAh8xvAxx1KqZ1ym+Hj+UI+m6xh
	mIDoNI1cfyuHLR82PkFnkyRvtJQpJg7OFZU2zR2YAc0mTqKHBOqfs2DNbS74OC6WYA00gCau2Sv
	IpRbsqRU/fp3r87K3MJvid0wPKvF+cBFTZyb22sPWZJS154GFP6Xjbtn3vJMvyilLjelwpndYt0
	F9GIx57t8kT9Y9KNm38=
X-Received: by 2002:a05:6a00:a223:b0:82f:6e7:1527 with SMTP id
 d2e1a72fcca58-82f0c18957amr25112917b3a.23.1776354208026; Thu, 16 Apr 2026
 08:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413094448.2263828-1-hxzene@gmail.com>
In-Reply-To: <20260413094448.2263828-1-hxzene@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 16 Apr 2026 11:43:16 -0400
X-Gm-Features: AQROBzC9xgboFKA_w7CsTLMJW7KHNWZnJyMUf6vlstEC3LDqYv4MjeJWBGIGu5A
Message-ID: <CAM0EoMndFM=JtsuP4ffM-YDphZ3gvW_=a5aTZmD62xPpCZY90w@mail.gmail.com>
Subject: Re: [PATCH] net: sched: teql: fix use-after-free in teql_master_xmit
To: "Kito Xu (veritas501)" <hxzene@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-279085-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 51D55411244
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 5:44=E2=80=AFAM Kito Xu (veritas501) <hxzene@gmail.=
com> wrote:
>
> teql_destroy() traverses the circular slave list to unlink a slave
> qdisc. It reads master->slaves as both the starting point and the
> do-while termination sentinel. However, the data-path writers
> teql_dequeue() and teql_master_xmit() concurrently modify
> master->slaves without holding RTNL, running in softirq or process
> context respectively. If master->slaves is overwritten to an
> already-visited node mid-traversal, the loop exits early without
> finding the target slave. The slave is never unlinked, but its memory
> is freed by call_rcu() -- leaving a dangling pointer in the circular
> list. The next teql_master_xmit() traversal dereferences freed memory.
>


Do you have a reproducer?
And it would be nice to get a tdc test from you.

Also, please use assisted-by: or even suggested-by if this patch was
suggested by AI.

cheers,
jamal

> race condition:
>
>   CPU 0 (teql_destroy, RTNL held)       CPU 1 (teql_dequeue, softirq)
>   -----------------------------------   -----------------------------
>   prev =3D master->slaves;  // =3D A
>   q =3D NEXT_SLAVE(A);      // =3D B
>   B =3D=3D A? No.
>   prev =3D B;
>                                          /* slave C's queue drains */
>                                          skb =3D=3D NULL ->
>                                          dat->m->slaves =3D C; /* write! =
*/
>
>   q =3D NEXT_SLAVE(B);      // =3D C
>   C =3D=3D A? No.
>   prev =3D C;
>   /* check: (prev=3DC) !=3D master->slaves(C)?
>      FALSE -> loop exits! */
>   /* A never unlinked, freed by call_rcu */
>
>   CPU 0 (teql_master_xmit, later)
>   -----------------------------------
>   q =3D NEXT_SLAVE(C);      // =3D A (freed!)
>   slave =3D qdisc_dev(A);   // UAF!
>
> Fix this by saving master->slaves into a local `head` variable at the
> start of teql_destroy() and using it as a stable sentinel for the
> entire traversal. Also annotate all data-path accesses to
> master->slaves with READ_ONCE/WRITE_ONCE to prevent store-tearing and
> compiler-introduced re-reads.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in teql_master_xmit+0xeae/0x14a0
> Read of size 8 at addr ffff888018074040 by task poc/162
>
> CPU: 2 UID: 0 PID: 162 Comm: poc Not tainted 7.0.0-rc7-next-20260410 #10 =
PREEMPTLAZY
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x64/0x80
>  print_report+0xd0/0x5e0
>  kasan_report+0xce/0x100
>  teql_master_xmit+0xeae/0x14a0
>  dev_hard_start_xmit+0xcd/0x5b0
>  sch_direct_xmit+0x12e/0xac0
>  __qdisc_run+0x3b1/0x1a70
>  __dev_queue_xmit+0x2257/0x3100
>  ip_finish_output2+0x615/0x19c0
>  ip_output+0x158/0x2b0
>  ip_send_skb+0x11b/0x160
>  udp_send_skb+0x64b/0xd80
>  udp_sendmsg+0x138c/0x1ec0
>  __sys_sendto+0x331/0x3a0
>  __x64_sys_sendto+0xe0/0x1c0
>  do_syscall_64+0x64/0x680
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> The buggy address belongs to the object at ffff888018074000
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 64 bytes inside of
>  freed 512-byte region [ffff888018074000, ffff888018074200)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
> ---
>  net/sched/sch_teql.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index ec4039a201a2..2e86397a5219 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -101,7 +101,7 @@ teql_dequeue(struct Qdisc *sch)
>         if (skb =3D=3D NULL) {
>                 struct net_device *m =3D qdisc_dev(q);
>                 if (m) {
> -                       dat->m->slaves =3D sch;
> +                       WRITE_ONCE(dat->m->slaves, sch);
>                         netif_wake_queue(m);
>                 }
>         } else {
> @@ -136,19 +136,23 @@ teql_destroy(struct Qdisc *sch)
>         if (!master)
>                 return;
>
> -       prev =3D master->slaves;
> +       prev =3D READ_ONCE(master->slaves);
>         if (prev) {
> +               struct Qdisc *head =3D prev;
> +
>                 do {
>                         q =3D NEXT_SLAVE(prev);
>                         if (q =3D=3D sch) {
>                                 NEXT_SLAVE(prev) =3D NEXT_SLAVE(q);
> -                               if (q =3D=3D master->slaves) {
> -                                       master->slaves =3D NEXT_SLAVE(q);
> -                                       if (q =3D=3D master->slaves) {
> +                               if (q =3D=3D head) {
> +                                       WRITE_ONCE(master->slaves,
> +                                                  NEXT_SLAVE(q));
> +                                       if (q =3D=3D NEXT_SLAVE(q)) {
>                                                 struct netdev_queue *txq;
>
>                                                 txq =3D netdev_get_tx_que=
ue(master->dev, 0);
> -                                               master->slaves =3D NULL;
> +                                               WRITE_ONCE(master->slaves=
,
> +                                                          NULL);
>
>                                                 dev_reset_queue(master->d=
ev,
>                                                                 txq, NULL=
);
> @@ -158,7 +162,7 @@ teql_destroy(struct Qdisc *sch)
>                                 break;
>                         }
>
> -               } while ((prev =3D q) !=3D master->slaves);
> +               } while ((prev =3D q) !=3D head);
>         }
>  }
>
> @@ -285,7 +289,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>         int subq =3D skb_get_queue_mapping(skb);
>         struct sk_buff *skb_res =3D NULL;
>
> -       start =3D master->slaves;
> +       start =3D READ_ONCE(master->slaves);
>
>  restart:
>         nores =3D 0;
> @@ -317,7 +321,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>                                     netdev_start_xmit(skb, slave, slave_t=
xq, false) =3D=3D
>                                     NETDEV_TX_OK) {
>                                         __netif_tx_unlock(slave_txq);
> -                                       master->slaves =3D NEXT_SLAVE(q);
> +                                       WRITE_ONCE(master->slaves, NEXT_S=
LAVE(q));
>                                         netif_wake_queue(dev);
>                                         master->tx_packets++;
>                                         master->tx_bytes +=3D length;
> @@ -329,7 +333,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>                                 busy =3D 1;
>                         break;
>                 case 1:
> -                       master->slaves =3D NEXT_SLAVE(q);
> +                       WRITE_ONCE(master->slaves, NEXT_SLAVE(q));
>                         return NETDEV_TX_OK;
>                 default:
>                         nores =3D 1;
> --
> 2.43.0
>

