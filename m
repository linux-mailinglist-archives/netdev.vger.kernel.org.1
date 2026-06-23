Return-Path: <netdev+bounces-301387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WDg8ELyWOmq4AwgAu9opvQ
	(envelope-from <netdev+bounces-301387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:22:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF046B7D7D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:22:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=d0TY2fLM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301387-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301387-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D280301DEEE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D00384CF6;
	Tue, 23 Jun 2026 14:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27878384CCB
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 14:22:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224561; cv=pass; b=NOjwwfyuYnmPjxteSHb3MU0HcKKQbjPar6Fa+jDFEv6K+1FkTYoC7a6IwzLYfYX3+Ae+h8RdRVPZPzQ2iAkfm0ftK3ITbpwkZm+lO1y0Pz9/WbD2wNeg9J2dihtbu5IzZVO+HRa795ZtjRBwYSVAQZh58WEKZy8JmBcmrIN8sbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224561; c=relaxed/simple;
	bh=6OuWNKXUjuJGgtstYVEf3air0BigVE0qUj/4sYp8Up8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTfUNVEOTRG9sV3GyeJzRjqisZGPLj4zx0VQMg9JmV4HkQ5lMBGWtwsOnQfx2aYZJJ3AExO1yCDmyziVwkvE1GMYbKW5IJI46A2r3gD9kWa4iSSFzoF0U/+cR9c6aZwNftKlNZ46j2qduJTgAzMZJ5vCuDClmfUqGfixDWG9gBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0TY2fLM; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84229481d44so2562367b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782224559; cv=none;
        d=google.com; s=arc-20240605;
        b=Qx3bXNiePWEEtxPuH3Dgr3ZHLEBsLKv8JMhhvWJydh+a/dU/c0Z4+hAs1phlNn1ufH
         l+uVNOU6RKGdufTgVET/BpNePW3CJVjvfmb5Ci+ewWWh56mxoLoFxKocieV63gIFCuGi
         qzuGzUqwP0HoDrNcmpmNz+rNP9M1tFIuHFiFFycMyj412WyH8m6YcKYvf/a5MnpCw44w
         kVILAjC8vWfEbdRL+3l7ZHjrbxIrmSB5fu1Z7X6dSxIcSvlKJ380pPL0tV8DgKVZc32i
         XsNEeP4Y1VKrfx2QKJxvjXg06vN5Zfm+7B+iOeEriJSB+3ZjU/w0YrFwrqY+6wi5ZIF/
         ePRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+cPfbh/CsU7TED7ItD4vJF/Q9AnwnYkUVn4tn9XieKE=;
        fh=K8tnaMzqLW4acSonRfVuPhvpDU3se+ynKWOLSBfyxA0=;
        b=bKS//1By2hmiw6gZw0MmdPo2njLfF2KgocgsV96tK5+1kTTlm/GFwRUCNXcVHMCyHP
         hhZFZ6HnrlIackQA+tfl8IJjD4Hxjs1k3HaE87ZZwccxh+T0cEhH8Ae6BGCUpYY/GkSO
         OhEBWAs6tctYWceCU74myKhLuA9XdFf8O9Ms9QWW1V8iu0LkPZgot++nVQxPQnc5BGax
         Mbz0f/XyoQu/VEMxMyDB0jzBZpdNqHZqx9Uzl9l+TvEBY5KFk77U3r4yw8Pr4F6qy1qo
         SNXDnuxiC1dZkYEvH+ga6mVMIwuezXp9xDz4QcHAQye1Ps/CxTaVIhY4CdbBe61mN4q5
         fjmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224559; x=1782829359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cPfbh/CsU7TED7ItD4vJF/Q9AnwnYkUVn4tn9XieKE=;
        b=d0TY2fLMTZ46c/LPN/7yHvvfdK1DmmnWOlZ7CDJ4dwSGMYnXZxd1UJB4sUKKiGD7hz
         NK6JCZD8qHWRXgXdR6AK4986h/0jzZj/GMEbts7LcL5N81Hk/KE1aw0mq81J0XjTP+pN
         EoSVawypyRX6Uv1o7Yo82TlV98bJPz+LFmWiQDd2f2PshNeWqC/YttI2XYVm+cIt1uYk
         hhi+trbZCfM8eSZdbY1XBGhwesyIvSi7wx24X8PcLjyiQCcYOwMpaCvzopIcE+Zb0lm0
         6VLh8Rk7CGjpZddmBHeAuA14DD1eJ91S/4GhSJcrTDmdz9uZQypLyNKhhneidSwPDuIw
         HP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224559; x=1782829359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cPfbh/CsU7TED7ItD4vJF/Q9AnwnYkUVn4tn9XieKE=;
        b=NMlx6vSukGDlQOexEoasGY6DufbW/9Gkf9LpJY1cUmpFbsgTdj0Y0yHfPqid/3CmSQ
         HhxA4JfdAyiadOlg6H9+k7vEPvXLJ7buEHB+QhbZeJt28NiAve1n8myZSL+mBMiesg80
         pv4DLEAuhsgjfQuQ9WJYcx88OZV6fDQiPxeCB3TS/SpCUwbRpEhwlZQnb/qm6jXuV0W1
         0KrAEWBG4Q97A/YmxsMfhjfoQLNCag/vF6fz6qMKUUscV2y+RIbT+XkbCpM8fHMnzA/n
         k8Oai8V7usdEOX368tyu02a6GnhZCLtoz00ChAjJv9PL4V4t5ybALappigTcpsIEPaHW
         wtMg==
X-Forwarded-Encrypted: i=1; AFNElJ/Uowhy61IT4w+5lxUHqKce9UKJ4R9KP34zdzvE8C8qdjlDrzdhCwnD1TEFsD3BN549vCwf0G4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BTLTpgMc/58+8qDHkUMPEBOsliG9YjqWTXNJFmxEVTnbmo2T
	nsj1UFP+i6rWY567koYuExBiVKMHvdakKPlnZePtH9vlePFtRwlFjajkW7fp693gI6jwpWbvfX8
	uDlVFvqSvlHPKHE+xkM//7vk2FTRUr4E=
X-Gm-Gg: AfdE7ckeXyRzj3lhGba9iXmLJo/kXxJQKRyvTboNhVEuewepJYviUKYrID+k6yY2278
	UQBvdgcWlWBh80wikbicqlHmnxq4X70opvvFrjncGFkaPMpi4lz0RgAzHcazChyo3GPTYn4lWaP
	nB78Sz0cj6RgOEWqAC/ojkSXzY1MZx866DvFj10pL2cMhG7aaHK+dXwAjM+oOIYSsbb2D8f02aq
	LStt0hSCJgDJ3tiGSjUxvIv6KhzDHNxmFLw2Oh86AoV1YhFr45LrmN6l/tJtlDtT9nY4tCNEH6F
	Byf+QpLNsa8WHQf0sCQfArHpMrQUT6xV/gT1PrtVQIs/ZsyU1rmgBwPL7dtM7waFYAEr4is=
X-Received: by 2002:a05:6a00:3cd3:b0:842:6a3b:60c9 with SMTP id
 d2e1a72fcca58-845970ed619mr3467557b3a.24.1782224559094; Tue, 23 Jun 2026
 07:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622171048.1626022-1-edumazet@google.com> <CADvbK_e_7184a_jm5ASjKafXrJqaOKFUKJF6V1wp7AnFxK596g@mail.gmail.com>
 <CANn89iKFj9vSS6B-=KAMnLyqFqY5edZ-eChfcq+SuGckU6T9yg@mail.gmail.com>
 <CANn89i+dkbrSAwvaWXW7yWMfcwUebuTBLG5T7AGZaZcpVYGyfQ@mail.gmail.com>
 <CADvbK_cMHtBFGb87P6CoqJN+DCasn_5=RwtNhymdZ6p1eFnjuQ@mail.gmail.com> <CANn89iLOUWwECfTyiPbk--nqNo=tbshZbYAS9Zy_9OFNdpADoA@mail.gmail.com>
In-Reply-To: <CANn89iLOUWwECfTyiPbk--nqNo=tbshZbYAS9Zy_9OFNdpADoA@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 23 Jun 2026 10:22:26 -0400
X-Gm-Features: AVVi8CdMIih0vJDwXMBVhvXhBnwXu5hRhfqx-J_XGJZGcJNJ4KQ3_VIqH1BRJcc
Message-ID: <CADvbK_cF2F-+trja9E1ahF1oQgdp+zk1bpi3vfgXeNJmjgkNdg@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com, 
	Jon Maloy <jon.maloy@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301387-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,ericsson.com];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com,m:jon.maloy@ericsson.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e14bc5d4942756023b77];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CF046B7D7D

On Tue, Jun 23, 2026 at 9:58=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jun 23, 2026 at 6:56=E2=80=AFAM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Tue, Jun 23, 2026 at 2:35=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Jun 22, 2026 at 10:37=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Mon, Jun 22, 2026 at 6:48=E2=80=AFPM Xin Long <lucien.xin@gmail.=
com> wrote:
> > > > >
> > > >
> > > > > Could this corrupt the list for concurrent RCU readers?
> > > > > When list_del_rcu() is called, it intentionally leaves the next p=
ointer
> > > > > intact so concurrent readers can continue their traversal. Howeve=
r, the
> > > > > immediate call to list_add() overwrites both the next and prev po=
inters
> > > > > to link the entry into private_list.
> > > > > If a concurrent reader is currently positioned at rcast, won't it=
 follow
> > > > > the newly clobbered next pointer and jump from the original RCU l=
ist
> > > > > directly into private_list?
> > > > > Because private_list is allocated on the local stack, the reader =
might
> > > > > interpret stack memory as a struct udp_replicast. Furthermore, th=
e reader
> > > > > would miss its loop termination condition because it expects to r=
each the
> > > > > original list head, potentially resulting in an infinite loop or =
a crash.
> > > > > [ ... ]
> > > >
> > > > I think you are right.
> > > >
> > > > Considering there is already one rcu_head in udp_replicast I will u=
se it in V2.
> > >
> > > While looking at many syzbot reports with RTNL pressure. I found this
> > > gem in  tipc_exit_net()
> > >
> > > while (atomic_read(&tn->wq_count))
> > >       cond_resched();
> > >
> > > On some kernel builds cond_resched() can be a NOP, so we might loop
> > > here for a while :/
> > >
> > True, thanks for the report,
> >
> > I think a cleanup_wq should be added for 'ub->work' instead of using sy=
stem_wq,
> > and then do flush_workqueue(cleanup_wq) in tipc_init_net().
> >
>
>  I will send a series of 2 patches.
>
> Second one looks like:
>
Cool, wait_var_event() looks better.

Thanks.

> More complex stuff can be added later in net-next.
>
> commit 2f6b56e70f7048a9a2577715b8cfdb0ec94c2469
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Jun 23 06:48:33 2026 +0000
>
>     tipc: avoid busy looping in tipc_exit_net()
>
>     Blamed commit introduced a busy-wait loop in tipc_exit_net()
>     to wait for pending UDP bearer cleanup works to complete:
>
>            while (atomic_read(&tn->wq_count))
>                    cond_resched();
>
>     This loop can busy-wait for a long time if cond_resched() is a NOP. T=
his
>     typically happens if the netns exit is executed by a high priority ta=
sk,
>     or under kernels configured without preemption (CONFIG_PREEMPT_NONE).=
 In
>     such cases, it wastes CPU cycles and can lead to soft lockups.
>
>     Fix this by replacing the busy loop with wait_var_event(), allowing t=
he
>     thread to sleep properly until the work queue count reaches zero.
>
>     Accordingly, update cleanup_bearer() to use atomic_dec_and_test() and
>     wake_up_var() to wake up the waiter when the count drops to zero.
>
>     This uses the global wait queue hash table, avoiding the need to bloa=
t
>     struct tipc_net with a wait_queue_head_t. The atomic_dec_and_test()
>     provides the necessary memory barrier to ensure the wakeup is not mis=
sed.
>
>     Fixes: 04c26faa51d1 ("tipc: wait and exit until all work queues are d=
one")
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Cc: Xin Long <lucien.xin@gmail.com>
>     Cc: Jon Maloy <jmaloy@redhat.com>
>     Cc: tipc-discussion@lists.sourceforge.net
>
> diff --git a/net/tipc/core.c b/net/tipc/core.c
> index 1ddecea1df6e9100334c47a28ff6c065292fb9ad..315975c3be8186784e9c44c9f=
f69d62c17ffd4b9
> 100644
> --- a/net/tipc/core.c
> +++ b/net/tipc/core.c
> @@ -45,6 +45,7 @@
>  #include "crypto.h"
>
>  #include <linux/module.h>
> +#include <linux/wait_bit.h>
>
>  /* configurable TIPC parameters */
>  unsigned int tipc_net_id __read_mostly;
> @@ -118,8 +119,7 @@ static void __net_exit tipc_exit_net(struct net *net)
>  #ifdef CONFIG_TIPC_CRYPTO
>         tipc_crypto_stop(&tipc_net(net)->crypto_tx);
>  #endif
> -       while (atomic_read(&tn->wq_count))
> -               cond_resched();
> +       wait_var_event(&tn->wq_count, atomic_read(&tn->wq_count) =3D=3D 0=
);
>  }
>
>  static void __net_exit tipc_pernet_pre_exit(struct net *net)
> diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> index 66f3cb87a0aaaac8f40e8f237ab9a44d539b1cd8..62ae7f5b58409c89798c915de=
e752ac42487581f
> 100644
> --- a/net/tipc/udp_media.c
> +++ b/net/tipc/udp_media.c
> @@ -40,6 +40,7 @@
>  #include <linux/igmp.h>
>  #include <linux/kernel.h>
>  #include <linux/workqueue.h>
> +#include <linux/wait_bit.h>
>  #include <linux/list.h>
>  #include <net/sock.h>
>  #include <net/ip.h>
> @@ -830,7 +831,8 @@ static void cleanup_bearer(struct work_struct *work)
>         synchronize_net();
>
>         dst_cache_destroy(&ub->rcast.dst_cache);
> -       atomic_dec(&tn->wq_count);
> +       if (atomic_dec_and_test(&tn->wq_count))
> +               wake_up_var(&tn->wq_count);
>         kfree(ub);
>  }

