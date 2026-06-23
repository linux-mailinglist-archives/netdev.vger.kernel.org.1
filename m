Return-Path: <netdev+bounces-301386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gPEuCAaROmoTAQgAu9opvQ
	(envelope-from <netdev+bounces-301386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:58:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6106B7AD0
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:58:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nx9Iy8F2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301386-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301386-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11257302067A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C3937F001;
	Tue, 23 Jun 2026 13:58:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481A37EFFC
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:58:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223106; cv=pass; b=HONn3Yl6bw43gTCFAoQghuZfpWRGqAfm+0R1C4Z6JtaZ9WkzCX6Nboo5BJ5x1Mmf/05e7mwgArRBMy8TMmG2wQJO0xh9uYfAz6CNUHFfZt+2JtrBAL8QR1M6EAC7AkVofqDzgk3E7vzQcGsWMYt7Mmas5GThw7tH++Nw0Kt9Vr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223106; c=relaxed/simple;
	bh=rh2JvUQrRbIgKmsRJ2EnnJPgdrFOwYmoISZA3/WKYOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIa8ouQt+zWchKhD9oiW9rgOvpRVAEDo1ty5ThaxUfoKexLCwMu6tq3wG4GT091iyzmQPT3CN6hJ3S80Yyr9YL+ff/Y2tBcTl81W28uSQiMlk1gtsQ+4gbj5XPQmHNPn+O2Ucz6eQpRfmAISQhPjkKtBdBdcbXbQfaNO2wT798M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nx9Iy8F2; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51a019e9ea9so40808641cf.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 06:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782223104; cv=none;
        d=google.com; s=arc-20240605;
        b=Oumlt2dKy8obbdvXqe/lIoepqQi4ZBaRskwElZKiZRwKiUsfBG3j4z7CDmHSrNS3E/
         n3Ja15sscLrfjpIQwI14unY23YfKWI2TgGGVZP7quf7A5IPcLz9Liow5Wx8U1QW/2A7S
         4bbWgZGA/lQowl5co9ivwdus6gYopAc3HTpLsGK7xAKeha+KVIOpxNonznAUzqEjEf1v
         EDaOLSQ7n9hQWh1U7cqqUD8j7AqA1FBnfS5rTQTZxMWTN4oeWOA1CgXysU63mYkKtx5G
         js/lERLGZAm9478OMSr1r36xvLEOBt5YI6eXa6KydptuwP/We4B6ulURaDi4ewsipzX7
         1CHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bk1FoSzeXQoU6F3hJVsuuFmJHfrlyI6SLZGX5A7jkkw=;
        fh=YU7NAIdU8hBv8TzL2Ea85SP8Bln9WFVggKPYKTKxH8Q=;
        b=XWREXzDySk/su858LfF2STtybupoRcmz2rCgon5Y7bFk7G0E0+zoKZ2afGTTgQNXc8
         +rmiqkoo55z1UgQGvAsQf9uSLbNsl9jGo1ikf2LLtKH0E/HPhaINeoAoP3estMfuzYiU
         015IRK2xLzbjjmen9RSgB3gKppnvo6KCSCuUNy4BOvCi2O9UuXms+q81/oZxsr05xyG2
         nadCZbjc3krPk2SxkxMAfJug/8lpQH+mgcDI4dJKJnVvuW0GvHJRDn0xrl4bs1wDAm0p
         Gf+4+Iq/SnUO0uTo6CZp4anuT9cxB5ddCn3le4IeRb0MXOyIkWwLOtuc5wyg/JIMGkJp
         nhNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782223104; x=1782827904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk1FoSzeXQoU6F3hJVsuuFmJHfrlyI6SLZGX5A7jkkw=;
        b=nx9Iy8F27W/tGCBMXEJny9Nn3u4wr8PwY4SXJQTwAK8n33BW1wnGUBfdtTe2kb1xPZ
         OzF7BxJcZjbzO2iuJ1qTe+ivYqi8Dk2TaWMja11tDspo2SPQW3LbEbWnBJx9KWhGbqjZ
         B/nv4vXV67ByQl85r4F71xTPPHJa0Z2Dr4bBCtHh+ttDt4U+MlfcfQGbrodKxecng3GN
         oVhEWsyIWUclqZZP5nEg60EuciELWFmsdzzEOoDPYNO0DYI7gPgQA2xW3C7vy3UrIrOE
         oHeB6Bw5jOAvFolmwVmHpFObMJXWkCncnp233FOzrLSe7ko8pjWgMf4ylXX+O8539EhS
         GKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782223104; x=1782827904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bk1FoSzeXQoU6F3hJVsuuFmJHfrlyI6SLZGX5A7jkkw=;
        b=annovdafGZiDV6pfqP+pPHvh8b4Pfm0wM5v71slRcXD7BptnllHR25bItuopoE8WL6
         vrXGVv3pgDsbnr4zoc5JHbzMFUBjOprxEmpe7Wb3lsdEGXcrLsbkWJG+mTHAo/nq7Cv/
         oWkwY9pX7vQX+88PLKS5FHd9XHQzhZv0ukW+Afc22H3SsQo2uctdH3l3VMxSh+YDbBRZ
         x3uaSJ/hAdqDOfo8f5d38OLx1iTH/dG9PYfJQJZhIlcNNbOJf8iYOE0DoO4UqyoRuanh
         gaUgmpaiZlfgG5PoIITx83MiTUA7t3ByUu5vO/o4aD5YZ6hZISMqt/rrPttvlsydhWwD
         ED7A==
X-Forwarded-Encrypted: i=1; AFNElJ+33Y+x0m5BfWnzkn0o3AB+o+U3XkVjUdiPSvkeT096/kjJaSpppqPw/KgDKiPtnVPVBwDc4Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SCaAcco4w2UFgf2UHaTTSCnYHR0qILp5Bhj4uYuuSRQcufWH
	At1phi3qZDSQ6Rl1YPROuaxv1A1/QgnqR2J6hpeYT+XJLqzy7nxYEZFGo/b9AL1P4k3m8qX84+7
	62MeQ2+0fEt3+RiMo05a8EjumOexjoGXKjLID0O7u
X-Gm-Gg: AfdE7ck41OKH2Sm0UebBOjJzhZf8EfKGC/iT04reCphzxg2Oux5J/Q9B67jpfoFiG8Y
	04zgAy+b06ex32rkN9VB7PGIqahirIxV+A2cKjAAaikQ8Sn+IbfqQVbiuTO0XKoki/0vBx+9hdn
	n8OTNtycsIdeqyoKJRx2t0Pd52d6+MVNpcqyeMFnwUbuG7Q6t2kzeno60HphKsej85ztGujaHpZ
	YSB3LIqyBfsxOxT3KOqIxEdVL4xJc8R5yEBTBuli5PLwCwJYBFtuaMBz8SQ4wwz9BVCDPR1NoFH
	bREtlTT5aN1aFyMscV3uZKT7CZtNTeg8r9DO38aO7qONw8O5RMa2PWYDgsLG0FMEduAkduYrEPo
	RayGHrV+G
X-Received: by 2002:a05:622a:1e12:b0:517:88a0:9b2e with SMTP id
 d75a77b69052e-51a066c34c9mr229152691cf.4.1782223103567; Tue, 23 Jun 2026
 06:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622171048.1626022-1-edumazet@google.com> <CADvbK_e_7184a_jm5ASjKafXrJqaOKFUKJF6V1wp7AnFxK596g@mail.gmail.com>
 <CANn89iKFj9vSS6B-=KAMnLyqFqY5edZ-eChfcq+SuGckU6T9yg@mail.gmail.com>
 <CANn89i+dkbrSAwvaWXW7yWMfcwUebuTBLG5T7AGZaZcpVYGyfQ@mail.gmail.com> <CADvbK_cMHtBFGb87P6CoqJN+DCasn_5=RwtNhymdZ6p1eFnjuQ@mail.gmail.com>
In-Reply-To: <CADvbK_cMHtBFGb87P6CoqJN+DCasn_5=RwtNhymdZ6p1eFnjuQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jun 2026 06:58:11 -0700
X-Gm-Features: AVVi8CcCk3OSnGqeVKVE9b-UbPubLKJrzNPx8vVlpI-MradkaPpV8T8WwoIE8CQ
Message-ID: <CANn89iLOUWwECfTyiPbk--nqNo=tbshZbYAS9Zy_9OFNdpADoA@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
To: Xin Long <lucien.xin@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301386-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com,m:jon.maloy@ericsson.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,ericsson.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,e14bc5d4942756023b77];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB6106B7AD0

On Tue, Jun 23, 2026 at 6:56=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Tue, Jun 23, 2026 at 2:35=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Jun 22, 2026 at 10:37=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Mon, Jun 22, 2026 at 6:48=E2=80=AFPM Xin Long <lucien.xin@gmail.co=
m> wrote:
> > > >
> > >
> > > > Could this corrupt the list for concurrent RCU readers?
> > > > When list_del_rcu() is called, it intentionally leaves the next poi=
nter
> > > > intact so concurrent readers can continue their traversal. However,=
 the
> > > > immediate call to list_add() overwrites both the next and prev poin=
ters
> > > > to link the entry into private_list.
> > > > If a concurrent reader is currently positioned at rcast, won't it f=
ollow
> > > > the newly clobbered next pointer and jump from the original RCU lis=
t
> > > > directly into private_list?
> > > > Because private_list is allocated on the local stack, the reader mi=
ght
> > > > interpret stack memory as a struct udp_replicast. Furthermore, the =
reader
> > > > would miss its loop termination condition because it expects to rea=
ch the
> > > > original list head, potentially resulting in an infinite loop or a =
crash.
> > > > [ ... ]
> > >
> > > I think you are right.
> > >
> > > Considering there is already one rcu_head in udp_replicast I will use=
 it in V2.
> >
> > While looking at many syzbot reports with RTNL pressure. I found this
> > gem in  tipc_exit_net()
> >
> > while (atomic_read(&tn->wq_count))
> >       cond_resched();
> >
> > On some kernel builds cond_resched() can be a NOP, so we might loop
> > here for a while :/
> >
> True, thanks for the report,
>
> I think a cleanup_wq should be added for 'ub->work' instead of using syst=
em_wq,
> and then do flush_workqueue(cleanup_wq) in tipc_init_net().
>

 I will send a series of 2 patches.

Second one looks like:

More complex stuff can be added later in net-next.

commit 2f6b56e70f7048a9a2577715b8cfdb0ec94c2469
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Jun 23 06:48:33 2026 +0000

    tipc: avoid busy looping in tipc_exit_net()

    Blamed commit introduced a busy-wait loop in tipc_exit_net()
    to wait for pending UDP bearer cleanup works to complete:

           while (atomic_read(&tn->wq_count))
                   cond_resched();

    This loop can busy-wait for a long time if cond_resched() is a NOP. Thi=
s
    typically happens if the netns exit is executed by a high priority task=
,
    or under kernels configured without preemption (CONFIG_PREEMPT_NONE). I=
n
    such cases, it wastes CPU cycles and can lead to soft lockups.

    Fix this by replacing the busy loop with wait_var_event(), allowing the
    thread to sleep properly until the work queue count reaches zero.

    Accordingly, update cleanup_bearer() to use atomic_dec_and_test() and
    wake_up_var() to wake up the waiter when the count drops to zero.

    This uses the global wait queue hash table, avoiding the need to bloat
    struct tipc_net with a wait_queue_head_t. The atomic_dec_and_test()
    provides the necessary memory barrier to ensure the wakeup is not misse=
d.

    Fixes: 04c26faa51d1 ("tipc: wait and exit until all work queues are don=
e")
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Cc: Xin Long <lucien.xin@gmail.com>
    Cc: Jon Maloy <jmaloy@redhat.com>
    Cc: tipc-discussion@lists.sourceforge.net

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 1ddecea1df6e9100334c47a28ff6c065292fb9ad..315975c3be8186784e9c44c9ff6=
9d62c17ffd4b9
100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -45,6 +45,7 @@
 #include "crypto.h"

 #include <linux/module.h>
+#include <linux/wait_bit.h>

 /* configurable TIPC parameters */
 unsigned int tipc_net_id __read_mostly;
@@ -118,8 +119,7 @@ static void __net_exit tipc_exit_net(struct net *net)
 #ifdef CONFIG_TIPC_CRYPTO
        tipc_crypto_stop(&tipc_net(net)->crypto_tx);
 #endif
-       while (atomic_read(&tn->wq_count))
-               cond_resched();
+       wait_var_event(&tn->wq_count, atomic_read(&tn->wq_count) =3D=3D 0);
 }

 static void __net_exit tipc_pernet_pre_exit(struct net *net)
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 66f3cb87a0aaaac8f40e8f237ab9a44d539b1cd8..62ae7f5b58409c89798c915dee7=
52ac42487581f
100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -40,6 +40,7 @@
 #include <linux/igmp.h>
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <linux/wait_bit.h>
 #include <linux/list.h>
 #include <net/sock.h>
 #include <net/ip.h>
@@ -830,7 +831,8 @@ static void cleanup_bearer(struct work_struct *work)
        synchronize_net();

        dst_cache_destroy(&ub->rcast.dst_cache);
-       atomic_dec(&tn->wq_count);
+       if (atomic_dec_and_test(&tn->wq_count))
+               wake_up_var(&tn->wq_count);
        kfree(ub);
 }

