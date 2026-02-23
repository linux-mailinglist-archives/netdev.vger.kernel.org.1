Return-Path: <netdev+bounces-260037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFmLFR5anGmzEgQAu9opvQ
	(envelope-from <netdev+bounces-260037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:46:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB199177323
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8CA63045C03
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90089221540;
	Mon, 23 Feb 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zXlappCN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA9221726
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854065; cv=pass; b=PdBEd3TwmhuWfGWSV6u2iIFxJJqg+Q8ZLH2HSD6w4TNMvElPLUrzGFJSNtJ9tVtUWt/CjCzSoe+SxQo/kPezuSlIcApksjBwCvtqbiALWfPAtgqMVhvwWJ+rsE5djktbmH9Xq663VhVrfvad7a5iaMt+2XM6zKUxvadJcHmDXzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854065; c=relaxed/simple;
	bh=/rDFSkyk9XDD6QnhOlAh/4Ojapy2eEuDhDWuh193Y38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRzjTOdeAoq/bI8dMAPd2h87loso6zySO6eDvcarxH5yByHN5Ot0jUrCEzh7KA6RLO0lyjZyXWUnUvRViVt1XT9YQ28MPcdRhPWgSqhORvoqcwzEZ3jY2yabB9ZHWNgdpxLWOCt0LeeAxESI7+NWm5dNzdqGonuHYlHoIz7agLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zXlappCN; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8249cb73792so3823675b3a.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 05:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771854063; cv=none;
        d=google.com; s=arc-20240605;
        b=fElRVdC4wIgCX2/g9TgrltgDgOtmCWvkzNPTheOwmxkAVRcBHELTfmcIWGGobMfISI
         kGsCtxpK6D2IeJp6B5S+W17b9FDEuiMM8Ln9lo4pWDaDTaXS/jUbeEN8B/6nJ7NB3WeN
         BDCO1vjF1lzVluwt4rRDEksI28+yiODZZxZE49XMHui0Zer2VT6DAcP0h8I2YL4qowH+
         O1o65T8TV6uBAn/j4gYGc5jHAWelrcTP8JwlciF5kTQc1QtDy03oQa+KuGNcz8QsQXA7
         8RRNU9gWEUjat/4gKSuw+6OKw76ZXF+F85FXFgcLTHXpF2UgYzbTM9Oi5Xs74bPdUJgA
         otZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MMsH9QLvKj5vXxSOfwujFHVAamnbIlrD7SVHZSgn1eY=;
        fh=tvqvJkdnUQVi9NGN6B1VadfIZaGGJMi9h7m+wE3SvCs=;
        b=eiFfLcmlA64ZEoTo5AQRNx1cPqL4OaCT01D7vEmXOiVrfwUKLoRjqglV2dWKIogSvx
         E0nmwmfmhbgz7eK6tjiEVx0n1RfVZIuiJIU6gHnFP1iupdc2qS7BPKyFaJRvN3nj8G+z
         YCPcxDUSHfzvxSSOm3mAzSjdiXGYBicqAV0cqSRe6Wpz9Gr7+OwsCZDwky0zGXgTjjI0
         JAoSg/ewimL5/I5TzPKrq71rqG6LgNtNQgOjQIjDQEwuFSy2cw6hMGIWcHsvUPKQe+6e
         BT9qcbAj0peFOwQM3wDdZyqlHUl8O0yqe8Gn7ikjAPxkAWGc33mc47pcdbpdQPdVypfA
         iYZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771854063; x=1772458863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMsH9QLvKj5vXxSOfwujFHVAamnbIlrD7SVHZSgn1eY=;
        b=zXlappCNL0nR6JvJgc0Fj2qU/4lPPhn9GUw3StYe1Q47qX2WMR+u1lZHpdCLf5tWTJ
         VKT0VJ2XXdW6r+H1cJVSpkvKmXt2IW4dJFUAxGH/nTLA5NyJSmNTOl5xmj1RgN0DCdfx
         KyU+tonYNY3hB5B2IJjdsNHEWDYIEN7+Wb8ghKfFkUmtOsyLrIblDtDitu5EcBtSv4I0
         ox4kvMpKaDz9h+6mztclCmS2pQIhVk5PREOfxdFThF9VQBC3rGlW1fop+F0BVzCHgj+X
         kA8Sju4bzYk62jGw+JBA4LPSM/CXavy/KUxGKxb8HoexovSt7VKjqJSTGPOqyl5CW/jT
         mhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854063; x=1772458863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MMsH9QLvKj5vXxSOfwujFHVAamnbIlrD7SVHZSgn1eY=;
        b=QP4LiMZaGTBOrSPokpA2Tvv4uAw+KN+gbsVH5R58rJj/Pi+QR6jgtsmEKALzaJJcoN
         hePkd9sC3Dae5nWhLAktjTEIRzMnlJbHiiG5Wuhgt4JDD5wUXpsIf18QNetu4ek549U2
         jRnK3pDfiha/Qvy0MnO9M8Jqq7LZTBYuM8IEwKbcIwcJ0GNfs35l9dWMcY9Tb1DjmmvY
         UezbSpAFtFv2m0p2rAxAYvtkhXSxnLlNRonofq6js1Kx8tCb3z5Y+xczpBUHmhnkyj8g
         euVE/mFibJFYoxDpJ42WMObpfHM7ypjWNiAnWWNft7TL/aEtUGr5xnvDEAHpEZh4mYUN
         ZVKg==
X-Forwarded-Encrypted: i=1; AJvYcCWKK/2shOh6g7NCPUcR434OB1Vi9/ZW8xGxHqi4fZmPnTzK1ehx6sgxkOyCdvygXTxpxSYQYzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PlZIwZCr1Vh7blpEJG1/303/UMHdE4rVZniHVsTO4MNrNIqM
	EMXmCFuk8z/QtIB5wRn4nbUoORSImiMBVD2IFnY/Doh23K8S/9z+PYc2ZZFWHws/rMVi7LZdsGD
	Oib6sIMTv7oDkez2WbBL4WeCW3pfHanObNv0mSDNW
X-Gm-Gg: ATEYQzzTLAN8IJ28yDs0n8DPJxuZ30IpDUwLAPSC7qB1Y+g/JxJcWnIMCFoo76x4MUR
	lnBeLR2E0hUnF0F5UqS9CDEuQ69m4/oEBK8vzgCW6BQz8Opo5dKZZhLdhj3NmHnsBGodmjZuIyb
	HiGPUsPDBBr84i4rWI0nCFin6UlN9xJ0V9BTNQ66BpaQy2lMm3gAMa787l5G9s9sTx5hx4olafc
	XzkP5dvYUSyZKBenAg93cuDfehbqNZALV1rv9cqBDY68DCGfDFdqvko1rBr582Cc/ZaIq0DESV8
	wSQc1hP7srCJhm5UYetiE9u4cg==
X-Received: by 2002:a05:6a00:928a:b0:81e:d7c3:2f3a with SMTP id
 d2e1a72fcca58-826daa64655mr8520754b3a.46.1771854063410; Mon, 23 Feb 2026
 05:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirfcsAFODycGarmqY8v6HSiHVaBgyKSUucV0DvPDjVX0U8Q@mail.gmail.com>
In-Reply-To: <CAGfirfcsAFODycGarmqY8v6HSiHVaBgyKSUucV0DvPDjVX0U8Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 23 Feb 2026 08:40:51 -0500
X-Gm-Features: AaiRm53u989LLHY4g2APNKOf2_8vz5njbIEGhG0KlJv4EeKJ8L0SktMlmBAn8Ys
Message-ID: <CAM0EoMk-QngJqsk+ehp7eynqMhHwwjju80pgKvTfRVqYoN9x=A@mail.gmail.com>
Subject: Re: [BUG] general protection fault in qdisc_tree_reduce_backlog
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260037-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EB199177323
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 8:33=E2=80=AFPM GangMin Kim <km.kim1503@gmail.com> =
wrote:
>
> Dear Linux kernel developers and maintainers,
> Using a modified version of syzkaller, I identified a new bug and
> refined the PoC, and the bug-related information is attached
> below.Please let me know if you need any further information.
>
> Summary
>
> A missing NULL check for cl_ops during qdisc replacement causes a NULL
> Pointer Dereference in qdisc_tree_reduce_backlog().
>

This also seems to have the same root cause as your earlier email.

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
> Most qdiscs set .cl_ops in their struct Qdisc_ops.
>
> ```c
> // net/sched/sch_tbf.c
> static struct Qdisc_ops tbf_qdisc_ops __read_mostly =3D {
>     .cl_ops     =3D &tbf_class_ops,
>     .id         =3D "tbf",
>     ...
> };
>
> // net/sched/sch_qfq.c
> static struct Qdisc_ops qfq_qdisc_ops __read_mostly =3D {
>     .cl_ops     =3D &qfq_class_ops,
>     .id         =3D "qfq",
>     ...
> };
> ```
>
> However, teql is a classless qdisc and does not set cl_ops.
>
> ```c
> static __init void teql_master_setup(struct net_device *dev)
> {
>     struct teql_master *master =3D netdev_priv(dev);
>     struct Qdisc_ops *ops =3D &master->qops;
>
>     master->dev =3D dev;
>     ops->priv_size  =3D sizeof(struct teql_sched_data);
>
>     ops->enqueue    =3D   teql_enqueue;
>     ops->dequeue    =3D   teql_dequeue;
>     ops->peek   =3D   teql_peek;
>     ops->init   =3D   teql_qdisc_init;
>     ops->reset  =3D   teql_reset;
>     ops->destroy    =3D   teql_destroy;
>     ops->owner  =3D   THIS_MODULE;
>
>     dev->netdev_ops =3D       &teql_netdev_ops;
>     dev->type       =3D ARPHRD_VOID;
>     dev->mtu        =3D 1500;
>     dev->min_mtu        =3D 68;
>     dev->max_mtu        =3D 65535;
>     dev->tx_queue_len   =3D 100;
>     dev->flags      =3D IFF_NOARP;
>     dev->hard_header_len    =3D LL_MAX_HEADER;
>     netif_keep_dst(dev);
> }
> ```
>
> When a qdisc is replaced, the existing qdisc tree is deleted, and
> qdisc_tree_reduce_backlog() is called to update the backlog counters.
>
> ```c
> tc_modify_qdisc
>   __tc_modify_qdisc
>     qdisc_graft
>       qdisc_replace
>         qdisc_purge_queue
>           qdisc_tree_reduce_backlog
> ```
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
>         cops =3D sch->ops->cl_ops; // [1]
>         if (notify && cops->qlen_notify) { // [2]
>             /* Note that qlen_notify must be idempotent as it may get cal=
led
>              * multiple times.
>              */
>             cl =3D cops->find(sch, parentid);
>             cops->qlen_notify(sch, cl);
>         }
>         sch->q.qlen -=3D n;
>         sch->qstats.backlog -=3D len;
>         __qdisc_qstats_drop(sch, drops);
>     }
>     rcu_read_unlock();
> }
> ```
>
> If the parent qdisc is replaced with teql, sch becomes teql0, and
> since teql is a classless qdisc, cl_ops is NULL. At [1], cops is
> assigned NULL, and at [2], accessing qlen_notify through the NULL
> pointer causes a NULL Pointer Dereference.
>
> Kasan Report
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> CPU: 0 UID: 0 PID: 2275 Comm: test Tainted: G        W
> 7.0.0-rc1 #54 PREEMPT(full)
> Tainted: [W]=3DWARN
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:qdisc_tree_reduce_backlog+0xcf/0x400 net/sched/sch_api.c:810
> Code: 4d 8b 67 18 49 8d 7c 24 08 48 89 f8 48 c1 e8 03 80 3c 18 00 0f
> 85 fb 02 00 00 4d 8b 6c 24 08 4d 8d 65 20 4c 89 e0 48 c1 e8 03 <80> 3c
> 18 00 0f 85 d4 02 00 00 49 83 7d 20 00 74 48 e8 7b ac 98 fd
> RSP: 0018:ffff8881213ef2d8 EFLAGS: 00010212
> RAX: 0000000000000004 RBX: dffffc0000000000 RCX: ffffffff83d4b680
> RDX: ffff8881213e4680 RSI: 0000000000010000 RDI: ffff888103812a08
> RBP: 0000000000010001 R08: 0000000000000000 R09: fffffbfff0d3595c
> R10: ffffffff869acae7 R11: 00000000ac3123a9 R12: 0000000000000020
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff888121071c00
> FS:  00007f10c4c3f700(0000) GS:ffff88834ad0d000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f10c4bfcfb8 CR3: 0000000121398000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  htb_graft+0x257/0x810 net/sched/sch_htb.c:1468
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
> RIP: 0033:0x7f10c4e29e4d
> Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ca ee ff ff 8b 54
> 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 fe ee ff ff 48
> RSP: 002b:00007f10c4c3ed90 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f10c4e29e4d
> RDX: 0000000000000000 RSI: 00007f10c4c3edd0 RDI: 0000000000000003
> RBP: 00007f10c4c3ee30 R08: 0000000000000000 R09: 0000000000050000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007fff03a356fe
> R13: 00007fff03a356ff R14: 00007f10c4c3efc0 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:qdisc_tree_reduce_backlog+0xcf/0x400 net/sched/sch_api.c:810
> Code: 4d 8b 67 18 49 8d 7c 24 08 48 89 f8 48 c1 e8 03 80 3c 18 00 0f
> 85 fb 02 00 00 4d 8b 6c 24 08 4d 8d 65 20 4c 89 e0 48 c1 e8 03 <80> 3c
> 18 00 0f 85 d4 02 00 00 49 83 7d 20 00 74 48 e8 7b ac 98 fd
> RSP: 0018:ffff8881213ef2d8 EFLAGS: 00010212
> RAX: 0000000000000004 RBX: dffffc0000000000 RCX: ffffffff83d4b680
> RDX: ffff8881213e4680 RSI: 0000000000010000 RDI: ffff888103812a08
> RBP: 0000000000010001 R08: 0000000000000000 R09: fffffbfff0d3595c
> R10: ffffffff869acae7 R11: 00000000ac3123a9 R12: 0000000000000020
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff888121071c00
> FS:  00007f10c4c3f700(0000) GS:ffff88834ad0d000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f10c4bfcfb8 CR3: 0000000121398000 CR4: 0000000000750ef0
> PKRU: 55555554
> ----------------
> Code disassembly (best guess):
>    0: 4d 8b 67 18           mov    0x18(%r15),%r12
>    4: 49 8d 7c 24 08        lea    0x8(%r12),%rdi
>    9: 48 89 f8              mov    %rdi,%rax
>    c: 48 c1 e8 03           shr    $0x3,%rax
>   10: 80 3c 18 00           cmpb   $0x0,(%rax,%rbx,1)
>   14: 0f 85 fb 02 00 00     jne    0x315
>   1a: 4d 8b 6c 24 08        mov    0x8(%r12),%r13
>   1f: 4d 8d 65 20           lea    0x20(%r13),%r12
>   23: 4c 89 e0              mov    %r12,%rax
>   26: 48 c1 e8 03           shr    $0x3,%rax
> * 2a: 80 3c 18 00           cmpb   $0x0,(%rax,%rbx,1) <-- trapping instru=
ction
>   2e: 0f 85 d4 02 00 00     jne    0x308
>   34: 49 83 7d 20 00        cmpq   $0x0,0x20(%r13)
>   39: 74 48                 je     0x83
>   3b: e8 7b ac 98 fd        call   0xfd98acbb
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff888121071c00
> FS:  00007f10c4c3f700(0000) GS:ffff88834ad0d000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f10c4bfcfb8 CR3: 0000000121398000 CR4: 0000000000750ef0
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception in interrupt
> Kernel Offset: disabled
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

