Return-Path: <netdev+bounces-47082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240637E7BAF
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC211C209DE
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECA14297;
	Fri, 10 Nov 2023 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJinpNpq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72753134C0
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:07:55 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A02B7A7
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:07:53 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c742186a3bso20893441fa.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699614471; x=1700219271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HY/BhxNMgkxM5Sa2W25BpshHpaFZpGY1HEFkTDZzJT0=;
        b=FJinpNpqCF9v0o7erl9IEQktOE86y30RdgweuV9/VH23Ykh9nEMhe/KloVDAB+Tpl2
         NaDJ6RXYKPEczH8+Vk+nScdBamI9v2rHGFXFsiQiTXMkWgQkNei1WxQQVETXGqQgzk+q
         rqmtBv8XF9bUC0VnDTSVy89i0OCKRbnlSr+lTnIuyB23T1ILuXnWF47266YYzR1Fj+7p
         An4LD7Cls9htWhvbDf84h7UZRjx9+7D5K+2lIxaTZ6ZB1Kne6W8+iWaCfdfsa2UK9qoa
         eXo7w7XX00YillA30OW8PBF6XX2SqN6fIuyk9VFOtbnOGMm6Dyj0BCYTXUIEPMalx0+8
         ap6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699614471; x=1700219271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY/BhxNMgkxM5Sa2W25BpshHpaFZpGY1HEFkTDZzJT0=;
        b=O7ccSKgCvMNIVAEeQDNIh95nCv/yWFRUxeiIfCeGukmwCEge333nihaPxvWx/py/DR
         A8HOeyGjjlCb8dLnaXXDNXhk7tDitq+Cmao8OPVGS7kDqyEqQ2HEJRfbZOJenfbQYLxF
         uXzFTXkJOQoRNrjuVdbBiIsh2BOgkIdAcVf39Nxf7x2zU8cans4N35P6OeQWg5n9VrBB
         49bT8gGcycVtmwwzUEuxhxv6gzzkFgULRrjGQK8pYaJ+DltT3oGaz7SeUiSu7t0u+wDD
         dYRzf2N6birRvPvJicc6K8i+43R+C+AzykN3IZcX/MWs6L7ZNCkvogaf8+2+9XGcDbz3
         eTJw==
X-Gm-Message-State: AOJu0Yy4D0lPMkKOJHgvxFmqJecDmXEwqGlzOWa8mpQfZdvholzwrl3z
	Jtthp0uxTuXnCYWY8bNCbMoihdy4rbLpmw==
X-Google-Smtp-Source: AGHT+IH8QepTUzgBLncpeIlZUuSICLolgZfi6NH0yrjLGrB/M/C2DuAgWYYfBjVyViMqMOlTbmaFUQ==
X-Received: by 2002:a2e:7217:0:b0:2c5:b4d2:e9c1 with SMTP id n23-20020a2e7217000000b002c5b4d2e9c1mr6337543ljc.1.1699614471174;
        Fri, 10 Nov 2023 03:07:51 -0800 (PST)
Received: from localhost ([195.96.151.130])
        by smtp.gmail.com with ESMTPSA id 24-20020a2e1558000000b002bcdeeecd11sm245133ljv.66.2023.11.10.03.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 03:07:50 -0800 (PST)
Date: Fri, 10 Nov 2023 13:07:49 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: "Chittim, Madhu" <madhu.chittim@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	xuejun.zhang@intel.com, sridhar.samudrala@intel.com
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
Message-ID: <ZU4PBY1g_-N7cd8A@mail.gmail.com>
References: <ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
 <ZTvBoQHfu23ynWf-@mail.gmail.com>
 <131da9645be5ef6ea584da27ecde795c52dfbb00.camel@redhat.com>
 <ZUEQzsKiIlgtbN-S@mail.gmail.com>
 <5d873c14-9d17-4c48-8e11-951b99270b75@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d873c14-9d17-4c48-8e11-951b99270b75@intel.com>
X-Spam-Level: *

On Thu, 09 Nov 2023 at 13:54:17 -0800, Chittim, Madhu wrote:
> 
> 
> On 10/31/2023 7:40 AM, Maxim Mikityanskiy wrote:
> > On Tue, 31 Oct 2023 at 10:11:14 +0100, Paolo Abeni wrote:
> > > Hi,
> > > 
> > > I'm sorry for the late reply.
> > > 
> > > On Fri, 2023-10-27 at 16:57 +0300, Maxim Mikityanskiy wrote:
> > > > I believe this is not the right fix.
> > > > 
> > > > On Thu, 26 Oct 2023 at 17:36:48 +0200, Paolo Abeni wrote:
> > > > > The following commands:
> > > > > 
> > > > > tc qdisc add dev eth1 handle 2: root htb offload
> > > > > tc class add dev eth1 parent 2: classid 2:1 htb rate 5mbit burst 15k
> > > > > 
> > > > > yeld to a WARN in the HTB qdisc:
> > > > 
> > > > Something is off here. These are literally the most basic commands one
> > > > could invoke with HTB offload, I'm sure they worked. Is it something
> > > > that broke recently? Tariq/Gal/Saeed, could you check them on a Mellanox
> > > > NIC?
> > > > 
> > > > > 
> > > > >   WARNING: CPU: 2 PID: 1583 at net/sched/sch_htb.c:1959
> > > > >   CPU: 2 PID: 1583 Comm: tc Kdump: loaded 6.6.0-rc2.mptcp_7895773e5235+ #59
> > > > >   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
> > > > >   RIP: 0010:htb_change_class+0x25c4/0x2e30 [sch_htb]
> > > > >   Code: 24 58 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 c1 ea 03 80 3c 02 00 0f 85 92 01 00 00 49 89 8c 24 b0 01 00 00 e9 77 fc ff ff <0f> 0b e9 15 ec ff ff 80 3d f8 35 00 00 00 0f 85 d4 f9 ff ff ba 32
> > > > >   RSP: 0018:ffffc900015df240 EFLAGS: 00010246
> > > > >   RAX: 0000000000000000 RBX: ffff88811b4ca000 RCX: ffff88811db42800
> > > > >   RDX: 1ffff11023b68502 RSI: ffffffffaf2e6a00 RDI: ffff88811db42810
> > > > >   RBP: ffff88811db45000 R08: 0000000000000001 R09: fffffbfff664bbc9
> > > > >   R10: ffffffffb325de4f R11: ffffffffb2d33748 R12: 0000000000000000
> > > > >   R13: ffff88811db43000 R14: ffff88811b4caaac R15: ffff8881252c0030
> > > > >   FS:  00007f6c1f126740(0000) GS:ffff88815aa00000(0000) knlGS:0000000000000000
> > > > >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > >   CR2: 000055dca8e5b4a8 CR3: 000000011bc7a006 CR4: 0000000000370ee0
> > > > >   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > >   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > >   Call Trace:
> > > > >   <TASK>
> > > > >    tc_ctl_tclass+0x394/0xeb0
> > > > >    rtnetlink_rcv_msg+0x2f5/0xaa0
> > > > >    netlink_rcv_skb+0x12e/0x3a0
> > > > >    netlink_unicast+0x421/0x730
> > > > >    netlink_sendmsg+0x79e/0xc60
> > > > >    ____sys_sendmsg+0x95a/0xc20
> > > > >    ___sys_sendmsg+0xee/0x170
> > > > >    __sys_sendmsg+0xc6/0x170
> > > > >   do_syscall_64+0x58/0x80
> > > > >   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > > > > 
> > > > > The first command creates per TX queue pfifo qdiscs in
> > > > > tc_modify_qdisc() -> htb_init() and grafts the pfifo to each dev_queue
> > > > > via tc_modify_qdisc() ->  qdisc_graft() -> htb_attach().
> > > > 
> > > > Not exactly; it grafts pfifo to direct queues only. htb_attach_offload
> > > > explicitly grafts noop to all the remaining queues.
> > > 
> > > num_direct_qdiscs == real_num_tx_queues:
> > > 
> > > https://elixir.bootlin.com/linux/latest/source/net/sched/sch_htb.c#L1101
> > > 
> > > pfifo will be configured on all the TX queues available at TC creation
> > > time, right?
> > 
> > Yes, all real TX queues will be used as direct queues (for unclassified
> > traffic). num_tx_queues should be somewhat bigger than
> > real_num_tx_queues - it should reserve a queue per potential leaf class.
> > 
> > pfifo is configured on direct queues, and the reserved queues have noop.
> > Then, when a new leaf class is added (TC_HTB_LEAF_ALLOC_QUEUE), the
> > driver allocates a new queue and increases real_num_tx_queues. HTB
> > assigns a pfifo qdisc to the newly allocated queue.
> > 
> > Changing the hierarchy (deleting a node or converting an inner node to a
> > leaf) may reorder the classful queues (with indexes >= the initial
> > real_num_tx_queues), so that there are no gaps.
> > 
> > > Lacking a mlx card with offload support I hack basic htb support in
> > > netdevsim and I observe the splat on top of such device. I can as well
> > > share the netdevsim patch - it will need some clean-up.
> > 
> > I will be happy to review the netdevsim patch, but I don't promise
> > prompt responsiveness.
> > 
> > > > 
> > > > > When the command completes, the qdisc_sleeping for each dev_queue is a
> > > > > pfifo one. The next class creation will trigger the reported splat.
> > > > > 
> > > > > Address the issue taking care of old non-builtin qdisc in
> > > > > htb_change_class().
> > > > > 
> > > > > Fixes: d03b195b5aa0 ("sch_htb: Hierarchical QoS hardware offload")
> > > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > > ---
> > > > >   net/sched/sch_htb.c | 3 +--
> > > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> > > > > index 0d947414e616..dc682bd542b4 100644
> > > > > --- a/net/sched/sch_htb.c
> > > > > +++ b/net/sched/sch_htb.c
> > > > > @@ -1955,8 +1955,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
> > > > >   				qdisc_refcount_inc(new_q);
> > > > >   			}
> > > > >   			old_q = htb_graft_helper(dev_queue, new_q);
> > > > > -			/* No qdisc_put needed. */
> > > > > -			WARN_ON(!(old_q->flags & TCQ_F_BUILTIN));
> > > > > +			qdisc_put(old_q);
> > > > 
> > > > We can get here after one of two cases above:
> > > > 
> > > > 1. A new queue is allocated with TC_HTB_LEAF_ALLOC_QUEUE. It's supposed
> > > > to have a noop qdisc by default (after htb_attach_offload).
> > > 
> > > So most likely the trivial netdevsim implementation I used was not good
> > > enough.
> > > 
> > > Which constrains should respect TC_HTB_LEAF_ALLOC_QUEUE WRT the
> > > returned qid value? should it in the (real_num_tx_queues,
> > > num_tx_queues] range?
> > 
> > Let's say N is real_num_tx_queues as it was at the moment of attaching.
> > HTB queues should be allocated from [N, num_tx_queues), and
> > real_num_tx_queues should be increased accordingly. It should not return
> > queues number [0, N).
> > 
> > Deletions should fill the gaps: if queue X is being deleted, N <= X <
> > real_num_tx_queues - 1, then the gap should be filled with queue number
> > real_num_tx_queues - 1 by swapping the queues (real_num_tx_queues will
> > be decreased by 1 accordingly). Some care also needs to be taken when
> > converting inner-to-leaf (TC_HTB_LEAF_DEL_LAST) and leaf-to-inner (it's
> > better to get insights from [1], there are also some comments).
> > 
> > > Can HTB actually configure H/W shaping on
> > > real_num_tx_queues?
> > 
> > It will be on real_num_tx_queues, but after it's increased to add new
> > HTB queues. The original queues [0, N) are used for direct traffic, same
> > as the non-offloaded HTB's direct_queue (it's not shaped).
> > 
> > > I find no clear documentation WRT the above.
> > 
> > I'm sorry for the lack of documentation. All I have is the commit
> > message [2] and a netdev talk [3]. Maybe the slides could be of some
> > use...
> > 
> > I hope the above explanation clarifies something, and feel free to ask
> > further questions, I'll be glad to explain what hasn't been documented
> > properly.
> 
> We would like to enable Tx rate limiting using htb offload on all the
> existing queues.

I don't seem to understand how you see it possible with HTB.

1. Where would the unclassified traffic go? HTB uses a set of filters
that steer certain traffic to certain classes. Everything that doesn't
match the filter goes to the direct queue, which doesn't have shaping.
In the non-offloaded HTB it's struct htb_sched::direct_queue. With HTB
offload it's mapped to the standard set of queues.

2. How do you see the mapping of HTB classes to netdev queues if you use
a fixed set of queues? In the current implementation of HTB offload,
each new HTB class creates a new queue. If you are bound to using only N
standard queues, how would the allocation work when you add the second,
third, etc. HTB classes?

> We are able to do with the following set of commands with
> Paolo's patch
> 
> tc qdisc add dev enp175s0v0 handle 1: root htb offload
> tc class add dev enp175s0v0 parent 1: classid 1:1 htb rate 1000mbit ceil
> 2000mbit burst 100k

As long as you don't attach any filters, this set of commands is not
supposed to shape anything. It should TX full-speed, you should be able
to see this effect if you configure non-offloaded HTB. As long as there
are no filters, and the default classid doesn't match your only class,
all traffic will go to the direct queue.

What is your goal? If you need shaping for the whole netdev, maybe HTB
is not needed, and it's enough to attach a catchall filter with the
police action? Or use /sys/class/net/eth0/queues/tx-*/tx_maxrate
per-queue? Or tc mqprio mode channel, that allows to group existing
queues and assign rate limits?

> where
>   classid 1:1 is tx queue0
>   tx_minrate is rate 1000mbps
>   tx_maxrate is ceil 2000mbps
> 
> 
> In order to not break your implementation could bring in if condition
> instead WARN_ON, something like below
> 	if (!(old_q->flags & TCQ_F_BUILTIN))
> 		qdisc_put(old_q);
> 
> Would this work for you, please advise.

One of the reasons this WARN is there to prevent misuse of the API (the
other is to catch bugs that lead to inconsistencies in the internal
state). We can't just remove the WARN and start misusing the API. Your
ideas require more major design changes, but before that I need to
understand your approach to solving (1) and (2).

