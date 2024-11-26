Return-Path: <netdev+bounces-147465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B919D9AA3
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1166C2812E1
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D31D5CEE;
	Tue, 26 Nov 2024 15:50:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ECC1C9B7A
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636219; cv=none; b=Z95mmSzn5c708ZRdZNqSqU5+nMWA/1TFwACtO30o4s81/UglaDIW4SIcaGFqbDHwNYulExzMVkARqqPsCCUTHxJxSPAcnCDhTS7pxzvwfxfnqLS1yr/cugMqXrLhtTka2fga48o9fho5YY5OzMl9i6aieEP0V06rN/0Ir43exz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636219; c=relaxed/simple;
	bh=w+ICTV6MLMH9JtQ7+/seSAZhOlL+1YteEbqSHp+/9VI=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=YsIMoUvdT+37mwQN+fWPSH+T1ci2xK2oUQHy6s1dDIHldMaoDM2R/qi+Ve8x59uzc7C66IT3njnHIHQ8qHAgxQ5bHR62c4v5vLD+e6zZUmfd931QOk1gwygB+vIEuZLeEabSzIJ9DSnxthDzyYdzLmqhRGHpExdFK6iJMzI84fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:56660)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tFxpI-00ChAV-Un; Tue, 26 Nov 2024 08:50:09 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:46232 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tFxpH-0082SK-LS; Tue, 26 Nov 2024 08:50:08 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <edumazet@google.com>,  <davem@davemloft.net>,  <jmaloy@redhat.com>,
  <kuba@kernel.org>,  <kuni1840@gmail.com>,  <netdev@vger.kernel.org>,
  <pabeni@redhat.com>,  <syzkaller@googlegroups.com>,
  <tipc-discussion@lists.sourceforge.net>,  <ying.xue@windriver.com>,
  <erik.hugne@ericsson.com>
References: <CANn89iLXk2BRLWuyvEsxOVqRBo2qbuOydv33xfKAe54M9tKPUA@mail.gmail.com>
	<20241126142031.11397-1-kuniyu@amazon.com>
Date: Tue, 26 Nov 2024 09:49:44 -0600
In-Reply-To: <20241126142031.11397-1-kuniyu@amazon.com> (Kuniyuki Iwashima's
	message of "Tue, 26 Nov 2024 23:20:31 +0900")
Message-ID: <871pyyq9k7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1tFxpH-0082SK-LS;;;mid=<871pyyq9k7.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19YX3ourTOdswJTayzmNRRm2usQ1kL6qhg=
X-Spam-Level: ***
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4738]
	*  0.7 XMSubLong Long Subject
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_PhoneNumber BODY: Likely contains a phone number in body
	*      of email
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	*  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
	*  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kuniyuki Iwashima <kuniyu@amazon.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 708 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 11 (1.5%), b_tie_ro: 9 (1.3%), parse: 1.24 (0.2%),
	 extract_message_metadata: 19 (2.6%), get_uri_detail_list: 4.3 (0.6%),
	tests_pri_-2000: 17 (2.4%), tests_pri_-1000: 2.6 (0.4%),
	tests_pri_-950: 1.31 (0.2%), tests_pri_-900: 1.16 (0.2%),
	tests_pri_-90: 140 (19.7%), check_bayes: 134 (19.0%), b_tokenize: 15
	(2.1%), b_tok_get_all: 51 (7.2%), b_comp_prob: 3.9 (0.5%),
	b_tok_touch_all: 62 (8.7%), b_finish: 0.84 (0.1%), tests_pri_0: 500
	(70.5%), check_dkim_signature: 0.74 (0.1%), check_dkim_adsp: 2.7
	(0.4%), poll_dns_idle: 0.47 (0.1%), tests_pri_10: 2.6 (0.4%),
	tests_pri_500: 10 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 net] tipc: Fix use-after-free of kernel socket in
 cleanup_bearer().
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: erik.hugne@ericsson.com, ying.xue@windriver.com, tipc-discussion@lists.sourceforge.net, syzkaller@googlegroups.com, pabeni@redhat.com, netdev@vger.kernel.org, kuni1840@gmail.com, kuba@kernel.org, jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com, kuniyu@amazon.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Kuniyuki Iwashima <kuniyu@amazon.com> writes:

> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 26 Nov 2024 11:53:07 +0100
>> On Tue, Nov 26, 2024 at 7:14=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
>> >
>> > syzkaller reported a use-after-free of kernel UDP socket in
>> > cleanup_bearer() without repro. [0][1]
>> >
>> > When bearer_disable() calls tipc_udp_disable(), cleanup of the kernel
>> > UDP socket is deferred by work calling cleanup_bearer().
>> >
>> > Since the cited commit, however, the socket's netns might not be alive
>> > when the work is executed, resulting in use-after-free.
>> >
>> > Let's hold netns for the kernel UDP socket when created.
>> >
>> > Note that we can't call get_net() before scheduling the work and call
>> > put_net() in cleanup_bearer() because bearer_disable() could be called
>> > from pernet_operations.exit():
>> >
>> >   tipc_exit_net
>> >   `- tipc_net_stop
>> >      `- tipc_bearer_stop
>> >         `- bearer_disable
>> >
>> > [0]:
>> > ref_tracker: net notrefcnt@000000009b3d1faf has 1/1 users at
>> >      sk_alloc+0x438/0x608
>> >      inet_create+0x4c8/0xcb0
>> >      __sock_create+0x350/0x6b8
>> >      sock_create_kern+0x58/0x78
>> >      udp_sock_create4+0x68/0x398
>> >      udp_sock_create+0x88/0xc8
>> >      tipc_udp_enable+0x5e8/0x848
>> >      __tipc_nl_bearer_enable+0x84c/0xed8
>> >      tipc_nl_bearer_enable+0x38/0x60
>> >      genl_family_rcv_msg_doit+0x170/0x248
>> >      genl_rcv_msg+0x400/0x5b0
>> >      netlink_rcv_skb+0x1dc/0x398
>> >      genl_rcv+0x44/0x68
>> >      netlink_unicast+0x678/0x8b0
>> >      netlink_sendmsg+0x5e4/0x898
>> >      ____sys_sendmsg+0x500/0x830
>> >
>> > [1]:
>> > BUG: KMSAN: use-after-free in udp_hashslot include/net/udp.h:85 [inlin=
e]
>> > BUG: KMSAN: use-after-free in udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.=
c:1979
>> >  udp_hashslot include/net/udp.h:85 [inline]
>> >  udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
>> >  sk_common_release+0xaf/0x3f0 net/core/sock.c:3820
>> >  inet_release+0x1e0/0x260 net/ipv4/af_inet.c:437
>> >  inet6_release+0x6f/0xd0 net/ipv6/af_inet6.c:489
>> >  __sock_release net/socket.c:658 [inline]
>> >  sock_release+0xa0/0x210 net/socket.c:686
>> >  cleanup_bearer+0x42d/0x4c0 net/tipc/udp_media.c:819
>> >  process_one_work kernel/workqueue.c:3229 [inline]
>> >  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
>> >  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
>> >  kthread+0x531/0x6b0 kernel/kthread.c:389
>> >  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
>> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>> >
>> > Uninit was created at:
>> >  slab_free_hook mm/slub.c:2269 [inline]
>> >  slab_free mm/slub.c:4580 [inline]
>> >  kmem_cache_free+0x207/0xc40 mm/slub.c:4682
>> >  net_free net/core/net_namespace.c:454 [inline]
>> >  cleanup_net+0x16f2/0x19d0 net/core/net_namespace.c:647
>> >  process_one_work kernel/workqueue.c:3229 [inline]
>> >  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
>> >  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
>> >  kthread+0x531/0x6b0 kernel/kthread.c:389
>> >  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
>> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>> >
>> > CPU: 0 UID: 0 PID: 54 Comm: kworker/0:2 Not tainted 6.12.0-rc1-00131-g=
f66ebf37d69c #7 91723d6f74857f70725e1583cba3cf4adc716cfa
>> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3=
-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> > Workqueue: events cleanup_bearer
>> >
>> > Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the =
netns of kernel sockets.")
>> > Reported-by: syzkaller <syzkaller@googlegroups.com>
>> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> > ---
>> > I'll remove this ugly hack by clearner API in the next cycle.
>> > see:
>> > https://lore.kernel.org/netdev/20241112001308.58355-1-kuniyu@amazon.co=
m/
>> > ---
>> >  net/tipc/udp_media.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
>> > index 439f75539977..10986b283ac8 100644
>> > --- a/net/tipc/udp_media.c
>> > +++ b/net/tipc/udp_media.c
>> > @@ -673,6 +673,7 @@ static int tipc_udp_enable(struct net *net, struct=
 tipc_bearer *b,
>> >         struct nlattr *opts[TIPC_NLA_UDP_MAX + 1];
>> >         u8 node_id[NODE_ID_LEN] =3D {0,};
>> >         struct net_device *dev;
>> > +       struct sock *sk;
>> >         int rmcast =3D 0;
>> >
>> >         ub =3D kzalloc(sizeof(*ub), GFP_ATOMIC);
>> > @@ -792,6 +793,12 @@ static int tipc_udp_enable(struct net *net, struc=
t tipc_bearer *b,
>> >         if (err)
>> >                 goto free;
>> >
>> > +       sk =3D ub->ubsock->sk;
>> > +       __netns_tracker_free(net, &sk->ns_tracker, false);
>> > +       sk->sk_net_refcnt =3D 1;
>> > +       get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
>> > +       sock_inuse_add(net, 1);
>> > +
>> >         return 0;
>>=20
>> I think 'kernel sockets' were not refcounted to allow the netns to be re=
moved.
>>=20
>> Otherwise, what would tipc_bearer_stop() be needed ?
>
> Interestingly, the delayed cleanup exists since the udp media support
> was added in d0f91938bede2, and it's 2 months earlier than 26abe14379f8
> that drops netns refcnt for kernel sockets.

Just for reference commit 26abe14379f8 ("net: Modify sk_alloc to not
reference count the netns of kernel sockets.") doesn't ``drop'' the
netns refcnt for kernel sockets.  It changes the code so the refcnt is
not taken.  You will see in that commit a bunch of sk_change_net calls
which if memory serves are where the refcnt was previously dropped.

> So I thought the udp bearer did not assume bearer_disable() was called
> from the __net_exit path, it could be simply wrong though.
>
> At least, the __net_exit path works for other media types.

For the most part.  The network filesystem has been seeing similar
issues lately.  I suspect there is something (maybe just syzkaller)
that is making old bugs more likely to appear lately.

> @Erik Hugne, do you remember any context above ?
>
>
>>=20
>> tipc_exit_net(struct net *net)  // can only be called when all refcnt
>> have been released
>>  -> tipc_net_stop()
>>   -> tipc_bearer_stop()
>>     -> bearer_disable()
>>      -> tipc_udp_disable()
>>        -> INIT_WORK(&ub->work, cleanup_bearer); schedule_work(&ub->work);
>>=20

That schedule_work definitely looks like it will start running after
the network namespace and probably the entire kernel socket
has been released.

Eric

