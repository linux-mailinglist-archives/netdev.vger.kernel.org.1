Return-Path: <netdev+bounces-141932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74469BCB3D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BC71F22DF9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE321D27A9;
	Tue,  5 Nov 2024 11:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net [46.105.63.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E271D1500
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.63.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804731; cv=none; b=GjEKxasFYaXx2Mel4g8o4U1UileHIITFc7Gn+9s+o6usQKqHI7/gJlWhPCwpWo2BAB8GZUpoAuMSbQR527+ilohAGwootFlBflPq3bCw2qZHS9HAAalMihdxGiYSY1AzmF7NwZ4mfnQ1pf9AQsXuuHk+IH9QoYeedMgeB3D7wBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804731; c=relaxed/simple;
	bh=alB18K499Ij8E0qPZfo2zb3hFUtvrsjw2BWfWyJxJKs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JSSvS72OESeHnGDUrUvgqoI66xRDvUTs/9T/Oa26nJkVuBhImYGD3kQGQw+KDaL1+7SQq6OCiRXttyrsO/CWfUKZ3ajxbL9kOy4QqchJ12LqdJMb2OKYENzWtdazsmcOyyj7ZFOnr5HzJb7goCYR2hIXPGb4jChhv72WFHNE2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=46.105.63.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.139.225])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4XjQV62RT2z1Svv
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 11:05:18 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-zcssp (unknown [10.111.174.63])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 27CE01FDC5;
	Tue,  5 Nov 2024 11:05:10 +0000 (UTC)
Received: from courmont.net ([37.59.142.104])
	by ghost-submission-5b5ff79f4f-zcssp with ESMTPSA
	id czs2Keb7KWercAAARAn4fw
	(envelope-from <remi@remlab.net>); Tue, 05 Nov 2024 11:05:10 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-104R00535e08229-f436-4d53-82b5-a0da44792e43,
                    EE834E3B50A23AFC85B510F492F9176D607159AB) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:87.95.77.48
Date: Tue, 05 Nov 2024 13:03:49 +0200
From: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Remi Denis-Courmont <courmisch@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_phonet=3A_do_not_call_?=
 =?US-ASCII?Q?synchronize=5Frcu=28=29_from_phonet=5Froute=5Fdel=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241104152622.3580037-1-edumazet@google.com>
References: <20241104152622.3580037-1-edumazet@google.com>
Message-ID: <D2067CE4-F300-4DED-8012-9718FD6AB67F@remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 18153447150167005470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreejnecuhfhrohhmpeftrohmihcuffgvnhhishdqvehouhhrmhhonhhtuceorhgvmhhisehrvghmlhgrsgdrnhgvtheqnecuggftrfgrthhtvghrnheptdehtedtheegfeejfeetheetgedvveekkeejhffggefgieevveffffelgfehueejnecukfhppeduvdejrddtrddtrddupdekjedrleehrdejjedrgeekpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvghmihesrhgvmhhlrggsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth



Le 4 novembre 2024 17:26:22 GMT+02:00, Eric Dumazet <edumazet@google=2Ecom=
> a =C3=A9crit=C2=A0:
>Calling synchronize_rcu() while holding rcu_read_lock() is not
>permitted [1]
>
>Move the synchronize_rcu() to route_doit()=2E
>
>[1]
>WARNING: suspicious RCU usage
>6=2E12=2E0-rc5-syzkaller-01056-gf07a6e6ceb05 #0 Not tainted
>-----------------------------
>kernel/rcu/tree=2Ec:4092 Illegal synchronize_rcu() in RCU read-side criti=
cal section!
>
>other info that might help us debug this:
>
>rcu_scheduler_active =3D 2, debug_locks =3D 1
>1 lock held by syz-executor427/5840:
>  #0: ffffffff8e937da0 (rcu_read_lock){=2E=2E=2E=2E}-{1:2}, at: rcu_lock_=
acquire include/linux/rcupdate=2Eh:337 [inline]
>  #0: ffffffff8e937da0 (rcu_read_lock){=2E=2E=2E=2E}-{1:2}, at: rcu_read_=
lock include/linux/rcupdate=2Eh:849 [inline]
>  #0: ffffffff8e937da0 (rcu_read_lock){=2E=2E=2E=2E}-{1:2}, at: route_doi=
t+0x3d6/0x640 net/phonet/pn_netlink=2Ec:264
>
>stack backtrace:
>CPU: 1 UID: 0 PID: 5840 Comm: syz-executor427 Not tainted 6=2E12=2E0-rc5-=
syzkaller-01056-gf07a6e6ceb05 #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
>Call Trace:
> <TASK>
>  __dump_stack lib/dump_stack=2Ec:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack=2Ec:120
>  lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep=2Ec:6821
>  synchronize_rcu+0xea/0x360 kernel/rcu/tree=2Ec:4089
>  phonet_route_del+0xc6/0x140 net/phonet/pn_dev=2Ec:409
>  route_doit+0x514/0x640 net/phonet/pn_netlink=2Ec:275
>  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink=2Ec:6790
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink=2Ec:2551
>  netlink_unicast_kernel net/netlink/af_netlink=2Ec:1331 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink=2Ec:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink=2Ec:1901
>  sock_sendmsg_nosec net/socket=2Ec:729 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket=2Ec:744
>  sock_write_iter+0x2d7/0x3f0 net/socket=2Ec:1165
>  new_sync_write fs/read_write=2Ec:590 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write=2Ec:683
>  ksys_write+0x183/0x2b0 fs/read_write=2Ec:736
>  do_syscall_x64 arch/x86/entry/common=2Ec:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common=2Ec:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>Fixes: 17a1ac0018ae ("phonet: Don't hold RTNL for route_doit()=2E")
>Reported-by: syzbot <syzkaller@googlegroups=2Ecom>
>Signed-off-by: Eric Dumazet <edumazet@google=2Ecom>
>Cc: Kuniyuki Iwashima <kuniyu@amazon=2Ecom>
>Cc: Remi Denis-Courmont <courmisch@gmail=2Ecom>
>---
> net/phonet/pn_dev=2Ec     |  4 +++-
> net/phonet/pn_netlink=2Ec | 10 ++++++++--
> 2 files changed, 11 insertions(+), 3 deletions(-)
>
>diff --git a/net/phonet/pn_dev=2Ec b/net/phonet/pn_dev=2Ec
>index 19234d664c4fb537eba0267266efbb226cf103c3=2E=2E578d935f2b11694fd1004=
c5f854ec344b846eeb2 100644
>--- a/net/phonet/pn_dev=2Ec
>+++ b/net/phonet/pn_dev=2Ec
>@@ -406,7 +406,9 @@ int phonet_route_del(struct net_device *dev, u8 daddr=
)
>=20
> 	if (!dev)
> 		return -ENOENT;
>-	synchronize_rcu();
>+
>+	/* Note : our caller must call synchronize_rcu() */
>+
> 	dev_put(dev);
> 	return 0;
> }
>diff --git a/net/phonet/pn_netlink=2Ec b/net/phonet/pn_netlink=2Ec
>index ca1f04e4a2d9eb3b2a6d6cc5b299aee28d569b08=2E=2E24930733ac572ed3ec5fd=
142d347c115346a28fa 100644
>--- a/net/phonet/pn_netlink=2Ec
>+++ b/net/phonet/pn_netlink=2Ec
>@@ -233,6 +233,7 @@ static int route_doit(struct sk_buff *skb, struct nlm=
sghdr *nlh,
> {
> 	struct net *net =3D sock_net(skb->sk);
> 	struct nlattr *tb[RTA_MAX+1];
>+	bool sync_needed =3D false;
> 	struct net_device *dev;
> 	struct rtmsg *rtm;
> 	u32 ifindex;
>@@ -269,16 +270,21 @@ static int route_doit(struct sk_buff *skb, struct n=
lmsghdr *nlh,
> 		return -ENODEV;
> 	}
>=20
>-	if (nlh->nlmsg_type =3D=3D RTM_NEWROUTE)
>+	if (nlh->nlmsg_type =3D=3D RTM_NEWROUTE) {
> 		err =3D phonet_route_add(dev, dst);
>-	else
>+	} else {
> 		err =3D phonet_route_del(dev, dst);
>+		if (!err)
>+			sync_needed =3D true;
>+	}
>=20
> 	rcu_read_unlock();
>=20
> 	if (!err)
> 		rtm_phonet_notify(net, nlh->nlmsg_type, ifindex, dst);
>=20
>+	if (sync_needed)
>+		synchronize_rcu();

Synchronising after sending notifications sounds a bit iffy=2E Whatever a =
given notification is about should be fully committed so we don't create a =
user-visible race here=2E

Can't we reorder here?

> 	return err;
> }
>=20

