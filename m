Return-Path: <netdev+bounces-303921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vdEEGjLTRWo5FwsAu9opvQ
	(envelope-from <netdev+bounces-303921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:55:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D16F3220
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:55:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=32wH6hhG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303921-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303921-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2E2D30315FD
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707530EF80;
	Thu,  2 Jul 2026 02:55:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61332DF717;
	Thu,  2 Jul 2026 02:55:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960940; cv=none; b=rICbzpdZvLkGvJExkFD7uyPUVwxs6cVbL5hWCMsPhYOnWlm9EAuKtBpwGBIvmWeAbSouoGtwN8D1h8C5hoLTxOPpstGHEEpS6dLAh8Rn9o3L5zlEYCVPgpngoRp9A0mnT7IK6BHg4xD/5OXdbOnhBrNuCSUh31OPrjvcnEYaeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960940; c=relaxed/simple;
	bh=FHDJ6S0cme9NFQlijE1zY8pDFCRpU2a8tTQEaGDGWIQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KhjHZj8w9G9RRaht1aaDfswPchqsTTzKql/nNoLeuirhmsV6+yHBEPnDFt4SBpGiniA6RTWeVoo4zH1bl1zPCVKcAKvsYwHbYQqkyirK9fN9/g348wD1HBCs95DYFMWIE3UicD9elZoDB0VmAgJPkb8PLAvW0CcvkkS/v9aZV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=32wH6hhG; arc=none smtp.client-ip=113.46.200.223
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Z/IC9QfT5yS2aAq8dSyLYn2dEGe7oIq6qCnw/Wv2xv8=;
	b=32wH6hhG+7AriEN4q1uh5ZqPFaebKmU91Fi+7g5dU1IPwGPOtYDdWoEBVLoWjLWs/0POit6nu
	JU2YD75n1dCGBzl4WJS2mwewyLp7v5555OEpJw8czpb4LphGZmHfBJfqFE/S7oUABYQbj5fEOws
	jRDf9aMqcwUMA1/bseujL64=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4grLqX435YzmVW1;
	Thu,  2 Jul 2026 10:46:16 +0800 (CST)
Received: from kwepemj100016.china.huawei.com (unknown [7.202.194.10])
	by mail.maildlp.com (Postfix) with ESMTPS id D87A640590;
	Thu,  2 Jul 2026 10:55:26 +0800 (CST)
Received: from [10.174.177.15] (10.174.177.15) by
 kwepemj100016.china.huawei.com (7.202.194.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 10:55:23 +0800
Message-ID: <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
Date: Thu, 2 Jul 2026 10:55:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <virtualization@lists.linux.dev>,
	<kvm@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [syzbot] Monthly virt report (Jun 2026)
To: <syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <stefanha@redhat.com>,
	<sgarzare@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
References: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj100016.china.huawei.com (7.202.194.10)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303921-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mawupeng1@huawei.com,m:virtualization@lists.linux.dev,m:kvm@vger.kernel.org,m:netdev@vger.kernel.org,m:syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mawupeng1@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mawupeng1@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,listbf7b8eeeb8dda31d6de1];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,googlegroups.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid,huawei.com:from_mime,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 349D16F3220



On 周四 2026-6-25 04:32, syzbot wrote:
> Hello virt maintainers/developers,
> 
> This is a 31-day syzbot report for the virt subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/virt
> 
> During the period, 0 new issues were detected and 0 were fixed.
> In total, 5 issues are still open and 61 have already been fixed.
> There are also 2 low-priority issues.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 24      No    WARNING: refcount bug in call_timer_fn (4)
>                   https://syzkaller.appspot.com/bug?extid=07dcf509f4c013e25dc5
> <2> 3       Yes   memory leak in __vsock_create (2)
>                   https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678

Hi,

This is regarding the still-open "memory leak in __vsock_create (2)"
bug (#2 in the monthly virt report, extid 1b2c9c4a0f8708082678):
  https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678

I spent some time analyzing the root cause and the previous fix
attempt; below is a summary and a direction that tested out.

== Root cause ==

The leaked object is the child socket created by
virtio_transport_recv_listen() via __vsock_create() — exactly the
allocation site kmemleak points at. The reason it never gets freed is
in the accept() error path, not in the allocation itself.

When vsock_accept() dequeues a child but the listener carries an error
(listener->sk_err, e.g. set by a failed connect() issued on the socket
before listen()), it sets vconnected->rejected = true, skips
sock_graft(), drops the dequeue reference and *relies on
vsock_pending_work()* to clean the child up.

The catch: vsock_pending_work() is never scheduled on the transports
involved here. It is only ever scheduled by vmci_transport
(vmci_transport.c:1130); virtio_transport and vsock_loopback never
schedule it. So the rejected child sits with an unreleased initial
reference (the one from sk_alloc()) plus the connected-table
reference, vsock_sk_destruct() is never reached, and the cascade —
child socket, struct cred, virtio transport, SELinux blob — all leak.

The earlier commit 3a5cc90a4d17 ("vsock/virtio: remove socket from
connected/bound list on shutdown") adds an unconditional
vsock_remove_sock() in virtio_transport_recv_connected() when a
SHUTDOWN arrives, which drops the connected-table reference for a
child that later receives a SHUTDOWN; but it does not release the
sk_alloc() reference. So the leak is not really a regression
introduced there — rejected children have never been cleaned up on
transports that don't schedule pending_work. 3a5cc90a4d17 mainly
changes whether kmemleak can see the leak: on v6.6 it can (the
cascade shows up), on mainline the smaller struct sock layout leaves a
residual pointer inside the child that kmemleak counts as a reachable
reference, so mainline kmemleak stays silent even though
create/destruct accounting confirms the child never reaches
vsock_sk_destruct().

== Why the previous attempt didn't land ==

Divya's patch [1] tried to fix it by re-locking the parent listener
inside virtio_transport_recv_listen() and re-checking the shutdown
state under that lock before vsock_enqueue_accept(). That re-locks an
already-held lock — virtio_transport_recv_pkt() holds lock_sock(sk)
across the call into recv_listen() — and syzbot ci immediately flagged
"possible recursive locking" [2]. So it was backed out and the bug
stayed open.

== A direction that tests out ==

Instead of re-locking in the receive path, handle the cleanup directly
in vsock_accept(): on reject, instead of setting vconnected->rejected
and relying on pending_work, explicitly release the child's references
there:

    if (err) {
        vsock_remove_connected(vconnected);  /* connected-table ref */
        connected->sk_state = TCP_CLOSE;
        sock_put(connected);                  /* enqueue_accept ref  */
    } else {
        sock_graft(connected, newsock);
    }
    ...
    sock_put(connected);  /* the existing, common put — sk_alloc ref */

This drops exactly the three references the child holds at dequeue
time (sk_alloc + __vsock_insert_connected + vsock_enqueue_accept),
lets refcount reach zero and vsock_sk_destruct() run. The `rejected`
flag and its pending_work handling can then be removed. The receive
path is not touched, so there is no re-locking and no deadlock.

I verified this on ARM64 QEMU. On linux v6.6.y (where kmemleak can
see the leak) with the syzbot reproducer:
  - before: 6 creates / 4 destructs (2 leaked); kmemleak reports the
    cascade;
  - after:  6 creates / 6 destructs (0 leaked); kmemleak clean;
  - 50-iter normal server and 50-iter same-port-reconnect tests both
    pass 50/50 with zero leaks, no double-put warnings.
On mainline, kmemleak stays silent (see above) but create/destruct
accounting confirms the same leak before the fix; the fix is
code-identical across v6.6.y and mainline (same recv_listen/accept
paths).

I'm not subscribed to follow the list at full volume; happy to send a
formal patch (with the af_vsock.h / pending_work changes folded in)
if the direction looks right to the maintainers.

== Trigger, for completeness ==

The reproducer's atypical-but-legal sequence is what sets
listener->sk_err: a socket is connect()ed (leaving sk_err set, since
vsock_connect() only clears it at the start of a new connect) and then
turned into a listener:

    fd = socket(AF_VSOCK, SOCK_STREAM, 0);
    bind(fd, ...);
    connect(fd, &(VMADDR_CID_LOCAL, ...));   /* leaves sk_err set */
    listen(fd, 5);
    /* a peer connects to fd; the child created is later rejected */
    accept4(fd, ...);

Standard servers (listen before any connect on the same fd) don't hit
it, which is why this went ~2.5 years between the offending commit and
the syzbot report.

[1] https://lore.kernel.org/all/20260605191922.12720-1-divyakm@unc.edu/
[2] https://ci.syzbot.org/series/76f40e62-5a21-46d4-a636-10f0ec9c5040

Thanks.


> <3> 3913    Yes   INFO: rcu detected stall in do_idle
>                   https://syzkaller.appspot.com/bug?extid=385468161961cee80c31
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> To disable reminders for individual bugs, reply with the following command:
> #syz set <Ref> no-reminders
> 
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
> 
> You may send multiple commands in a single email message.


