Return-Path: <netdev+bounces-133052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B10D9945D2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74FC1F2492D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB0192B8F;
	Tue,  8 Oct 2024 10:54:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AEF2CA8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384851; cv=none; b=g0ToxoXU/N849GJDJGAc2coJYZQxyFQum4tgGl1K7mOys8T3A0671bHywi8aS5g7ggoX12iTruux7W8eCaxXtm6vWhGj28TTrPvscbRNcKrtUAnTlRcday4fg7HX9Ig9VIDqZLChmhaQsGhPCyquQO20nW2YMKrsN8ffujiXiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384851; c=relaxed/simple;
	bh=27o7KUKq9lbTXRZUrDjXx8h86VGke4PyLQ7YBCSSenA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLp81NtXywd+D8mKf5fq++zhJMRFOVl0pHr+H9NxNed29Hyk8NwdZWFKv0lHaV64jQNx/5QYScrZsgw07INP8McqqbIQ7BHLIxKARl94979099LIxArK5wwTudZmq5xb42h6yfQE6BBFuniBQJV6rT/XN2pgr3PLCdI9Obbw36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.199])
	by sina.com (10.185.250.21) with ESMTP
	id 67050F3C00001F59; Tue, 8 Oct 2024 18:53:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3893203408170
X-SMAIL-UIID: 783BC62F157E4D65A32E12E32B2EB28C-20241008-185352-1
From: Hillf Danton <hdanton@sina.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Netdev <netdev@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request at virtual address
Date: Tue,  8 Oct 2024 18:53:40 +0800
Message-Id: <20241008105340.2214-1-hdanton@sina.com>
In-Reply-To: <CADvbK_fxXdNiyJ3j0H+KHgMF11iOGhnjtYFy6R18NyBX9wB4Kw@mail.gmail.com>
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp> <20230831114108.4744-1-hdanton@sina.com> <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com> <20230903005334.5356-1-hdanton@sina.com> <CANn89iJj_VR0L7g3-0=aZpKbXfVo7=BG0tsb8rhiTBc4zi_EtQ@mail.gmail.com> <20230905111059.5618-1-hdanton@sina.com> <CANn89iKvoLUy=TMxW124tiixhOBL+SsV2jcmYhH8MFh3O75mow@mail.gmail.com> <CA+G9fYvskJfx3=h4oCTAyxDWO1-aG7S0hAxSk4Jm+xSx=P1dhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 6 Oct 2024 14:08:18 -0400 Xin Long <lucien.xin@gmail.com>
> Sorry for bringing up this issue, it recently occurred on my aarch64 kernel
> with blackhole_netdev backported. I tracked it down, and when deleting
> the netns, the path is:
> 
> In cleanup_net():
> 
>   default_device_exit_batch()
>     unregister_netdevice_many()
>       addrconf_ifdown() -> call_rcu(rcu, fib6_info_destroy_rcu) <--- [1]
>     netdev_run_todo()
>       rcu_barrier() <- [2]
>   ip6_route_net_exit() -> dst_entries_destroy(net->ip6_dst_ops) <--- [3]
> 
> In fib6_info_destroy_rcu():
> 
>   dst_dev_put()
>   dst_release() -> call_rcu(rcu, dst_destroy_rcu) <--- [5]
> 
> In dst_destroy_rcu():
>   dst_destroy() -> dst_entries_add(dst->ops, -1); <--- [6]
> 
> fib6_info_destroy_rcu() is scheduled at [1], rcu_barrier() will wait
> for fib6_info_destroy_rcu() to be done at [2]. However, another callback
> dst_destroy_rcu() is scheduled() in fib6_info_destroy_rcu() at [5], and
> there's no place calling rcu_barrier() to wait for dst_destroy_rcu() to
> be done. It means dst_entries_add() at [6] might be run later than
> dst_entries_destroy() at [3], then this UAF will trigger the panic.
> 
No more important discoveries than this one in the net core so far in 2024.

Thanks
Hillf

> On Tue, Oct 17, 2023 at 1:02 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > On Tue, 5 Sept 2023 at 17:55, Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Tue, Sep 5, 2023 at 1:52 PM Hillf Danton <hdanton@sina.com> wrote:
> > > >
> > > > On Mon, 4 Sep 2023 13:29:57 +0200 Eric Dumazet <edumazet@google.com>
> > > > > On Sun, Sep 3, 2023 at 5:57=E2=80=AFAM Hillf Danton <hdanton@sina.com>
> > > > > > On Thu, 31 Aug 2023 15:12:30 +0200 Eric Dumazet <edumazet@google.com>
> > > > > > > --- a/net/core/dst.c
> > > > > > > +++ b/net/core/dst.c
> > > > > > > @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
> > > > > > >
> > > > > > >  void dst_release(struct dst_entry *dst)
> > > > > > >  {
> > > > > > > -       if (dst && rcuref_put(&dst->__rcuref))
> > > > > > > +       if (dst && rcuref_put(&dst->__rcuref)) {
> > > > > > > +               if (!(dst->flags & DST_NOCOUNT)) {
> > > > > > > +                       dst->flags |= DST_NOCOUNT;
> > > > > > > +                       dst_entries_add(dst->ops, -1);
> > > > > >
> So I think it makes sense to NOT call dst_entries_add() in the path
> dst_destroy_rcu() -> dst_destroy(), as it does on the patch above,
> but I don't see it get posted.
> 
> Hi, Eric, would you like to move forward with your patch above ?
> 
> Or we can also move the dst_entries_add(dst->ops, -1) from dst_destroy()
> to dst_release():
> 
> Note, dst_destroy() is not used outside net/core/dst.c, we may delete
> EXPORT_SYMBOL(dst_destroy) in the future.
> 
> Thanks.
> 
> > > > > > Could this add happen after the rcu sync above?
> > > > > >
> > > > > I do not think so. All dst_release() should happen before netns removal.
> > > >
> > > >         cpu2                    cpu3
> > > >         ====                    ====
> > > >         cleanup_net()           __sys_sendto
> > > >                                 sock_sendmsg()
> > > >                                 udpv6_sendmsg()
> > > >         synchronize_rcu();
> > > >                                 dst_release()
> > > >
> > > > Could this one be an exception?
> > >
> > > No idea what you are trying to say.
> > >
> > > Please give exact locations, instead of being rather vague.
> > >
> > > Note that an UDP socket can not send a packet while its netns is dismantled,
> > > because alive sockets keep a reference on the netns.
> >
> > Gentle reminder.
> > This is still an open issue.
> >
> > # selftests: net: pmtu.sh
> > # TEST: ipv4: PMTU exceptions                                         [ OK ]
> > # TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]
> > # TEST: ipv6: PMTU exceptions                                         [ OK ]
> > # TEST: ipv6: PMTU exceptions - nexthop objects                       [ OK ]
> > # TEST: ICMPv4 with DSCP and ECN: PMTU exceptions                     [ OK ]
> > # TEST: ICMPv4 with DSCP and ECN: PMTU exceptions - nexthop objects   [ OK ]
> > # TEST: UDPv4 with DSCP and ECN: PMTU exceptions                      [ OK ]
> > # TEST: UDPv4 with DSCP and ECN: PMTU exceptions - nexthop objects    [ OK ]
> > # TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
> > # TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
> > # TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
> > # TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
> > # TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
> > <1>[  155.820793] Unable to handle kernel paging request at virtual
> > address ffff247020442000
> > <1>[  155.821495] Mem abort info:
> > <1>[  155.821719]   ESR = 0x0000000097b58004
> > <1>[  155.822046]   EC = 0x25: DABT (current EL), IL = 32 bits
> > <1>[  155.822412]   SET = 0, FnV = 0
> > <1>[  155.822648]   EA = 0, S1PTW = 0
> > <1>[  155.822925]   FSC = 0x04: level 0 translation fault
> > <1>[  155.823317] Data abort info:
> > <1>[  155.823590]   Access size = 4 byte(s)
> > <1>[  155.823886]   SSE = 1, SRT = 21
> > <1>[  155.824167]   SF = 1, AR = 0
> > <1>[  155.824450]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > <1>[  155.824847]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > <1>[  155.825345] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041d84000
> > <1>[  155.827244] [ffff247020442000] pgd=0000000000000000, p4d=0000000000000000
> > <0>[  155.828511] Internal error: Oops: 0000000097b58004 [#1] PREEMPT SMP
> > <4>[  155.829155] Modules linked in: vxlan ip6_udp_tunnel udp_tunnel
> > act_csum libcrc32c act_pedit cls_flower sch_prio veth vrf macvtap
> > macvlan tap crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64
> > fuse drm backlight dm_mod ip_tables x_tables [last unloaded:
> > test_blackhole_dev]
> > <4>[  155.832289] CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.6.0-rc6 #1
> > <4>[  155.832896] Hardware name: linux,dummy-virt (DT)
> > <4>[  155.833927] pstate: 824000c9 (Nzcv daIF +PAN -UAO +TCO -DIT
> > -SSBS BTYPE=--)
> > <4>[  155.834496] pc : percpu_counter_add_batch+0x24/0xcc
> > <4>[  155.835735] lr : dst_destroy+0x44/0x1e4
> >
> > Links:
> > - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.6-rc6/testrun/20613439/suite/log-parser-test/test/check-kernel-oops/log
> > - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.6-rc6/testrun/20613439/suite/log-parser-test/tests/
> >
> > - Naresh

