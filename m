Return-Path: <netdev+bounces-260036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN3LApVYnGkAEQQAu9opvQ
	(envelope-from <netdev+bounces-260036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:39:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 829151770F3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC028302A7B5
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DBF218E91;
	Mon, 23 Feb 2026 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MWqNoOT0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4951E834B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853928; cv=pass; b=ZvujB6BM3mhwkL1cao3FNwBnIztUpNIhE9YvN7upy26p6lZqYDcle96WQLG7LSqDX89axqmhNV2/t1wmyhE+m+AKID5/5IrhVnmXFQjAZfo6by6+uByIqkub1JzQOsO7GJC7mBn9V9atwAk7guJUkKzezwmN8PQ14kv5q3lti1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853928; c=relaxed/simple;
	bh=S4lFjQaSGlg1lS+TEpbgnOltoHuapaMvNQyfxUz713w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3pXTVOyzAlsIaB9yXBTF5Wwff5giUMryJw/n1oCfeXg58oX507vzX6LTm5aXl7zACSd042ylpA0QKltIMRi3u8E2N9yTo+eZz9fwPxyRsNXKbqMk0oRzrpze+He6fhvmlhpzoQG2R411hbiE1G/nWo/BgStz6gXwKp80Idstqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=MWqNoOT0; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82318702afbso3991372b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 05:38:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771853926; cv=none;
        d=google.com; s=arc-20240605;
        b=fye3OWDqQvGpo5aibBCx7ziifJw0r0CSwVTxpghSzKnOm60YTaTZWHcvYNZZm5G/ol
         5Hq5ZUGMNp6bKEBSg1MlIeVTtjbeJqouE4MC4deAMrZJSgleyxR7cuKdFKCawuwvyHAk
         fWS5vYYPLZwM+UiMpgKVz5zzsd9MUUKgqV7vQuvvxe9sJcPoeC4kO1pZYLtSfxoCEoRW
         S79PuW6d4un1+5Usxhy7L2JEgnVHc7MMUFq/wy3XFK8tsLCaeqCPWGI+aNbYvvl+O0+W
         pun/N6lCgYS7SkFnJvHI98VV+jI9LEhpFDXsSdoABedsAfoiHj3uP7J6YLdZM7iSU+2o
         zGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XKOZN3uWc3BNbuYEOvKeegPOFJeQZgqrunx5GZ7JRc4=;
        fh=WboAxardEv8hjAjkt4R1zZ8nCz1odhj71MoMPXjtR8k=;
        b=lP3gfo33OFqSGc8VpstGXbbHPs6e7aXa9ttJdW4N9nbfFqktDac/bg0SeUh2bBYXxx
         l9kj7I6EWHB6KgpVqkgtZuiA88/PQg0yFfMveP0lcoHcutB/zFCafJbjU4NupKhlw1hM
         1lK1rQjyAZe4gRCFaoUvJBD6LPRuchnPX7OF/eZu4s64u+tS7FEAyGaN7FYxvzoAJOWG
         8XxQK5ITd+KsFaIw2I9OmwzvFea/DVc4vIfPZV5o+ojMY66vu4C5BOGJHblI5StKIw83
         OFR9OBA3itk5Qthp8qHreGyVlv4j3BDwV1cScn474Wp7/kWdNiBvuATEdj0DAOvTatUk
         /fEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771853926; x=1772458726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKOZN3uWc3BNbuYEOvKeegPOFJeQZgqrunx5GZ7JRc4=;
        b=MWqNoOT0WHFFz+w6ejkQ6DU8px4GKJo50274CHkYHj1fnjdVmyCR/QwXekCykLW+38
         E77aS4uwJhzPgELrNbvt5e2pgio3Z3YWaE3ebTnHwf7PdydwedgD+nV4dRWo6esCsDxP
         FQfOgv0arxwJSY/dcb1S8/o9kQy9ojyemHgTlUqcpIA+dSBhymARs6xpy4r2MDOehKHC
         vigT+5KFjbEg5s1kjMpk1Q6OkMMF6RRJQ4TjzS4xxYQA2nYsgFDndJP3PQeh2zQrz7e3
         FKjg9S7VmJ8vNjpxVn+AxQ7V6Z5uwxK9GVWHestAaPvQTKf/W+3+T+BTI2PmF2N2IbUl
         MYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771853926; x=1772458726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XKOZN3uWc3BNbuYEOvKeegPOFJeQZgqrunx5GZ7JRc4=;
        b=SVg8YC+gmpvfP9K1vMFQ1dP4+lBfCE9lk/uikUccTFkgB+jXHyeTrOqbjAfAzeLlXu
         b53QMKaNMGxED8CIck+fA2KCNfeBDoxibm6OsZ5DxjeRfypbRbdWzApDX1r4uEqzREzE
         0nQ7wgZKw6fucqxnewL57o4rlU11KRRFJx2/7owomEEL1b27l3YCbHOT8S3cxlFAl6Oj
         VJCVa7IlNaDBshlAJKtAbpJX61C+rTNjTNAscrRz4ogX51GwShEvVcAhQJgvibjrPwTk
         v4j86PPFefsOPiv8KVAxhuceGiZRFv0qzlhWQi4io6p4/g2vbzPiC2oJdTXgU8U5fOjC
         D6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVaijVCCVsjMgFTvwjvyL79g08EGUrkaXeECwhlxY3YKCfEPxZ3X9Yme9BkvkW0AJzn7W6I0hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOdAKwIHX3pirWP9A420n9dTf92t91egzlpCHLV9YacyyUB5g
	rQSbdaDyHvb6EDYqsxr8MVXLfx9sNmxlRKXUwqPqyCIvWBntQ5A2lLowjhZQYJYK+ROE7mYV1je
	+FaETBlCCjqs9vG3naKWRMXSw6e1hiWuT8KdYYV+G
X-Gm-Gg: AZuq6aJHDwYjCi6STrEHKjlhPt7RbiZXv83ZDQcGSHn3j2NOMWjByq8X4xSxuLn09Jl
	KXE3h8sK/svCiGe97ac3AC9qdcEh4+NlxIUsLR4Mtb3YXtoLYwK/PYtGoOxilHndrMyda/0LXVo
	zOrY2JpSXrLsXg7gHMAtD1wEu93dUXwg2kJbKrV5vfxm48c5nOBDljcyTILle94rz2prPxF+R5N
	kFnKEE2FP9B6EM8DqoDROLZvhNzXHhwVNgn2b291YzrXKyMuIG+HaYiMUThd9Ri+wmVpeK7lSs+
	xeeB4ZeUTTGD48j04MMLk0sisQ==
X-Received: by 2002:a05:6a00:1583:b0:824:4a22:ec16 with SMTP id
 d2e1a72fcca58-826daa042eamr6893598b3a.34.1771853925606; Mon, 23 Feb 2026
 05:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirffHzSjmjNGx1ZU+JNLmrUYWEukrPAP5nTbJdemn6MZGyQ@mail.gmail.com>
In-Reply-To: <CAGfirffHzSjmjNGx1ZU+JNLmrUYWEukrPAP5nTbJdemn6MZGyQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 23 Feb 2026 08:38:34 -0500
X-Gm-Features: AaiRm53gQfQHUt4ZsvXGs_tUP6nz0iJ1CDQfGs3HmbGVgylsl2sA2-uxujKXoFw
Message-ID: <CAM0EoMkpOd0ZJwsSUa-diuMtDOoOuGcNDyYtdhmjYcCe+jw9Qw@mail.gmail.com>
Subject: Re: [BUG] general protection fault in qfq_qlen_notify
To: GangMin Kim <km.kim1503@gmail.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	kuba@kernel.org, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Manas Ghandat <ghandatmanas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260036-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,resnulli.us,kernel.org,vger.kernel.org,redhat.com,googlegroups.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 829151770F3
X-Rspamd-Action: no action

Hi,

On Sun, Feb 22, 2026 at 8:27=E2=80=AFPM GangMin Kim <km.kim1503@gmail.com> =
wrote:
>
> Dear Linux kernel developers and maintainers,
> Using a modified version of syzkaller, I identified a new bug and
> refined the PoC, and the bug-related information is attached
> below.Please let me know if you need any further information.
>
> Summary
>
> A NULL Pointer Dereference occurs because there is no proper check for
> whether cl is NULL when a class is found via cops->find() and then
> used in cops->qlen_notify().
> This description provides an explanation and KASAN report for
> qfq_qlen_notify, but the vulnerability can occur in various other
> places such as drr_qlen_notify, hfsc_qlen_notify, htb_qlen_notify,
> etc.
>

This is a duplicate of the issue reported by Manas Ghandat
<ghandatmanas@gmail.com> on the 17th.
We are still looking at best way to resolve this issue.

cheers,
jamal

> Keywords
> - net/sched
>
> Kernel Info
> Version: (Output of /proc/version)
> - Linux version 7.0.0-rc1
> Commit: (Git hash if applicable)
> - 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
>
> Description(Root Cause)
>
> ```c
> void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
> {
>     const struct Qdisc_class_ops *cops;
>     unsigned long cl;
>     u32 parentid;
>     bool notify;
>     int drops;
>
>     drops =3D max_t(int, n, 0);
>     rcu_read_lock();
>     while ((parentid =3D sch->parent)) {
>         if (parentid =3D=3D TC_H_ROOT)
>             break;
>
>         if (sch->flags & TCQ_F_NOPARENT)
>             break;
>         /* Notify parent qdisc only if child qdisc becomes empty. */
>         notify =3D !sch->q.qlen;
>         /* TODO: perform the search on a per txq basis */
>         sch =3D qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
>         if (sch =3D=3D NULL) {
>             WARN_ON_ONCE(parentid !=3D TC_H_ROOT);
>             break;
>         }
>         cops =3D sch->ops->cl_ops;
>         if (notify && cops->qlen_notify) { // [1]
>             /* Note that qlen_notify must be idempotent as it may get cal=
led
>              * multiple times.
>              */
>             cl =3D cops->find(sch, parentid); // [2]
>             cops->qlen_notify(sch, cl); // [3]
>         }
>         sch->q.qlen -=3D n;
>         sch->qstats.backlog -=3D len;
>         __qdisc_qstats_drop(sch, drops);
>     }
>     rcu_read_unlock();
> }
> ```
>
> When condition [1] is satisfied, cl is retrieved at [2] and then
> passed to [3]. Here, [2] can return NULL, and using this value at [3]
> can cause a NULL Pointer Dereference.
>
> ```c
> static unsigned long qfq_search_class(struct Qdisc *sch, u32 classid)
> {
>     return (unsigned long)qfq_find_class(sch, classid);
> }
>
> static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
> {
>     struct qfq_sched *q =3D qdisc_priv(sch);
>     struct Qdisc_class_common *clc;
>
>     clc =3D qdisc_class_find(&q->clhash, classid);
>     if (clc =3D=3D NULL)
>         return NULL; // [4]
>     return container_of(clc, struct qfq_class, common);
> }
> ```
>
> When QFQ is configured, the above function is executed at [2], and
> NULL can be returned at [4].
>
> ```c
> static void qfq_qlen_notify(struct Qdisc *sch, unsigned long arg)
> {
>     struct qfq_sched *q =3D qdisc_priv(sch);
>     struct qfq_class *cl =3D (struct qfq_class *)arg; // [5]
>
>     if (list_empty(&cl->alist)) // [6]
>         return;
>     qfq_deactivate_class(q, cl);
> }
> ```
>
> If NULL is returned at [2], that value is passed directly to [3],
> which becomes cl through [5]. Subsequently, a NULL Pointer Dereference
> occurs at [6].
>
> Kasan Report
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc000000000b: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
> CPU: 0 UID: 0 PID: 377 Comm: test Not tainted 7.0.0-rc1 #54 PREEMPT(full)
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:qfq_qlen_notify+0x2e/0x180 net/sched/sch_qfq.c:1434
> Code: 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 4c 8d 7b 58 e8
> e3 b3 8a fd 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> 02 00 0f 85 f8 00 00 00 48 8b 43 58 49 39 c7 0f 84 b9 00 00
> RSP: 0018:ffff88811a447258 EFLAGS: 00010212
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff83e2af6d
> RDX: 000000000000000b RSI: 0000000000000000 RDI: ffff88811b524000
> RBP: ffff88811b524000 R08: 0000000000000000 R09: fffffbfff0d3595c
> R10: ffffffff869acae7 R11: 00000000ac3123a9 R12: ffffffff859b0b60
> R13: ffffffff859b0b40 R14: 0000000000000000 R15: 0000000000000058
> FS:  00007ff24e5da700(0000) GS:ffff88834ad0d000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff24e6e95f0 CR3: 000000011a5ff000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __qdisc_qstats_drop include/net/sch_generic.h:958 [inline]
>  qdisc_tree_reduce_backlog+0x128/0x400 net/sched/sch_api.c:812
>  tbf_offload_graft net/sched/sch_tbf.c:191 [inline]
>  tbf_graft+0x1cc/0x590 net/sched/sch_tbf.c:573
>  qdisc_refcount_dec_if_one include/net/sch_generic.h:152 [inline]
>  qdisc_graft+0x2ef/0x1460 net/sched/sch_api.c:1117
>  __tc_modify_qdisc net/sched/sch_api.c:1631 [inline]
>  tc_modify_qdisc+0xf4f/0x1e40 net/sched/sch_api.c:1819
>  rcu_read_unlock include/linux/rcupdate.h:883 [inline]
>  rtnetlink_rcv_msg+0x3b9/0xa90 net/core/rtnetlink.c:6913
>  netlink_rcv_skb+0x12e/0x390 net/netlink/af_netlink.c:2539
>  kfree_skb_reason include/linux/skbuff.h:1322 [inline]
>  kfree_skb include/linux/skbuff.h:1331 [inline]
>  netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
>  netlink_unicast+0x6c1/0x970 net/netlink/af_netlink.c:1344
>  netlink_sendmsg+0x79c/0xc50 net/netlink/af_netlink.c:2465
>  __sock_release net/socket.c:673 [inline]
>  ____sys_sendmsg+0x8b2/0xa50 net/socket.c:690
>  sendmsg_copy_msghdr net/socket.c:2621 [inline]
>  ___sys_sendmsg+0x120/0x1c0 net/socket.c:2642
>  __sys_sendmsg+0x147/0x1f0 net/socket.c:2681
>  arch_atomic64_read arch/x86/include/asm/atomic64_64.h:15 [inline]
>  raw_atomic64_read include/linux/atomic/atomic-arch-fallback.h:2583 [inli=
ne]
>  raw_atomic_long_read include/linux/atomic/atomic-long.h:38 [inline]
>  atomic_long_read include/linux/atomic/atomic-instrumented.h:3189 [inline=
]
>  unwind_reset_info include/linux/unwind_deferred.h:37 [inline]
>  exit_to_user_mode include/linux/irq-entry-common.h:296 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:327 [inline]
>  do_syscall_64+0xf1/0x530 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff24e7c4e4d
> Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ca ee ff ff 8b 54
> 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 fe ee ff ff 48
> RSP: 002b:00007ff24e5d9d90 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff24e7c4e4d
> RDX: 0000000000000000 RSI: 00007ff24e5d9dd0 RDI: 0000000000000003
> RBP: 00007ff24e5d9e30 R08: 0000000000000000 R09: 0000000000050000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffcdc50ddde
> R13: 00007ffcdc50dddf R14: 00007ff24e5d9fc0 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:qfq_qlen_notify+0x2e/0x180 net/sched/sch_qfq.c:1434
> Code: 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 4c 8d 7b 58 e8
> e3 b3 8a fd 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> 02 00 0f 85 f8 00 00 00 48 8b 43 58 49 39 c7 0f 84 b9 00 00
> RSP: 0018:ffff88811a447258 EFLAGS: 00010212
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff83e2af6d
> RDX: 000000000000000b RSI: 0000000000000000 RDI: ffff88811b524000
> RBP: ffff88811b524000 R08: 0000000000000000 R09: fffffbfff0d3595c
> R10: ffffffff869acae7 R11: 00000000ac3123a9 R12: ffffffff859b0b60
> R13: ffffffff859b0b40 R14: 0000000000000000 R15: 0000000000000058
> FS:  00007ff24e5da700(0000) GS:ffff88834ad0d000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff24e6e95f0 CR3: 000000011a5ff000 CR4: 0000000000750ef0
> PKRU: 55555554
> ----------------
> Code disassembly (best guess):
>    0:   41 57                   push   %r15
>    2:   41 56                   push   %r14
>    4:   41 55                   push   %r13
>    6:   41 54                   push   %r12
>    8:   55                      push   %rbp
>    9:   48 89 fd                mov    %rdi,%rbp
>    c:   53                      push   %rbx
>    d:   48 89 f3                mov    %rsi,%rbx
>   10:   4c 8d 7b 58             lea    0x58(%rbx),%r15
>   14:   e8 e3 b3 8a fd          call   0xfd8ab3fc
>   19:   4c 89 fa                mov    %r15,%rdx
>   1c:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   23:   fc ff df
>   26:   48 c1 ea 03             shr    $0x3,%rdx
> * 2a:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping
> instruction
>   2e:   0f 85 f8 00 00 00       jne    0x12c
>   34:   48 8b 43 58             mov    0x58(%rbx),%rax
>   38:   49 39 c7                cmp    %rax,%r15
>   3b:   0f                      .byte 0xf
>   3c:   84                      .byte 0x84
>   3d:   b9                      .byte 0xb9
> R13: ffffffff859b0b40 R14: 0000000000000000 R15: 0000000000000058
> FS:  00007ff24e5da700(0000) GS:ffff88834ad0d000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff24e6e95f0 CR3: 000000011a5ff000 CR4: 0000000000750ef0
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception in interrupt
> Kernel Offset: disabled
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

